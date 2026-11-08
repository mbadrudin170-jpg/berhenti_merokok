# PRD: Optimasi Dashboard — Ringkasan Progres

## 1. Identitas Fitur
- **Nama fitur:** Optimasi Dashboard (Ringkasan Progres: Impian & Streak)
- **Kategori:** Pembaruan / Penyempurnaan
- **Status PRD:** Draft
- **Tanggal pembaruan:** 2026-11-08

## 2. Sumber Referensi
- **Nama aplikasi referensi:** QuitNow (Fewlaps); Smoke Free (David Crane PhD / Portable Pixels); Quit Tracker (despDev)
- **URL aplikasi:**
  - https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa
  - https://play.google.com/store/apps/details?id=com.portablepixels.smokefree
  - https://play.google.com/store/apps/details?id=com.despdev.quitsmoking
- **Path file referensi:** `refrensi_apk.md`
- **Nomor baris awal dan akhir:** 220–233
- **Judul entri:** 4. Dashboard (Ringkasan Progres)
- **Screenshot/sumber visual:** Deskripsi resmi Google Play Store (diperiksa 2026-11-08 via web); detail tata letak/screenshot spesifik belum dianalisis mendalam.

## 3. Latar Belakang
Dashboard saat ini menjadi layar utama ringkasan progres smoke-free. Aplikasi sudah memiliki metrik uang dihemat, rokok tidak dihisap, durasi berhenti, milestone kesehatan terdekat, dan shortcut pencapaian. Namun ringkasan tujuan finansial/motivasi (impian) dan capaian konsistensi jangka panjang (“streak terpanjang”, sesuai entri referensi) belum ditampilkan di dashboard. Pengguna perlu membuka fitur lain untuk memahami status impian, sehingga informasi bermakna belum sepenuhnya terkonsolidasi.

## 4. Tujuan Fitur
- Menyajikan ringkasan progres yang lebih bermakna pada dashboard.
- Menyelaraskan dashboard dengan tujuan aplikasi (progres berhenti merokok + motivasi/tujuan).
- Memudahkan pengguna melihat status impian (jumlah impian dan impian tercapai) secara cepat.
- Memberikan metrik konsistensi (“streak terpanjang”) **setelah definisi produk/teknis disepakati**.

## 5. Masalah yang Diselesaikan
- Dashboard belum merangkum jumlah impian dan impian tercapai, padahal data impian sudah tersedia.
- Dashboard belum menampilkan streak terpanjang; definisi metrik ini belum tersedia di implementasi saat ini.
- Pengguna harus navigasi ke layar Impian untuk mengetahui progres tujuan tabungan.

## 6. Target Pengguna
- Pengguna yang telah mengisi biodata dan/atau memiliki tanggal mulai berhenti merokok.
- Pengguna yang membuat impian dan ingin memantau progresnya dari dashboard.
- Pengguna yang membutuhkan ringkasan motivasi cepat tanpa membuka banyak layar.

## 7. Ruang Lingkup
### Termasuk (usulan, Draft)
- Menampilkan ringkasan jumlah impian dan impian tercapai pada dashboard (berbasis data impian dan saldo `uangDihemat` yang konsisten dengan fitur Impian).
- Navigasi opsional dari kartu ringkasan ke layar Impian.
- Menampilkan streak terpanjang **hanya jika** definisi, sumber data, dan dampak teknis disepakati.

### Tidak Termasuk
- Implementasi backend/cloud sync, akun, komunitas, atau AI coach.
- Perubahan perhitungan `uangDihemat`/`hariBerhenti`/`rokokTidakDiHisap` pada `BiodataModelPerhitungan` (kecuali keputusan terpisah yang terdokumentasi).
- Pencatatan relapse/reset historis untuk streak, **kecuali** disepakati sebagai ruang lingkup terpisah (berpotensi butuh model/DB/migrasi).
- Meniru desain visual referensi secara penuh.
- Perubahan dependensi, konfigurasi build, atau kode di luar kebutuhan fitur.

## 8. Kondisi Implementasi Saat Ini
- **Status implementasi:** Sebagian.
- **Fungsi yang sudah tersedia:**
  - Durasi berhenti merokok (real-time, widget terisolasi) — `lib/fitur/dashboard/screens/dashboard_screen.dart` (sekitar L442–L509, L120).
  - Kartu uang dihemat dan rokok tidak dihisap memakai getter terpusat biodata — `dashboard_screen.dart` (sekitar L146–L191).
  - Milestone kesehatan terdekat + navigasi — `dashboard_screen.dart` (sekitar L193–L248).
  - Shortcut pencapaian/badge — `dashboard_screen.dart` (sekitar L285–L326).
  - Info kerugian saat merokok — `dashboard_screen.dart` (sekitar L328–394).
  - Penanganan loading/error/biodata null — `dashboard_screen.dart` (sekitar L41–78, L409–438).
  - `ImpianState` memiliki `listImpian`, `jumlahImpian`, `totalJumlah` — `lib/fitur/impian/state/impian_state.dart`.
  - `impianProvider` (keepAlive) memuat/CRUD impian — `lib/fitur/impian/notifier/impian_notifier.dart`.
  - Layar Impian menghitung impian tercapai sebagai `uangDihemat >= item.jumlah` — `lib/fitur/impian/screens/impian_screen.dart` (sekitar L114–149).
  - `DashboardNotifier` mem-watch `impianProvider.future` — `lib/fitur/dashboard/notifier/dashboard_notifier.dart` (L17); perannya terhadap UI dashboard **belum dapat dipastikan**.
- **Fungsi yang belum tersedia:**
  - Kartu ringkasan jumlah impian dan impian tercapai pada dashboard.
  - Streak terpanjang pada dashboard.
- **Kekurangan yang ditemukan:**
  - Data impian belum diringkas di UI dashboard meskipun sumber data ada.
  - Tidak ditemukan implementasi/model “streak/longest streak/berturut-turut” di `lib/` (hasil pencarian `rg streak|berturut|hari berturut|longest`).
- **Bukti path dan nomor baris:** lihat daftar di atas; nomor baris bersifat indikatif berdasarkan pemeriksaan 2026-11-08 dan dapat bergeser jika file berubah.

## 9. Kebutuhan Fungsional
- **KF-1 (wajib jika disetujui):** Dashboard menampilkan ringkasan impian: jumlah impian total dan jumlah impian tercapai, berdasarkan data `impianProvider` dan saldo `uangDihemat` yang konsisten dengan pola fitur Impian.
- **KF-2:** Definisi “impian tercapai” harus konsisten: `item.jumlah > 0 && uangDihemat >= item.jumlah` (atau keputusan guard yang disepakati). Perilaku saat `jumlah <= 0` harus ditentukan.
- **KF-3:** Kartu ringkasan impian menangani kondisi async (loading/error/data kosong) tanpa memanggil `requireValue` sebelum state siap. Jika impian kosong, tampilkan informasi yang jelas (mis. “Belum ada impian” / “0 dari 0 impian”) sesuai keputusan UX.
- **KF-4 (opsional):** Mengetuk kartu ringkasan impian menavigasi ke layar Impian menggunakan `Nav`.
- **KF-5 (tertunda/keputusan):** Dashboard menampilkan “streak terpanjang” hanya setelah disepakati: (A) berbasis data saat ini (mis. hari smoke-free berturut-turut sejak tanggal berhenti, tanpa riwayat relapse — *istilah UI harus akurat*), atau (B) berbasis riwayat historis (memerlukan sumber data baru).

## 10. Kebutuhan Nonfungsional
- **Konsistensi arsitektur:** Ikuti `docs/struktur_rules.md` dan pola proyek (Riverpod, `L`, `Nav`, tema, `BiodataModelPerhitungan` sebagai sumber perhitungan turunan).
- **Keandalan:** Guard `jumlah <= 0`, biodata null, impian kosong, dan state async error/loading.
- **UX:** Bahasa Indonesia formal, hierarki visual jelas, padding tepi layar via container halaman, tidak menempel tepi, touch target memadai, teks tidak overflow.
- **Performa:** Hindari komputasi berat di `build`; tidak memicu rebuild berlebihan; pertimbangkan pembatasan rebuild bila perlu.
- **Offline-first:** Menggunakan data lokal (SQLite/provider) yang sudah ada.

## 11. Alur Penggunaan
1. Pengguna membuka Dashboard.
2. Aplikasi memuat biodata (pola existing) dan data impian.
3. Dashboard menampilkan metrik smoke-free yang sudah ada.
4. Dashboard menampilkan kartu ringkasan impian: “X dari Y impian tercapai” (atau setara).
5. (Opsional) Pengguna mengetuk kartu untuk membuka layar Impian.
6. (Jika KF-5 disetujui) Dashboard menampilkan streak terpanjang dengan definisi yang telah disepakati.
7. Kondisi khusus: biodata belum ada → alur biodata null existing tetap berlaku; impian kosong/error/loading → kartu impian menampilkan state yang sesuai tanpa crash.

## 12. Rancangan Antarmuka
- Tambah kartu/section ringkasan impian di area `ListView` dashboard, ditempatkan konsisten dengan hierarki informasi (keputusan posisi: sebelum/antara/sesudah kartu existing).
- Elemen: ikon/label “Impian”, nilai “tercapai dari total”, opsional chevron navigasi.
- Jika streak disetujui: kartu/row terpisah dengan label yang akurat terhadap definisi (hindari label “streak terpanjang” bila yang ditampilkan hanya hari smoke-free saat ini tanpa riwayat).
- Mengikuti `Theme.of(context).textTheme`/`colorScheme`, spacing proyek, dan pola kartu existing.

## 13. Rancangan Teknis
- **UI:** `lib/fitur/dashboard/screens/dashboard_screen.dart` (existing) — tambah konsumsi `impianProvider` dan widget kartu.
- **Data:** `impianProvider` + `biodataProvider`/`BiodataModelPerhitungan.uangDihemat` (existing). Jangan duplikasi formula uang dihemat/hari berhenti.
- **Opsional:** helper murni untuk hitung impian tercapai (lokasi mengikuti struktur proyek, belum dipastikan) agar konsisten dengan `impian_screen.dart`.
- **Notifier dashboard:** `lib/fitur/dashboard/notifier/dashboard_notifier.dart` (existing) — tinjau kebutuhan; perubahan belum dapat dipastikan wajib.
- **Streak (opsi B):** berpotensi menyentuh model/state/notifier/DB/migrasi; **belum termasuk** rancangan teknis final.

## 14. File Terdampak
| Path file | Status | Fungsi | Alasan terdampak |
|---|---|---|---|
| `lib/fitur/dashboard/screens/dashboard_screen.dart` | Existing | UI dashboard | Tambah kartu ringkasan impian; kemungkinan kartu streak; penanganan multi-provider async. |
| `lib/fitur/dashboard/notifier/dashboard_notifier.dart` | Existing | Notifier dashboard | Tinjau peran watch `impianProvider.future` (L17); perubahan belum dapat dipastikan. |
| `lib/fitur/impian/state/impian_state.dart` | Existing (consumed) | State impian | Sumber jumlah/list; kemungkinan tidak diubah. |
| `lib/fitur/impian/notifier/impian_notifier.dart` | Existing (consumed) | Provider impian | Sumber data; kemungkinan tidak diubah. |
| `lib/fitur/impian/screens/impian_screen.dart` | Existing (referensi) | Pola hitung tercapai | Konsistensi rumus; perubahan opsional bila ekstraksi helper disetujui. |
| `lib/fitur/biodata/model/biodata_model.dart` | Existing (consumed) | `uangDihemat`/perhitungan turunan | Sumber saldo; tidak diubah, tidak diduplikasi. |
| `lib/fitur/.../helper/*` | Rencana/Belum dapat dipastikan | Helper murni impian tercapai | Opsional; path mengikuti struktur proyek aktual. |
| `prd/optimasi-dashboard-ringkasan-progres.md` | Baru (dokumen) | PRD | Dokumentasi kebutuhan. |
| `refrensi_apk.md` (L220–233) | Existing (penanda) | Status referensi | Ditandai `Status PRD: Sudah dibuat — prd/optimasi-dashboard-ringkasan-progres.md`. |

## 15. Kriteria Penerimaan
- [ ] Dashboard menampilkan jumlah impian dan jumlah impian tercapai secara akurat berdasarkan data lokal.
- [ ] Perhitungan “tercapai” konsisten dengan aturan yang disepakati dan tidak menduplikasi formula `BiodataModelPerhitungan`.
- [ ] Kondisi loading/error/biodata null/impian kosong ditangani tanpa crash.
- [ ] UI mengikuti tema, spacing, aksesibilitas, dan bahasa Indonesia formal.
- [ ] (Jika navigasi disetujui) Kartu membuka layar Impian via `Nav` dengan penanganan error navigasi.
- [ ] (Jika KF-5 disetujui) Streak ditampilkan sesuai definisi yang disepakati dan tidak menyesatkan.
- [ ] Tidak ada perubahan kode di luar ruang lingkup yang disetujui; verifikasi `flutter analyze`/test relevan dilakukan saat implementasi (oleh implementor, sesuai aturan proyek).

## 16. Risiko dan Ketergantungan
- **Ketergantungan keputusan:** Definisi “streak terpanjang” belum disepakati; opsi historis butuh data relapse.
- **Ketergantungan data:** Impian dan biodata bisa kosong/error/loading; dashboard harus tetap stabil.
- **Risiko inkonsistensi:** Rumus “tercapai” bisa berbeda antar layar jika tidak disatukan.
- **Risiko async UI:** Multi-provider pada dashboard dapat menambah kompleksitas loading/error bila tidak ditangani eksplisit.
- **Keterbatasan referensi:** Label/visual streak pada referensi tidak sepenuhnya terverifikasi.

## 17. Pertanyaan Terbuka
1. Apakah definisi “streak terpanjang” = hari smoke-free saat ini sejak `tanggalMulaiBerhentiMerokok` (tanpa riwayat relapse), atau butuh riwayat streak terbaik? Jika historis, data apa yang akan dicatat?
2. Apakah ringkasan impian ditampilkan meskipun biodata/`uangDihemat` belum lengkap (saldo 0), dengan penjelasan konteks?
3. Di posisi mana kartu ringkasan impian/streak ditempatkan pada dashboard?
4. Apakah kartu impian dapat diketuk untuk membuka `ImpianScreen`?
5. Apakah perlu helper murni bersama untuk perhitungan “impian tercapai”?
6. Bagaimana perilaku `item.jumlah <= 0` (tidak dihitung tercapai / ditangani khusus)?

## 18. Rekomendasi
- Tahap 1 (wajib usulan): ringkasan impian (KF-1 s.d. KF-4) karena data sudah ada dan risiko rendah.
- Tahap 2 (setelah keputusan): streak terpanjang; mulai dari definisi berbasis data yang ada bila disetujui, dengan label UI yang akurat.
- Gunakan `BiodataModelPerhitungan.uangDihemat` dan hindari duplikasi formula.
- Tangani `impianProvider` dengan pola async yang jelas (loading/error terpisah atau placeholder kartu) mengikuti aturan proyek.

## 19. Riwayat Perubahan
| Tanggal | Perubahan | Oleh |
|---|---|---|
| 2026-11-08 | Draf awal PRD dari diskusi fitur `refrensi_apk.md` L220–233 dan pemeriksaan implementasi dashboard/impian. | AI (analisis, tanpa implementasi kode) |
