import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/system_status.dart';
import '../services/system_monitor_service.dart';
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
        actions: [
          Center(
            child: ValueListenableBuilder<String>(
              valueListenable: _monitorService.formattedSessionTime,
              builder: (context, time, _) {
                return Text(
                  time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
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
                  'Battery: ${status.batteryLevel} (${status.batteryStatus})',
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                const SizedBox(height: 32),
                FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, prefSnapshot) {
                    if (!prefSnapshot.hasData) return const SizedBox.shrink();
                    final prefs = prefSnapshot.data!;
                    final bool camStatus = prefs.getBool('cameraStatus') ?? false;
                    final bool micStatus = prefs.getBool('micStatus') ?? false;
                    final bool spkStatus = prefs.getBool('speakerStatus') ?? false;

                    return Column(
                      children: [
                        const Text('Hardware Status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo, fontSize: 18)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildHardwareStatusIcon(Icons.camera_alt, 'Camera', camStatus),
                            const SizedBox(width: 32),
                            _buildHardwareStatusIcon(Icons.mic, 'Mic', micStatus),
                            const SizedBox(width: 32),
                            _buildHardwareStatusIcon(Icons.speaker, 'Speaker', spkStatus),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHardwareStatusIcon(IconData icon, String label, bool isHealthy) {
    return Column(
      children: [
        Icon(icon, color: isHealthy ? Colors.green : Colors.red, size: 36),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isHealthy ? Colors.green[700] : Colors.red[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
