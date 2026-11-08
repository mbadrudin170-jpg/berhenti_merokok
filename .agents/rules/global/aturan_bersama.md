## Penambahan Log Debug pada Variabel dan Parameter

Gunakan sistem logging yang sudah tersedia di proyek (mis. `L.i()`, `L.w()`, `L.e()`) untuk mencatat nilai variabel dan parameter, alih-alih membuat sistem logging baru.

**Aturan:**
1. Tambahkan log pada setiap variabel dan parameter yang relevan, setelah variabel mendapatkan nilainya.
2. Format log wajib singkat: nama variabel dan nilainya menggunakan interpolasi, mis. `logger.i('kopi=$kopi, susu=$susu')`.
3. Untuk objek model (Freezed, API, database, repository), cukup tampilkan objek langsung: `logger.i('model=$model')`; jangan uraikan properti satu per satu.
4. Gabungkan variabel yang berkaitan dalam satu pemanggilan log apabila berada pada titik eksekusi yang sama.
5. Jangan mencatat variabel sensitif (password, token, OTP, secret key, kredensial).
6. Jangan mengubah logika bisnis, nilai variabel, tipe data, kondisi percabangan, atau menambah fitur saat menambahkan log.
7. Jangan menambahkan log sebelum variabel mendapatkan nilai.
8. Jangan menambahkan log yang tidak memberikan informasi nilai aktual.
9. Jangan menggunakan `print()` sebagai pengganti logger yang tersedia.
10. Pada `catch`, catat error dengan konteks proses yang gagal dan sertakan stack trace apabila tersedia.
11. Log pada `initState` dan `dispose` diperbolehkan karena hanya dipanggil sekali. Log pada `build()` dihindari apabila memungkinkan karena `build()` dapat dipanggil berulang dan menambah noise; prioritaskan log pada titik yang tidak berfrekuensi tinggi (initState, dispose, method helper, perhitungan).

**Larangan:**
- Jangan membuat sistem logging baru.
- Jangan mencetak properti model satu per satu (gunakan `$model`).
- Jangan mencetak data sensitif.
- Jangan mengubah logika program saat menambahkan log.

**Alasan:**
Format log yang singkat dan konsisten (nama variabel + nilai) memudahkan pelacakan alur eksekusi tanpa menambah noise. Menampilkan objek model langsung menghindari log yang terlalu panjang dan tetap informatif. Larangan mencetak data sensitif menjaga keamanan. Prinsip ini dapat diterapkan pada seluruh proyek Flutter yang memiliki sistem logging. Enam commit terakhir (`f2859a0`, `6bae210`, `f55410a`, `c05f446`, `7b9e8d0`, `be04199`) memperkuat pola ini secara konsisten, termasuk penggabungan variabel terkait dalam satu log (commit `7b9e8d0` memperluas log form impian dengan menggabungkan `_namaController.text`, `_jumlahController.text`, dan `_targetTanggal`; commit `be04199` menggabungkan seluruh variabel perhitungan pada dashboard), penggunaan `L.w` untuk kondisi peringatan (`konfirmasi bukan ok`, `jumlah <= 0`, `biodataAsync loading`), penggunaan `L.e` pada blok catch/error dengan stack trace (termasuk `${biodataAsync.error} ${biodataAsync.stackTrace}`), pola logging siklus hidup widget (`L.i('DashboardScreen initState')`, `L.i('DashboardScreen dispose')`), dan logging pada method helper yang menerima parameter (`L.i('icon=$icon, title=$title, subtitle=$subtitle')`). Log pada `initState` dan `dispose` diperbolehkan karena hanya dipanggil sekali; log pada `build()` dihindari apabila memungkinkan karena dapat dipanggil berulang dan menambah noise. Commit `c05f446` juga merangkum ulang aturan proyek dan global agar tetap fokus dan tidak verbose.

**Sumber evaluasi:**
- Commit: `f2859a0f7b8f6ebeb0befefffa8047a9c3173c04`, `6bae21014ab8f156d70364ea40ff669573de1f37`, `f55410ae5d09de92cb53f1f284ab69051d6af46a`, `c05f4460a316c3bf33aaad30fc1d8a32f66b9c5b`, `7b9e8d054624b8941c1f44b11551fe9ea57a54a1`, `be04199e5b44537ee1052a3815f5af8518308148`
- File: `lib/fitur/dummy/helper/dummy_helper.dart`, `lib/fitur/dummy/screens/dummy_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/screens/form_impian.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`, `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/impian/notifier/impian_notifier.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `.kilo/commands/tambah_log.md`

**Contoh benar:**
```dart
logger.i('dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}');
logger.i('row=$row');
logger.i('biodata=$biodata');
logger.i('impian=$impian');
logger.i('konfirmasi=$konfirmasi');
logger.i('_namaController.text=${_namaController.text}, _jumlahController.text=${_jumlahController.text}, _targetTanggal=$_targetTanggal');
logger.i('listImpian.length=${listImpian.length}, totalJumlah=${impianState.totalJumlah}');
logger.i('DashboardScreen initState');
logger.i('DashboardScreen dispose');
logger.i('biodataAsync=$biodataAsync');
logger.w('konfirmasi bukan ok');
logger.w('jumlah <= 0');
logger.w('biodataAsync loading');
logger.e('Gagal memasukkan data dummy: $e $s');
logger.e('biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}');
logger.i('tanggalBerhenti=$tanggalBerhenti, jumlahRokokPerHari=$jumlahRokokPerHari, hargaPerBungkus=$hargaPerBungkus, hariBerhenti=$hariBerhenti, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat');
logger.i('icon=$icon, title=$title, subtitle=$subtitle');
```

**Contoh salah:**
```dart
logger.i('tes'); // tidak memberikan informasi nilai variabel
logger.i('nama=${model.nama}, umur=${model.umur}'); // menguraikan properti model
print('data=$data'); // menggunakan print() alih-alih logger
```


## Type Promotion untuk Null Safety (Field Objek)

**Aturan:**
1. Field nullable dari objek model wajib disalin terlebih dahulu ke variabel lokal sebelum digunakan dalam kondisi null-check, agar type promotion berlaku.
2. Setelah penyalinan, gunakan variabel lokal tersebut dalam percabangan `== null` dan pemanggilan fungsi, bukan akses properti objek dengan operator `!`.
3. Jangan menggunakan operator `!` untuk memaksakan nilai nullable menjadi non-null apabila nilai tersebut dapat dipromosikan melalui variabel lokal.
4. Prinsip ini melengkapi aturan penanganan null yang sudah ada, dengan fokus pada field objek (bukan hanya parameter constructor atau variabel privat).

**Alasan:**
Type promotion memungkinkan compiler Dart mempromosikan tipe nullable ke non-nullable setelah pemeriksaan null, sehingga operator `!` tidak diperlukan. Penggunaan operator `!` berisiko menimbulkan runtime error jika nilai ternyata null. Commit `1e7b71e` menunjukkan refactoring pada `biodata_screen.dart` untuk menghindari operator `!` dengan menyalin field nullable ke variabel lokal.

**Contoh benar:**
```dart
final tanggalLahir = biodata?.tanggalLahir;
final tanggalMulaiMerokok = biodata?.tanggalMulaiMerokok;

_buildItem(
  'Tanggal lahir',
  tanggalLahir == null
      ? 'Belum dipilih'
      : FormatTanggal.formatDasar(tanggalLahir),
);
```

**Contoh salah:**
```dart
_buildItem(
  'Tanggal lahir',
  biodata.tanggalLahir == null
      ? 'Belum dipilih'
      : FormatTanggal.formatDasar(biodata.tanggalLahir!),
);
```

**Sumber evaluasi:**
- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec`
- File: `lib/fitur/biodata/screens/biodata_screen.dart`


## Import Ordering (Urutan Import)

**Aturan:**
1. Import wajib diurutkan secara alfabetis berdasarkan path package.
2. Import dari package proyek (`package:berhenti_merokok/...`) wajib diurutkan berdasarkan path lengkap.
3. Jangan mengurutkan import secara sembarangan; ikuti urutan alfabetis.
4. Prinsip ini berlaku untuk seluruh file Dart dalam proyek.

**Alasan:**
Urutan import yang konsisten memudahkan pembacaan kode dan pengelolaan dependensi. Commit `1e7b71e` menunjukkan perubahan urutan import pada `biodata_screen.dart` agar mengikuti urutan alfabetis (`biodata_notifier` sebelum `form_biodata`).

**Contoh benar:**
```dart
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

**Contoh salah:**
```dart
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

**Sumber evaluasi:**
- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec`
- File: `lib/fitur/biodata/screens/biodata_screen.dart`


## Migrasi Skema Database SQLite

**Aturan:**
1. Setiap perubahan skema wajib menaikkan versi database (increment satu per migrasi).
2. Metode `onCreate` wajib membuat seluruh tabel yang dibutuhkan aplikasi, termasuk tabel baru.
3. Metode `onUpgrade` wajib menangani setiap versi lama secara kondisional (`if (oldVersion < N)`).
4. Tabel baru pada versi tertentu wajib dibuat baik di `onCreate` maupun di `onUpgrade`.
5. Nama tabel dan kolom wajib didefinisikan sebagai konstanta terpusat, bukan string literal.
6. Perubahan kolom pada tabel lama wajib menggunakan `ALTER TABLE ... ADD COLUMN` di `onUpgrade` dengan kondisi versi yang sesuai.

**Alasan:**
Migrasi skema yang konsisten memastikan pengguna baru maupun lama memiliki skema database yang sama tanpa kehilangan data. Commit `3b67d309` menunjukkan pola migrasi v4 ke v5 yang membuat tabel baru di `onCreate` dan `onUpgrade`.

**Contoh benar:**
```dart
static const int _versiDatabase = 5;
// onCreate: buat semua tabel.
// onUpgrade:
if (oldVersion < 5) {
  await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.baru}(...)');
}
```

**Contoh salah:**
```dart
// Hanya membuat tabel di onCreate, lupa onUpgrade.
```

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/shared/db/sqflite/sqflite.dart`


## Pola Notifier CRUD pada Database

**Aturan:**
1. Notifier database wajib menggunakan `@Riverpod(keepAlive: true)`.
2. Method `build()` wajib memanggil `_ambilSemua()` yang mengambil seluruh data dan memetakan ke model.
3. Setiap method CRUD (`tambah`, `ubah`, `hapus`) wajib:
   a. Mengambil state lama melalui `await future`.
   b. Menjalankan operasi database terlebih dahulu.
   c. Memperbarui `state` dengan `AsyncValue.data(...)` setelah operasi database berhasil.
   d. Menangkap `Exception`, mencatat dengan logger, lalu `rethrow`.
4. Gunakan lapisan akses database (`SqfliteOp` atau setara); jangan memanggil `openDatabase` langsung di notifier.
5. Operasi batch (banyak data) wajib menggunakan `batch(...)` agar atomik dan efisien.

**Alasan:**
State hanya diperbarui setelah operasi database berhasil, mencegah UI tidak sinkron dengan database ketika operasi gagal. Pola ini konsisten pada `ImpianNotifier` dan `DiaryCravingNotifier`.

**Contoh benar:**
```dart
Future<void> tambah(Model model) async {
  try {
    final dataLama = await future;
    final op = const SqfliteOp();
    await op.tambah(NamaTabel.tabel, model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    state = AsyncValue.data(StateBaru(list: [model, ...dataLama.list]));
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan: $e $s');
    rethrow;
  }
}
```

**Contoh salah:**
```dart
// Memperbarui state sebelum operasi database selesai.
state = AsyncValue.data(StateBaru(list: [model, ...list]));
await op.tambah(NamaTabel.tabel, model.toMap());
```

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/notifier/diary_craving_notifier.dart`, `lib/fitur/impian/notifier/impian_notifier.dart`


## Penggunaan `withValues` untuk Opacity Warna

**Aturan:**
1. Gunakan `withValues(alpha: ...)` alih-alih `withOpacity(...)` untuk mengatur opacity warna, sesuai API Flutter terpasang.
2. Pertahankan konsistensi penggunaan pada seluruh widget.

**Alasan:**
Flutter versi terpasang (3.47+) menyediakan `withValues` sebagai pengganti `withOpacity` yang deprecated. Commit `3b67d309` menggunakan `warna.withValues(alpha: 0.2)`.

**Contoh benar:**
```dart
warna.withValues(alpha: 0.2)
```

**Contoh salah:**
```dart
warna.withOpacity(0.2)
```

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/sos_craving/screens/sos_craving_screen.dart`


## Isolasi Widget yang Diperbarui Berkala (Timer/Animasi)

**Aturan:**
1. Widget yang diperbarui secara berkala (mis. `Timer.periodic` per detik) wajib diisolasi ke widget terpisah (`StatefulWidget`) agar hanya widget tersebut yang melakukan rebuild, bukan seluruh halaman.
2. Timer wajib dibatalkan (`cancel()`) di `dispose()` widget yang memilikinya.
3. Di dalam callback timer, periksa `mounted` sebelum memanggil `setState`.
4. Jangan menjalankan `Timer.periodic` pada widget yang mencakup seluruh halaman apabila hanya sebagian tampilan yang perlu diperbarui.
5. Jangan membiarkan timer tetap aktif setelah widget tidak lagi terpasang.

**Alasan:**
Timer yang diletakkan pada widget tingkat halaman menyebabkan seluruh halaman rebuild setiap detik, yang tidak efisien dan dapat mengganggu interaksi pengguna. Isolasi ke widget kecil (mis. `_HeaderPemulihan`, `_TimerCravingView`) membatasi rebuild hanya pada bagian yang membutuhkan pembaruan berkala. Pemeriksaan `mounted` mencegah pembaruan state pada widget yang sudah tidak terpasang. Pola ini terlihat konsisten pada `SosCravingScreen` (`_TimerCravingView`) dan `PemulihanKesehatanScreen` (`_HeaderPemulihan`), yang masing-masing menjalankan `Timer.periodic` sendiri dan membatalkannya di `dispose()`.

**Contoh benar:**
```dart
class _HeaderPemulihan extends StatefulWidget {
  const _HeaderPemulihan({required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  State<_HeaderPemulihan> createState() => _HeaderPemulihanState();
}

class _HeaderPemulihanState extends State<_HeaderPemulihan> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // hanya widget ini yang rebuild tiap detik
    return ...;
  }
}
```

**Contoh salah:**
```dart
// Timer.periodic dijalankan di widget tingkat halaman, menyebabkan
// seluruh halaman rebuild setiap detik.
class _HalamanState extends State<Halaman> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {}); // rebuild seluruh halaman
    });
  }
}
```

**Sumber evaluasi:**
- Commit: `02aa6b29b0669a4f5bf21651b09b43552f65d6f8`, `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/sos_craving/screens/sos_craving_screen.dart`


## Normalisasi Tanggal untuk Perbandingan dan Perhitungan Berbasis Hari

**Aturan:**
1. Sebelum membandingkan atau menghitung selisih hari antara dua tanggal, normalisasi nilai `DateTime` ke komponen tanggal saja (tahun, bulan, hari) dengan membuang komponen waktu.
2. Gunakan `DateTime(tanggal.year, tanggal.month, tanggal.day)` untuk memperoleh representasi tanggal tanpa waktu.
3. Saat menghitung selisih hari dengan `difference(...).inDays`, pastikan kedua operand sudah dinormalisasi agar hasil tidak terpengaruh oleh jam/menit/detik.
4. Hasil perhitungan durasi atau jumlah hari yang dapat bernilai negatif wajib diklem (clamp) ke nol apabila nilai negatif tidak bermakna dalam konteks (mis. "hari smoke-free" tidak boleh negatif).
5. Gunakan `isBefore`/`isAfter` pada nilai yang sudah dinormalisasi untuk menentukan rentang tanggal, agar batas hari konsisten.

**Alasan:**
`DateTime.now()` menyertakan komponen waktu (jam, menit, detik). Jika dibandingkan langsung dengan tanggal yang dinormalisasi (mis. tengah malam), hasil perhitungan hari dapat salah satu hari. Normalisasi memastikan perbandingan dan perhitungan berbasis hari akurat. Pengklaman nilai negatif ke nol mencegah tampilan atau logika yang tidak bermakna (mis. jumlah hari smoke-free negatif sebelum tanggal berhenti). Pola ini terlihat pada `KalenderSmokeFreeScreen` (`_SelHari`, `_GridKalender`) dan dashboard (`_buildCardMilestone`).

**Contoh benar:**
```dart
final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
final tanggalBerhentiDate = DateTime(
  tanggalBerhenti.year,
  tanggalBerhenti.month,
  tanggalBerhenti.day,
);
final totalHari = hariIniDate.difference(tanggalBerhentiDate).inDays + 1;
final totalAman = totalHari < 0 ? 0 : totalHari;

// Klamping durasi negatif ke nol.
final durasi = DateTime.now().difference(tanggalBerhenti);
final aman = durasi.isNegative ? Duration.zero : durasi;
```

**Contoh salah:**
```dart
// Membandingkan DateTime.now() (dengan waktu) langsung dengan tanggal berhenti.
final totalHari = DateTime.now().difference(tanggalBerhenti).inDays + 1;
// Bisa salah satu hari karena komponen waktu.
```

**Sumber evaluasi:**
- Commit: `6fd979fd9e8296bc7d9c40e9037870faef9c846a`, `02aa6b29b0669a4f5bf21651b09b43552f65d6f8`
- File: `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`, `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`

## Ekstraksi Logika Perhitungan Turunan yang Diduplikasi

**Aturan:**
1. Apabila perhitungan turunan yang sama digunakan di lebih dari satu layar, ekstrak ke satu lokasi bersama (ekstensi pada model, helper murni, atau utilitas) agar logika hanya ditulis sekali.
2. Konsumen (layar/widget) wajib menggunakan hasil dari lokasi bersama, bukan menghitung ulang secara inline.
3. Helper murni wajib menerima parameter primitif dan tidak bergantung pada `BuildContext` atau provider.
4. Guard pembagian dengan nol wajib diterapkan pada perhitungan yang melakukan pembagian.

**Alasan:**
Duplikasi perhitungan turunan (mis. `hariBerhenti`, `rokokTidakDiHisap`, `uangDihemat`) di beberapa layar berisiko tidak konsisten jika salah satu diubah. Commit `19f43e5` mengekstrak perhitungan ke ekstensi `BiodataModelPerhitungan` dan helper `hitungBadge`, sehingga logika hanya ditulis sekali dan konsisten di dashboard, impian, dan badge. Prinsip ini berlaku pada seluruh proyek Flutter yang memiliki perhitungan turunan yang digunakan bersama.

**Contoh benar:**
```dart
extension BiodataModelPerhitungan on BiodataModel {
  double get uangDihemat {
    if (batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
  }
}

// Konsumsi di layar.
final uangDihemat = biodata?.uangDihemat ?? 0;
```

**Contoh salah:**
```dart
// Duplikasi perhitungan inline di layar.
double _hitungUangDihemat(BiodataModel? biodata) {
  if (biodata == null) return 0;
  ...
}
```

**Sumber evaluasi:**
- Commit: `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/biodata/model/biodata_model.dart`, `lib/fitur/badge/helper/badge_helper.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/badge/screens/badge_screen.dart`

## Validasi Dukungan Platform dan Izin Runtime

**Aturan:**
1. Sebelum menggunakan API package, periksa dukungan platform berdasarkan versi package yang terpasang. Jangan mengasumsikan API yang sama tersedia di semua platform.
2. Jangan menampilkan kontrol fitur yang tidak didukung platform (misalnya pengingat terjadwal pada Web/Linux).
3. Permintaan izin harus mengikuti kebijakan sistem operasi dan dilakukan pada konteks yang tepat (setelah interaksi pengguna, bukan saat aplikasi pertama dibuka).
4. Periksa hasil izin sebelum menyatakan fitur berhasil diaktifkan. Jangan menyimpan status aktif jika izin sistem belum tersedia.
5. Pisahkan inisialisasi layanan dari permintaan izin pengguna. Inisialisasi boleh dilakukan saat startup, tetapi izin diminta sesuai kebutuhan fitur.
6. Tangani error platform yang tidak didukung (mis. `UnsupportedError`) secara eksplisit, bukan hanya `Exception`.

**Alasan:**
Commit notifikasi (`774431d`) dan saran (`0cb0e52`) menunjukkan kebutuhan membedakan kemampuan berdasarkan platform, meminta izin sesuai kebijakan OS, dan memeriksa hasil izin sebelum mengaktifkan fitur. Permintaan izin otomatis saat startup (termasuk iOS Darwin default) dapat ditolak atau diblokir.

**Contoh benar:**
```dart
if (kIsWeb) {
  // jangan tampilkan pengingat terjadwal
} else if (defaultTargetPlatform == TargetPlatform.android) {
  final izin = await mintaIzinAndroid();
  if (!izin) return;
}
```

**Contoh salah:**
```dart
// Meminta izin saat aplikasi pertama dibuka tanpa konteks fitur.
await plugin.requestNotificationsPermission();
// Menyimpan status aktif tanpa memeriksa hasil izin.
await setAktif(true);
```

**Sumber evaluasi:**
- Commit: `774431dbf61bb330d548785e8d47597c5bdcd123`, `0cb0e52f48f6d6f95f2bfc9e8b82a092bb5f9e4f`
- File: `lib/shared/notifikasi/notifikasi_service.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `saran.md`

## Penggunaan Tipe Exception Khusus untuk Deteksi Error

**Aturan:**
1. Gunakan tipe exception khusus (class yang mengimplementasikan `Exception` atau `Error`) untuk menandai kondisi error yang perlu dideteksi oleh pemanggil, alih-alih melempar `Exception` dengan pesan string lalu mendeteksinya melalui `e.toString().contains(...)`.
2. Pemanggil wajib mendeteksi error melalui `is` (type check), bukan pencocokan string.
3. Tipe exception khusus wajib dideklarasikan sebagai class terpisah dengan dokumentasi singkat, agar mudah diidentifikasi dan diuji.
4. Jangan bergantung pada teks pesan exception untuk menentukan alur program, karena teks dapat berubah dan menyebabkan deteksi gagal.

**Alasan:**
Pencocokan string pada pesan exception (mis. `e.toString().contains('Izin notifikasi tidak diberikan')`) bergantung pada teks yang sama persis. Jika pesan berubah, deteksi gagal dan alur program salah. Commit `07fc8df` mengganti pola ini dengan `IzinNotifikasiTidakDiberikanException` yang diimplementasikan sebagai class khusus, sehingga deteksi dilakukan melalui `e is IzinNotifikasiTidakDiberikanException`. Pola ini dapat diterapkan pada proyek Flutter lain yang membutuhkan deteksi error berdasarkan jenis, bukan teks.

**Contoh benar:**
```dart
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override
  String toString() => 'Izin notifikasi tidak diberikan';
}

// Melempar.
throw const IzinNotifikasiTidakDiberikanException();

// Mendeteksi.
} on Exception catch (e, s) {
  if (e is IzinNotifikasiTidakDiberikanException) {
    // tangani kegagalan izin
  }
}
```

**Contoh salah:**
```dart
throw Exception('Izin notifikasi tidak diberikan');

// Mendeteksi melalui pencocokan string (rentan).
final isIzin = e.toString().contains('Izin notifikasi tidak diberikan');
```

**Sumber evaluasi:**
- Commit: `07fc8df6cf5ea28fe7133b1aee5dae7b05b96590`
- File: `lib/shared/notifikasi/notifikasi_service.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`

## Prinsip Umum Penanganan Beberapa `AsyncValue` pada Satu Layar

**Aturan:**
1. Ketika satu layar menggunakan beberapa provider asynchronous, tangani status loading secara gabungan apabila salah satu data yang dibutuhkan masih loading.
2. Tangani status error untuk setiap provider secara terpisah, dengan pesan error dan tombol retry yang memanggil `ref.refresh(provider)` yang sesuai.
3. Panggil `requireValue` pada masing-masing provider hanya setelah status loading dan error-nya ditangani.
4. Kondisi data tidak lengkap tetap ditangani sebagai tampilan tersendiri dengan informasi dan call-to-action.

**Alasan:**
Aturan khusus sudah mencakup penerapan konkret pada `BadgeScreen` (memuat `biodataProvider` dan `impianProvider`). Prinsip ini dapat diterapkan pada proyek Flutter lain yang menggunakan Riverpod dengan beberapa provider asynchronous pada satu layar, agar loading dan error tetap jelas serta `requireValue` tidak dipanggil pada data yang belum tersedia.

**Contoh benar:**
```dart
final aAsync = ref.watch(providerA);
final bAsync = ref.watch(providerB);
if (aAsync.isLoading || bAsync.isLoading) {
  return const Center(child: CircularProgressIndicator());
}
if (aAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(providerA));
}
if (bAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(providerB));
}
final a = aAsync.requireValue;
final b = bAsync.requireValue;
```

**Contoh salah:**
```dart
// Memanggil requireValue tanpa menangani loading/error (berisiko crash).
final a = aAsync.requireValue;
final b = bAsync.requireValue;
```

**Sumber evaluasi:**
- Commit: `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/badge/screens/badge_screen.dart`
