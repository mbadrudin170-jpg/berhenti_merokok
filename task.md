# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

#### Task 2

- Status: kerjakan
- Masalah: Logging `L.i` ditambahkan di `_buildCardTargetSmokeFree(...)` (dipanggil dari `build()`) yang mencatat `targetSmokeFreeHari/tanggalBerhenti/hariBerhenti/teksProgres` (baris ~166-168). Log di jalur `build()` dapat terpanggil berulang dan menambah noise.
- Solusi: Pindahkan/hapus log dari method yang dipanggil `build()`; log pada titik tidak berfrekuensi tinggi bila diperlukan.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L166-L168)
- Prompt:

#### Task 3

- Status: batal
- Masalah: Commit `18cc24e` menambahkan `ref.watch(impianProvider)` di `build()` (baris 83) dengan logging `L.i('impianAsync.isLoading=..., hasError=...')` (baris 83-L86), serta logging `L.i` di dalam `_buildCardRingkasanImpian` (baris 211/215/226). Kedua berada di jalur `build()` yang dapat dipanggil berulang, menambah noise.
- Solusi: Hapus log `impianAsync.isLoading/hasError` dari `build()`; pindahkan log `ringkasan impian: ...` ke titik tidak berfrekuensi tinggi (initState/dispose/aksi) atau hapus sama sekali.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83-L86), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L211-L226)
- Prompt:

#### Task 4

- Status: kerjakan
- Masalah: Commit `18cc24e` menggunakan `AsyncValue<dynamic>` secara eksplisit pada `ref.watch(impianProvider)` di `build()` (baris 83) dan pada parameter `_buildCardRingkasanImpian(BiodataModel biodata, AsyncValue<dynamic> impianAsync)` (baris 203-L206). Provider `impianProvider` mengembalikan `AsyncValue<ImpianState>` (terverifikasi di `.g.dart`), sehingga type inference sudah cukup dan penandaan `dynamic` tidak perlu — menambahkan `dynamic` secara eksplisit melanggar prinsip hindari `dynamic` ketika tipe dapat ditentukan secara jelas.
- Solusi: Hapus penandaan `dynamic` — biarkan `final impianAsync = ref.watch(impianProvider);` (otomatis `AsyncValue<ImpianState>`) dan ganti parameter menjadi `AsyncValue<ImpianState> impianAsync` (atau hapus parameter sama sekali dan watch di dalam method, sesuai kebutuhan).
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L51-L53)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L203-L206)
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

#### Task 1

- Status: kerjakan
- Masalah: Commit `adc85b5` mengubah nilai konstanta `NamaKolom.tanggalMulaiTapering` dari `'tanggal_mulai_tapering'` (snake_case) menjadi `'Tanggal_mulai_tapering'` (kapital `T`). Nilai ini tidak konsisten dengan konvensi snake_case kolom lain dan dengan nama kolom yang sudah dibuat di skema/migrasi (`tanggal_mulai_tapering`). Perbedaan kapitalisasi berisiko merusak baca/tulis tanggal mulai tapering (pemetaan ke kolom DB berbeda). Perubahan ini tampak tidak disengaja dan di luar tujuan commit (menambah target smoke-free).
- Solusi: Kembalikan nilai konstanta menjadi `static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';`. Verifikasi tidak ada referensi lain yang bergantung pada kapitalisasi salah; bila skema/migrasi sudah memakai nilai lama (lowercase), pastikan konsisten.
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L95-L100), [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L139-L140), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L310-L311)
- File bermasalah: [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart#L37)
- Prompt:

#### Task 2

- Status: kerjakan
- Masalah: `BiodataModel.fromSqflite` mem-parsing `targetSmokeFreeHari` (field nullable `int?`) menggunakan `ParserUtil.parseInt(...)` yang mengembalikan `defaultValue 0` ketika nilai DB `null` (terverifikasi: `share_global_saya/lib/src/utils/parser_util.dart` `parseInt` mengembalikan `defaultValue` untuk `null`). Akibatnya target yang tidak diset (`null`) dibaca sebagai `0`, sehingga UI/progres dapat menganggap target terset (bukan `null`) dan menampilkan perilaku yang tidak sesuai (mis. progres/validasi berbasis target).
- Solusi: Gunakan `ParserUtil.parseIntOrNull(row[NamaKolom.targetSmokeFreeHari])` pada `fromSqflite` agar nilai `null` tetap `null`. Periksa juga apakah nilai `0` dari data lama (jika ada) perlu diperlakukan sebagai tidak diset sesuai kebutuhan bisnis (verifikasi sebelum memutuskan).
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L53-L55), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L305-L315), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L419-L420)
- File bermasalah: [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart#L64-L66)
- Prompt: gunakan parse null di parserutil

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

#### Task 3

- Status: kerjakan
- Alasan: File `dashboard_screen.dart` sedang terbuka di editor (Open tabs), sehingga tidak dapat diedit sesuai aturan #5 kerjakan_task.md.
- Masalah: Commit `18cc24e` menggunakan `AsyncValue<dynamic>` secara eksplisit pada `ref.watch(impianProvider)` di `build()` (baris 83) dan pada parameter `_buildCardRingkasanImpian(BiodataModel biodata, AsyncValue<dynamic> impianAsync)` (baris 203-L206). Provider `impianProvider` mengembalikan `AsyncValue<ImpianState>` (terverifikasi di `.g.dart`), sehingga type inference sudah cukup dan penandaan `dynamic` tidak perlu — menambahkan `dynamic` secara eksplisit melanggar prinsip hindari `dynamic` ketika tipe dapat ditentukan secara jelas.
- Solusi: Hapus penandaan `dynamic` — biarkan `final impianAsync = ref.watch(impianProvider);` (otomatis `AsyncValue<ImpianState>`) dan ganti parameter menjadi `AsyncValue<ImpianState> impianAsync` (atau hapus parameter sama sekali dan watch di dalam method, sesuai kebutuhan).
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L51-L53)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L203-L206)
- Prompt: langsung saja cek isloading dan error sepertio biodataasync

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

# Kelompok 13

## File terdampak

- [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart)

## Tinggi

## Sedang

#### Task 1

- Status: Belum dikerjakan
- Masalah: Navigasi `Nav.to(context, FormImpian(impian: impian))` dijalankan melalui `unawaited()` tanpa penanganan error (baris 114). Jika Future navigasi gagal, error tidak ditangani. Pola ini melanggar skill `penanganan-error-unawaited` yang mewajibkan `catchError` atau `try/catch` untuk Future yang dilepas.
- Solusi: Tambahkan penanganan error pada Future navigasi sesuai pola di skill `.agents/skills/custom/penanganan-error-unawaited/SKILL.md`. Catat kegagalan menggunakan logger proyek dan sesuaikan nilai balik handler dengan tipe Future dari `Nav.to`.
- Aturan dilanggar: [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md)
- File bermasalah: [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart#L114)
- Prompt:

## Rendah

#### Task 2

- Status: Belum dikerjakan
- Masalah: Dua `Column` pada tampilan error menggunakan `const SizedBox(height: 8)` hanya untuk mengatur jarak antaranak (baris 41 dan 67). Skill spacing mewajibkan properti `spacing` pada `Column` untuk jarak antaranak yang seragam.
- Solusi: Tambahkan `spacing: 8` pada kedua `Column` tersebut dan hapus `SizedBox(height: 8)` yang hanya berfungsi sebagai jarak.
- Aturan dilanggar: [spacing](.agents/skills/custom/spacing/SKILL.md)
- File bermasalah: [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart#L41), [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart#L67)
- Prompt:
