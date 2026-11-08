# PRD: Optimasi Biodata (Profil Merokok) — Alasan Berhenti & Target Smoke-Free

## 1. Identitas Fitur
- **Nama fitur:** Optimasi Biodata (Profil Merokok: Alasan Berhenti & Target Smoke-Free)
- **Kategori:** Pembaruan / Penyempurnaan
- **Status PRD:** Draft — Dalam Diskusi
- **Tanggal pembaruan:** 2026-11-08

## 2. Sumber Referensi
- **Nama aplikasi referensi:** Smoke Free (Portable Pixels); Quit Tracker (despDev); Kick It (UC San Diego)
- **URL aplikasi:**
  - https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
  - https://play.google.com/store/apps/details?id=com.despdev.quitsmoking
  - https://play.google.com/store/apps/details?id=com.kickitca
- **Path file referensi:** `refrensi_apk.md`
- **Nomor baris awal dan akhir (entri terpilih, isi aktual saat dianalisis):** 182–195
- **Judul entri:** 3. Biodata (Profil Merokok)
- **Screenshot/sumber visual:** Deskripsi resmi Google Play Store (disebut di entri). Halaman Play Store **belum** diambil/dianalisis mendalam pada sesi ini (keterbatasan akses/konten dinamis mungkin berlaku). Tidak ada APK yang diunduh atau dijalankan.

### Fakta teramati dari sumber internal
- `refrensi_apk.md` (L182–195): peluang optimasi = field opsional **alasan berhenti** dan **target smoke-free (hari)** pada biodata; saran tampilkan di dashboard sebagai motivasi; relevan, dampak terbatas.

### Interpretasi
- “Field pada biodata” dapat berarti data profil tunggal (1 nilai per pengguna) yang disimpan bersama biodata, **atau** dapat ditafsirkan sebagai data motivasi yang mudah diakses dari profil. Interpretasi ini **belum diputuskan** karena repositori sudah memiliki fitur daftar alasan berhenti terpisah (lihat bagian 8).

### Usulan untuk proyek ini
- Menambah **target smoke-free (hari)** sebagai field opsional profil/biodata (belum ada). Bentuk penyimpanan/penyajian **alasan berhenti** harus diputuskan agar tidak menduplikasi atau membingungkan fitur alasan berhenti yang sudah ada.

## 3. Latar Belakang
Biodata (profil merokok) sudah menjadi fondasi perhitungan progres (hari berhenti, rokok tidak dihisap, uang dihemat, tapering). Namun motivasi personal yang eksplisit berupa alasan berhenti dan target durasi bebas rokok (hari) belum tertangkap sebagai bagian profil sesuai usulan entri referensi. Penguatan motivasi di permukaan utama (dashboard) disebut sebagai manfaat, tetapi implementasinya beririsan dengan fitur/PRD lain.

## 4. Tujuan Fitur
- Mempersonalisasi profil berhenti merokok dengan data motivasi yang relevan.
- Memungkinkan pengguna menetapkan dan melihat **target smoke-free (hari)** secara jelas (definisi final: lihat Pertanyaan Terbuka).
- Menyelaraskan penyajian **alasan berhenti** dengan kebutuhan motivasi tanpa duplikasi data/fungsi yang membingungkan.
- Memberikan dasar yang dapat diuji untuk implementasi biodata; penyajian motivasi lintas layar (mis. dashboard) ditangani sesuai keputusan ruang lingkup.

## 5. Masalah yang Diselesaikan
- Biodata belum memiliki field **target smoke-free (hari)**.
- Entri referensi meminta “field opsional alasan berhenti” pada biodata, tetapi kondisi aktual proyek sudah memiliki **fitur daftar Alasan Berhenti terpisah** (CRUD, DB, dipakai dashboard/SOS) — sehingga ada risiko duplikasi atau ketidakselarasan konsep jika langsung menambah field biodata tanpa keputusan.
- Motivasi berbasis target/alasan belum terstruktur sebagai bagian profil (untuk target) dan belum jelas bentuk integrasinya (untuk alasan).

## 6. Target Pengguna
- Pengguna yang mengisi atau memperbarui biodata/profil merokok.
- Pengguna yang ingin menetapkan target durasi bebas rokok sebagai jangkar motivasi.
- Pengguna yang ingin alasan berhenti mudah diingat/ditampilkan saat progres dipantau.

## 7. Ruang Lingkup
### Termasuk (usulan Draft, perlu konfirmasi)
- Menambah field opsional **target smoke-free (hari)** pada biodata: model, konstanta kolom, migrasi DB, form input (opsional), tampilan biodata, validasi (jika diisi: bilangan bulat positif), dan kompatibilitas data lama.
- Menentukan pendekatan **alasan berhenti** pada konteks biodata/profil: (A) memakai fitur `alasan_berhenti` existing sebagai sumber motivasi tanpa menambah field duplikat di biodata, (B) menambah field ringkas opsional di biodata (mis. alasan utama) sebagai pelengkap, atau (C) pendekatan lain yang disepakati. PRD ini akan dikunci setelah keputusan.

### Tidak Termasuk (kecuali diputuskan terpisah)
- Implementasi backend/cloud sync, akun, atau komunitas.
- Perubahan formula `hariBerhenti`/`rokokTidakDiHisap`/`uangDihemat`/tapering di `BiodataModelPerhitungan`, kecuali perubahan kecil yang terdokumentasi dan disepakati untuk menampilkan progres terhadap target (jika diputuskan).
- Perubahan dependensi, build, atau kode di luar kebutuhan yang disepakati.
- Meniru UI referensi secara penuh.
- **Penyajian motivasi di `dashboard_screen.dart` (dan PRD dashboard):** diusulkan sebagai **di luar ruang lingkup PRD ini** kecuali pengguna memutuskan sebaliknya; jika disertakan, PRD harus mencatat irisan dengan `prd/optimasi-dashboard-ringkasan-progres.md` dan dampak file dashboard.

## 8. Kondisi Implementasi Saat Ini
- **Status implementasi (entri Biodata):** Sebagian (konsisten dengan `refrensi_apk.md` L185).
- **Fungsi biodata yang sudah tersedia:**
  - Model `BiodataModel` (Freezed `abstract class`, `fromSqflite`/`toSqflite`, `ParserUtil`) + `BiodataModelPerhitungan` (`hariBerhenti`, `rokokTidakDiHisap`, `uangDihemat`, `sedangTapering`, `targetRokokHariIni`) — `lib/fitur/biodata/model/biodata_model.dart`.
  - Form input, tampilan, notifier — `lib/fitur/biodata/screens/form_biodata.dart`, `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/biodata/notifier/biodata_notifier.dart`.
  - DB `biodata` v7, migrasi bertahap — `lib/shared/db/sqflite/sqflite.dart` (`_versiDatabase = 7`), konstanta — `lib/shared/konstanta/nama_kolom.dart`, `nama_tabel.dart`.
- **Fungsi “alasan berhenti” yang sudah tersedia (fitur terpisah, bukan field biodata):**
  - Modul CRUD daftar alasan: `lib/fitur/alasan_berhenti/model/alasan_berhenti_model.dart`, `state/`, `notifier/alasan_berhenti_notifier.dart` (Riverpod `keepAlive`), `screens/alasan_berhenti_screen.dart`, `screens/form_alasan_berhenti.dart`.
  - Tabel DB `alasan_berhenti` (`NamaTabel.alasanBerhenti`, kolom `id/teks/dibuat`) dibuat di `onCreate` dan `onUpgrade` v7 — `lib/shared/db/sqflite/sqflite.dart`.
  - Dipakai oleh: `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/lainnya_screen.dart`.
- **Fungsi yang belum tersedia (sesuai peluang referensi, status perlu diverifikasi setelah keputusan):**
  - Field opsional **target smoke-free (hari)** pada biodata/profil.
  - Integrasi bentuk “alasan berhenti pada biodata/profil” yang selaras dengan fitur existing (keputusan terbuka).
- **Kekurangan/gap:** Usulan referensi menyebut “field alasan berhenti pada biodata”; implementasi aktual menggunakan daftar terpisah. PRD harus mencegah duplikasi dan UX yang membingungkan.

## 9. Kebutuhan Fungsional
- **KF-1 (target, usulan wajib setelah keputusan):** Sistem menyediakan field opsional `targetSmokeFreeHari` (bilangan bulat, hari) pada biodata. Jika diisi, nilai harus > 0; jika kosong, diperlakukan sebagai “belum ditetapkan”.
- **KF-2:** Form biodata memungkinkan pengguna mengisi/mengubah/mengosongkan target (sesuai keputusan UX) dengan validasi yang jelas (bahasa Indonesia formal). Penyimpanan hanya terjadi setelah validasi form sukses (pola existing).
- **KF-3:** Layar biodata menampilkan target smoke-free bila tersedia, dengan label yang jelas.
- **KF-4:** Data lama (tanpa kolom target) tetap terbaca tanpa crash (fallback null/default aman).
- **KF-5 (alasan berhenti, keputusan):** Salah satu disepakati:
  - **A:** Tidak menambah field alasan di tabel biodata; motivasi alasan tetap via fitur `alasan_berhenti` existing. Biodata dapat menampilkan ringkasan/jumlah alasan hanya jika disepakati dan tanpa duplikasi sumber data (opsional, ruang lingkup terpisah).
  - **B:** Tambah field opsional ringkas pada biodata (mis. `alasanUtama`/`alasanBerhenti` teks) sebagai profil, berdampingan dengan daftar `alasan_berhenti` existing; relasi/konsistensi harus dijelaskan.
  - **C:** Lainnya sesuai keputusan pengguna.
- **KF-6 (dashboard, di luar ruang lingkup default):** Menampilkan alasan/target sebagai motivasi di dashboard **tidak** termasuk implementasi PRD ini kecuali pengguna menyetujui perluasan ruang lingkup dan irisan dengan `prd/optimasi-dashboard-ringkasan-progres.md`.

## 10. Kebutuhan Nonfungsional
- **Konsistensi arsitektur:** Ikuti `docs/struktur_rules.md` dan pola proyek (Freezed `abstract class`, Riverpod generator, `SqfliteOp`/pola DB, `L` logging, `Nav`, `AppToast`/`adaptive_dialog`/`EasyLoading` sesuai usage existing).
- **Data/DB:** Normalisasi tanggal UTC di DB, lokal saat tampil (pola existing). Migrasi: bump versi, `onCreate` lengkap, `onUpgrade` kondisional `oldVersion < N`. Nama tabel/kolom via konstanta.
- **UX:** Bahasa Indonesia formal, `SafeArea`, padding tepi via container halaman, hierarki teks via `textTheme`, state async (loading/error) sebelum `requireValue`, konfirmasi sebelum simpan jika pola form mempertahankannya.
- **Keandalan:** Guard validasi, null-safety, type promotion; jangan gunakan `!` pada field nullable tanpa penyalinan lokal. Jangan duplikasi perhitungan turunan di luar `BiodataModelPerhitungan` bila relevan.
- **Offline-first:** Data lokal SQLite/provider.

## 11. Alur Penggunaan
1. Pengguna membuka layar Biodata / Form Biodata.
2. Pengguna melihat field profil existing dan (setelah implementasi) field opsional target smoke-free (hari).
3. Pengguna mengisi target (opsional) dan menyimpan setelah konfirmasi/validasi.
4. Sistem memvalidasi (target kosong diperbolehkan; jika terisi harus > 0) dan menyimpan ke DB lokal.
5. Layar biodata menampilkan target. Jika kosong, tampilkan status netral (mis. “Belum ditetapkan”) — teks final mengikuti UX proyek.
6. Alur alasan berhenti mengikuti keputusan KF-5 (existing list dan/atau field biodata).
7. Kondisi gagal simpan/muat: tampilkan error yang dapat ditindaklanjuti (retry/toast) tanpa crash.

## 12. Rancangan Antarmuka (konseptual)
- **Form biodata:** tambah input opsional “Target smoke-free (hari)” (angka, bilangan bulat positif bila diisi), ditempatkan dekat informasi berhenti/progres agar kontekstual. Placeholder/label jelas.
- **Tampil biodata:** tambah baris `_buildItem`/komponen setara untuk target. Jika belum diisi: teks netral.
- **Alasan berhenti:** sesuai KF-5 — bisa tetap diakses via `AlasanBerhentiScreen` existing; PRD ini tidak mengubah UI dashboard kecuali ruang lingkup diperluas.
- Ikuti tema, spacing, `SafeArea`, padding container.

## 13. Rancangan Teknis
- **Model:** `lib/fitur/biodata/model/biodata_model.dart` — tambah field opsional (usulan: `int? targetSmokeFreeHari`), update `fromSqflite`/`toSqflite` dengan fallback aman.
- **Konstanta:** `lib/shared/konstanta/nama_kolom.dart` — tambah konstanta kolom baru (nama snake_case DB, mis. `target_smoke_free_hari` — finalisasi nama wajib diverifikasi sebelum implementasi).
- **DB:** `lib/shared/db/sqflite/sqflite.dart` — bump `_versiDatabase` (saat ini 7), tambah kolom di `onCreate` tabel `biodata` dan `onUpgrade` `oldVersion < 8` via `ALTER TABLE ... ADD COLUMN` (pola v6).
- **Form/UI:** `form_biodata.dart`, `biodata_screen.dart` — input/tampil + validasi; pertahankan `Form` + `validate()` + pengecekan `mounted`/loading.
- **Notifier:** `biodata_notifier.dart` — tinjau dampak serialisasi; biasanya mengikuti model.
- **Perhitungan:** jika perlu tampilkan “sisa hari ke target” atau progres target, pertimbangkan getter/helper terpusat (jangan duplikasi). **Belum diputuskan** apakah perhitungan ini masuk ruang lingkup.
- **Generated:** `.freezed.dart`/`.g.dart` hanya dihasilkan saat implementasi (di luar command ini).

## 14. File Terdampak
| Path file | Status | Fungsi | Alasan terdampak | Kepastian |
|---|---|---|---|---|
| `lib/fitur/biodata/model/biodata_model.dart` | Existing | Model + ekstensi | Field target opsional (+ field alasan bila KF-5B) | Pasti (target) |
| `lib/shared/konstanta/nama_kolom.dart` | Existing | Konstanta kolom | Kolom target/alasan biodata | Pasti (sesuai keputusan) |
| `lib/shared/db/sqflite/sqflite.dart` | Existing | DB/migrasi | Bump v8, onCreate+onUpgrade biodata | Pasti (target) |
| `lib/fitur/biodata/screens/form_biodata.dart` | Existing | Form | Input + validasi target | Pasti |
| `lib/fitur/biodata/screens/biodata_screen.dart` | Existing | Tampilan | Tampil target | Pasti |
| `lib/fitur/biodata/notifier/biodata_notifier.dart` | Existing | Notifier | Penyesuaian simpan/baca bila perlu | Perlu verifikasi |
| `lib/fitur/biodata/model/biodata_model.freezed.dart`, `notifier/biodata_notifier.g.dart` | Generated | Kode hasil | Regenerasi saat implementasi | Pasti (nanti) |
| `lib/fitur/alasan_berhenti/*` | Existing | Fitur alasan terpisah | Kemungkinan integrasi/referensi saja; **tidak diubah** kecuali KF-5 memutuskan | Tergantung keputusan |
| `lib/fitur/dashboard/screens/dashboard_screen.dart` | Existing | Dashboard | Hanya jika ruang lingkup diperluas (motivasi) | Tergantung keputusan |
| `prd/optimasi-dashboard-ringkasan-progres.md` | Existing | PRD dashboard | Koordinasi jika dashboard berubah | Tergantung keputusan |
| `test/*biodata*` | Perlu verifikasi | Pengujian | Cakup perubahan public API/state bila ada | Perlu verifikasi |

## 15. Kriteria Penerimaan (Draft)
- [ ] Field target smoke-free (hari) opsional dapat disimpan, dibaca ulang, dan ditampilkan tanpa crash (termasuk data lama).
- [ ] Validasi: jika diisi, target bilangan bulat > 0; kosong diperbolehkan (sesuai keputusan).
- [ ] Migrasi DB menaikkan versi, memperbarui `onCreate` dan `onUpgrade` secara aman.
- [ ] Tidak ada duplikasi formula perhitungan turunan; ekstensi biodata tetap sumber kebenaran bila dipakai.
- [ ] Keputusan KF-5 (alasan berhenti) terdokumentasi dan diterapkan secara konsisten tanpa duplikasi UX/data yang membingungkan.
- [ ] UI mengikuti tema, `textTheme`, padding container, bahasa Indonesia formal, dan state async aman.
- [ ] (Jika ruang lingkup dashboard disetujui) Motivasi tampil di dashboard dengan sumber data jelas dan tanpa regresi kartu existing.
- [ ] Verifikasi saat implementasi: `flutter analyze`, test relevan, dan pengecekan Android-first (oleh implementor).

## 16. Risiko dan Ketergantungan
- **Risiko duplikasi konsep:** “Alasan berhenti” sudah ada sebagai daftar terpisah; menambah field biodata tanpa keputusan dapat membingungkan pengguna dan menggandakan data.
- **Ketergantungan keputusan:** KF-5, ruang lingkup dashboard, definisi target (hari sejak berhenti vs target bebas), dan perilaku progres terhadap target.
- **Irisan PRD:** Dashboard sudah punya PRD/status; perubahan dashboard memerlukan koordinasi.
- **Referensi eksternal:** Deskripsi Play Store dapat berubah/terbatas akses; PRD tidak bergantung pada klaim visual yang belum diverifikasi.

## 17. Pertanyaan Terbuka
1. **Ruang lingkup dashboard:** Apakah PRD ini mencakup perubahan `lib/fitur/dashboard/screens/dashboard_screen.dart` untuk motivasi (alasan/target)? Usulan: **di luar PRD ini** kecuali Anda memutuskan memperluas.
2. **Alasan berhenti (KF-5):** Pilih (A) gunakan fitur `alasan_berhenti` existing saja, (B) tambah field ringkas opsional di biodata berdampingan, atau (C) lainnya. Apa bentuk UX yang diinginkan?
3. **Definisi target smoke-free (hari):** (1) target = N hari **sejak `tanggalMulaiBerhentiMerokok`** (selaras `hariBerhenti`), atau (2) target **bebas/mandiri** sebagai angka motivasi? Perlu ditampilkan progres “X dari N hari”?
4. **Nama field DB/model final:** konfirmasi penamaan (mis. `targetSmokeFreeHari` / `target_smoke_free_hari`) saat implementasi.
5. **Referensi APK eksternal:** perlu saya coba ambil deskripsi Play Store via `webfetch` untuk memperkaya fakta teramati (dengan catatan keterbatasan)?

## 18. Rekomendasi
- Implementasi bertahap: **tahap 1** target smoke-free di biodata (risiko rendah, gap jelas); **tahap 2** keputusan integrasi alasan berhenti (karena fitur existing sudah berjalan).
- Jaga `BiodataModelPerhitungan` sebagai satu-satunya sumber perhitungan turunan yang relevan.
- Jika dashboard diubah, buat/koordinasikan keputusan dengan PRD dashboard agar tidak tumpang tindih.

## 19. Riwayat Perubahan
| Tanggal | Perubahan | Oleh |
|---|---|---|
| 2026-11-08 | Draf awal PRD dari `refrensi_apk.md` L182–195, pemeriksaan `biodata` + temuan `alasan_berhenti` existing (DB v7/dashboard/SOS). Belum final. | AI (analisis/dokumentasi, tanpa perubahan kode) |
