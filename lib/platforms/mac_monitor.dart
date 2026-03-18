import '../core/system_monitor.dart';

class MacMonitor implements SystemMonitor {
  @override
  Future<int> getCpuUsage() async => 20;

  @override
  Future<int> getRamUsage() async => 40;

  @override
  Future<int> getDiskUsage() async => 50;

  @override
  Future<Map<String, String>> getNetworkSpeed() {
    // TODO: implement getNetworkSpeed
    throw UnimplementedError();
  }

  @override
  Future<bool> isCameraAvailable() {
    // TODO: implement isCameraAvailable
    throw UnimplementedError();
  }

  @override
  Future<bool> isMicAvailable() {
    // TODO: implement isMicAvailable
    throw UnimplementedError();
  }

  @override
  Future<bool> isSpeakerAvailable() {
    // TODO: implement isSpeakerAvailable
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getGeoLocation() {
    // TODO: implement getGeoLocation
    throw UnimplementedError();
  }
}