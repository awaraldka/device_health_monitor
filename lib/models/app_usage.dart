

class AppUsageData {
  final String name;
  final String from;
  final String till;
  final String duration;

  AppUsageData({
    required this.name,
    required this.from,
    required this.till,
    required this.duration,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'from': from,
        'till': till,
        'duration': duration,
      };

  factory AppUsageData.fromJson(Map<String, dynamic> json) => AppUsageData(
        name: json['name'] ?? '',
        from: json['from'] ?? '',
        till: json['till'] ?? '',
        duration: json['duration'] ?? '',
      );

  factory AppUsageData.fromMap(Map<String, dynamic> map) {
    final fromRaw = map['From']?['DateTime'];
    final tillRaw = map['Till']?['DateTime'];
    final durationRaw = map['Duration'] ?? {};

    return AppUsageData(
      name: map['Name'] ?? 'Unknown',
      from: _formatDate(fromRaw),
      till: _formatDate(tillRaw),
      duration: _formatDuration(durationRaw),
    );
  }

  static String _formatDate(String? date) {
    if (date == null) return '-';

    try {
      final dt = DateTime.parse(date);
      return "${dt.day}/${dt.month} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return date; // fallback
    }
  }

  static String _formatDuration(Map duration) {
    final days = duration['Days'] ?? 0;
    final hours = duration['Hours'] ?? 0;
    final minutes = duration['Minutes'] ?? 0;

    return "${days}d ${hours}h ${minutes}m";
  }

  @override
  String toString() {
    return "AppUsageData(name: $name, from: $from, till: $till, duration: $duration)";
  }
}
