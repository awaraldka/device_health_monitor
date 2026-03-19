import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../core/system_monitor.dart';
import '../services/cpu_monitor.dart';

class MacMonitor implements SystemMonitor {


  final cpuMonitor = CpuMonitor();
  static const MethodChannel _channel = MethodChannel('gpu_info');


  @override
  Future<int> getCpuUsage() async {

    return await cpuMonitor.getCpuUsage();
  }

  @override
  Future<int> getRamUsage() async {
    try {
      final result = await Process.run(
          'bash', ['-c', "memory_pressure"]);

      final output = result.stdout.toString();

      final usedMatch =
      RegExp(r'System-wide memory free percentage:\s+(\d+)%')
          .firstMatch(output);

      if (usedMatch != null) {
        final freePercent = int.parse(usedMatch.group(1)!);
        return 100 - freePercent;
      }

      return 0;
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<int> getDiskUsage() async {
    try {
      final result = await Process.run('bash', ['-c', "df -h /"]);

      final lines = result.stdout.toString().split('\n');
      if (lines.length < 2) return 0;

      final parts = lines[1].split(RegExp(r'\s+'));
      if (parts.length < 5) return 0;
      return int.tryParse(parts[4].replaceAll('%', '')) ?? 0;
    } catch (_) {
      return 0;
    }
  }

  double _lastRx = 0;
  double _lastTx = 0;
  double _lastTime = 0;

  @override
  Future<Map<String, String>> getNetworkSpeed() async {
    try {
      final result = await Process.run('bash', ['-c', "netstat -ib"]);

      final output = result.stdout.toString();
      final lines = output.split('\n');

      double rx = 0;
      double tx = 0;

      for (var line in lines) {
        if (line.contains('en0')) {
          final parts = line.split(RegExp(r'\s+'));

          if (parts.length > 10) {
            rx += double.tryParse(parts[6]) ?? 0;
            tx += double.tryParse(parts[9]) ?? 0;
          }
        }
      }

      final now = DateTime.now().millisecondsSinceEpoch / 1000;

      if (_lastTime == 0) {
        _lastRx = rx;
        _lastTx = tx;
        _lastTime = now;
        return {"download": "0 Kbps", "upload": "0 Kbps"};
      }

      final timeDiff = now - _lastTime;
      if (timeDiff <= 0) {
        return {"download": "0 Kbps", "upload": "0 Kbps"};
      }

      final download = (rx - _lastRx) / timeDiff;
      final upload = (tx - _lastTx) / timeDiff;

      _lastRx = rx;
      _lastTx = tx;
      _lastTime = now;

      return {
        "download": _formatSpeed(download),
        "upload": _formatSpeed(upload),
      };
    } catch (_) {
      return {"download": "0 Kbps", "upload": "0 Kbps"};
    }
  }

  String _formatSpeed(double bytesPerSec) {
    double kb = bytesPerSec / 1024;
    double mb = kb / 1024;

    if (mb >= 1) {
      return "${mb.toStringAsFixed(1)} Mbps";
    } else {
      return "${kb.toStringAsFixed(1)} Kbps";
    }
  }

  @override
  Future<bool> isCameraAvailable() async => true;

  @override
  Future<bool> isMicAvailable() async => true;

  @override
  Future<bool> isSpeakerAvailable() async => true;

  @override
  Future<Map<String, dynamic>> getGeoLocation() async {
    try {
      final result = await Process.run(
        '/usr/bin/curl',
        ['-s', 'https://ipinfo.io/json'],
      );



      final output = result.stdout.toString().trim();

      if (output.isEmpty) {
        return await _fallbackGeoLocation();
      }

      final json = jsonDecode(output);

      final loc = (json['loc'] ?? "0,0").toString();
      final parts = loc.split(',');

      return {
        "city": (json['city'] ?? '-').toString(),
        "region": (json['region'] ?? '-').toString(),
        "country": (json['country'] ?? '-').toString(),
        "lat": parts.isNotEmpty ? parts[0] : "0",
        "lon": parts.length > 1 ? parts[1] : "0",
      };
    } catch (_) {
      return await _fallbackGeoLocation();
    }
  }

  Future<Map<String, dynamic>> _fallbackGeoLocation() async {
    try {
      final result = await Process.run(
        'bash',
        ['-c', "curl -s --max-time 3 http://ip-api.com/json"],
      );

      final output = result.stdout.toString().trim();

      if (output.isEmpty) return _defaultLocation();

      final json = jsonDecode(output);

      return {
        "city": (json['city'] ?? '-').toString(),
        "region": (json['regionName'] ?? '-').toString(),
        "country": (json['country'] ?? '-').toString(),
        "lat": (json['lat'] ?? 0).toString(),
        "lon": (json['lon'] ?? 0).toString(),
      };
    } catch (_) {
      return _defaultLocation();
    }
  }


  Map<String, dynamic> _defaultLocation() {
    return {
      "city": "-",
      "region": "-",
      "country": "-",
      "lat": "0",
      "lon": "0",
    };
  }

  @override
  Future<List<Map<String, dynamic>>> getAppUsage() async {
    try {
      final result = await Process.run('bash', ['-c', "ps -eo comm,lstart"]);

      final output = result.stdout.toString().trim();
      if (output.isEmpty) return [];

      final now = DateTime.now();
      final lines = output.split('\n');
      final Map<String, Map<String, dynamic>> appMap = {};

      for (var i = 1; i < lines.length; i++) {
        final parts = lines[i].trim().split(RegExp(r'\s+'));
        if (parts.length < 6) continue;

        final name = parts[0];
        final dateStr = "${parts[1]} ${parts[2]} ${parts[3]} ${parts[4]} ${parts[5]}";

        DateTime? startTime;
        try {
          startTime = DateTime.parse(_convertMacDate(dateStr));
        } catch (_) {
          continue;
        }

        final duration = now.difference(startTime);

        if (appMap.containsKey(name)) {
          final existing = appMap[name]!;
          final existingStart = DateTime.parse(existing["From"]["DateTime"]);

          if (startTime.isBefore(existingStart)) {
            existing["From"]["DateTime"] = startTime.toString();
          }

          final newDuration = now.difference(DateTime.parse(existing["From"]["DateTime"]));
          existing["Duration"] = {
            "Days": newDuration.inDays,
            "Hours": newDuration.inHours % 24,
            "Minutes": newDuration.inMinutes % 60,
          };
        } else {
          appMap[name] = {
            "Name": name,
            "From": {"DateTime": startTime.toString()},
            "Till": {"DateTime": now.toString()},
            "Duration": {
              "Days": duration.inDays,
              "Hours": duration.inHours % 24,
              "Minutes": duration.inMinutes % 60,
            }
          };
        }
      }

      final apps = appMap.values.toList();
      apps.sort((a, b) {
        final da = a['Duration']['Days'] * 86400 + a['Duration']['Hours'] * 3600 + a['Duration']['Minutes'] * 60;
        final db = b['Duration']['Days'] * 86400 + b['Duration']['Hours'] * 3600 + b['Duration']['Minutes'] * 60;
        return db.compareTo(da);
      });

      return apps.take(20).toList();
    } catch (_) {
      return [];
    }
  }

  String _convertMacDate(String input) {
    final parts = input.split(' ');
    if (parts.length < 5) return "1970-01-01 00:00:00";

    final monthMap = {
      "Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04", "May": "05", "Jun": "06",
      "Jul": "07", "Aug": "08", "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12",
    };

    final month = monthMap[parts[1]] ?? "01";
    final day = parts[2].padLeft(2, '0');
    return "${parts[4]}-$month-$day ${parts[3]}";
  }

  @override
  Future<String> getGpuName() async {
    try {
      final String name = await _channel.invokeMethod('getGpuName');
      return name;
    } catch (_) {
      return "Unknown";
    }
  }



}
