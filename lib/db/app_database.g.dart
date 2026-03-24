// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SystemStatsTable extends SystemStats
    with TableInfo<$SystemStatsTable, SystemStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SystemStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _cpuUsageMeta =
      const VerificationMeta('cpuUsage');
  @override
  late final GeneratedColumn<int> cpuUsage = GeneratedColumn<int>(
      'cpu_usage', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _ramUsageMeta =
      const VerificationMeta('ramUsage');
  @override
  late final GeneratedColumn<int> ramUsage = GeneratedColumn<int>(
      'ram_usage', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diskUsageMeta =
      const VerificationMeta('diskUsage');
  @override
  late final GeneratedColumn<int> diskUsage = GeneratedColumn<int>(
      'disk_usage', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _cpuNameMeta =
      const VerificationMeta('cpuName');
  @override
  late final GeneratedColumn<String> cpuName = GeneratedColumn<String>(
      'cpu_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gpuNameMeta =
      const VerificationMeta('gpuName');
  @override
  late final GeneratedColumn<String> gpuName = GeneratedColumn<String>(
      'gpu_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _downloadSpeedMeta =
      const VerificationMeta('downloadSpeed');
  @override
  late final GeneratedColumn<double> downloadSpeed = GeneratedColumn<double>(
      'download_speed', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _uploadSpeedMeta =
      const VerificationMeta('uploadSpeed');
  @override
  late final GeneratedColumn<double> uploadSpeed = GeneratedColumn<double>(
      'upload_speed', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isConnectedMeta =
      const VerificationMeta('isConnected');
  @override
  late final GeneratedColumn<bool> isConnected = GeneratedColumn<bool>(
      'is_connected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_connected" IN (0, 1))'));
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
      'temperature', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _osNameMeta = const VerificationMeta('osName');
  @override
  late final GeneratedColumn<String> osName = GeneratedColumn<String>(
      'os_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _deviceNameMeta =
      const VerificationMeta('deviceName');
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
      'device_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _batteryLevelMeta =
      const VerificationMeta('batteryLevel');
  @override
  late final GeneratedColumn<String> batteryLevel = GeneratedColumn<String>(
      'battery_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _batteryStatusMeta =
      const VerificationMeta('batteryStatus');
  @override
  late final GeneratedColumn<String> batteryStatus = GeneratedColumn<String>(
      'battery_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _computerNameMeta =
      const VerificationMeta('computerName');
  @override
  late final GeneratedColumn<String> computerName = GeneratedColumn<String>(
      'computer_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cpuCoresMeta =
      const VerificationMeta('cpuCores');
  @override
  late final GeneratedColumn<int> cpuCores = GeneratedColumn<int>(
      'cpu_cores', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalRamMeta =
      const VerificationMeta('totalRam');
  @override
  late final GeneratedColumn<String> totalRam = GeneratedColumn<String>(
      'total_ram', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _osBuildMeta =
      const VerificationMeta('osBuild');
  @override
  late final GeneratedColumn<String> osBuild = GeneratedColumn<String>(
      'os_build', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _buildNumberMeta =
      const VerificationMeta('buildNumber');
  @override
  late final GeneratedColumn<String> buildNumber = GeneratedColumn<String>(
      'build_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kernelMeta = const VerificationMeta('kernel');
  @override
  late final GeneratedColumn<String> kernel = GeneratedColumn<String>(
      'kernel', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformIdMeta =
      const VerificationMeta('platformId');
  @override
  late final GeneratedColumn<String> platformId = GeneratedColumn<String>(
      'platform_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _manufacturerMeta =
      const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
      'manufacturer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cameraMeta = const VerificationMeta('camera');
  @override
  late final GeneratedColumn<bool> camera = GeneratedColumn<bool>(
      'camera', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("camera" IN (0, 1))'));
  static const VerificationMeta _micMeta = const VerificationMeta('mic');
  @override
  late final GeneratedColumn<bool> mic = GeneratedColumn<bool>(
      'mic', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("mic" IN (0, 1))'));
  static const VerificationMeta _speakerMeta =
      const VerificationMeta('speaker');
  @override
  late final GeneratedColumn<bool> speaker = GeneratedColumn<bool>(
      'speaker', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("speaker" IN (0, 1))'));
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _appUsageDataMeta =
      const VerificationMeta('appUsageData');
  @override
  late final GeneratedColumn<String> appUsageData = GeneratedColumn<String>(
      'app_usage_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        cpuUsage,
        ramUsage,
        diskUsage,
        cpuName,
        gpuName,
        downloadSpeed,
        uploadSpeed,
        isConnected,
        temperature,
        osName,
        deviceName,
        batteryLevel,
        batteryStatus,
        computerName,
        cpuCores,
        totalRam,
        userName,
        osBuild,
        buildNumber,
        kernel,
        platformId,
        manufacturer,
        model,
        camera,
        mic,
        speaker,
        city,
        region,
        country,
        longitude,
        latitude,
        appUsageData,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'system_stats';
  @override
  VerificationContext validateIntegrity(Insertable<SystemStat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cpu_usage')) {
      context.handle(_cpuUsageMeta,
          cpuUsage.isAcceptableOrUnknown(data['cpu_usage']!, _cpuUsageMeta));
    } else if (isInserting) {
      context.missing(_cpuUsageMeta);
    }
    if (data.containsKey('ram_usage')) {
      context.handle(_ramUsageMeta,
          ramUsage.isAcceptableOrUnknown(data['ram_usage']!, _ramUsageMeta));
    } else if (isInserting) {
      context.missing(_ramUsageMeta);
    }
    if (data.containsKey('disk_usage')) {
      context.handle(_diskUsageMeta,
          diskUsage.isAcceptableOrUnknown(data['disk_usage']!, _diskUsageMeta));
    } else if (isInserting) {
      context.missing(_diskUsageMeta);
    }
    if (data.containsKey('cpu_name')) {
      context.handle(_cpuNameMeta,
          cpuName.isAcceptableOrUnknown(data['cpu_name']!, _cpuNameMeta));
    } else if (isInserting) {
      context.missing(_cpuNameMeta);
    }
    if (data.containsKey('gpu_name')) {
      context.handle(_gpuNameMeta,
          gpuName.isAcceptableOrUnknown(data['gpu_name']!, _gpuNameMeta));
    } else if (isInserting) {
      context.missing(_gpuNameMeta);
    }
    if (data.containsKey('download_speed')) {
      context.handle(
          _downloadSpeedMeta,
          downloadSpeed.isAcceptableOrUnknown(
              data['download_speed']!, _downloadSpeedMeta));
    } else if (isInserting) {
      context.missing(_downloadSpeedMeta);
    }
    if (data.containsKey('upload_speed')) {
      context.handle(
          _uploadSpeedMeta,
          uploadSpeed.isAcceptableOrUnknown(
              data['upload_speed']!, _uploadSpeedMeta));
    } else if (isInserting) {
      context.missing(_uploadSpeedMeta);
    }
    if (data.containsKey('is_connected')) {
      context.handle(
          _isConnectedMeta,
          isConnected.isAcceptableOrUnknown(
              data['is_connected']!, _isConnectedMeta));
    } else if (isInserting) {
      context.missing(_isConnectedMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('os_name')) {
      context.handle(_osNameMeta,
          osName.isAcceptableOrUnknown(data['os_name']!, _osNameMeta));
    } else if (isInserting) {
      context.missing(_osNameMeta);
    }
    if (data.containsKey('device_name')) {
      context.handle(
          _deviceNameMeta,
          deviceName.isAcceptableOrUnknown(
              data['device_name']!, _deviceNameMeta));
    } else if (isInserting) {
      context.missing(_deviceNameMeta);
    }
    if (data.containsKey('battery_level')) {
      context.handle(
          _batteryLevelMeta,
          batteryLevel.isAcceptableOrUnknown(
              data['battery_level']!, _batteryLevelMeta));
    } else if (isInserting) {
      context.missing(_batteryLevelMeta);
    }
    if (data.containsKey('battery_status')) {
      context.handle(
          _batteryStatusMeta,
          batteryStatus.isAcceptableOrUnknown(
              data['battery_status']!, _batteryStatusMeta));
    } else if (isInserting) {
      context.missing(_batteryStatusMeta);
    }
    if (data.containsKey('computer_name')) {
      context.handle(
          _computerNameMeta,
          computerName.isAcceptableOrUnknown(
              data['computer_name']!, _computerNameMeta));
    } else if (isInserting) {
      context.missing(_computerNameMeta);
    }
    if (data.containsKey('cpu_cores')) {
      context.handle(_cpuCoresMeta,
          cpuCores.isAcceptableOrUnknown(data['cpu_cores']!, _cpuCoresMeta));
    } else if (isInserting) {
      context.missing(_cpuCoresMeta);
    }
    if (data.containsKey('total_ram')) {
      context.handle(_totalRamMeta,
          totalRam.isAcceptableOrUnknown(data['total_ram']!, _totalRamMeta));
    } else if (isInserting) {
      context.missing(_totalRamMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('os_build')) {
      context.handle(_osBuildMeta,
          osBuild.isAcceptableOrUnknown(data['os_build']!, _osBuildMeta));
    } else if (isInserting) {
      context.missing(_osBuildMeta);
    }
    if (data.containsKey('build_number')) {
      context.handle(
          _buildNumberMeta,
          buildNumber.isAcceptableOrUnknown(
              data['build_number']!, _buildNumberMeta));
    } else if (isInserting) {
      context.missing(_buildNumberMeta);
    }
    if (data.containsKey('kernel')) {
      context.handle(_kernelMeta,
          kernel.isAcceptableOrUnknown(data['kernel']!, _kernelMeta));
    } else if (isInserting) {
      context.missing(_kernelMeta);
    }
    if (data.containsKey('platform_id')) {
      context.handle(
          _platformIdMeta,
          platformId.isAcceptableOrUnknown(
              data['platform_id']!, _platformIdMeta));
    } else if (isInserting) {
      context.missing(_platformIdMeta);
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
          _manufacturerMeta,
          manufacturer.isAcceptableOrUnknown(
              data['manufacturer']!, _manufacturerMeta));
    } else if (isInserting) {
      context.missing(_manufacturerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('camera')) {
      context.handle(_cameraMeta,
          camera.isAcceptableOrUnknown(data['camera']!, _cameraMeta));
    } else if (isInserting) {
      context.missing(_cameraMeta);
    }
    if (data.containsKey('mic')) {
      context.handle(
          _micMeta, mic.isAcceptableOrUnknown(data['mic']!, _micMeta));
    } else if (isInserting) {
      context.missing(_micMeta);
    }
    if (data.containsKey('speaker')) {
      context.handle(_speakerMeta,
          speaker.isAcceptableOrUnknown(data['speaker']!, _speakerMeta));
    } else if (isInserting) {
      context.missing(_speakerMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('app_usage_data')) {
      context.handle(
          _appUsageDataMeta,
          appUsageData.isAcceptableOrUnknown(
              data['app_usage_data']!, _appUsageDataMeta));
    } else if (isInserting) {
      context.missing(_appUsageDataMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SystemStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SystemStat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cpuUsage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cpu_usage'])!,
      ramUsage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ram_usage'])!,
      diskUsage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}disk_usage'])!,
      cpuName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpu_name'])!,
      gpuName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gpu_name'])!,
      downloadSpeed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}download_speed'])!,
      uploadSpeed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}upload_speed'])!,
      isConnected: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_connected'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temperature'])!,
      osName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}os_name'])!,
      deviceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_name'])!,
      batteryLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}battery_level'])!,
      batteryStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}battery_status'])!,
      computerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}computer_name'])!,
      cpuCores: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cpu_cores'])!,
      totalRam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}total_ram'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      osBuild: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}os_build'])!,
      buildNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}build_number'])!,
      kernel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kernel'])!,
      platformId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platform_id'])!,
      manufacturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manufacturer'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model'])!,
      camera: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}camera'])!,
      mic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}mic'])!,
      speaker: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}speaker'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      appUsageData: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_usage_data'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SystemStatsTable createAlias(String alias) {
    return $SystemStatsTable(attachedDatabase, alias);
  }
}

class SystemStat extends DataClass implements Insertable<SystemStat> {
  final int id;
  final int cpuUsage;
  final int ramUsage;
  final int diskUsage;
  final String cpuName;
  final String gpuName;
  final double downloadSpeed;
  final double uploadSpeed;
  final bool isConnected;
  final double temperature;
  final String osName;
  final String deviceName;
  final String batteryLevel;
  final String batteryStatus;
  final String computerName;
  final int cpuCores;
  final String totalRam;
  final String userName;
  final String osBuild;
  final String buildNumber;
  final String kernel;
  final String platformId;
  final String manufacturer;
  final String model;
  final bool camera;
  final bool mic;
  final bool speaker;
  final String city;
  final String region;
  final String country;
  final double longitude;
  final double latitude;
  final String appUsageData;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SystemStat(
      {required this.id,
      required this.cpuUsage,
      required this.ramUsage,
      required this.diskUsage,
      required this.cpuName,
      required this.gpuName,
      required this.downloadSpeed,
      required this.uploadSpeed,
      required this.isConnected,
      required this.temperature,
      required this.osName,
      required this.deviceName,
      required this.batteryLevel,
      required this.batteryStatus,
      required this.computerName,
      required this.cpuCores,
      required this.totalRam,
      required this.userName,
      required this.osBuild,
      required this.buildNumber,
      required this.kernel,
      required this.platformId,
      required this.manufacturer,
      required this.model,
      required this.camera,
      required this.mic,
      required this.speaker,
      required this.city,
      required this.region,
      required this.country,
      required this.longitude,
      required this.latitude,
      required this.appUsageData,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cpu_usage'] = Variable<int>(cpuUsage);
    map['ram_usage'] = Variable<int>(ramUsage);
    map['disk_usage'] = Variable<int>(diskUsage);
    map['cpu_name'] = Variable<String>(cpuName);
    map['gpu_name'] = Variable<String>(gpuName);
    map['download_speed'] = Variable<double>(downloadSpeed);
    map['upload_speed'] = Variable<double>(uploadSpeed);
    map['is_connected'] = Variable<bool>(isConnected);
    map['temperature'] = Variable<double>(temperature);
    map['os_name'] = Variable<String>(osName);
    map['device_name'] = Variable<String>(deviceName);
    map['battery_level'] = Variable<String>(batteryLevel);
    map['battery_status'] = Variable<String>(batteryStatus);
    map['computer_name'] = Variable<String>(computerName);
    map['cpu_cores'] = Variable<int>(cpuCores);
    map['total_ram'] = Variable<String>(totalRam);
    map['user_name'] = Variable<String>(userName);
    map['os_build'] = Variable<String>(osBuild);
    map['build_number'] = Variable<String>(buildNumber);
    map['kernel'] = Variable<String>(kernel);
    map['platform_id'] = Variable<String>(platformId);
    map['manufacturer'] = Variable<String>(manufacturer);
    map['model'] = Variable<String>(model);
    map['camera'] = Variable<bool>(camera);
    map['mic'] = Variable<bool>(mic);
    map['speaker'] = Variable<bool>(speaker);
    map['city'] = Variable<String>(city);
    map['region'] = Variable<String>(region);
    map['country'] = Variable<String>(country);
    map['longitude'] = Variable<double>(longitude);
    map['latitude'] = Variable<double>(latitude);
    map['app_usage_data'] = Variable<String>(appUsageData);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SystemStatsCompanion toCompanion(bool nullToAbsent) {
    return SystemStatsCompanion(
      id: Value(id),
      cpuUsage: Value(cpuUsage),
      ramUsage: Value(ramUsage),
      diskUsage: Value(diskUsage),
      cpuName: Value(cpuName),
      gpuName: Value(gpuName),
      downloadSpeed: Value(downloadSpeed),
      uploadSpeed: Value(uploadSpeed),
      isConnected: Value(isConnected),
      temperature: Value(temperature),
      osName: Value(osName),
      deviceName: Value(deviceName),
      batteryLevel: Value(batteryLevel),
      batteryStatus: Value(batteryStatus),
      computerName: Value(computerName),
      cpuCores: Value(cpuCores),
      totalRam: Value(totalRam),
      userName: Value(userName),
      osBuild: Value(osBuild),
      buildNumber: Value(buildNumber),
      kernel: Value(kernel),
      platformId: Value(platformId),
      manufacturer: Value(manufacturer),
      model: Value(model),
      camera: Value(camera),
      mic: Value(mic),
      speaker: Value(speaker),
      city: Value(city),
      region: Value(region),
      country: Value(country),
      longitude: Value(longitude),
      latitude: Value(latitude),
      appUsageData: Value(appUsageData),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SystemStat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SystemStat(
      id: serializer.fromJson<int>(json['id']),
      cpuUsage: serializer.fromJson<int>(json['cpuUsage']),
      ramUsage: serializer.fromJson<int>(json['ramUsage']),
      diskUsage: serializer.fromJson<int>(json['diskUsage']),
      cpuName: serializer.fromJson<String>(json['cpuName']),
      gpuName: serializer.fromJson<String>(json['gpuName']),
      downloadSpeed: serializer.fromJson<double>(json['downloadSpeed']),
      uploadSpeed: serializer.fromJson<double>(json['uploadSpeed']),
      isConnected: serializer.fromJson<bool>(json['isConnected']),
      temperature: serializer.fromJson<double>(json['temperature']),
      osName: serializer.fromJson<String>(json['osName']),
      deviceName: serializer.fromJson<String>(json['deviceName']),
      batteryLevel: serializer.fromJson<String>(json['batteryLevel']),
      batteryStatus: serializer.fromJson<String>(json['batteryStatus']),
      computerName: serializer.fromJson<String>(json['computerName']),
      cpuCores: serializer.fromJson<int>(json['cpuCores']),
      totalRam: serializer.fromJson<String>(json['totalRam']),
      userName: serializer.fromJson<String>(json['userName']),
      osBuild: serializer.fromJson<String>(json['osBuild']),
      buildNumber: serializer.fromJson<String>(json['buildNumber']),
      kernel: serializer.fromJson<String>(json['kernel']),
      platformId: serializer.fromJson<String>(json['platformId']),
      manufacturer: serializer.fromJson<String>(json['manufacturer']),
      model: serializer.fromJson<String>(json['model']),
      camera: serializer.fromJson<bool>(json['camera']),
      mic: serializer.fromJson<bool>(json['mic']),
      speaker: serializer.fromJson<bool>(json['speaker']),
      city: serializer.fromJson<String>(json['city']),
      region: serializer.fromJson<String>(json['region']),
      country: serializer.fromJson<String>(json['country']),
      longitude: serializer.fromJson<double>(json['longitude']),
      latitude: serializer.fromJson<double>(json['latitude']),
      appUsageData: serializer.fromJson<String>(json['appUsageData']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cpuUsage': serializer.toJson<int>(cpuUsage),
      'ramUsage': serializer.toJson<int>(ramUsage),
      'diskUsage': serializer.toJson<int>(diskUsage),
      'cpuName': serializer.toJson<String>(cpuName),
      'gpuName': serializer.toJson<String>(gpuName),
      'downloadSpeed': serializer.toJson<double>(downloadSpeed),
      'uploadSpeed': serializer.toJson<double>(uploadSpeed),
      'isConnected': serializer.toJson<bool>(isConnected),
      'temperature': serializer.toJson<double>(temperature),
      'osName': serializer.toJson<String>(osName),
      'deviceName': serializer.toJson<String>(deviceName),
      'batteryLevel': serializer.toJson<String>(batteryLevel),
      'batteryStatus': serializer.toJson<String>(batteryStatus),
      'computerName': serializer.toJson<String>(computerName),
      'cpuCores': serializer.toJson<int>(cpuCores),
      'totalRam': serializer.toJson<String>(totalRam),
      'userName': serializer.toJson<String>(userName),
      'osBuild': serializer.toJson<String>(osBuild),
      'buildNumber': serializer.toJson<String>(buildNumber),
      'kernel': serializer.toJson<String>(kernel),
      'platformId': serializer.toJson<String>(platformId),
      'manufacturer': serializer.toJson<String>(manufacturer),
      'model': serializer.toJson<String>(model),
      'camera': serializer.toJson<bool>(camera),
      'mic': serializer.toJson<bool>(mic),
      'speaker': serializer.toJson<bool>(speaker),
      'city': serializer.toJson<String>(city),
      'region': serializer.toJson<String>(region),
      'country': serializer.toJson<String>(country),
      'longitude': serializer.toJson<double>(longitude),
      'latitude': serializer.toJson<double>(latitude),
      'appUsageData': serializer.toJson<String>(appUsageData),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SystemStat copyWith(
          {int? id,
          int? cpuUsage,
          int? ramUsage,
          int? diskUsage,
          String? cpuName,
          String? gpuName,
          double? downloadSpeed,
          double? uploadSpeed,
          bool? isConnected,
          double? temperature,
          String? osName,
          String? deviceName,
          String? batteryLevel,
          String? batteryStatus,
          String? computerName,
          int? cpuCores,
          String? totalRam,
          String? userName,
          String? osBuild,
          String? buildNumber,
          String? kernel,
          String? platformId,
          String? manufacturer,
          String? model,
          bool? camera,
          bool? mic,
          bool? speaker,
          String? city,
          String? region,
          String? country,
          double? longitude,
          double? latitude,
          String? appUsageData,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SystemStat(
        id: id ?? this.id,
        cpuUsage: cpuUsage ?? this.cpuUsage,
        ramUsage: ramUsage ?? this.ramUsage,
        diskUsage: diskUsage ?? this.diskUsage,
        cpuName: cpuName ?? this.cpuName,
        gpuName: gpuName ?? this.gpuName,
        downloadSpeed: downloadSpeed ?? this.downloadSpeed,
        uploadSpeed: uploadSpeed ?? this.uploadSpeed,
        isConnected: isConnected ?? this.isConnected,
        temperature: temperature ?? this.temperature,
        osName: osName ?? this.osName,
        deviceName: deviceName ?? this.deviceName,
        batteryLevel: batteryLevel ?? this.batteryLevel,
        batteryStatus: batteryStatus ?? this.batteryStatus,
        computerName: computerName ?? this.computerName,
        cpuCores: cpuCores ?? this.cpuCores,
        totalRam: totalRam ?? this.totalRam,
        userName: userName ?? this.userName,
        osBuild: osBuild ?? this.osBuild,
        buildNumber: buildNumber ?? this.buildNumber,
        kernel: kernel ?? this.kernel,
        platformId: platformId ?? this.platformId,
        manufacturer: manufacturer ?? this.manufacturer,
        model: model ?? this.model,
        camera: camera ?? this.camera,
        mic: mic ?? this.mic,
        speaker: speaker ?? this.speaker,
        city: city ?? this.city,
        region: region ?? this.region,
        country: country ?? this.country,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        appUsageData: appUsageData ?? this.appUsageData,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SystemStat copyWithCompanion(SystemStatsCompanion data) {
    return SystemStat(
      id: data.id.present ? data.id.value : this.id,
      cpuUsage: data.cpuUsage.present ? data.cpuUsage.value : this.cpuUsage,
      ramUsage: data.ramUsage.present ? data.ramUsage.value : this.ramUsage,
      diskUsage: data.diskUsage.present ? data.diskUsage.value : this.diskUsage,
      cpuName: data.cpuName.present ? data.cpuName.value : this.cpuName,
      gpuName: data.gpuName.present ? data.gpuName.value : this.gpuName,
      downloadSpeed: data.downloadSpeed.present
          ? data.downloadSpeed.value
          : this.downloadSpeed,
      uploadSpeed:
          data.uploadSpeed.present ? data.uploadSpeed.value : this.uploadSpeed,
      isConnected:
          data.isConnected.present ? data.isConnected.value : this.isConnected,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      osName: data.osName.present ? data.osName.value : this.osName,
      deviceName:
          data.deviceName.present ? data.deviceName.value : this.deviceName,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      batteryStatus: data.batteryStatus.present
          ? data.batteryStatus.value
          : this.batteryStatus,
      computerName: data.computerName.present
          ? data.computerName.value
          : this.computerName,
      cpuCores: data.cpuCores.present ? data.cpuCores.value : this.cpuCores,
      totalRam: data.totalRam.present ? data.totalRam.value : this.totalRam,
      userName: data.userName.present ? data.userName.value : this.userName,
      osBuild: data.osBuild.present ? data.osBuild.value : this.osBuild,
      buildNumber:
          data.buildNumber.present ? data.buildNumber.value : this.buildNumber,
      kernel: data.kernel.present ? data.kernel.value : this.kernel,
      platformId:
          data.platformId.present ? data.platformId.value : this.platformId,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      camera: data.camera.present ? data.camera.value : this.camera,
      mic: data.mic.present ? data.mic.value : this.mic,
      speaker: data.speaker.present ? data.speaker.value : this.speaker,
      city: data.city.present ? data.city.value : this.city,
      region: data.region.present ? data.region.value : this.region,
      country: data.country.present ? data.country.value : this.country,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      appUsageData: data.appUsageData.present
          ? data.appUsageData.value
          : this.appUsageData,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SystemStat(')
          ..write('id: $id, ')
          ..write('cpuUsage: $cpuUsage, ')
          ..write('ramUsage: $ramUsage, ')
          ..write('diskUsage: $diskUsage, ')
          ..write('cpuName: $cpuName, ')
          ..write('gpuName: $gpuName, ')
          ..write('downloadSpeed: $downloadSpeed, ')
          ..write('uploadSpeed: $uploadSpeed, ')
          ..write('isConnected: $isConnected, ')
          ..write('temperature: $temperature, ')
          ..write('osName: $osName, ')
          ..write('deviceName: $deviceName, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('batteryStatus: $batteryStatus, ')
          ..write('computerName: $computerName, ')
          ..write('cpuCores: $cpuCores, ')
          ..write('totalRam: $totalRam, ')
          ..write('userName: $userName, ')
          ..write('osBuild: $osBuild, ')
          ..write('buildNumber: $buildNumber, ')
          ..write('kernel: $kernel, ')
          ..write('platformId: $platformId, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('camera: $camera, ')
          ..write('mic: $mic, ')
          ..write('speaker: $speaker, ')
          ..write('city: $city, ')
          ..write('region: $region, ')
          ..write('country: $country, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('appUsageData: $appUsageData, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        cpuUsage,
        ramUsage,
        diskUsage,
        cpuName,
        gpuName,
        downloadSpeed,
        uploadSpeed,
        isConnected,
        temperature,
        osName,
        deviceName,
        batteryLevel,
        batteryStatus,
        computerName,
        cpuCores,
        totalRam,
        userName,
        osBuild,
        buildNumber,
        kernel,
        platformId,
        manufacturer,
        model,
        camera,
        mic,
        speaker,
        city,
        region,
        country,
        longitude,
        latitude,
        appUsageData,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SystemStat &&
          other.id == this.id &&
          other.cpuUsage == this.cpuUsage &&
          other.ramUsage == this.ramUsage &&
          other.diskUsage == this.diskUsage &&
          other.cpuName == this.cpuName &&
          other.gpuName == this.gpuName &&
          other.downloadSpeed == this.downloadSpeed &&
          other.uploadSpeed == this.uploadSpeed &&
          other.isConnected == this.isConnected &&
          other.temperature == this.temperature &&
          other.osName == this.osName &&
          other.deviceName == this.deviceName &&
          other.batteryLevel == this.batteryLevel &&
          other.batteryStatus == this.batteryStatus &&
          other.computerName == this.computerName &&
          other.cpuCores == this.cpuCores &&
          other.totalRam == this.totalRam &&
          other.userName == this.userName &&
          other.osBuild == this.osBuild &&
          other.buildNumber == this.buildNumber &&
          other.kernel == this.kernel &&
          other.platformId == this.platformId &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.camera == this.camera &&
          other.mic == this.mic &&
          other.speaker == this.speaker &&
          other.city == this.city &&
          other.region == this.region &&
          other.country == this.country &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude &&
          other.appUsageData == this.appUsageData &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SystemStatsCompanion extends UpdateCompanion<SystemStat> {
  final Value<int> id;
  final Value<int> cpuUsage;
  final Value<int> ramUsage;
  final Value<int> diskUsage;
  final Value<String> cpuName;
  final Value<String> gpuName;
  final Value<double> downloadSpeed;
  final Value<double> uploadSpeed;
  final Value<bool> isConnected;
  final Value<double> temperature;
  final Value<String> osName;
  final Value<String> deviceName;
  final Value<String> batteryLevel;
  final Value<String> batteryStatus;
  final Value<String> computerName;
  final Value<int> cpuCores;
  final Value<String> totalRam;
  final Value<String> userName;
  final Value<String> osBuild;
  final Value<String> buildNumber;
  final Value<String> kernel;
  final Value<String> platformId;
  final Value<String> manufacturer;
  final Value<String> model;
  final Value<bool> camera;
  final Value<bool> mic;
  final Value<bool> speaker;
  final Value<String> city;
  final Value<String> region;
  final Value<String> country;
  final Value<double> longitude;
  final Value<double> latitude;
  final Value<String> appUsageData;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SystemStatsCompanion({
    this.id = const Value.absent(),
    this.cpuUsage = const Value.absent(),
    this.ramUsage = const Value.absent(),
    this.diskUsage = const Value.absent(),
    this.cpuName = const Value.absent(),
    this.gpuName = const Value.absent(),
    this.downloadSpeed = const Value.absent(),
    this.uploadSpeed = const Value.absent(),
    this.isConnected = const Value.absent(),
    this.temperature = const Value.absent(),
    this.osName = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.batteryStatus = const Value.absent(),
    this.computerName = const Value.absent(),
    this.cpuCores = const Value.absent(),
    this.totalRam = const Value.absent(),
    this.userName = const Value.absent(),
    this.osBuild = const Value.absent(),
    this.buildNumber = const Value.absent(),
    this.kernel = const Value.absent(),
    this.platformId = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.camera = const Value.absent(),
    this.mic = const Value.absent(),
    this.speaker = const Value.absent(),
    this.city = const Value.absent(),
    this.region = const Value.absent(),
    this.country = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.appUsageData = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SystemStatsCompanion.insert({
    this.id = const Value.absent(),
    required int cpuUsage,
    required int ramUsage,
    required int diskUsage,
    required String cpuName,
    required String gpuName,
    required double downloadSpeed,
    required double uploadSpeed,
    required bool isConnected,
    required double temperature,
    required String osName,
    required String deviceName,
    required String batteryLevel,
    required String batteryStatus,
    required String computerName,
    required int cpuCores,
    required String totalRam,
    required String userName,
    required String osBuild,
    required String buildNumber,
    required String kernel,
    required String platformId,
    required String manufacturer,
    required String model,
    required bool camera,
    required bool mic,
    required bool speaker,
    required String city,
    required String region,
    required String country,
    required double longitude,
    required double latitude,
    required String appUsageData,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : cpuUsage = Value(cpuUsage),
        ramUsage = Value(ramUsage),
        diskUsage = Value(diskUsage),
        cpuName = Value(cpuName),
        gpuName = Value(gpuName),
        downloadSpeed = Value(downloadSpeed),
        uploadSpeed = Value(uploadSpeed),
        isConnected = Value(isConnected),
        temperature = Value(temperature),
        osName = Value(osName),
        deviceName = Value(deviceName),
        batteryLevel = Value(batteryLevel),
        batteryStatus = Value(batteryStatus),
        computerName = Value(computerName),
        cpuCores = Value(cpuCores),
        totalRam = Value(totalRam),
        userName = Value(userName),
        osBuild = Value(osBuild),
        buildNumber = Value(buildNumber),
        kernel = Value(kernel),
        platformId = Value(platformId),
        manufacturer = Value(manufacturer),
        model = Value(model),
        camera = Value(camera),
        mic = Value(mic),
        speaker = Value(speaker),
        city = Value(city),
        region = Value(region),
        country = Value(country),
        longitude = Value(longitude),
        latitude = Value(latitude),
        appUsageData = Value(appUsageData),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SystemStat> custom({
    Expression<int>? id,
    Expression<int>? cpuUsage,
    Expression<int>? ramUsage,
    Expression<int>? diskUsage,
    Expression<String>? cpuName,
    Expression<String>? gpuName,
    Expression<double>? downloadSpeed,
    Expression<double>? uploadSpeed,
    Expression<bool>? isConnected,
    Expression<double>? temperature,
    Expression<String>? osName,
    Expression<String>? deviceName,
    Expression<String>? batteryLevel,
    Expression<String>? batteryStatus,
    Expression<String>? computerName,
    Expression<int>? cpuCores,
    Expression<String>? totalRam,
    Expression<String>? userName,
    Expression<String>? osBuild,
    Expression<String>? buildNumber,
    Expression<String>? kernel,
    Expression<String>? platformId,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<bool>? camera,
    Expression<bool>? mic,
    Expression<bool>? speaker,
    Expression<String>? city,
    Expression<String>? region,
    Expression<String>? country,
    Expression<double>? longitude,
    Expression<double>? latitude,
    Expression<String>? appUsageData,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cpuUsage != null) 'cpu_usage': cpuUsage,
      if (ramUsage != null) 'ram_usage': ramUsage,
      if (diskUsage != null) 'disk_usage': diskUsage,
      if (cpuName != null) 'cpu_name': cpuName,
      if (gpuName != null) 'gpu_name': gpuName,
      if (downloadSpeed != null) 'download_speed': downloadSpeed,
      if (uploadSpeed != null) 'upload_speed': uploadSpeed,
      if (isConnected != null) 'is_connected': isConnected,
      if (temperature != null) 'temperature': temperature,
      if (osName != null) 'os_name': osName,
      if (deviceName != null) 'device_name': deviceName,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (batteryStatus != null) 'battery_status': batteryStatus,
      if (computerName != null) 'computer_name': computerName,
      if (cpuCores != null) 'cpu_cores': cpuCores,
      if (totalRam != null) 'total_ram': totalRam,
      if (userName != null) 'user_name': userName,
      if (osBuild != null) 'os_build': osBuild,
      if (buildNumber != null) 'build_number': buildNumber,
      if (kernel != null) 'kernel': kernel,
      if (platformId != null) 'platform_id': platformId,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (camera != null) 'camera': camera,
      if (mic != null) 'mic': mic,
      if (speaker != null) 'speaker': speaker,
      if (city != null) 'city': city,
      if (region != null) 'region': region,
      if (country != null) 'country': country,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (appUsageData != null) 'app_usage_data': appUsageData,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SystemStatsCompanion copyWith(
      {Value<int>? id,
      Value<int>? cpuUsage,
      Value<int>? ramUsage,
      Value<int>? diskUsage,
      Value<String>? cpuName,
      Value<String>? gpuName,
      Value<double>? downloadSpeed,
      Value<double>? uploadSpeed,
      Value<bool>? isConnected,
      Value<double>? temperature,
      Value<String>? osName,
      Value<String>? deviceName,
      Value<String>? batteryLevel,
      Value<String>? batteryStatus,
      Value<String>? computerName,
      Value<int>? cpuCores,
      Value<String>? totalRam,
      Value<String>? userName,
      Value<String>? osBuild,
      Value<String>? buildNumber,
      Value<String>? kernel,
      Value<String>? platformId,
      Value<String>? manufacturer,
      Value<String>? model,
      Value<bool>? camera,
      Value<bool>? mic,
      Value<bool>? speaker,
      Value<String>? city,
      Value<String>? region,
      Value<String>? country,
      Value<double>? longitude,
      Value<double>? latitude,
      Value<String>? appUsageData,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SystemStatsCompanion(
      id: id ?? this.id,
      cpuUsage: cpuUsage ?? this.cpuUsage,
      ramUsage: ramUsage ?? this.ramUsage,
      diskUsage: diskUsage ?? this.diskUsage,
      cpuName: cpuName ?? this.cpuName,
      gpuName: gpuName ?? this.gpuName,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      isConnected: isConnected ?? this.isConnected,
      temperature: temperature ?? this.temperature,
      osName: osName ?? this.osName,
      deviceName: deviceName ?? this.deviceName,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      batteryStatus: batteryStatus ?? this.batteryStatus,
      computerName: computerName ?? this.computerName,
      cpuCores: cpuCores ?? this.cpuCores,
      totalRam: totalRam ?? this.totalRam,
      userName: userName ?? this.userName,
      osBuild: osBuild ?? this.osBuild,
      buildNumber: buildNumber ?? this.buildNumber,
      kernel: kernel ?? this.kernel,
      platformId: platformId ?? this.platformId,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      camera: camera ?? this.camera,
      mic: mic ?? this.mic,
      speaker: speaker ?? this.speaker,
      city: city ?? this.city,
      region: region ?? this.region,
      country: country ?? this.country,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      appUsageData: appUsageData ?? this.appUsageData,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cpuUsage.present) {
      map['cpu_usage'] = Variable<int>(cpuUsage.value);
    }
    if (ramUsage.present) {
      map['ram_usage'] = Variable<int>(ramUsage.value);
    }
    if (diskUsage.present) {
      map['disk_usage'] = Variable<int>(diskUsage.value);
    }
    if (cpuName.present) {
      map['cpu_name'] = Variable<String>(cpuName.value);
    }
    if (gpuName.present) {
      map['gpu_name'] = Variable<String>(gpuName.value);
    }
    if (downloadSpeed.present) {
      map['download_speed'] = Variable<double>(downloadSpeed.value);
    }
    if (uploadSpeed.present) {
      map['upload_speed'] = Variable<double>(uploadSpeed.value);
    }
    if (isConnected.present) {
      map['is_connected'] = Variable<bool>(isConnected.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (osName.present) {
      map['os_name'] = Variable<String>(osName.value);
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<String>(batteryLevel.value);
    }
    if (batteryStatus.present) {
      map['battery_status'] = Variable<String>(batteryStatus.value);
    }
    if (computerName.present) {
      map['computer_name'] = Variable<String>(computerName.value);
    }
    if (cpuCores.present) {
      map['cpu_cores'] = Variable<int>(cpuCores.value);
    }
    if (totalRam.present) {
      map['total_ram'] = Variable<String>(totalRam.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (osBuild.present) {
      map['os_build'] = Variable<String>(osBuild.value);
    }
    if (buildNumber.present) {
      map['build_number'] = Variable<String>(buildNumber.value);
    }
    if (kernel.present) {
      map['kernel'] = Variable<String>(kernel.value);
    }
    if (platformId.present) {
      map['platform_id'] = Variable<String>(platformId.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (camera.present) {
      map['camera'] = Variable<bool>(camera.value);
    }
    if (mic.present) {
      map['mic'] = Variable<bool>(mic.value);
    }
    if (speaker.present) {
      map['speaker'] = Variable<bool>(speaker.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (appUsageData.present) {
      map['app_usage_data'] = Variable<String>(appUsageData.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SystemStatsCompanion(')
          ..write('id: $id, ')
          ..write('cpuUsage: $cpuUsage, ')
          ..write('ramUsage: $ramUsage, ')
          ..write('diskUsage: $diskUsage, ')
          ..write('cpuName: $cpuName, ')
          ..write('gpuName: $gpuName, ')
          ..write('downloadSpeed: $downloadSpeed, ')
          ..write('uploadSpeed: $uploadSpeed, ')
          ..write('isConnected: $isConnected, ')
          ..write('temperature: $temperature, ')
          ..write('osName: $osName, ')
          ..write('deviceName: $deviceName, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('batteryStatus: $batteryStatus, ')
          ..write('computerName: $computerName, ')
          ..write('cpuCores: $cpuCores, ')
          ..write('totalRam: $totalRam, ')
          ..write('userName: $userName, ')
          ..write('osBuild: $osBuild, ')
          ..write('buildNumber: $buildNumber, ')
          ..write('kernel: $kernel, ')
          ..write('platformId: $platformId, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('camera: $camera, ')
          ..write('mic: $mic, ')
          ..write('speaker: $speaker, ')
          ..write('city: $city, ')
          ..write('region: $region, ')
          ..write('country: $country, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('appUsageData: $appUsageData, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SystemStatsTable systemStats = $SystemStatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [systemStats];
}

typedef $$SystemStatsTableCreateCompanionBuilder = SystemStatsCompanion
    Function({
  Value<int> id,
  required int cpuUsage,
  required int ramUsage,
  required int diskUsage,
  required String cpuName,
  required String gpuName,
  required double downloadSpeed,
  required double uploadSpeed,
  required bool isConnected,
  required double temperature,
  required String osName,
  required String deviceName,
  required String batteryLevel,
  required String batteryStatus,
  required String computerName,
  required int cpuCores,
  required String totalRam,
  required String userName,
  required String osBuild,
  required String buildNumber,
  required String kernel,
  required String platformId,
  required String manufacturer,
  required String model,
  required bool camera,
  required bool mic,
  required bool speaker,
  required String city,
  required String region,
  required String country,
  required double longitude,
  required double latitude,
  required String appUsageData,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$SystemStatsTableUpdateCompanionBuilder = SystemStatsCompanion
    Function({
  Value<int> id,
  Value<int> cpuUsage,
  Value<int> ramUsage,
  Value<int> diskUsage,
  Value<String> cpuName,
  Value<String> gpuName,
  Value<double> downloadSpeed,
  Value<double> uploadSpeed,
  Value<bool> isConnected,
  Value<double> temperature,
  Value<String> osName,
  Value<String> deviceName,
  Value<String> batteryLevel,
  Value<String> batteryStatus,
  Value<String> computerName,
  Value<int> cpuCores,
  Value<String> totalRam,
  Value<String> userName,
  Value<String> osBuild,
  Value<String> buildNumber,
  Value<String> kernel,
  Value<String> platformId,
  Value<String> manufacturer,
  Value<String> model,
  Value<bool> camera,
  Value<bool> mic,
  Value<bool> speaker,
  Value<String> city,
  Value<String> region,
  Value<String> country,
  Value<double> longitude,
  Value<double> latitude,
  Value<String> appUsageData,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$SystemStatsTableFilterComposer
    extends Composer<_$AppDatabase, $SystemStatsTable> {
  $$SystemStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cpuUsage => $composableBuilder(
      column: $table.cpuUsage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ramUsage => $composableBuilder(
      column: $table.ramUsage, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diskUsage => $composableBuilder(
      column: $table.diskUsage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpuName => $composableBuilder(
      column: $table.cpuName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gpuName => $composableBuilder(
      column: $table.gpuName, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get downloadSpeed => $composableBuilder(
      column: $table.downloadSpeed, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get uploadSpeed => $composableBuilder(
      column: $table.uploadSpeed, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isConnected => $composableBuilder(
      column: $table.isConnected, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get osName => $composableBuilder(
      column: $table.osName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceName => $composableBuilder(
      column: $table.deviceName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get batteryLevel => $composableBuilder(
      column: $table.batteryLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get batteryStatus => $composableBuilder(
      column: $table.batteryStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get computerName => $composableBuilder(
      column: $table.computerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cpuCores => $composableBuilder(
      column: $table.cpuCores, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get totalRam => $composableBuilder(
      column: $table.totalRam, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get osBuild => $composableBuilder(
      column: $table.osBuild, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get buildNumber => $composableBuilder(
      column: $table.buildNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kernel => $composableBuilder(
      column: $table.kernel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get platformId => $composableBuilder(
      column: $table.platformId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get camera => $composableBuilder(
      column: $table.camera, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get mic => $composableBuilder(
      column: $table.mic, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get speaker => $composableBuilder(
      column: $table.speaker, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appUsageData => $composableBuilder(
      column: $table.appUsageData, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SystemStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $SystemStatsTable> {
  $$SystemStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cpuUsage => $composableBuilder(
      column: $table.cpuUsage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ramUsage => $composableBuilder(
      column: $table.ramUsage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diskUsage => $composableBuilder(
      column: $table.diskUsage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpuName => $composableBuilder(
      column: $table.cpuName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gpuName => $composableBuilder(
      column: $table.gpuName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get downloadSpeed => $composableBuilder(
      column: $table.downloadSpeed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get uploadSpeed => $composableBuilder(
      column: $table.uploadSpeed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isConnected => $composableBuilder(
      column: $table.isConnected, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get osName => $composableBuilder(
      column: $table.osName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceName => $composableBuilder(
      column: $table.deviceName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get batteryLevel => $composableBuilder(
      column: $table.batteryLevel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get batteryStatus => $composableBuilder(
      column: $table.batteryStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get computerName => $composableBuilder(
      column: $table.computerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cpuCores => $composableBuilder(
      column: $table.cpuCores, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totalRam => $composableBuilder(
      column: $table.totalRam, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get osBuild => $composableBuilder(
      column: $table.osBuild, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get buildNumber => $composableBuilder(
      column: $table.buildNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kernel => $composableBuilder(
      column: $table.kernel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platformId => $composableBuilder(
      column: $table.platformId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get camera => $composableBuilder(
      column: $table.camera, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get mic => $composableBuilder(
      column: $table.mic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get speaker => $composableBuilder(
      column: $table.speaker, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appUsageData => $composableBuilder(
      column: $table.appUsageData,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SystemStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SystemStatsTable> {
  $$SystemStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cpuUsage =>
      $composableBuilder(column: $table.cpuUsage, builder: (column) => column);

  GeneratedColumn<int> get ramUsage =>
      $composableBuilder(column: $table.ramUsage, builder: (column) => column);

  GeneratedColumn<int> get diskUsage =>
      $composableBuilder(column: $table.diskUsage, builder: (column) => column);

  GeneratedColumn<String> get cpuName =>
      $composableBuilder(column: $table.cpuName, builder: (column) => column);

  GeneratedColumn<String> get gpuName =>
      $composableBuilder(column: $table.gpuName, builder: (column) => column);

  GeneratedColumn<double> get downloadSpeed => $composableBuilder(
      column: $table.downloadSpeed, builder: (column) => column);

  GeneratedColumn<double> get uploadSpeed => $composableBuilder(
      column: $table.uploadSpeed, builder: (column) => column);

  GeneratedColumn<bool> get isConnected => $composableBuilder(
      column: $table.isConnected, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => column);

  GeneratedColumn<String> get osName =>
      $composableBuilder(column: $table.osName, builder: (column) => column);

  GeneratedColumn<String> get deviceName => $composableBuilder(
      column: $table.deviceName, builder: (column) => column);

  GeneratedColumn<String> get batteryLevel => $composableBuilder(
      column: $table.batteryLevel, builder: (column) => column);

  GeneratedColumn<String> get batteryStatus => $composableBuilder(
      column: $table.batteryStatus, builder: (column) => column);

  GeneratedColumn<String> get computerName => $composableBuilder(
      column: $table.computerName, builder: (column) => column);

  GeneratedColumn<int> get cpuCores =>
      $composableBuilder(column: $table.cpuCores, builder: (column) => column);

  GeneratedColumn<String> get totalRam =>
      $composableBuilder(column: $table.totalRam, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get osBuild =>
      $composableBuilder(column: $table.osBuild, builder: (column) => column);

  GeneratedColumn<String> get buildNumber => $composableBuilder(
      column: $table.buildNumber, builder: (column) => column);

  GeneratedColumn<String> get kernel =>
      $composableBuilder(column: $table.kernel, builder: (column) => column);

  GeneratedColumn<String> get platformId => $composableBuilder(
      column: $table.platformId, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<bool> get camera =>
      $composableBuilder(column: $table.camera, builder: (column) => column);

  GeneratedColumn<bool> get mic =>
      $composableBuilder(column: $table.mic, builder: (column) => column);

  GeneratedColumn<bool> get speaker =>
      $composableBuilder(column: $table.speaker, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<String> get appUsageData => $composableBuilder(
      column: $table.appUsageData, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SystemStatsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SystemStatsTable,
    SystemStat,
    $$SystemStatsTableFilterComposer,
    $$SystemStatsTableOrderingComposer,
    $$SystemStatsTableAnnotationComposer,
    $$SystemStatsTableCreateCompanionBuilder,
    $$SystemStatsTableUpdateCompanionBuilder,
    (SystemStat, BaseReferences<_$AppDatabase, $SystemStatsTable, SystemStat>),
    SystemStat,
    PrefetchHooks Function()> {
  $$SystemStatsTableTableManager(_$AppDatabase db, $SystemStatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SystemStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SystemStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SystemStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> cpuUsage = const Value.absent(),
            Value<int> ramUsage = const Value.absent(),
            Value<int> diskUsage = const Value.absent(),
            Value<String> cpuName = const Value.absent(),
            Value<String> gpuName = const Value.absent(),
            Value<double> downloadSpeed = const Value.absent(),
            Value<double> uploadSpeed = const Value.absent(),
            Value<bool> isConnected = const Value.absent(),
            Value<double> temperature = const Value.absent(),
            Value<String> osName = const Value.absent(),
            Value<String> deviceName = const Value.absent(),
            Value<String> batteryLevel = const Value.absent(),
            Value<String> batteryStatus = const Value.absent(),
            Value<String> computerName = const Value.absent(),
            Value<int> cpuCores = const Value.absent(),
            Value<String> totalRam = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<String> osBuild = const Value.absent(),
            Value<String> buildNumber = const Value.absent(),
            Value<String> kernel = const Value.absent(),
            Value<String> platformId = const Value.absent(),
            Value<String> manufacturer = const Value.absent(),
            Value<String> model = const Value.absent(),
            Value<bool> camera = const Value.absent(),
            Value<bool> mic = const Value.absent(),
            Value<bool> speaker = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> region = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<String> appUsageData = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SystemStatsCompanion(
            id: id,
            cpuUsage: cpuUsage,
            ramUsage: ramUsage,
            diskUsage: diskUsage,
            cpuName: cpuName,
            gpuName: gpuName,
            downloadSpeed: downloadSpeed,
            uploadSpeed: uploadSpeed,
            isConnected: isConnected,
            temperature: temperature,
            osName: osName,
            deviceName: deviceName,
            batteryLevel: batteryLevel,
            batteryStatus: batteryStatus,
            computerName: computerName,
            cpuCores: cpuCores,
            totalRam: totalRam,
            userName: userName,
            osBuild: osBuild,
            buildNumber: buildNumber,
            kernel: kernel,
            platformId: platformId,
            manufacturer: manufacturer,
            model: model,
            camera: camera,
            mic: mic,
            speaker: speaker,
            city: city,
            region: region,
            country: country,
            longitude: longitude,
            latitude: latitude,
            appUsageData: appUsageData,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int cpuUsage,
            required int ramUsage,
            required int diskUsage,
            required String cpuName,
            required String gpuName,
            required double downloadSpeed,
            required double uploadSpeed,
            required bool isConnected,
            required double temperature,
            required String osName,
            required String deviceName,
            required String batteryLevel,
            required String batteryStatus,
            required String computerName,
            required int cpuCores,
            required String totalRam,
            required String userName,
            required String osBuild,
            required String buildNumber,
            required String kernel,
            required String platformId,
            required String manufacturer,
            required String model,
            required bool camera,
            required bool mic,
            required bool speaker,
            required String city,
            required String region,
            required String country,
            required double longitude,
            required double latitude,
            required String appUsageData,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              SystemStatsCompanion.insert(
            id: id,
            cpuUsage: cpuUsage,
            ramUsage: ramUsage,
            diskUsage: diskUsage,
            cpuName: cpuName,
            gpuName: gpuName,
            downloadSpeed: downloadSpeed,
            uploadSpeed: uploadSpeed,
            isConnected: isConnected,
            temperature: temperature,
            osName: osName,
            deviceName: deviceName,
            batteryLevel: batteryLevel,
            batteryStatus: batteryStatus,
            computerName: computerName,
            cpuCores: cpuCores,
            totalRam: totalRam,
            userName: userName,
            osBuild: osBuild,
            buildNumber: buildNumber,
            kernel: kernel,
            platformId: platformId,
            manufacturer: manufacturer,
            model: model,
            camera: camera,
            mic: mic,
            speaker: speaker,
            city: city,
            region: region,
            country: country,
            longitude: longitude,
            latitude: latitude,
            appUsageData: appUsageData,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SystemStatsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SystemStatsTable,
    SystemStat,
    $$SystemStatsTableFilterComposer,
    $$SystemStatsTableOrderingComposer,
    $$SystemStatsTableAnnotationComposer,
    $$SystemStatsTableCreateCompanionBuilder,
    $$SystemStatsTableUpdateCompanionBuilder,
    (SystemStat, BaseReferences<_$AppDatabase, $SystemStatsTable, SystemStat>),
    SystemStat,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SystemStatsTableTableManager get systemStats =>
      $$SystemStatsTableTableManager(_db, _db.systemStats);
}
