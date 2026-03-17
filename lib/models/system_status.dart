class SystemStatus {
  final double cpuUsage;
  final double ramUsage;
  final double diskUsage;
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
  });

  bool get isHealthy {
    return cpuUsage < 80 &&
        ramUsage < 80 &&
        diskUsage < 90 &&
        isConnected;
  }
}
