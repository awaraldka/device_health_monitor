import 'dart:convert';
import 'dart:io';
import '../core/system_monitor.dart';

class LinuxMonitor implements SystemMonitor {

  /// ✅ CPU Usage
  @override
  Future<int> getCpuUsage() async {
    try {
      final result = await Process.run('bash', [
        '-c',
        "top -bn1 | grep 'Cpu(s)'"
      ]);

      final output = result.stdout.toString();

      final match = RegExp(r'(\d+\.\d+)\s*id').firstMatch(output);

      if (match != null) {
        final idle = double.parse(match.group(1)!);
        return (100 - idle).round().clamp(0, 100);
      }

      return 0;
    } catch (_) {
      return 0;
    }
  }

  /// ✅ RAM Usage
  @override
  Future<int> getRamUsage() async {
    try {
      final result = await Process.run('bash', ['-c', "free -m"]);

      final lines = result.stdout.toString().split('\n');
      final memLine = lines.firstWhere((e) => e.contains('Mem'));

      final parts = memLine.split(RegExp(r'\s+'));

      final total = int.parse(parts[1]);
      final used = int.parse(parts[2]);

      return ((used / total) * 100).round();
    } catch (_) {
      return 0;
    }
  }

  /// ✅ Disk Usage
  @override
  Future<int> getDiskUsage() async {
    try {
      final result = await Process.run('bash', ['-c', "df -h /"]);

      final lines = result.stdout.toString().split('\n');

      if (lines.length < 2) return 0;

      final parts = lines[1].split(RegExp(r'\s+'));
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
      final result = await Process.run('bash', [
        '-c',
        "cat /proc/net/dev"
      ]);

      final output = result.stdout.toString();

      final lines = output.split('\n');

      double rx = 0;
      double tx = 0;

      for (var line in lines) {
        if (line.contains('eth0') || line.contains('wlan0')) {
          final parts = line.split(RegExp(r'\s+'));

          rx += double.tryParse(parts[1]) ?? 0;
          tx += double.tryParse(parts[9]) ?? 0;
        }
      }

      final now = DateTime.now().millisecondsSinceEpoch / 1000;

      if (_lastTime == 0) {
        _lastRx = rx;
        _lastTx = tx;
        _lastTime = now;

        return {
          "download": "0 Kbps",
          "upload": "0 Kbps",
        };
      }

      final timeDiff = now - _lastTime;

      if (timeDiff <= 0) {
        return {
          "download": "0 Kbps",
          "upload": "0 Kbps",
        };
      }

      final downloadBytesPerSec = (rx - _lastRx) / timeDiff;
      final uploadBytesPerSec = (tx - _lastTx) / timeDiff;

      _lastRx = rx;
      _lastTx = tx;
      _lastTime = now;

      return {
        "download": _formatSpeed(downloadBytesPerSec),
        "upload": _formatSpeed(uploadBytesPerSec),
      };

    } catch (e) {
      return {
        "download": "0 Kbps",
        "upload": "0 Kbps",
      };
    }
  }

  /// ✅ Camera
  @override
  Future<bool> isCameraAvailable() async {
    try {
      final result = await Process.run('bash', ['-c', "ls /dev/video*"]);
      return result.stdout.toString().trim().isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// ✅ Mic
  @override
  Future<bool> isMicAvailable() async {
    try {
      final result = await Process.run('bash', ['-c', "arecord -l"]);
      return result.stdout.toString().contains('card');
    } catch (_) {
      return false;
    }
  }

  /// ✅ Speaker
  @override
  Future<bool> isSpeakerAvailable() async {
    try {
      final result = await Process.run('bash', ['-c', "aplay -l"]);
      return result.stdout.toString().contains('card');
    } catch (_) {
      return false;
    }
  }

  /// ✅ Geo Location
  @override
  Future<Map<String, dynamic>> getGeoLocation() async {
    try {
      final result = await Process.run('bash', [
        '-c',
        "curl -s ipinfo.io/json"
      ]);

      if (result.stdout.toString().isEmpty) {
        return _defaultLocation();
      }

      final json = jsonDecode(result.stdout);

      final loc = json['loc'] ?? "0,0";
      final parts = loc.split(',');

      return {
        "city": json['city'] ?? '-',
        "region": json['region'] ?? '-',
        "country": json['country'] ?? '-',
        "lat": parts[0],
        "lon": parts[1],
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
      final result = await Process.run('bash', [
        '-c',
        "ps -eo comm,lstart --no-headers"
      ]);

      final output = result.stdout.toString().trim();
      if (output.isEmpty) return [];

      final now = DateTime.now();
      final lines = output.split('\n');

      final Map<String, Map<String, dynamic>> appMap = {};

      for (var line in lines) {
        final parts = line.trim().split(RegExp(r'\s+'));
        if (parts.length < 6) continue;

        final name = parts[0];

        /// 🔥 Filter unwanted system processes (optional)
        if (name.contains("system") ||
            name.contains("dbus") ||
            name.contains("bash")) continue;

        final dateStr =
            "${parts[1]} ${parts[2]} ${parts[3]} ${parts[4]} ${parts[5]}";

        DateTime? startTime;

        try {
          startTime = DateTime.parse(_convertLinuxDate(dateStr));
        } catch (_) {
          continue;
        }

        final duration = now.difference(startTime);

        if (appMap.containsKey(name)) {
          final existing = appMap[name]!;

          final existingStart =
          DateTime.parse(existing["From"]["DateTime"]);

          /// Keep earliest start
          if (startTime.isBefore(existingStart)) {
            existing["From"]["DateTime"] = startTime.toString();
          }

          final newDuration = now.difference(
              DateTime.parse(existing["From"]["DateTime"]));

          existing["Duration"] = {
            "Days": newDuration.inDays,
            "Hours": newDuration.inHours % 24,
            "Minutes": newDuration.inMinutes % 60,
            "Seconds": newDuration.inSeconds % 60,
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
              "Seconds": duration.inSeconds % 60,
            }
          };
        }
      }

      final apps = appMap.values.toList();

      /// Sort longest running first
      apps.sort((a, b) {
        final da = a['Duration']['Days'] * 86400 +
            a['Duration']['Hours'] * 3600 +
            a['Duration']['Minutes'] * 60;

        final db = b['Duration']['Days'] * 86400 +
            b['Duration']['Hours'] * 3600 +
            b['Duration']['Minutes'] * 60;

        return db.compareTo(da);
      });

      return apps.take(20).toList();
    } catch (_) {
      return [];
    }
  }

  /// ✅ Date converter
  String _convertLinuxDate(String input) {
    final parts = input.split(' ');

    final monthMap = {
      "Jan": "01",
      "Feb": "02",
      "Mar": "03",
      "Apr": "04",
      "May": "05",
      "Jun": "06",
      "Jul": "07",
      "Aug": "08",
      "Sep": "09",
      "Oct": "10",
      "Nov": "11",
      "Dec": "12",
    };

    final month = monthMap[parts[1]] ?? "01";

    return "${parts[4]}-$month-${parts[2]} ${parts[3]}";
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
}