# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Pada `_buildSaldoTerkumpul` di `impian_screen.dart` digunakan `SizedBox(width: 8)` untuk memberi jarak antara ikon `Icons.savings_outlined` dan kolom teks. Jarak seragam antar-anak Row sebaiknya diatur dengan properti `spacing` pada `Row`, bukan `SizedBox` individual, sesuai `optimasi_ui.md` #4.
- Solusi: Ganti `SizedBox(width: 8)` dengan menambahkan `spacing: 8` pada `Row`, dan hapus `SizedBox` tersebut.
- Aturan dilanggar: [optimasi_ui.md](.agents/rules/global/optimasi_ui.md#L51-L53)
- File bermasalah: [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart#L328)
- Prompt:

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

# Kelompok 12

## File terdampak

- [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart)

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Urutan import pada `detail_impian_screen.dart` tidak mengikuti urutan alfabetis berdasarkan path package. Baris 8 `widget/visual_tabungan_impian.dart` berada sebelum baris 9 `notifier/impian_notifier.dart`, padahal `notifier` secara alfabetis mendahului `widget`. Urutan yang benar: `notifier/impian_notifier.dart` sebelum `widget/visual_tabungan_impian.dart`.
- Solusi: Tukar urutan kedua import tersebut sehingga `notifier/impian_notifier.dart` berada sebelum `widget/visual_tabungan_impian.dart`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L99-L104), [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L31)
- File bermasalah: [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart#L8-L9)
- Prompt:

