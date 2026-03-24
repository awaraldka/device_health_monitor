import 'package:drift/drift.dart';

class SystemStats extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Usage
  TextColumn get cpuUsage => text()();
  TextColumn get ramUsage => text()();
  TextColumn get diskUsage => text()();

  // Hardware
  TextColumn get cpuName => text()();
  TextColumn get gpuName => text()();

  // Network
  TextColumn get downloadSpeed => text()();
  TextColumn get uploadSpeed => text()();

  TextColumn get isConnected => text()();

  // Temperature
  TextColumn get temperature => text()();

  // System
  TextColumn get osName => text()();
  TextColumn get deviceName => text()();

  // Battery
  TextColumn get batteryLevel => text()();
  TextColumn get batteryStatus => text()();

  // Additional Info
  TextColumn get computerName => text()();
  TextColumn get cpuCores => text()();
  TextColumn get totalRam => text()();
  TextColumn get userName => text()();

  TextColumn get osBuild => text()();
  TextColumn get buildNumber => text()();
  TextColumn get kernel => text()();
  TextColumn get platformId => text()();

  TextColumn get manufacturer => text()();
  TextColumn get model => text()();

  // Hardware Checks
  TextColumn get camera => text()();
  TextColumn get mic => text()();
  TextColumn get speaker => text()();

  // Location
  TextColumn get city => text()();
  TextColumn get region => text()();
  TextColumn get country => text()();

  TextColumn get longitude => text()();
  TextColumn get latitude => text()();

  // App Usage
  TextColumn get appUsageData => text()();

  // Timestamps
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
