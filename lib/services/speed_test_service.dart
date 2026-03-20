import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

class SpeedTestService {

  static const String _downloadUrl = 'https://speedtest.mumbai1.linode.com/100MB-mumbai.bin'; // Faster regional server
  static const String _uploadUrl = 'https://speed.cloudflare.com/__up';



  /// Measures download speed in Mbps over a fixed [duration].
  /// Yields live updates periodically.
  Stream<double> measureDownloadSpeed({Duration duration = const Duration(seconds: 20)}) async* {
    final client = HttpClient();
    client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36';
    client.connectionTimeout = const Duration(seconds: 5);
    
    final List<StreamSubscription> subscriptions = [];
    int totalBytesReceived = 0;
    bool isTimeUp = false;
    
    final stopwatch = Stopwatch();
    bool hasStarted = false;
    double emaSpeed = 0.0;
    
    // Inner function to start download workers in parallel
    Future<void> startDownloadWorker() async {
      try {
        final request = await client.getUrl(Uri.parse(_downloadUrl));
        final response = await request.close();
        
        final sub = response.listen((List<int> chunk) {
          if (!hasStarted) {
            hasStarted = true;
            stopwatch.start();
          }
          if (!isTimeUp) {
            totalBytesReceived += chunk.length;
          }
        }, cancelOnError: true);
        subscriptions.add(sub);
      } catch (_) {
        // Ignore single worker failure
      }
    }
    
    // Spawn 5 parallel workers for precise bandwidth saturation
    for (int i = 0; i < 5; i++) {
        startDownloadWorker();
    }
    
    int previousBytes = 0;
    int previousTime = 0;

    // Wait until downloading actually begins
    while (!hasStarted) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Yield updates periodically until duration is reached
    while (stopwatch.elapsed < duration) {
      await Future.delayed(const Duration(milliseconds: 250));
      if (stopwatch.elapsed >= duration) break;
      
      final currentBytes = totalBytesReceived;
      final currentTime = stopwatch.elapsedMilliseconds;
      
      final bytesDiff = currentBytes - previousBytes;
      final timeDiff = (currentTime - previousTime) / 1000.0;
      
      if (timeDiff > 0 && currentBytes > 0) {
        // Calculate instantaneous speed in Mbps
        final currentSpeedMbps = (bytesDiff * 8) / timeDiff / 1000000.0;
        
        // Exponential Moving Average to smooth out spikes
        if (emaSpeed == 0.0) {
          emaSpeed = currentSpeedMbps;
        } else {
          emaSpeed = (currentSpeedMbps * 0.3) + (emaSpeed * 0.7);
        }
        
        yield emaSpeed;
      }
      
      previousBytes = currentBytes;
      previousTime = currentTime;
    }
    
    isTimeUp = true;
    for (var sub in subscriptions) {
      sub.cancel();
    }
    client.close(force: true);
  }

  /// Measures upload speed in Mbps over a fixed [duration].
  /// Yields live updates periodically.
  Stream<double> measureUploadSpeed({Duration duration = const Duration(seconds: 20)}) async* {
    final client = HttpClient();
    client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36';
    client.connectionTimeout = const Duration(seconds: 5);
    
    int totalBytesSent = 0;
    bool isTimeUp = false;
    final stopwatch = Stopwatch();
    bool hasStarted = false;
    double emaSpeed = 0.0;
    
    // Generated dummy payload - 256KB for more frequent updates
    final payload = Uint8List(256 * 1024);
    
    // Inner function to hammer endpoint with POST requests
    Future<void> startUploadWorker() async {
      while (!isTimeUp && (!hasStarted || stopwatch.elapsed < duration)) {
        try {
          final request = await client.postUrl(Uri.parse(_uploadUrl));
          request.contentLength = payload.length;
          request.add(payload);
          await request.close();
          
          if (!hasStarted) {
            hasStarted = true;
            stopwatch.start();
            totalBytesSent += payload.length;
          } else if (!isTimeUp) {
            totalBytesSent += payload.length;
          }
        } catch (_) {
          // Ignore failures, retry loop handles it
        }
      }
    }
    
    // Spawn 3 workers
    for (int i = 0; i < 3; i++) {
      startUploadWorker();
    }
    
    int previousBytes = 0;
    int previousTime = 0;

    // Wait until uploading actually begins
    while (!hasStarted) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // Yield updates incrementally
    while (stopwatch.elapsed < duration) {
      await Future.delayed(const Duration(milliseconds: 250));
      if (stopwatch.elapsed >= duration) break;
      
      final currentBytes = totalBytesSent;
      final currentTime = stopwatch.elapsedMilliseconds;
      
      final bytesDiff = currentBytes - previousBytes;
      final timeDiff = (currentTime - previousTime) / 1000.0;
      
      if (timeDiff > 0 && currentBytes > 0) {
        // Calculate instantaneous speed in Mbps
        final currentSpeedMbps = (bytesDiff * 8) / timeDiff / 1000000.0;
        
        // Exponential Moving Average to smooth out spikes
        if (emaSpeed == 0.0) {
          emaSpeed = currentSpeedMbps;
        } else {
          emaSpeed = (currentSpeedMbps * 0.3) + (emaSpeed * 0.7);
        }
        
        yield emaSpeed;
      }
      
      previousBytes = currentBytes;
      previousTime = currentTime;
    }
    
    isTimeUp = true;
    client.close(force: true);
  }
}
