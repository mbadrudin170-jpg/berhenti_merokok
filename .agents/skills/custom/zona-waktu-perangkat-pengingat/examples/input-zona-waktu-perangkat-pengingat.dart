// commit: d42422ba65a0f3c90b46a0736a197af572b62c33
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

Future<void> setupZonaWaktuSalah() async {
  // SALAH: Set Asia/Jakarta permanen tanpa deteksi perangkat
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
  
  // SALAH: Tidak inisialisasi database zona waktu
  // SALAH: Tidak handle error deteksi/pencarian/set lokasi
}

Future<void> setupZonaWaktuBenar() async {
  try {
    // BENAR: Inisialisasi database zona waktu
    tz.initializeTimeZones();
    
    // BENAR: Deteksi zona waktu perangkat
    final deviceTz = await FlutterTimezone.getLocalTimezone();
    L.i('deviceTimezone=$deviceTz');
    
    // BENAR: Gunakan identifier dari TimezoneInfo
    final location = tz.getLocation(deviceTz.identifier);
    
    // BENAR: Set lokasi sebelum penjadwalan
    tz.setLocalLocation(location);
    L.i('timezoneSet=${location.name}');
  } catch (e, s) {
    // BENAR: Fallback ke Asia/Jakarta dengan logging
    L.w('fallbackToAsiaJakarta: $e');
    try {
      final fallback = tz.getLocation('Asia/Jakarta');
      tz.setLocalLocation(fallback);
    } catch (e2, s2) {
      L.e('fallbackFailed: $e2 $s2');
      rethrow;
    }
  }
}