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
