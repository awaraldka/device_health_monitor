import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

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
      final String filePath = p.join(tempDir.path, 'test_audio.m4a');
      
      // On macOS, the record package sometimes requires a file:// URL format
      // to avoid 'NSInvalidArgumentException ... is not a file URL'
      final String recordPath = Platform.isMacOS ? 'file://$filePath' : filePath;

      print("Start recording to: $recordPath");
      await _recorder.start(path: recordPath);
      await Future.delayed(const Duration(seconds: 3));
      final String? resultPath = await _recorder.stop();

      // When checking for file existence, use the raw file path (without file://)
      if (resultPath != null && await File(filePath).exists()) {
        _updateStatus(TestStatus.passed);
        return TestResult(success: true, message: "Audio recorded successfully");
      } else {
        _updateStatus(TestStatus.failed);
        return TestResult(success: false, message: "Failed to record audio");
      }
    } catch (e) {
      print("Microphone Test Error: $e");
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
