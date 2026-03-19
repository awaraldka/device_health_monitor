import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../hardware/camera_test.dart';
import '../hardware/hardware_tester.dart';
import '../hardware/hardware_tester_factory.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final HardwareTester _hardwareTester = HardwareTesterFactory.create();

  bool _isObscure = true;
  String? _errorMessage;
  bool _isChecking = false;
  String _currentCheck = '';
  
  CameraTest? _activeCameraTest;

  Future<void> _login() async {
    setState(() {
      _errorMessage = null;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password';
      });
      return;
    }

    if (email == 'hestabit@gmail.com' && password == 'Hestabit') {
      setState(() {
        _isChecking = true;
      });

      try {
        final prefs = await SharedPreferences.getInstance();
        final bool isHardwareVerified = prefs.getBool('isHardwareVerified') ?? false;

        if (!isHardwareVerified) {
          // 1. Camera Test
        setState(() {
          _currentCheck = 'Initializing Camera...';
          _activeCameraTest = _hardwareTester.cameraTest as CameraTest;
        });
        
        final camResult = await _activeCameraTest!.runTest();
        final bool camStatus = camResult.success;
        
        // If camera check fails (e.g. no camera found), we mark it but CONTINUE to next tests
        if (!camStatus) {
          debugPrint('Camera health check failed: ${camResult.message}');
          // You could optionally set a flag here to show the user that camera is unhealthy
        } else {
          setState(() {
            _currentCheck = 'Camera Active (Verification)';
          });
          // Give 3 seconds for the user to see the preview
          await Future.delayed(const Duration(seconds: 3));
        }

        // 2. Microphone Test
        setState(() {
          _currentCheck = 'Checking Microphone (Recording 3s)...';
          _activeCameraTest = null; // Close camera preview to focus on mic
        });
        final micResult = await _hardwareTester.microphoneTest.runTest();
        final bool micStatus = micResult.success;
        if (!micStatus) {
          debugPrint('Microphone health check failed: ${micResult.message}');
        } else {
          setState(() => _currentCheck = 'Microphone Verified');
          await Future.delayed(const Duration(seconds: 1));
        }

        // 3. Speaker Test
        setState(() => _currentCheck = 'Checking Speakers (Playing audio)...');
        final spkResult = await _hardwareTester.speakerTest.runTest();
        final bool spkStatus = spkResult.success;
        if (!spkStatus) {
          debugPrint('Speaker health check failed: ${spkResult.message}');
        } else {
          setState(() => _currentCheck = 'Hardware Verified. Logging in...');
          await Future.delayed(const Duration(seconds: 1));
        }

          // Finalize checks
          await prefs.setBool('cameraStatus', camStatus);
          await prefs.setBool('micStatus', micStatus);
          await prefs.setBool('speakerStatus', spkStatus);
          await prefs.setBool('isHardwareVerified', true);
        } else {
          setState(() {
            _currentCheck = 'Hardware already verified. Logging in...';
          });
          await Future.delayed(const Duration(seconds: 3));
        }

        // Finalize Login
        await prefs.setBool('isLoggedIn', true);

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } catch (e) {
        setState(() {
          _isChecking = false;
          _activeCameraTest = null;
          _errorMessage = 'Health check failed: $e';
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password';
      });
    }
  }

  @override
  void dispose() {
    _hardwareTester.cameraTest.dispose();
    _hardwareTester.microphoneTest.dispose();
    _hardwareTester.speakerTest.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF303F9F)),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(maxWidth: _isChecking ? 500 : 450),
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: _isChecking ? _buildCheckProgress() : _buildLoginForm(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckProgress() {
    bool hasCamera = _activeCameraTest?.controller?.value.isInitialized ?? false;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasCamera)
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF3F51B5), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CameraPreview(_activeCameraTest!.controller!),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(),
          ),
        const Text(
          'Hardware Health Check',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5)),
        ),
        const SizedBox(height: 12),
        Text(
          _currentCheck,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.lock_person_rounded, size: 64, color: Color(0xFF3F51B5)),
        const SizedBox(height: 12),
        const Text(
          'System Login',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5)),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF3F51B5)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: _isObscure,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF3F51B5)),
            suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _isObscure = !_isObscure),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 13)),
        ],
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F51B5),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('LOGIN', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
