import 'package:flutter_test/flutter_test.dart';
import 'package:device_health_monitor/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DeviceHealthMonitorApp());

    // Verify that the title appears.
    expect(find.text('Device Health Monitor'), findsOneWidget);
  });
}
