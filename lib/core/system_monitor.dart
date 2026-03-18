
abstract class SystemMonitor {
  Future<int> getCpuUsage();
  Future<int> getRamUsage();
  Future<int> getDiskUsage();
  Future<Map<String, String>> getNetworkSpeed();
  Future<bool> isCameraAvailable();
  Future<bool> isMicAvailable();
  Future<bool> isSpeakerAvailable();
  Future<Map<String, dynamic>>  getGeoLocation();


}