// commit: 774431dbf61bb330d548785e8d47597c5bdcd123
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

void inisialisasiBenar() async {
  final plugin = FlutterLocalNotificationsPlugin();
  
  // BENAR: Inisialisasi TANPA minta izin otomatis
  await plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    ),
    onDidReceiveNotificationResponse: _onTapNotifikasi,
  );
  
  // BENAR: Handle tap 3 lifecycle
  final launchDetails = await plugin.getNotificationAppLaunchDetails();
  if (launchDetails?.didNotificationLaunchApp ?? false) {
    _navigasiBerdasarkanPayload(launchDetails!.notificationResponse.payload);
  }
}

void _navigasiBerdasarkanPayload(String? payload) {
  // BENAR: Validasi payload kategori dikenal
  String? kategori;
  if (payload != null) {
    for (final part in payload.split('&')) {
      final kv = part.split('=');
      if (kv.length == 2 && kv[0] == 'kategori') kategori = kv[1];
    }
  }
  if (kategori == 'pengingat_harian') {
    // BENAR: unawaited DENGAN catchError
    unawaited(
      Nav.pushAndRemoveUntil(context, const Home()).catchError((e, s) {
        L.e('Gagal navigasi: $e $s');
      }),
    );
  } else if (kategori != null) {
    L.w('kategori tidak dikenal: $kategori');
  }
}

void _onTapNotifikasi(NotificationResponse response) {
  _navigasiBerdasarkanPayload(response.payload);
}

// BENAR: EasyLoading DENGAN catchError
unawaited(EasyLoading.show(status: 'Memproses...').catchError((e, s) => L.e('Gagal loading: $e $s')));
unawaited(EasyLoading.dismiss().catchError((e, s) => L.e('Gagal dismiss: $e $s')));

// BENAR: Exception khusus
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override String toString() => 'Izin notifikasi tidak diberikan';
}