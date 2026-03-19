import 'dart:async';
import 'package:camera/camera.dart';
import 'hardware_test.dart';

class CameraTest extends HardwareTest {
  @override
  final String name = "Camera Test";

  final StreamController<TestStatus> _statusController = StreamController<TestStatus>.broadcast();
  TestStatus _currentStatus = TestStatus.idle;

  @override
  Stream<TestStatus> get statusStream => _statusController.stream;

  @override
  TestStatus get currentStatus => _currentStatus;

  CameraController? controller;
  List<CameraDescription>? cameras;

  void _updateStatus(TestStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  @override
  Future<TestResult> runTest() async {
    _updateStatus(TestStatus.testing);
    try {
      // Small delay to allow OS to recognize newly connected hardware
      await Future.delayed(const Duration(milliseconds: 500));
      
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        _updateStatus(TestStatus.failed);
        return TestResult(success: false, message: "No cameras found. Please ensure your camera is connected and permissions are granted.");
      }

      // Sort to prioritize external cameras
      cameras!.sort((a, b) {
        if (a.lensDirection == CameraLensDirection.external && b.lensDirection != CameraLensDirection.external) return -1;
        if (a.lensDirection != CameraLensDirection.external && b.lensDirection == CameraLensDirection.external) return 1;
        return 0;
      });

      String lastError = "";
      for (var camera in cameras!) {
        try {
          controller = CameraController(
            camera, 
            ResolutionPreset.medium,
            enableAudio: false, // We test mic separately
          );

          await controller!.initialize();

          if (controller!.value.isInitialized) {
            _updateStatus(TestStatus.passed);
            return TestResult(success: true, message: "Camera initialized successfully");
          }
        } catch (e) {
          lastError = e.toString();
          controller?.dispose();
          controller = null;
        }
      }

      _updateStatus(TestStatus.failed);
      return TestResult(success: false, message: "Camera failed to initialize. Last error: $lastError");
    } catch (e) {
      _updateStatus(TestStatus.failed);
      return TestResult(success: false, message: "Error: $e");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    _statusController.close();
  }
}
