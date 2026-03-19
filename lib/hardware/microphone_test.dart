import 'dart:async';
import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'hardware_test.dart';

class MicrophoneTest extends HardwareTest {
  @override
  final String name = "Microphone Test";

  final StreamController<TestStatus> _statusController = StreamController<TestStatus>.broadcast();
  TestStatus _currentStatus = TestStatus.idle;

  @override
  Stream<TestStatus> get statusStream => _statusController.stream;

  @override
  TestStatus get currentStatus => _currentStatus;

  final Record _recorder = Record();

  void _updateStatus(TestStatus status) {
    _currentStatus = status;
    _statusController.add(status);
  }

  @override
  Future<TestResult> runTest() async {
    _updateStatus(TestStatus.testing);
    try {
      if (!await _recorder.hasPermission()) {
        _updateStatus(TestStatus.failed);
        return TestResult(success: false, message: "Microphone permission denied");
      }

      final Directory tempDir = await getTemporaryDirectory();
      final String path = p.join(tempDir.path, 'test_audio.m4a');

      // Simple recording for 3 seconds
      await _recorder.start(path: path);
      await Future.delayed(const Duration(seconds: 3));
      final String? resultPath = await _recorder.stop();

      if (resultPath != null && await File(resultPath).exists()) {
        _updateStatus(TestStatus.passed);
        return TestResult(success: true, message: "Audio recorded successfully");
      } else {
        _updateStatus(TestStatus.failed);
        return TestResult(success: false, message: "Failed to record audio");
      }
    } catch (e) {
      _updateStatus(TestStatus.failed);
      return TestResult(success: false, message: "Error: $e");
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _statusController.close();
  }
}
