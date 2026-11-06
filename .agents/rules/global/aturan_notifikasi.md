# Aturan Notifikasi

**Path:** `.agents/rules/global/aturan_notifikasi.md`

## Aturan Wajib Baca

Sebelum mengimplementasikan atau mengubah kode yang berkaitan dengan notifikasi lokal, AI wajib membaca dokumentasi berikut:

- [flutter_local_notifications versi 22.3.3](https://pub.dev/packages/flutter_local_notifications/versions/22.3.3)

Ketentuan:
1. Gunakan dokumentasi tersebut sebagai referensi utama implementasi.
2. Versi `22.3.3` merupakan versi yang telah dipasang pada proyek. Jangan mencari, mengganti, atau mempertanyakan versi lain.
3. Pastikan penggunaan API, konfigurasi, dan implementasi sesuai dengan dokumentasi versi tersebut.

## Aturan Implementasi

### 1. Paket dan Inisialisasi

1. Gunakan `flutter_local_notifications` untuk menangani notifikasi lokal.
2. Lakukan inisialisasi notifikasi di dalam fungsi `main()`.
3. Gunakan paket `timezone` dengan alias `tz` untuk mengatur jadwal notifikasi.

#### Contoh benar

```dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();
  final plugin = FlutterLocalNotificationsPlugin();
  await plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_notifikasi'),
    ),
  );
  runApp(const App());
}
```

**Alasan:** Inisialisasi dilakukan sebelum `runApp`, plugin berasal dari paket yang dipasang, dan `timezone` diimpor dengan alias `tz`.

#### Contoh salah

```dart
void main() {
  runApp(const App()); // plugin belum diinisialisasi
}

final jadwal = DateTime.now().add(const Duration(hours: 1));
```

**Kesalahan:** Notifikasi tidak diinisialisasi di `main()` dan jadwal tidak menggunakan `tz.TZDateTime` dari paket `timezone`.

**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `inisialisasi()`.
- `pubspec.yaml` — `flutter_local_notifications: ^22.3.3`, `timezone: ^0.11.2`.

### 2. Ikon Notifikasi

1. Wajib menggunakan ikon aplikasi sebagai ikon notifikasi.
2. Pastikan ikon dikonfigurasi sesuai dengan ketentuan dan format yang didukung oleh platform.
3. Ikuti dokumentasi `flutter_local_notifications` versi `22.3.3` untuk menentukan konfigurasi ikon yang benar.

#### Contoh benar

```dart
const android = AndroidNotificationDetails(
  'jadwal_service',
  'Jadwal Service',
  icon: 'ic_notifikasi',
);
```

**Alasan:** Ikon menggunakan aset aplikasi `ic_notifikasi` yang juga dipakai proyek.

#### Contoh salah

```dart
const android = AndroidNotificationDetails(
  'jadwal_service',
  'Jadwal Service',
  icon: 'https://example.com/icon.png',
);
```

**Kesalahan:** Ikon dimuat dari jaringan, bukan ikon aplikasi yang terpasang.

**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `AndroidNotificationDetails(icon: 'ic_notifikasi')`.

### 3. Payload Notifikasi

1. Setiap notifikasi wajib memiliki payload yang memuat:
   - `kategori`: jenis atau kategori data yang menjadi sumber notifikasi.
   - `id`: identitas data yang terkait dengan notifikasi.
2. Kedua informasi tersebut digunakan untuk menentukan tujuan navigasi ketika pengguna membuka notifikasi.

#### Contoh benar

```dart
await plugin.show(
  1,
  'Jadwal service',
  'Segera lakukan service',
  notificationDetails,
  payload: 'kategori=jadwal_service&id=$idJadwal',
);
```

**Alasan:** Payload memuat `kategori` dan `id` yang dapat dipakai untuk navigasi.

#### Contoh salah

```dart
await plugin.show(1, 'Jadwal service', 'Segera lakukan service', notificationDetails);
```

**Kesalahan:** Notifikasi ditampilkan tanpa payload, sehingga tujuan navigasi tidak dapat ditentukan.

**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `_navigasiKeHalaman(payload)`.

### 4. Penanganan Izin

1. Tangani permintaan izin notifikasi sesuai dengan ketentuan masing-masing platform.
2. Sesuaikan mekanisme permintaan dan pemeriksaan izin dengan platform yang digunakan.

#### Contoh benar

```dart
if (kIsWeb) {
  await plugin
      .resolvePlatformSpecificImplementation<WebFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
} else if (defaultTargetPlatform == TargetPlatform.android) {
  await plugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
}
```

**Alasan:** Mekanisme izin disesuaikan dengan platform web dan Android.

#### Contoh salah

```dart
await plugin.requestNotificationsPermission(); // API generik tanpa platform
```

**Kesalahan:** Memanggil API izin tanpa mempertimbangkan platform yang didukung.

**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `inisialisasi()` dan `mintaIzin()`.

### 5. ID Notifikasi

1. Gunakan ID yang unik untuk setiap notifikasi agar tidak terjadi benturan ID.
2. ID dapat menggunakan UUID versi 4 (`uuid.v4`) atau ID dari item terkait apabila nilainya sudah unik.
3. Jangan menggunakan tanggal sebagai ID notifikasi.

#### Contoh benar

```dart
final notifId = int.tryParse(idJadwal)?.abs() ?? idJadwal.hashCode.abs();
await plugin.cancel(id: notifId);
```

**Alasan:** ID numerik konsisten dibuat dari ID item, bukan tanggal.

#### Contoh salah

```dart
final notifId = DateTime.now().millisecondsSinceEpoch;
await plugin.show(notifId, judul, isi, details);
```

**Kesalahan:** Menggunakan tanggal sebagai ID notifikasi, sehingga ID berubah setiap waktu dan benturan ID tidak terkontrol.

**Rujukan teknis:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `_notifId(String id)`.
- `pubspec.yaml` — `uuid: ^4.6.0`.
