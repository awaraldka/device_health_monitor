import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

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

  @override
  Future<Map<String, dynamic>> getGeoLocation() async {
    try {
      final result = await Process.run(
        '/usr/bin/curl',
        ['-s', 'https://ipinfo.io/json'],
      );

      final response = await http.get(Uri.parse('https://ipinfo.io/json'));


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
    final now = DateTime.now();
    final Map<String, Map<String, dynamic>> appMap = {};

    try {
      // Run ps for user processes
      final result = await Process.run('bash', [
        '-c',
        "ps -u \$USER -o pid,comm,etimes,cputime --sort=-cputime"
      ]);

      final output = result.stdout.toString().trim();
      if (output.isEmpty) return [];

      final lines = output.split('\n');

      // Skip header
      for (var i = 1; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;

        final parts = line.split(RegExp(r'\s+'));
        if (parts.length < 4) continue;

        final pid = parts[0];
        final comm = parts[1]; // app name
        final etimes = int.tryParse(parts[2]) ?? 0; // elapsed seconds
        final cpuTime = parts[3]; // CPU time string

        // Filter system/background processes
        if (_isSystemProcess(comm)) continue;

        final fromTime = now.subtract(Duration(seconds: etimes));
        final duration = Duration(seconds: etimes);

        appMap[comm] = {
          "Name": comm,
          "PID": pid,
          "From": {"DateTime": fromTime.toString()},
          "Till": {"DateTime": now.toString()},
          "Duration": {
            "Days": duration.inDays,
            "Hours": duration.inHours % 24,
            "Minutes": duration.inMinutes % 60,
            "Seconds": duration.inSeconds % 60,
          },
          "CPUTime": cpuTime,
        };
      }

      return appMap.values.toList();
    } catch (e) {
      return [];
    }
  }

  /// Filter system / background processes
  bool _isSystemProcess(String name) {
    final blacklist = [
      'kworker', 'rcu', 'migration', 'systemd', 'dbus', 'snapd',
      'bash', 'sh', 'ps', 'dart', 'init', 'login', 'agetty',
      'cron', 'rsyslog', 'NetworkManager', 'udisks', 'gvfs',
      'ibus', 'gsd-', 'pipewire', 'wireplumber', 'Xwayland',
      'mutter', 'xdg-', 'evolution', 'cat', 'goa-', 'sd-pam', 'gdm-',
      'gnome-', 'at-','dconf-','ubuntu-', 'update-', 'tracker-','gjs'
    ];

    for (var item in blacklist) {
      if (name.contains(item)) return true;
    }
    return false;
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