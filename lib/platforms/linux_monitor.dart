import 'dart:io';
import '../core/system_monitor.dart';

class LinuxMonitor implements SystemMonitor {
  @override
  Future<int> getCpuUsage() async {
    final result = await Process.run('bash', ['-c', "top -bn1 | grep 'Cpu(s)'"]);
    return 20; // TODO: parse properly
  }

  @override
  Future<int> getRamUsage() async {
    final result = await Process.run('free', ['-m']);
    return 40;
  }

  @override
  Future<int> getDiskUsage() async {
    final result = await Process.run('df', ['-h']);
    return 50;
  }

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