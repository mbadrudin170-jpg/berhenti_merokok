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
