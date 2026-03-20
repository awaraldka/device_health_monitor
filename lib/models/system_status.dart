
import 'app_usage.dart';

class SystemStatus {
  final int cpuUsage;
  final int ramUsage;
  final int diskUsage;
  final String cpuName;
  final String gpuName;
  final double downloadSpeed;
  final double uploadSpeed;
  final bool isConnected;
  final double temperature;
  final String osName;
  final String deviceName;
  final String batteryLevel;
  final String batteryStatus;

  // Additional Information
  final Map<String, String> additionalInfo;
  final Map<String, String> locationInfo;
  final List<AppUsageData> appData;

  SystemStatus({
    required this.cpuUsage,
    required this.ramUsage,
    required this.diskUsage,
    required this.cpuName,
    required this.gpuName,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.isConnected,
    required this.temperature,
    required this.osName,
    required this.deviceName,
    required this.batteryLevel,
    required this.batteryStatus,
    required this.additionalInfo,
    required this.locationInfo,
    required this.appData,
  });

  bool get isHealthy {
    return cpuUsage < 80 &&
        ramUsage < 80 &&
        diskUsage < 90 &&
        isConnected;
  }

  SystemStatus copyWith({
    int? cpuUsage,
    int? ramUsage,
    int? diskUsage,
    String? cpuName,
    String? gpuName,
    double? downloadSpeed,
    double? uploadSpeed,
    bool? isConnected,
    double? temperature,
    String? osName,
    String? deviceName,
    String? batteryLevel,
    String? batteryStatus,
    Map<String, String>? additionalInfo,
    Map<String, String>? locationInfo,
    List<AppUsageData>? appData,
  }) {
    return SystemStatus(
      cpuUsage: cpuUsage ?? this.cpuUsage,
      ramUsage: ramUsage ?? this.ramUsage,
      diskUsage: diskUsage ?? this.diskUsage,
      cpuName: cpuName ?? this.cpuName,
      gpuName: gpuName ?? this.gpuName,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      isConnected: isConnected ?? this.isConnected,
      temperature: temperature ?? this.temperature,
      osName: osName ?? this.osName,
      deviceName: deviceName ?? this.deviceName,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      batteryStatus: batteryStatus ?? this.batteryStatus,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      locationInfo: locationInfo ?? this.locationInfo,
      appData: appData ?? this.appData,
    );
  }
}
