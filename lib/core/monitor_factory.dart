import 'dart:io';

import '../platforms/linux_monitor.dart';
import '../platforms/mac_monitor.dart';
import '../platforms/windows_monitor.dart';
import 'system_monitor.dart';

class MonitorFactory {
  static SystemMonitor create() {
    if (Platform.isWindows) return WindowsMonitor();
    if (Platform.isLinux) return LinuxMonitor();
    if (Platform.isMacOS) return MacMonitor();

    throw UnsupportedError("Unsupported platform");
  }
}