class SystemStatus {
  final double cpuUsage;
  final double ramUsage;
  final double diskUsage;
  final String gpuInfo;
  final double downloadSpeed;
  final double uploadSpeed;
  final bool isConnected;
  final double temperature;
  final String osName;
  final String deviceName;

  SystemStatus({
    required this.cpuUsage,
    required this.ramUsage,
    required this.diskUsage,
    required this.gpuInfo,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.isConnected,
    required this.temperature,
    required this.osName,
    required this.deviceName,
  });

  bool get isHealthy {
    return cpuUsage < 80 &&
        ramUsage < 80 &&
        diskUsage < 90 &&
        isConnected;
  }
}
