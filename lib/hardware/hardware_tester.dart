import 'hardware_test.dart';

abstract class HardwareTester {
  HardwareTest get cameraTest;
  HardwareTest get microphoneTest;
  HardwareTest get speakerTest;
  
  List<HardwareTest> get allTests => [cameraTest, microphoneTest, speakerTest];
}
