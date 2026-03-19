import 'dart:io';
import 'hardware_tester.dart';
import 'impl/windows_hardware_tester.dart';
import 'impl/mac_hardware_tester.dart';
import 'impl/linux_hardware_tester.dart';

class HardwareTesterFactory {
  static HardwareTester create() {
    if (Platform.isWindows) {
      return WindowsHardwareTester();
    } else if (Platform.isMacOS) {
      return MacHardwareTester();
    } else if (Platform.isLinux) {
      return LinuxHardwareTester();
    }
    throw UnsupportedError('Platform not supported');
  }
}
