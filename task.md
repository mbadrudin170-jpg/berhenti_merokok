# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

#### Task 2

- Status: selesai
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

- Status: selesai
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

- Status: selesai
- Masalah: Commit `adc85b5` mengubah nilai konstanta `NamaKolom.tanggalMulaiTapering` dari `'tanggal_mulai_tapering'` (snake_case) menjadi `'Tanggal_mulai_tapering'` (kapital `T`). Nilai ini tidak konsisten dengan konvensi snake_case kolom lain dan dengan nama kolom yang sudah dibuat di skema/migrasi (`tanggal_mulai_tapering`). Perbedaan kapitalisasi berisiko merusak baca/tulis tanggal mulai tapering (pemetaan ke kolom DB berbeda). Perubahan ini tampak tidak disengaja dan di luar tujuan commit (menambah target smoke-free).
- Solusi: Kembalikan nilai konstanta menjadi `static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';`. Verifikasi tidak ada referensi lain yang bergantung pada kapitalisasi salah; bila skema/migrasi sudah memakai nilai lama (lowercase), pastikan konsisten.
- Aturan dilanggar: [optimasi_bug_runtime.md](.agents/rules/global/optimasi_bug_runtime.md#L95-L100), [aturan_bersama.md](.agents/rules/global/aturan_bersama.md#L139-L140), [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md#L310-L311)
- File bermasalah: [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart#L37)
- Prompt:

#### Task 2

- Status: selesai
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

- Status: dilewati
- Alasan: Task ini duplikat dengan Task 4 di Kelompok 1 yang sudah selesai dikerjakan (menghapus penandaan `dynamic` eksplisit pada `impianProvider` dan parameter method). File `dashboard_screen.dart` sudah diperbaiki di Kelompok 1 Task 4.
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

# Kelompok 14

## File terdampak

- [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status: Belum dikerjakan
- Masalah: Ringkasan menggabungkan seluruh kategori di luar tiga teratas menjadi baris berlabel `Lainnya` (baris 108-110 dan 250-254), sementara `PemicuEnum.lainnya` juga merupakan kategori pilihan pengguna dengan label yang sama. Jika kategori enum tersebut masuk tiga teratas, UI dapat menampilkan dua baris bernama `Lainnya`. Jika tidak masuk tiga teratas, jumlah kategori itu tercampur dalam agregat kategori lain sehingga arti label tidak jelas.
- Solusi: Bedakan label kategori enum `PemicuEnum.lainnya` dari label agregat kategori di luar tiga teratas, misalnya gunakan `Kategori lain` untuk agregat. Pastikan jumlah yang ditampilkan tetap mencakup setiap entri tepat satu kali.
- Aturan dilanggar: Konsistensi label dan makna agregasi data pada ringkasan pemicu.
- File bermasalah: [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L101-L110), [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L242-L255), [pemicu_enum.dart](lib/fitur/diary_craving/enum/pemicu_enum.dart)
- Prompt:

#### Task 2

- Status: Belum dikerjakan
- Masalah: Tiga navigasi memakai `unawaited(Nav.to(...))` tanpa penanganan error: tombol tambah pada empty state (baris 118), navigasi dari item daftar (baris 167-169), dan tombol tambah pada daftar (baris 181). Jika Future navigasi gagal, error dapat menjadi unhandled. Pola ini sudah ada sebelum commit yang dievaluasi, tetapi masih terdapat pada berkas yang berubah.
- Solusi: Tambahkan `.catchError(...)` pada setiap Future navigasi dan catat kegagalan melalui `L.e`. Sesuaikan nilai balik handler dengan tipe Future dari `Nav.to`.
- Aturan dilanggar: [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md), [pola-ux](.agents/skills/custom/pola-ux/SKILL.md)
- File bermasalah: [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L118), [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L166-L169), [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L181)
- Prompt:

## Rendah

#### Task 3

- Status: Belum dikerjakan
- Masalah: `_BarisPemicu` menggunakan `const SizedBox(width: 8)` hanya untuk memberi jarak antara ikon dan teks di dalam `Row` (baris 278-282). Skill spacing mewajibkan penggunaan properti `Row.spacing` untuk jarak seragam antar-anak.
- Solusi: Tambahkan `spacing: 8` pada `Row` dan hapus `SizedBox(width: 8)`.
- Aturan dilanggar: [spacing](.agents/skills/custom/spacing/SKILL.md)
- File bermasalah: [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L278-L282)
- Prompt:

#### Task 4

- Status: Belum dikerjakan
- Masalah: Comparator pada `entriPemicu.sort((a, b) => b.value.compareTo(a.value))` hanya membandingkan jumlah. Saat dua kategori memiliki jumlah sama, comparator mengembalikan `0`; API Dart menyatakan `List.sort` tidak menjamin urutan stabil. Jika seri terjadi di batas tiga kategori teratas, anggota `topPemicu` dan agregat kategori lain dapat berubah urutannya.
- Solusi: Tambahkan tie-breaker deterministik, misalnya membandingkan `PemicuEnum.index` ketika jumlah sama. Pastikan pemilihan tiga kategori teratas konsisten.
- Aturan dilanggar: Determinisme pengurutan hasil ketika nilai pembanding sama. Referensi: [Dart List.sort](https://api.flutter.dev/flutter/dart-core/List/sort.html).
- File bermasalah: [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L105-L107)
- Prompt:

#### Task 5

- Status: Belum dikerjakan
- Masalah: Logging `L.i` masih dilakukan pada jalur `build()` untuk status `cravingAsync` (baris 66-68), jumlah daftar (baris 98), dan di `itemBuilder` (baris 143-146). Logging ini dapat berulang setiap rebuild atau saat item daftar dibangun kembali sehingga menambah noise. Temuan ini sudah ada sebelum commit yang dievaluasi.
- Solusi: Hapus atau pindahkan log dari `build()` dan `itemBuilder`; pertahankan log pada titik yang tidak berfrekuensi tinggi seperti `initState`, `dispose`, atau handler aksi bila masih diperlukan.
- Aturan dilanggar: [logging-debug](.agents/skills/custom/logging-debug/SKILL.md)
- File bermasalah: [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L66-L68), [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L98), [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart#L143-L146)
- Prompt:

# Kelompok 15

## file terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [konsumsi_hitung_helper.dart](lib/fitur/konsumsi_rokok/helper/konsumsi_hitung_helper.dart)
- [konsumsi_rokok_model.dart](lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart)
- [konsumsi_rokok_notifier.dart](lib/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart)
- [konsumsi_rokok_state.dart](lib/fitur/konsumsi_rokok/state/konsumsi_rokok_state.dart)
- [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart)
- [form_konsumsi_rokok.dart](lib/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart)
- [pola_craving_helper.dart](lib/fitur/diary_craving/helper/pola_craving_helper.dart)
- [lainnya_screen.dart](lib/lainnya_screen.dart)
- [sqflite.dart](lib/shared/db/sqflite/sqflite.dart)
- [shared_keys.dart](lib/shared/helper/shared_keys.dart)
- [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart)
- [nama_tabel.dart](lib/shared/konstanta/nama_tabel.dart)
- [cadangan_helper.dart](lib/fitur/cadangan/helper/cadangan_helper.dart)
- [toxin_hitung_helper.dart](lib/fitur/toxin_pelacakan/helper/toxin_hitung_helper.dart)
- [toxin_model.dart](lib/fitur/toxin_pelacakan/model/toxin_model.dart)
- [toxin_pelacakan_screen.dart](lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart)
- [toxin_pelacakan_state.dart](lib/fitur/toxin_pelacakan/state/toxin_pelacakan_state.dart)
- [pubspec.yaml](pubspec.yaml)

## Tinggi

#### Task 1

- Status: belum
- Masalah: Commit `17d53cf` menambahkan logging `L.i('konsumsiAsync.isLoading=..., hasError=...')` di dalam method `build()` (baris 88-89) pada `dashboard_screen.dart`. Log di jalur `build()` dapat dipanggil berulang setiap rebuild, menambah noise log.
- Solusi: Hapus log `konsumsiAsync.isLoading/hasError` dari `build()`; pindahkan ke titik tidak berfrekuensi tinggi seperti `initState` atau handler aksi bila masih diperlukan.
- Aturan dilanggar: [logging-debug](.agents/skills/custom/logging-debug/SKILL.md)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L88-L89)
- Prompt:

#### Task 2

- Status: belum
- Masalah: Commit `17d53cf` menambahkan logging `L.i('konsumsiHariIni=..., targetHariIni=..., sedangTapering=..., melebihiTarget=...')` di dalam method widget `_buildCardKonsumsiHariIni` (baris 357-361) yang dipanggil dari `build()`. Log di jalur build dapat dipanggil berulang.
- Solusi: Hapus log dari method widget yang dipanggil `build()`; pindahkan ke titik tidak berfrekuensi tinggi.
- Aturan dilanggar: [logging-debug](.agents/skills/custom/logging-debug/SKILL.md)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L357-L361)
- Prompt:

#### Task 3

- Status: belum
- Masalah: Commit `17d53cf` menggunakan warna hardcode `const Color(0xFFFF9800)` dan `const Color(0xFF4CAF50)` (baris 355-356) pada `dashboard_screen.dart` bukan dari `ColorScheme`/tema. Melangguarkan aturan styling warna yang wajib diambil dari tema.
- Solusi: Ganti warna hardcode dengan `Theme.of(context).colorScheme` atau warna semantik dari tema (mis. `colorScheme.primary`, `colorScheme.error`, `colorScheme.surface`).
- Aturan dilanggar: [gaya](.agents/skills/custom/gaya/SKILL.md)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L355-L356)
- Prompt:

#### Task 4

- Status: belum
- Masalah: Commit `17d53cf` menggunakan `const SizedBox(height: 8)` (baris 381) pada `Column` yang sudah memiliki `spacing: 8` pada `dashboard_screen.dart`. Skill spacing mewajibkan properti `spacing` pada `Column` untuk jarak antaranak seragam.
- Solusi: Hapus `SizedBox(height: 8)` yang redundan; gunakan `spacing` pada `Column` untuk jarak yang seragam.
- Aturan dilanggar: [spacing](.agents/skills/custom/spacing/SKILL.md)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L381)
- Prompt:

#### Task 5

- Status: belum
- Masalah: Commit `17d53cf` menambahkan logging `L.i('konsumsiAsync=$konsumsiAsync')` di dalam method `build()` (baris 24) pada `konsumsi_rokok_screen.dart`. Logging seluruh objek `AsyncValue` di jalur build dapat dipanggil berulang.
- Solusi: Hapus log dari `build()`; pindahkan ke titik tidak berfrekuensi tinggi.
- Aturan dilanggar: [logging-debug](.agents/skills/custom/logging-debug/SKILL.md)
- File bermasalah: [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart#L24)
- Prompt:

#### Task 6

- Status: belum
- Masalah: Commit `17d53cf` menggunakan warna hardcode `Color(0xFFEF5350)` (baris 131 dan 139) pada `konsumsi_rokok_screen.dart` bukan dari `ColorScheme`/tema.
- Solusi: Ganti dengan `Theme.of(context).colorScheme.error` atau warna semantik dari tema.
- Aturan dilanggar: [gaya](.agents/skills/custom/gaya/SKILL.md)
- File bermasalah: [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart#L131), [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart#L139)
- Prompt:

#### Task 7

- Status: belum
- Masalah: Commit `17d53cf` menggunakan warna hardcode `Colors.grey` (baris 175 dan 183) pada `_EmptyKonsumsiRokok` di `konsumsi_rokok_screen.dart` bukan dari `ColorScheme`/tema.
- Solusi: Ganti dengan `Theme.of(context).colorScheme.onSurfaceVariant` atau warna semantik dari tema.
- Aturan dilanggar: [gaya](.agents/skills/custom/gaya/SKILL.md)
- File bermasalah: [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart#L175), [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart#L183)
- Prompt:

#### Task 8

- Status: belum
- Masalah: Commit `17d53cf` menggunakan `const SizedBox(height: 8)` (baris 214) pada `Column` yang sudah memiliki `spacing: 12` di `form_konsumsi_rokok.dart`. Skill spacing mewajibkan properti `spacing` pada `Column`.
- Solusi: Hapus `SizedBox(height: 8)` yang redundan; gunakan `spacing` pada `Column`.
- Aturan dilanggar: [spacing](.agents/skills/custom/spacing/SKILL.md)
- File bermasalah: [form_konsumsi_rokok.dart](lib/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart#L214)
- Prompt:

#### Task 9

- Status: belum
- Masalah: Commit `1788a1c` menggunakan `unawaited(Nav.to(...))` tanpa penanganan `catchError` pada 3 tombol navigasi di `toxin_pelacakan_screen.dart` (baris 212-213, 248-249, 283-284). Jika Future navigasi gagal, error tidak ditangani.
- Solusi: Tambahkan `.catchError(...)` pada setiap Future navigasi dan catat kegagalan menggunakan `L.e`. Sesuaikan nilai balik handler dengan tipe Future dari `Nav.to`.
- Aturan dilanggar: [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md)
- File bermasalah: [toxin_pelacakan_screen.dart](lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart#L212-L213), [toxin_pelacakan_screen.dart](lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart#L248-L249), [toxin_pelacakan_screen.dart](lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart#L283-L284)
- Prompt:

#### Task 10

- Status: belum
- Masalah: Commit `17d53cf` menggunakan `parseInt` dengan `defaultValue` pada field yang nullable di `konsumsi_rokok_model.dart` (`fromSqflite` baris 27-28). Nilai `null` dari database dapat dibaca sebagai `0` atau `1` bukan tetap `null`.
- Solusi: Gunakan `parseIntOrNull` untuk field nullable agar `null` tetap `null`, sesuai skill `parsing-nullable-int`.
- Aturan dilanggar: [parsing-nullable-int](.agents/skills/custom/parsing-nullable-int/SKILL.md)
- File bermasalah: [konsumsi_rokok_model.dart](lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart#L27-L28)
- Prompt:

#### Task 11

- Status: belum
- Masalah: `flutter_local_notifications ^23.0.0` di `pubspec.yaml` memerlukan Flutter SDK 3.44.0 minimum (per dokumentasi pub.dev), sedangkan batasan project adalah `sdk: ^3.13.7`. Potensi ketidakkocokan versi SDK yang dapat menyebabkan build gagal atau perilaku tidak terduga.
- Solusi: Verifikasi versi Flutter SDK yang terinstall dan pertimbangkan untuk menurunkan `flutter_local_notifications` ke versi yang kompatibel, atau naikkan batasan SDK project jika memungkinkan.
- Aturan dilanggar: kompatibilitas versi SDK/paket dengan dokumentasi pub.dev
- File bermasalah: [pubspec.yaml](pubspec.yaml#L18)
- Prompt:

#### Task 12

- Status: belum
- Masalah: `flutter_easyloading ^4.0.2` di `pubspec.yaml` memerlukan Flutter 3.27.0+ dan Dart 3.6.0+ (per dokumentasi pub.dev), sedangkan batasan project adalah `sdk: ^3.13.7`. Potensi ketidakkocokan versi.
- Solusi: Verifikasi versi Flutter/Dart SDK yang terinstall dan pastikan kompatibel dengan versi paket yang digunakan.
- Aturan dilanggar: kompatibilitas versi SDK/paket dengan dokumentasi pub.dev
- File bermasalah: [pubspec.yaml](pubspec.yaml#L17)
- Prompt:

#### Task 13

- Status: belum
- Masalah: `share_plus ^13.3.1` di `pubspec.yaml` memerlukan Flutter >=3.38.1 dan Dart >=3.10.0 (per dokumentasi pub.dev), sedangkan batasan project adalah `sdk: ^3.13.7`. Potensi ketidakkocokan versi.
- Solusi: Verifikasi versi Flutter SDK yang terinstall dan pastikan kompatibel dengan `share_plus`.
- Aturan dilanggar: kompatibilitas versi SDK/paket dengan dokumentasi pub.dev
- File bermasalah: [pubspec.yaml](pubspec.yaml#L27)
- Prompt:

## Sedang

#### Task 1

- Status: belum
- Masalah: Commit `17d53cf` melakukan logging `L.i('catatCepat model=$model')` pada `konsumsi_rokok_notifier.dart` (baris 54) yang mencatat seluruh objek model. Dapat menambah noise log dan potensi membocorkan data.
- Solusi: Kurangi detail log atau hapus log model lengkap; log hanya ID atau ringkasan non-sensitif bila diperlukan.
- Aturan dilanggar: [logging-debug](.agents/skills/custom/logging-debug/SKILL.md)
- File bermasalah: [konsumsi_rokok_notifier.dart](lib/fitur/konsumsi_rokok/notifier/konsumsi_rokok_notifier.dart#L54)
- Prompt:

#### Task 2

- Status: belum
- Masalah: Commit `1788a1c` melakukan logging `L.i('biodata=$biodata, rokokTidakDiHisap=$rokokTidakDiHisap')` pada `toxin_pelacakan_screen.dart` (baris 87) yang mencatat seluruh objek `BiodataModel`. Dapat membocorkan data sensitif pengguna ke log.
- Solusi: Hapus logging objek `biodata` lengkap; log hanya field non-sensitif seperti `rokokTidakDiHisap` bila diperlukan.
- Aturan dilanggar: [logging-debug](.agents/skills/custom/logging-debug/SKILL.md), [keamanan-aplikasi](.agents/skills/custom/keamanan-aplikasi/SKILL.md)
- File bermasalah: [toxin_pelacakan_screen.dart](lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart#L87)
- Prompt:

## Rendah

Tidak ada temuan.
