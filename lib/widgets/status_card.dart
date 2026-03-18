import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final bool isHealthy;
  final String? statusText;
  final VoidCallback onMonitorPressed;

  const StatusCard({
    super.key,
    required this.isHealthy,
    this.statusText,
    required this.onMonitorPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: isHealthy
                ? [Colors.green.shade400, Colors.green.shade700]
                : [Colors.red.shade400, Colors.red.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isHealthy ? Icons.check_circle_outline : Icons.error_outline,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            const Text(
              'System Status',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              statusText ?? (isHealthy ? 'Healthy' : 'Unhealthy'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onMonitorPressed,
              icon: const Icon(Icons.dashboard),
              label: const Text('Monitor System'),
              style: ElevatedButton.styleFrom(
                foregroundColor: isHealthy ? Colors.green.shade800 : Colors.red.shade800,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
