// commit: 774431dbf61bb330d548785e8d47597c5bdcd123
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

void inisialisasiSalah() async {
  final plugin = FlutterLocalNotificationsPlugin();
  
  // SALAH: Tidak cek platform sebelum pakai API penjadwalan
  // SALAH: Minta izin otomatis saat startup (iOS default true)
  await plugin.initialize(
    const InitializationSettings(),
    onDidReceiveNotificationResponse: (_) {},
  );
  
  // SALAH: Penjadwalan berulang di Web tanpa cek platform
  await plugin.zonedSchedule(
    1, 'Test', 'Body', 
    tz.TZDateTime.now(tz.local).add(const Duration(days: 1)),
    const NotificationDetails(),
    matchDateTimeComponents: DateTimeComponents.time,
  );
  
  // SALAH: ID uji coba sama dengan ID pengingat utama
  await plugin.show(1, 'Test', 'Body', const NotificationDetails());
  
  // SALAH: unawaited tanpa catchError
  unawaited(plugin.show(1, 'Test', 'Body', const NotificationDetails()));
}