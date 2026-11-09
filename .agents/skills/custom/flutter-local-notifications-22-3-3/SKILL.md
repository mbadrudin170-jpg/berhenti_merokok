---
name: flutter-local-notifications-22-3-3
description: Panduan standar flutter_local_notifications v22.3.3 Flutter - cek platform sebelum API penjadwalan, receiver Android (RECEIVE_BOOT_COMPLETED, ScheduledNotificationReceiver, ScheduledNotificationBootReceiver), core library desugaring, izin runtime (minta saat fitur diaktifkan bukan startup), payload validation, lifecycle tap (foreground/background/terminated), exception khusus, dan unawaited catchError.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "774431dbf61bb330d548785e8d47597c5bdcd123"
  model: "kilo-auto/free"
---

# Standar flutter_local_notifications v22.3.3 pada Notifikasi Harian

Aturan khusus untuk plugin versi 22.3.3: cek platform, receiver Android, core library desugaring, izin runtime, payload, lifecycle tap.

## Cakupan yang Di-Cover

- Package: `package:flutter_local_notifications` v22.3.3 (class `FlutterLocalNotificationsPlugin`, `InitializationSettings`, `AndroidInitializationSettings`, `NotificationDetails`, `NotificationResponse`), `package:timezone` as `tz` (class `tz`, `TZDateTime`), `dart:async` (`unawaited`)
- Class: `FlutterLocalNotificationsPlugin`, `InitializationSettings`, `AndroidInitializationSettings`, `NotificationDetails`, `NotificationResponse`, `TZDateTime`, `AndroidFlutterLocalNotificationsPlugin`, `IOSFlutterLocalNotificationsPlugin`
- Method: `plugin.initialize()`, `plugin.zonedSchedule()`, `plugin.show()`, `plugin.getNotificationAppLaunchDetails()`, `plugin.resolvePlatformSpecificImplementation()`, `androidPlugin?.requestNotificationsPermission()`, `iosPlugin?.requestPermissions()`, `unawaited()`, `catchError()`
- Properti: `kIsWeb`, `defaultTargetPlatform`, `TargetPlatform.android`, `TargetPlatform.iOS`, `isDestructiveAction`

## Aturan

1. Periksa dukungan fitur berdasarkan platform dan versi plugin sebelum menggunakan API penjadwalan.
2. Jangan gunakan penjadwalan berulang (`matchDateTimeComponents`, `zonedSchedule` dengan pengulangan) pada Web, Linux, Windows. macOS didukung via `zonedSchedule`.
3. Lengkapi receiver dan izin Android: `RECEIVE_BOOT_COMPLETED`, `ScheduledNotificationReceiver`, `ScheduledNotificationBootReceiver`. Gunakan `AndroidScheduleMode.inexactAllowWhileIdle`.
4. Aktifkan core library desugaring: `isCoreLibraryDesugaringEnabled = true`, dependency `desugar_jdk_libs:2.1.4`, `compileSdk` minimal 35, AGP minimal 8.11.1.
5. Jangan minta izin notifikasi otomatis saat startup (termasuk iOS Darwin default). Minta saat pengguna aktifkan fitur.
6. Periksa hasil izin sebelum simpan status aktif. Periksa kembali izin saat buka aplikasi.
7. Rollback state, tampilkan feedback, jangan simpan status aktif jika penjadwalan gagal.
8. Tangani gagal penjadwalan ulang saat buka aplikasi: log error, jangan biarkan unhandled.
9. Pisahkan ID notifikasi uji coba dari ID pengingat utama.
10. Handle tap notifikasi 3 kondisi lifecycle: foreground, background, terminated. Gunakan `getNotificationAppLaunchDetails()` untuk terminated.
11. Validasi payload: parse `kategori` dan `id`, hanya proses kategori dikenal, log warning jika tidak valid.
12. Izin dicabut → cancel jadwal, update preferensi, pastikan tidak ada jadwal tertinggal. Aktifkan kembali → minta izin dulu.
13. Konsistensi waktu: simpan nilai lama, terapkan baru setelah berhasil, gagal → pulihkan lama.
14. unawaited navigasi/loading wajib catchError dengan `L.e`.
15. Gunakan exception khusus (class implements `Exception`), deteksi via `is`, bukan string matching.

## Larangan

- Jangan minta izin notifikasi otomatis saat startup aplikasi.
- Jangan gunakan penjadwalan berulang di Web/Linux/Windows.
- Jangan gunakan ID notifikasi uji coba sama dengan ID pengingat utama.
- Jangan unawaited navigasi/loading tanpa catchError.
- Jangan string matching untuk deteksi exception.
- Jangan simpan status aktif sebelum izin terverifikasi.

## Contoh Benar

```dart
// Inisialisasi TANPA minta izin otomatis
await plugin.initialize(
  const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  ),
  onDidReceiveNotificationResponse: _onTapNotifikasi,
);

// Handle tap 3 lifecycle
final launchDetails = await plugin.getNotificationAppLaunchDetails();
if (launchDetails?.didNotificationLaunchApp ?? false) {
  _navigasiBerdasarkanPayload(launchDetails!.notificationResponse.payload);
}

void _navigasiBerdasarkanPayload(String? payload) {
  String? kategori;
  if (payload != null) {
    for (final part in payload.split('&')) {
      final kv = part.split('=');
      if (kv.length == 2 && kv[0] == 'kategori') kategori = kv[1];
    }
  }
  if (kategori == 'pengingat_harian') {
    unawaited(
      Nav.pushAndRemoveUntil(context, const Home()).catchError((e, s) {
        L.e('Gagal navigasi: $e $s');
      }),
    );
  } else if (kategori != null) {
    L.w('kategori tidak dikenal: $kategori');
  }
}

// EasyLoading dengan catchError
unawaited(EasyLoading.show(status: 'Memproses...').catchError((e, s) => L.e('Gagal loading: $e $s')));

// Exception khusus
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override String toString() => 'Izin notifikasi tidak diberikan';
}
```

## Contoh Salah

```dart
// DILARANG: Tidak cek platform sebelum pakai API penjadwalan
await plugin.zonedSchedule(
  1, 'Test', 'Body',
  tz.TZDateTime.now(tz.local).add(const Duration(days: 1)),
  const NotificationDetails(),
  matchDateTimeComponents: DateTimeComponents.time, // Tidak didukung Web
);

// DILARANG: Minta izin otomatis saat startup (termasuk iOS default true)
await plugin.requestNotificationsPermission();

// DILARANG: ID uji coba sama dengan ID pengingat utama
await plugin.show(1, 'Test', 'Body', const NotificationDetails());

// DILARANG: unawaited tanpa catchError
unawaited(plugin.show(1, 'Test', 'Body', const NotificationDetails()));
```

## Sumber Evaluasi

- File: `lib/shared/notifikasi/notifikasi_service.dart`, `lib/main.dart`, `lib/app.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `android/app/src/main/AndroidManifest.xml`, `saran.md`
- Class terkait: `FlutterLocalNotificationsPlugin`, `InitializationSettings`, `NotificationDetails`, `NotificationResponse`
- Commit rujukan: `774431dbf61bb330d548785e8d47597c5bdcd123`, `0cb0e52f48f6d6f95f2bfc9e8b82a092bb5f9e4f`