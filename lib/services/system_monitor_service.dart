import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_device_info_plus/flutter_device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/monitor_factory.dart';
import '../models/app_usage.dart';
import '../models/system_status.dart';
import '../screens/login_screen.dart';

class SystemMonitorService {
  final FlutterDeviceInfoPlus _deviceInfoPlugin = const FlutterDeviceInfoPlus();
  final Connectivity _connectivity = Connectivity();

  static final SystemMonitorService _instance =
      SystemMonitorService._internal();

  factory SystemMonitorService() => _instance;

  SystemMonitorService._internal();

  final monitor = MonitorFactory.create();

  final StreamController<SystemStatus> _controller =
      StreamController<SystemStatus>.broadcast();

  SystemStatus? _cachedStatus;

  SystemStatus? get cachedStatus => _cachedStatus;

  Timer? _timer;

  Stream<SystemStatus> getStatusStream() {
    _init();

    if (_cachedStatus != null) {
      Future.microtask(() {
        _controller.add(_cachedStatus!);
      });
    }

    return _controller.stream;
  }

  void _init() {
    if (_timer != null) return;

    _fetchAndEmit();

    _timer = Timer.periodic(const Duration(hours: 1), (_) {
      _fetchAndEmit();
    });
  }

  Future<void> refreshNow() async {
    await _fetchAndEmit();
  }

  Future<void> _fetchAndEmit() async {
    try {
      final status = await getSystemStatus();
      _cachedStatus = status;
      _controller.add(status);
    } catch (e) {
      debugPrint("Error in _fetchAndEmit: $e");
      if (_cachedStatus != null) {
        _controller.add(_cachedStatus!);
      }
    }
  }

  Future<SystemStatus> getSystemStatus() async {
    final info = await _deviceInfoPlugin.getDeviceInfo();


    final cpu = await monitor.getCpuUsage();
    final ram = await monitor.getRamUsage();
    final disk = await monitor.getDiskUsage();

    final networkSpeed = await monitor.getNetworkSpeed();

    final camera = await monitor.isCameraAvailable();
    final mic = await monitor.isMicAvailable();
    final speaker = await monitor.isSpeakerAvailable();

    final geo = await monitor.getGeoLocation();

    final appUsage = await monitor.getAppUsage();
    final gpuName =  await monitor.getGpuName();

    final apps = appUsage.map((e) => AppUsageData.fromMap(e)).toList();

    final connectivityResult = await _connectivity.checkConnectivity();
    bool isInternetConnected =
        !connectivityResult.contains(ConnectivityResult.none);

    return SystemStatus(
      cpuUsage: cpu,
      ramUsage: ram,
      diskUsage: disk,
      cpuName: info.processorInfo.processorName,
      gpuName: gpuName,
      downloadSpeed: networkSpeed.containsKey('download')
          ? double.tryParse(networkSpeed['download']!.split(' ')[0]) ?? 0
          : 0,
      uploadSpeed: networkSpeed.containsKey('upload')
          ? double.tryParse(networkSpeed['upload']!.split(' ')[0]) ?? 0
          : 0,
      isConnected: isInternetConnected,
      temperature: info.batteryInfo?.batteryTemperature ?? 0.0,
      osName: "${info.operatingSystem} ${info.systemVersion}",
      deviceName: Platform.localHostname,
      batteryLevel: info.batteryInfo?.batteryLevel != null ? "${info.batteryInfo?.batteryLevel}%" : "Not Available",
      batteryStatus: info.batteryInfo?.chargingStatus ?? "Not Available",
      additionalInfo: {
        'Computer Name': info.deviceName,
        'CPU Cores': info.processorInfo.coreCount.toString(),
        'Total RAM':
            "${(info.memoryInfo.totalPhysicalMemory / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB",
        'User Name': Platform.environment['USERNAME'] ??
            Platform.environment['USER'] ??
            'Unknown',
        'OS Build': info.systemVersion,
        'Build Number': info.buildNumber,
        'Kernel': info.kernelVersion,
        'Platform ID': Platform.operatingSystem,
        'Manufacturer': info.manufacturer,
        'Model': info.model,
      },
      locationInfo: {
        'Camera': camera ? 'Yes' : 'No',
        'Mic': mic ? 'Yes' : 'No',
        'Speaker': speaker ? 'Yes' : 'No',
        'City': geo['city'] ?? 'No Internet',
        'Region': geo['region'] ?? '-',
        'Country': geo['country'] ?? '-',
        'Latitude': geo['lat'] ?? '0',
        'Longitude': geo['lon'] ?? '0',
      },
      appData: apps,
    );
  }

  Future<void> clickLogout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
