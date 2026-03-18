import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/system_monitor_service.dart';
import '../models/system_status.dart';
import '../widgets/status_card.dart';
import 'monitor_dashboard.dart';
import 'login_screen.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => SystemMonitorService().clickLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<SystemStatus>(
          stream: _monitorService.getStatusStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data available');
            }

            final status = snapshot.data!;
            final bool hasInternet = status.isConnected;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatusCard(
                  isHealthy: status.isHealthy && hasInternet,
                  statusText: hasInternet ? null : 'Internet Required',
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
                const SizedBox(height: 8),
                Text(
                  'Battery: ${status.batteryLevel}% (${status.batteryStatus})',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
              ],
            );
          },
        ),
      ),
    );
  }



}
