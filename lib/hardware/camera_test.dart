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
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        _updateStatus(TestStatus.failed);
        return TestResult(success: false, message: "No cameras found");
      }

      controller = CameraController(cameras![0], ResolutionPreset.medium);
      await controller!.initialize();

      if (controller!.value.isInitialized) {
        _updateStatus(TestStatus.passed);
        return TestResult(success: true, message: "Camera initialized successfully");
      } else {
        _updateStatus(TestStatus.failed);
        return TestResult(success: false, message: "Camera failed to initialize");
      }
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
