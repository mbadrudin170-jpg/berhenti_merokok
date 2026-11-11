# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

---

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

Tidak ada temuan.

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

Tidak ada temuan.

## Rendah

# Kelompok 14

## File terdampak

- [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

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

#### Task 3

- Status: belum
- Masalah: Commit `17d53cf` menggunakan warna hardcode `const Color(0xFFFF9800)` dan `const Color(0xFF4CAF50)` (baris 355-356) pada `dashboard_screen.dart` bukan dari `ColorScheme`/tema. Melangguarkan aturan styling warna yang wajib diambil dari tema.
- Solusi: Ganti warna hardcode dengan `Theme.of(context).colorScheme` atau warna semantik dari tema (mis. `colorScheme.primary`, `colorScheme.error`, `colorScheme.surface`).
- Aturan dilanggar: [gaya](.agents/skills/custom/gaya/SKILL.md)
- File bermasalah: [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L355-L356)
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

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

# Kelompok 16

## file terdampak

- [hasil_craving_enum.dart](lib/fitur/diary_craving/enum/hasil_craving_enum.dart)
- [strategi_craving_enum.dart](lib/fitur/diary_craving/enum/strategi_craving_enum.dart)
- [hasil_intervensi_sos_enum.dart](lib/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart)
- [jenis_intervensi_sos_enum.dart](lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart)
- [pola_craving_helper.dart](lib/fitur/diary_craving/helper/pola_craving_helper.dart)
- [sos_intervensi_model.dart](lib/fitur/sos_craving/model/sos_intervensi_model.dart)
- [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart)
- [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart)
- [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)

## Tinggi

#### Task 1

- Status : kerjakan
- Masalah : Commit `a15acd9` mendefinisikan enum value dengan gaya `snake_case` di beberapa enum baru (mis. `HasilCravingEnum.berhasil_menahan`, `HasilCravingEnum.belum_selesai`, `StrategiCravingEnum.napas_478`, `StrategiCravingEnum.tunda_5_menit`, `StrategiCravingEnum.alih_aktivitas`, `HasilIntervensiSos.belum_selesai`, `JenisIntervensiSos.timer_3_menit`) sedangkan enum value yang sudah dipakai proyek (`PemicuEnum.bauRokok`, `ModeBerhenti.seketika`, `StatusKalender.adaKonsumsi`) memakai `lowerCamelCase`. Nilai `.name` enum ini juga dipersistenkan ke kolom database (`mood`, `strategi`, `hasil`, `jenis_intervensi`, `hasil_intervensi`) sehingga inkonsistensi ikut tersimpan di data pengguna. (Value satu kata seperti `senang`, `stres`, `berkurang`, `distraksi`, `jalan`, `lainnya` tidak melanggar dan tidak perlu diubah.)
- Solusi : Ubah enum value yang melanggar menjadi `lowerCamelCase` (mis. `berhasilMenahan`, `tetapMerokok`, `belumSelesai`, `napas478`, `minumAir`, `alihAktivitas`, `tunda5Menit`, `timer3Menit`), perbarui seluruh referensi literal di model, helper, layar, dan bottom sheet, lalu bila nilai `snake_case` sudah tersimpan di database tambahkan migrasi pada `onUpgrade` versi berikutnya untuk memetakan nilai lama ke nilai baru (mis. `UPDATE diary_craving SET strategi = 'berhasilMenahan' WHERE strategi = 'berhasil_menahan'`). Contoh benar: `enum HasilCravingEnum { berhasilMenahan, tetapMerokok, belumSelesai }`.
- aturan dilanggar : [penamaan-konvensi](.agents/skills/custom/penamaan-konvensi/SKILL.md)
- file bermasalah : [hasil_craving_enum.dart](lib/fitur/diary_craving/enum/hasil_craving_enum.dart), [strategi_craving_enum.dart](lib/fitur/diary_craving/enum/strategi_craving_enum.dart), [hasil_intervensi_sos_enum.dart](lib/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart), [jenis_intervensi_sos_enum.dart](lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart), [sos_intervensi_model.dart](lib/fitur/sos_craving/model/sos_intervensi_model.dart), [pola_craving_helper.dart](lib/fitur/diary_craving/helper/pola_craving_helper.dart), [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart), [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart), [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)
- prompt :

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

# Kelompok 17

## file terdampak

- [sos_intervensi_notifier.dart](lib/fitur/sos_craving/notifier/sos_intervensi_notifier.dart)
- [pubspec.yaml](pubspec.yaml)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : kerjakan
- Masalah : Commit `a15acd9` mengimpor `package:uuid/uuid.dart` di `sos_intervensi_notifier.dart` (`const Uuid().v4()`), tetapi `uuid` tidak dideklarasikan di `pubspec.yaml`; `pubspec.lock` mencatat `uuid 4.6.0` sebagai dependensi `transitive` (dibawa oleh `share_global_saya`). Jika `share_global_saya` berhenti bergantung pada `uuid`, impor ini langsung gagal compile.
- Solusi : Deklarasikan `uuid` sebagai dependensi langsung di `pubspec.yaml` sesuai versi yang terpasang (tervalidasi di pub.dev, https://pub.dev/packages/uuid, terpasang `4.6.0`): tambahkan `uuid: ^4.6.0` pada bagian `dependencies`. Ini sejalan dengan konvensi pub (dependensi langsung wajib dideklarasikan sendiri; versi `^4.6.0` cocok dengan constraint `share_global_saya`).
- aturan dilanggar : tidak ada skill spesifik; rujukan dokumentasi paket pub.dev dan konvensi Dart/Flutter ("depend on the packages you directly import").
- file bermasalah : [sos_intervensi_notifier.dart](lib/fitur/sos_craving/notifier/sos_intervensi_notifier.dart), [pubspec.yaml](pubspec.yaml)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 18

## file terdampak

- [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart)
- [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : kerjakan
- Masalah : Commit `a15acd9` melemparkan `WidgetRef` dari `SosCravingScreen` ke widget `StatefulWidget` anak lewat konstruktor (`_Napas478View({required this.ref})`, `_TimerCravingView({required this.ref})`, `_DistraksiView({required this.ref})`) dan menyimpannya di field State. `WidgetRef` terikat pada siklus hidup element pembuatnya, sehingga menyimpannya di objek lain berisiko dipakai setelah element tidak aktif/rebuild. Pola yang benar untuk akses `ref` di dalam `StatefulWidget` adalah `ConsumerStatefulWidget`.
- Solusi : Ubah ketiga widget tersebut menjadi `ConsumerStatefulWidget` dan gunakan `ref` bawaan `ConsumerState` langsung di callback (timer selesai, napas selesai, distraksi selesai). Untuk helper `tampilkanDanSimpanHasilIntervensi` di `sheet_hasil_intervensi.dart`, pertahankan parameter `WidgetRef ref` yang dioper saat pemanggilan (bukan disimpan di field objek), atau lebih baik ambil `ref` di dalam `ConsumerWidget`/`ConsumerState` pemanggil saat callback dipicu. Contoh: `class _Napas478View extends ConsumerStatefulWidget { ... }` lalu `class _Napas478ViewState extends ConsumerState<_Napas478View> { ... }` dan panggil `tampilkanDanSimpanHasilIntervensi(context: context, ref: ref, ...)` dari dalam State tersebut.
- aturan dilanggar : [riverpod-pola](.agents/skills/custom/riverpod-pola/SKILL.md)
- file bermasalah : [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart), [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 19

## file terdampak

- [kalender_smoke_free_screen.dart](lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : belum
- Masalah : Commit `a15acd9` menambahkan fungsi top-level `_streakSaatIni` di `kalender_smoke_free_screen.dart` (dengan TODO(B.1) merujuk `prd/satukan_perhitungan_baseline_aktual.md`), tetapi commit `9c5dafb` kemudian membuat `MetrikBerhentiHelper.hitungStreak` dengan logika identik di `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart` tanpa memigrasi layar kalender. Akibatnya perhitungan turunan yang sama ditulis dua kali dan komentar TODO menjadi basi (PRD terkait sudah diimplementasikan dan dihapus pada `9c5dafb`).
- Solusi : Hapus `_streakSaatIni` dan ganti pemanggilannya dengan `MetrikBerhentiHelper.hitungStreak(konsumsiState.listKonsumsi)` (impor `lib/fitur/konsumsi_rokok/helper/metrik_berhenti_helper.dart`). Hapus juga komentar TODO(B.1) yang merujuk PRD yang sudah tidak ada.
- aturan dilanggar : [ekstraksi-perhitungan-turunan](.agents/skills/custom/ekstraksi-perhitungan-turunan/SKILL.md)
- file bermasalah : [kalender_smoke_free_screen.dart](lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 20

## file terdampak

- [sqflite.dart](lib/shared/db/sqflite/sqflite.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : belum
- Masalah : Commit `a15acd9` menempatkan `CREATE TABLE IF NOT EXISTS sos_intervensi (...)` dua kali di `onUpgrade`: di dalam blok `if (oldVersion < 9)` (sekitar baris 209-218, branch yang seharusnya hanya membuat `konsumsi_rokok`) dan di dalam blok `if (oldVersion < 11)` (sekitar baris 239-249). Duplikasi DDL yang sama di dua kondisi versi melanggar penanganan kondisional per versi dan berisiko inkonsisten bila skema tabel `sos_intervensi` diubah di masa depan (hanya satu salinan yang kemungkinan diperbarui).
- Solusi : Hapus blok `CREATE TABLE IF NOT EXISTS sos_intervensi` dari branch `oldVersion < 9` sehingga `konsumsi_rokok` (v9) dan `sos_intervensi` (v11) didefinisikan tepat sekali pada kondisi versinya masing-masing; `onCreate` tetap membuat kedua tabel. Ratakan juga indentasi blok `oldVersion < 9` agar konsisten dengan blok lain.
- aturan dilanggar : [migrasi-skema-sqlite](.agents/skills/custom/migrasi-skema-sqlite/SKILL.md)
- file bermasalah : [sqflite.dart](lib/shared/db/sqflite/sqflite.dart)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 21

## file terdampak

- [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : belum
- Masalah : Commit `f6d1fa2` mendaftarkan `WidgetsBinding.instance.addPostFrameCallback` di dalam `build()` pada `BadgeScreen`. Setiap rebuild mendaftarkan callback baru yang tidak dapat dibatalkan, sehingga penulisan `SharedPreferences` (`_simpanBadgeHistoris`) dapat terdaftar berkali-kali untuk badge yang sama selama fase awal (mis. saat `_historisDimuat` baru selesai). Pendaftaran post-frame callback yang berulang melanggar ketentuan bahwa pendaftaran dilakukan hanya sekali.
- Solusi : Pindahkan logika penyimpanan badge historis keluar dari `build()`: panggil `_simpanBadgeHistoris` tepat sekali setelah `_badgeHistoris` dimuat dan badge baru tercapai (mis. di dalam `_muatBadgeHistoris` setelah setState, atau di `didChangeDependencies` dengan flag `_postFrameTerdaftar`), atau minimal dedup pendaftaran dengan flag agar post-frame callback hanya didaftarkan sekali per perubahan. Contoh: `if (!_postFrameTerdaftar) { _postFrameTerdaftar = true; WidgetsBinding.instance.addPostFrameCallback(...); }`.
- aturan dilanggar : [penjadwalan-frame-dan-pemantauan-performa-flutter](.agents/skills/custom/penjadwalan-frame-dan-pemantauan-performa-flutter/SKILL.md)
- file bermasalah : [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 22

## file terdampak

- [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

#### Task 1

- Status : belum
- Masalah : Commit `a15acd9` mendeklarasikan parameter/field `value` (`final HasilIntervensiSos value;`) pada `_TombolHasil` di `sheet_hasil_intervensi.dart`, tetapi `value` tidak pernah dibaca di `build` (tombol hanya memakai `label` dan `onTap`). Kode mati ini menyesatkan pemelihara karena mengisyaratkan `value` dipakai.
- Solusi : Hapus parameter `value` beserta field-nya, atau bila memang ingin dipakai, gunakan `value` untuk menentukan `onTap`/gaya tombol. Contoh: `const _TombolHasil({required this.label, required this.onTap});` dan perbarui ketiga pemanggilan di bottom sheet.
- aturan dilanggar : tidak ada (kode mati / parameter tidak terpakai).
- file bermasalah : [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)
- prompt :

#### Task 2

- Status : belum
- Masalah : `_ambilEntriDiaryTerbaruHariIni` pada `sheet_hasil_intervensi.dart` mencari entri diary memakai prefix tanggal `DateTime.now().toUtc()` (mis. `2026-11-10%`), sedangkan entri diary dibuat dari waktu lokal perangkat yang dikonversi ke UTC sebelum disimpan. Untuk zona UTC+7, entri pagi hari (mis. lokal 10 Nov 06:30 WIB → UTC 09 Nov 23:30) tersimpan dengan tanggal UTC sehari sebelumnya, sehingga tawaran "Tautkan ke catatan craving?" gagal menemukan entri yang dibuat pada hari yang sama menurut waktu pengguna.
- Solusi : Normalisasi perbandingan ke komponen tanggal yang konsisten dengan cara entri disimpan, mis. cari entri dengan `tanggal >= awal hari lokal hari ini yang dikonversi ke UTC` dan `tanggal < awal hari lokal besok yang dikonversi ke UTC` (rentang UTC dari batas hari lokal), bukan prefix tanggal UTC. Contoh: `final awalLokal = DateTime(now.year, now.month, now.day); final awalUtc = awalLokal.toUtc().toIso8601String(); final akhirUtc = awalLokal.add(const Duration(days: 1)).toUtc().toIso8601String(); where: '${NamaKolom.tanggal} >= ? AND ${NamaKolom.tanggal} < ?', whereArgs: [awalUtc, akhirUtc]`.
- aturan dilanggar : [normalisasi-tanggal](.agents/skills/custom/normalisasi-tanggal/SKILL.md)
- file bermasalah : [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)
- prompt :

# Kelompok 23

## file terdampak

- [lainnya_screen.dart](lib/lainnya_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : belum
- Masalah : Commit `65abc01` menulis `ontap: () => Nav.to(context, const ...Screen())` pada seluruh pintasan menu di `_ItemLainnya` (SOS Craving, Alasan Berhenti, Konsumsi Rokok, Diary Craving, Kalender Smoke-Free, Pemulihan Kesehatan, Pelacakan Toxin, Pengaturan, dan Dummy). `Nav.to` mengembalikan `Future<T?>` yang dibuang secara diam-diam: tidak dibungkus `unawaited()` dan tidak memiliki `.catchError(...)` yang mencatat `L.e`, sehingga error navigasi menjadi unhandled dan tanpa log. Pola `_buildTombolCustom(() => Nav.to(...))` sebelum commit memiliki kelemahan yang sama, tetapi commit ini menyalinnya ke struktur `_ItemLainnya` alih-alih memperbaikinya.
- Solusi : Bungkus setiap pemanggilan dengan `unawaited(Nav.to(context, ...).catchError((Object e, StackTrace s) { L.e('Gagal navigasi ke <nama halaman>: $e $s'); return null; }))`. Contoh: `ontap: () => unawaited(Nav.to(context, const SosCravingScreen()).catchError((Object e, StackTrace s) { L.e('Gagal navigasi ke SOS Craving: $e $s'); return null; })),`. Lebih baik lagi: ekstrak helper bersama (mis. `_navigasi(BuildContext context, Widget page, String nama)`) agar pola aman ini tidak diulang di 10 tempat.
- aturan dilanggar : [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md), [kartu-motivasi-pintasan-dashboard](.agents/skills/custom/kartu-motivasi-pintasan-dashboard/SKILL.md)
- file bermasalah : [lainnya_screen.dart](lib/lainnya_screen.dart#L32-L88)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 24

## file terdampak

- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : belum
- Masalah : Commit `65abc01` menambahkan `onCta: () => unawaited(Nav.to(context, const FormImpian()))` (baris 251) pada `EmptyStateView` tanpa `.catchError(...)`. Skill penanganan-error-unawaited melarang melepas `unawaited(...)` tanpa penanganan error, dan skill kartu-motivasi-pintasan-dashboard mewajibkan `.catchError()` pada navigasi pintasan dengan log `L.e`. Pola identik (tanpa `catchError`) sudah ada lebih dulu di baris 254 dan 370 dan sebaiknya diperbaiki sekalian.
- Solusi : Tambahkan `.catchError((Object e, StackTrace s) { L.e('Gagal navigasi ke Form Impian: $e $s'); return null; })` sebelum penutup kurung `unawaited`, contoh: `onCta: () => unawaited(Nav.to(context, const FormImpian()).catchError((Object e, StackTrace s) { L.e('Gagal navigasi ke Form Impian: $e $s'); return null; })),`. Terapkan pola yang sama pada baris 254 dan 370.
- aturan dilanggar : [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md), [kartu-motivasi-pintasan-dashboard](.agents/skills/custom/kartu-motivasi-pintasan-dashboard/SKILL.md)
- file bermasalah : [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart#L251), [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart#L254), [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart#L370)
- prompt :

## Rendah

Tidak ada temuan.

# Kelompok 25

## file terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

#### Task 1

- Status : belum
- Masalah : Commit `fbcfada` menambahkan `_buildCaptionDariCatatan` yang mengembalikan `Text` telanjang dan diletakkan langsung sebagai anak `ListView` di antara `_buildRingkasan(biodata)` (Row berisi 3 kartu ringkasan) dan `_buildCardSosCraving()` (baris 119-121). Anak-anak `ListView` lain menjaga jarak lewat margin `Card`, tetapi `Text` tidak, sehingga caption `bodySmall` menempel rapat di bawah deretan kartu ringkasan dan rapat di atas kartu SOS Craving. Jarak antar elemen tidak serasi dan tidak mengikuti hierarki spasi yang dipakai layar lain.
- Solusi : Beri caption jarak vertikal, misalnya bungkus dengan `Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Text(...))` di dalam `_buildCaptionDariCatatan`, atau sisipkan `const SizedBox(height: 8)` sebelum dan sesudah `_buildCaptionDariCatatan(...)` pada daftar anak `ListView`. Alternatif: gunakan `ListView` dengan jarak seragam untuk seluruh anak.
- aturan dilanggar : [spacing](.agents/skills/custom/spacing/SKILL.md)
- file bermasalah : [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L119-L121), [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart#L315-L363)
- prompt :

# Kelompok 26

## file terdampak

- [alasan_berhenti_screen.dart](lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart)
- [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart)
- [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart)
- [detail_impian_screen.dart](lib/fitur/impian/screens/detail_impian_screen.dart)
- [kalender_smoke_free_screen.dart](lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart)
- [konsumsi_rokok_screen.dart](lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart)
- [pemulihan_kesehatan_screen.dart](lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart)
- [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart)
- [toxin_pelacakan_screen.dart](lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart)
- [empty_state_view.dart](lib/shared/widget/empty_state_view.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

