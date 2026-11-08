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

# Kelompok 6

## File terdampak

- [badge_helper.dart](lib/fitur/badge/helper/badge_helper.dart)
- [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart)

## Rendah

# Kelompok 7

## File terdampak

- [biodata_notifier.dart](lib/fitur/biodata/notifier/biodata_notifier.dart)

## Sedang

# Kelompok 8

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)

## Sedang

#### Task 3

- Status: Selesai
- Masalah: Pada `dashboard_screen.dart` sekitar baris 313-318, perhitungan `totalHariMerokok` menggunakan `tanggalBerhenti.difference(tanggalMulaiMerokok).inDays` tanpa normalisasi tanggal ke komponen tanggal saja. Hasil perhitungan hari dapat bergeser akibat komponen waktu pada nilai `DateTime`.
- Solusi: Normalisasi kedua tanggal dengan `DateTime(tanggal.year, tanggal.month, tanggal.day)` sebelum menghitung selisih hari, agar hasil perhitungan berbasis hari akurat.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L303); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L620)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L313)
- Prompt:

## Rendah

#### Task 1

- Status: batal
- Masalah: Pada `dashboard_screen.dart`, pemanggilan `L.i(...)` berada langsung di dalam `build()` (baris 39, 75, dan 81), sehingga log berulang pada setiap rebuild meskipun nilai tidak berubah dan menambah noise.
- Solusi: Pindahkan logging ke titik yang tidak berfrekuensi tinggi (mis. aksi pengguna, inisialisasi, atau method helper yang dipicu perubahan data), dan hindari log di dalam `build()`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L11); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L39); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L75); [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L81)
- Prompt:

# Kelompok 9

## File terdampak

- [diary_craving_notifier.dart](lib/fitur/diary_craving/notifier/diary_craving_notifier.dart)

## Rendah


# Kelompok 10

## File terdampak

- [alasan_berhenti_screen.dart](lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart)
- [form_alasan_berhenti.dart](lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart)

## Rendah

#### Task 1

- Status: Selesai
- Masalah: Pada `form_alasan_berhenti.dart`, pemanggilan `EasyLoading.show(...)` dan `EasyLoading.dismiss()` dilepas dengan `unawaited(...)` tanpa penanganan error (`.catchError(...)`). Aturan notifikasi #14 dan optimasi bug runtime mewajibkan penanganan error pada Future yang dilepas, agar kegagalan menampilkan/menutup loading tidak menjadi unhandled error.
- Solusi: Bungkus pemanggilan `EasyLoading.show(...)` dan `EasyLoading.dismiss()` yang dilepas dengan `unawaited(...)` menggunakan `.catchError((Object e, StackTrace s) { L.e('...: $e $s'); })`, sesuai pola pada `pengaturan_screen.dart`.
- Aturan dilanggar: [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L787); [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L6)
- File bermasalah: [form_alasan_berhenti.dart](lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart#L70); [form_alasan_berhenti.dart](lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart#L101)
- Prompt:

#### Task 2

- Status: batal
- Masalah: Pada `alasan_berhenti_screen.dart`, pemanggilan `L.i(...)` berada langsung di dalam `build()` (baris 64-67) dan di dalam `itemBuilder` (baris 119), sehingga log berulang pada setiap rebuild dan setiap item, meskipun nilai tidak berubah, menambah noise. Selain itu, log pada `itemBuilder` menguraikan properti model (`item.id`, `item.teks`) alih-alih menampilkan objek model langsung.
- Solusi: Pindahkan logging ke titik yang tidak berfrekuensi tinggi (mis. aksi pengguna, inisialisasi, atau method helper yang dipicu perubahan data), dan untuk objek model gunakan `$model` alih-alih menguraikan properti. Hindari log di dalam `build()` dan `itemBuilder`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L1); [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L3); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L1)
- File bermasalah: [alasan_berhenti_screen.dart](lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart#L64); [alasan_berhenti_screen.dart](lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart#L119)
- Prompt:
