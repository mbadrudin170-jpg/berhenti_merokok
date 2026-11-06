# Aturan Pemanfaatan SDK dan Paket Flutter

## 1. Tujuan

Memastikan pemanfaatan SDK, paket, dan fitur yang tersedia dalam proyek Flutter dilakukan secara tepat, konsisten, dan sesuai dengan mekanisme resmi yang telah disediakan.

Implementasi wajib mengutamakan pemanfaatan fitur dan API yang sudah tersedia daripada membuat mekanisme sendiri yang memiliki fungsi serupa.

## 2. Skills

1. **Wajib membaca Skills sebelum implementasi.**
   - Sebelum menulis atau mengubah kode, periksa dan baca Skills yang tersedia di folder `.agents/skills`.
   - Identifikasi Skills yang relevan dengan paket, SDK, atau fitur yang akan digunakan.
   - Load dan ikuti panduan dari Skills terkait sebelum memulai implementasi.

2. **Utamakan mekanisme yang sudah tersedia.**
   - Gunakan API, utilitas, pola implementasi, dan mekanisme yang telah dijelaskan dalam Skills.
   - Jangan membuat ulang mekanisme yang sebenarnya sudah tersedia dan dapat digunakan.
   - Jangan mengabaikan panduan Skills tanpa alasan teknis yang jelas.

## 3. Aturan Pemanfaatan Paket dan API

### 3.1. Pengaturan Jarak pada Row dan Column

- Gunakan properti `spacing` pada `Row` dan `Column` untuk mengatur jarak antar-anak secara konsisten.
- Jangan menggunakan beberapa `SizedBox` hanya untuk mengatur jarak antar-anak yang memiliki jarak seragam.
- Gunakan `SizedBox` apabila terdapat kebutuhan jarak khusus pada anak tertentu yang tidak dapat dipenuhi secara tepat menggunakan `spacing`.

### 3.2. Pengurutan Data Koleksi

- Gunakan fungsi `sorted` dari paket `collection` untuk mengurutkan data dalam koleksi.
- Jangan membuat mekanisme pengurutan sendiri apabila fungsi tersebut sudah memenuhi kebutuhan.

#### Contoh benar

```dart
import 'package:collection/collection.dart';

final terurut = daftarBahanBakar.sorted((a, b) => a.tanggal.compareTo(b.tanggal));
```

**Alasan:** Pengurutan menggunakan `sorted` dari paket `collection`.

#### Contoh salah

```dart
final terurut = [...daftarBahanBakar]..sort((a, b) => a.tanggal.compareTo(b.tanggal));
```

**Kesalahan:** Membuat mekanisme pengurutan manual padahal `sorted` sudah tersedia.

**Rujukan teknis:**
- `pubspec.yaml` — `collection: ^1.19.1`.
- `pub-cache/.../collection-*/lib/collection.dart`.

### 3.3. Pencarian Satu Item dalam Koleksi

- Gunakan fungsi `firstWhereOrNull` dari paket `collection` untuk mencari satu item berdasarkan kondisi tertentu.
- Fungsi ini digunakan ketika hasil pencarian mungkin tidak ditemukan dan nilai `null` perlu dikembalikan tanpa menimbulkan exception.

#### Contoh benar

```dart
import 'package:collection/collection.dart';

final item = daftar.firstWhereOrNull((e) => e.id == idDicari);
```

**Alasan:** Pencarian mengembalikan `null` tanpa exception ketika item tidak ditemukan.

#### Contoh salah

```dart
final item = daftar.firstWhere((e) => e.id == idDicari);
```

**Kesalahan:** `firstWhere` melempar exception ketika item tidak ditemukan.

**Rujukan teknis:**
- `pubspec.yaml` — `collection: ^1.19.1`.

### 3.4. Pengambilan Item Berdasarkan Nilai Maksimum

- Gunakan fungsi `maxBy` dari paket `collection` untuk mengambil satu item yang memiliki nilai maksimum berdasarkan properti atau kriteria tertentu.
- Jangan menggunakan `firstWhereOrNull` untuk kebutuhan ini karena keduanya memiliki tujuan yang berbeda.

#### Contoh benar

```dart
import 'package:collection/collection.dart';

final terbaru = daftar.maxBy((e) => e.tanggal);
```

**Alasan:** `maxBy` mengambil item dengan nilai maksimum berdasarkan kriteria.

#### Contoh salah

```dart
final terbaru = daftar.firstWhereOrNull((e) => e.tanggal == daftar.map((x) => x.tanggal).reduce((a, b) => a.isAfter(b) ? a : b));
```

**Kesalahan:** Menggunakan `firstWhereOrNull` untuk kebutuhan nilai maksimum, padahal `maxBy` lebih tepat.

**Rujukan teknis:**
- `pubspec.yaml` — `collection: ^1.19.1`.

### 3.5. Menampilkan Gambar dari Jaringan

- Gunakan `CachedNetworkImage` dari paket `cached_network_image` untuk menampilkan gambar yang bersumber dari jaringan.
- Jangan menggunakan `Image.network` untuk kebutuhan tersebut.
- Implementasi wajib menyediakan:
  - `placeholder` untuk menampilkan kondisi ketika gambar sedang dimuat.
  - `errorWidget` untuk menangani dan menampilkan kondisi ketika gambar gagal dimuat.
- Ikuti pola implementasi resmi pada folder `example` paket `cached_network_image`, dengan mengacu pada `example.md` apabila tersedia.

#### Contoh benar

```dart
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(
  imageUrl: urlGambar,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
);
```

**Alasan:** Gambar jaringan ditampilkan dengan cache, placeholder, dan error widget.

#### Contoh salah

```dart
Image.network(urlGambar);
```

**Kesalahan:** Tidak menggunakan cache dan tidak menyediakan placeholder/error widget.

**Rujukan teknis:**
- `pubspec.yaml` — `cached_network_image: ^4.0.6`.

## 4. Aturan Berdasarkan Paket

### 4.1. UUID

**Tujuan:** Menghasilkan ID unik dengan mekanisme yang telah disediakan oleh paket `uuid`.

Ketentuan:

1. Gunakan `uuid.v4()` dari paket `uuid` untuk menghasilkan ID unik.
2. Dilarang membuat ID secara manual.
3. Dilarang menggunakan tanggal, waktu, timestamp, atau kombinasi nilai lainnya sebagai pengganti UUID.

#### Contoh benar

```dart
import 'package:uuid/uuid.dart';

final id = const Uuid().v4();
```

**Alasan:** ID dihasilkan oleh generator UUID versi 4.

#### Contoh salah

```dart
final id = DateTime.now().millisecondsSinceEpoch.toString();
```

**Kesalahan:** Menggunakan timestamp sebagai ID, bertentangan dengan aturan pembuatan ID unik.

**Rujukan teknis:**
- `pubspec.yaml` — `uuid: ^4.6.0`.

### 4.2. URL Launcher

**Tujuan:** Memastikan pembukaan URL, tautan, email, dan berkas menggunakan mekanisme resmi paket `url_launcher` dengan penanganan kegagalan yang tepat.

#### A. Membuka URL

1. Gunakan `launchUrl` untuk membuka URL.
2. Buat objek `Uri` menggunakan metode yang sesuai:
   - `Uri.parse`
   - `Uri.tryParse`
   - `Uri(...)`
   - `Uri.file`
3. Periksa nilai balik `bool` dari `launchUrl`.
4. Jika hasilnya `false`, lempar `Exception` agar kegagalan tidak diabaikan.
5. Bungkus operasi pembukaan URL dengan `try`/`catch` untuk menangani exception yang mungkin terjadi.

#### B. Menentukan Mode Peluncuran

Pilih `LaunchMode` berdasarkan kebutuhan dan konteks penggunaan:

- `externalApplication`
- `inAppBrowserView`
- `inAppWebView`
- `externalNonBrowserApplication`

Untuk universal link:

1. Coba buka menggunakan `externalNonBrowserApplication` terlebih dahulu.
2. Jika gagal, lakukan fallback menggunakan `inAppBrowserView`.

Jangan menggunakan mode peluncuran secara sembarangan tanpa mempertimbangkan jenis URL dan pengalaman pengguna yang diharapkan.

#### C. Konfigurasi Browser dan WebView

Gunakan konfigurasi sesuai kebutuhan:

- `BrowserConfiguration`, misalnya `showTitle`.
- `WebViewConfiguration`, misalnya `headers`, `enableJavaScript`, dan `enableDomStorage`.
- `webOnlyWindowName` untuk menentukan target jendela pada platform web.

Jangan menambahkan konfigurasi yang tidak diperlukan.

#### D. Memeriksa Dukungan Fitur

- Gunakan `canLaunchUrl` untuk memeriksa ketersediaan atau dukungan URL tertentu sebelum menampilkan aksi kepada pengguna.
- Terapkan terutama pada URL yang bergantung pada aplikasi eksternal, seperti panggilan telepon.
- Jangan menampilkan aksi yang tidak dapat dijalankan apabila ketersediaannya dapat diperiksa terlebih dahulu.

#### E. Membuka Email

- Gunakan `Uri` dengan konfigurasi:
  - `scheme: 'mailto'`
  - `path` berisi alamat email tujuan.
  - `query` berisi hasil fungsi `encodeQueryParameters`.
- Implementasikan `encodeQueryParameters` menggunakan `Uri.encodeComponent` untuk mengamankan parameter query.

#### F. Membuka Berkas

- Gunakan `Uri.file` untuk membentuk URI dari lokasi berkas.
- Pastikan berkas benar-benar tersedia sebelum memanggil `launchUrl`.
- Tangani kondisi ketika berkas tidak ditemukan atau gagal dibuka.

#### G. Tautan Deklaratif

- Gunakan widget `Link` dengan properti `uri` dan `target` untuk kebutuhan tautan deklaratif.
- Jangan mengganti mekanisme ini dengan implementasi manual apabila widget tersebut sudah memenuhi kebutuhan.

#### H. Menutup WebView

- Gunakan `closeInAppWebView()` apabila WebView yang dibuka melalui aplikasi perlu ditutup secara programatik.

#### I. Referensi Implementasi

- Ikuti contoh resmi pada folder `example` paket `url_launcher`.
- Gunakan `example.md` sebagai referensi apabila tersedia.
- Jangan mengasumsikan API atau konfigurasi berdasarkan ingatan apabila dokumentasi paket sudah tersedia.

### 4.3. Timezone

**Tujuan:** Memastikan pengolahan waktu dan zona waktu dilakukan menggunakan database zona waktu yang benar serta sesuai dengan platform.

#### A. Inisialisasi Database Zona Waktu

1. Inisialisasi database zona waktu sebelum menggunakan fitur yang bergantung padanya.
2. Gunakan `tz.initializeTimeZones()` untuk menginisialisasi database.
3. Gunakan `tz.getLocation('...')` atau `tz.timeZoneDatabase` untuk menentukan lokasi zona waktu.
4. Gunakan `tz.TZDateTime` untuk melakukan pengolahan dan konversi waktu berdasarkan zona waktu yang ditentukan.
5. Contoh konversi: `tz.TZDateTime.from(waktu, tz.local)`.

Jangan memanggil `tz.getLocation` atau menggunakan `tz.TZDateTime` sebelum database zona waktu selesai diinisialisasi.

#### Contoh benar

```dart
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

tz.initializeTimeZones();
final lokasi = tz.getLocation('Asia/Jakarta');
final waktuLokal = tz.TZDateTime.from(waktuUtc, lokasi);
```

**Alasan:** Database zona waktu diinisialisasi sebelum `tz.getLocation` dan `tz.TZDateTime` digunakan.

#### Contoh salah

```dart
final lokasi = tz.getLocation('Asia/Jakarta'); // database belum diinisialisasi
```

**Kesalahan:** Memanggil `tz.getLocation` sebelum inisialisasi database zona waktu.

**Rujukan teknis:**
- `pubspec.yaml` — `timezone: ^0.11.2`.

#### B. Inisialisasi Berdasarkan Platform

Gunakan mekanisme inisialisasi yang sesuai dengan platform:

- **Web:** Gunakan `initializeTimeZone()` dari `package:timezone/browser.dart`.
- **VM/Standalone:** Gunakan `tz.initializeTimeZones()` dari `package:timezone/data/latest.dart`.

Pastikan hanya mekanisme inisialisasi yang sesuai dengan platform target yang digunakan.

#### C. Penanganan Kesalahan

1. Bungkus proses inisialisasi dengan `try`/`catch`.
2. Catat kegagalan inisialisasi agar penyebabnya dapat ditelusuri.
3. Pada platform web, tangani `TimeZoneInitException` apabila exception tersebut terjadi.
4. Jangan melanjutkan proses yang membutuhkan database zona waktu apabila inisialisasi gagal.

### 4.4. Sqflite

**Tujuan:** Memastikan inisialisasi database SQLite menggunakan factory yang sesuai dengan platform target.

Ketentuan:

1. Panggil `sqfliteFfiInit()` sebelum menggunakan database melalui implementasi FFI.
2. Atur `databaseFactory` sesuai platform:
   - Desktop: gunakan `databaseFactoryFfi`.
   - Web: gunakan `databaseFactoryFfiWeb`.
3. Pastikan inisialisasi dan pengaturan `databaseFactory` selesai sebelum database dibuka.
4. Jangan membuka database sebelum mekanisme inisialisasi platform selesai dilakukan.
5. Ikuti contoh implementasi pada folder `example` dari paket terkait:
   - `sqflite`
   - `sqflite_common_ffi`
   - `sqflite_common_ffi_web`

Gunakan implementasi yang sesuai dengan platform dan paket yang benar-benar digunakan dalam proyek.

#### Contoh benar (desktop)

```dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

sqfliteFfiInit();
databaseFactory = databaseFactoryFfi;
```

**Alasan:** Factory FFI diinisialisasi sebelum database dibuka.

#### Contoh salah

```dart
final db = await openDatabase('app.db'); // factory belum diatur
```

**Kesalahan:** Database dibuka sebelum inisialisasi factory platform.

**Rujukan teknis:**
- `lib/main.dart` — pengaturan factory berdasarkan platform.
- `pubspec.yaml` — `sqflite`, `sqflite_common_ffi`, `sqflite_common_ffi_web`.

### 4.5. adaptive_dialog

**Tujuan:** Menyeragamkan mekanisme dialog konfirmasi agar konsisten dan mendukung tampilan adaptif sesuai platform.

Ketentuan:

1. Wajib menggunakan paket `adaptive_dialog` untuk dialog konfirmasi.
2. Gunakan `showOkCancelAlertDialog` untuk konfirmasi dengan pilihan OK dan Cancel.
3. Sesuaikan parameter dialog dengan konteks tindakan yang dikonfirmasi:
   - `context`: BuildContext yang aktif.
   - `title`: Judul konfirmasi.
   - `message`: Penjelasan tindakan.
   - `okLabel`: Label tombol persetujuan.
   - `cancelLabel`: Label tombol pembatalan.
   - `isDestructiveAction`: Gunakan `true` untuk tindakan destruktif, seperti menghapus data.
4. Jangan membuat dialog konfirmasi manual apabila mekanisme dari `adaptive_dialog` sudah memenuhi kebutuhan.

**Contoh implementasi:**

```dart
showOkCancelAlertDialog(
  context: context,
  title: 'Hapus Data?',
  message: 'Data yang dihapus tidak dapat dikembalikan.',
  okLabel: 'Hapus',
  cancelLabel: 'Batal',
  isDestructiveAction: true,
);
```
