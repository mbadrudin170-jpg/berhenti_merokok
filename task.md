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

Tidak ada temuan.

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

Tidak ada temuan.

## Rendah

Tidak ada temuan.

# Kelompok 18

## file terdampak

- [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart)
- [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

# Kelompok 19

## file terdampak

- [kalender_smoke_free_screen.dart](lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

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

Tidak ada temuan.

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

# Kelompok 23

## file terdampak

- [lainnya_screen.dart](lib/lainnya_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

# Kelompok 24

## file terdampak

- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

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

Tidak ada temuan.

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

---

# Kelompok 27

## file terdampak

- [hasil_craving_enum.dart](lib/fitur/diary_craving/enum/hasil_craving_enum.dart)
- [strategi_craving_enum.dart](lib/fitur/diary_craving/enum/strategi_craving_enum.dart)
- [hasil_intervensi_sos_enum.dart](lib/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart)
- [jenis_intervensi_sos_enum.dart](lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart)
- [pola_craving_helper.dart](lib/fitur/diary_craving/helper/pola_craving_helper.dart)
- [sos_intervensi_model.dart](lib/fitur/sos_craving/model/sos_intervensi_model.dart)
- [diary_craving_screen.dart](lib/fitur/diary_craving/screens/diary_craving_screen.dart)
- [sos_craving_screen.dart](lib/fitur/sos_craving/screens/sos_craving_screen.dart)
- [box_breathing_view.dart](lib/fitur/sos_craving/widgets/box_breathing_view.dart)
- [distraksi_view.dart](lib/fitur/sos_craving/widgets/distraksi_view.dart)
- [grounding_54321_view.dart](lib/fitur/sos_craving/widgets/grounding_54321_view.dart)
- [napas_478_view.dart](lib/fitur/sos_craving/widgets/napas_478_view.dart)
- [napas_90_detik_view.dart](lib/fitur/sos_craving/widgets/napas_90_detik_view.dart)
- [timer_craving_view.dart](lib/fitur/sos_craving/widgets/timer_craving_view.dart)
- [urge_surfing_view.dart](lib/fitur/sos_craving/widgets/urge_surfing_view.dart)
- [sheet_hasil_intervensi.dart](lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

---

# Kelompok 28

## file terdampak

- [sqflite.dart](lib/shared/db/sqflite/sqflite.dart)
- [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart)
- [nama_tabel.dart](lib/shared/konstanta/nama_tabel.dart)

## Tinggi

#### Task 1

- Status : selesai
- Masalah : Commit `db5dd32` menambahkan tabel `rencana_darurat` (skema v13) hanya di `_onUpgrade`, tetapi tidak di `_buatTabel` (onCreate). Instalasi baru pada versi 13 tidak akan memiliki tabel `rencana_darurat` sehingga query/insert ke tabel tersebut gagal pada pengguna baru. Melanggar aturan skill migrasi skema: onCreate wajib membuat seluruh tabel yang dibutuhkan aplikasi (termasuk tabel baru), dan tabel baru wajib dibuat baik di `onCreate` maupun di `onUpgrade`.
- Solusi : Tambahkan blok `CREATE TABLE IF NOT EXISTS` untuk `rencana_darurat` ke `_buatTabel` (mis. setelah blok `sosIntervensi`). Contoh:

  ```dart
  await db.execute('''
    CREATE TABLE IF NOT EXISTS ${NamaTabel.rencanaDarurat}(
      ${NamaKolom.id} TEXT PRIMARY KEY,
      ${NamaKolom.jika} TEXT NOT NULL,
      ${NamaKolom.maka} TEXT NOT NULL,
      ${NamaKolom.dibuat} TEXT NOT NULL
    )
  ''');
  ```

- aturan dilanggar : [migrasi-skema-sqlite](.agents/skills/custom/migrasi-skema-sqlite/SKILL.md)
- file bermasalah : [sqflite.dart](lib/shared/db/sqflite/sqflite.dart#L44-L120)
- prompt :

## Sedang

#### Task 2

- Status : selesai
- Masalah : Commit `db5dd32` menempatkan DDL `CREATE TABLE IF NOT EXISTS rencana_darurat` di dalam branch `oldVersion < 11` (cabang untuk `sos_intervensi` v11) sekaligus di branch `oldVersion < 13`. Penempatan di branch v11 salah versi (`rencana_darurat` adalah v13) dan menyebabkan duplikasi DDL untuk upgrade dari versi ≤10 (tabel dibuat dua kali; idempoten karena `IF NOT EXISTS`, tetapi menyesatkan dan berisiko drift bila skema tabel diubah di masa depan). Blok `oldVersion < 11` baru juga ber-indentasi ragged (isi tidak sejajar dengan `if`), mengikuti pola buruk blok `oldVersion < 9` yang sudah dilaporkan di Kelompok 20 Task 1 dan belum diperbaiki.
- Solusi : Hapus blok `CREATE TABLE rencana_darurat` dari branch `oldVersion < 11` sehingga branch itu kembali hanya membuat `sos_intervensi`; biarkan pembuatan tabel `rencana_darurat` hanya di branch `oldVersion < 13` (dan di `onCreate` sesuai Kelompok 28 Task 1). Ratakan indentasi blok `oldVersion < 11` (dan `oldVersion < 9`) ke level yang sama dengan branch lain. Perhatikan juga temuan duplikasi `sos_intervensi` di Kelompok 20 Task 1 (masih belum).
- aturan dilanggar : [migrasi-skema-sqlite](.agents/skills/custom/migrasi-skema-sqlite/SKILL.md)
- file bermasalah : [sqflite.dart](lib/shared/db/sqflite/sqflite.dart#L240-L260), [sqflite.dart](lib/shared/db/sqflite/sqflite.dart#L315-L325)
- prompt :

## Rendah

Tidak ada temuan.

---

# Kelompok 29

## file terdampak

- [badge_screen.dart](lib/fitur/badge/screens/badge_screen.dart)
- [kalender_smoke_free_screen.dart](lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart)
- [pubspec.yaml](pubspec.yaml)

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

Tidak ada temuan.

---

# Kelompok 30

## file terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)
- [lainnya_screen.dart](lib/lainnya_screen.dart)
- [rencana_darurat_model.dart](lib/fitur/rencana_darurat/model/rencana_darurat_model.dart)
- [rencana_darurat_state.dart](lib/fitur/rencana_darurat/state/rencana_darurat_state.dart)

## Tinggi

#### Task 1

- Status : selesai
- Masalah : Commit `db5dd32` menambahkan `RencanaDaruratModel` dan `RencanaDaruratState` dengan direktif `part '...freezed.dart'`, tetapi file generated (`rencana_darurat_model.freezed.dart`, `rencana_darurat_state.freezed.dart`) tidak ikut di-commit, padahal proyek ini meng-commit file generated (lihat file `*.freezed.dart` lain di `git ls-files`). Akibatnya kode pada commit tersebut gagal di-compile: `dart analyze` melaporkan `uri_does_not_exist` untuk kedua part file dan nama `_$RencanaDaruratModel` / `_$RencanaDaruratState` tidak terdefinisi.
- Solusi : Jalankan `dart run build_runner build --delete-conflicting-outputs` lalu commit kedua file generated tersebut. Contoh: `git add lib/fitur/rencana_darurat/model/rencana_darurat_model.freezed.dart lib/fitur/rencana_darurat/state/rencana_darurat_state.freezed.dart`.
- aturan dilanggar : [build-runner-codegen](.agents/skills/custom/build-runner-codegen/SKILL.md)
- file bermasalah : [rencana_darurat_model.dart](lib/fitur/rencana_darurat/model/rencana_darurat_model.dart#L5), [rencana_darurat_state.dart](lib/fitur/rencana_darurat/state/rencana_darurat_state.dart#L4)
- prompt :

## Sedang

Tidak ada temuan.

## Rendah

#### Task 2

- Status : belum
- Masalah : Commit `db5dd32` membuat indentasi tidak konsisten pada `floatingActionButton` di `impian_screen.dart` — closure `Nav.to(...)` kelebihan indent (12 spasi) di dalam `unawaited(`, sementara `child:` dan kurung tutup sejajar dengan `onPressed:`; blok menjadi sulit dibaca dan tidak seragam dengan dua pemanggilan lain di file yang sama. (Ketidakkonsistenan format, tidak ada skill yang dilanggar.)
- Solusi : Ratakan indentasi blok tersebut mengikuti pola dua pemanggilan lain di file yang sama (baris 252 dan 263): `onPressed: () => unawaited(` lalu isi satu level lebih dalam, `child:` dan `),` sejajar dengan `onPressed:`.
- aturan dilanggar : tidak ada (ketidakkonsistenan format)
- file bermasalah : [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart#L385-L397)
- prompt :

---

# Kelompok 31

## file terdampak

- [rencana_darurat_screen.dart](lib/fitur/rencana_darurat/screens/rencana_darurat_screen.dart)
- [form_rencana_darurat.dart](lib/fitur/rencana_darurat/screens/form_rencana_darurat.dart)
- [cadangan_screen.dart](lib/fitur/cadangan/screens/cadangan_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status : belum
- Masalah : Commit `2462af8` menambahkan tabel `konsumsi_rokok`, `sos_intervensi`, dan `rencana_darurat` ke dalam `tabelCadangan` sehingga `CadanganHelper.pulihkanDariPayload` kini ikut menghapus dan mengisi ulang ketiga tabel tersebut saat pemulihan, tetapi `_refreshProviderSetelahRestore` di `cadangan_screen.dart` hanya me-`refresh` `biodataProvider`, `impianProvider`, `diaryCravingProvider`, dan `alasanBerhentiProvider`. Akibatnya, layar yang memantau `konsumsiRokokProvider` (mis. kalender smoke-free, impian, dashboard), `sosIntervensiProvider` (sheet hasil intervensi SOS), dan `rencanaDaruratProvider` (kartu rencana darurat di SOS Craving, layar rencana darurat) tetap menampilkan data lama setelah pemulihan cadangan hingga aplikasi dimuat ulang. Melanggar aturan skill ekspor/pemulihan cadangan: setelah pemulihan berhasil wajib menyegarkan seluruh provider yang terkait data yang dipulihkan agar UI tidak basi.
- Solusi : Tambahkan refresh untuk `konsumsiRokokProvider`, `sosIntervensiProvider`, dan `rencanaDaruratProvider` pada `_refreshProviderSetelahRestore` dengan pola try/catch `L.e` yang sama. Contoh:

  ```dart
  try {
    final _ = ref.refresh(konsumsiRokokProvider);
  } on Exception catch (e, s) {
    L.e('Gagal refresh konsumsiRokokProvider: $e $s');
  }
  try {
    final _ = ref.refresh(sosIntervensiProvider);
  } on Exception catch (e, s) {
    L.e('Gagal refresh sosIntervensiProvider: $e $s');
  }
  try {
    final _ = ref.refresh(rencanaDaruratProvider);
  } on Exception catch (e, s) {
    L.e('Gagal refresh rencanaDaruratProvider: $e $s');
  }
  ```

- aturan dilanggar : [ekspor-pemulihan-cadangan](.agents/skills/custom/ekspor-pemulihan-cadangan/SKILL.md)
- file bermasalah : [cadangan_screen.dart](lib/fitur/cadangan/screens/cadangan_screen.dart#L243-L265)
- prompt :

## Rendah

#### Task 2

- Status : belum
- Masalah : Commit `2462af8` melepas `unawaited(_hapus(item))` pada `onPressed` `IconButton` hapus di `rencana_darurat_screen.dart` tanpa `.catchError(...)`. Di dalam `_hapus`, pemanggilan `showOkCancelAlertDialog` berada di luar blok `try`, sehingga exception dari dialog (mis. kegagalan platform channel) menjadi error async yang tidak tertangani. Melanggar aturan skill penanganan error unawaited: Future yang dilepas dengan `unawaited()` wajib memiliki `catchError` yang mencatat via `L.e`. (Catatan: pola serupa sudah ada di layar lain, tetapi commit `2462af8` memperkenalkan instance baru.)
- Solusi : Bungkus pemanggilan `_hapus(item)` dengan `catchError`. Contoh: `onPressed: () => unawaited(_hapus(item).catchError((Object e, StackTrace s) { L.e('Gagal menghapus rencana darurat: $e $s'); return null; })),` atau pindahkan `showOkCancelAlertDialog` ke dalam blok `try` pada `_hapus`.
- aturan dilanggar : [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md)
- file bermasalah : [rencana_darurat_screen.dart](lib/fitur/rencana_darurat/screens/rencana_darurat_screen.dart#L158), [rencana_darurat_screen.dart](lib/fitur/rencana_darurat/screens/rencana_darurat_screen.dart#L47-L62)
- prompt :

#### Task 3

- Status : belum
- Masalah : Commit `2462af8` melepas `unawaited(_simpan())` pada `onPressed` `OutlinedButton` simpan di `form_rencana_darurat.dart` tanpa `.catchError(...)`. Di dalam `_simpan`, pemanggilan `showOkCancelAlertDialog` dan `setState(() => _sedangMemproses = true)` berada di luar blok `try`, sehingga exception dari dialog (mis. kegagalan platform channel) menjadi error async yang tidak tertangani. Melanggar aturan skill penanganan error unawaited: Future yang dilepas dengan `unawaited()` wajib memiliki `catchError` yang mencatat via `L.e`.
- Solusi : Bungkus pemanggilan `_simpan()` dengan `catchError`. Contoh: `onPressed: _sedangMemproses ? null : () => unawaited(_simpan().catchError((Object e, StackTrace s) { L.e('Gagal menyimpan rencana darurat: $e $s'); return null; })),` atau pindahkan `showOkCancelAlertDialog` ke dalam blok `try` pada `_simpan`.
- aturan dilanggar : [penanganan-error-unawaited](.agents/skills/custom/penanganan-error-unawaited/SKILL.md)
- file bermasalah : [form_rencana_darurat.dart](lib/fitur/rencana_darurat/screens/form_rencana_darurat.dart#L196), [form_rencana_darurat.dart](lib/fitur/rencana_darurat/screens/form_rencana_darurat.dart#L62-L84)
- prompt :

