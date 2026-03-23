import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_health_monitor/services/speed_test_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_info_plus/flutter_device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/monitor_factory.dart';
import '../models/app_usage.dart';
import '../models/system_status.dart';
import '../screens/login_screen.dart';

class SystemMonitorService {
  final FlutterDeviceInfoPlus _deviceInfoPlugin = const FlutterDeviceInfoPlus();
  final Connectivity _connectivity = Connectivity();

  final speedTest = SpeedTestService();

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

  bool _isSpeedTestRunning = false;

  final List<int> _cpuUsageHistory = List.generate(30, (_) => 0);

  void _runSpeedTestsSequentially() async {
    if (_isSpeedTestRunning) return;
    _isSpeedTestRunning = true;
    try {
      await for (final speed in speedTest.measureDownloadSpeed()) {
        if (_cachedStatus != null) {
          _cachedStatus = _cachedStatus!.copyWith(downloadSpeed: double.parse(speed.toStringAsFixed(2)));
          _controller.add(_cachedStatus!);
        }
      }
      await for (final speed in speedTest.measureUploadSpeed()) {
        if (_cachedStatus != null) {
          _cachedStatus = _cachedStatus!.copyWith(uploadSpeed: double.parse(speed.toStringAsFixed(2)));
          _controller.add(_cachedStatus!);
        }
      }
    } finally {
      _isSpeedTestRunning = false;
    }
  }

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

    // ✅ Fix: Changed from 1 hour to 3 seconds for real-time history and dashboard updates
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
      _runSpeedTestsSequentially();
    } catch (e) {
      debugPrint("Error in _fetchAndEmit: $e");
      if (_cachedStatus != null) {
        _controller.add(_cachedStatus!);
      }
    }
  }

  Future<SystemStatus> getSystemStatus() async {
    final info = await _deviceInfoPlugin.getDeviceInfo();

    // Parallelize monitoring tasks for faster dashboard loading
    final results = await Future.wait([
      monitor.getCpuUsage(),
      monitor.getRamUsage(),
      monitor.getDiskUsage(),
      monitor.getNetworkSpeed(),
      monitor.isCameraAvailable(),
      monitor.isMicAvailable(),
      monitor.isSpeakerAvailable(),
      monitor.getGeoLocation(),
      monitor.getAppUsage(),
      monitor.getGpuName(),
      _connectivity.checkConnectivity(),
    ]);

    final int cpu = results[0] as int;
    
    // ✅ Update CPU history
    _cpuUsageHistory.add(cpu);
    if (_cpuUsageHistory.length > 30) {
      _cpuUsageHistory.removeAt(0);
    }

    final int ram = results[1] as int;
    final int disk = results[2] as int;
    final Map<String, String> networkSpeed = results[3] as Map<String, String>;
    final bool camera = results[4] as bool;
    final bool mic = results[5] as bool;
    final bool speaker = results[6] as bool;
    final Map<String, dynamic> geo = results[7] as Map<String, dynamic>;
    final List<Map<String, dynamic>> appUsage = results[8] as List<Map<String, dynamic>>;
    final String gpuName = results[9] as String;
    final List<ConnectivityResult> connectivityResult = results[10] as List<ConnectivityResult>;

    final apps = appUsage.map((e) => AppUsageData.fromMap(e)).toList();
    bool isInternetConnected = !connectivityResult.contains(ConnectivityResult.none);

    return SystemStatus(
      cpuUsage: cpu,
      cpuUsageHistory: List.from(_cpuUsageHistory),
      ramUsage: ram,
      diskUsage: disk,
      cpuName: info.processorInfo.processorName,
      gpuName: gpuName,
      downloadSpeed: _cachedStatus?.downloadSpeed ?? 0,
      uploadSpeed:  _cachedStatus?.uploadSpeed ?? 0,
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
    await prefs.setBool('isHardwareVerified', false);

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
