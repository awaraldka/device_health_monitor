import 'dart:convert';
import 'dart:io';
import '../core/system_monitor.dart';

class WindowsMonitor implements SystemMonitor {
  @override
  Future<int> getCpuUsage() async {
    final result = await Process.run('powershell', [
      '-Command',
      "(Get-Counter '\\Processor(_Total)\\% Processor Time').CounterSamples.CookedValue"
    ]);

    final output = result.stdout.toString();

    final match = RegExp(r'\d+(\.\d+)?').firstMatch(output);

    if (match != null) {
      final value = double.parse(match.group(0)!);
      int cpuUsage = value.roundToDouble().clamp(0, 100).toInt();
      return cpuUsage;

    }

    return 0;
  }

  @override
  Future<int> getRamUsage() async {
    final result = await Process.run('powershell', [
      '-Command',
      "(Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory,(Get-CimInstance Win32_OperatingSystem).TotalVisibleMemorySize"
    ]);

    final output = result.stdout.toString();

    final values = RegExp(r'\d+')
        .allMatches(output)
        .map((e) => int.parse(e.group(0)!))
        .toList();

    if (values.length >= 2) {
      final free = values[0];
      final total = values[1];
      return (((total - free) / total) * 100).toInt();
    }

    return 0;
  }

  @override
  Future<int> getDiskUsage() async {
    final result = await Process.run('powershell', [
      '-Command',
      "(Get-CimInstance Win32_LogicalDisk -Filter \"DeviceID='C:'\").Size, (Get-CimInstance Win32_LogicalDisk -Filter \"DeviceID='C:'\").FreeSpace"
    ]);

    final output = result.stdout.toString().trim().split('\n');

    if (output.length >= 2) {
      final size = double.parse(output[0].trim());
      final free = double.parse(output[1].trim());

      final used = size - free;
      final percent = ((used / size) * 100).round();

      return percent;
    }

    return 0;
  }

  double _lastReceived = 0;
  double _lastSent = 0;
  double _lastTime = 0;

  @override
  Future<Map<String, String>> getNetworkSpeed() async {
    const adapter = "Wi-Fi";

    try {
      final result = await Process.run('powershell', [
        '-Command',
        "Get-NetAdapterStatistics -Name \"$adapter\" | Select-Object ReceivedBytes,SentBytes"
      ]);

      final output = result.stdout.toString();

      final values = RegExp(r'\d+')
          .allMatches(output)
          .map((e) => double.parse(e.group(0)!))
          .toList();

      if (values.length < 2) {
        return {"download": "0 Kbps", "upload": "0 Kbps"};
      }

      final received = values[0];
      final sent = values[1];

      final now = DateTime.now().millisecondsSinceEpoch / 1000;


      if (_lastTime == 0) {
        _lastReceived = received;
        _lastSent = sent;
        _lastTime = now;
        return {"download": "0 Kbps", "upload": "0 Kbps"};
      }

      final timeDiff = now - _lastTime;

      // ✅ Prevent division by zero
      if (timeDiff <= 0) {
        return {"download": "0 Kbps", "upload": "0 Kbps"};
      }

      final downloadBytesPerSec = (received - _lastReceived) / timeDiff;
      final uploadBytesPerSec = (sent - _lastSent) / timeDiff;

      // ✅ Update last values
      _lastReceived = received;
      _lastSent = sent;
      _lastTime = now;



      return {
        "download": _formatSpeed(downloadBytesPerSec),
        "upload": _formatSpeed(uploadBytesPerSec),
      };
    } catch (e) {
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
  Future<bool> isCameraAvailable() async {
    final result = await Process.run('powershell', [
      '-Command',
      "Get-PnpDevice -Class Camera | Where-Object {\$_.Status -eq 'OK'}"
    ]);

    return result.stdout.toString().trim().isNotEmpty;
  }

  @override
  Future<bool> isMicAvailable() async {
    final result = await Process.run('powershell', [
      '-Command',
      "Get-PnpDevice -Class AudioEndpoint | Where-Object {\$_.FriendlyName -like '*Microphone*'}"
    ]);

    return result.stdout.toString().trim().isNotEmpty;
  }


  @override
  Future<bool> isSpeakerAvailable() async {
    final result = await Process.run('powershell', [
      '-Command',
      "Get-PnpDevice -Class AudioEndpoint | Where-Object {\$_.FriendlyName -like '*Speaker*'}"
    ]);

    return result.stdout.toString().trim().isNotEmpty;
  }

  @override
  @override
  Future<Map<String, dynamic>> getGeoLocation() async {
    try {
      final result = await Process.run('powershell', [
        '-Command',
        "(Invoke-RestMethod ipinfo.io/json) | ConvertTo-Json"
      ]);

      if (result.stdout == null || result.stdout.toString().trim().isEmpty) {
        return _defaultLocation();
      }

      final json = jsonDecode(result.stdout);

      final loc = json['loc'] ?? "0,0";
      final parts = loc.split(',');

      return {
        "city": json['city'] ?? 'Unknown',
        "region": json['region'] ?? 'Unknown',
        "country": json['country'] ?? 'Unknown',
        "lat": parts[0],
        "lon": parts[1],
      };
    } catch (e) {
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
  @override
  Future<List<Map<String, dynamic>>> getAppUsage() async {
    try {
      final result = await Process.run('powershell', [
        '-Command',
        '''
      Get-Process | Where-Object {\$_.MainWindowTitle} |
      Select-Object Name,
      @{Name="From"; Expression={\$_.StartTime}},
      @{Name="Till"; Expression={Get-Date}},
      @{Name="Duration"; Expression={(Get-Date) - \$_.StartTime}} |
      Sort-Object Duration -Descending |
      ConvertTo-Json
      '''
      ]);

      final output = result.stdout.toString().trim();
      if (output.isEmpty) return [];

      final decoded = jsonDecode(output);

      return decoded is List
          ? List<Map<String, dynamic>>.from(decoded)
          : [Map<String, dynamic>.from(decoded)];
    } catch (_) {
      return [];
    }
  }

}