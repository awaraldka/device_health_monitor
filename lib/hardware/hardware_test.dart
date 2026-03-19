import 'dart:async';

enum TestStatus { idle, testing, passed, failed }

class TestResult {
  final bool success;
  final String message;

  TestResult({required this.success, required this.message});
}

abstract class HardwareTest {
  String get name;
  Stream<TestStatus> get statusStream;
  TestStatus get currentStatus;
  
  Future<TestResult> runTest();
  void dispose();
}
