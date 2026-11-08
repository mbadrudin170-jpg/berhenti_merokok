## Penambahan Log Debug pada Variabel dan Parameter

**Cakupan:**
- Seluruh file Dart yang ditentukan pengguna untuk diberi log debug.
- `lib/shared/utils/l.dart` — referensi implementasi `L` (jangan diubah).
- `lib/app.dart` — lokasi `L.init(ref.container)` (menentukan apakah `L.*` atau `debugPrint()` yang digunakan).

**Aturan wajib:**
1. Gunakan sistem logging yang sudah tersedia (`L.i()`, `L.w()`, `L.e()` dari `lib/shared/utils/l.dart`); jangan membuat sistem logging baru.
2. Tambahkan log pada setiap variabel dan parameter yang relevan, setelah variabel mendapatkan nilainya.
3. Format log wajib singkat: nama variabel dan nilainya menggunakan interpolasi Dart, mis. `L.i('kopi=$kopi, susu=$susu')`.
4. Untuk objek model (Freezed, API, database, repository), cukup tampilkan objek langsung: `L.i('model=$model')`; jangan uraikan properti satu per satu.
5. Gabungkan variabel yang berkaitan dalam satu pemanggilan log apabila berada pada titik eksekusi yang sama.
6. Jangan mencatat variabel sensitif (password, token, OTP, secret key, kredensial); laporkan variabel yang dikecualikan.
7. Pilih `L.*` atau `debugPrint()` berdasarkan urutan inisialisasi `L.init()`: jika jalur eksekusi sudah melewati `L.init()`, gunakan `L.*`; jika belum, gunakan `debugPrint()` dengan pengecekan `kDebugMode`.
8. Jangan mengubah logika bisnis, nilai variabel, tipe data, kondisi percabangan, atau menambah fitur saat menambahkan log.
9. Jangan menambahkan log sebelum variabel mendapatkan nilai.
10. Jangan menambahkan log yang tidak memberikan informasi nilai aktual.
11. Jangan mengubah file di luar daftar target; jangan mengubah file generated (`.g.dart`, `.freezed.dart`).
12. Jangan menambahkan `try-catch` baru hanya demi menambahkan log; pertahankan mekanisme penanganan error yang sudah ada. Pada `catch`, gunakan `L.e('gagal ...: $e $s')` dan sertakan stack trace apabila tersedia.
13. Log pada `initState` dan `dispose` diperbolehkan karena hanya dipanggil sekali. Log pada `build()` dihindari apabila memungkinkan karena `build()` dapat dipanggil berulang dan menambah noise; prioritaskan log pada titik yang tidak berfrekuensi tinggi (initState, dispose, method helper, perhitungan). Log pada getter/properti turunan yang dapat dipanggil berulang saat `build()` (mis. `targetRokokHariIni`, label Enum) juga dihindari.

**Larangan:**
- Jangan menggunakan `print()` sebagai pengganti `L.*`/`debugPrint()`.
- Jangan membuat fungsi logging tambahan.
- Jangan menambahkan package baru.
- Jangan mencetak properti model satu per satu (gunakan `$model`).
- Jangan mencetak data sensitif.
- Jangan menambahkan log berulang tanpa perubahan nilai.
- Jangan mengubah lokasi/mekanisme `L.init()`.

**Alasan:**
Enam commit terakhir (`f2859a0`, `6bae210`, `f55410a`, `c05f446`, `7b9e8d0`, `be04199`) menambahkan log debug secara bertahap pada `DummyHelper`, `DummyScreen`, `ImpianScreen`, `BiodataNotifier`, `ImpianNotifier`, `BiodataScreen`, `FormImpian`, `PengaturanScreen`, dan `DashboardScreen`. Pola yang diterapkan konsisten: format singkat `namaVar=nilai`, tampilan model langsung (`row=$row`, `biodata=$biodata`, `impian=$impian`, `biodataAsync=$biodataAsync`), gabungan variabel terkait dalam satu log (commit `7b9e8d0` memperluas log form impian dengan menggabungkan `_namaController.text`, `_jumlahController.text`, dan `_targetTanggal`; commit `be04199` menggabungkan seluruh variabel perhitungan pada dashboard), penggunaan `L.w` untuk kondisi peringatan (`konfirmasi bukan ok`, `jumlah <= 0`, `biodataAsync loading`), dan penggunaan `L.e` pada blok catch/error dengan stack trace (termasuk `${biodataAsync.error} ${biodataAsync.stackTrace}`). Commit `be04199` juga menunjukkan pola logging siklus hidup widget (`L.i('DashboardScreen initState')`, `L.i('DashboardScreen dispose')`) dan logging pada method helper yang menerima parameter (`L.i('icon=$icon, title=$title, subtitle=$subtitle')`). Log pada `initState` dan `dispose` diperbolehkan karena hanya dipanggil sekali; log pada `build()` dihindari apabila memungkinkan karena dapat dipanggil berulang dan menambah noise (sesuai saran pada `saran.md` dan aturan runtime). Command `.kilo/commands/tambah_log.md` (commit `f2859a0`) mendokumentasikan standar ini untuk penggunaan berulang. Commit `c05f446` juga merangkum ulang aturan proyek dan global agar lebih ringkas, menunjukkan preferensi aturan yang fokus dan tidak verbose.

**Sumber evaluasi:**
- Commit: `f2859a0f7b8f6ebeb0befefffa8047a9c3173c04`, `6bae21014ab8f156d70364ea40ff669573de1f37`, `f55410ae5d09de92cb53f1f284ab69051d6af46a`, `c05f4460a316c3bf33aaad30fc1d8a32f66b9c5b`, `7b9e8d054624b8941c1f44b11551fe9ea57a54a1`, `be04199e5b44537ee1052a3815f5af8518308148`
- File: `lib/fitur/dummy/helper/dummy_helper.dart`, `lib/fitur/dummy/screens/dummy_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/screens/form_impian.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`, `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/impian/notifier/impian_notifier.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `.kilo/commands/tambah_log.md`

**Contoh benar:**
```dart
L.i('dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}');
L.i('row=$row');
L.i('biodata=$biodata');
L.i('impian=$impian');
L.i('konfirmasi=$konfirmasi');
L.i('_namaController.text=${_namaController.text}, _jumlahController.text=${_jumlahController.text}, _targetTanggal=$_targetTanggal');
L.i('listImpian.length=${listImpian.length}, totalJumlah=${impianState.totalJumlah}');
L.i('DashboardScreen initState');
L.i('DashboardScreen dispose');
L.i('biodataAsync=$biodataAsync');
L.w('konfirmasi bukan ok');
L.w('jumlah <= 0');
L.w('biodataAsync loading');
L.e('Gagal memasukkan data dummy: $e $s');
L.e('biodataAsync error: ${biodataAsync.error} ${biodataAsync.stackTrace}');
L.i('tanggalBerhenti=$tanggalBerhenti, jumlahRokokPerHari=$jumlahRokokPerHari, hargaPerBungkus=$hargaPerBungkus, hariBerhenti=$hariBerhenti, rokokTidakDiHisap=$rokokTidakDiHisap, uangDihemat=$uangDihemat');
L.i('icon=$icon, title=$title, subtitle=$subtitle');
```

**Contoh salah:**
```dart
L.i('tes'); // tidak memberikan informasi nilai variabel
L.i('nama=${model.nama}, umur=${model.umur}'); // menguraikan properti model
print('data=$data'); // menggunakan print() alih-alih L.*
```


## Penggunaan Biodata untuk Menghitung Saldo Terkumpul pada Impian

**Cakupan:**
- `lib/fitur/impian/screens/impian_screen.dart` — `_ImpianScreenState`, `_buildSaldoTerkumpul`.
- `lib/fitur/biodata/notifier/biodata_notifier.dart` — `biodataProvider`.
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel`, ekstensi `BiodataModelPerhitungan`.
- `lib/fitur/dashboard/screens/dashboard_screen.dart` — `_buildCardProgres`.
- `lib/fitur/badge/screens/badge_screen.dart` — `_BadgeScreenState`.

**Aturan wajib:**
1. Impian screen wajib melakukan `ref.watch(biodataProvider)` untuk memperoleh data biodata yang digunakan menghitung saldo terkumpul.
2. Saldo terkumpul merupakan uang yang dihemat dari tidak merokok, dihitung dari biodata: hari berhenti (dinormalisasi ke komponen tanggal, minimum 0), rokok tidak dihisap (`jumlahRokokPerHari * hariBerhenti`), dan uang dihemat (`(rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus`).
3. Selama `biodataAsync` masih loading atau error, saldo terkumpul dianggap 0; jangan memanggil `requireValue` sebelum memastikan data tersedia.
4. Perhitungan turunan (`hariBerhenti`, `rokokTidakDiHisap`, `uangDihemat`) wajib didefinisikan sekali pada ekstensi `BiodataModelPerhitungan` di `lib/fitur/biodata/model/biodata_model.dart`, bukan diduplikasi inline di setiap layar. Setiap layar (dashboard, impian, badge) wajib menggunakan getter dari ekstensi (`biodata.hariBerhenti`, `biodata.rokokTidakDiHisap`, `biodata.uangDihemat`).
5. Progress bar dan teks "Sisa" pada setiap item impian wajib berbasis saldo terkumpul (uang yang dihemat), bukan `totalJumlah` dari `ImpianState`.
6. Perhitungan turunan wajib konsisten di seluruh layar; jangan menduplikasi formula dengan versi yang berbeda antara dashboard, impian, dan badge.
7. Guard pembagian dengan nol wajib diterapkan pada getter `uangDihemat` (mis. `if (batangPerBungkus == 0) return 0;`).

**Larangan:**
- Jangan menggunakan `totalJumlah` dari `ImpianState` sebagai saldo terkumpul (saldo berasal dari biodata, bukan dari jumlah impian).
- Jangan memanggil `biodataAsync.requireValue` tanpa memeriksa loading/error terlebih dahulu.
- Jangan menghitung saldo terkumpul di provider (perhitungan bergantung pada waktu saat ini dan lebih tepat di ekstensi model).
- Jangan menduplikasi formula perhitungan uang yang dihemat dengan versi yang berbeda antara dashboard, impian, dan badge.
- Jangan membuat method `_hitungUangDihemat` (atau sejenis) inline di layar; gunakan getter dari ekstensi.

**Alasan:**
Commit `336a72f` mengubah impian screen agar menggunakan biodata sebagai sumber saldo terkumpul (uang yang dihemat dari tidak merokok), menggantikan `totalJumlah` dari `ImpianState`. Perubahan ini menyelaraskan impian dengan dashboard yang sudah menggunakan perhitungan yang sama. Penanganan loading/error biodata dengan nilai default 0 mencegah crash dan tampilan kosong sementara. Commit `19f43e5` mengekstrak perhitungan turunan ke ekstensi `BiodataModelPerhitungan` agar logika `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat` hanya ditulis sekali dan konsisten di dashboard, impian, dan badge (menghapus duplikasi `_hitungUangDihemat`). Perhitungan yang bergantung pada waktu saat ini tetap berada di getter ekstensi (memanggil `DateTime.now()`), bukan di provider, sesuai prinsip bahwa perhitungan sederhana yang bergantung pada waktu saat ini dapat dilakukan di lapisan model.

**Sumber evaluasi:**
- Commit: `336a72f3b67ea7361aea95ac36ae90d08b1e2c6c`, `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`, `lib/fitur/biodata/model/biodata_model.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/badge/screens/badge_screen.dart`

**Contoh benar:**
```dart
// Ekstensi pada model (didefinisikan sekali).
extension BiodataModelPerhitungan on BiodataModel {
  int get hariBerhenti {
    final tanggalBerhenti = tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) return 0;
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );
    final hari = hariIniDate.difference(tanggalBerhentiDate).inDays;
    return hari < 0 ? 0 : hari;
  }

  int get rokokTidakDiHisap => jumlahRokokPerHari * hariBerhenti;

  double get uangDihemat {
    if (batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
  }
}

// Penggunaan di layar.
final biodataAsync = ref.watch(biodataProvider);
BiodataModel? biodata;
if (biodataAsync.isLoading) {
  // saldo tetap 0 sementara
} else if (biodataAsync.hasError) {
  // saldo tetap 0 sementara
} else {
  biodata = biodataAsync.requireValue;
}
final uangDihemat = biodata?.uangDihemat ?? 0;
```

**Contoh salah:**
```dart
// Menggunakan totalJumlah sebagai saldo terkumpul (salah).
_buildSaldoTerkumpul(impianState.totalJumlah);

// Memanggil requireValue tanpa memeriksa loading/error (berisiko crash).
final biodata = biodataAsync.requireValue;
final uangDihemat = _hitungUangDihemat(biodata);

// Duplikasi method inline di layar (salah, gunakan getter ekstensi).
double _hitungUangDihemat(BiodataModel? biodata) { ... }

// Formula berbeda antar layar (tidak konsisten).
final uangDihemat = rokokTidakDiHisap * biodata.hargaRokokPerBungkus; // salah
```


## Type Promotion untuk Null Safety pada Biodata Screen

**Cakupan:**
- `lib/fitur/biodata/screens/biodata_screen.dart` — `_BiodataScreenState.build`, `_buildItem`.

**Aturan wajib:**
1. Field nullable dari objek model (misalnya `BiodataModel`) wajib disalin terlebih dahulu ke variabel lokal sebelum digunakan dalam kondisi null-check, agar type promotion berlaku.
2. Setelah penyalinan, gunakan variabel lokal tersebut dalam percabangan `== null` dan pemanggilan fungsi, bukan akses properti objek dengan operator `!`.
3. Jangan menggunakan operator `!` untuk memaksakan nilai nullable menjadi non-null apabila nilai tersebut dapat dipromosikan melalui variabel lokal.
4. Urutan import wajib mengikuti urutan alfabetis berdasarkan path package.

**Larangan:**
- Jangan menggunakan `biodata.tanggalLahir!` atau `biodata.tanggalMulaiMerokok!` ketika nilai tersebut dapat disalin ke variabel lokal.
- Jangan mengakses properti nullable secara langsung dengan operator `!` apabila type promotion dapat digunakan.
- Jangan mengurutkan import secara sembarangan; ikuti urutan alfabetis.

**Alasan:**
Commit `1e7b71e` melakukan refactoring pada `biodata_screen.dart` untuk menghindari operator `!` dengan menyalin field nullable (`tanggalLahir`, `tanggalMulaiMerokok`, `tanggalMulaiBerhentiMerokok`) ke variabel lokal, sehingga type promotion berlaku dan operator `!` tidak diperlukan. Perubahan ini juga mengubah urutan import agar mengikuti urutan alfabetis (`biodata_notifier` sebelum `form_biodata`).

**Sumber evaluasi:**
- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec`
- File: `lib/fitur/biodata/screens/biodata_screen.dart`

**Contoh benar:**
```dart
final tanggalLahir = biodata?.tanggalLahir;
final tanggalMulaiMerokok = biodata?.tanggalMulaiMerokok;
final tanggalMulaiBerhentiMerokok = biodata?.tanggalMulaiBerhentiMerokok;

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


## Penghapusan Biodata Lama pada Dummy Helper

**Cakupan:**
- `lib/fitur/dummy/helper/dummy_helper.dart` — method yang memasukkan data dummy biodata.

**Aturan wajib:**
1. Sebelum memasukkan data dummy biodata, hapus seluruh baris biodata yang sudah ada dalam database.
2. Penghapusan dilakukan di dalam transaksi yang sama dengan proses insert data dummy, agar data dummy menjadi satu-satunya biodata yang terbaca aplikasi.
3. Tambahkan komentar penjelasan pada kode yang melakukan penghapusan, agar alasan penghapusan (karena `ambilSatu` mengembalikan baris pertama) dapat dipahami.

**Larangan:**
- Jangan memasukkan data dummy biodata tanpa terlebih dahulu menghapus biodata yang ada, karena `ambilSatu` mengembalikan baris pertama dan data dummy mungkin tidak terbaca.
- Jangan melakukan penghapusan di luar transaksi yang sama dengan proses insert.

**Alasan:**
Commit `1e7b71e` menambahkan `await txn.delete(NamaTabel.biodata)` pada `dummy_helper.dart` agar data dummy menjadi satu-satunya biodata yang terbaca aplikasi, karena `ambilSatu` mengembalikan baris pertama. Commit ini juga menambahkan komentar penjelasan pada kode penghapusan.

**Sumber evaluasi:**
- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec`
- File: `lib/fitur/dummy/helper/dummy_helper.dart`

**Contoh benar:**
```dart
// Hapus biodata yang ada agar data dummy menjadi satu-satunya biodata
// yang terbaca aplikasi (ambilSatu mengembalikan baris pertama).
await txn.delete(NamaTabel.biodata);
for (final biodata in dummyBiodata) {
  await txn.insert(
    NamaTabel.biodata,
    biodata.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
```

**Contoh salah:**
```dart
// Memasukkan data dummy tanpa menghapus biodata yang ada.
// ambilSatu mungkin mengembalikan biodata lama, bukan data dummy.
for (final biodata in dummyBiodata) {
  await txn.insert(
    NamaTabel.biodata,
    biodata.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
```


## Pesan Konfirmasi yang Menjelaskan Konsekuensi pada Dummy Screen

**Cakupan:**
- `lib/fitur/dummy/screens/dummy_screen.dart` — `_DummyScreenState` (dialog konfirmasi).

**Aturan wajib:**
1. Pesan konfirmasi pada dialog "Masukkan Dummy" wajib menjelaskan konsekuensi bahwa biodata yang ada akan diganti dengan data dummy.
2. Pesan harus menggunakan bahasa formal dan baku, serta jelas menyebutkan data yang akan terpengaruh.

**Larangan:**
- Jangan menggunakan pesan konfirmasi generik ("Apakah Anda yakin ingin memasukkan data dummy?") tanpa menjelaskan konsekuensi penggantian biodata.
- Jangan membiarkan pengguna tidak mengetahui bahwa biodata lama akan diganti.

**Alasan:**
Commit `1e7b71e` mengubah pesan konfirmasi pada `dummy_screen.dart` dari "Apakah Anda yakin ingin memasukkan data dummy?" menjadi pesan yang menjelaskan bahwa "Biodata yang ada akan diganti dengan data dummy." Perubahan ini meningkatkan kejelasan UX agar pengguna mengetahui konsekuensi tindakan.

**Sumber evaluasi:**
- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec`
- File: `lib/fitur/dummy/screens/dummy_screen.dart`

**Contoh benar:**
```dart
final konfirmasi = await showOkCancelAlertDialog(
  context: context,
  title: 'Masukkan Dummy',
  message:
      'Apakah Anda yakin ingin memasukkan data dummy? '
      'Biodata yang ada akan diganti dengan data dummy.',
  okLabel: 'Masukkan',
  cancelLabel: 'Batal',
);
```

**Contoh salah:**
```dart
final konfirmasi = await showOkCancelAlertDialog(
  context: context,
  title: 'Masukkan Dummy',
  message: 'Apakah Anda yakin ingin memasukkan data dummy?',
  okLabel: 'Masukkan',
  cancelLabel: 'Batal',
);
```


## Migrasi Skema Database SQLite

**Cakupan:**
- `lib/shared/db/sqflite/sqflite.dart` — `AppDatabase`, `_versiDatabase`, `onCreate`, `onUpgrade`.
- `lib/shared/konstanta/nama_tabel.dart` — `NamaTabel`.
- `lib/shared/konstanta/nama_kolom.dart` — `NamaKolom`.

**Aturan wajib:**
1. Setiap perubahan skema wajib menaikkan konstanta `_versiDatabase` (increment satu per migrasi).
2. Metode `onCreate` wajib membuat seluruh tabel yang dibutuhkan aplikasi, termasuk tabel baru, agar instalasi baru memiliki skema lengkap.
3. Metode `onUpgrade` wajib menangani setiap versi lama secara kondisional menggunakan `if (oldVersion < N)` untuk setiap versi yang ditambahkan.
4. Tabel baru pada versi tertentu wajib dibuat baik di `onCreate` maupun di `onUpgrade` (agar pengguna lama mendapatkan tabel baru).
5. Nama tabel dan kolom baru wajib didefinisikan di `NamaTabel` dan `NamaKolom`, bukan string literal di kode database.
6. Perubahan kolom pada tabel lama wajib menggunakan `ALTER TABLE ... ADD COLUMN` di `onUpgrade` dengan kondisi versi yang sesuai.

**Larangan:**
- Jangan menaikkan versi database tanpa memperbarui `onCreate` dan `onUpgrade`.
- Jangan membuat tabel baru hanya di `onCreate` tanpa menangani `onUpgrade` (pengguna lama tidak akan mendapatkan tabel).
- Jangan menggunakan string literal untuk nama tabel/kolom baru.
- Jangan menghapus data pengguna saat migrasi kecuali memang diperlukan dan terdokumentasi.

**Alasan:**
Commit `3b67d309` menaikkan skema dari v4 ke v5 untuk menambah tabel `diary_craving`. Tabel baru dibuat di `onCreate` (instalasi baru) dan di `onUpgrade` dengan kondisi `oldVersion < 5` (pengguna lama). Pola ini memastikan seluruh pengguna, baru maupun lama, memiliki skema yang konsisten tanpa kehilangan data.

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/shared/db/sqflite/sqflite.dart`, `lib/shared/konstanta/nama_tabel.dart`, `lib/shared/konstanta/nama_kolom.dart`

**Contoh benar:**
```dart
static const int _versiDatabase = 5;

// onCreate: buat semua tabel.
await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(...)');

// onUpgrade:
if (oldVersion < 5) {
  await db.execute('CREATE TABLE IF NOT EXISTS ${NamaTabel.diaryCraving}(...)');
}
```

**Contoh salah:**
```dart
// Hanya membuat tabel di onCreate, lupa onUpgrade: pengguna lama tidak mendapatkan tabel.
static const int _versiDatabase = 5;
// onCreate: create table diary_craving
// onUpgrade: (kosong / tidak menangani v5)
```


## Pola Notifier CRUD pada Database

**Cakupan:**
- `lib/fitur/impian/notifier/impian_notifier.dart` — `ImpianNotifier`.
- `lib/fitur/diary_craving/notifier/diary_craving_notifier.dart` — `DiaryCravingNotifier`.

**Aturan wajib:**
1. Notifier database wajib menggunakan `@Riverpod(keepAlive: true)` agar state tidak hilang saat tidak ada listener.
2. Method `build()` wajib memanggil `_ambilSemua()` yang mengambil seluruh data dari database dan memetakan ke model.
3. Setiap method CRUD (`tambah`, `ubah`, `hapus`) wajib:
   a. Mencatat parameter/log awal dengan `L.i`.
   b. Mengambil state lama melalui `await future`.
   c. Menjalankan operasi database terlebih dahulu.
   d. Memperbarui `state` dengan `AsyncValue.data(...)` setelah operasi database berhasil.
   e. Mencatat keberhasilan dengan `L.s`.
   f. Menangkap `Exception` dengan `on Exception catch (e, s)`, mencatat dengan `L.e`, lalu `rethrow`.
4. Gunakan `SqfliteOp` sebagai lapisan akses database; jangan memanggil `openDatabase` langsung di notifier.
5. Operasi batch (banyak data) wajib menggunakan `op.batch(...)` agar atomik dan efisien.

**Larangan:**
- Jangan memperbarui `state` sebelum operasi database selesai (kecuali mengikuti pola optimistic update pada aturan Riverpod #9).
- Jangan menelan exception; wajib `rethrow` agar UI dapat menangani.
- Jangan membuat instance database baru di notifier.

**Alasan:**
Pola ini konsisten antara `ImpianNotifier` dan `DiaryCravingNotifier`: state hanya diperbarui setelah operasi database berhasil, dengan penanganan error yang terstruktur. Hal ini mencegah state UI tidak sinkron dengan database ketika operasi gagal.

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/notifier/diary_craving_notifier.dart`, `lib/fitur/impian/notifier/impian_notifier.dart`

**Contoh benar:**
```dart
Future<void> tambah(DiaryCravingModel craving) async {
  L.i('craving.id=${craving.id}');
  try {
    final dataLama = await future;
    final op = const SqfliteOp();
    await op.tambah(NamaTabel.diaryCraving, craving.toSqflite(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    state = AsyncValue.data(
      DiaryCravingState(
        listCraving: [craving, ...dataLama.listCraving],
        jumlahCraving: dataLama.jumlahCraving + 1,
      ),
    );
    L.s('Diary craving berhasil disimpan');
  } on Exception catch (e, s) {
    L.e('Gagal menyimpan diary craving: $e $s');
    rethrow;
  }
}
```

**Contoh salah:**
```dart
// Memperbarui state sebelum operasi database selesai.
state = AsyncValue.data(DiaryCravingState(listCraving: [craving, ...list]));
await op.tambah(NamaTabel.diaryCraving, craving.toSqflite()); // jika gagal, state sudah berubah
```


## Model dan State Freezed menggunakan `abstract class`

**Cakupan:**
- `lib/fitur/diary_craving/model/diary_craving_model.dart` — `DiaryCravingModel`.
- `lib/fitur/diary_craving/state/diary_craving_state.dart` — `DiaryCravingState`.

**Aturan wajib:**
1. Model dan state yang dibuat dengan Freezed pada proyek ini wajib menggunakan `abstract class`, bukan `class` biasa.
2. Model database wajib menyediakan factory `fromSqflite(Map<String, Object?> row)` dan method `toSqflite()` untuk konversi ke/dari SQLite.
3. Parsing nilai dari database wajib menggunakan `ParserUtil`.
4. Konversi tanggal ke UTC wajib dilakukan di `toSqflite()` (`toUtc().toIso8601String()`), dan konversi ke lokal wajib dilakukan di `fromSqflite()` (`parseDateTime(...)?.toLocal()`).

**Larangan:**
- Jangan membuat model/state Freezed dengan `class` biasa.
- Jangan melakukan parsing `dynamic` dari database secara langsung tanpa `ParserUtil`.
- Jangan menyimpan waktu lokal seolah-olah UTC.

**Alasan:**
Commit `3b67d309` membuat `DiaryCravingModel` dan `DiaryCravingState` dengan `abstract class` Freezed. Model menyediakan `fromSqflite`/`toSqflite` yang menggunakan `ParserUtil` dan konversi UTC, konsisten dengan aturan penyimpanan tanggal.

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/model/diary_craving_model.dart`, `lib/fitur/diary_craving/state/diary_craving_state.dart`

**Contoh benar:**
```dart
@freezed
abstract class DiaryCravingModel with _$DiaryCravingModel {
  const DiaryCravingModel._();
  const factory DiaryCravingModel({...}) = _DiaryCravingModel;

  factory DiaryCravingModel.fromSqflite(Map<String, Object?> row) {...}
  Map<String, Object?> toSqflite() {...}
}
```

**Contoh salah:**
```dart
@freezed
class DiaryCravingModel with _$DiaryCravingModel { ... } // class biasa, bukan abstract
```


## Konfirmasi sebelum Menyimpan pada Form

**Cakupan:**
- `lib/fitur/diary_craving/screens/form_diary_craving.dart` — `_FormDiaryCravingState._simpan`.

**Aturan wajib:**
1. Sebelum menyimpan data, tampilkan dialog konfirmasi (`showOkCancelAlertDialog`) yang menjelaskan tindakan yang akan dilakukan.
2. Hanya jalankan penyimpanan jika pengguna menekan OK.
3. Selama proses penyimpanan, aktifkan flag `_isLoading` dan tampilkan loading overlay (`EasyLoading`).
4. Setelah selesai (berhasil/gagal), hentikan loading dan kembalikan flag.

**Larangan:**
- Jangan menyimpan data tanpa konfirmasi pengguna.
- Jangan membiarkan proses penyimpanan berjalan tanpa indikator loading.

**Alasan:**
Commit `3b67d309` menambahkan dialog konfirmasi "Apakah Anda yakin ingin menyimpan catatan craving ini?" sebelum menyimpan, serta flag `_isLoading` dan `EasyLoading` selama proses. Pola ini konsisten dengan UX yang jelas.

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/screens/form_diary_craving.dart`

**Contoh benar:**
```dart
final konfirmasi = await showOkCancelAlertDialog(
  context: context,
  title: 'Simpan Craving',
  message: 'Apakah Anda yakin ingin menyimpan catatan craving ini?',
  okLabel: 'Simpan',
  cancelLabel: 'Batal',
);
if (konfirmasi != OkCancelResult.ok) return;
```

**Contoh salah:**
```dart
// Menyimpan langsung tanpa konfirmasi.
await ref.read(diaryCravingProvider.notifier).tambah(model);
```


## Empty State pada Daftar

**Cakupan:**
- `lib/fitur/diary_craving/screens/diary_craving_screen.dart` — `_EmptyDiaryCraving`.

**Aturan wajib:**
1. Ketika daftar data kosong, tampilkan widget empty state yang informatif (ikon, judul, deskripsi singkat).
2. Sertakan call-to-action (mis. tombol FAB) agar pengguna dapat menambah data.
3. Empty state wajib dibungkus `SafeArea` dan memiliki padding tepi layar.

**Larangan:**
- Jangan menampilkan layar kosong tanpa informasi atau CTA.

**Alasan:**
Commit `3b67d309` menambahkan `_EmptyDiaryCraving` dengan ikon, judul "Belum ada catatan craving", deskripsi, dan FAB untuk menambah data. Pola ini meningkatkan UX.

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/screens/diary_craving_screen.dart`

**Contoh benar:**
```dart
class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.book, size: 48),
              Text('Belum ada catatan craving',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Tekan tombol + untuk mencatat craving pertama.',
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
```

**Contoh salah:**
```dart
// Menampilkan layar kosong tanpa informasi.
if (list.isEmpty) return const Scaffold(body: SizedBox.shrink());


## Penanganan State Asynchronous dan Data Kosong pada Layar

**Cakupan:**
- `lib/fitur/diary_craving/screens/diary_craving_screen.dart` — `_DiaryCravingScreenState.build`.
- `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart` — `_PemulihanKesehatanScreenState.build`.

**Aturan wajib:**
1. Layar yang memuat data asynchronous wajib menangani status `isLoading` terlebih dahulu (tampilkan indikator loading).
2. Setelah itu, tangani status `hasError` (tampilkan pesan error dan tombol retry yang memanggil `ref.refresh(provider)`).
3. Setelah data tersedia (`requireValue`), tangani kondisi data kosong (empty state) dan kondisi data tidak lengkap (mis. biodata null, tanggal berhenti null) sebagai tampilan tersendiri dengan informasi dan call-to-action.
4. Gunakan early return (guard clause) untuk setiap kondisi tersebut agar alur build tetap linear dan mudah dibaca.
5. Gunakan `const SizedBox.shrink()` untuk widget kondisional yang disembunyikan (mis. kartu milestone ketika belum ada tanggal berhenti).
6. Setelah `await`/operasi asynchronous, periksa `mounted` sebelum mengakses `context` atau memanggil `setState`.

**Larangan:**
- Jangan memanggil `requireValue` sebelum memastikan `isLoading` dan `hasError` sudah ditangani.
- Jangan menampilkan layar kosong tanpa informasi atau CTA ketika data kosong.
- Jangan menggabungkan penanganan loading, error, dan data kosong dalam satu blok yang sulit dibaca.

**Alasan:**
Pola ini konsisten pada `DiaryCravingScreen` (loading → error dengan retry → empty state dengan FAB) dan `PemulihanKesehatanScreen` (loading → error dengan retry → biodata null → belum berhenti → daftar milestone). Penanganan setiap status sebagai tampilan tersendiri memberikan kepastian kepada pengguna (UX) dan mencegah crash akibat `requireValue` pada data yang belum tersedia. Early return menjaga keterbacaan build method.

**Sumber evaluasi:**
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`, `02aa6b29b0669a4f5bf21651b09b43552f65d6f8`
- File: `lib/fitur/diary_craving/screens/diary_craving_screen.dart`, `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`

**Contoh benar:**
```dart
final dataAsync = ref.watch(provider);

if (dataAsync.isLoading) {
  return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
if (dataAsync.hasError) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Gagal memuat data'),
          OutlinedButton(
            onPressed: () => ref.refresh(provider),
            child: const Text('Coba lagi'),
          ),
        ],
      ),
    ),
  );
}

final state = dataAsync.requireValue;
if (state.list.isEmpty) {
  return const Scaffold(body: _EmptyState());
}
return Scaffold(body: _Daftar(state.list));
```

**Contoh salah:**
```dart
// Memanggil requireValue tanpa menangani loading/error (berisiko crash).
final state = dataAsync.requireValue;
return Scaffold(body: ListView(...));
```


## Normalisasi Tanggal untuk Perbandingan dan Perhitungan Berbasis Hari

**Cakupan:**
- `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart` — `_KalenderSmokeFreeScreenState.build`, `_GridKalender`, `_SelHari`.
- `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart` — `_PemulihanKesehatanScreenState.build`, `_HeaderPemulihan`.
- `lib/fitur/dashboard/screens/dashboard_screen.dart` — `_DashboardScreenState._buildCardMilestone`.

**Aturan wajib:**
1. Sebelum membandingkan atau menghitung selisih hari antara dua tanggal, normalisasi nilai `DateTime` ke komponen tanggal saja (tahun, bulan, hari) dengan membuang komponen waktu.
2. Gunakan `DateTime(tanggal.year, tanggal.month, tanggal.day)` untuk memperoleh representasi tanggal tanpa waktu.
3. Saat menghitung selisih hari dengan `difference(...).inDays`, pastikan kedua operand sudah dinormalisasi agar hasil tidak terpengaruh oleh jam/menit/detik.
4. Hasil perhitungan durasi atau jumlah hari yang dapat bernilai negatif wajib diklem (clamp) ke nol apabila nilai negatif tidak bermakna dalam konteks (mis. "hari smoke-free" tidak boleh negatif).
5. Gunakan `isBefore`/`isAfter` pada nilai yang sudah dinormalisasi untuk menentukan rentang tanggal, agar batas hari konsisten.

**Larangan:**
- Jangan membandingkan `DateTime.now()` (yang menyertakan waktu) langsung dengan tanggal yang dinormalisasi tanpa penyesuaian.
- Jangan membiarkan hasil perhitungan hari bernilai negatif pada konteks yang mensyaratkan nilai non-negatif.
- Jangan menggunakan komponen waktu dalam penentuan status hari (smoke-free / belum) pada kalender.

**Alasan:**
`DateTime.now()` menyertakan komponen waktu (jam, menit, detik). Jika dibandingkan langsung dengan tanggal yang dinormalisasi (mis. tengah malam), hasil perhitungan hari dapat salah satu hari. Normalisasi memastikan perbandingan dan perhitungan berbasis hari akurat. Pengklaman nilai negatif ke nol mencegah tampilan atau logika yang tidak bermakna. Pola ini konsisten pada `KalenderSmokeFreeScreen` (normalisasi `hariIni` dan `tanggalBerhenti` sebelum menghitung total hari smoke-free dan menentukan status sel kalender), `PemulihanKesehatanScreen`/dashboard (klamping durasi negatif ke `Duration.zero`).

**Sumber evaluasi:**
- Commit: `6fd979fd9e8296bc7d9c40e9037870faef9c846a`, `02aa6b29b0669a4f5bf21651b09b43552f65d6f8`
- File: `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`, `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`

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

## Penanganan Beberapa Provider Asynchronous pada Satu Layar

**Cakupan:**
- `lib/fitur/badge/screens/badge_screen.dart` — `_BadgeScreenState.build`.

**Aturan wajib:**
1. Ketika layar memuat lebih dari satu provider asynchronous, tangani status `isLoading` gabungan (tampilkan indikator loading jika salah satu masih loading).
2. Tangani status `hasError` untuk setiap provider secara terpisah, dengan pesan error dan tombol retry yang memanggil `ref.refresh(provider)` yang sesuai.
3. Panggil `requireValue` pada masing-masing provider hanya setelah status loading dan error-nya ditangani.
4. Kondisi data tidak lengkap (mis. biodata null) tetap ditangani sebagai tampilan tersendiri dengan informasi dan call-to-action.

**Larangan:**
- Jangan memanggil `requireValue` pada provider yang masih loading atau error.
- Jangan menggabungkan penanganan error beberapa provider menjadi satu blok yang tidak jelas provider mana yang gagal.

**Alasan:**
Commit `19f43e5` menambahkan `BadgeScreen` yang memuat `biodataProvider` dan `impianProvider` sekaligus. Loading ditangani secara gabungan (`biodataAsync.isLoading || impianAsync.isLoading`), sedangkan error ditangani terpisah dengan retry yang sesuai provider. Pola ini menjaga kejelasan sumber kegagalan dan mencegah crash akibat `requireValue` pada data yang belum tersedia.

**Sumber evaluasi:**
- Commit: `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/badge/screens/badge_screen.dart`

**Contoh benar:**
```dart
final biodataAsync = ref.watch(biodataProvider);
final impianAsync = ref.watch(impianProvider);

if (biodataAsync.isLoading || impianAsync.isLoading) {
  return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
if (biodataAsync.hasError) {
  // retry biodataProvider
}
if (impianAsync.hasError) {
  // retry impianProvider
}

final biodata = biodataAsync.requireValue;
final impianState = impianAsync.requireValue;
```

**Contoh salah:**
```dart
// Memanggil requireValue tanpa menangani loading/error (berisiko crash).
final biodata = biodataAsync.requireValue;
final impianState = impianAsync.requireValue;
```

## Ekstraksi Perhitungan Turunan ke Ekstensi Model

**Cakupan:**
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel`, ekstensi `BiodataModelPerhitungan`.
- `lib/fitur/biodata/screens/form_biodata.dart` — form input yang menyimpan field sumber perhitungan.
- `lib/fitur/dashboard/screens/dashboard_screen.dart` — `_buildCardProgres`.
- `lib/fitur/impian/screens/impian_screen.dart` — `_ImpianScreenState`.
- `lib/fitur/badge/screens/badge_screen.dart` — `_BadgeScreenState`.
- `lib/fitur/badge/helper/badge_helper.dart` — `hitungBadge`.

**Aturan wajib:**
1. Perhitungan turunan yang digunakan lebih dari satu layar (mis. `hariBerhenti`, `rokokTidakDiHisap`, `uangDihemat`) wajib didefinisikan sekali pada ekstensi di atas model sumber (`BiodataModelPerhitungan`), bukan diduplikasi inline di setiap layar.
2. Ekstensi wajib ditempatkan pada file model yang sama (`lib/fitur/biodata/model/biodata_model.dart`), setelah definisi class Freezed.
3. Guard pembagian dengan nol wajib diterapkan pada getter yang melakukan pembagian (mis. `if (batangPerBungkus == 0) return 0;`).
4. Perhitungan yang bergantung pada waktu saat ini (`DateTime.now()`) boleh dilakukan di getter ekstensi, dengan normalisasi tanggal sesuai aturan normalisasi tanggal.
5. Helper fungsi murni yang menerima parameter primitif (mis. `hitungBadge`) wajib ditempatkan pada folder `helper/` fitur terkait dan tidak bergantung pada `BuildContext` atau provider.
6. Layar wajib mengonsumsi getter/helper tersebut, bukan menghitung ulang secara inline.

**Larangan:**
- Jangan membuat method perhitungan inline (mis. `_hitungUangDihemat`) di layar yang menggandakan logika yang sudah ada di ekstensi/helper.
- Jangan meletakkan perhitungan turunan di provider (perhitungan bergantung pada waktu saat ini dan lebih tepat di lapisan model).
- Jangan membiarkan formula berbeda antar layar untuk besaran yang sama.

**Alasan:**
Commit `19f43e5` mengekstrak perhitungan turunan ke ekstensi `BiodataModelPerhitungan` dan helper `hitungBadge` agar logika hanya ditulis sekali dan konsisten di dashboard, impian, dan badge. Perubahan ini juga menghapus saran sebelumnya tentang duplikasi `_hitungUangDihemat`. Ekstensi pada model menjaga konsistensi dan memudahkan pengujian; helper murni di folder `helper/` menjaga pemisahan tanggung jawab. Guard pembagian dengan nol mencegah crash ketika `batangPerBungkus` bernilai 0.

**Sumber evaluasi:**
- Commit: `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/biodata/model/biodata_model.dart`, `lib/fitur/badge/helper/badge_helper.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/badge/screens/badge_screen.dart`

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

## Standar Penggunaan `flutter_local_notifications` versi 22.3.3 pada Notifikasi Harian

**Cakupan:**
- `lib/shared/notifikasi/notifikasi_service.dart` — `NotifikasiService`.
- `lib/main.dart` — inisialisasi plugin sebelum `runApp`.
- `lib/app.dart` — penjadwalan ulang saat aplikasi dibuka.
- `lib/fitur/pengaturan/screens/pengaturan_screen.dart` — toggle, pemilih waktu, uji coba.
- `android/app/src/main/AndroidManifest.xml`, `android/app/build.gradle.kts` — konfigurasi Android.

**Catatan versi:** Aturan ini ditulis untuk `flutter_local_notifications` versi `22.3.3`. Jika versi package berubah, AI wajib memeriksa dokumentasi versi baru sebelum menerapkan konfigurasi lama.

**Aturan wajib:**
1. Periksa dukungan fitur berdasarkan platform dan versi plugin sebelum menggunakan API penjadwalan. Jangan mengasumsikan API yang sama tersedia di semua platform.
2. Jangan menggunakan penjadwalan berulang (`matchDateTimeComponents`, `zonedSchedule` dengan pengulangan) pada Web, Linux, atau Windows dengan plugin versi 22.3.3, karena browser/desktop tidak mendukung notifikasi terjadwal atau berulang melalui plugin ini. macOS didukung untuk penjadwalan terjadwal melalui `zonedSchedule` (hapus macOS dari daftar platform yang melempar `UnsupportedError`).
3. Lengkapi receiver dan izin Android untuk penjadwalan serta pemulihan setelah restart: tambahkan `RECEIVE_BOOT_COMPLETED` serta deklarasi `ScheduledNotificationReceiver` dan `ScheduledNotificationBootReceiver` sesuai dokumentasi plugin. Jangan menambahkan izin exact alarm karena implementasi menggunakan `AndroidScheduleMode.inexactAllowWhileIdle`.
4. Aktifkan core library desugaring sesuai persyaratan plugin bila diperlukan: `isCoreLibraryDesugaringEnabled = true`, dependency `com.android.tools:desugar_jdk_libs:2.1.4`, dan verifikasi `compileSdk` minimal 35. AGP minimal 8.11.1.
5. Jangan meminta izin notifikasi secara otomatis saat aplikasi baru dibuka (termasuk iOS `DarwinInitializationSettings` dengan `requestAlertPermission`/`requestSoundPermission`/`requestBadgePermission` default `true`). Minta izin ketika pengguna secara sadar mengaktifkan pengingat.
6. Periksa hasil izin sebelum menyimpan status pengingat aktif. Jangan menyimpan status aktif jika izin sistem belum tersedia. Periksa kembali izin ketika aplikasi dibuka karena pengguna dapat mengubahnya melalui pengaturan sistem.
7. Pastikan jadwal, `SharedPreferences`, dan tampilan tetap konsisten ketika operasi gagal: rollback state, tampilkan feedback kegagalan, dan jangan simpan status aktif jika penjadwalan gagal.
8. Tangani kegagalan penjadwalan ulang ketika aplikasi dibuka: catat error melalui logger, jangan biarkan Future menjadi unhandled, dan pastikan kegagalan fitur notifikasi tidak mengganggu fitur utama aplikasi.
9. Pisahkan ID notifikasi uji coba dari ID pengingat utama agar notifikasi uji coba tidak memperbarui atau menggantikan jadwal utama.
10. Penanganan tap notifikasi wajib membedakan tiga kondisi lifecycle aplikasi: foreground (aplikasi aktif), background, dan terminated. Pada kondisi terminated, gunakan `getNotificationAppLaunchDetails()` untuk memperoleh notifikasi yang meluncurkan aplikasi dan lakukan navigasi setelah navigator siap. Jangan mengandalkan callback `onDidReceiveNotificationResponse` saja untuk kondisi terminated.
11. Validasi payload notifikasi: parse `kategori` dan `id`; hanya proses kategori yang dikenal; jika payload null, tidak valid, atau kategori tidak dikenal, catat peringatan dan jangan lakukan navigasi yang tidak sesuai. ID yang tidak ditemukan atau tidak diperlukan oleh tujuan navigasi tidak boleh menyebabkan crash.
12. Ketika izin sistem dicabut, batalkan jadwal yang tersimpan di sistem operasi (`_plugin.cancel`), perbarui preferensi (`setAktif(false)`), dan pastikan tidak ada jadwal lama tertinggal. Saat pengguna mengaktifkan kembali, minta izin terlebih dahulu dan buat jadwal baru. Jangan hanya mengubah SharedPreferences tanpa memeriksa kondisi jadwal pada sistem operasi.
13. Konsistensi perubahan waktu pengingat: simpan nilai waktu lama sebelum perubahan; terapkan nilai baru hanya setelah penjadwalan atau penyimpanan berhasil; jika gagal, pulihkan nilai lama dan tampilkan pesan kegagalan; pastikan jadwal sistem operasi, preferensi, dan tampilan tetap konsisten. Jangan membiarkan kegagalan pada salah satu tahap meninggalkan kondisi data yang berbeda.
14. Jangan melepas Future navigasi atau loading (`unawaited`) tanpa penanganan error. Bungkus `Nav.pushAndRemoveUntil(...)` serta `EasyLoading.show(...)` dan `EasyLoading.dismiss()` yang dilepas dengan `unawaited(...)` menggunakan `try/catch` atau `.catchError(...)` yang mencatat error melalui `L.e`, sesuai aturan global penanganan error Future yang dilepas.
15. Gunakan tipe exception khusus (class yang mengimplementasikan `Exception`) untuk menandai kondisi error yang perlu dideteksi oleh pemanggil, alih-alih melempar `Exception` dengan pesan string lalu mendeteksinya melalui `e.toString().contains(...)`. Pemanggil wajib mendeteksi melalui `is` (type check). Contoh: `IzinNotifikasiTidakDiberikanException` menggantikan `Exception('Izin notifikasi tidak diberikan')` dan `e.toString().contains('Izin notifikasi tidak diberikan')`.

**Larangan:**
- Jangan meminta izin notifikasi Web saat aplikasi pertama dibuka; minta izin setelah pengguna mengaktifkan notifikasi. Jangan tampilkan pengaturan pengingat terjadwal pada platform yang tidak mendukung.
- Jangan tangkap hanya `Exception`; tangani `UnsupportedError` secara eksplisit pada platform yang tidak mendukung.
- Jangan gunakan ID yang sama untuk notifikasi uji coba dan pengingat utama.
- Jangan menyatakan fitur notifikasi aktif tanpa memeriksa izin sistem terlebih dahulu.
- Jangan mengandalkan callback tap biasa untuk menangani notifikasi yang meluncurkan aplikasi dari kondisi terminated.
- Jangan memproses kategori notifikasi yang tidak dikenal tanpa pencatatan peringatan.
- Jangan mengubah preferensi tanpa memastikan jadwal sistem operasi konsisten.
- Jangan memanggil `EasyLoading.show()` atau `EasyLoading.dismiss()` tanpa `.catchError(...)` ketika dilepas dengan `unawaited()`.
- Jangan mendeteksi error melalui `e.toString().contains(...)`; gunakan tipe exception khusus dan `is`.

**Alasan:**
Commit `774431d` menambahkan pengingat harian terjadwal dengan toggle dan pemilih waktu. `saran.md` (commit `0cb0e52`) mencatat temuan bahwa AndroidManifest belum menyertakan receiver dan izin pemulihan, core library desugaring belum aktif, Web tidak mendukung notifikasi terjadwal, izin iOS diminta terlalu awal, hasil izin tidak diperiksa sebelum menyimpan status aktif, waktu pengingat diperbarui sebelum penjadwalan selesai, `mounted` belum konsisten, Future `unawaited()` tidak menangani error, payload tap belum dinavigasi, zona waktu tetap `Asia/Jakarta`, dan ID uji coba sama dengan ID pengingat utama. Aturan ini mencegah pengulangan temuan tersebut.

**Contoh benar:**
```dart
// Menangani tap notifikasi pada tiga kondisi lifecycle.
final launchDetails = await _plugin.getNotificationAppLaunchDetails();
if (launchDetails?.didNotificationLaunchApp ?? false) {
  final response = launchDetails!.notificationResponse;
  _navigasiBerdasarkanPayload(response?.payload);
}

// Validasi payload dengan kategori yang dikenal.
String? kategori;
String? id;
if (payload != null) {
  for (final part in payload.split('&')) {
    final kv = part.split('=');
    if (kv.length == 2) {
      if (kv[0] == 'kategori') kategori = kv[1];
      if (kv[0] == 'id') id = kv[1];
    }
  }
}
if (kategori == 'pengingat_harian') {
  unawaited(Nav.pushAndRemoveUntil(context, const Home())
      .catchError((Object e, StackTrace s) {
    L.e('Gagal navigasi dari notifikasi: $e $s');
  }));
} else {
  L.w('kategori notifikasi tidak dikenal: $kategori');
}

// Menampilkan loading dengan penanganan error (unawaited).
unawaited(
  EasyLoading.show(
    status: 'Memproses...',
    maskType: EasyLoadingMaskType.black,
  ).catchError((Object e, StackTrace s) {
    L.e('Gagal menampilkan loading: $e $s');
  }),
);

// Menutup loading dengan penanganan error (unawaited).
unawaited(
  EasyLoading.dismiss().catchError((Object e, StackTrace s) {
    L.e('Gagal menutup loading: $e $s');
  }),
);
```

**Contoh salah:**
```dart
// Mengandalkan callback tap biasa untuk kondisi terminated.
static void _onTapNotifikasi(NotificationResponse response) {
  Nav.pushAndRemoveUntil(context, const Home()); // tanpa penanganan error
}

// Memproses kategori tidak dikenal tanpa validasi.
if (kategori != null) {
  Nav.pushAndRemoveUntil(context, const HalamanLain()); // kategori tidak divalidasi
}

// Melepas EasyLoading tanpa penanganan error.
unawaited(EasyLoading.show(status: 'Memproses...'));
unawaited(EasyLoading.dismiss());
```

**Sumber evaluasi:**
- Commit: `774431dbf61bb330d548785e8d47597c5bdcd123`, `0cb0e52f48f6d6f95f2bfc9e8b82a092bb5f9e4f`, `9dff35ade58c73784ce27927efad98b429ee97cb`, `a30b6b6e4377b55eadecb6b83b0e4c05faa985b5`, `2a5a357429d44d7302ce54d46b378fe2ce6a0cb6`, `9f3e88936232b3b837218db3ae22d9d835a1aa99`
- File: `lib/shared/notifikasi/notifikasi_service.dart`, `lib/main.dart`, `lib/app.dart`, `lib/fitur/pengaturan/screens/pengaturan_screen.dart`, `android/app/src/main/AndroidManifest.xml`, `saran.md`


## Zona Waktu Perangkat untuk Pengingat Harian

**Cakupan:**
- `lib/shared/notifikasi/notifikasi_service.dart` — inisialisasi layanan notifikasi dan penentuan zona waktu lokal.

**Catatan versi:**

Implementasi yang dievaluasi menggunakan:
- `flutter_timezone` versi `5.1.1`.
- `timezone` versi `0.11.2`.

Jika versi package berubah, periksa kembali API, struktur nilai balik, serta dukungan platform pada versi yang benar-benar digunakan.

**Aturan wajib:**

1. Pengingat harian wajib mengikuti zona waktu lokal perangkat pengguna, bukan menggunakan `Asia/Jakarta` sebagai zona waktu utama secara permanen.

2. Inisialisasi database zona waktu melalui `tz.initializeTimeZones()` sebelum melakukan pencarian dan penetapan lokasi zona waktu.

3. Gunakan `FlutterTimezone.getLocalTimezone()` untuk memperoleh informasi zona waktu perangkat.

4. Gunakan properti `identifier` dari hasil `TimezoneInfo` sebagai identitas zona waktu ketika mencari lokasi melalui `tz.getLocation(identifier)`.

5. Setelah lokasi berhasil ditemukan, tetapkan dengan `tz.setLocalLocation(...)` sebelum membuat atau menjadwalkan waktu berbasis `TZDateTime`.

6. Jangan menggunakan singkatan zona waktu seperti WIB, WITA, atau WIT sebagai identifier database zona waktu tanpa memastikan bahwa identifier tersebut benar-benar didukung. Utamakan identifier yang diberikan oleh package.

7. `Asia/Jakarta` hanya digunakan sebagai fallback yang telah ditentukan proyek apabila deteksi zona waktu perangkat atau pencarian identifier tidak berhasil. Jangan menjadikannya zona waktu utama ketika zona perangkat berhasil dideteksi.

8. Penanganan kegagalan harus mencakup tahapan penting:
   - Inisialisasi database zona waktu.
   - Pemanggilan API deteksi zona waktu perangkat.
   - Pencarian lokasi berdasarkan identifier perangkat.
   - Penetapan lokasi zona waktu.
   - Pencarian dan penetapan lokasi fallback.

9. Catat informasi identifier zona waktu yang berhasil dideteksi menggunakan sistem logging proyek. Jika terjadi fallback, catat penyebabnya menggunakan `L.w()` atau `L.e()` sesuai tingkat kesalahan.

10. Pastikan lokasi zona waktu berhasil ditetapkan sebelum proses penjadwalan dilanjutkan. Jangan diam-diam melanjutkan penjadwalan menggunakan zona waktu yang belum berhasil ditentukan.

11. Apabila fallback `Asia/Jakarta` juga gagal ditemukan atau ditetapkan, tangani sebagai kegagalan inisialisasi yang harus dilaporkan. Jangan menganggap inisialisasi berhasil ketika tidak ada zona waktu valid yang berhasil ditetapkan.

12. Gunakan jenis exception dan mekanisme penanganan yang sesuai dengan API package aktual. Jangan mengandalkan `catch (Exception)` untuk menangani semua kemungkinan kegagalan apabila API terkait dapat menghasilkan jenis kesalahan lain yang perlu ditangani secara khusus.

13. Jangan menggunakan penanganan error yang terlalu luas untuk menelan kesalahan fatal atau membuat aplikasi seolah-olah berhasil padahal zona waktu belum berhasil diinisialisasi.

**Larangan:**

- Jangan menetapkan `Asia/Jakarta` sebagai zona utama secara permanen tanpa mencoba mendeteksi zona waktu perangkat.
- Jangan menggunakan singkatan zona waktu sebagai identifier IANA tanpa validasi.
- Jangan melanjutkan penjadwalan jika lokasi zona waktu belum berhasil ditetapkan.
- Jangan mengabaikan kegagalan deteksi atau pencarian zona waktu tanpa pencatatan.
- Jangan membiarkan kegagalan fallback tidak ditangani.
- Jangan menambah package lain untuk menyelesaikan kebutuhan yang sudah dapat dipenuhi oleh package yang digunakan, kecuali ada bukti teknis bahwa diperlukan.

**Alasan:**

Commit `19eece7` menambahkan dependensi `flutter_timezone` dan commit `d42422b` menerapkannya pada `NotifikasiService`. Package `timezone` menyediakan database lokasi zona waktu, sedangkan `flutter_timezone` digunakan untuk memperoleh zona waktu perangkat. Kombinasi ini membuat pengingat dapat mengikuti zona waktu lokal pengguna. Fallback `Asia/Jakarta` menjaga perilaku yang sudah digunakan proyek apabila deteksi atau pencarian zona waktu perangkat gagal.

**Sumber evaluasi:**
- Commit: `19eece75351cd8deee5a2a01cf65464a8e2a1bc1`, `d42422ba65a0f3c90b46a0736a197af572b62c33`.
- File: `pubspec.yaml`, `pubspec.lock`, `lib/shared/notifikasi/notifikasi_service.dart`, `saran.md`.

## Validasi dan Perhitungan Mode Berhenti Bertahap (Tapering)

**Cakupan:**
- `lib/fitur/biodata/enum/mode_berhenti.dart` — `ModeBerhenti`, `ModeBerhentiExtension`.
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel`, ekstensi `BiodataModelPerhitungan` (`sedangTapering`, `targetRokokHariIni`).
- `lib/fitur/biodata/screens/form_biodata.dart` — `_BiodataScreenState._simpan`, input mode tapering, penurunan per minggu, tanggal mulai penurunan.
- `lib/fitur/biodata/screens/biodata_screen.dart` — tampilan mode berhenti, penurunan per minggu, target rokok per hari, tanggal mulai penurunan.
- `lib/shared/db/sqflite/sqflite.dart` — migrasi skema v5 ke v6 (kolom baru pada tabel biodata).
- `lib/shared/konstanta/nama_kolom.dart` — konstanta `modeBerhenti`, `penurunanPerMinggu`, `tanggalMulaiTapering`.

**Aturan wajib:**
1. `ModeBerhenti.seketika` menggunakan jumlah rokok per hari sebagai target, tanpa menerapkan penurunan bertahap.
2. `ModeBerhenti.bertahap` wajib memiliki nilai `penurunanPerMinggu` berupa bilangan bulat positif.
3. Input penurunan mingguan tidak boleh kosong, nol, atau negatif ketika mode bertahap aktif.
4. Tanggal mulai tapering harus diinisialisasi ketika pengguna mengaktifkan mode bertahap dan dipastikan valid sebelum data disimpan.
5. Jika tanggal mulai berada di masa depan, jumlah minggu yang telah berlalu dianggap nol sampai tanggal tersebut tercapai.
6. Perhitungan jumlah minggu wajib memakai tanggal yang telah dinormalisasi, sesuai aturan normalisasi tanggal yang sudah tersedia.
7. Target rokok dihitung dengan prinsip:

   `target = jumlahRokokPerHari - (penurunanPerMinggu * mingguBerlalu)`

8. Hasil target tidak boleh kurang dari nol.
9. Nilai target pada mode seketika harus tetap sama dengan jumlah rokok per hari.
10. Jangan menghitung ulang formula yang sama di setiap layar. Gunakan ekstensi `BiodataModelPerhitungan` pada `biodata_model.dart`.
11. Setiap perubahan logika tapering wajib mempertahankan kompatibilitas pembacaan data lama (nilai fallback pada `fromSqflite`).
12. Uji perhitungan pada batas tanggal dan kondisi penting, termasuk:
    - Sebelum tanggal mulai.
    - Hari pertama.
    - Enam hari setelah tanggal mulai.
    - Tujuh hari setelah tanggal mulai.
    - Empat belas hari setelah tanggal mulai.
    - Target mencapai nol.
    - Mode seketika.

**Larangan:**
- Jangan menduplikasi formula target rokok di layar; gunakan getter `targetRokokHariIni` dari ekstensi.
- Jangan menyimpan mode bertahap tanpa `penurunanPerMinggu` positif dan tanggal mulai yang valid.
- Jangan membiarkan target bernilai negatif (klamping ke nol).
- Jangan menghitung minggu berlalu dari tanggal yang belum dinormalisasi.
- Jangan membuat aturan migrasi database baru yang menduplikasi aturan migrasi yang sudah tersedia (versi dinaikkan, tabel/kolom lengkap di `onCreate` dan `onUpgrade`, konstanta untuk nama kolom).

**Alasan:**
Commit `ceacc6a` menambahkan mode berhenti bertahap (tapering) pada biodata: enum `ModeBerhenti`, perluasan `BiodataModel` dengan `modeBerhenti`, `penurunanPerMinggu`, `tanggalMulaiTapering`, getter `sedangTapering` dan `targetRokokHariIni`, migrasi skema v5 ke v6, serta input dan tampilan pada form dan layar biodata. Perhitungan target menggunakan penurunan kumulatif per minggu sejak tanggal mulai, dengan klamping target ke rentang 0–`jumlahRokokPerHari`. Normalisasi tanggal mencegah hasil bergeser akibat komponen waktu. Kompatibilitas data lama dijaga melalui nilai fallback pada `fromSqflite` (`safeParseEnum` dengan default `seketika`, `parseInt` dengan default 0, `parseDateTime` yang mengembalikan null).

**Contoh benar:**
```dart
// Ekstensi pada model (didefinisikan sekali).
int get targetRokokHariIni {
  if (!sedangTapering) return jumlahRokokPerHari;
  final mulai = tanggalMulaiTapering ?? DateTime.now();
  final sekarang = DateTime.now();
  final mulaiDate = DateTime(mulai.year, mulai.month, mulai.day);
  final sekarangDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
  final hariBerlalu = sekarangDate.difference(mulaiDate).inDays;
  final mingguBerlalu = hariBerlalu < 0 ? 0 : hariBerlalu ~/ 7;
  final penurunan = penurunanPerMinggu * mingguBerlalu;
  final target = jumlahRokokPerHari - penurunan;
  if (target < 0) return 0;
  if (target > jumlahRokokPerHari) return jumlahRokokPerHari;
  return target;
}
// Konsumsi di layar.
final target = biodata.targetRokokHariIni;
```

**Contoh salah:**
```dart
// Menghitung ulang formula di layar (duplikasi).
final target = biodata.jumlahRokokPerHari - biodata.penurunanPerMinggu * minggu;
// Menggunakan tanggal tanpa normalisasi.
final hariBerlalu = DateTime.now().difference(tanggalMulaiTapering!).inDays;
// Menggunakan tanggalMulaiTapering! tanpa penyalinan ke variabel lokal (melanggar type promotion).
FormatTanggal.formatDasar(biodata.tanggalMulaiTapering!);
// Mengganti nilai parsing yang tidak valid dengan 0 tanpa validasi (menyembunyikan input tidak valid).
penurunanPerMinggu: int.tryParse(_penurunanPerMingguController.text.trim()) ?? 0,
```

**Sumber evaluasi:**
- Commit: `ceacc6a1c388b24b7647a37ccde411d6c85ee01c`.
- File: `lib/fitur/biodata/enum/mode_berhenti.dart`, `lib/fitur/biodata/model/biodata_model.dart`, `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/biodata/screens/form_biodata.dart`, `lib/shared/db/sqflite/sqflite.dart`, `lib/shared/konstanta/nama_kolom.dart`, `refrensi_apk.md`.
