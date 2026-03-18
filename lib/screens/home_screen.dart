import 'package:flutter/material.dart';
import '../services/system_monitor_service.dart';
import '../models/system_status.dart';
import '../widgets/status_card.dart';
import 'monitor_dashboard.dart';

class HomeScreen extends StatelessWidget {
  final SystemMonitorService _monitorService = SystemMonitorService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Device Health Monitor'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<SystemStatus>(
          future: _monitorService.getSystemStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            }

            final status = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatusCard(
                  isHealthy: status.isHealthy,
                  onMonitorPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MonitorDashboard(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  '${status.deviceName} | ${status.osName}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
