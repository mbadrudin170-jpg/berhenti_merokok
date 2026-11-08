# PRD: Optimasi Biodata (Profil Merokok) — Alasan Berhenti & Target Smoke-Free

## 1. Identitas Fitur
- **Nama fitur:** Optimasi Biodata (Profil Merokok: Alasan Berhenti & Target Smoke-Free)
- **Kategori:** Pembaruan / Penyempurnaan
- **Status PRD:** Final
- **Tanggal pembaruan:** 2026-11-08

## 2. Sumber Referensi
- **Nama aplikasi referensi:** Smoke Free (Portable Pixels); Quit Tracker (despDev); Kick It (UC San Diego)
- **URL aplikasi:**
  - https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
  - https://play.google.com/store/apps/details?id=com.despdev.quitsmoking
  - https://play.google.com/store/apps/details?id=com.kickitca
- **Path file referensi:** `refrensi_apk.md`
- **Nomor baris awal dan akhir (entri terpilih, isi aktual saat dianalisis):** 168–181 (verifikasi 2026-11-08, setelah penanda status PRD)
- **Judul entri:** 3. Biodata (Profil Merokok)
- **Screenshot/sumber visual:** Deskripsi resmi Google Play Store (disebut di entri). Halaman Play Store **tidak** diambil via webfetch pada sesi ini atas keputusan pengguna (2026-11-08); keterbatasan akses/konten dinamis tetap dicatat. Tidak ada APK yang diunduh atau dijalankan.

### Fakta teramati dari sumber internal
- `refrensi_apk.md` (L182–195): peluang optimasi = field opsional **alasan berhenti** dan **target smoke-free (hari)** pada biodata; saran tampilkan di dashboard sebagai motivasi; relevan, dampak terbatas.

### Interpretasi
- “Field pada biodata” di konteks proyek ini diterjemahkan sebagai: (1) **target smoke-free (hari)** disimpan pada biodata/profil; (2) **alasan berhenti** memanfaatkan sumber data existing `alasan_berhenti` (daftar terpisah) agar tidak duplikasi; keduanya dapat disajikan sebagai motivasi di dashboard sesuai keputusan ruang lingkup.

### Usulan untuk proyek ini (disepakati dalam diskusi, belum final PRD)
- Tambah field opsional **target smoke-free (hari)** pada biodata, dihitung/ditafsirkan sebagai **N hari sejak `tanggalMulaiBerhentiMerokok`** (selaras dengan `hariBerhenti` pada `BiodataModelPerhitungan`), dengan tampilan progres **“X dari N hari”** bila target diisi dan tanggal berhenti tersedia.
- **Alasan berhenti (KF-5 = A):** gunakan fitur `alasan_berhenti` existing saja (CRUD/DB v7, sudah dipakai Dashboard/SOS). Tidak menambah field alasan duplikat di tabel biodata.
- **Ruang lingkup mencakup dashboard:** PRD ini mendokumentasikan dampak/AC untuk menampilkan motivasi (progres target + penajaman/alignment tampilan alasan existing) di `dashboard_screen.dart`, dengan catatan irisan terhadap `prd/optimasi-dashboard-ringkasan-progres.md`.

## 3. Latar Belakang
Biodata (profil merokok) sudah menjadi fondasi perhitungan progres (hari berhenti, rokok tidak dihisap, uang dihemat, tapering). Namun motivasi personal yang eksplisit berupa alasan berhenti dan target durasi bebas rokok (hari) belum tertangkap sebagai bagian profil sesuai usulan entri referensi. Penguatan motivasi di permukaan utama (dashboard) disebut sebagai manfaat, tetapi implementasinya beririsan dengan fitur/PRD lain.

## 4. Tujuan Fitur
- Mempersonalisasi profil berhenti merokok dengan **target smoke-free (hari)** yang jelas dan terukur.
- Menampilkan progres target sebagai **“X dari N hari”** sejak `tanggalMulaiBerhentiMerokok` (selaras dengan perhitungan `hariBerhenti`), tanpa mengubah formula inti perhitungan turunan.
- Memperkuat motivasi dengan **alasan berhenti** menggunakan sumber data `alasan_berhenti` existing (tanpa duplikasi field di biodata).
- Menyajikan motivasi (target + alasan) secara konsisten di biodata dan dashboard, dengan dampak file terdokumentasi.

## 5. Masalah yang Diselesaikan
- Biodata belum memiliki field **target smoke-free (hari)**.
- Pengguna belum melihat progres relatif terhadap target hari (hanya metrik durasi/uang/rokok/milestone).
- Entri referensi meminta “field alasan berhenti pada biodata” + motivasi dashboard; proyek sudah memiliki daftar alasan terpisah dan kartu alasan di dashboard. Tanpa keputusan, risiko duplikasi/inkonsistensi tinggi — **diputuskan (A)**: pakai existing saja.

## 6. Target Pengguna
- Pengguna yang mengisi atau memperbarui biodata/profil merokok.
- Pengguna yang ingin target durasi bebas rokok (hari) sebagai jangkar motivasi.
- Pengguna yang ingin melihat alasan berhenti dan progres target dari dashboard.

## 7. Ruang Lingkup
### Termasuk (disepakati dalam diskusi)
- Menambah field opsional **target smoke-free (hari)** pada biodata: model, konstanta kolom, migrasi DB, form input (opsional), tampilan biodata, validasi (jika diisi: bilangan bulat positif), dan kompatibilitas data lama.
- **Alasan berhenti (KF-5 = A):** gunakan fitur `alasan_berhenti` existing saja. Tidak menambah field alasan di tabel biodata. Tidak membuat sumber data alasan baru.
- **Dashboard (termasuk):** `lib/fitur/dashboard/screens/dashboard_screen.dart` — tampilkan motivasi **progres target smoke-free “X dari N hari”** (berbasis `hariBerhenti` + target biodata) dan pertahankan/selaraskan penampilan alasan berhenti existing agar konsisten sebagai motivasi. Perubahan terbatas pada kebutuhan ini; hindari duplikasi formula.
- Koordinasi dokumentasi: PRD ini mencatat irisan dengan `prd/optimasi-dashboard-ringkasan-progres.md` (dashboard). **PRD dashboard tidak diubah** oleh command ini (di luar izin edit); implementor/PR berikutnya perlu meninjau keselarasan.

### Tidak Termasuk
- Backend/cloud sync, akun, komunitas, AI coach.
- Perubahan formula inti `BiodataModelPerhitungan.hariBerhenti`/`rokokTidakDiHisap`/`uangDihemat`/tapering. Perhitungan progres target (mis. `min(hariBerhenti, target)`) bersifat presentasi/turunan ringan dan **tidak** mengubah getter inti existing kecuali keputusan terpisah (lihat Rancangan Teknis).
- Perubahan dependensi, build, atau kode di luar kebutuhan yang disepakati.
- Meniru UI referensi secara penuh.
- Restruktur besar modul `alasan_berhenti` (opsi C ditolak pada diskusi ini).

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
- **KF-1 (target):** Sistem menyediakan field opsional `targetSmokeFreeHari` (bilangan bulat, hari) pada biodata. Jika diisi, nilai harus > 0; jika kosong, diperlakukan sebagai “Belum ditetapkan”.
- **KF-2:** Form biodata memungkinkan pengguna mengisi, mengubah, atau mengosongkan target. Validasi: kosong diperbolehkan; jika terisi harus bilangan bulat > 0. Pesan validasi bahasa Indonesia formal. Penyimpanan hanya terjadi setelah `validate()` sukses dan konfirmasi (pola existing).
- **KF-3 (biodata):** Layar biodata menampilkan target smoke-free. Jika target dan `tanggalMulaiBerhentiMerokok` tersedia, tampilkan progres berbasis `X = hariBerhenti` (sumber: `BiodataModelPerhitungan`):
  - Jika `X < N`: “X dari N hari”.
  - Jika `X >= N`: “N dari N hari — Target tercapai” (**disepakati**).
  - Jika tanggal berhenti belum ada: tampilkan target tanpa progres yang menyesatkan (mis. “Target: N hari” + status netral).
- **KF-4:** Data lama (tanpa kolom target) tetap terbaca tanpa crash (fallback null/aman).
- **KF-5 (alasan berhenti = A, disepakati):** Tidak menambah field alasan di tabel biodata. Motivasi alasan menggunakan modul `alasan_berhenti` existing (`alasanBerhentiProvider`/`AlasanBerhentiScreen`) sebagai satu-satunya sumber data alasan. Dashboard/SOS tetap memakai sumber ini.
- **KF-6 (dashboard, termasuk):** `dashboard_screen.dart` menampilkan elemen motivasi target **dekat durasi/progres utama** (**disepakati**), dengan aturan KF-3 untuk teks progres. Tangani loading/error/biodata null; jangan `requireValue` sebelum siap.
- **KF-7 (dashboard alasan, alignment):** Kartu alasan berhenti existing tetap berfungsi dan bersumber dari `alasanBerhentiProvider`; penyesuaian hanya presentasi/hierarki bila perlu. Routing via `Nav`.

## 10. Kebutuhan Nonfungsional
- **Konsistensi arsitektur:** Ikuti `docs/struktur_rules.md` dan pola proyek (Freezed `abstract class`, Riverpod generator, `SqfliteOp`/pola DB, `L` logging, `Nav`, `AppToast`/`adaptive_dialog`/`EasyLoading` sesuai usage existing).
- **Data/DB:** Normalisasi tanggal UTC di DB, lokal saat tampil (pola existing). Migrasi: bump versi, `onCreate` lengkap, `onUpgrade` kondisional `oldVersion < N`. Nama tabel/kolom via konstanta.
- **UX:** Bahasa Indonesia formal, `SafeArea`, padding tepi via container halaman, hierarki teks via `textTheme`, state async (loading/error) sebelum `requireValue`, konfirmasi sebelum simpan jika pola form mempertahankannya.
- **Keandalan:** Guard validasi, null-safety, type promotion; jangan gunakan `!` pada field nullable tanpa penyalinan lokal. Jangan duplikasi perhitungan turunan di luar `BiodataModelPerhitungan` bila relevan.
- **Offline-first:** Data lokal SQLite/provider.

## 11. Alur Penggunaan
1. Pengguna membuka Form Biodata dan mengisi target smoke-free (hari) opsional (mis. 30).
2. Sistem memvalidasi (kosong boleh; jika terisi > 0) dan menyimpan ke DB lokal setelah konfirmasi.
3. Layar Biodata menampilkan target. Jika tanggal berhenti ada, tampilkan **“X dari N hari”** (X bersumber dari `hariBerhenti`).
4. Pengguna membuka Dashboard. Dashboard memuat biodata (+ alasan existing) dan menampilkan kartu motivasi target “X dari N hari” bila syarat terpenuhi.
5. Kartu alasan berhenti existing tetap dapat dibuka ke `AlasanBerhentiScreen` via `Nav` (perilaku existing dipertahankan).
6. Kondisi khusus: target kosong/tanggal berhenti kosong → tidak menampilkan progres target yang menyesatkan; biodata/alasan loading/error → state aman tanpa crash.

## 12. Rancangan Antarmuka (konseptual)
- **Form biodata:** input opsional “Target smoke-free (hari)” (angka). Label/placeholder jelas, validasi formal.
- **Layar biodata:** baris target + baris progres “X dari N hari” bila relevan.
- **Dashboard:** kartu/elemen motivasi target ditempatkan konsisten (keputusan posisi final minor: dekat durasi/milestone, tanpa mengganggu hierarki existing); kartu alasan berhenti existing diselaraskan secara visual bila perlu. `Theme.textTheme`/`colorScheme`, spacing, `SafeArea`/padding container.
- Tidak meniru UI referensi.

## 13. Rancangan Teknis
- **Model:** `lib/fitur/biodata/model/biodata_model.dart` — tambah `int? targetSmokeFreeHari` (nama final dapat disesuaikan saat implementasi, makna tetap), update `fromSqflite`/`toSqflite` fallback aman.
- **Konstanta:** `lib/shared/konstanta/nama_kolom.dart` — `targetSmokeFreeHari` (snake_case DB, mis. `target_smoke_free_hari`).
- **DB:** `lib/shared/db/sqflite/sqflite.dart` — saat ini `_versiDatabase = 7`; bump ke 8 (atau versi berikutnya bila berubah sebelum implementasi), tambah kolom di `onCreate` biodata + `onUpgrade` `oldVersion < 8`.
- **Biodata UI:** `form_biodata.dart`, `biodata_screen.dart` — input/tampil/validasi, `mounted`/loading aman.
- **Dashboard UI:** `dashboard_screen.dart` — watch data yang dibutuhkan, hitung tampilan `X dari N` memakai `biodata.hariBerhenti` (sumber terpusat) dan `targetSmokeFreeHari`; jaga guard async/loading/error/biodata null. Jangan duplikasi formula inti.
- **Alasan berhenti:** `alasanBerhentiProvider`/fitur existing **tidak** diubah sebagai sumber data; dashboard tetap konsumsi existing.
- **Generated:** `.freezed.dart`/`.g.dart` saat implementasi saja (di luar command ini).

## 14. File Terdampak
| Path file | Status | Fungsi | Alasan terdampak | Kepastian |
|---|---|---|---|---|
| `lib/fitur/biodata/model/biodata_model.dart` | Existing | Model + ekstensi | Field target opsional | Pasti |
| `lib/shared/konstanta/nama_kolom.dart` | Existing | Konstanta kolom | Kolom target | Pasti |
| `lib/shared/db/sqflite/sqflite.dart` | Existing | DB/migrasi | v8, kolom biodata | Pasti (versi final verifikasi) |
| `lib/fitur/biodata/screens/form_biodata.dart` | Existing | Form | Input + validasi target | Pasti |
| `lib/fitur/biodata/screens/biodata_screen.dart` | Existing | Tampil biodata | Target + progres “X dari N hari” | Pasti |
| `lib/fitur/dashboard/screens/dashboard_screen.dart` | Existing | Dashboard | Motivasi target + alignment alasan existing | Pasti (ruang lingkup termasuk) |
| `lib/fitur/biodata/notifier/biodata_notifier.dart` | Existing | Notifier | Tinjau serialisasi/simpan | Perlu verifikasi |
| `lib/fitur/alasan_berhenti/*` | Existing | Sumber alasan (A) | **Tidak diubah** kecuali bug tak terkait (di luar PRD) | Tidak diubah |
| `lib/fitur/biodata/*.freezed.dart`, `*.g.dart` | Generated | Hasil generator | Regenerasi implementasi | Nanti |
| `prd/optimasi-dashboard-ringkasan-progres.md` | Existing | PRD dashboard | **Koordinasi saat implementasi** (irisan dashboard); tidak diedit di command ini | Koordinasi |
| `test/*biodata*`, `test/*dashboard*` | Perlu verifikasi | Pengujian | Cakup perubahan public behavior | Perlu verifikasi |

## 15. Kriteria Penerimaan
- [ ] Target smoke-free (hari) opsional tersimpan/terbaca/tertampil; data lama aman (tanpa crash).
- [ ] Validasi target: kosong boleh; jika terisi bilangan bulat > 0.
- [ ] Biodata menampilkan progres “X dari N hari” bila target dan `tanggalMulaiBerhentiMerokok` tersedia; makna selaras `hariBerhenti`.
- [ ] Migrasi DB bump versi, `onCreate` + `onUpgrade` aman (pola proyek).
- [ ] Dashboard menampilkan motivasi target sesuai KF-6 tanpa regresi kartu existing; guard async/loading/error/null.
- [ ] Dashboard tetap memakai `alasanBerhentiProvider`/fitur existing (KF-5A, KF-7); tidak ada duplikasi sumber alasan.
- [ ] Tidak ada duplikasi formula inti `BiodataModelPerhitungan`; progres target memakai `hariBerhenti`.
- [ ] UI: tema, `textTheme`, padding container, `SafeArea`, bahasa Indonesia formal, tooltip/touch target sesuai aturan bila ada interaksi baru.
- [ ] (Implementasi) `flutter analyze`/test relevan lulus sesuai aturan proyek; perubahan kode hanya sesuai PRD yang disetujui.

## 16. Risiko dan Ketergantungan
- **Irisan dashboard:** `dashboard_screen.dart` dan `prd/optimasi-dashboard-ringkasan-progres.md` — risiko konflik/perubahan ganda; mitigasi: implementasi terkoordinasi, perubahan minimal.
- **Tanggal berhenti kosong:** progres target tidak bisa dihitung; UI harus netral/jelas.
- **Target terlampaui:** tentukan presentasi konsisten (capai/terlampaui) tanpa mengubah makna.
- **Async multi-provider:** dashboard sudah mem-watch beberapa sumber; tambah guard eksplisit.
- **Migrasi:** pastikan versi final saat implementasi (DB bisa berubah oleh pekerjaan lain).

## 17. Pertanyaan Terbuka
- Tidak ada pertanyaan terbuka. Keputusan utama dan minor telah disepakati (dashboard termasuk; KF-5A `alasan_berhenti` existing; target sejak `tanggalMulaiBerhentiMerokok` + “X dari N hari”; terlampaui = “N dari N hari — Target tercapai”; posisi dekat durasi/progres utama; Play Store webfetch tidak dilakukan).
- PRD disetujui **Final** oleh pengguna (2026-11-08).

## 18. Rekomendasi
- Satu sumber kebenaran alasan = `alasan_berhenti` existing (KF-5A).
- Gunakan `hariBerhenti` dari `BiodataModelPerhitungan`; jangan duplikasi formula inti.
- Implementasi dashboard minimal dan terkoordinasi dengan `prd/optimasi-dashboard-ringkasan-progres.md`.

## 19. Riwayat Perubahan
| Tanggal | Perubahan | Oleh |
|---|---|---|
| 2026-11-08 | Draf awal (Biodata parsial; temuan `alasan_berhenti` existing). | AI (analisis, tanpa kode) |
| 2026-11-08 | Keputusan: dashboard termasuk; KF-5A; target sejak tanggal berhenti + “X dari N hari”; webfetch tidak. | AI, berdasar jawaban pengguna |
| 2026-11-08 | Keputusan minor: lampaui target = “N dari N hari — Target tercapai”; posisi dashboard dekat durasi/progres utama. Koreksi nomor baris referensi. | AI, berdasar jawaban pengguna |
| 2026-11-08 | PRD disetujui **Final** oleh pengguna; status PRD dan penanda referensi diperbarui. | AI, konfirmasi pengguna |
