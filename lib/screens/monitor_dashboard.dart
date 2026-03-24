import 'dart:async';

import 'package:device_health_monitor/services/database_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/system_status.dart';
import '../services/system_monitor_service.dart';
import '../widgets/metric_card.dart';

enum SpeedTestPhase {
  idle,
  download,
  upload,
  done,
}

class MonitorDashboard extends StatefulWidget {
  const MonitorDashboard({super.key});

  @override
  State<MonitorDashboard> createState() => _MonitorDashboardState();
}

class _MonitorDashboardState extends State<MonitorDashboard>
    with TickerProviderStateMixin {
  final SystemMonitorService _monitorService = SystemMonitorService();

  late AnimationController _controller;
  bool _isRefreshing = false;


  final DatabaseService _databaseService = DatabaseService();

  bool _isInitialDataSaved = false;

  List<double> downloadSamples = [];
  List<double> uploadSamples = [];

  double avgDownload = 0;
  double avgUpload = 0;

  double downloadSpeed = 0;
  double uploadSpeed = 0;

  double? lastDownload;
  double? lastUpload;

  SpeedTestPhase phase = SpeedTestPhase.idle;

  DateTime? phaseStartTime;
  Timer? _timer;

  static const downloadDuration = Duration(seconds: 20);
  static const uploadDuration = Duration(seconds: 20);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );


    _initializeDashboard();
  }

  Future<void> _initializeDashboard() async {
    // await _databaseService.deleteAllSystemStats();

    // Start speed test
    _monitorService.resetSpeedTest();
    startSpeedTest();

    // Wait for first monitor service status to be available
    await Future.delayed(const Duration(seconds: 1));
    final status = _monitorService.cachedStatus;
    if (status != null && !_isInitialDataSaved) {
      await _databaseService.insertSystemStatus(status);
      _isInitialDataSaved = true;
      debugPrint("Initial system status saved to database.");
    }

    // Now it's safe to print
    await _databaseService.printSize();
    await _databaseService.printLatestRecord();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  /// 🚀 START SPEED TEST TIMER
  void startSpeedTest() {
    phase = SpeedTestPhase.download;
    phaseStartTime = DateTime.now();

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final now = DateTime.now();
      final elapsed = now.difference(phaseStartTime!);

      if (phase == SpeedTestPhase.download) {
        if (elapsed >= downloadDuration) {
          phase = SpeedTestPhase.upload;
          phaseStartTime = DateTime.now();
        }
      } else if (phase == SpeedTestPhase.upload) {
        if (elapsed >= uploadDuration) {
          phase = SpeedTestPhase.done;

          avgDownload = calculateAverage(downloadSamples);
          avgUpload = calculateAverage(uploadSamples);

          debugPrint('Average Download: $avgDownload Mbps');
          debugPrint('Average Upload: $avgUpload Mbps');

          // Update the database with the final speeds
          _databaseService.updateLatestSpeed(avgDownload, avgUpload);

          timer.cancel();
        }
      }

      if (mounted) setState(() {});
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
      avgDownload = 0;
      avgUpload = 0;
      downloadSpeed = 0;
      uploadSpeed = 0;
    });

    _controller.repeat();

    // Reset everything
    downloadSamples.clear();
    uploadSamples.clear();
    lastDownload = null;
    lastUpload = null;
    avgDownload = 0;
    avgUpload = 0;

    startSpeedTest();

    await _monitorService.refreshNow();

    // Save data after refresh
    final status = _monitorService.cachedStatus;
    if (status != null) {
      await _databaseService.insertSystemStatus(status);
    }

    _controller.stop();
    _controller.reset();

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data refreshed"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        leadingWidth: 100,
        leading: IconButton(
          onPressed: (_isRefreshing || avgDownload == 0 || avgUpload == 0)
              ? null
              : () {
                  Navigator.pop(context);
                },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Monitoring'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _isRefreshing || avgDownload == 0 || avgUpload == 0
                ? null
                : _handleRefresh,
            icon: RotationTransition(
              turns: _controller,
              child: const Icon(Icons.refresh),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: avgDownload == 0 || avgUpload == 0
                ? null
                : () => {

              _monitorService.resetSession(),
                      SystemMonitorService().clickLogout(context)
                    },
          ),
        ],
      ),
      body: StreamBuilder<SystemStatus>(
        stream: _monitorService.getStatusStream(),
        builder: (context, snapshot) {
          final status = snapshot.data ?? _monitorService.cachedStatus;

          if (status == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!_isInitialDataSaved) {
            _isInitialDataSaved = true;
            _databaseService.insertSystemStatus(status);
          }

          /// ✅ Collect samples ONLY (no timing logic here)
          if (phase == SpeedTestPhase.download) {
            if (status.downloadSpeed > 0 &&
                (lastDownload == null ||
                    lastDownload != status.downloadSpeed)) {
              downloadSpeed = status.downloadSpeed;
              downloadSamples.add(status.downloadSpeed);
              lastDownload = status.downloadSpeed;
            }
          }

          if (phase == SpeedTestPhase.upload) {
            if (status.uploadSpeed > 0 &&
                (lastUpload == null || lastUpload != status.uploadSpeed)) {
              uploadSpeed = status.uploadSpeed;
              uploadSamples.add(status.uploadSpeed);
              lastUpload = status.uploadSpeed;
            }
          }

          final int battery =
              int.tryParse(status.batteryLevel.replaceAll('%', '')) ?? 0;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(status),
                  const SizedBox(height: 24),

                  /// GRID
                  GridView.count(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 1200 ? 5 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      MetricCard(
                        title: 'CPU Usage',
                        value: '${status.cpuUsage}%',
                        percentage: status.cpuUsage / 100,
                        icon: Icons.developer_board,
                        color: Colors.blue,
                      ),
                      MetricCard(
                        title: 'RAM Usage',
                        value: '${status.ramUsage}%',
                        percentage: status.ramUsage / 100,
                        icon: Icons.memory,
                        color: Colors.orange,
                      ),
                      MetricCard(
                        title: 'Battery',
                        value: battery > 0 ? status.batteryLevel : 'Desktop',
                        percentage: battery > 0 ? battery / 100 : 1,
                        icon: Icons.battery_full,
                        color: Colors.green,
                      ),
                      MetricCard(
                        title: 'Download',
                        value: phase == SpeedTestPhase.done
                            ? '${avgDownload.toStringAsFixed(1)} Mbps'
                            : '${downloadSpeed.toStringAsFixed(1)} Mbps',
                        percentage: status.downloadSpeed / 100,
                        icon: Icons.download,
                        color: Colors.purple,
                      ),
                      MetricCard(
                        title: 'Upload',
                        value: phase == SpeedTestPhase.done
                            ? '${avgUpload.toStringAsFixed(1)} Mbps'
                            : '${uploadSpeed.toStringAsFixed(1)} Mbps',
                        percentage: status.uploadSpeed / 100,
                        icon: Icons.upload,
                        color: Colors.teal,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// MAIN ROW (FIXED OVERFLOW)
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            _buildChartSection('CPU Usage History', status),
                            const SizedBox(height: 16),
                            _buildAdditionalInfo(status),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            _buildHardwareDetails(status),
                            const SizedBox(height: 16),
                            _buildLocationInfo(status),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: _buildAppUsage(status),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(SystemStatus status) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Dashboard',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900,
                  ),
            ),
            Text(
              'Metrics for ${status.deviceName}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.indigo.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, color: Colors.indigo, size: 20),
                  const SizedBox(width: 8),
                  ValueListenableBuilder<String>(
                    valueListenable: _monitorService.formattedSessionTime,
                    builder: (context, time, _) {
                      return Text(
                        time,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: status.isConnected
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: status.isConnected ? Colors.green : Colors.red,
            ),
          ),
          child: Row(
            children: [
              Icon(
                status.isConnected ? Icons.wifi : Icons.wifi_off,
                size: 20,
                color: status.isConnected ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                status.isConnected ? 'CONNECTED' : 'DISCONNECTED',
                style: TextStyle(
                  color: status.isConnected ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection(String title, SystemStatus status) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: status.cpuUsageHistory.asMap().entries.map((e) {
                        return FlSpot(
                          e.key.toDouble(),
                          e.value.toDouble(),
                        );
                      }).toList(),
                      isCurved: true,
                      color: Colors.indigo,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.indigo.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHardwareDetails(SystemStatus status) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hardware Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            _infoRow(Icons.laptop, 'OS', status.osName),
            _infoRow(Icons.developer_board, 'CPU', status.cpuName),
            _infoRow(Icons.videogame_asset, 'GPU', status.gpuName),
            _infoRow(Icons.storage, 'Disk',
                '${status.diskUsage.toStringAsFixed(1)}% Used'),
            _infoRow(Icons.thermostat, 'Temp',
                '${status.temperature.toStringAsFixed(1)}°C'),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalInfo(SystemStatus status) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('System Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            ...status.additionalInfo.entries
                .map((e) => _infoRow(Icons.info_outline, e.key, e.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationInfo(SystemStatus status) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Additional Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            ...status.locationInfo.entries
                .map((e) => _infoRow(Icons.info_outline, e.key, e.value))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.indigo),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 13),
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppUsage(SystemStatus status) {
    if (status.appData.isEmpty) {
      return const Text("No App Usage Data");
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            ...status.appData.map((app) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.apps, color: Colors.indigo, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// App Name
                          Text(
                            app.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 4),

                          /// From → Till
                          Text(
                            "${app.from} → ${app.till}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),

                          /// Duration
                          Text(
                            "⏱ ${app.duration}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  double calculateAverage(List<double> samples) {
    if (samples.isEmpty) {
      return 0;
    }
    final sum = samples.reduce((a, b) => a + b);
    final avg = sum / samples.length;
    return avg;
  }
}
