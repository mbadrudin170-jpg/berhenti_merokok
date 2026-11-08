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

- Status: Belum dikerjakan
- Masalah: Referensi versi `flutter_local_notifications` pada aturan proyek (`aturan_notifikasi.md`, `aturan_khusus.md`) masih menyebut `22.3.3`, tetapi `pubspec.yaml`/`pubspec.lock` menggunakan `23.0.0`. Selain itu, perubahan dependensi sebelumnya dilakukan langsung pada `pubspec.yaml` (bukan melalui `flutter pub add`), sehingga pelacakan dan konsistensi dokumentasi belum selesai. Entri task sebelumnya (Kelompok 11 Task 1) ditandai Selesai dan dihapus pada commit `64dc775`, padahal ketidaksesuaian masih ada.
- Solusi: Sinkronkan referensi versi pada aturan/dokumentasi notifikasi dengan versi yang benar-benar terpasang (`23.0.0`), atau sesuaikan dependensi sesuai mekanisme resmi (`flutter pub add flutter_local_notifications`) dan perbarui `pubspec.lock`; pastikan aturan dan kode konsisten. Jangan mengubah kode Dart tanpa persetujuan.
- Aturan dilanggar: [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L5); [aturan_notifikasi.md](.agents/rules/global/aturan_notifikasi.md#L1); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L762)
- File bermasalah: [pubspec.yaml](pubspec.yaml)
- Prompt:
