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

- Status: kerjakan
- Masalah: Log debug yang ditambahkan pada fitur tapering dicatat pada getter dan `build()` yang dapat dipanggil berulang. `ModeBerhentiExtension.label` memanggil `L.i('mode=$this')` pada setiap akses (termasuk saat `biodata.modeBerhenti.label` dibaca di `build()`), `BiodataModelPerhitungan.targetRokokHariIni` memanggil `L.i` pada setiap akses (termasuk saat dibaca di `build()`), dan `biodata_screen.dart` memanggil `L.i` dengan field tanggal di dalam `build()`. Hal ini menyebabkan pencatatan berulang pada setiap rebuild meskipun nilai tidak berubah, menambah noise log.
- Solusi: Pindahkan logging ke titik perubahan data atau proses yang tidak berfrekuensi tinggi (mis. `initState`, method helper, perhitungan yang dipicu aksi), dan hindari log di dalam getter/`build()` yang dipanggil berulang.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L1); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L1)
- File bermasalah: [mode_berhenti.dart](lib/fitur/biodata/enum/mode_berhenti.dart#L9); [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart#L124); [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L69)
- Prompt:

#### Task 2

- Status: kerjakan
- Masalah: File [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart) tidak mengikuti format kode (`dart format` melaporkan perubahan), terutama indentasi blok validasi/manual parsing pada `_simpan` yang tidak konsisten. Hal ini menyebabkan inkonsistensi format dengan aturan proyek.
- Solusi: Jalankan `dart format` pada file tersebut agar indentasi dan format mengikuti standar Dart, tanpa mengubah logika.
- Aturan dilanggar: [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L15)
- File bermasalah: [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart)
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

## Rendah

# Kelompok 9

## File terdampak

- [diary_craving_notifier.dart](lib/fitur/diary_craving/notifier/diary_craving_notifier.dart)

## Rendah


# Kelompok 10

## File terdampak

- [alasan_berhenti_screen.dart](lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart)
- [form_alasan_berhenti.dart](lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart)

## Rendah

# Kelompok 11

## File terdampak

- [pubspec.yaml](pubspec.yaml)

## Sedang

#### Task 1

- Status: kerjakan
- Masalah: Commit `041ac91` mengubah entri dependensi `flutter_local_notifications` dari `^22.3.3` menjadi `^23.0.0` secara langsung pada `pubspec.yaml` (bukan melalui `flutter pub add`), sehingga melanggar aturan manajemen dependensi. Selain itu, aturan proyek (`aturan_notifikasi.md`) dan dokumentasi masih mereferensikan versi `22.3.3`, sehingga tidak konsisten dengan versi yang terpasang (`23.0.0`).
- Solusi: Sesuaikan versi dependensi dengan mekanisme resmi (`flutter pub add flutter_local_notifications`), perbarui `pubspec.lock`, dan sinkronkan referensi versi pada aturan/dokumentasi notifikasi agar sesuai dengan versi yang benar-benar digunakan.
- Aturan dilanggar: [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L5); [aturan_notifikasi.md](.agents/rules/global/aturan_notifikasi.md#L1)
- File bermasalah: [pubspec.yaml](pubspec.yaml)
- Prompt:
