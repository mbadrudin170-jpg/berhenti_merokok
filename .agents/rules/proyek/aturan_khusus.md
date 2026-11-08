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
13. Log pada `initState` dan `dispose` diperbolehkan karena hanya dipanggil sekali. Log pada `build()` dihindari apabila memungkinkan karena `build()` dapat dipanggil berulang dan menambah noise; prioritaskan log pada titik yang tidak berfrekuensi tinggi (initState, dispose, method helper, perhitungan).

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
- `lib/fitur/impian/screens/impian_screen.dart` — `_ImpianScreenState`, `_hitungUangDihemat`, `_buildSaldoTerkumpul`.
- `lib/fitur/biodata/notifier/biodata_notifier.dart` — `biodataProvider`.
- `lib/fitur/biodata/model/biodata_model.dart` — `BiodataModel`.

**Aturan wajib:**
1. Impian screen wajib melakukan `ref.watch(biodataProvider)` untuk memperoleh data biodata yang digunakan menghitung saldo terkumpul.
2. Saldo terkumpul merupakan uang yang dihemat dari tidak merokok, dihitung dari biodata: hari berhenti (`DateTime.now().difference(tanggalMulaiBerhentiMerokok).inDays`, minimum 0), rokok tidak dihisap (`jumlahRokokPerHari * hariBerhenti`), dan uang dihemat (`(rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus`).
3. Selama `biodataAsync` masih loading atau error, saldo terkumpul dianggap 0; jangan memanggil `requireValue` sebelum memastikan data tersedia.
4. Perhitungan saldo terkumpul wajib dilakukan di widget (mis. method `_hitungUangDihemat`), bukan di provider, karena merupakan perhitungan turunan sederhana yang bergantung pada waktu saat ini.
5. Progress bar dan teks "Sisa" pada setiap item impian wajib berbasis saldo terkumpul (uang yang dihemat), bukan `totalJumlah` dari `ImpianState`.
6. Perhitungan uang yang dihemat wajib konsisten dengan perhitungan pada dashboard (`_buildCardProgres`); jangan menduplikasi logika dengan formula yang berbeda.

**Larangan:**
- Jangan menggunakan `totalJumlah` dari `ImpianState` sebagai saldo terkumpul (saldo berasal dari biodata, bukan dari jumlah impian).
- Jangan memanggil `biodataAsync.requireValue` tanpa memeriksa loading/error terlebih dahulu.
- Jangan menghitung saldo terkumpul di provider (perhitungan bergantung pada waktu saat ini dan lebih tepat di widget).
- Jangan menduplikasi formula perhitungan uang yang dihemat dengan versi yang berbeda antara dashboard dan impian.

**Alasan:**
Commit `336a72f` mengubah impian screen agar menggunakan biodata sebagai sumber saldo terkumpul (uang yang dihemat dari tidak merokok), menggantikan `totalJumlah` dari `ImpianState`. Perubahan ini menyelaraskan impian dengan dashboard yang sudah menggunakan perhitungan yang sama. Penanganan loading/error biodata dengan nilai default 0 mencegah crash dan tampilan kosong sementara. Perhitungan di widget (bukan provider) sesuai dengan prinsip bahwa perhitungan sederhana yang bergantung pada waktu saat ini dapat dilakukan di widget.

**Sumber evaluasi:**
- Commit: `336a72f3b67ea7361aea95ac36ae90d08b1e2c6c`
- File: `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`, `lib/fitur/biodata/model/biodata_model.dart`

**Contoh benar:**
```dart
final biodataAsync = ref.watch(biodataProvider);
BiodataModel? biodata;
if (biodataAsync.isLoading) {
  // saldo tetap 0 sementara
} else if (biodataAsync.hasError) {
  // saldo tetap 0 sementara
} else {
  biodata = biodataAsync.requireValue;
}
final uangDihemat = _hitungUangDihemat(biodata);

double _hitungUangDihemat(BiodataModel? biodata) {
  if (biodata == null) return 0;
  int hariBerhenti = 0;
  final tanggalBerhenti = biodata.tanggalMulaiBerhentiMerokok;
  if (tanggalBerhenti != null) {
    hariBerhenti = DateTime.now().difference(tanggalBerhenti).inDays;
    if (hariBerhenti < 0) hariBerhenti = 0;
  }
  final rokokTidakDiHisap = biodata.jumlahRokokPerHari * hariBerhenti;
  return (rokokTidakDiHisap / biodata.batangPerBungkus) *
      biodata.hargaRokokPerBungkus;
}
```

**Contoh salah:**
```dart
// Menggunakan totalJumlah sebagai saldo terkumpul (salah).
_buildSaldoTerkumpul(impianState.totalJumlah);

// Memanggil requireValue tanpa memeriksa loading/error (berisiko crash).
final biodata = biodataAsync.requireValue;
final uangDihemat = _hitungUangDihemat(biodata);

// Formula berbeda dengan dashboard (tidak konsisten).
final uangDihemat = rokokTidakDiHisap * biodata.hargaRokokPerBungkus; // salah: tidak membagi dengan batangPerBungkus
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
```
