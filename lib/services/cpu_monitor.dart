import 'dart:ffi';
import 'package:ffi/ffi.dart';

final dylib = DynamicLibrary.open('/usr/lib/libSystem.B.dylib');

// Types
typedef host_t = Int32;
typedef host_flavor_t = Int32;
typedef mach_msg_type_number_t = Uint32;
typedef natural_t = Uint32;
typedef integer_t = Int32;

// host_statistics function
typedef host_statistics_native = Int32 Function(
    host_t host,
    host_flavor_t flavor,
    Pointer<integer_t> host_info,
    Pointer<mach_msg_type_number_t> host_info_count,
    );

typedef host_statistics_dart = int Function(
    int host,
    int flavor,
    Pointer<Int32> host_info,
    Pointer<Uint32> host_info_count,
    );

final host_statistics = dylib.lookupFunction<
    host_statistics_native,
    host_statistics_dart>('host_statistics');

final mach_host_self = dylib.lookupFunction<Int32 Function(), int Function()>(
  'mach_host_self',
);

// Constants
const HOST_CPU_LOAD_INFO = 3;
const CPU_STATE_MAX = 4;

class CpuMonitor {
  List<int>? _prevTicks;

  Future<int> getCpuUsage() async {
    try {
      final host = mach_host_self();

      final count = calloc<Uint32>();
      count.value = CPU_STATE_MAX;

      final cpuInfo = calloc<Int32>(CPU_STATE_MAX);

      final result = host_statistics(
        host,
        HOST_CPU_LOAD_INFO,
        cpuInfo,
        count,
      );

      if (result != 0) {
        calloc.free(cpuInfo);
        calloc.free(count);
        return 0;
      }

      final ticks = List<int>.generate(
        CPU_STATE_MAX,
            (i) => cpuInfo[i],
      );

      calloc.free(cpuInfo);
      calloc.free(count);

      if (_prevTicks == null) {
        _prevTicks = ticks;
        // Small delay to get a diff on the first run
        await Future.delayed(const Duration(milliseconds: 200));
        return await getCpuUsage();
      }

      final diffs = List<int>.generate(
        CPU_STATE_MAX,
            (i) => ticks[i] - _prevTicks![i],
      );

      _prevTicks = ticks;

      final idle = diffs[2];
      final total = diffs.reduce((a, b) => a + b);

      if (total <= 0) return 0;

      final usage = ((total - idle) / total * 100).round();

      return usage.clamp(0, 100);
    } catch (e) {
      print("FFI CPU Error: $e");
      return 0;
    }
  }
}
