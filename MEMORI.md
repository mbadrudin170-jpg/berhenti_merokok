# MEMORI Proyek: berhenti_merokok

## Status Proyek
- **Nama**: berhenti_merokok
- **Deskripsi**: Aplikasi Flutter untuk membantu pengguna berhenti merokok
- **Versi**: 1.0.0+1
- **Platform**: Flutter (Android, iOS, Web, Desktop)
- **Status Implementasi**: Sedang Diimplementasikan
- **Terakhir Diperbarui**: 2026-11-12 (verifikasi jumlah skill: 87 file `SKILL.md` di `.agents/skills` = 54 `custom` + 33 `bawaan`; `available_skills` menampilkan **88** entri = 54 `custom` + 1 `kilo-config` bawaan Kilo + 33 `bawaan`; `SKILLS_INDEX.md` = 87 entri)

## Struktur Utama Layar (Screen)
Folder fitur ada di `lib/fitur/` (16 folder). Fitur utama:
1. **Dashboard** (`lib/fitur/dashboard/`) - Layar utama dengan navigasi tab
2. **Biodata** (`lib/fitur/biodata/`) - Data pribadi pengguna (history merokok, target)
3. **Impian** (`lib/fitur/impian/`) - Visualisasi progres tujuan berhenti merokok
4. **SOS Craving** (`lib/fitur/sos_craving/`) - Intervensi ketika nafsu merokok menyerang
5. **Diary Craving** (`lib/fitur/diary_craving/`) - Catatan harian nafsu merokok
6. **Alasan Berhenti** (`lib/fitur/alasan_berhenti/`) - Daftar alasan berhenti merokok
7. **Toksin / Toko Rokok** (`lib/fitur/toxin_pelacakan/`) - Melacak toksik dari merokok
8. **Rencana Darurat** (`lib/fitur/rencana_darurat/`) - Penanganan situasi darurat

Folder fitur lain (pendukung):
- `alasan_berhenti`, `badge`, `biodata`, `cadangan`, `dashboard`, `diary_craving`, `dummy`, `impian`, `kalender_smoke_free`, `konsumsi_rokok`, `pemulihan_kesehatan`, `pengaturan`, `rencana_darurat`, `sos_craving`, `tema`, `toxin_pelacakan`
- `lib/lainnya_screen.dart` - Layar "Lainnya" (fitur tambahan)

## Struktur Utama Fitur (Dependency)
- **Notifikasi**: `flutter_local_notifications: ^23.0.0` - Jadwalan obat/pengingat
- **Database**: `sqflite: ^2.4.5` dengan `sqflite_common_ffi_web: ^1.2.0` (web support)
- **State Management**: `riverpod: ^3.5.0` dengan `freezed: ^4.0.3`
- **Riverpod Annotation**: `riverpod_annotation: ^4.0.8`
- **Freezed Annotation**: `freezed_annotation: ^3.1.0`
- **Build Runner**: `build_runner: ^2.17.1`, `riverpod_generator: ^4.0.10`, `freezed: ^4.0.3`
- **Dependency Khusus**: `uuid: ^4.6.0`, `flutter_timezone: ^5.1.1`
- **Helper**: Beberapa helper terstruktur di `lib/shared/`

## Provider/Riverpod Key
Provider dihasilkan dari notifier ber-anotasi `@Riverpod` (deklarasi ada di `*.notifier.g.dart`). Yang aktif:
- `temaProvider` - Mengatur tema (terang/gelap/sistem)
- `biodataProvider` - State biodata pengguna
- `impianProvider` - State visualisasi impian
- `temaVisualProvider` - State tema visual impian
- `sosIntervensiProvider` - State intervensi SOS
- `diaryCravingProvider` - State catatan nafsu merokok
- `alasanBerhentiProvider` - State daftar alasan berhenti
- `konsumsiRokokProvider` - State konsumsi rokok
- `rencanaDaruratProvider` - State rencana darurat
- `dashboardProvider` - State agregat dashboard

## Enum Utama
- `TemaEnum` (`lib/fitur/tema/enum/tema_enum.dart`) - Tema aplikasi (sistem/terang/gelap)
- `TemaVisualImpian` (`lib/fitur/impian/enum/tema_visual_impian.dart`) - Tema visual impian
- `SortImpian` (`lib/fitur/impian/enum/sort_impian.dart`) - Opsi pengurutan impian
- `ModeBerhenti` (`lib/fitur/biodata/enum/mode_berhenti.dart`) - Mode berhenti (seketika/bertahap)
- `PemicuEnum` (`lib/fitur/diary_craving/enum/pemicu_enum.dart`) - Pemicu nafsu merokok
- `MoodCravingEnum` (`lib/fitur/diary_craving/enum/mood_craving_enum.dart`) - Mood nafsu merokok
- `HasilCravingEnum` (`lib/fitur/diary_craving/enum/hasil_craving_enum.dart`) - Hasil craving
- `StrategiCravingEnum` (`lib/fitur/diary_craving/enum/strategi_craving_enum.dart`) - Strategi menghadapi craving
- `JenisIntervensiSos` (`lib/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart`) - Jenis intervensi SOS
- `HasilIntervensiSos` (`lib/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart`) - Hasil intervensi SOS
- `StatusKalender` (`lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`) - Status hari kalender smoke-free
- `ToxinStatus` (`lib/fitur/toxin_pelacakan/state/toxin_pelacakan_state.dart`) - Status pemuatan data toksin

## File Konfigurasi & Penting
- `pubspec.yaml` - Dependencies dan konfigurasi
- `lib/app.dart` - Widget root aplikasi
- `lib/main.dart` - Entry point dengan inisialisasi DB & notifikasi
- `lib/shared/db/sqflite/sqflite.dart` - Konfigurasi database SQFlite
- `lib/shared/db/sqflite/sqflite_op.dart` - Operasi database
- `lib/shared/konstanta/nama_kolom.dart` - Nama kolom database (snake_case)
- `lib/shared/konstanta/nama_tabel.dart` - Nama tabel database
- `lib/shared/helper/shared_keys.dart` - Keys shared preferences
- `lib/shared/widget/empty_state_view.dart` - Widget empty state bersama

## Skills & Rules Utama yang Diaktifkan
**Sumber kebenaran:** `SKILLS_INDEX.md` (indeks discovery di root proyek) dan `.agents/skills/**/SKILL.md`. `SKILLS_INDEX.md` berisi indeks lengkap seluruh skill (path, trigger, status diperbarui) dikelompokkan per kategori (`custom`, `bawaan`). Daftar di bawah hanya ringkasan skill yang paling sering dipakai — JANGAN anggap ini daftar lengkap; selalu cek `SKILLS_INDEX.md`.
**Jumlah skill terdaftar pada `available_skills` (per 2026-11-12):** 88 total = 54 `custom` + 1 `kilo-config` (bawaan Kilo, `builtin`) + 33 `bawaan` (project-local); 87 skill project-local ini identik dengan 87 file `SKILL.md` di `.agents/skills` (54 `custom` + 33 `bawaan`) dan 87 entri di `SKILLS_INDEX.md`. Semua skill fisik berada di dalam folder `bawaan/` atau `custom/`; TIDAK ada skill yang menggantung langsung di root `.agents/skills/`. Catatan: 33 skill `bawaan` tidak memiliki field `metadata.kategori` (front matter hanya `name` + `description`), sehingga kategori pada indeks ditentukan dari **folder fisik**, bukan `metadata.kategori`.
- `memori-check` - WAJIB load pada SETIAP interaksi apa pun (AGENTS.md aturan 5 & 10). Skill ini mengatur PROSES (baca konteks → terapkan → perbarui bagian relevan), bukan daftar section; jadi TIDAK perlu diubah saat struktur `MEMORI.md` berubah.
- `penggunaan-tool-question` - Penggunaan tool `question` Kilo (kapan wajib pakai, `header` maks. 30 karakter, opsi `label` + `description`, `multiple` vs single-select, `default`, rekomendasi "(Recommended)", larangan catch-all, varian i18n)
- `pencarian-teks-ripgrep` - Penggunaan `rg` untuk pencarian teks
- `bug-runtime` - Pencegahan bug runtime
- `gaya` / `withvalues-opacity-warna` - Styling warna & opacity (`withValues(alpha:)`)
- `import-ordering` - Urutan import
- `penamaan-konvensi` - Konvensi penamaan
- `type-promotion-null-safety` - Type promotion null safety
- `validasi-form-sebelum-penyimpanan` - Validasi form
- `validasi-platform-izin` - Validasi platform & izin

## Lokasi Hasil Diskusi (PENTING)
- Folder hasil diskusi berada di **`hasil_diskusi/`** di **root proyek** (BUKAN di dalam `prd/`).
- File yang ada saat ini: `diskusi_1.md`, `diskusi_2.md`, `diskusi_3.md` (topik pemindahan folder hasil diskusi ke root), `diskusi_4.md` (topik pembuatan aturan format hasil diskusi), `diskusi_5.md` (topik pemisahan format hasil diskusi dari format PRD), `diskusi_6.md` (topik pembuatan skill penggunaan tool `question`, **Final** — sudah diimplementasikan).
- Nomor tertinggi dari file yang ada: `diskusi_6.md`; diskusi berikutnya = `diskusi_7.md`.
- Aturan penomoran: nomor tertinggi + 1, gap tidak diisi (lihat `.kilo/commands/mode/mode_diskusi.md` bagian 3). Jika folder kosong → buat `diskusi_1.md`.
- Aturan format berkas hasil diskusi: `.agents/rules/global/format_hasil_diskusi.md` (lokasi, penamaan, penomoran, struktur berorientasi keputusan, status, pencatatan, larangan); sudah didaftarkan pada `instructions` di `~/.config/kilo/kilo.jsonc`.
- Format hasil diskusi **berbeda** dari PRD: bukan dokumen PRD, tidak memakai struktur `format_PRD.md`. Bagian wajib: `## Status`, `## Latar Belakang`, `## Poin Diskusi`, `## Keputusan`, `## Rekomendasi`, `## Tindak Lanjut`, `## File Terdampak`, `## Pertanyaan Terbuka`, `## Riwayat Perubahan`.
- `diskusi_1.md`–`diskusi_4.md` adalah arsip berstruktur PRD dan **tidak** dimigrasi ke format baru.
- `.kilo/commands/mode/mode_diskusi.md` (bagian 3) sudah memakai path `hasil_diskusi/` (root).
- `.kilo/commands/kerjakan_hasil_diskusi.md` (baris 2 & 5) memakai `hasil_diskusi/diskusi_N.md`.
- Mirror `gpt/mode/mode_diskusi.md` dan `gpt/kerjakan_hasil_diskusi.md` memakai path `hasil_diskusi/` (kini kembali benar setelah pemindahan); isi bagian lain pada mirror `gpt/` belum disinkronkan dengan versi `.kilo/commands/`.
- Folder `prd/` dipertahankan dan kini hanya berisi `prd_konsumsi_pemicu_analisis_puncak.md`.

## Riwayat Diskusi
Format: `No | Tanggal | Topik | Status PRD | Tindak Lanjut`

| No | Tanggal | Topik | Status PRD | Tindak Lanjut |
|----|---------|-------|------------|---------------|
| 1 | 2026-11-12 | Penekanan `AGENTS.md` agar agen wajib membaca & mematuhi file/aturan (poin 5, rules global spesifik, permission `kilo.jsonc`, skill relevan sebelum kerja) | Final (file PRD dihapus setelah implementasi) | Sudah diimplementasikan: `AGENTS.md` diperkuat (wording tegas, cakupan poin 5 + rules global spesifik `aturan_skill.md`/`format_PRD.md`/`format_task.md`, baca `~/.config/kilo/kilo.jsonc` permission sebelum bash/tindakan, cari & load skill relevan sebelum kerja; struktur poin dipertahankan) |
| 2 | 2026-11-12 | Risiko dan rekomendasi koordinasi pengeditan `MEMORI.md` secara bersamaan oleh pengguna, Kilo, dan model AI lain | Draft | Belum ditindaklanjuti (dokumentasi hasil diskusi di `hasil_diskusi/diskusi_1.md`) |
| 3 | 2026-11-12 | Pemindahan folder hasil diskusi dari `prd/hasil_diskusi/` ke root `hasil_diskusi/` | Final | Selesai diimplementasikan (folder dipindah, referensi path diperbarui di command aktif + MEMORI; mirror `gpt/` sudah sesuai) |
| 4 | 2026-11-12 | Pembuatan aturan format berkas hasil diskusi (`.agents/rules/global/format_hasil_diskusi.md`) | Final | Selesai diimplementasikan (aturan dibuat, `mode_diskusi.md` §3–§4 merujuk ke aturan, didaftarkan di `instructions` `kilo.jsonc`) |
| 5 | 2026-11-12 | Pemisahan format hasil diskusi dari format PRD (format berorientasi keputusan) | Final | Selesai diimplementasikan (aturan ditulis ulang, `mode_diskusi.md` §4 tidak lagi mensyaratkan PRD, `diskusi_1`–`4` tetap arsip) |
| 7 | (lihat file) | Pembuatan skill penggunaan `ripgrep` | Final (file diskusi sudah dihapus) | Selesai diimplementasikan (skill `pencarian-teks-ripgrep`) |
| 8 | 2026-11-12 | Celah validasi pada `.kilo/commands/perbarui_skills_index.md` (skill tanpa kategori / di luar `bawaan`/`custom` tidak dilaporkan) | Final (file dihapus atas permintaan pengguna) | Perintah direvisi: kategori dari folder fisik, klasifikasi anomali (serius→STOP, ringan→peringatan, fatal→STOP), laporan wajib |
| 6 | 2026-11-12 | Pembuatan skill penggunaan tool `question` | Final | Selesai diimplementasikan (skill `.agents/skills/custom/penggunaan-tool-question/SKILL.md` dibuat, didaftarkan ke `SKILLS_INDEX.md` & `MEMORI.md`) |

Catatan: `hasil_diskusi/` (root) saat ini berisi `diskusi_1.md` sampai `diskusi_6.md`. Folder ini sebelumnya berada di `prd/hasil_diskusi/` dan dipindahkan ke root pada 2026-11-12. Riwayat lama: `diskusi_1.md` (topik `AGENTS.md`) dan `diskusi_5.md` pernah dibuat lalu dihapus; `diskusi_4.md` dan lainnya tidak tersedia sebagai file saat ini. Nomor diskusi berikutnya = tertinggi yang ada + 1.

## Riwayat Perubahan (Changelog)
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-12 | Implementasi `hasil_diskusi/diskusi_6.md` (status `Draft` → `Final`): dibuat skill `.agents/skills/custom/penggunaan-tool-question/SKILL.md` (panduan tool `question`: `header` maks. 30 karakter, opsi `label` + `description`, `multiple` vs single-select, `default`, rekomendasi "(Recommended)", larangan catch-all, varian i18n; sumber commit `208e3ec`), didaftarkan ke `SKILLS_INDEX.md` sebagai entri `custom` ke-54, dan `MEMORI.md` diperbarui (jumlah skill 86→87 file / 87→88 `available_skills`, lokasi & riwayat diskusi). |
| 2026-11-12 | Penyelarasan `AGENTS.md` dengan pemisahan format: poin 5 kini mencantumkan `format_hasil_diskusi.md` (dan `format_PRD.md` dibatasi hanya untuk PRD), poin 6 serta poin 8 ikut menyesuaikan. `MEMORI.md` bagian `Aturan yang Harus Dipelihara` menambahkan butir format hasil diskusi. |
| 2026-11-12 | Pemisahan format hasil diskusi dari PRD: `.agents/rules/global/format_hasil_diskusi.md` ditulis ulang menjadi format berorientasi keputusan (9 bagian wajib: `## Status`, `## Latar Belakang`, `## Poin Diskusi`, `## Keputusan`, `## Rekomendasi`, `## Tindak Lanjut`, `## File Terdampak`, `## Pertanyaan Terbuka`, `## Riwayat Perubahan`) dan tidak lagi merujuk struktur `format_PRD.md`; `.kilo/commands/mode/mode_diskusi.md` §1 & §4 disesuaikan (hasil diskusi bukan PRD); `.kilo/commands/kerjakan_hasil_diskusi.md` butir 4 ditambahi rujukan aturan format. `diskusi_1`–`diskusi_4` tetap sebagai arsip berstruktur PRD. |
| 2026-11-12 | Pembuatan aturan format berkas hasil diskusi: dibuat `.agents/rules/global/format_hasil_diskusi.md` (tujuan, cakupan, hubungan dengan `format_PRD.md`, aturan lokasi/penamaan/penomoran, struktur isi, status, bagian belum dibahas, pencatatan `MEMORI.md`, larangan, kerangka contoh, checklist). `.kilo/commands/mode/mode_diskusi.md` bagian 3–4 diperbarui agar merujuk ke aturan baru (penomoran butir disesuaikan), dan berkas aturan didaftarkan pada `instructions` di `~/.config/kilo/kilo.jsonc`. `docs/struktur_rules.md` sudah usang dan sengaja tidak diubah pada diskusi ini. |
| 2026-11-12 | Pemindahan folder hasil diskusi dari `prd/hasil_diskusi/` ke root **`hasil_diskusi/`** (mkdir + `git mv` untuk `diskusi_1.md` yang tracked, `mv` untuk `diskusi_2.md` yang untracked, lalu `rmdir prd/hasil_diskusi`). Folder `prd/` dipertahankan dan hanya berisi `prd_konsumsi_pemicu_analisis_puncak.md`. Referensi path diperbarui di `.kilo/commands/mode/mode_diskusi.md`, `.kilo/commands/kerjakan_hasil_diskusi.md`, dan `MEMORI.md`; mirror `gpt/mode/mode_diskusi.md` + `gpt/kerjakan_hasil_diskusi.md` sudah memakai path root sehingga tidak perlu diubah. |
| 2026-11-12 | Koreksi angka jumlah skill di `MEMORI.md` (pertanyaan pengguna "ada berapa skill terdaftar"). Verifikasi via `find .agents/skills -name SKILL.md` = 86 file (53 `custom` + 33 `bawaan`) dan `SKILLS_INDEX.md` = 86 entri (53 + 33); `available_skills` = 87 entri (86 project-local + `kilo-config` bawaan Kilo). Angka usang "90 total / 36 `bawaan`" di `Status Proyek`, `Skills & Rules Utama yang Diaktifkan`, dan `Catatan untuk Model Selanjutnya` diganti menjadi 87 (53 + 1 + 33). |
| 2026-11-12 | Penghapusan `prd/hasil_diskusi/diskusi_1.md` atas permintaan pengguna (implementasi `perbarui_skills_index.md` sudah selesai). `MEMORI.md` diperbarui: lokasi hasil diskusi (kembali kosong, berikutnya `diskusi_1.md`), riwayat diskusi (entri no. 8 ditandai file dihapus), catatan ketersediaan file. |
| 2026-11-12 | Mode Diskusi: dibuat `prd/hasil_diskusi/diskusi_1.md` (Draft) dan direvisi `.kilo/commands/perbarui_skills_index.md` untuk menutup celah validasi — kategori ditentukan dari folder fisik (`bawaan`/`custom`), ditambah klasifikasi anomali (serius: skill di luar `bawaan`/`custom` + konflik kategori → STOP & tidak menulis indeks; ringan: `metadata.kategori` kosong → hanya peringatan; fatal: folder tak terbaca / tidak ada `SKILL.md`) dan kewajiban laporan anomali. Kebijakan "stop hanya untuk anomali serius" dipilih pengguna via `question`. `SKILLS_INDEX.md` tidak diubah isinya (sudah 33 bawaan + 53 custom). `MEMORI.md` dikoreksi (catatan usang "folder `bawaan` kosong" → benar: 33 bawaan + 53 custom di disk, semua terbungkus folder) dan diperbarui (lokasi & riwayat diskusi). |
| 2026-11-12 | Verifikasi jumlah skill terdaftar pada `available_skills` (90 skill = 53 `custom` + 1 `kilo-config` bawaan Kilo + 36 `bawaan` project-local; total 90 file `SKILL.md` di `.agents/skills` terverifikasi via `grep`). `MEMORI.md` diperbarui (bagian `Status Proyek` dan `Skills & Rules Utama yang Diaktifkan`). |
| 2026-11-12 | Implementasi `prd/hasil_diskusi/diskusi_1.md` (penekanan `AGENTS.md`): `AGENTS.md` diperkuat dengan wording tegas (WAJIB/DILARANG) sambil mempertahankan struktur poin — menegaskan cari & load skill relevan sebelum kerja, poin 5 sebagai konteks inti wajib (termasuk urutan/prioritas), rules global spesifik `aturan_skill.md`/`format_PRD.md`/`format_task.md` saat relevan, dan kewajiban baca `~/.config/kilo/kilo.jsonc` permission sebelum bash/tindakan (izin `deny` mutlak). PRD berstatus Sedang → Sudah Diimplementasikan lalu dihapus; tidak ada section terkait di `refrensi_apk.md` (dilewati). `MEMORI.md` diperbarui (lokasi/riwayat diskusi, status diskusi 1). |
| 2026-11-12 | Pembuatan `prd/hasil_diskusi/diskusi_1.md` (Mode Diskusi, PRD usulan saja, Draft): topik penekanan `AGENTS.md` agar agen wajib membaca & mematuhi poin 5, rules global spesifik (`aturan_skill.md`, `format_PRD.md`, `format_task.md` saat relevan), permission `~/.config/kilo/kilo.jsonc` sebelum bash/tindakan, dan skill relevan sebelum kerja; gaya perkuat wording dengan struktur dipertahankan; `AGENTS.md` belum diubah. `MEMORI.md` diperbarui (lokasi & riwayat diskusi). |
| 2026-11-12 | Penghapusan `prd/hasil_diskusi/diskusi_5.md` atas permintaan pengguna (tindak lanjut diskusi sudah terimplementasi pada aturan). `MEMORI.md` diperbarui: lokasi hasil diskusi (tertinggi kembali `diskusi_4.md`, berikutnya `diskusi_5.md`), riwayat diskusi (entri no. 5 dihapus, catatan ketersediaan file diperbarui). |
| 2026-11-12 | Penyelarasan aturan PRD: `.kilo/commands/mode/mode_diskusi.md` §4.2 tidak lagi mensyaratkan "Bagian 1 sampai Bagian 21" (sisa templat lama yang sudah disederhanakan lewat commit `4ce508d`, `06634a2`, `aedb325`, `30ff01b` menjadi 6 bagian) dan kini merujuk ke `format_PRD.md` sebagai sumber kebenaran; §4.6 kini hanya menyebut bagian yang benar-benar ada (`Daftar Fitur`, `Alur Pengguna`, `Steps`, `File-File Terdampak`); penomoran butir §4 dirapikan menjadi 1–7; hasil diskusi semula didokumentasikan pada `prd/hasil_diskusi/diskusi_5.md` (kini dihapus). |
| 2026-11-12 | Pembaruan skill `memori-check` ke v1.3.0: diubah dari daftar section yang di-hardcode menjadi panduan proses generik (baca konteks → terapkan → perbarui bagian relevan) agar tidak wajib diubah setiap kali struktur `MEMORI.md` berubah; `Sumber Evaluasi` diperbaiki (commit `1823940`, `5e2a55d`, `b7f2b05`; path `prd/hasil_diskusi/`) |
| 2026-11-12 | Pemindahan semua skill bawaan (33 skill) dari root `.agents/skills/` ke `.agents/skills/bawaan/`,Folder `custom` (53 skill) tidak dipindah. `SKILLS_INDEX.md` diperbarui path bawaan ke `.agents/skills/bawaan/<nama>/SKILL.md`. Tidak ada file `SKILL.md` yang diubah isinya. |
| 2026-11-12 | Mode Diskusi: dibuat `prd/hasil_diskusi/diskusi_1.md` (Draft) dokumentasi hasil diskusi tentang risiko dan rekomendasi koordinasi saat `MEMORI.md` diubah secara bersamaan oleh banyak pihak. `MEMORI.md` diperbarui (lokasi hasil diskusi sekarang berisi `diskusi_1.md`, berikutnya `diskusi_2.md`; riwayat diskusi ditambahi entri no. 2). |
| 2026-11-12 | Mode Diskusi: dibuat `hasil_diskusi/diskusi_6.md` (Draft) dokumentasi hasil diskusi tentang pembuatan skill penggunaan tool `question`. `MEMORI.md` diperbarui (lokasi & riwayat diskusi, nomor tertinggi diskusi_6.md). |

## Catatan Teknis Penting
1. **Database FFI Web**: Konfigurasi `sqfliteCommonFfiWeb` di `main.dart`
2. **Notifikasi**: Inisialisasi di `main.dart` dan `app.dart`; gunakan `unawaited` dengan catchError
3. **Tema**: Menggunakan `ThemeData.from(colorScheme: ColorScheme.fromSeed(...))` dengan `withValues(alpha:)` untuk opacity
4. **Localization**: `supportedLocales: const [Locale('id', 'ID')]` dengan localizationsDelegates lengkap
5. **Navigator Key**: `NotifikasiService.navigatorKey` digunakan untuk navigasi dari notifikasi
6. **EasyLoading**: `builder: EasyLoading.init()` di MaterialApp
7. **Eksport Modul**: `share_global_saya` sebagai path dependency lokal
8. **ripgrep Kilo**: `/home/thefarmercompanyba/.cache/kilo/bin/rg` sempat hilang (spawn `ChildProcess.spawn .../bin/rg` gagal). Diperbaiki dengan `install_rg` (`sudo apt-get install -y ripgrep`, v14.1.0) lalu menyalin `/usr/bin/rg` ke `~/.cache/kilo/bin/rg`. Lingkungan Cloud Shell bersifat ephemeral: instalasi apt dan isi `~/.cache` dapat hilang setelah sesi berakhir — bila error `rg` muncul lagi, pasang ulang dan salin ulang.
9. **Provider Codegen**: Deklarasi `final xxxProvider = XxxNotifierProvider._();` ada di file `*.notifier.g.dart` (generated). JANGAN edit file generated; edit file `*.notifier.dart` lalu jalankan `build_runner`.

## Aturan yang Harus Dipelihara
- Selalu gunakan kebab-case untuk nama folder skill
- Berkas hasil diskusi memakai format berorientasi keputusan (`format_hasil_diskusi.md`), BUKAN struktur PRD
- Bahasa Indonesia dalam dokumentasi dan komentar
- Gunakan `withValues(alpha:)` untuk opacity, DILARANG `withOpacity()`
- Import diurutkan alfabetis berdasarkan path package lengkap
- Gunakan `Form + GlobalKey + validate()` untuk validasi form
- Type promotion: salin field nullable ke variabel lokal sebelum null-check
- Hardcode warna hanya untuk status semantic (hijau sukses, merah error, kuning warning)
- `MaterialApp` harus memiliki `home`, `routes`, `onGenerateRoute`, atau `builder` non-null
- AGENTS.md aturan 5: `MEMORI.md` wajib dibaca sebelum SETIAP interaksi apa pun (task, pertanyaan, diskusi, review, penelusuran)
- AGENTS.md aturan 10: perbarui isi `MEMORI.md` setiap setelah task/interaksi yang mengubah proyek (lihat skill `memori-check`)
- AGENTS.md aturan 11: wajib baca konfigurasi global Kilo `~/.config/kilo/kilo.jsonc` (bagian `permission`) sebelum menjalankan `bash`/tindakan lain; izin `deny` bersifat mutlak dan dilarang dilewati; saat ini `deny` pada `bash`: `cat *`, `sed *`, `python3 *`; pada `read`: `*.env`, `*.env.*`; `kilo.jsonc` adalah sumber kebenaran dan bisa berubah, baca ulang setiap interaksi

## Referensi Commit Terkait
- Commit terkait skill dan fitur dapat ditemukan melalui `git log` di repository ini
- Setiap perubahan skill/`SKILL.md` harus mengikuti `.agents/rules/global/aturan_skill.md`

## Catatan untuk Model Selanjutnya
Setiap kali model (AI) berinteraksi dengan proyek ini, seharusnya:
1. Membaca file ini untuk konteks terbaru
2. Memperbarui bagian "Status Proyek" & "Riwayat Perubahan" bila ada perubahan versi/state
3. Memastikan kepatuhan terhadap rules di AGENTS.md
4. Menggunakan skills yang relevan (cari via `SKILLS_INDEX.md`, jangan hanya pakai daftar ringkas di atas)
5. Menyimpan keputusan penting dan state baru ke file ini
6. Jika ditanya jumlah skill terdaftar, jawab 88 (54 `custom` + 1 `kilo-config` bawaan Kilo + 33 `bawaan` project-local; 87 file `SKILL.md` + `SKILLS_INDEX.md` 87 entri) dan verifikasi ulang via `available_skills`/`SKILLS_INDEX.md` bila ada perubahan.

---
*File ini dibuat untuk memastikan konsistensi dan mempertahankan konteks proyek berhenti_merokok di masa mendatang.*