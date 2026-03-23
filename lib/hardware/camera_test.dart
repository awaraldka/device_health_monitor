import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'hardware_test.dart';

class CameraTest extends HardwareTest {
  @override
  final String name = "Camera Test";

  final StreamController<TestStatus> _statusController =
  StreamController<TestStatus>.broadcast();

  TestStatus _currentStatus = TestStatus.idle;

  @override
  Stream<TestStatus> get statusStream => _statusController.stream;

  @override
  TestStatus get currentStatus => _currentStatus;

  void _updateStatus(TestStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  @override
  Future<TestResult> runTest() async {
    _updateStatus(TestStatus.testing);

    try {
      await Future.delayed(const Duration(milliseconds: 300));

      /// ✅ Get devices using WebRTC
      final devices = await navigator.mediaDevices.enumerateDevices();
      final cameras =
      devices.where((d) => d.kind == 'videoinput').toList();

      if (cameras.isEmpty) {
        _updateStatus(TestStatus.failed);
        return TestResult(
          success: false,
          message: "No cameras found",
        );
      }

      /// 🔥 Try opening camera (REAL validation)
      final stream = await navigator.mediaDevices.getUserMedia({
        'audio': false,
        'video': true,
      });

      // Stop immediately (we just test)
      stream.getTracks().forEach((t) => t.stop());

      _updateStatus(TestStatus.passed);

      return TestResult(
        success: true,
        message: "Camera working: ${cameras.first.label}",
      );
    } catch (e) {
      _updateStatus(TestStatus.failed);

      return TestResult(
        success: false,
        message: "Camera error: $e",
      );
    }
  }

  @override
  void dispose() {
    _statusController.close();
  }
}