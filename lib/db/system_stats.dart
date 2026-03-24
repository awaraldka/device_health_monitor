import 'package:drift/drift.dart';

class SystemStats extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Usage
  IntColumn get cpuUsage => integer()();
  IntColumn get ramUsage => integer()();
  IntColumn get diskUsage => integer()();

  // Hardware
  TextColumn get cpuName => text()();
  TextColumn get gpuName => text()();

  // Network
  RealColumn get downloadSpeed => real()();
  RealColumn get uploadSpeed => real()();

  BoolColumn get isConnected => boolean()();

  // Temperature
  RealColumn get temperature => real()();

  // System
  TextColumn get osName => text()();
  TextColumn get deviceName => text()();

  // Battery
  TextColumn get batteryLevel => text()();
  TextColumn get batteryStatus => text()();

  // Additional Info
  TextColumn get computerName => text()();
  IntColumn get cpuCores => integer()();
  TextColumn get totalRam => text()();
  TextColumn get userName => text()();

  TextColumn get osBuild => text()();
  TextColumn get buildNumber => text()();
  TextColumn get kernel => text()();
  TextColumn get platformId => text()();

  TextColumn get manufacturer => text()();
  TextColumn get model => text()();

  // Hardware Checks
  BoolColumn get camera => boolean()();
  BoolColumn get mic => boolean()();
  BoolColumn get speaker => boolean()();

  // Location
  TextColumn get city => text()();
  TextColumn get region => text()();
  TextColumn get country => text()();

  RealColumn get longitude => real()();
  RealColumn get latitude => real()();

  // App Usage
  TextColumn get appUsageData => text()();

  // Timestamps
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
