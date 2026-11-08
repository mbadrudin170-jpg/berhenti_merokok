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

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Log debug yang ditambahkan pada fitur tapering dicatat pada getter dan `build()` yang dapat dipanggil berulang. `ModeBerhentiExtension.label` memanggil `L.i('mode=$this')` pada setiap akses (termasuk saat `biodata.modeBerhenti.label` dibaca di `build()`), `BiodataModelPerhitungan.targetRokokHariIni` memanggil `L.i` pada setiap akses (termasuk saat dibaca di `build()`), dan `biodata_screen.dart` memanggil `L.i` dengan field tanggal di dalam `build()`. Hal ini menyebabkan pencatatan berulang pada setiap rebuild meskipun nilai tidak berubah, menambah noise log.
- Solusi: Pindahkan logging ke titik perubahan data atau proses yang tidak berfrekuensi tinggi (mis. `initState`, method helper, perhitungan yang dipicu aksi), dan hindari log di dalam getter/`build()` yang dipanggil berulang.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L1); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L1)
- File bermasalah: [mode_berhenti.dart](lib/fitur/biodata/enum/mode_berhenti.dart#L9); [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart#L124); [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L69)
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

