import '../camera_test.dart';
import '../hardware_test.dart';
import '../hardware_tester.dart';
import '../microphone_test.dart';
import '../speaker_test.dart';

class WindowsHardwareTester extends HardwareTester {
  @override
  final HardwareTest cameraTest = CameraTest();
  @override
  final HardwareTest microphoneTest = MicrophoneTest();
  @override
  final HardwareTest speakerTest = SpeakerTest();
}
