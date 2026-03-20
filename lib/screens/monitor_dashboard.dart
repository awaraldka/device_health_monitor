import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/system_status.dart';
import '../services/system_monitor_service.dart';
import '../widgets/metric_card.dart';

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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    _controller.repeat();

    await _monitorService.refreshNow();

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
        title: const Text('Monitoring'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _isRefreshing ? null : _handleRefresh,
            icon: RotationTransition(
              turns: _controller,
              child: const Icon(Icons.refresh),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => SystemMonitorService().clickLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: StreamBuilder<SystemStatus>(
        stream: _monitorService.getStatusStream(),
        builder: (context, snapshot) {
          final status =
              snapshot.data ?? _monitorService.cachedStatus;

          if (status == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Safe parsing of battery level
          final int battery = int.tryParse(status.batteryLevel.replaceAll('%', '')) ?? 0;

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(status),
                  const SizedBox(height: 24),

                  /// 📊 Metrics Grid
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
                        color: status.cpuUsage > 80 ? Colors.red : Colors.blue,
                      ),
                      MetricCard(
                        title: 'RAM Usage',
                        value: '${status.ramUsage}%',
                        percentage: status.ramUsage / 100,
                        icon: Icons.memory,
                        color:
                        status.ramUsage > 80 ? Colors.red : Colors.orange,
                      ),

                      MetricCard(
                        title: 'Battery',
                        value: battery > 0 ? status.batteryLevel : 'Desktop',
                        percentage: battery > 0 ? battery / 100 : 1.0,
                        icon: battery > 0
                            ? (battery > 20 ? Icons.battery_full : Icons.battery_alert)
                            : Icons.power,
                        color: battery > 0
                            ? (battery > 20 ? Colors.green : Colors.red)
                            : Colors.blue,
                      ),
                      MetricCard(
                        title: 'Download',
                        value:
                        '${status.downloadSpeed.toStringAsFixed(1)} Mbps',
                        percentage: status.downloadSpeed / 100,
                        icon: Icons.download_sharp,
                        color: Colors.purple,
                      ),
                      MetricCard(
                        title: 'Upload',
                        value:
                        '${status.uploadSpeed.toStringAsFixed(1)} Mbps',
                        percentage: status.uploadSpeed / 100,
                        icon: Icons.upload_sharp,
                        color: Colors.teal,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildChartSection('CPU Usage History', status),
                            const SizedBox(height: 16),
                            _buildAdditionalInfo(status),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            _buildHardwareDetails(status),
                            const SizedBox(height: 16),
                            _buildLocationInfo(status),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            _buildAppUsage(status),
                            const SizedBox(height: 16)
                          ],
                        ),
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




}
