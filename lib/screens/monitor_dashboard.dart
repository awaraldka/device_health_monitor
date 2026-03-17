import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/system_monitor_service.dart';
import '../models/system_status.dart';
import '../widgets/metric_card.dart';

class MonitorDashboard extends StatefulWidget {
  const MonitorDashboard({super.key});

  @override
  State<MonitorDashboard> createState() => _MonitorDashboardState();
}

class _MonitorDashboardState extends State<MonitorDashboard> {
  final SystemMonitorService _monitorService = SystemMonitorService();
  final List<double> cpuHistory = List.generate(20, (_) => 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Real-time Monitoring'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<SystemStatus>(
        stream: _monitorService.getStatusStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final status = snapshot.data!;
          cpuHistory.add(status.cpuUsage);
          if (cpuHistory.length > 20) cpuHistory.removeAt(0);

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(status),
                  const SizedBox(height: 24),
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 5 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      MetricCard(
                        title: 'CPU Usage',
                        value: '${status.cpuUsage.toStringAsFixed(1)}%',
                        percentage: status.cpuUsage / 100,
                        icon: Icons.developer_board,
                        color: status.cpuUsage > 80 ? Colors.red : Colors.blue,
                      ),
                      MetricCard(
                        title: 'RAM Usage',
                        value: '${status.ramUsage.toStringAsFixed(1)}%',
                        percentage: status.ramUsage / 100,
                        icon: Icons.memory,
                        color: status.ramUsage > 80 ? Colors.red : Colors.orange,
                      ),
                      MetricCard(
                        title: 'Battery',
                        value: '${status.batteryLevel}%',
                        percentage: status.batteryLevel / 100,
                        icon: status.batteryLevel > 20 ? Icons.battery_full : Icons.battery_alert,
                        color: status.batteryLevel > 20 ? Colors.green : Colors.red,
                      ),
                      MetricCard(
                        title: 'Download',
                        value: '${status.downloadSpeed.toStringAsFixed(1)} Mbps',
                        percentage: status.downloadSpeed / 100,
                        icon: Icons.download_sharp,
                        color: Colors.purple,
                      ),
                      MetricCard(
                        title: 'Upload',
                        value: '${status.uploadSpeed.toStringAsFixed(1)} Mbps',
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
                        child: _buildChartSection('CPU Usage History'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            _buildHardwareDetails(status),
                            const SizedBox(height: 16),
                            _buildAdditionalInfo(status),
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
              'Real-time metrics for ${status.deviceName}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: status.isConnected ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
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

  Widget _buildChartSection(String title) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                      spots: cpuHistory.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value);
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
            const Text('Hardware Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            _infoRow(Icons.laptop, 'OS', status.osName),
            _infoRow(Icons.developer_board, 'CPU', status.cpuName),
            _infoRow(Icons.videogame_asset, 'GPU', status.gpuName),
            _infoRow(Icons.storage, 'Disk', '${status.diskUsage.toStringAsFixed(1)}% Used'),
            _infoRow(Icons.thermostat, 'Temp', '${status.temperature.toStringAsFixed(1)}°C'),
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
            const Text('Additional Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            ...status.additionalInfo.entries.map((e) => _infoRow(Icons.info_outline, e.key, e.value)).toList(),
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
                  TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
