import 'package:device_health_monitor/db/app_database.dart';
import 'package:device_health_monitor/models/system_status.dart';
import 'package:drift/drift.dart';
import 'dart:convert';
import '../models/app_usage.dart';
import 'encryption_service.dart';

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
        cpuUsage: EncryptionService.encryptInt(status.cpuUsage),
        ramUsage: EncryptionService.encryptInt(status.ramUsage),
        diskUsage: EncryptionService.encryptInt(status.diskUsage),
        cpuName: EncryptionService.encrypt(status.cpuName),
        gpuName: EncryptionService.encrypt(status.gpuName),
        downloadSpeed: EncryptionService.encryptDouble(status.downloadSpeed),
        uploadSpeed: EncryptionService.encryptDouble(status.uploadSpeed),
        isConnected: EncryptionService.encryptBool(status.isConnected),
        temperature: EncryptionService.encryptDouble(status.temperature),
        osName: EncryptionService.encrypt(status.osName),
        deviceName: EncryptionService.encrypt(status.deviceName),
        batteryLevel: EncryptionService.encrypt(status.batteryLevel),
        batteryStatus: EncryptionService.encrypt(status.batteryStatus),

        computerName: EncryptionService.encrypt(status.additionalInfo['Computer Name'] ?? ''),
        cpuCores: EncryptionService.encryptInt(int.tryParse(status.additionalInfo['CPU Cores'] ?? '0') ?? 0),
        totalRam: EncryptionService.encrypt(status.additionalInfo['Total RAM'] ?? ''),
        userName: EncryptionService.encrypt(status.additionalInfo['User Name'] ?? ''),

        osBuild: EncryptionService.encrypt(status.additionalInfo['OS Build'] ?? ''),
        buildNumber: EncryptionService.encrypt(status.additionalInfo['Build Number'] ?? ''),
        kernel: EncryptionService.encrypt(status.additionalInfo['Kernel'] ?? ''),
        platformId: EncryptionService.encrypt(status.additionalInfo['Platform ID'] ?? ''),

        manufacturer: EncryptionService.encrypt(status.additionalInfo['Manufacturer'] ?? ''),
        model: EncryptionService.encrypt(status.additionalInfo['Model'] ?? ''),

        camera: EncryptionService.encryptBool(status.locationInfo['Camera'] == 'Yes'),
        mic: EncryptionService.encryptBool(status.locationInfo['Mic'] == 'Yes'),
        speaker: EncryptionService.encryptBool(status.locationInfo['Speaker'] == 'Yes'),

        city: EncryptionService.encrypt(status.locationInfo['City'] ?? ''),
        region: EncryptionService.encrypt(status.locationInfo['Region'] ?? ''),
        country: EncryptionService.encrypt(status.locationInfo['Country'] ?? ''),

        longitude: EncryptionService.encryptDouble(double.tryParse(status.locationInfo['Longitude'] ?? '0') ?? 0.0),
        latitude: EncryptionService.encryptDouble(double.tryParse(status.locationInfo['Latitude'] ?? '0') ?? 0.0),

        appUsageData: EncryptionService.encrypt(jsonEncode(status.appData.map((e) => e.toJson()).toList())),

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
        downloadSpeed: Value(EncryptionService.encryptDouble(download)),
        uploadSpeed: Value(EncryptionService.encryptDouble(upload)),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateLatestSpeed(double download, double upload) async {
    final last = await getLastRecord();

    if (last == null) return;

    await updateSpeed(last.id, download, upload);
  }

  Future<void> printSize() async {
    final db = DatabaseService().db;

    final countExp = db.systemStats.id.count();

    final query = db.selectOnly(db.systemStats)
      ..addColumns([countExp]);

    final result = await query.getSingle();

    final count = result.read(countExp);

    print("Total rows: $count");
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
    print("CPU Usage: ${row.cpuUsage}%");
    print("RAM Usage: ${row.ramUsage}%");
    print("RAM Usage: ${row.diskUsage}%");

    print("===== SYSTEM STATUS (DECRYPTED) =====");
    print("CPU Usage: ${EncryptionService.decrypt(row.cpuUsage)}%");
    print("RAM Usage: ${EncryptionService.decrypt(row.ramUsage)}%");
    print("Disk Usage: ${EncryptionService.decrypt(row.diskUsage)}%");

    print("CPU: ${EncryptionService.decrypt(row.cpuName)}");
    print("GPU: ${EncryptionService.decrypt(row.gpuName)}");

    print("Download: ${EncryptionService.decrypt(row.downloadSpeed)} Mbps");
    print("Upload: ${EncryptionService.decrypt(row.uploadSpeed)} Mbps");

    print("Connected: ${EncryptionService.decrypt(row.isConnected)}");
    print("Temperature: ${EncryptionService.decrypt(row.temperature)}");

    print("OS: ${EncryptionService.decrypt(row.osName)}");
    print("Device: ${EncryptionService.decrypt(row.deviceName)}");

    print("===== ADDITIONAL INFO =====");
    print("Computer Name: ${EncryptionService.decrypt(row.computerName)}");
    print("CPU Cores: ${EncryptionService.decrypt(row.cpuCores)}");
    print("Total RAM: ${EncryptionService.decrypt(row.totalRam)}");
    print("User Name: ${EncryptionService.decrypt(row.userName)}");
    print("OS Build: ${EncryptionService.decrypt(row.osBuild)}");
    print("Build Number: ${EncryptionService.decrypt(row.buildNumber)}");
    print("Kernel: ${EncryptionService.decrypt(row.kernel)}");
    print("Platform ID: ${EncryptionService.decrypt(row.platformId)}");
    print("Manufacturer: ${EncryptionService.decrypt(row.manufacturer)}");
    print("Model: ${EncryptionService.decrypt(row.model)}");

    print("Battery: ${EncryptionService.decrypt(row.batteryLevel)} (${EncryptionService.decrypt(row.batteryStatus)})");

    print("Location: ${EncryptionService.decrypt(row.city)}, ${EncryptionService.decrypt(row.region)}, ${EncryptionService.decrypt(row.country)}");
    print("Lat: ${EncryptionService.decrypt(row.latitude)}, Lon: ${EncryptionService.decrypt(row.longitude)}");

    print("===== APP USAGE =====");
    final String decryptedApps = EncryptionService.decrypt(row.appUsageData);
    if (decryptedApps != "Decryption Error" && decryptedApps.isNotEmpty) {
      try {
        final List<dynamic> appsJson = jsonDecode(decryptedApps);
        final apps = appsJson.map((e) => AppUsageData.fromJson(e)).toList();

        for (var app in apps) {
          print("App: ${app.name}");
          print("Usage: ${app.from} → ${app.till}");
          print("Duration: ${app.duration}");
          print("-------------------");
        }
      } catch (e) {
        print("Error decoding app usage JSON: $e");
      }
    } else {
      print("App Usage: [Decryption Error or Data Empty]");
    }

    print("Created: ${row.createdAt}");
    print("Updated: ${row.updatedAt}");
  }

  Future<void> printLatestRecordDec() => printLatestRecord();

  Future<void> deleteAllSystemStats() async {
    final db = DatabaseService().db;
    await db.delete(db.systemStats).go();
    print("All system stats deleted");
  }
}


