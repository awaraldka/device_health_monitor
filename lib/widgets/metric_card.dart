import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final double percentage;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            LinearPercentIndicator(
              lineHeight: 8.0,
              percent: percentage.clamp(0.0, 1.0),
              backgroundColor: Colors.grey[200],
              progressColor: color,
              barRadius: const Radius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}
