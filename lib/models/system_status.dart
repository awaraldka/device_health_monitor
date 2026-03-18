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
  final int batteryLevel;
  final String batteryStatus;

  // Additional Information
  final Map<String, String> additionalInfo;
  final Map<String, String> locationInfo;

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
  });

  bool get isHealthy {
    return cpuUsage < 80 &&
        ramUsage < 80 &&
        diskUsage < 90 &&
        isConnected;
  }
}
