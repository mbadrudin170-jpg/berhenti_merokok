# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

#### Task 1

- Status: Selesai
- Masalah: Pada `_buildSaldoTerkumpul` di `impian_screen.dart` digunakan `SizedBox(width: 8)` untuk memberi jarak antara ikon `Icons.savings_outlined` dan kolom teks. Jarak seragam antar-anak Row sebaiknya diatur dengan properti `spacing` pada `Row`, bukan `SizedBox` individual, sesuai `optimasi_ui.md` #4.
- Solusi: Ganti `SizedBox(width: 8)` dengan menambahkan `spacing: 8` pada `Row`, dan hapus `SizedBox` tersebut.
- Aturan dilanggar: [optimasi_ui.md](.agents/rules/global/optimasi_ui.md#L51-L53)
- File bermasalah: [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart#L328)
- Prompt:

#### Task 2

- Status: Belum dikerjakan
- Masalah: Logging `L.i` ditambahkan di `_buildCardTargetSmokeFree(...)` (dipanggil dari `build()`) yang mencatat `targetSmokeFreeHari/tanggalBerhenti/hariBerhenti/teksProgres` (baris ~166-168). Log di jalur `build()` dapat terpanggil berulang dan menambah noise.
- Solusi: Pindahkan/hapus log dari method yang dipanggil `build()`; log pada titik tidak berfrekuensi tinggi bila diperlukan.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L166-L168)
- Prompt:

#### Task 3

- Status: Belum dikerjakan
- Masalah: Commit `18cc24e` menambahkan `ref.watch(impianProvider)` di `build()` (baris 83) dengan logging `L.i('impianAsync.isLoading=..., hasError=...')` (baris 83-L86), serta logging `L.i` di dalam `_buildCardRingkasanImpian` (baris 211/215/226). Kedua berada di jalur `build()` yang dapat dipanggil berulang, menambah noise.
- Solusi: Hapus log `impianAsync.isLoading/hasError` dari `build()`; pindahkan log `ringkasan impian: ...` ke titik tidak berfrekuensi tinggi (initState/dispose/aksi) atau hapus sama sekali.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83-L86), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L211-L226)
- Prompt:

#### Task 4

- Status: Belum dikerjakan
- Masalah: Commit `18cc24e` menggunakan `AsyncValue<dynamic>` secara eksplisit pada `ref.watch(impianProvider)` di `build()` (baris 83) dan pada parameter `_buildCardRingkasanImpian(BiodataModel biodata, AsyncValue<dynamic> impianAsync)` (baris 203-L206). Provider `impianProvider` mengembalikan `AsyncValue<ImpianState>` (terverifikasi di `.g.dart`), sehingga type inference sudah cukup dan penandaan `dynamic` tidak perlu — menambahkan `dynamic` secara eksplisit melanggar prinsip hindari `dynamic` ketika tipe dapat ditentukan secara jelas.
- Solusi: Hapus penandaan `dynamic` — biarkan `final impianAsync = ref.watch(impianProvider);` (otomatis `AsyncValue<ImpianState>`) dan ganti parameter menjadi `AsyncValue<ImpianState> impianAsync` (atau hapus parameter sama sekali dan watch di dalam method, sesuai kebutuhan).
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L51-L53)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L203-L206)
- Prompt:

#### Task 5

- Status: Belum dikerjakan
- Masalah: Commit `18cc24e` menghasilkan dua potong dead code: (1) variabel `total` dihitung dari `impianState.jumlahImpian` (baris 220) tetapi tidak pernah digunakan — `subtitle` menggunakan `total` hanya untuk pengecekan `total == 0`, kemudian mencetak `$tercapai dari $total`; (2) field `totalTercapai` diinisialisasi di `build()` (baris 84-L85) dengan nilai `listImpian.where(...).length` tetapi tidak pernah dibaca di mana pun. Keduanya tidak memberikan informasi dan dapat mengacaukan pembacaan code.
- Solusi: Hapus variabel `total` (ganti `total == 0` dengan `listImpian.isEmpty` dan `$total` dengan `listImpian.length`), serta hapus field `totalTercapai` beserta inisialisasinya.
- Aturan dilanggar: [optimasi_boilerplate.md](.agents/rules/global/optimasi_boilerplate.md#L45-L50) (hindari penulisan ulang/komputasi tidak perlu), [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L47-L50] (fokus pada kode yang diperlukan)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L84-L85), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L218-L233)
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

- Status: Belum dikerjakan
- Masalah: Commit `adc85b5` mengubah nilai konstanta `NamaKolom.tanggalMulaiTapering` dari `'tanggal_mulai_tapering'` (snake_case) menjadi `'Tanggal_mulai_tapering'` (kapital `T`). Nilai ini tidak konsisten dengan konvensi snake_case kolom lain dan dengan nama kolom yang sudah dibuat di skema/migrasi (`tanggal_mulai_tapering`). Perbedaan kapitalisasi berisiko merusak baca/tulis tanggal mulai tapering (pemetaan ke kolom DB berbeda). Perubahan ini tampak tidak disengaja dan di luar tujuan commit (menambah target smoke-free).
- Solusi: Kembalikan nilai konstanta menjadi `static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';`. Verifikasi tidak ada referensi lain yang bergantung pada kapitalisasi salah; bila skema/migrasi sudah memakai nilai lama (lowercase), pastikan konsisten.
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L95-L100), [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L139-L140), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L310-L311)
- File bermasalah: [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart#L37)
- Prompt:

#### Task 2

- Status: Belum dikerjakan
- Masalah: `BiodataModel.fromSqflite` mem-parsing `targetSmokeFreeHari` (field nullable `int?`) menggunakan `ParserUtil.parseInt(...)` yang mengembalikan `defaultValue 0` ketika nilai DB `null` (terverifikasi: `share_global_saya/lib/src/utils/parser_util.dart` `parseInt` mengembalikan `defaultValue` untuk `null`). Akibatnya target yang tidak diset (`null`) dibaca sebagai `0`, sehingga UI/progres dapat menganggap target terset (bukan `null`) dan menampilkan perilaku yang tidak sesuai (mis. progres/validasi berbasis target).
- Solusi: Gunakan `ParserUtil.parseIntOrNull(row[NamaKolom.targetSmokeFreeHari])` pada `fromSqflite` agar nilai `null` tetap `null`. Periksa juga apakah nilai `0` dari data lama (jika ada) perlu diperlakukan sebagai tidak diset sesuai kebutuhan bisnis (verifikasi sebelum memutuskan).
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L53-L55), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L305-L315), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L419-L420)
- File bermasalah: [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart#L64-L66)
- Prompt:

## Sedang

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Logging `L.i` ditambahkan di jalur yang dipanggil dari `build()` pada biodata: (1) `BiodataScreen.build()` mencatat `targetSmokeFreeHari=$targetSmokeFreeHari` (baris ~75), (2) `_buildItem(...)` dipanggil berulang dari `build()` dan mencatat `label=$label, nilai=$nilai` (baris ~195). Ini berpotensi menambah noise karena `build()`/helper-nya dapat dipanggil berulang.
- Solusi: Pindahkan/hapus log yang dipicu dari `build()` dan helper per-item; cukup log pada titik tidak berfrekuensi tinggi (initState/dispose/aksi/perhitungan). Jika log tetap diperlukan, batasi pada perubahan nilai yang relevan di luar `build()`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L75), [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L195)
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

#### Task 1

- Status: Belum dikerjakan
- Masalah: Logging `L.i` ditambahkan di `_buildCardTargetSmokeFree(...)` (dipanggil dari `build()`) yang mencatat `targetSmokeFreeHari/tanggalBerhenti/hariBerhenti/teksProgres` (baris ~166-168). Log di jalur `build()` dapat terpanggil berulang dan menambah noise.
- Solusi: Pindahkan/hapus log dari method yang dipanggil `build()`; log pada titik tidak berfrekuensi tinggi bila diperlukan.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L166-L168)
- Prompt:

#### Task 2

- Status: Belum dikerjakan
- Masalah: Commit `18cc24e` menambahkan `ref.watch(impianProvider)` di `build()` (baris 83) dengan logging `L.i('impianAsync.isLoading=..., hasError=...')` (baris 83-L86), serta logging `L.i` di dalam `_buildCardRingkasanImpian` (baris 211/215/226). Kedua berada di jalur `build()` yang dapat dipanggil berulang, menambah noise.
- Solusi: Hapus log `impianAsync.isLoading/hasError` dari `build()`; pindahkan log `ringkasan impian: ...` ke titik tidak berfrekuensi tinggi (initState/dispose/aksi) atau hapus sama sekali.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L16), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L21), [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L272)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83-L86), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L211-L226)
- Prompt:

#### Task 3

- Status: Belum dikerjakan
- Masalah: Commit `18cc24e` menggunakan `AsyncValue<dynamic>` secara eksplisit pada `ref.watch(impianProvider)` di `build()` (baris 83) dan pada parameter `_buildCardRingkasanImpian(BiodataModel biodata, AsyncValue<dynamic> impianAsync)` (baris 203-L206). Provider `impianProvider` mengembalikan `AsyncValue<ImpianState>` (terverifikasi di `.g.dart`), sehingga type inference sudah cukup dan penandaan `dynamic` tidak perlu — menambahkan `dynamic` secara eksplisit melanggar prinsip hindari `dynamic` ketika tipe dapat ditentukan secara jelas.
- Solusi: Hapus penandaan `dynamic` — biarkan `final impianAsync = ref.watch(impianProvider);` (otomatis `AsyncValue<ImpianState>`) dan ganti parameter menjadi `AsyncValue<ImpianState> impianAsync` (atau hapus parameter sama sekali dan watch di dalam method, sesuai kebutuhan).
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L51-L53)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L83), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L203-L206)
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

# Kelompok 11

## File terdampak

- [pubspec.yaml](pubspec.yaml)

## Sedang

# Kelompok 12

## File terdampak

- [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart)

## Rendah

#### Task 1

- Status: Sedang
- Masalah: Urutan import pada `detail_impian_screen.dart` masih tidak sepenuhnya alfabetis berdasarkan path package. Commit 0b0b564 telah menukar `widget/visual_tabungan_impian.dart` dan `notifier/impian_notifier.dart` (notifier sekarang sebelum widget ✓), tetapi baris 7 `screens/form_impian.dart` masih berada di atas baris 8 `notifier/impian_notifier.dart`, padahal `notifier` secara alfabetis mendahului `screens`.
- Solusi: Pindahkan `screens/form_impian.dart` ke bawah `notifier/impian_notifier.dart`, sehingga urutan menjadi: `notifier/impian_notifier.dart`, `screens/form_impian.dart`, `widget/visual_tabungan_impian.dart`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L99-L104), [aturan_lainnya.md](.agents/rules/global/aturan_lainnya.md#L31)
- File bermasalah: [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart#L7-L9)
- Prompt:
