// commit: d42422ba65a0f3c90b46a0736a197af572b62c33
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

Future<void> setupZonaWaktuBenar() async {
  try {
    tz.initializeTimeZones();
    
    final deviceTz = await FlutterTimezone.getLocalTimezone();
    L.i('deviceTimezone=$deviceTz');
    
    final location = tz.getLocation(deviceTz.identifier);
    tz.setLocalLocation(location);
    L.i('timezoneSet=${location.name}');
  } catch (e, s) {
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