# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Belum Diimplementasikan

---

## 1. Informasi Produk

**Informasi:**
- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter pendamping proses berhenti merokok yang membantu pengguna mencatat data pribadi, memantau progres *smoke-free*, mencatat dorongan merokok, mengelola impian, serta mengakses dukungan cepat saat muncul keinginan untuk merokok. Pendekatan *offline-first* dengan penyimpanan lokal (SQLite dan preferensi lokal).
- Platform: Android (APK); kode proyek juga mendukung web/desktop secara teknis, tetapi target riset dan pengembangan adalah Android.
- Versi: 1.0.0+1
- Status pengembangan: Internal / pra-rilis (belum dipublikasikan)

## 2. Latar Belakang

**Isi:**
Dashboard aplikasi Berhenti Merokok saat ini menampilkan **11 blok konten** dalam satu `ListView` (diperiksa pada `lib/fitur/dashboard/screens/dashboard_screen.dart`, 2026-11-10):

1. `_CounterSmokeFreeBesar` — counter *smoke-free* besar (`displayMedium`, "X hari Y jam").
2. Kartu "Lama berhenti merokok" — `_DurasiBerhenti` (timer 1 detik, `headlineMedium`) + "Sejak <tanggal>" + "Halo, <nama>" — **duplikasi metrik yang sama dengan counter poin 1**.
3. `_buildCardSosCraving()` — kartu CTA SOS (errorContainer), **ditambah** icon SOS terpisah di `AppBar` (aksi ganda untuk tujuan yang sama).
4. `_buildCardProgres` — dua blok besar: estimasi (hari/uang/rokok) dan aktual dari catatan, enam label `headlineSmall`.
5. `_buildCardKonsumsiHariIni` — konsumsi hari ini vs target (tapering).
6. `_buildCardTargetSmokeFree` — "Target Smoke-Free X dari N hari".
7. `_buildCardRingkasanImpian` — ringkasan impian.
8. `_buildCardAlasanBerhenti` — jumlah alasan berhenti.
9. `_buildCardMilestone` — milestone kesehatan berikutnya (navigasi ke `PemulihanKesehatanScreen`).
10. `_buildCardBadge` — pencapaian/badge.
11. `_buildInfoKerugian` — "Kerugian saat merokok" (rokok dihisap, uang terbuang, hidup hilang).

Masalah yang bertentangan dengan prinsip kompetitor (pola C1 pada `refrensi_apk.md:266-274`):

- **Dua widget menampilkan durasi yang sama** (counter `displayMedium` vs `_DurasiBerhenti` `headlineMedium`) — hierarki "satu metrik dominan" menjadi ambigu.
- **Aksi cepat SOS ganda** (icon `AppBar` + kartu full-width) — tidak perlu keduanya.
- **Tidak ada 3 kartu ringkasan sekunder dengan bobot seragam**; metrik penting (uang dihemat, rokok dihindari) tertimbun di dalam kartu progres yang sangat panjang, sementara milestone berdiri sebagai kartu terpisah.
- **Statistik aktual berdampingan dengan estimasi dalam blok yang sama** — halaman menjadi panjang dan lambat dipindai; statistik rinci tidak seharusnya dominan di Dashboard.
- **Kepadatan belum diaudit pada layar kecil** (lebar ≤320 dp / skala teks besar) — teks `displayMedium` seperti "120 hari 13 jam" berisiko overflow.

Pengguna baru/pemula tidak dapat memindai "kondisi sekarang" dalam <5 detik karena tidak ada urutan visual yang tegas: header status → ringkasan → aksi cepat → sisanya.

Fakta vs asumsi:
- **Fakta:** struktur 11 blok di atas saat ini ada di kode (diverifikasi membaca `dashboard_screen.dart`).
- **Fakta:** `fl_chart`/grafik **tidak** ada di Dashboard maupun `pubspec.yaml` saat ini.
- **Asumsi yang belum terverifikasi:** kepadatan secara visual di perangkat kecil — memerlukan pengujian di perangkat/emulator Android (tidak tersedia di lingkungan proyek saat PRD dibuat).

## 3. Tujuan Produk

**Isi:**
- Menetapkan **satu metrik dominan** yang tunggal dan konsisten di Dashboard: counter *smoke-free* besar sebagai satu-satunya elemen `displayMedium`.
- Menyusun ulang hierarki baca menjadi: **header status → 3 kartu ringkasan seragam → aksi cepat SOS → kondisi terkini (tapering) → sisanya dengan bobot rendah**, sehingga "kondisi sekarang" terbaca dalam <5 detik.
- Menjaga Dashboard **tidak bertambah padat**: setiap kartu yang ditambahkan harus diimbangi penggabungan/penghapusan kartu lain.
- Menjaga tindakan utama (SOS) selalu terlihat dan **tunggal** (hanya kartu, tanpa icon AppBar).

## 4. Target Pengguna

**Isi:**
Pengguna aplikasi Berhenti Merokok: perokok dewasa (khususnya Android di Indonesia) yang sedang/berencana berhenti, termasuk pengguna mode tapering. Kebutuhan mereka terhadap Dashboard:

- Sekali lirik mengetahui **apakah mereka masih *smoke-free* hari ini** (counter dominan).
- Melihat **3 angka pendukung** dengan bobot seragam: uang dihemat (estimasi), rokok dihindari (estimasi), dan milestone kesehatan berikutnya.
- Menemukan **aksi cepat SOS** tanpa berpikir; SOS penting saat craving muncul.
- Pengguna tapering membutuhkan **konsumsi hari ini vs target** yang mudah dilihat.

## 5. Ruang Lingkup

### Termasuk
- Penggabungan kartu "Lama berhenti merokok" ke dalam counter dominan (satu-satunya sumber durasi *smoke-free* di Dashboard): counter + "Sejak <tanggal>" + "Halo, <nama>".
- Penghapusan kartu progres estimasi/aktual (`_buildCardProgres`) sebagai kartu tersendiri; estimasi uang/rokok menjadi 2 dari 3 kartu ringkasan.
- **3 kartu ringkasan seragam** (bobot visual sama, jarak dan tipografi sama): 
  1. Uang dihemat (estimasi),
  2. Rokok tidak dihisap (estimasi),
  3. Milestone kesehatan berikutnya + sisa waktu (menggantikan `_buildCardMilestone` yang berdiri sendiri; tap → `PemulihanKesehatanScreen`).
- Data **aktual dari catatan** ditampilkan sebagai **satu baris caption kecil** di bawah 3 kartu ringkasan ("Dari catatan (N hari tercatat): RpX · Y batang") — bukan blok besar; bila catatan kosong atau gagal dimuat, baris caption tidak tampil atau menampilkan pesan singkat seperti sebelumnya.
- Penghapusan **icon SOS di `AppBar`**; kartu SOS full-width (errorContainer) dipertahankan sebagai satu-satunya aksi cepat SOS.
- Kartu "Kerugian saat merokok" **tetap** di Dashboard paling bawah dengan bobot visual rendah.
- Audit kepadatan/overflow pada layar kecil untuk teks `displayMedium` (mis. `FittedBox`/skala adaptif bila perlu).
- Penandaan `refrensi_apk.md` section C1 sebagai sudah dibuatkan PRD-nya.

### Tidak Termasuk
- **Tidak ada** perubahan logika bisnis, rumus perhitungan metrik (`MetrikBerhentiHelper`, `KonsumsiHitungHelper`, `ImpianProgresHelper`, `milestoneBerikutnya`), skema database, atau notifier.
- **Tidak ada** penambahan kartu baru di luar konsolidasi di atas.
- **Tidak ada** pemindahan kartu ke `lib/lainnya_screen.dart` (dikelola PRD `navigasi_dan_empty_state.md` yang berstatus Final) atau ke layar lain (`biodata`, `badge`, `impian`, `alasan_berhenti`, `pemulihan_kesehatan` — file terdampaknya dikelola PRD lain).
- **Tidak ada** pembuatan layar Analitik baru (refrensi_apk A5) — agar file terdampak tidak tumpang tindih dengan rencana A5 dan ruang lingkup tetap kecil; kebutuhan A5 dicatat sebagai risiko/ketergantungan.
- **Tidak ada** penambahan dependency grafik (`fl_chart`/`fl_heatmap`) di Dashboard (grafik tidak diletakkan di Dashboard).
- **Tidak ada** perubahan gaya CTA, navigasi pintasan (pola `unawaited(Nav.to(...).catchError(...))`), atau empty state lainnya.

## 6. Daftar Fitur

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| Counter dominan tunggal | Counter `displayMedium` menjadi satu-satunya elemen penampil durasi *smoke-free*; kartu "Lama berhenti merokok" dihapus; "Sejak <tanggal>" dan "Halo, <nama>" melebur ke header counter. | Must Have |
| 3 kartu ringkasan seragam | Uang dihemat (estimasi), Rokok tidak dihisap (estimasi), Milestone kesehatan berikutnya (tap → `PemulihanKesehatanScreen`); bobot visual/tipografi seragam. | Must Have |
| Aksi cepat SOS tunggal | Icon SOS di `AppBar` dihapus; kartu SOS (errorContainer) dipertahankan sebagai aksi cepat utama. | Must Have |
| Caption "Dari catatan" | Aktual dari catatan konsumsi ditampilkan satu baris caption di bawah ringkasan (bukan blok besar); hilang/pesan singkat bila data kosong atau error. | Should Have |
| Audit layar kecil | Teks counter dominan dan ringkasan diperiksa agar tidak overflow pada lebar ≤320 dp / skala teks besar. | Should Have |
| Kartu Kerugian berbobot rendah | Kartu "Kerugian saat merokok" tetap di posisi paling bawah tanpa gaya headline. | Should Have |
| Penanda referensi | Section C1 pada `refrensi_apk.md` ditandai sudah dibuatkan PRD-nya (isi sumber tidak dihapus). | Must Have |

## 7. Detail Persyaratan Fitur

### 7.1 Nama fitur: Counter dominan tunggal

- **Tujuan:** Satu metrik dominan yang langsung terbaca <5 detik.
- **Deskripsi:** Header Dashboard menampilkan `_CounterSmokeFreeBesar` sebagai satu-satunya elemen `displayMedium` ("X hari Y jam"), dengan teks pendukung satu baris: "Sejak <tanggal>" (bila tanggal mulai ada) dan "Halo, <nama>" (bila nama terisi). Kartu "Lama berhenti merokok" (`Card` berisi `_DurasiBerhenti` + teks sejak + halo) **dihapus**; widget `_DurasiBerhenti` yang berduplikasi fungsinya dengan counter juga dihapus bila sudah tidak dipakai.
- **Data masukan:** `biodata.tanggalMulaiBerhentiMerokok`, `biodata.hariBerhenti`, `biodata.nama` (sama seperti sumbernya sekarang).
- **Proses:** Buka Dashboard → `biodataAsync` sukses → header counter dirender → timer 1 detik hanya membangun widget counter (mekanisme timer terisolasi yang sudah ada dipertahankan).
- **Aturan bisnis:**
  - Hanya satu widget di Dashboard yang boleh memakai gaya `displayMedium`/`displaySmall` (counter). 
  - Durasi *smoke-free* ("X hari Y jam" / "hari jam menit detik") hanya boleh tampil dari satu sumber di Dashboard.
  - Bila `tanggalMulaiBerhentiMerokok == null`, teks counter menampilkan kondisi yang sudah didefinisikan (`hariBerhenti` dari ekstensi model tetap 0 dan jam sisa 0 — perilaku yang ada dipertahankan, bukan diubah).
- **Validasi:** Tidak ada dua widget dengan isi angka durasi yang sama pada layar; `grep`/review kode Dashboard tidak menemukan `_DurasiBerhenti` tersisa bila sudah tidak dipakai.
- **Kondisi berhasil:** Pengguna melihat counter besar + sejak + sapaan; tidak ada blok durasi kedua.
- **Kondisi gagal:** Duplikasi durasi masih tampil; counter bukan satu-satunya `displayMedium`.
- **Respons sistem:** Header dirender; timer 1 detik berjalan tanpa membangun ulang seluruh halaman.
- **Kriteria penerimaan:**
  - Pada `dashboard_screen.dart` tidak ada lagi kartu "Lama berhenti merokok".
  - Hanya counter yang memakai `textTheme.displayMedium`.
  - Tidak ada regresi timer (hanya widget counter yang rebuild tiap detik).

### 7.2 Nama fitur: 3 kartu ringkasan seragam

- **Tujuan:** Tiga angka pendukung dengan bobot seragam, menggantikan kartu progres estimasi/aktual yang panjang.
- **Deskripsi:** Di bawah header, tampilkan baris 3 kartu ringkasan (atau grid 3 kolom) dengan isi:
  1. **Uang dihemat (estimasi)** — `MetrikBerhentiHelper.hitungUangDihematEstimasi(biodata)`, format `FormatUang.formatRupiah`.
  2. **Rokok tidak dihisap (estimasi)** — `MetrikBerhentiHelper.hitungRokokTidakDiHisapEstimasi(biodata)`, format "<N> batang".
  3. **Milestone kesehatan berikutnya** — hasil `milestoneBerikutnya(aman)` (logika yang sudah ada), menampilkan judul milestone + "Tersisa <durasi>"; bila semua tercapai, tampilkan "Semua milestone tercapai"; kartu ini **tappable** → `PemulihanKesehatanScreen` dengan pola `unawaited(Nav.to(...).catchError(...))` yang sudah dipakai.
- **Data masukan:** `biodata` (+ `DateTime.now()` untuk sisa waktu milestone, sama seperti `_buildCardMilestone` sekarang).
- **Proses:** Hitung estimasi → render 3 kartu → tap kartu milestone → navigasi ke Pemulihan Kesehatan.
- **Aturan bisnis:**
  - Ketiga kartu memakai gaya judul dan nilai yang **seragam** (mis. judul `titleSmall`/`titleMedium` bold, nilai `headlineSmall` bold) — bukan satu kartu dominan dan dua kartu kecil.
  - Estimasi wajib berlabel "(estimasi)"; angka aktual tidak masuk ke kartu ringkasan (masuk caption, lihat 7.4).
  - `_buildCardProgres` dan `_buildCardMilestone` dihapus sebagai blok terpisah; isinya terwakili oleh kartu ringkasan ini + caption.
  - Rumus perhitungan **tidak diubah**.
- **Validasi:** Tiga kartu ringkasan ada, bobot visual seragam (diverifikasi review + pengujian manual); tidak ada lagi blok "Lama berhenti (estimasi)"/"Uang dihemat (estimasi)"/"Rokok tidak dihisap (estimasi)" sebagai bagian dari kartu progres lama.
- **Kondisi berhasil:** Pengguna melihat 3 angka ringkasan tanpa scroll pada layar normal.
- **Kondisi gagal:** Satu kartu tampak jauh lebih dominan; angka aktual tanpa label menyesatkan (terbaca seolah uang sungguhan tertabung).
- **Respons sistem:** 3 kartu dirender; tap milestone membuka layar Pemulihan Kesehatan.
- **Kriteria penerimaan:**
  - Terdapat tepat 3 kartu ringkasan dengan struktur seragam.
  - Setiap angka estimasi memuat kata "estimasi".
  - Tap kartu milestone membuka `PemulihanKesehatanScreen`.

### 7.3 Nama fitur: Aksi cepat SOS tunggal

- **Tujuan:** Tindakan kritis selalu terlihat tanpa duplikasi.
- **Deskripsi:** Icon SOS (`IconButton` di `AppBar.actions`) **dihapus**; kartu SOS (`_buildCardSosCraving`, warna `errorContainer`) dipertahankan sebagai satu-satunya representasi aksi cepat SOS, ditempatkan setelah 3 kartu ringkasan.
- **Data masukan:** Ketukan pengguna.
- **Proses:** Tap kartu → `Nav.to(context, const SosCravingScreen())` dalam `unawaited(...).catchError(...)` dengan `L.e` (pola yang sudah ada).
- **Aturan bisnis:**
  - Hanya satu CTA SOS yang berbentuk kartu full-width; tidak ada icon SOS lain di `AppBar`.
  - Perilaku navigasi dan teks kartu tidak berubah selain posisi setelah ringkasan.
- **Validasi:** `AppBar.actions` kosong atau hanya berisi aksi non-SOS bila ada di masa depan; tidak ada dua `SosCravingScreen` trigger pada satu layar.
- **Kondisi berhasil:** SOS tetap 1-ketuk dari Dashboard.
- **Kondisi gagal:** SOS hilang atau ganda.
- **Respons sistem:** Navigasi ke SOS Craving.
- **Kriteria penerimaan:** `AppBar` tidak memuat `IconButton` SOS; kartu SOS tampil setelah 3 kartu ringkasan.

### 7.4 Nama fitur: Caption "Dari catatan"

- **Tujuan:** Menampilkan progres aktual dari catatan konsumsi tanpa mendominasi layar.
- **Deskripsi:** Bila `konsumsiAsync` sukses dan ada catatan, tampilkan **satu baris caption** di bawah 3 kartu ringkasan: "Dari catatan (<N> hari tercatat): <Rp uang aktual> · <batang rokok aktual>" (atau format sejenis yang ringkas). Bila catatan kosong, tampilkan baris singkat "Belum ada catatan konsumsi — aktual tersedia setelah Anda mencatat." seperti sekarang (teks kecil, bukan headline). Bila error/loading, tampilkan pesan singkat bodySmall seperti sekarang.
- **Data masukan:** `konsumsiAsync` (`AsyncValue<KonsumsiRokokState>`), `MetrikBerhentiHelper.hitungJumlahHariTercatat`, `hitungRokokDihindariAktual`, `hitungUangDihematAktual`.
- **Proses:** Catatan berhasil dimuat → caption dirender; loading/error/kosong → caption menampilkan status yang sesuai.
- **Aturan bisnis:**
  - Aktual **wajib** berlabel "dari catatan" agar tidak rancu dengan estimasi.
  - Caption maksimal 1–2 baris; bukan `headlineSmall`; tanpa blok `Divider()` besar.
  - Perhitungan tidak berubah; bila gagal hitung, tampilkan status singkat, bukan exception.
- **Validasi:** Tidak ada `headlineSmall` baru untuk angka aktual; penanganan loading/error/kosong tetap ada.
- **Kondisi berhasil:** Pengguna melihat ringkasan aktual singkat.
- **Kondisi gagal:** Caption menjadi blok besar lagi (mengulang kerusakan `_buildCardProgres`); error tidak tertangani.
- **Respons sistem:** Teks bodySmall dirender; tap (bila ada) tidak diperlukan — caption bukan navigasi.
- **Kriteria penerimaan:**
  - Tidak ada blok "Dari catatan" dengan gaya headline di Dashboard.
  - Loading/error/kosong catatan tetap tertangani tanpa exception.

### 7.5 Nama fitur: Audit layar kecil

- **Tujuan:** Tidak ada overflow pada perangkat lebar ≤320 dp atau skala teks besar.
- **Deskripsi:** Periksa elemen berisiko overflow: counter `displayMedium` (mis. "120 hari 13 jam"), tag nominal uang besar (mis. "Rp10.000.000"), dan baris ringkasan 3 kolom. Gunakan `FittedBox`/`MediaQuery.textScaleFactor` secara terbatas atau `overflow: TextOverflow.ellipsis` sesuai pola tipografi yang berlaku di proyek.
- **Data masukan:** Ukuran layar / skala teks.
- **Proses:** Build dengan constraints sempit → amati overflow → perbaiki elemen yang meluap.
- **Aturan bisnis:** Perbaikan hanya pada widget Dashboard yang terdampak; jangan memaksa teks mengecil hingga tidak terbaca; jangan mengubah gaya `textTheme` global.
- **Validasi:** Tidak ada `RenderFlex overflowed` pada simulasi lebar 320 dp dan skala teks 1.3.
- **Kondisi berhasil:** Semua teks termuat tanpa overflow.
- **Kondisi gagal:** Kuning-hitam stripe overflow muncul pada layar sempit.
- **Respons sistem:** UI tetap rapi di layar sempit.
- **Kriteria penerimaan:** Review manual/uji widget menunjukkan tidak ada overflow pada skenario di atas.

### 7.6 Nama fitur: Kartu Kerugian berbobot rendah

- **Tujuan:** Informasi historis tetap tersedia tanpa menyaingi header/ringkasan.
- **Deskripsi:** Kartu "Kerugian saat merokok" dipertahankan di posisi paling bawah Dashboard, gaya `titleMedium` biasa (bukan headline besar), tanpa perubahan isi.
- **Data masukan:** Sama seperti sekarang.
- **Proses:** Tidak berubah; hanya posisi dipertahankan di bawah.
- **Aturan bisnis:** Tidak diubah rumusnya; tidak dinaikkan hierarkinya; tidak dipindah ke layar lain dalam ruang lingkup PRD ini.
- **Kriteria penerimaan:** Kartu tetap ada di paling bawah dengan gaya rendah.

## 8. Alur Pengguna

**Isi:**
1. Pengguna membuka aplikasi → tab Dashboard tampil.
2. Dalam <5 detik pengguna membaca: counter "X hari Y jam" (besar) + "Sejak <tanggal>" + "Halo, <nama>".
3. Pengguna memindai 3 kartu ringkasan seragam: uang dihemat (estimasi), rokok tidak dihisap (estimasi), milestone kesehatan berikutnya (+ sisa waktu).
4. Pengguna melihat caption singkat "Dari catatan (N hari tercatat): RpX · Y batang" bila ada catatan.
5. Pengguna melihat kartu SOS (aksi cepat) → mengetuknya saat craving → `SosCravingScreen` terbuka.
6. Pengguna tapering melihat kartu "Konsumsi Hari Ini X / Y batang" dengan progress bar dan warna kondisional (hijau/oranye) — perilaku yang sudah ada dipertahankan.
7. Pengguna melihat kartu Target Smoke-Free — perilaku yang sudah ada dipertahankan.
8. Pengguna men-scroll ke bawah: ringkasan Impian, pintasan Alasan Berhenti, Pencapaian (badge) — perilaku yang sudah ada dipertahankan.
9. Pengguna menampilkan bagian paling bawah: kartu "Kerugian saat merokok".
10. Kondisi akhir: tidak ada durasi duplikat, tidak ada aksi SOS ganda, hierarki satu metrik dominan + 3 ringkasan + aksi cepat.

Percabangan:
- Bila `biodata == null` → layar "Belum ada data biodata" + CTA "Isi Biodata" (perilaku yang sudah ada dipertahankan).
- Bila `biodataAsync` error → pesan gagal + "Coba lagi" (dipertahankan).
- Bila milestone semua tercapai → kartu ringkasan #3 menampilkan "Semua milestone tercapai".
- Bila catatan konsumsi kosong/error → caption menampilkan pesan singkat (bukan exception).

## 9. Persyaratan UI/UX

**Isi:**
- Urutan layout Dashboard (atas → bawah):
  1. Header status: counter `displayMedium` (satu-satunya) + caption "Sejak <tanggal>" (bodySmall) + "Halo, <nama>" (bodyMedium).
  2. Ringkasan: 3 kartu ringkasan seragam dalam satu baris/`Row` (`spacing` seragam, atau grid bila layar sempit) — judul `titleSmall`/`titleMedium` bold, nilai `headlineSmall` bold, label "(estimasi)" eksplisit.
  3. Caption "Dari catatan" (bodySmall, satu baris).
  4. Aksi cepat: kartu SOS (`errorContainer`, `onErrorContainer`) full-width.
  5. Kondisi terkini: kartu "Konsumsi Hari Ini" (tapering: progress bar + warna kondisional `0xFF4CAF50`/`0xFFFF9800` — warna semantik dipertahankan seperti sekarang).
  6. Target Smoke-Free (`headlineSmall` untuk teks progres — dipertahankan karena satu-satunya kartu target).
  7. Pintasan/lainnya (bobot seragam, `ListTile`-style): Ringkasan Impian, Alasan Berhenti, Pencapaian.
  8. Kerugian saat merokok (paling bawah, bobot rendah).
- Spacing antar blok mengikuti properti `spacing` pada `Column`/`Row` (bukan `SizedBox` berulang) sesuai skill `spacing`.
- Warna dari `ColorScheme`/`textTheme`; warna hardcode hanya untuk status semantik (hijau/oranye progres tapering) dan `errorContainer` untuk SOS — keduanya sudah menjadi pola proyek.
- `AppBar`: judul "Dashboard", `scrolledUnderElevation: 2`; **tanpa** icon SOS; `actions` kosong.
- Aksesibilitas: counter dan ringkasan memakai teks yang terbaca screen reader; kartu milestone memiliki label tap yang jelas; CTA SOS memiliki label teks (bukan hanya ikon).
- Tidak ada grafik/chart di Dashboard.
- Tipe kartu "Target Smoke-Free" (`headlineSmall`) tidak melanggar aturan 7.1 karena bukan metrik durasi dan bukan `displayMedium`.

## 10. Ringkasan Kode Contoh Singkat

**Informasi:**
- Nama fitur: Konsolidasi counter + 3 kartu ringkasan
- Bahasa pemrograman: Dart (Flutter)
- Tujuan kode: Menggambarkan bentuk header counter yang melebur ("Sejak"/"Halo") dan baris 3 kartu ringkasan seragam.

**Contoh kode:**

```dart
// Header status: counter dominan + caption (bukan kartu terpisah)
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  spacing: 4,
  children: [
    const _CounterSmokeFreeBesar(biodata: biodata), // satu-satunya displayMedium
    if (tanggalBerhenti != null)
      Text('Sejak ${FormatTanggal.formatDasar(tanggalBerhenti)}',
          style: Theme.of(context).textTheme.bodySmall),
    if (nama.isNotEmpty)
      Text('Halo, $nama', style: Theme.of(context).textTheme.bodyMedium),
  ],
),
```

```dart
// Baris 3 kartu ringkasan seragam (lebar dibagi rata)
Row(
  spacing: 8,
  children: [
    Expanded(child: _KartuRingkasan(judul: 'Uang dihemat (estimasi)',
        nilai: FormatUang.formatRupiah(uangEstimasi))),
    Expanded(child: _KartuRingkasan(judul: 'Rokok dihindari (estimasi)',
        nilai: '$rokokEstimasi batang')),
    Expanded(child: _KartuRingkasanMilestone(berikutnya: milestoneBerikutnya(aman),
        aman: aman)), // tap → PemulihanKesehatanScreen
  ],
),
```

```dart
// Caption "Dari catatan" — bodySmall, bukan headline
if (adaCatatan)
  Text(
    'Dari catatan ($hariTercatat hari tercatat): '
    '${FormatUang.formatRupiah(uangAktual)} · $rokokAktual batang',
    style: Theme.of(context).textTheme.bodySmall,
  ),
```

**Penjelasan:**
Contoh pertama menggambarkan counter dominan tanpa kartu pendamping duplikat. Contoh kedua menunjukkan tiga kartu ringkasan berbagi lebar secara merata dengan struktur seragam. Contoh ketiga menunjukkan aktual dari catatan sebagai caption satu baris ber-bodySmall.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi. Nama widget (`_KartuRingkasan`, dst.) hanya contoh; implementasi bebas memilih nama sesuai konvensi proyek.

## 11. Hak Akses Pengguna

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| Pengguna aplikasi (satu-satunya peran) | Melihat seluruh konten Dashboard dan mengetuk kartu milestone/pintasan/SOS | Tidak ada batasan peran; tidak ada konten berbayar/terkunci dalam ruang lingkup PRD ini |

Aplikasi hanya memiliki satu jenis pengguna tanpa pembatasan akses khusus.

## 12. Persyaratan Data

**Informasi yang perlu dijelaskan:**
- Jenis data: tidak ada data baru. Seluruh angka (estimasi/aktual/milestone) berasal dari `biodata` dan `konsumsiAsync` yang sudah ada.
- Data yang harus disimpan: tidak ada.
- Hubungan antar-data: tidak ada yang berubah.
- Aturan tambah/baca/ubah/hapus: tidak berubah; Dashboard hanya membaca.
- Validasi dan integritas: tidak ada perubahan; milestone dihitung dari `DateTime.now().difference(tanggalBerhenti)` dengan normalisasi yang sudah ada.
- Kebutuhan sinkronisasi: tidak ada; aplikasi *offline-first* dengan penyimpanan lokal.

## 13. Persyaratan Nonfungsional

- **Performa:** Tidak menambah jumlah *build*; timer tetap terisolasi di widget counter; kartu ringkasan memakai data yang sudah dihitung sekali per *build*; `ListView` tidak diubah menjadi `Column` statis tanpa `ListView` (gulir tetap diperlukan).
- **Keandalan:** Error `konsumsiAsync`/`impianAsync`/`alasanBerhentiAsync` tetap tertangani dengan pesan singkat; tidak boleh `requireValue` pada data opsional (pola `asData?.value` dipertahankan); tidak ada `SizedBox.shrink` untuk kondisi error tanpa keterangan.
- **Kompatibilitas:** Berjalan pada target Android proyek; tidak bergantung API khusus platform; aman pada lebar ≤320 dp (setelah audit 7.5).
- **Kemudahan pemeliharaan:** Penghapusan blok lama (`_buildCardProgres`, kartu "Lama berhenti merokok", `_buildCardMilestone` terpisah) mengurangi duplikasi; bila perlu, pemecahan widget baru mengikuti `widget-custom` (StatelessWidget, pure, theme-safe).
- **Privasi:** Tidak ada data baru yang ditampilkan di luar yang sudah ada; counter/kartu ringkasan tidak menampilkan nama selain yang sudah ditampilkan ("Halo, <nama>" sudah ada).
- **Aksesibilitas dasar:** Semua tindakan punya label; kontras mengikuti `ColorScheme`.

## 14. Kriteria Penerimaan

**Isi:**
1. Dashboard tidak lagi menampilkan kartu "Lama berhenti merokok"; `_DurasiBerhenti` dihapus bila sudah tidak terpakai.
2. Hanya satu widget memakai `textTheme.displayMedium` di Dashboard (counter).
3. Tepat 3 kartu ringkasan dengan bobot seragam tampil: uang dihemat (estimasi), rokok tidak dihisap (estimasi), milestone berikutnya (tappable → `PemulihanKesehatanScreen`).
4. Tidak ada blok "Dari catatan"/aktual dengan `headlineSmall`; caption aktual tampil bodySmall atau pesan singkat pada kondisi loading/error/kosong.
5. `AppBar` Dashboard tidak memuat aksi SOS; kartu SOS full-width tampil setelah ringkasan.
6. Kartu "Kerugian saat merokok" berada di posisi paling bawah dengan gaya bobot rendah.
7. Jumlah kartu/blok Dashboard **tidak bertambah** dibanding sebelum perubahan (konsolidasi murni; tidak ada kartu baru).
8. Tidak ada grafik/chart di Dashboard; tidak ada dependency baru di `pubspec.yaml`.
9. Tidak ada perubahan skema database, notifier, atau rumus perhitungan metrik.
10. Tidak ada overflow pada simulasi lebar 320 dp / skala teks besar (diaudit manual).
11. `dart analyze` tidak menghasilkan error baru pada file yang diubah.

## 15. Prioritas Pengembangan

- **Must Have:** Konsolidasi counter (7.1); 3 kartu ringkasan seragam (7.2); SOS tunggal (7.3); penanda C1 di `refrensi_apk.md`.
- **Should Have:** Caption "Dari catatan" (7.4); audit layar kecil (7.5); Kerugian berbobot rendah (7.6).
- **Could Have:** — (tidak ada).
- **Won't Have:** Layar Analitik baru (A5); widget Android (A1); quick log/undo (C2); perubahan navigasi/`lainnya_screen.dart`; penambahan kartu baru.

## 16. Risiko dan Ketergantungan

**Isi:**
- **Risiko adopsi pengguna lama:** metrik "Lama berhenti merokok" sebagai kartu hilang; mitigasi dengan melebur isinya ke header counter (bukan menghapus informasi).
- **Risiko "aktual hilang":** pengguna yang terbiasa melihat angka uang/rokok besar mungkin menganggap hilang; mitigasi: caption "Dari catatan" tetap ada (7.4).
- **Risiko regresi navigasi milestone:** kartu milestone pindah menjadi ringkasan; mitigasi: perilaku tap → `PemulihanKesehatanScreen` dipreservasi (7.2).
- **Risiko overflow:** counter `displayMedium` pada "1200 hari 5 jam"; mitigasi: audit 7.5.
- **Ketergantungan:** `MetrikBerhentiHelper`, `KonsumsiHitungHelper`, `ImpianProgresHelper`, `milestoneBerikutnya` (`shared/konstanta/milestone_kesehatan.dart`), pola `Nav.to` + `unawaited` dari `share_global_saya`, skill proyek (`spacing`, `tipografi`, `kartu-motivasi-pintasan-dashboard`, `pola-ux`, `penanganan-async-data-kosong`).
- **Ketergantungan opsional di luar ruang lingkup:** layar Analitik (A5) bila suatu saat dibuat — untuk Memindahkan statistik rinci & grafik; PRD ini sengaja tidak mencakupnya.
- **Asumsi yang belum terverifikasi:** kepadatan visual di perangkat kecil (tidak ada emulator/perangkat fisik di lingkungan proyek); perlu pengujian manual di Android.
- **Batasan:** PRD lain `navigasi_dan_empty_state.md` (Final, Sedang Diimplementasikan) mencakup `lainnya_screen.dart` dan layar-layar target pintasan; PRD ini tidak boleh mengubah file-file tersebut.

## 17. Rencana Pengembangan

| Tahap | Fitur | Target |
|---|---|---|
| Tahap 1 | Konsolidasi counter + hapus kartu durasi duplikat (7.1, 7.3) | Setelah PRD final |
| Tahap 2 | 3 kartu ringkasan seragam + hapus kartu progres/milestone lama (7.2) | Setelah Tahap 1 |
| Tahap 3 | Caption "Dari catatan" + audit layar kecil + perapihan posisi Kerugian (7.4–7.6) | Setelah Tahap 2 |
| Tahap 4 | Verifikasi: `dart analyze`, checklist kriteria penerimaan, penanda C1 di `refrensi_apk.md` | Setelah Tahap 3 |

## 18. Ketentuan Tambahan

**Isi:**
- PRD ini tidak mengubah logika bisnis, perhitungan, penyimpanan, atau navigasi selain yang dijelaskan pada bagian 7.
- Keputusan diskusi 2026-11-10 (putaran 1):
  - Ruang lingkup: **pola C1 penuh** tanpa membuat layar Analitik (A5 tetap di luar scope).
  - Isi 3 kartu ringkasan: **rekomendasi AI**, yaitu uang dihemat (estimasi), rokok tidak dihisap (estimasi), milestone kesehatan berikutnya — selaras dengan pola C1 ("2–3 metrik sekunder: uang, rokok dihindari, milestone berikutnya").
  - Kartu "Kerugian saat merokok": **tetap** di paling bawah, bobot rendah.
  - Aksi cepat SOS: **kartu saja**; icon SOS di `AppBar` dihapus.
- Menandai C1 di `refrensi_apk.md` tidak menghapus isi sumber; hanya menambah baris penanda PRD.
- Contoh kode pada bagian 10 hanya ilustrasi; bukan ketentuan nama widget.
- Urutan kartu "Konsumsi Hari Ini", "Target Smoke-Free", "Ringkasan Impian", "Alasan Berhenti", "Pencapaian", "Kerugian" tidak berubah selain penyesuaian posisi akibat penghapusan kartu lama.

## 19. Riwayat Perubahan

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| 2026-11-10 | Draf awal PRD dibuat dari `refrensi_apk.md` section C1 | Sumber: `refrensi_apk.md:266-274` |
| 2026-11-10 | Keputusan diskusi putaran 1: pola C1 penuh tanpa Analitik; 3 kartu ringkasan = uang/rokok/milestone (rekomendasi); Kerugian tetap di bawah; SOS kartu saja (icon AppBar dihapus) | Empat pertanyaan diskusi dijawab pengguna |
| 2026-11-10 | PRD disetujui dan ditandai Final | Pengguna menyetujui finalisasi tanpa revisi tambahan |

## 20. File-File Terdampak

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
|---|---|---|
| `lib/fitur/dashboard/screens/dashboard_screen.dart` | Diubah | Hapus kartu "Lama berhenti merokok" (+ `_DurasiBerhenti` bila tak terpakai); hapus blok `_buildCardProgres` dan `_buildCardMilestone`; tambah header caption melebur (Sejak/Halo); tambah baris 3 kartu ringkasan seragam (uang/rokok/milestone tappable); tambah caption "Dari catatan"; hapus icon SOS di `AppBar`; pertahankan kartu SOS, Konsumsi Hari Ini, Target, Impian, Alasan, Badge, Kerugian (paling bawah); audit overflow layar kecil |
| `lib/fitur/dashboard/notifier/dashboard_notifier.dart` | Diubah (opsional) | Hanya bila pemecahan widget ringkasan memerlukan state baru; diharapkan **tidak berubah** (tidak ada logika baru) |
| `lib/fitur/dashboard/state/dashboard_state.dart` | Diubah (opsional) | Hanya bila diperlukan; diharapkan **tidak berubah** |
| `lib/shared/` (opsional, mis. `lib/shared/widget/kartu_ringkasan.dart`) | Dibuat (opsional) | Ekstraksi widget `_KartuRingkasan` bila dipakai ulang; bila tidak, cukup widget privat di `dashboard_screen.dart`; mengikuti `widget-custom` |
| `refrensi_apk.md` | Diubah | Section C1 ditandai sudah dibuatkan PRD-nya (baris penanda, tanpa menghapus isi sumber) |
| `prd/dashboard_metrik_dominan.md` | Dibuat | Dokumen PRD ini |

**Sengaja TIDAK termasuk** (agar tidak tumpang tindih dengan PRD `navigasi_dan_empty_state.md` dan mencegah scope creep): `lib/lainnya_screen.dart`, `lib/home.dart`, `lib/fitur/pemulihan_kesehatan/...`, `lib/fitur/impian/...`, `lib/fitur/alasan_berhenti/...`, `lib/fitur/badge/...`, `lib/fitur/konsumsi_rokok/...`, `lib/fitur/sas_*`/`sos_craving/...`, `lib/fitur/biodata/...`, `pubspec.yaml`, skema database.

## 21. Referensi dari refrensi_apk.md

**Sumber:** `refrensi_apk.md` baris 266-274 (section "#### C1. Dashboard: Satu Metrik Dominan + Aksi Cepat + Metrik Pendukung", prioritas Tinggi, di bawah "### Prioritas Tinggi" pada kelompok "## C. UI, UX & Layout").

### 21.1 Referensi Fitur

- **Aplikasi serupa (dari referensi):** SmokingYou (F-Droid, `com.smokingtracker`) · TrackLess (GitHub, `poorangryman/trackless-public`) · H2M (Google Play, `com.h2m.util.quitsmoke`) · Flamy (Google Play, `net.offlinefirst.flamy`) · Quitrise (Google Play, `com.matrissoftware.Quitrise`) · Breathing Room (GitHub, `anindya127/Breathing-Room`) · Quit Smoking: Progress Tracker (Google Play, `com.inspectorstudios.quitsmokingprogresstracker`) · Smoke Tracker freedom_from_smoke (Google Play, `com.trifoiltrailblazer.freedom_from_smoke`).
- **Pola UI (dari referensi):** counter/timer smoke-free besar; 2–3 metrik sekunder (uang, rokok dihindari, milestone berikutnya) dengan bobot visual seragam; tombol SOS jelas; tema terang/gelap.
- **Pola layout (dari referensi):** header status → ringkasan 3 kartu → aksi cepat → progres milestone → lainnya; grafik tidak diletakkan di Dashboard.
- **Kondisi proyek (dari referensi):** Dashboard sudah padat (banyak kartu). Saran: audit ulang di layar kecil; pertahankan 1 metrik dominan; pindahkan statistik ke layar Analitik (A5); jangan tambah kartu tanpa mengurangi.
- **Tujuan pola (dari referensi):** beban kognitif rendah; aksi kritis (SOS) selalu terjangkau.
- **Prioritas pada sumber:** Tinggi.

Konteks penggunaan referensi fitur (hasil pemeriksaan tautan pada 2026-11-10):
- **SmokingYou** (F-Droid, GPL-3.0, open-source): minimalis, data-oriented, Material 3 Expressive — one-tap logging, timer smoke-free real-time, widget quick-add/live counter, analitik (chart harian/mingguan, pemicu, tabungan, milestone WHO), badge, backup JSON, offline. Menunjukkan pemisahan Dashboard (counter + aksi) dari analitik mendalam.
- **TrackLess** (GitHub, MIT, Kotlin/Compose, 0 stars): abstinence timer + milestone kesehatan real-time (20 menit s/d 1 bulan), SOS 4-7-8, analitik 14 hari (default hari ini) + pola pagi/siang/sore/malam, widget 1x1/2x1, offline; tampilan "Obsidian & Warm Beige" yang minimalis, statistik dipisah dari dashboard utama.
- **H2M** (Google Play, 50K+ unduhan): real-time quit timer + widget, 24 milestone kesehatan, SOS 3-menit + 4-7-8, savings & cigarettes-avoided, statistik/kalender (streak saat ini/terpanjang/kumulatif), pengingat pintar; tema 16 background — pola "timer dominan + statistik terpisah".
- **Flamy** (Google Play, 1M+ unduhan, 4.8★): quit plan (quit date/taper/NRT), counter + rokok dihindari + uang dihemat + milestone + achievements, SOS (napas/distraksi/motivasi) dengan log craving & slip, widget + Wear OS, offline-first; menegaskan uang dihemat & milestone sebagai metrik sekunder yang selalu terlihat.
- **Quitrise** (Google Play, 10+ unduhan): live counter (hari/jam/menit), uang/rokok dihindari/life regained, kalender smoke-free, level/XP/badge/misi harian, SOS 3-menit + breathing + mini-games + "your reasons", health timeline 12 milestone, wallet goals; private-by-design — counter dominan + progres milestone + aksi SOS satu ketuk.
- **Breathing Room** (GitHub, MIT, Flutter+Riverpod+sqflite+fl_chart+go_router): dual-mode (simple counter / coach tapering), wallet (biaya per batang + multi-mata uang), statistik harian/mingguan/bulanan, trophy room, non-smoker path (12 milestone + progress bar); proyek ini juga Flutter+Riverpod+sqflite — relevan sebagai acuan struktur proyek sejenis.
- **Quit Smoking: Progress Tracker** (Google Play, 100+ unduhan): quit plan 7 hari, money saved + savings goals, health recovery timeline, craving rescue toolkit (4-7-8, box breathing, grounding), CBT-based exercises, slip/craving/trigger log, weekly reports; "the dashboard to notice patterns and choose your next focus" — statistik/insight dipisah dari aksi.
- **Smoke Tracker (freedom_from_smoke)** (Google Play, 10K+ unduhan): one-tap check-in (3 mode), counter jam/hari/minggu/bulan/tahun, SOS toolkit + urge-surfing timer, craving tracker + triggers, NRT tracking, timeline kesehatan WHO/AHA/ACS, uang dihemat per hari, garden tumbuh, badge, weekly review; menegaskan pemisahan widget/garansi data lokal.

### 21.2 Referensi UI/UX

- **Pola UI (dari referensi):** counter/timer smoke-free besar; 2–3 metrik sekunder (uang, rokok dihindari, milestone berikutnya) bobot seragam; tombol SOS jelas; tema terang/gelap.
- **Pola UX (dari referensi):** hierarki baca "kondisi sekarang" dalam <5 detik; tindakan utama selalu terlihat; angka spesifik > umum.
- **Pola layout (dari referensi):** header status → ringkasan 3 kartu → aksi cepat → progres milestone → lainnya; grafik **tidak** diletakkan di Dashboard.
- Catatan: Detail visual 3 kartu ringkasan (bentuk/warna) tidak ditentukan referensi; ditentukan proyek ini saat diskusi PRD. Posisi milestone sebagai kartu ringkasan (bukan blok terpisah) adalah konsolidasi keputusan proyek, konsisten dengan pola "ringkasan 3 kartu".

### 21.3 Referensi Alur Pengguna

- Tidak ada alur langkah-demi-langkah eksplisit pada sumber; alur pada bagian 8 PRD ini disusun dari pola referensi (header status → 3 kartu ringkasan → aksi cepat → lainnya) dan kondisi proyek yang ada (Dashboard padat 11 blok dengan duplikasi durasi).

### 21.4 Referensi Lainnya

- **Prioritas pada sumber:** Tinggi (section C1 berada di bawah "### Prioritas Tinggi" pada kelompok C UI/UX & Layout).
- **Kepastian sumber:** Kedelapan tautan diperiksa pada 2026-11-10 (F-Droid/GitHub/Google Play). Ketiganya GitHub (TrackLess, Breathing Room) dan F-Droid/SmokingYou adalah sumber open-source yang dapat dibaca langsung; enam halaman Google Play hanya memuat deskripsi pengembang (klaim pengembang, bukan hasil pengujian perangkat). Klaim statistik (unduhan/rating) adalah potret sesaat dan tidak dijadikan dasar wajib.
- **Batasan memakai referensi:** Referensi hanya inspirasi; bukan kewajiban meniru tampilan. PRD ini tidak meniru kode/UI kompetitor; hanya pola (hierarki metrik, posisi aksi cepat, pemisahan statistik). Layar Analitik (A5) tetap di luar ruang lingkup PRD ini, meskipun referensi menyarankan pemindahan statistik.
