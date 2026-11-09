// commit: 774431dbf61bb330d548785e8d47597c5bdcd123
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> inisialisasiBenar() async {
  final plugin = FlutterLocalNotificationsPlugin();
  
  // BENAR: Inisialisasi layanan TANPA minta izin otomatis
  await plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: _onTapNotifikasi,
  );
  
  // BENAR: Izin diminta KETIKA pengguna mengaktifkan fitur (konteks fitur)
  // Bukan di startup aplikasi
}

Future<void> aktifkanPengingat(BuildContext context) async {
  // BENAR: Cek platform sebelum menggunakan fitur
  if (kIsWeb) {
    // Jangan tampilkan kontrol pengingat terjadwal di Web
    return;
  }
  
  if (defaultTargetPlatform == TargetPlatform.android) {
    final izin = await _mintaIzinAndroid();
    if (!izin) {
      // BENAR: Periksa hasil izin sebelum menyimpan status aktif
      return;
    }
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final izin = await _mintaIzinIOS();
    if (!izin) return;
  }
  
  // BENAR: Simpan status aktif HANYA SETELAH izin tersedia
  await _setAktif(true);
  
  // BENAR: Tangani UnsupportedError eksplisit untuk platform tidak didukung
  try {
    await _jadwalkanNotifikasi();
  } on UnsupportedError {
    // Platform tidak mendukung penjadwalan
  }
}

Future<bool> _mintaIzinAndroid() async {
  final plugin = FlutterLocalNotificationsPlugin();
  final androidPlugin = plugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  return await androidPlugin?.requestNotificationsPermission() ?? false;
}

Future<bool> _mintaIzinIOS() async {
  final plugin = FlutterLocalNotificationsPlugin();
  final iosPlugin = plugin.resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>();
  return await iosPlugin?.requestPermissions(alert: true, sound: true, badge: true) ?? false;
}

Future<void> _setAktif(bool value) async {}

Future<void> _jadwalkanNotifikasi() async {
  // Implementasi penjadwalan
}

void _onTapNotifikasi(NotificationResponse response) {}