import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_device_info_plus/flutter_device_info_plus.dart';

import '../models/system_status.dart';

class SystemMonitorService {
  final Connectivity _connectivity = Connectivity();
  final Random _random = Random();
  final FlutterDeviceInfoPlus _deviceInfoPlugin = const FlutterDeviceInfoPlus();

  Future<SystemStatus> getSystemStatus() async {
    String osName = Platform.operatingSystem;
    String deviceName = "Desktop Device";
    double ramUsage = 0.0;
    double diskUsage = 0.0;
    double temperature = 0.0;

    try {
      final info = await _deviceInfoPlugin.getDeviceInfo();
      deviceName = info.deviceName;
      osName = "${info.operatingSystem} ${info.systemVersion}";
      
      // Attempt to get real memory info from the plugin
      ramUsage = info.memoryInfo.memoryUsagePercentage;
      
      // Attempt to get real disk usage
      if (info.memoryInfo.totalStorageSpace > 0) {
        diskUsage = (info.memoryInfo.usedStorageSpace / info.memoryInfo.totalStorageSpace) * 100;
      }

      // Attempt to get real temperature
      if (info.batteryInfo != null) {
        temperature = info.batteryInfo!.batteryTemperature;
      }
    } catch (e) {
      deviceName = "Generic ${Platform.operatingSystem}";
    }

    // Default to simulation if values are not captured correctly or are 0
    if (ramUsage <= 0) ramUsage = 20 + _random.nextDouble() * 40;
    if (diskUsage <= 0) diskUsage = 60.0;
    if (temperature <= 0) temperature = 38 + _random.nextDouble() * 18;

    final connectivityResult = await _connectivity.checkConnectivity();
    bool isConnected = !connectivityResult.contains(ConnectivityResult.none);

    return SystemStatus(
      cpuUsage: 10 + _random.nextDouble() * 50, // CPU usage still simulated as it requires a delta over time
      ramUsage: ramUsage,
      diskUsage: diskUsage,
      gpuInfo: "Integrated Graphics",
      downloadSpeed: isConnected ? 30 + _random.nextDouble() * 40 : 0.0,
      uploadSpeed: isConnected ? 5 + _random.nextDouble() * 15 : 0.0,
      isConnected: isConnected,
      temperature: temperature,
      osName: osName,
      deviceName: deviceName,
    );
  }

  Stream<SystemStatus> getStatusStream() async* {
    while (true) {
      yield await getSystemStatus();
      await Future.delayed(const Duration(seconds: 3));
    }
  }
}
