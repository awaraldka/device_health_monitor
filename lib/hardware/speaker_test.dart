import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'hardware_test.dart';

class SpeakerTest extends HardwareTest {
  @override
  final String name = "Speaker Test";

  final StreamController<TestStatus> _statusController = StreamController<TestStatus>.broadcast();
  TestStatus _currentStatus = TestStatus.idle;

  @override
  Stream<TestStatus> get statusStream => _statusController.stream;

  @override
  TestStatus get currentStatus => _currentStatus;

  final AudioPlayer _player = AudioPlayer();

  void _updateStatus(TestStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  @override
  Future<TestResult> runTest() async {
    _updateStatus(TestStatus.testing);
    try {
      // Set release mode to release the resources immediately after playing
      await _player.setReleaseMode(ReleaseMode.stop);
      
      // Load the source first
      final source = AssetSource('test_audio.mp3');
      
      // Play and catch the future to ensure it starts
      await _player.play(source);
      
      debugPrint("Audio playback started");
      
      // Wait for 3 seconds to let user hear the sound
      await Future.delayed(const Duration(seconds: 3));
      await _player.stop();

      _updateStatus(TestStatus.passed);
      return TestResult(success: true, message: "Audio played successfully");
    } catch (e) {
      debugPrint("Speaker Test Error: $e");
      _updateStatus(TestStatus.failed);
      return TestResult(success: false, message: "Error: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _statusController.close();
  }
}
