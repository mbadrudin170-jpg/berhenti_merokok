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

**Larangan:**
- Jangan membuat sistem logging baru.
- Jangan mencetak properti model satu per satu (gunakan `$model`).
- Jangan mencetak data sensitif.
- Jangan mengubah logika program saat menambahkan log.

**Alasan:**
Format log yang singkat dan konsisten (nama variabel + nilai) memudahkan pelacakan alur eksekusi tanpa menambah noise. Menampilkan objek model langsung menghindari log yang terlalu panjang dan tetap informatif. Larangan mencetak data sensitif menjaga keamanan. Prinsip ini dapat diterapkan pada seluruh proyek Flutter yang memiliki sistem logging.

**Sumber evaluasi:**
- Commit: `6bae21014ab8f156d70364ea40ff669573de1f37`, `f55410ae5d09de92cb53f1f284ab69051d6af46a`
- File: `lib/fitur/dummy/helper/dummy_helper.dart`, `lib/fitur/dummy/screens/dummy_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`, `lib/fitur/impian/notifier/impian_notifier.dart`, `.kilo/commands/tambah_log.md`

**Contoh benar:**
```dart
logger.i('dummyImpian.length=${dummyImpian.length}, dummyBiodata.length=${dummyBiodata.length}');
logger.i('row=$row');
logger.i('biodata=$biodata');
logger.i('konfirmasi=$konfirmasi');
```

**Contoh salah:**
```dart
logger.i('tes'); // tidak memberikan informasi nilai variabel
logger.i('nama=${model.nama}, umur=${model.umur}'); // menguraikan properti model
print('data=$data'); // menggunakan print() alih-alih logger
```
