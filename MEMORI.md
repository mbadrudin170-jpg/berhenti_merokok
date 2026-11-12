# MEMORI Proyek: berhenti_merokok

## Status Proyek
- **Nama**: berhenti_merokok
- **Deskripsi**: Aplikasi Flutter untuk membantu pengguna berhenti merokok
- **Versi**: 1.0.0+1
- **Platform**: Flutter (Android, iOS, Web, Desktop)
- **Status Implementasi**: Sedang Diimplementasikan
- **Terakhir Diperbarui**: 2026-11-12 (implementasi PRD `diskusi_1.md`: `AGENTS.md` diperkuat, PRD dihapus)

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
**Sumber kebenaran:** `SKILLS_INDEX.md` (indeks discovery) dan `.agents/skills/**/SKILL.md`. Daftar di bawah hanya ringkasan skill yang paling sering dipakai — JANGAN anggap ini daftar lengkap; selalu cek `SKILLS_INDEX.md`.
- `memori-check` - WAJIB load pada SETIAP interaksi apa pun (AGENTS.md aturan 5 & 10). Skill ini mengatur PROSES (baca konteks → terapkan → perbarui bagian relevan), bukan daftar section; jadi TIDAK perlu diubah saat struktur `MEMORI.md` berubah.
- `pencarian-teks-ripgrep` - Penggunaan `rg` untuk pencarian teks
- `bug-runtime` - Pencegahan bug runtime
- `gaya` / `withvalues-opacity-warna` - Styling warna & opacity (`withValues(alpha:)`)
- `import-ordering` - Urutan import
- `penamaan-konvensi` - Konvensi penamaan
- `type-promotion-null-safety` - Type promotion null safety
- `validasi-form-sebelum-penyimpanan` - Validasi form
- `validasi-platform-izin` - Validasi platform & izin

## Lokasi Hasil Diskusi (PENTING)
- Folder hasil diskusi berada di **`prd/hasil_diskusi/`** (BUKAN di root).
- File yang ada saat ini: **(kosong)** — tidak ada file `diskusi_N.md`.
- Nomor tertinggi dari file yang ada: **tidak ada**; diskusi berikutnya = `diskusi_1.md`.
- Aturan penomoran: nomor tertinggi + 1, gap tidak diisi (lihat `.kilo/commands/mode/mode_diskusi.md` bagian 3). Jika folder kosong → buat `diskusi_1.md`.
- `.kilo/commands/mode/mode_diskusi.md` (bagian 3, baris 16–22) sudah diperbaiki: path `hasil_diskusi/` → `prd/hasil_diskusi/`.
- `.kilo/commands/mode/mode_diskusi.md` (bagian 4) sudah diselaraskan: dulu mensyaratkan "Bagian 1 sampai Bagian 21" (sisa templat lama), kini merujuk ke `format_PRD.md` sebagai satu-satunya sumber kebenaran tanpa hardcode jumlah/judul bagian.
- `.kilo/commands/kerjakan_hasil_diskusi.md` (baris 2 & 5) juga diperbarui ke `prd/hasil_diskusi/diskusi_N.md`.

## Riwayat Diskusi
Format: `No | Tanggal | Topik | Status PRD | Tindak Lanjut`

| No | Tanggal | Topik | Status PRD | Tindak Lanjut |
|----|---------|-------|------------|---------------|
| 1 | 2026-11-12 | Penekanan `AGENTS.md` agar agen wajib membaca & mematuhi file/aturan (poin 5, rules global spesifik, permission `kilo.jsonc`, skill relevan sebelum kerja) | Final (file PRD dihapus setelah implementasi) | Sudah diimplementasikan: `AGENTS.md` diperkuat (wording tegas, cakupan poin 5 + rules global spesifik `aturan_skill.md`/`format_PRD.md`/`format_task.md`, baca `~/.config/kilo/kilo.jsonc` permission sebelum bash/tindakan, cari & load skill relevan sebelum kerja; struktur poin dipertahankan) |
| 4 | (lihat file) | Lihat isi `prd/hasil_diskusi/diskusi_4.md` | Final (file diskusi tidak tersedia di folder saat ini) | Belum ditindaklanjuti (berdasarkan catatan sebelumnya) |
| 7 | (lihat file) | Pembuatan skill penggunaan `ripgrep` | Final (file diskusi sudah dihapus) | Selesai diimplementasikan (skill `pencarian-teks-ripgrep`) |

Catatan: folder `prd/hasil_diskusi/` saat ini kosong (tidak ada file `diskusi_N.md`). `diskusi_1.md` dibuat, diimplementasikan, dan dihapus pada 2026-11-12; `diskusi_4.md` dan lainnya tidak tersedia sebagai file saat ini. Nomor diskusi berikutnya = tertinggi yang ada + 1; karena tidak ada file, berikutnya `diskusi_1.md`.

## Riwayat Perubahan (Changelog)
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-12 | Implementasi `prd/hasil_diskusi/diskusi_1.md` (penekanan `AGENTS.md`): `AGENTS.md` diperkuat dengan wording tegas (WAJIB/DILARANG) sambil mempertahankan struktur poin — menegaskan cari & load skill relevan sebelum kerja, poin 5 sebagai konteks inti wajib (termasuk urutan/prioritas), rules global spesifik `aturan_skill.md`/`format_PRD.md`/`format_task.md` saat relevan, dan kewajiban baca `~/.config/kilo/kilo.jsonc` permission sebelum bash/tindakan (izin `deny` mutlak). PRD berstatus Sedang → Sudah Diimplementasikan lalu dihapus; tidak ada section terkait di `refrensi_apk.md` (dilewati). `MEMORI.md` diperbarui (lokasi/riwayat diskusi, status diskusi 1). |
| 2026-11-12 | Pembuatan `prd/hasil_diskusi/diskusi_1.md` (Mode Diskusi, PRD usulan saja, Draft): topik penekanan `AGENTS.md` agar agen wajib membaca & mematuhi poin 5, rules global spesifik (`aturan_skill.md`, `format_PRD.md`, `format_task.md` saat relevan), permission `~/.config/kilo/kilo.jsonc` sebelum bash/tindakan, dan skill relevan sebelum kerja; gaya perkuat wording dengan struktur dipertahankan; `AGENTS.md` belum diubah. `MEMORI.md` diperbarui (lokasi & riwayat diskusi). |
| 2026-11-12 | Penghapusan `prd/hasil_diskusi/diskusi_5.md` atas permintaan pengguna (tindak lanjut diskusi sudah terimplementasi pada aturan). `MEMORI.md` diperbarui: lokasi hasil diskusi (tertinggi kembali `diskusi_4.md`, berikutnya `diskusi_5.md`), riwayat diskusi (entri no. 5 dihapus, catatan ketersediaan file diperbarui). |
| 2026-11-12 | Penyelarasan aturan PRD: `.kilo/commands/mode/mode_diskusi.md` §4.2 tidak lagi mensyaratkan "Bagian 1 sampai Bagian 21" (sisa templat lama yang sudah disederhanakan lewat commit `4ce508d`, `06634a2`, `aedb325`, `30ff01b` menjadi 6 bagian) dan kini merujuk ke `format_PRD.md` sebagai sumber kebenaran; §4.6 kini hanya menyebut bagian yang benar-benar ada (`Daftar Fitur`, `Alur Pengguna`, `Steps`, `File-File Terdampak`); penomoran butir §4 dirapikan menjadi 1–7; hasil diskusi semula didokumentasikan pada `prd/hasil_diskusi/diskusi_5.md` (kini dihapus). |
| 2026-11-12 | Pembaruan skill `memori-check` ke v1.3.0: diubah dari daftar section yang di-hardcode menjadi panduan proses generik (baca konteks → terapkan → perbarui bagian relevan) agar tidak wajib diubah setiap kali struktur `MEMORI.md` berubah; `Sumber Evaluasi` diperbaiki (commit `1823940`, `5e2a55d`, `b7f2b05`; path `prd/hasil_diskusi/`) |

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

---
*File ini dibuat untuk memastikan konsistensi dan mempertahankan konteks proyek berhenti_merokok di masa mendatang.*