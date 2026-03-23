import 'package:flutter/services.dart';

enum CameraType { internal, external, unknown }

class CameraInfo {
  final String id;
  final String name;
  final CameraType type;

  CameraInfo({required this.id, required this.name, required this.type});

  factory CameraInfo.fromMap(Map<dynamic, dynamic> map) {
    return CameraInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      type: _parseType(map['type'] as String),
    );
  }

  static CameraType _parseType(String type) {
    if (type == 'internal') return CameraType.internal;
    if (type == 'external') return CameraType.external;
    return CameraType.unknown;
  }
}

class CameraService {
  static const MethodChannel _channel = MethodChannel('com.example.hardware/camera');

  Future<List<CameraInfo>> getAvailableCameras() async {
    try {
      final List<dynamic>? cameras = await _channel.invokeMethod('getAvailableCameras');
      if (cameras == null) return [];
      return cameras.map((c) => CameraInfo.fromMap(c as Map)).toList();
    } on PlatformException catch (e) {
      print("Failed to get cameras: '${e.message}'.");
      return [];
    }
  }

  Future<int?> initializeCamera(String cameraId) async {
    try {
      return await _channel.invokeMethod<int>('initializeCamera', {'cameraId': cameraId});
    } on PlatformException catch (e) {
      print("Failed to initialize camera: '${e.message}'.");
      return null;
    }
  }

  Future<void> disposeCamera() async {
    try {
      await _channel.invokeMethod('disposeCamera');
    } on PlatformException catch (e) {
      print("Failed to dispose camera: '${e.message}'.");
    }
  }
}
