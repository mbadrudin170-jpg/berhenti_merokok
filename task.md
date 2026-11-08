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

- Status:kerjakan
- Masalah: Pada `form_biodata.dart`, form menggunakan `InputTeks`, `InputAngka`, dan `InputRupiah` yang menyediakan `TextFormField` dan validator, tetapi tidak ditemukan pembungkus `Form` dan mekanisme `GlobalKey<FormState>`. Method `_simpan()` tidak menjalankan validasi sebelum penyimpanan. `penurunanPerMinggu` menggunakan `int.tryParse(...) ?? 0` yang mengganti input tidak valid dengan `0`. Validator bawaan `InputAngka` tidak memastikan nilai lebih besar dari nol. Tanggal mulai tapering (`_tanggalMulaiTapering`) belum dipastikan tidak null sebelum penyimpanan, khususnya ketika mode bertahap aktif. Akibatnya mode tapering dapat tersimpan tanpa penurunan rokok yang valid.
- Solusi: Validasi seluruh input sebelum penyimpanan (panggil `validate()` pada form atau mekanisme validasi yang setara), tambahkan validasi khusus agar penurunan mingguan merupakan bilangan bulat positif, pastikan tanggal mulai tapering valid sebelum menyimpan, dan jangan menyimpan nilai pengganti (`0`) yang menyembunyikan input tidak valid.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L492); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L937)
- File bermasalah: [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L151); [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L189)
- Prompt:

#### Task 2

- Status: kerjakan
- Masalah: Pada `biodata_screen.dart` dan `form_biodata.dart`, beberapa `Future` dilepas menggunakan `unawaited(...)` tanpa penanganan error: `Nav.to(...)` pada `biodata_screen.dart` (sekitar baris 92-97 dan 160-168), serta `EasyLoading.show(...)`, `Nav.pushAndRemoveUntil(...)`, dan `EasyLoading.dismiss()` pada `form_biodata.dart` (sekitar baris 168-173, 197, dan 208). Kegagalan pada Future tersebut tidak dicatat, sehingga error dapat menjadi unhandled dan sulit ditelusuri.
- Solusi: Bungkus setiap Future yang dilepas dengan `unawaited(...)` menggunakan `try/catch` atau `.catchError(...)` yang mencatat error melalui `L.e`, sesuai aturan penanganan error Future yang dilepas. Untuk `Nav.pushAndRemoveUntil(...)` dan `EasyLoading.show(...)`/`EasyLoading.dismiss()` gunakan pola `.catchError((Object e, StackTrace s) { L.e(...); })`.
- Aturan dilanggar: [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L787); [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L226); [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L375)
- File bermasalah: [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L92); [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L168)
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

- Status: Selesai
- Masalah: Pada `sqflite.dart`, method `_onUpgrade()` memanggil `L.i('oldVersion=$oldVersion, newVersion=$newVersion')`. Namun database dibuka di `main.dart` melalui `AppDatabase.database` sebelum `runApp()`, sedangkan `L.init(ref.container)` baru dipanggil di `app.dart` dalam `initState()` setelah `runApp()`. Akibatnya log tersebut berjalan sebelum `L` diinisialisasi, bertentangan dengan aturan proyek yang mewajibkan penggunaan `debugPrint()` dengan pengecekan `kDebugMode` pada jalur yang belum melewati `L.init()`.
- Solusi: Ganti pemanggilan `L.i(...)` pada `_onUpgrade()` (dan jalur eksekusi sebelum `L.init()`) dengan `debugPrint(...)` yang dibungkus pengecekan `kDebugMode`, atau pindahkan logging ke titik setelah `L.init()` terpanggil.
- Aturan dilanggar: [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L15)
- File bermasalah: [sqflite.dart](lib/shared/db/sqflite/sqflite.dart#L87)
- Prompt: ubah menjadi debugprint

#### Task 3

- Status: Belum dikerjakan
- Masalah: Pada `form_biodata.dart` sekitar baris 76-80, penutup log menempel dengan penutup method (`);  }`) dengan spasi ganda, sehingga format kode tidak sesuai standar `dart format`. Contoh: `    );  }` pada akhir `_isiDariModel`.
- Solusi: Jalankan `dart format` pada `form_biodata.dart` agar penutup method dan pemanggilan terformat sesuai standar, tanpa mengubah logika.
- Aturan dilanggar: [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L191)
- File bermasalah: [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart#L80)
- Prompt:

# Kelompok 5

## File terdampak

- [app.dart](lib/app.dart)

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Pada `app.dart`, import tidak diurutkan secara alfabetis berdasarkan path package. Import `package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart` dan `package:berhenti_merokok/fitur/tema/...` muncul sebelum `package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart`, sehingga urutan import tidak sesuai aturan.
- Solusi: Urutkan import pada `app.dart` secara alfabetis berdasarkan path package lengkap, misalnya `fitur/biodata/notifier/...` sebelum `fitur/biodata/screens/...` dan `fitur/tema/...`, tanpa mengubah logika.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L99)
- File bermasalah: [app.dart](lib/app.dart#L2)
- Prompt:

# Kelompok 6

## File terdampak

- [badge_helper.dart](lib/fitur/badge/helper/badge_helper.dart)
- [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart)

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Pada `badge_helper.dart` (fungsi `hitungBadge`) dan `badge_screen.dart` (method `build`), pemanggilan `L.i(...)` berada pada jalur yang dapat dipanggil berulang saat build, sehingga log berulang pada setiap rebuild meskipun nilai tidak berubah dan menambah noise.
- Solusi: Pindahkan logging ke titik yang tidak berfrekuensi tinggi (mis. aksi pengguna, inisialisasi, atau method helper yang dipicu perubahan data), dan hindari log di dalam build/getter yang dipanggil berulang.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L1); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L1)
- File bermasalah: [badge_helper.dart](lib/fitur/badge/helper/badge_helper.dart#L29); [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart#L33)
- Prompt:

# Kelompok 7

## File terdampak

- [biodata_notifier.dart](lib/fitur/biodata/notifier/biodata_notifier.dart)

## Sedang

#### Task 1

- Status: Belum dikerjakan
- Masalah: Pada `biodata_notifier.dart`, `BiodataNotifier` menggunakan anotasi `@riverpod` (auto-dispose) padahal notifier ini mengakses database; aturan proyek mewajibkan notifier database menggunakan `@Riverpod(keepAlive: true)`. Selain itu, `build()` memanggil `_ambilData()` bukan `_ambilSemua()` sesuai pola notifier CRUD, dan log pada `simpan()` mencatat properti model (`biodata.id`, `biodata.nama`) secara terurai alih-alih menampilkan objek model langsung.
- Solusi: Ubah anotasi menjadi `@Riverpod(keepAlive: true)`, sesuaikan method pengambilan data awal dengan pola `_ambilSemua()`, dan ganti log properti model dengan `L.i('biodata=$biodata')` (atau logging objek secara langsung). Regenerasi file `.g.dart` sesuai sumber.
- Aturan dilanggar: [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L348); [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L1)
- File bermasalah: [biodata_notifier.dart](lib/fitur/biodata/notifier/biodata_notifier.dart#L11); [biodata_notifier.dart](lib/fitur/biodata/notifier/biodata_notifier.dart#L14); [biodata_notifier.dart](lib/fitur/biodata/notifier/biodata_notifier.dart#L34)
- Prompt:

# Kelompok 8

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)

## Sedang

#### Task 1

- Status: Selesai
- Masalah: Pada `dashboard_screen.dart`, beberapa `Future` dari `Nav.to(...)` dilepas menggunakan `unawaited(...)` tanpa penanganan error (baris 92, 198, 274, dan 389). Kegagalan navigasi pada Future tersebut tidak dicatat, sehingga error dapat menjadi unhandled dan sulit ditelusuri.
- Solusi: Bungkus setiap Future yang dilepas dengan `unawaited(...)` menggunakan `try/catch` atau `.catchError(...)` yang mencatat error melalui `L.e`, sesuai aturan penanganan error Future yang dilepas.
- Aturan dilanggar: [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L787); [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L226); [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L375)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L92); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L198); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L274); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L389)
- Prompt:

#### Task 2

- Status: Selesai
- Masalah: Pada `dashboard_screen.dart` sekitar baris 312-322, perhitungan `uangTerbuang` melakukan pembagian dengan `biodata.batangPerBungkus` tanpa guard pembagian dengan nol. Jika nilai `batangPerBungkus` adalah 0, hasil perhitungan dapat menjadi Infinity/NaN dan tampilan kerugian menjadi tidak valid.
- Solusi: Tambahkan guard pembagian dengan nol (mis. `if (biodata.batangPerBungkus == 0) return 0;` atau gunakan getter yang sudah memiliki guard pada ekstensi model), agar perhitungan tetap aman.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L346); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L723)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L322)
- Prompt:

#### Task 3

- Status: Belum dikerjakan
- Masalah: Pada `dashboard_screen.dart` sekitar baris 313-318, perhitungan `totalHariMerokok` menggunakan `tanggalBerhenti.difference(tanggalMulaiMerokok).inDays` tanpa normalisasi tanggal ke komponen tanggal saja. Hasil perhitungan hari dapat bergeser akibat komponen waktu pada nilai `DateTime`.
- Solusi: Normalisasi kedua tanggal dengan `DateTime(tanggal.year, tanggal.month, tanggal.day)` sebelum menghitung selisih hari, agar hasil perhitungan berbasis hari akurat.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L303); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L620)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L313)
- Prompt:

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Pada `dashboard_screen.dart`, pemanggilan `L.i(...)` berada langsung di dalam `build()` (baris 39, 75, dan 81), sehingga log berulang pada setiap rebuild meskipun nilai tidak berubah dan menambah noise.
- Solusi: Pindahkan logging ke titik yang tidak berfrekuensi tinggi (mis. aksi pengguna, inisialisasi, atau method helper yang dipicu perubahan data), dan hindari log di dalam `build()`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L11); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L39); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L75); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L81)
- Prompt:

# Kelompok 9

## File terdampak

- [diary_craving_notifier.dart](lib/fitur/diary_craving/notifier/diary_craving_notifier.dart)

## Rendah

#### Task 1

- Status: Selesai
- Masalah: Pada `diary_craving_notifier.dart`, method `tambah()` (baris 39) dan `ubah()` (baris 62) mencatat properti model secara terurai (`craving.id` dan `craving.pemicu`) alih-alih menampilkan objek model langsung.
- Solusi: Ganti log tersebut dengan `L.i('craving=$craving')` agar format log singkat dan konsisten.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L8); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L12)
- File bermasalah: [diary_craving_notifier.dart](lib/fitur/diary_craving/notifier/diary_craving_notifier.dart#L39); [diary_craving_notifier.dart](lib/fitur/diary_craving/notifier/diary_craving_notifier.dart#L62)
- Prompt:
