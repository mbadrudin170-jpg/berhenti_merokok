# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Sedang Dikerjakan

---

## 1. Informasi Produk

**Informasi:**
- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter offline-first untuk membantu pengguna berhenti merokok, mencatat konsumsi, craving, progres kesehatan, dan tabungan impian.
- Platform: Android (Flutter; kode juga berjalan di iOS/desktop/web, tetapi sasaran fitur ini adalah Android mobile)
- Versi: 1.0.0+1
- Status pengembangan: Aktif dikembangkan (layar SOS Craving tersedia; sedang ada PRD/implementasi perluasan tool SOS di `prd/sos_craving_tool_tambahan.md`)

## 2. Latar Belakang

Pengguna yang ingin merokok saat craving sering gagal bukan karena tidak tahu teknik coping, tetapi karena harus mengambil keputusan di saat intensitas craving paling tinggi — momen di mana kemampuan mengambil keputusan justru paling lemah.

Implementation intentions ("jika pemicu X terjadi, maka saya lakukan Y") adalah teknik perubahan perilaku yang memindahkan keputusan dari momen craving ke momen tenang sebelumnya. Meta-analisis uji coba terkontrol menunjukkan if-then plans efektif menurunkan perilaku kebiasaan yang tidak diinginkan (termasuk perilaku merokok) dalam studi kebiasaan (sumber: `refrensi_apk.md` bagian A10, baris 144–149).

Kondisi proyek saat ini (diperiksa pada branch `master`, 10–11 November 2026):

- Layar SOS Craving (`lib/fitur/sos_craving/screens/sos_craving_screen.dart`) menyediakan teknik coping, tetapi **tidak ada tempat** bagi pengguna untuk menuliskan rencana "jika craving saat X, maka saya lakukan Y" sebelum craving itu datang.
- Tabel `diary_craving` mencatat pemicu craving yang sudah terjadi, tetapi bersifat retrospektif — bukan rencana prospektif.
- Tidak ada tabel/field untuk menyimpan rencana if-then; tidak ada rencana yang ditampilkan saat craving.
- Riset kompetitor (`refrensi_apk.md:144-149`) menunjukkan pola ini dipakai: Pace (Playbook, maks 6 rencana), Flamy (SOS Emergency Setup: if-then plans + alasan + frasa bantuan + pintasan SOS dalam satu tempat).

Masalah yang ingin diselesaikan: aplikasi belum menyediakan mekanisme rencana if-then tertulis yang dapat dibangkitkan tepat saat pengguna membutuhkan bantuan (kartu SOS).

## 3. Tujuan Produk

- Menyediakan layar/kartu "Rencana Darurat Saya" berisi if-then plans (Jika …, Maka …) yang dibuat pengguna di saat tenang.
- Menampilkan rencana tersebut di kartu SOS Craving agar terlihat tepat saat craving menyerang.
- Seluruh data tersimpan lokal (SQLite), offline-first, tanpa iklan, tanpa akun, tanpa pengiriman data ke luar perangkat.
- Tidak mengubah logika bisnis, rumus, atau skema database yang sudah ada; hanya menambah tabel baru + migrasi versi.

## 4. Target Pengguna

- Pengguna aplikasi Berhenti Merokok yang sudah mengenali pola craving-nya (pemicu, jam, situasi) dan ingin menyiapkan respons otomatis.
- Pengguna yang mencatat diary craving dan ingin mengubah catatannya menjadi rencana konkret.
- Pengguna yang sedang craving dan membutuhkan pengingat rencana yang ia buat sendiri (bukan saran generik).

## 5. Ruang Lingkup

### Termasuk
- Pembuatan, pengubahan, penghapusan rencana if-then (Jika …, Maka …), maksimal 3 rencana tersimpan.
- Penyimpanan lokal di tabel baru `rencana_darurat` (migrasi database versi 11 → 12).
- Kartu tampilan rencana pada layar SOS Craving, terpisah di bawah kartu "Ingat alasanmu", yang merangkum rencana tersimpan.
- Layar kelola rencana (daftar + tambah + ubah + hapus) yang diakses dari kartu SOS Craving saja (tanpa entry di menu Lainnya).
- Validasi masukan (if/then wajib terisi, maks 150 karakter), penyimpanan melalui notifier Riverpod mengikuti pola `AlasanBerhentiNotifier`.
- Sinkron ke cadangan (backup) + perbaikan B1 sekaligus: `rencana_darurat`, `konsumsi_rokok`, dan `sos_intervensi` ikut terekspor dan terpulihkan pada `cadangan_helper.dart` (diputuskan 2026-11-10).

### Tidak Termasuk
- Draft rencana otomatis oleh AI / LLM (Pace memakai AI coach; di luar prinsip offline-first, lihat juga A8 di `refrensi_apk.md:130-135`).
- Notifikasi atau pengingat baru berbasis rencana (A13 `refrensi_apk.md:165-170` adalah fitur terpisah).
- Integrasi dengan timer/napas SOS (rencana hanya ditampilkan, tidak men-trigger teknik lain otomatis).
- Perubahan logika tapering, badge, impian, atau skema tabel yang sudah ada selain penambahan tabel baru.
- Template contoh rencana bawaan (diputuskan 2026-11-10: tidak diperlukan; pengguna menulis sendiri).
- Entry menu Lainnya untuk layar kelola (diputuskan 2026-11-10: hanya dari kartu SOS).
- Ekspor format selain JSON cadangan yang sudah ada. Perbaikan ekspor cadangan B1 (`konsumsi_rokok` + `sos_intervensi`) **termasuk** dalam v1 lewat 7.4 (diputuskan 2026-11-10: diperbaiki sekaligus, bukan ruang lingkup terpisah).

## 6. Daftar Fitur

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| Kelola rencana if-then | Tambah / ubah / hapus rencana "Jika …, Maka …", maksimal 3 | Must Have |
| Kartu "Rencana Darurat Saya" di SOS | Menampilkan rencana tersimpan pada layar SOS Craving | Must Have |
| Layar kelola rencana | Layar daftar rencana + form tambah/ubah | Must Have |
| Sinkron ke cadangan (backup) | `rencana_darurat` ikut terekspor/terpulihkan | Should Have |

## 7. Detail Persyaratan Fitur

### 7.1 Kelola Rencana If-Then

- Nama fitur: Kelola Rencana Darurat (if-then)
- Tujuan: pengguna menulis respons otomatis untuk pemicu craving yang ia kenali.
- Deskripsi: daftar rencana tersimpan (maks 3) dengan aksi tambah, ubah, hapus; setiap rencana berisi satu baris "Jika …" (situasi/pemicu) dan satu baris "Maka …" (tindakan konkret).
- Data masukan:
  - `jika` (teks bebas, wajib): situasi pemicu, mis. "habis makan", "bangun tidur", "stres di kantor".
  - `maka` (teks bebas, wajib): tindakan, mis. "langsung sikat gigi", "jalan 5 menit", "tarik napas 4-7-8".
- Proses:
  1. Pengguna membuka layar kelola rencana.
  2. Menekan "Tambah rencana" (nonaktif bila sudah 3 rencana).
  3. Mengisi `jika` dan `maka`, menekan Simpan.
  4. Rencana tersimpan ke tabel `rencana_darurat`; daftar diperbarui.
  5. Pengguna dapat mengetuk rencana untuk mengubah, atau menghapus (dengan konfirmasi).
- Aturan bisnis:
  - Maksimal 3 rencana aktif tersimpan; saat sudah 3, tombol tambah dinonaktifkan dengan penjelasan.
  - `jika` dan `maka` di-trim; tidak boleh kosong atau hanya spasi.
  - Panjang maksimal masing-masing kolom: 150 karakter (konsisten dengan teks ruang terbatas pada kartu).
  - Urutan tampil: berdasarkan `dibuat` ascending (rencana lama di atas).
  - Tidak ada duplikasi: dua rencana dengan `jika` identik (setelah trim, case-insensitive) ditolak dengan pesan.
  - Penghapusan bersifat permanen (tidak ada arsip/undo) dengan dialog konfirmasi destruktif.
- Validasi:
  - `jika.trim().isNotEmpty` dan `maka.trim().isNotEmpty` wajib.
  - Panjang `jika` dan `maka` ≤ 150 karakter; melebihi → pesan error di field.
  - Jumlah rencana < 3 saat menambah.
  - Duplikasi `jika` → pesan "Rencana untuk situasi ini sudah ada".
- Kondisi berhasil: rencana tersimpan/terubah/terhapus → toast sukses + daftar ter-refresh + kartu SOS ikut menampilkan data terbaru.
- Kondisi gagal: penyimpanan di DB gagal → toast gagal (pola yang dipakai layar lain), masukan pengguna tidak hilang dari form.
- Respons sistem: identik dengan pola CRUD `AlasanBerhentiNotifier` (keepAlive, `_ambilSemua` di `build()`, state setelah operasi DB berhasil).
- Kriteria penerimaan:
  - Pengguna dapat menambah rencana ke-1/2/3 dan tombol tambah nonaktif setelahnya.
  - Mengosongkan `jika` atau `maka` diblokir validasi form.
  - Rencana ke-4 ditolak.
  - `jika` duplikat ditolak.
  - Hapus menampilkan dialog konfirmasi; setelahnya baris terhapus dari DB.

### 7.2 Kartu "Rencana Darurat Saya" di SOS Craving

- Nama fitur: Kartu rencana di SOS
- Tujuan: rencana terlihat tepat saat pengguna paling membutuhkannya (menjelang/dalam craving).
- Deskripsi: kartu ringkas di layar SOS Craving yang menampilkan daftar if-then plans tersimpan (maks 3 baris ringkas: "Jika X → Maka Y"), dengan aksi "Kelola" untuk membuka layar kelola rencana.
- Data masukan: tidak ada input langsung di kartu; hanya tap "Kelola".
- Proses:
  1. SOS screen dibuka → kartu membaca provider rencana (`ref.watch`).
  2. Bila kosong → tampilkan empty state singkat: ikon + "Belum ada rencana darurat" + CTA "Buat rencana".
  3. Bila terisi → tampilkan daftar ringkas + CTA "Kelola".
- Aturan bisnis:
  - Kartu tidak men-trigger teknik SOS otomatis; hanya menampilkan teks rencana.
  - Teks rencana panjang ditangani dengan overflow yang benar (tidak merusak layout ≤320 dp).
  - Kartu konsisten dengan kartu lain di SOS (alasan berhenti): Card + Padding + Column spacing.
  - Posisi kartu: terpisah, di bawah kartu "Ingat alasanmu" (diputuskan 2026-11-10).
- Validasi: tidak ada input teks.
- Kondisi berhasil: kartu menampilkan rencana terbaru tanpa perlu restart aplikasi.
- Kondisi gagal: provider error → kartu menampilkan pesan gagal + retry (pola `penanganan-async-data-kosong`); teknik SOS lain tetap berfungsi.
- Respons sistem: navigasi ke layar kelola memakai `unawaited(Nav.to(...).catchError(...))` sesuai pola proyek.
- Kriteria penerimaan:
  - Setelah menyimpan rencana dari layar kelola, kartu SOS menampilkan rencana tersebut tanpa hot restart.
  - Kondisi kosong menampilkan empty state dengan CTA.
  - Tidak ada overflow pada lebar ≤320 dp dengan skala teks besar.

### 7.3 Layar Kelola Rencana

- Nama fitur: Layar Rencana Darurat
- Tujuan: satu tempat untuk melihat dan mengelola semua rencana if-then.
- Deskripsi: layar daftar (ListView) berisi kartu rencana; tombol tambah (FAB atau aksi AppBar); empty state bila belum ada; setiap item punya aksi ubah/hapus.
- Data masukan: tap item → form ubah; tap tambah → form tambah; konfirmasi hapus.
- Proses: sama dengan 7.1; layar adalah shell UI-nya.
- Aturan bisnis: form memakai `Form` + `GlobalKey` + `validate()` sebelum simpan; tombol simpan nonaktif saat tidak valid/selama submit (flag `_sedangMemproses`).
- Validasi: lihat 7.1.
- Kondisi berhasil: daftar ter-render setelah simpan/hapus; kembali ke SOS menampilkan kartu terbaru.
- Kondisi gagal: lihat 7.1.
- Respons sistem: AppBar + body ListView/empty state; FAB "Tambah rencana" nonaktif saat sudah 3.
- Kriteria penerimaan:
  - Layar dapat dibuka hanya dari kartu SOS (diputuskan 2026-11-10); tidak ada entry di menu Lainnya.
  - Semua aksi CRUD berfungsi dan tercermin di kartu SOS.

### 7.4 Sinkron ke Cadangan + perbaikan B1 (Should Have — diputuskan 2026-11-10)

- Nama fitur: Ekspor/pemulihan `rencana_darurat` + penyisiran payload cadangan (B1)
- Tujuan: rencana pengguna tidak hilang saat ganti perangkat / reinstall; sekaligus memperbaiki bug ekspor yang membuat `konsumsi_rokok` dan `sos_intervensi` tidak diekspor.
- Deskripsi: tambahkan `rencana_darurat` ke `tabelCadangan` dan payload ekspor (`buatCadanganJson`) pada `cadangan_helper.dart`; sekaligus tulis `konsumsiRokok` dan `sosIntervensi` ke payload yang sama (B1, `refrensi_apk.md:185-189`); pemulihan mengikuti pola tabel lain (restore payload → tabel).
- Aturan bisnis: jalur pemulihan tunggal mengikuti pola tabel lain — jangan jalur baru; berkas cadangan lama (tanpa `rencana_darurat`) harus tetap terbaca valid (tabel kosong dianggap wajar, konsisten dengan validasi cadangan saat ini).
- Validasi: payload wajib memuat 7 kunci tabel (biodata, impian, diary_craving, alasan_berhenti, konsumsi_rokok, sos_intervensi, rencana_darurat) setelah perbaikan; berkas cadangan lama dengan 4 kunci tetap dapat dipulihkan (kunci hilang diabaikan/dianggap kosong sesuai validasi yang berlaku).
- Kondisi berhasil: cadangan berisi `rencana_darurat` (serta `konsumsi_rokok` dan `sos_intervensi`); pemulihan mengembalikan baris identik.
- Kondisi gagal: gagal baca/tulis → mengikuti perilaku cadangan yang sudah ada (berkas parsial dihapus, toast gagal).
- Respons sistem: mengikuti alur `CadanganScreen` yang sudah ada.
- Kriteria penerimaan: berkas cadangan berisi kunci `rencana_darurat`, `konsumsi_rokok`, `sos_intervensi`; pemulihan mengembalikan baris yang sama; cadangan lama tetap bisa dipulihkan.

## 8. Alur Pengguna

1. Pengguna membuka SOS Craving (dari Dashboard/Lainnya).
2. Pengguna melihat kartu "Rencana Darurat Saya":
   - Kosong → tap "Buat rencana" → layar kelola → form tambah (pre-fill nama layar) → isi `jika`/`maka` → Simpan → kembali ke SOS, kartu terisi.
   - Terisi → membaca rencana saat craving; bisa tap "Kelola" untuk ubah/hapus.
3. Saat craving datang, pengguna membuka SOS, membaca rencananya sendiri, lalu memilih teknik SOS lain (di luar ruang lingkup PRD ini).
4. Percabangan: penyimpanan gagal → toast gagal, form tetap terisi; DB tidak bisa dibuka → kartu error + retry, teknik SOS lain tetap jalan.
5. Kondisi akhir: rencana if-then tersedia offline dan terlihat di momen craving.

## 9. Persyaratan UI/UX

- Bahasa Indonesia seluruh teks UI; gaya bahasa suportif, bukan medis/menghakimi.
- Kartu SOS memakai pola kartu yang sudah ada di `sos_craving_screen.dart` (Card + Padding(12) + Column spacing 8, ikon berwarna primary).
- Empty state kartu: ikon `Icons.event_note_outlined` (usulan) + judul "Belum ada rencana darurat" + CTA "Buat rencana".
- Layar kelola: AppBar "Rencana Darurat", ListView kartu rencana, FAB "Tambah rencana" (nonaktif + tooltip saat sudah 3).
- Form: dua `TextFormField` (label "Jika …" dengan hint "mis. habis makan", label "Maka …" dengan hint "mis. sikat gigi"), `Form` + `GlobalKey`, keyboard teks, `maxLength` 150.
- Dialog hapus: konfirmasi destruktif (`isDestructiveAction` bila tersedia via adaptive_dialog pola proyek) dengan teks "Hapus rencana?".
- Kontras/typography mengikuti `Theme.of(context).textTheme`; `WithValues(alpha:)` untuk opacity; angka tidak perlu tabular figures (bukan timer).
- Posisi kartu di SOS: terpisah, di bawah kartu "Ingat alasanmu" (diputuskan 2026-11-10).
- Tidak ada grafik; tidak ada navigasi baru yang membingungkan — maksimum 1 level push dari SOS.

## 10. Ringkasan Kode Contoh Singkat

- Nama fitur: Kelola Rencana Darurat
- Bahasa pemrograman: Dart
- Tujuan kode: menggambarkan aturan batas 3 rencana + validasi duplikat yang harus dijaga notifier, dan validasi murni untuk form.

```dart
bool rencanaValid(String jika, String maka) {
  final j = jika.trim();
  final m = maka.trim();
  return j.isNotEmpty && m.isNotEmpty && j.length <= 150 && m.length <= 150;
}
```

```dart
Future<void> tambahRencana(RencanaDarurat r) async {
  final ada = _ambilSemua(); // state saat ini
  if (ada.length >= 3) {
    throw const RencanaPenuhException(); // class implements Exception
  }
  if (ada.any((e) => e.jika.trim().toLowerCase() == r.jika.trim().toLowerCase())) {
    throw const RencanaDuplikatException();
  }
  // ... insert ke DB lalu refresh state
}
```

**Penjelasan:** kode pertama adalah validasi murni (dipakai form validator & notifier). Kode kedua menggambarkan penjagaan batas 3 rencana dan duplikat `jika` di notifier; exception khusus dipakai agar UI bisa membedakan penyebab gagal tanpa string matching.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

## 11. Hak Akses Pengguna

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| Pengguna aplikasi (satu jenis) | Buat/lihat/ubah/hapus rencana miliknya sendiri, offline | Tidak ada akun/sinkronisasi; data hanya di perangkat ini |

## 12. Persyaratan Data

- Jenis data: teks lokal (if-then plans).
- Tabel baru `rencana_darurat` (dibuat pada migrasi versi 11 → 12):
  - `id` TEXT PRIMARY KEY
  - `jika` TEXT NOT NULL
  - `maka` TEXT NOT NULL
  - `dibuat` TEXT NOT NULL (UTC, ISO-8601 — pola proyek)
- Tidak ada kolom intensitas/tanggal craving; rencana bersifat prospektif, bukan log.
- Hubungan: tidak ada FK keras; rencana berdiri sendiri (dapat dibaca dari kartu SOS dan layar kelola).
- Aturan tambah/baca/ubah/hapus: insert saat tambah; update kolom `jika`/`maka` saat ubah; delete permanen saat hapus; read all untuk daftar/kartu.
- Validasi & integritas: `jika`/`maka` NOT NULL; batas 3 baris ditegakkan di notifier (bukan constraint DB) agar pesan error dapat ditampilkan.
- Kebutuhan sinkronisasi: tidak ada sinkronisasi jaringan; cadangan lokal (bagian 7.4) wajib disertakan (diputuskan 2026-11-10).
- Integritas cadangan: `rencana_darurat` disertakan pada ekspor/pemulihan; tabel kosong dianggap wajar (ditangani oleh validasi yang sama dengan tabel cadangan lain — lihat B1 `refrensi_apk.md:185-189`).

## 13. Persyaratan Nonfungsional

- Performa: daftar ≤3 baris — tidak ada kebutuhan lazy list kompleks; build kartu harus ringan.
- Keamanan: tidak ada data sensitif yang dikirim keluar; tidak ada izin baru; tidak ada logging isi rencana ke console selain logging pola proyek (`L.i` tanpa menulis konten bebas pengguna — cukup log panjang/jumlah).
- Privasi: seluruh data di perangkat; `rencana_darurat` disertakan pada cadangan atas persetujuan pengguna (item 7.4 diputuskan 2026-11-10); cadangan hanya dibagikan oleh pengguna sendiri.
- Keandalan: gagal simpan tidak merusak data lama; migrasi skema diuji pada DB versi 11 yang sudah ada (onUpgrade `oldVersion < 12`).
- Kompatibilitas: Android API minimum sesuai aplikasi; tidak ada API platform baru.
- Kemudahan pemeliharaan: mengikuti struktur `lib/fitur/<fitur>/{model,state,notifier,screens,widgets}` + Freezed + Riverpod generator + `build_runner`; file `.g.dart`/`.freezed.dart` tidak diedit manual.

## 14. Kriteria Penerimaan

1. Pengguna dapat membuat rencana if-then dengan `jika` dan `maka` terisi; rencana tersimpan dan muncul di layar kelola.
2. Tombol tambah nonaktif saat 3 rencana tersimpan; pembuatan rencana ke-4 ditolak dengan pesan jelas.
3. `jika`/`maka` kosong/spasi-only ditolak validasi form; `if` duplikat (trim, case-insensitive) ditolak.
4. Pengguna dapat mengubah dan menghapus rencana; hapus meminta konfirmasi; perubahan terlihat di kartu SOS tanpa restart.
5. Kartu SOS menampilkan empty state + CTA saat belum ada rencana, dan daftar rencana saat terisi; tidak ada overflow pada lebar ≤320 dp dengan teks besar (diperiksa manual).
6. `dart analyze` tanpa error baru; tidak ada warning overflow.
7. Data rencana tersimpan di `rencana_darurat`; DB versi naik ke 12; instalasi lama (versi 11) termigrasi tanpa kehilangan data (`onUpgrade` membuat tabel baru saja).
8. Semua aksi berjalan offline; tidak ada izin baru di AndroidManifest/Info.plist.
9. Cadangan JSON berisi `rencana_darurat`, `konsumsi_rokok`, dan `sos_intervensi` (B1 diperbaiki sekaligus — diputuskan 2026-11-10); pemulihan mengembalikan isinya; cadangan lama (4 kunci) tetap bisa dipulihkan.
10. Tidak ada kode Dart yang diubah di luar berkas pada bagian 20 tanpa keputusan eksplisit.

## 15. Prioritas Pengembangan

- Must Have: kelola rencana if-then (7.1), kartu SOS (7.2), migrasi tabel (bagian 12), layar kelola (7.3, digabung dengan 7.1).
- Should Have: sinkron cadangan + penyisiran B1 (7.4) — diputuskan 2026-11-10: diperbaiki sekaligus untuk v1.
- Won't Have: AI draft rencana, notifikasi berbasis rencana, integrasi otomatis dengan teknik SOS, ekspor CSV, template contoh bawaan (diputuskan 2026-11-10), entry menu Lainnya (diputuskan 2026-11-10), tampilan di Dashboard (belum disepakati).

## 16. Risiko dan Ketergantungan

- **Overlap dengan PRD SOS yang sedang dikerjakan** (`prd/sos_craving_tool_tambahan.md`, status Sedang/Final-implementasi): kedua PRD menyentuh `lib/fitur/sos_craving/screens/sos_craving_screen.dart`. Mitigasi (diputuskan 2026-11-10): implementasi A10 menunggu PRD SOS ter-merge/selesai dikerjakan; tidak dikerjakan paralel.
- Risiko: kartu SOS menjadi padat (kartu alasan + kartu rencana + teknik) → mitigasi: kartu rencana ringkas; maksimal 3 baris teks satu baris per rencana; kartu tidak perlu collapsed (maks 3 baris).
- Risiko: pengguna menulis rencana yang tidak realistis/kontraproduktif → mitigasi: teks bantuan pada form ("pilih tindakan yang bisa langsung dilakukan"), bukan validasi konten (tidak boleh menghakimi).
- Risiko: duplikat konseptual ("habis makan" vs "setelah makan") — tidak ditolak karena bukan duplikat literal; diterima sebagai keterbatasan yang disengaja (bukan fuzzy matching).
- Risiko: migrasi skema gagal → mitigasi: `CREATE TABLE IF NOT EXISTS` di `onUpgrade`; tidak menyentuh tabel lama.
- Ketergantungan: pola `AlasanBerhenti` (model Freezed + notifier keepAlive), `sqflite.dart` (`_versiDatabase`, `_buatTabel`, `_onUpgrade`), `NamaTabel`, `NamaKolom`, `Nav.to`, `AppToast`/pola toast hasil intervensi, cadangan (`cadangan_helper.dart`, wajib), dan penyelesaian PRD SOS (file `sos_craving_screen.dart`).
- Semua asumsi sudah diverifikasi lewat diskusi 2026-11-10 (posisi kartu, entry point, cadangan, batas 3 × 150 karakter, urutan vs PRD SOS, tanpa template bawaan).

## 17. Rencana Pengembangan

| Tahap | Fitur | Target |
|---|---|---|
| 1 | Tabel `rencana_darurat` + migrasi versi 12 + konstanta `NamaTabel`/`NamaKolom` | Tahap pertama |
| 2 | Model Freezed + state + notifier (CRUD + batas 3 + duplikat) | Tahap pertama |
| 3 | Layar kelola (daftar + form + validasi) | Tahap kedua |
| 4 | Kartu SOS + empty state + integrasi `Nav.to` | Tahap kedua (setelah PRD SOS selesai — diputuskan 2026-11-10) |
| 5 | Sinkron cadangan + perbaikan B1 (`konsumsi_rokok`, `sos_intervensi`, `rencana_darurat` masuk payload ekspor & pemulihan) | Tahap ketiga (wajib untuk v1 — diputuskan 2026-11-10) |
| 6 | Audit overflow ≤320 dp + `dart analyze` + uji manual | Sebelum selesai |

## 18. Ketentuan Tambahan

Keputusan diskusi 2026-11-10 (final):

1. Penempatan kartu rencana di SOS: terpisah, di bawah kartu "Ingat alasanmu".
2. Entry point layar kelola: hanya dari kartu SOS (tanpa menu Lainnya).
3. `rencana_darurat` wajib ikut ekspor/pemulihan cadangan, diperbaiki sekaligus dengan B1 (`konsumsi_rokok` + `sos_intervensi` ikut diekspor; pemulihan cadangan lama tetap jalan).
4. Batas jumlah rencana: tetap 3 (sesuai `refrensi_apk.md:148`).
5. Panjang maksimal `jika`/`maka`: 150 karakter.
6. Template contoh rencana bawaan: tidak diperlukan.
7. Overlap dengan PRD SOS: implementasi A10 menunggu PRD SOS selesai dikerjakan/ter-merge; tidak paralel.

Ketentuan lain:
- Tidak ada perubahan logika bisnis/rumus/notifier yang sudah ada; hanya penambahan baru.
- Tidak ada dependency baru.
- Tidak ada izin baru.
- Bahasa Indonesia seluruh teks UI.
- Perubahan hanya pada file di bagian 20; berkas lain di luar daftar memerlukan keputusan eksplisit.

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| 2026-11-10 | Draf awal PRD dibuat dari `refrensi_apk.md` bagian A10 (baris 144–149) | Menunggu diskusi final dengan pengguna |
| 2026-11-10 | Referensi toko dibaca ulang: Pace Playbook (maks 6, "They sit on Today, travel in backups"), Flamy Emergency Setup (v11.5.1: if-then plans + alasan + frasa + shortcut SOS satu tempat), QuitNow Medicon (trigger management plans & coping cards), Craving To Quit (program 21 hari Yale, urge surfing — bukan if-then, dicatat sebagai referensi CBT terdekat) | Draft; belum final |
| 2026-11-10 | Keputusan diskusi: kartu terpisah di bawah kartu alasan; entry hanya dari SOS; cadangan wajib sertakan `rencana_darurat`; batas 3 rencana × 150 karakter; A10 menunggu PRD SOS selesai; tanpa template bawaan | Draft; belum final |
| 2026-11-10 | Keputusan lanjutan: perbaikan cadangan B1 (`konsumsi_rokok` + `sos_intervensi`) termasuk dalam v1/7.4, bukan ruang lingkup terpisah; PRD ditandai **Final** | Belum Diimplementasikan |

## 20. File-File Terdampak

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
|---|---|---|
| `lib/shared/konstanta/nama_tabel.dart` | Diubah | Tambah `static const String rencanaDarurat = 'rencana_darurat';` |
| `lib/shared/konstanta/nama_kolom.dart` | Diubah | Tambah `jika`, `maka` (kolom rencana); `id` dan `dibuat` dipakai ulang |
| `lib/shared/db/sqflite/sqflite.dart` | Diubah | `_versiDatabase` 11 → 12; `_buatTabel` tambah CREATE TABLE `rencana_darurat`; `_onUpgrade` tambah `oldVersion < 12` membuat tabel baru |
| `lib/fitur/rencana_darurat/model/rencana_darurat_model.dart` | Dibuat | Model Freezed `RencanaDarurat` (id, jika, maka, dibuat) + `fromSqflite`/`toSqflite` |
| `lib/fitur/rencana_darurat/model/rencana_darurat_model.freezed.dart` | Dibuat (generated) | Hasil `build_runner`; tidak diedit manual |
| `lib/fitur/rencana_darurat/state/rencana_darurat_state.dart` | Dibuat | State Freezed daftar rencana |
| `lib/fitur/rencana_darurat/state/rencana_darurat_state.freezed.dart` | Dibuat (generated) | Hasil `build_runner` |
| `lib/fitur/rencana_darurat/notifier/rencana_darurat_notifier.dart` | Dibuat | `RencanaDaruratNotifier` (keepAlive, build→_ambilSemua, tambah/ubah/hapus, batas 3, duplikat `jika`) |
| `lib/fitur/rencana_darurat/notifier/rencana_darurat_notifier.g.dart` | Dibuat (generated) | Hasil `build_runner` |
| `lib/fitur/rencana_darurat/screens/rencana_darurat_screen.dart` | Dibuat | Layar kelola (ListView + empty state + FAB) |
| `lib/fitur/rencana_darurat/screens/form_rencana_darurat.dart` | Dibuat | Form tambah/ubah (Form + GlobalKey + validasi + konfirmasi simpan pola proyek) |
| `lib/fitur/rencana_darurat/widgets/kartu_rencana_darurat.dart` | Dibuat | Widget kartu ringkas untuk disematkan di SOS (pure, terima data via parameter/provider) |
| `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Diubah | Sematkan `KartuRencanaDarurat` (posisi menunggu keputusan diskusi; file yang sama diubah PRD SOS — lihat bagian 16) |
| `lib/fitur/cadangan/helper/cadangan_helper.dart` | Diubah (wajib, diputuskan 2026-11-10) | Tambah `rencana_darurat`, `konsumsi_rokok`, `sos_intervensi` ke `tabelCadangan` + payload `buatCadanganJson()` (perbaikan B1 sekaligus) + pemulihan tabel baru |
| `lib/lainnya_screen.dart` | Tidak berubah | Diputuskan 2026-11-10: entry hanya dari kartu SOS |
| `prd/implementation_intention_craving.md` | Dibuat | Dokumen ini |
| `refrensi_apk.md` | Diubah (tandai) | Bagian A10 ditandai sudah dibuatkan PRD |

Catatan: daftar mengikuti keputusan diskusi; tidak ada kode Dart yang diubah pada tahap PRD ini.

## 21. Referensi dari refrensi_apk.md

Sumber: `refrensi_apk.md` di root proyek (baris dibaca 10–11 November 2026).

### 21.1 Referensi Fitur

- **`refrensi_apk.md:144-149` (A10. Implementation Intentions (Jika–Maka) untuk Craving)** — inti PRD ini. Dikutip:
  - Tujuan fitur: pengguna menulis rencana "jika craving saat X, maka saya lakukan Y"; dibuktikan menurunkan slip dalam studi kebiasaan.
  - Referensi: [Pace Android](https://github.com/ravipurohit1991/pace) (Playbook if-then plans) · [Flamy — SOS Emergency Setup](https://apps.apple.com/us/app/quit-smoking-smoke-free-flamy/id1462887052) · [Intervensi CBT Craving To Quit](https://play.google.com/store/apps/details?id=com.claritasmindsciences.CravingToQuit) · [QuitNow Medicon — 9 hari, 8 latihan CBT](https://apps.apple.com/us/app/quitnow-stop-smoking/id6768372199).
  - Saran sumber: layar kecil "Rencana Darurat Saya" (Jika …, Maka …) ditampilkan di kartu SOS; disimpan lokal; maks 3 rencana.
  - Prioritas sumber: Rendah.
- **Ringkasan pembacaan referensi (11 Nov 2026):**
  - **Pace Android (repo, dibaca README):** "A playbook decided in advance … If-then plans — *if it is 3pm and I am at my desk, then I refill my water and walk the long way back* — are one of the better-evidenced tricks in behaviour change: the plan fires on the cue instead of waiting for a decision in the minute least suited to making one. The **Playbook** keeps up to six. The coach drafts three at a time from your hardest stretch, situations and values; you keep the ones that sound like you or write your own. They sit on Today, travel in backups, and are handed to the coach." Menjadi dasar pola "plans hidup di layar utama + ikut cadangan"; angka maks di sumber adalah 6, tetapi sumber `refrensi_apk.md:148` menetapkan 3 — keputusan final lewat diskusi.
  - **Flamy (App Store, what's new v11.5.1):** "The new Emergency Setup helps you prepare for difficult moments by bringing your if-then plans, reasons, helpful phrases, and SOS shortcut together in one place … with 'Check your thoughts,' you can examine thoughts about smoking … save a personal phrase for difficult moments." Mengonfirmasi if-then plans sebagai bagian dari layar persiapan craving yang satu tempat dengan pintasan SOS. Flamy juga menyebut if-then plans sebagai bagian dari panduan pasca-slip (v11.4.0: "stronger if-then plans prepare you for difficult situations").
  - **Craving To Quit (Play Store):** program 21 hari berbasis Yale ("A clinical trial of this program delivered as a group-based in-person training over 4 weeks proved to be twice as effective as the gold standard treatment"); konten berbasis mindfulness/urge surfing — **bukan if-then**; dicatat sebagai referensi CBT/mindfulness terdekat, bukan pola langsung.
  - **QuitNow Medicon (App Store):** "EIGHT EXERCISES, DRAWN FROM CESSATION RESEARCH … • Coping cards — your emergency toolkit • Trigger management plans — for the predictable danger zones • 5-4-3-2-1 grounding …". Mengonfirmasi "trigger management plans" dan "coping cards" sebagai padanan if-then plans dalam program berbasis bukti; data tetap di perangkat ("Everything stays on your phone. We have no servers …"), selaras dengan offline-first proyek.
- **`refrensi_apk.md:29` (Ringkasan Temuan Terbesar)** — konteks: teknik berbasis bukti (napas, if-then, urge surfing) diprioritaskan di atas gimmick.
- **`refrensi_apk.md:51` (Kondisi Fitur Aktual)** — SOS sudah ada; `diary_craving` mencatat pemicu retrospektif. Rencana if-then mengisi celah prospektif.

### 21.2 Referensi UI/UX

- **`refrensi_apk.md:148`** — "layar kecil 'Rencana Darurat Saya' (Jika …, Maka …) ditampilkan di kartu SOS". Menjadi dasar kartu pada 7.2 dan empty state pada 9.
- Flamy Emergency Setup: satu layar persiapan yang menggabungkan plans + alasan + frasa + shortcut SOS — inspirasi struktural (tidak disalin; proyek sudah punya kartu alasan sendiri, plans disatukan sebagai kartu, bukan layar baru yang menggantikan SOS).
- Tidak ada referensi tampilan visual (screenshot) yang disalin; pola disimpulkan dari deskripsi toko/README.

### 21.3 Referensi Alur Pengguna

- **Pace Playbook:** plans tersimpan → sits on Today → tampil saat craving; diadopsi sebagai alur 8 (baca rencana → pilih teknik SOS).
- **Flamy Emergency Setup:** satu layar "prepare for difficult moments" sebelum craving; diadopsi sebagai dua pintu (kartu SOS ringkas + layar kelola).
- Tidak menambahkan tahapan yang tidak didukung referensi (tidak ada reminders otomatis, tidak ada coach).

### 21.4 Referensi Lainnya

- **`refrensi_apk.md:122-128` (A7. Mini-game Distraksi Offline)** — berdekatan (coping saat craving); **tidak termasuk** ruang lingkup PRD ini.
- **`refrensi_apk.md:130-135` (A8. AI Coach)** — draf rencana otomatis ala Pace/Quity **ditolak** untuk v1 (offline-first; tidak ada LLM di proyek).
- **`refrensi_apk.md:144-149` baris 149 (Prioritas Rendah)** — PRD ini tidak menaikkan/menurunkan prioritas tanpa keputusan pengguna.
- **`refrensi_apk.md:165-170` (A13. Pengingat 30 Menit Sebelum Jam Rawan)** — notifikasi berbasis pola adalah fitur terpisah; PRD ini tidak membuat notifikasi.
- **`refrensi_apk.md:185-189` (B1. Ekspor Cadangan)** — termasuk dalam v1 lewat 7.4 (diputuskan 2026-11-10: diperbaiki sekaligus dengan `rencana_darurat`; berkas cadangan lama tetap dapat dipulihkan).
- Catatan bukti: klaim "dibuktikan menurunkan slip dalam studi kebiasaan" berasal dari sumber `refrensi_apk.md:146`; PRD ini tidak menambahkan statistik spesifik agar tidak mengarang angka.
