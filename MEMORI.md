# MEMORI Proyek: berhenti_merokok

## Status Proyek
- **Nama**: berhenti_merokok
- **Deskripsi**: Aplikasi Flutter untuk membantu pengguna berhenti merokok
- **Versi**: 1.0.0+1
- **Platform**: Flutter (Android, iOS, Web, Desktop)
- **SDB**: Status pengembangan - Sedang Diimplementasikan

## Struktur Utama Layar (Screen)
1. **Dashboard** (`lib/fitur/dashboard/`) - Layar utama dengan navigasi tab
2. **Biodata** (`lib/fitur/biodata/`) - Data pribadi pengguna (history merokok, target)
3. **Impian** (`lib/fitur/impian/`) - Visualisasi progres tujuan berhenti merokok
4. **SOS Craving** (`lib/fitur/sos_craving/`) - Intervensi ketika menimpa nafsu merokok
5. **Diary Craving** (`lib/fitur/diary_craving/`) - Catatan harian nafsu merokok
6. **Alasan Berhenti** (`lib/fitur/alasan_berhenti/`) - Daftar alasan berhenti merokok
7. **Toko Rokok** (`lib/fitur/toxin_pelacakan/`) - Melacak toksik dari merokok
8. **Rencana Darurat** (`lib/fitur/rencana_darurat/`) - Penanganan situasi darurat
9. **Lainnya** (`lib/lainnya_screen.dart`) - Fitur tambahan

## Struktur Utama Fitur
- **Notifikasi**: `flutter_local_notifications: ^23.0.0` - Jadwalan obat/pengingat
- **Database**: `sqflite: ^2.4.5` dengan `sqflite_common_ffi_web: ^1.2.0` (web support)
- **State Management**: `riverpod: ^3.5.0` dengan `freezed: ^4.0.3`
- **Build Runner**: `build_runner: ^2.17.1`, `riverpod_generator: ^4.0.10`, `freezed: ^4.0.3`
- **Helper**: Beberapa helper terstruktur di `lib/shared/`
- **Dependency Khusus**: `uuid: ^4.6.0`, `flutter_timezone: ^5.1.1`, `path_provider: ^2.1.6`

## Provider/Riverpod Key
- `temaProvider` - Mengatur tema (terang/gelap/sistem)
- `biodataProvider` - State biodata pengguna
- `impianProvider` - State visualisasi impian
- `sosIntervensiProvider` - State intervensi SOS
- `diaryCravingProvider` - State catatan nafsu merokok

## Enum Utama
- `tema_visual_impian` - Enum tema visual impian
- `sort_impian` - Enum sort impian
- `mode_berhenti` - Enum mode berhentarobok
- `pemicu_enum` - Pemicu nafsu merokok
- `mood_craving_enum` - Mood nafsu merokok
- `hasil_craving_enum` - Hasil craving
- `strategi_craving_enum` - Strategi dealing dengan craving
- `hasil_intervensi_sos_enum` - Hasil intervensi SOS
- `jenis_intervensi_sos_enum` - Jenis intervensi SOS

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
Dikutip dari `.agents/skills/`:
- `memori-check` v1.2.0 - WAJIB load pada SETIAP interaksi apa pun di proyek ini (AGENTS.md aturan 5 & 10; bukan hanya task, juga pertanyaan/diskusi/review/penelusuran)
- `pencarian-teks-ripgrep` - Penggunaan `rg` sebagai alat pencarian teks (preferensi atas `grep -rn`, cek `which rg`, pembagian tugas dengan `glob`/`ls`, diagnosa/pemulihan binary Kilo `~/.cache/kilo/bin/rg` via `install_rg` + salin `/usr/bin/rg`)
- `bug-runtime` - Pencegahan bug runtime
- `gaya` - Styling warna dan tema
- `import-ordering` - Urutan import
- `penamaan-konvensi` - Konvensi penamaan
- `type-promotion-null-safety` - Type promotion null safety
- `validasi-form-sebelum-penyimpanan` - Validasi form
- `validasi-platform-izin` - Validasi platform & izin
- `withvalues-opacity-warna` - Aturan opacity dengan withValues(alpha:)

## Diskusi Terakhir (diskusi_7.md → sudah diimplementasikan, file PRD dihapus)
PRD diskusi_7 (membuat skill penggunaan `ripgrep`) diimplementasikan: skill `.agents/skills/custom/pencarian-teks-ripgrep/SKILL.md` dibuat dari perintah eksplisit pengguna (tidak ada commit berkaitan yang memuat panduan `rg` lengkap; pengguna memilih sumber isi dari perintah eksplisit pengguna saja). `SKILLS_INDEX.md` ditambahkan entri 53 `custom/pencarian-teks-ripgrep`. `refrensi_apk.md` tidak memiliki section yang merujuk PRD tersebut sehingga langkah penghapusan dilewati.

## Catatan Teknis Penting
1. **Database FFI Web**: Konfigurasi `sqfliteCommonFfiWeb` di `main.dart` baris 15-17
2. **Notifikasi**: Inisialisasi di `main.dart` dan `app.dart`; gunakan `unawaited` dengan catchError
3. **Tema**: Menggunakan `ThemeData.from(colorScheme: ColorScheme.fromSeed(...))` dengan `withValues(alpha:)` untuk opacity
4. **Localization**: `supportedLocales: const [Locale('id', 'ID')]` dengan localizationsDelegates lengkap
5. **Navigator Key**: `NotifikasiService.navigatorKey` digunakan untuk navigasi dari notifikasi
6. **EasyLoading**: `builder: EasyLoading.init()` di MaterialApp
7. **Eksport Modul**: `share_global_saya` sebagai path dependency lokal
8. **ripgrep Kilo**: `/home/thefarmercompanyba/.cache/kilo/bin/rg` sempat hilang (spawn `ChildProcess.spawn .../bin/rg` gagal). Diperbaiki dengan `install_rg` (`sudo apt-get install -y ripgrep`, v14.1.0) lalu menyalin `/usr/bin/rg` ke `~/.cache/kilo/bin/rg`. Lingkungan Cloud Shell bersifat ephemeral: instalasi apt dan isi `~/.cache` dapat hilang setelah sesi berakhir — bila error `rg` muncul lagi, pasang ulang dan salin ulang.

## Aturan yang Harus Dipelihara
- Selalu gunakan kebab-case untuk nama folder skill
- Bahasa Indonesia dalam dokumentasi dan komentar
- Gunakan `withValues(alpha:)` untuk opacity, DILARANG `withOpacity()`
- Import diurutkan alfabetis berdasarkan path package lengkap
- Gunakan `Form + GlobalKey + validate()` untuk validasi form
- Type promotion: salin field nullable ke variabel lokal sebelum null-check
- Hardcode warna hanya untuk status semantic (hijau sukses, merah error, kuning warning)
- `MaterialApp` harus memiliki `home`, `routes`, `onGenerateRoute`, atau `builder` non-null
- AGENTS.md aturan 5: `MEMORI.md` tercantum sebagai file wajib baca sebelum SETIAP interaksi apa pun di proyek ini (task, pertanyaan, diskusi, review, penelusuran)
- AGENTS.md aturan 10: `MEMORI.md` wajib dibaca sebelum setiap interaksi; selalu perbarui isinya setelah task atau interaksi yang mengubah proyek (lihat skill `memori-check` di `.agents/skills/custom/memori-check/SKILL.md`)
- AGENTS.md aturan 11: wajib baca konfigurasi global Kilo `~/.config/kilo/kilo.jsonc` (bagian `permission`) sebelum menjalankan perintah `bash` atau tindakan lain; izin `deny` bersifat mutlak dan dilarang dilewati/diakali; saat ini `deny` pada `bash`: `cat *`, `sed *`, `python3 *`; pada `read`: `*.env`, `*.env.*`; file `kilo.jsonc` adalah sumber kebenaran dan bisa berubah, jadi baca ulang setiap interaksi

## Referensi Commit Terkait
- Commit terkait skill dan fitur dapat ditemukan melalui `git log` di repository ini
- Setiap perubahan skills/SKILL.md harus mengikuti aturan di `.agents/rules/global/aturan_skill.md`

## Catatan untuk Model Selanjutnya
Setiap kali model (AI) berinteraksi dengan proyek ini, seharusnya:
1. Memeriksa file ini untuk konteks terbaru
2. Memperbarui bagian "Status Proyek" jika ada perubahan versi/state
3. Memastikan kepatuhan terhadap rules yang tertera di AGENTS.md
4. Menggunakan skills yang relevan untuk task yang diberikan
5. Menyimpan keputusan penting dan state baru ke file ini

---
*File ini dibuat untuk memastikan konsistensi dan mempertahankan konteks proyek berhenti_merokok di masa mendatang.*