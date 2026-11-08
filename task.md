# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

# Kelompok 2

## File terdampak

- [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- [main.dart](lib/main.dart)
- [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart)
- [notifikasi_service_test.dart](test/notifikasi_service_test.dart)

## Tinggi

## Sedang

## Rendah

---

# Kelompok 3

## File terdampak

- [home.dart](lib/home.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

Tidak ada temuan.

# Kelompok 4

## File terdampak

- [mode_berhenti.dart](lib/fitur/biodata/enum/mode_berhenti.dart)
- [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart)
- [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart)
- [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart)
- [sqflite.dart](lib/shared/db/sqflite/sqflite.dart)
- [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status: Belum dikerjakan
- Masalah: Pada `form_biodata.dart`, form menggunakan `InputTeks`, `InputAngka`, dan `InputRupiah` yang menyediakan `TextFormField` dan validator, tetapi tidak ditemukan pembungkus `Form` dan mekanisme `GlobalKey<FormState>`. Method `_simpan()` tidak menjalankan validasi sebelum penyimpanan. `penurunanPerMinggu` menggunakan `int.tryParse(...) ?? 0` yang mengganti input tidak valid dengan `0`. Validator bawaan `InputAngka` tidak memastikan nilai lebih besar dari nol. Tanggal mulai tapering (`_tanggalMulaiTapering`) belum dipastikan tidak null sebelum penyimpanan, khususnya ketika mode bertahap aktif. Akibatnya mode tapering dapat tersimpan tanpa penurunan rokok yang valid.
- Solusi: Validasi seluruh input sebelum penyimpanan (panggil `validate()` pada form atau mekanisme validasi yang setara), tambahkan validasi khusus agar penurunan mingguan merupakan bilangan bulat positif, pastikan tanggal mulai tapering valid sebelum menyimpan, dan jangan menyimpan nilai pengganti (`0`) yang menyembunyikan input tidak valid.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L492); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L937)
- File bermasalah: [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L151); [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L189)
- Prompt:

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Log debug yang ditambahkan pada fitur tapering dicatat pada getter dan `build()` yang dapat dipanggil berulang. `ModeBerhentiExtension.label` memanggil `L.i('mode=$this')` pada setiap akses (termasuk saat `biodata.modeBerhenti.label` dibaca di `build()`), `BiodataModelPerhitungan.targetRokokHariIni` memanggil `L.i` pada setiap akses (termasuk saat dibaca di `build()`), dan `biodata_screen.dart` memanggil `L.i` dengan field tanggal di dalam `build()`. Hal ini menyebabkan pencatatan berulang pada setiap rebuild meskipun nilai tidak berubah, menambah noise log.
- Solusi: Pindahkan logging ke titik perubahan data atau proses yang tidak berfrekuensi tinggi (mis. `initState`, method helper, perhitungan yang dipicu aksi), dan hindari log di dalam getter/`build()` yang dipanggil berulang.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L1); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L1)
- File bermasalah: [mode_berhenti.dart](lib/fitur/biodata/enum/mode_berhenti.dart#L9); [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart#L124); [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L69)
- Prompt:

#### Task 2

- Status: Belum dikerjakan
- Masalah: Pada `sqflite.dart`, method `_onUpgrade()` memanggil `L.i('oldVersion=$oldVersion, newVersion=$newVersion')`. Namun database dibuka di `main.dart` melalui `AppDatabase.database` sebelum `runApp()`, sedangkan `L.init(ref.container)` baru dipanggil di `app.dart` dalam `initState()` setelah `runApp()`. Akibatnya log tersebut berjalan sebelum `L` diinisialisasi, bertentangan dengan aturan proyek yang mewajibkan penggunaan `debugPrint()` dengan pengecekan `kDebugMode` pada jalur yang belum melewati `L.init()`.
- Solusi: Ganti pemanggilan `L.i(...)` pada `_onUpgrade()` (dan jalur eksekusi sebelum `L.init()`) dengan `debugPrint(...)` yang dibungkus pengecekan `kDebugMode`, atau pindahkan logging ke titik setelah `L.init()` terpanggil.
- Aturan dilanggar: [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L15)
- File bermasalah: [sqflite.dart](lib/shared/db/sqflite/sqflite.dart#L87)
- Prompt:

#### Task 3

- Status: Belum dikerjakan
- Masalah: Pada `form_biodata.dart` sekitar baris 76-80, penutup log menempel dengan penutup method (`);  }`) dengan spasi ganda, sehingga format kode tidak sesuai standar `dart format`. Contoh: `    );  }` pada akhir `_isiDariModel`.
- Solusi: Jalankan `dart format` pada `form_biodata.dart` agar penutup method dan pemanggilan terformat sesuai standar, tanpa mengubah logika.
- Aturan dilanggar: [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L191)
- File bermasalah: [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L80)
- Prompt:
