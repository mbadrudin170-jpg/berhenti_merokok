// commit: 774431dbf61bb330d548785e8d47597c5bdcd123
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> inisialisasiSalah() async {
  final plugin = FlutterLocalNotificationsPlugin();
  
  // SALAH: Meminta izin otomatis saat startup (termasuk iOS default true)
  await plugin.initialize(
    const InitializationSettings(),
    onDidReceiveNotificationResponse: (_) {},
  );
  
  // SALAH: Mengasumsikan izin selalu diberikan
  await plugin.requestNotificationsPermission();
  
  // SALAH: Menyimpan status aktif tanpa cek hasil izin
  await setAktif(true);
  
  // SALAH: Menggunakan penjadwalan berulang di Web tanpa cek platform
  await plugin.zonedSchedule(
    1, 'Title', 'Body', 
    TZDateTime.now(local).add(const Duration(days: 1)),
    const NotificationDetails(),
    matchDateTimeComponents: DateTimeComponents.time, // Tidak didukung Web
  );
}

Future<void> setAktif(bool value) async {}