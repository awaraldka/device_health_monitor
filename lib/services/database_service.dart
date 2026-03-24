import 'package:device_health_monitor/db/app_database.dart';
import 'package:device_health_monitor/models/system_status.dart';
import 'package:drift/drift.dart';
import 'dart:convert';
import '../models/app_usage.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  late final AppDatabase db;

  factory DatabaseService() => _instance;

  DatabaseService._internal() {
    db = AppDatabase();
  }

  Future<void> insertSystemStatus(SystemStatus status) async {
    final db = DatabaseService().db;

    await db.into(db.systemStats).insert(
      SystemStatsCompanion.insert(
        cpuUsage: status.cpuUsage,
        ramUsage: status.ramUsage,
        diskUsage: status.diskUsage,
        cpuName: status.cpuName,
        gpuName: status.gpuName,
        downloadSpeed: status.downloadSpeed,
        uploadSpeed: status.uploadSpeed,
        isConnected: status.isConnected,
        temperature: status.temperature,
        osName: status.osName,
        deviceName: status.deviceName,
        batteryLevel: status.batteryLevel,
        batteryStatus: status.batteryStatus,

        computerName: status.additionalInfo['Computer Name'] ?? '',
        cpuCores: int.tryParse(status.additionalInfo['CPU Cores'] ?? '0') ?? 0,
        totalRam: status.additionalInfo['Total RAM'] ?? '',
        userName: status.additionalInfo['User Name'] ?? '',

        osBuild: status.additionalInfo['OS Build'] ?? '',
        buildNumber: status.additionalInfo['Build Number'] ?? '',
        kernel: status.additionalInfo['Kernel'] ?? '',
        platformId: status.additionalInfo['Platform ID'] ?? '',

        manufacturer: status.additionalInfo['Manufacturer'] ?? '',
        model: status.additionalInfo['Model'] ?? '',

        camera: status.locationInfo['Camera'] == 'Yes',
        mic: status.locationInfo['Mic'] == 'Yes',
        speaker: status.locationInfo['Speaker'] == 'Yes',

        city: status.locationInfo['City'] ?? '',
        region: status.locationInfo['Region'] ?? '',
        country: status.locationInfo['Country'] ?? '',

        longitude: double.tryParse(status.locationInfo['Longitude'] ?? '0') ?? 0,
        latitude: double.tryParse(status.locationInfo['Latitude'] ?? '0') ?? 0,

        appUsageData: jsonEncode(status.appData.map((e) => e.toJson()).toList()),

        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<SystemStat?> getLastRecord() async {
    final db = DatabaseService().db;

    final query = await (db.select(db.systemStats)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1))
        .get();

    return query.isNotEmpty ? query.first : null;
  }

  Future<void> updateSpeed(int id, double download, double upload) async {
    final db = DatabaseService().db;

    await (db.update(db.systemStats)..where((t) => t.id.equals(id))).write(
      SystemStatsCompanion(
        downloadSpeed: Value(download),
        uploadSpeed: Value(upload),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateLatestSpeed(double download, double upload) async {
    final last = await getLastRecord();

    if (last == null) return;

    await updateSpeed(last.id, download, upload);
  }


  Future<void> printLatestRecord() async {
    final db = DatabaseService().db;

    final row = await (db.select(db.systemStats)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1))
        .getSingleOrNull();

    if (row == null) {
      print("No data found");
      return;
    }

    print("===== SYSTEM STATUS =====");
    print("CPU Usage: ${row.cpuUsage}%");
    print("RAM Usage: ${row.ramUsage}%");
    print("Disk Usage: ${row.diskUsage}%");

    print("CPU: ${row.cpuName}");
    print("GPU: ${row.gpuName}");

    print("Download: ${row.downloadSpeed} Mbps");
    print("Upload: ${row.uploadSpeed} Mbps");

    print("Connected: ${row.isConnected}");
    print("Temperature: ${row.temperature}");

    print("OS: ${row.osName}");
    print("Device: ${row.deviceName}");

    print("===== ADDITIONAL INFO =====");
    print("Computer Name: ${row.computerName}");
    print("CPU Cores: ${row.cpuCores}");
    print("Total RAM: ${row.totalRam}");
    print("User Name: ${row.userName}");
    print("OS Build: ${row.osBuild}");
    print("Build Number: ${row.buildNumber}");
    print("Kernel: ${row.kernel}");
    print("Platform ID: ${row.platformId}");
    print("Manufacturer: ${row.manufacturer}");
    print("Model: ${row.model}");



    print("Battery: ${row.batteryLevel} (${row.batteryStatus})");

    print("Location: ${row.city}, ${row.region}, ${row.country}");
    print("Lat: ${row.latitude}, Lon: ${row.longitude}");

    print("===== APP USAGE =====");
    final List<dynamic> appsJson = jsonDecode(row.appUsageData);
    final apps = appsJson.map((e) => AppUsageData.fromJson(e)).toList();

    for (var app in apps) {
      print("App: ${app.name}");
      print("Usage: ${app.from} → ${app.till}");
      print("Duration: ${app.duration}");
      print("-------------------");
    }

    print("Created: ${row.createdAt}");
    print("Updated: ${row.updatedAt}");
  }


  Future<void> deleteAllSystemStats() async {
    final db = DatabaseService().db;

    await db.delete(db.systemStats).go();

    print("All system stats deleted");
  }



}