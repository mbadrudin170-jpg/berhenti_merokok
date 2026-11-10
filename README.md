# Berhenti Merokok

Aplikasi Flutter pendamping proses berhenti merokok yang membantu pengguna mencatat data pribadi, memantau progres *smoke-free*, mencatat dorongan merokok, mengelola impian, serta mengakses dukungan cepat saat muncul keinginan untuk merokok. Aplikasi berjalan dengan pendekatan *offline-first* menggunakan penyimpanan lokal (SQLite dan preferensi lokal), dengan dukungan notifikasi pengingat harian sesuai kemampuan platform.

## Tujuan Aplikasi

Berdasarkan implementasi yang tersedia, aplikasi ini bertujuan untuk:

- Membantu pengguna mencatat biodata dan parameter kebiasaan merokok.
- Memantau progres sejak tanggal mulai berhenti merokok secara berkelanjutan.
- Menyediakan pencatatan konsumsi rokok aktual, termasuk kondisi *slip*.
- Mencatat dorongan merokok (*craving*) beserta pemicu, intensitas, dan catatan.
- Menyediakan dukungan motivasi dan intervensi cepat (SOS Craving, alasan berhenti).
- Mengelola impian/target sebagai tujuan pemanfaatan dana yang dihemat.
- Menyajikan informasi pemulihan kesehatan, pencapaian (*badge*), kalender *smoke-free*, dan estimasi zat berbahaya yang dihindari.
- Menyediakan cadangan dan pemulihan data lokal serta utilitas data dummy untuk keperluan pengujian.

## Fitur Utama

### 1. Onboarding dan Biodata Pengguna
- Alur awal aplikasi: jika biodata belum ada, pengguna diarahkan ke formulir biodata (`FormBiodata` dengan mode pembuatan awal).
- Penyimpanan dan pembaruan data biodata, meliputi:
  - Nama dan tanggal lahir.
  - Jumlah rokok per hari, harga rokok per bungkus, dan jumlah batang per bungkus.
  - Tanggal mulai merokok dan tanggal mulai berhenti merokok.
  - Target *smoke-free* (hari).
- Mendukung dua mode berhenti merokok (`ModeBerhenti`):
  - **Seketika**.
  - **Bertahap (tapering)** dengan parameter penurunan per minggu dan tanggal mulai *tapering*.
- Data biodata disimpan di tabel SQLite `biodata` dan dikelola melalui *notifier* Riverpod.
- Perhitungan turunan (berbasis ekstensi model biodata) digunakan secara konsisten di berbagai layar, antara lain:
  - Hari *smoke-free* (normalisasi tanggal, tanpa komponen waktu).
  - Jumlah rokok yang tidak dihisap.
  - Estimasi uang yang dihemat.
  - Target rokok hari ini untuk mode *tapering* (dengan klamping agar tidak negatif dan tidak melebihi jumlah rokok per hari).

### 2. Dashboard
- Menampilkan ringkasan progres pengguna, termasuk durasi berhenti merokok dan metrik terkait yang dihitung dari biodata.
- Menyediakan akses cepat ke bantuan SOS Craving dari bilah aplikasi.
- Menyediakan navigasi ke fitur pendukung seperti pemulihan kesehatan dan pencapaian (sesuai implementasi layar dashboard).
- Pembaruan waktu/durasi yang bersifat periodik diisolasi pada widget terpisah agar pembaruan tidak memicu *rebuild* seluruh halaman.

### 3. Pemulihan Kesehatan
- Menampilkan daftar *milestone* pemulihan kesehatan berdasarkan durasi *smoke-free*.
- Cakupan *milestone* yang didefinisikan dalam konstanta aplikasi: dari **20 menit** hingga **15 tahun**, lengkap dengan judul dan deskripsi manfaat.
- Status *milestone* ditentukan dari durasi *smoke-free* pengguna (tercapai/belum) dan dapat menampilkan *milestone* berikutnya.

### 4. Pencapaian (*Badge*)
- Menghitung dan menampilkan daftar pencapaian berdasarkan progres pengguna.
- Kategori pencapaian yang dihitung dalam helper aplikasi meliputi:
  - Durasi *smoke-free* (mis. 1, 3, 7, 14, 30, 90, 180, 365 hari).
  - Jumlah rokok yang tidak dihisap (mis. 100, 500, 1000 batang).
  - Uang yang dihemat (mis. Rp100.000, Rp500.000, Rp1.000.000).
  - Jumlah impian tercapai (mis. 1 dan 3 impian).
- Menampilkan ringkasan pencapaian yang telah diraih dan kondisi kosong ketika data pendukung belum tersedia.

### 5. Kalender *Smoke-Free*
- Menampilkan kalender bulanan dengan penandaan hari-hari *smoke-free* sejak tanggal mulai berhenti merokok.
- Menyediakan navigasi antarbulan.
- Menampilkan ringkasan progres berdasarkan data biodata.
- Menangani kondisi data belum lengkap (mis. biodata atau tanggal mulai berhenti belum tersedia) dengan tampilan/pesan yang sesuai.

### 6. Impian (Tujuan)
- Pengelolaan daftar impian: tambah, ubah, hapus, dan lihat detail impian.
- Data impian mencakup informasi seperti nama, jumlah target, target tanggal, dan waktu pembuatan (sesuai model/tabel impian).
- Menampilkan progres/visualisasi tabungan impian berbasis saldo terkumpul (uang dihemat dari tidak merokok).
- Menyediakan pengurutan daftar impian (`SortImpian`) dengan opsi:
  - Nama A-Z / Z-A.
  - Jumlah terkecil / terbesar.
  - Paling mendekati terkumpul / sisa terbesar.
- Menampilkan kondisi kosong ketika belum ada impian.

### 7. Alasan Berhenti
- Pencatatan dan pengelolaan daftar alasan berhenti merokok (tambah, ubah, hapus).
- Data disimpan pada tabel `alasan_berhenti`.
- Alasan terbaru dapat ditampilkan sebagai penguat motivasi pada layar SOS Craving (kartu "Ingat alasanmu") ketika data tersedia.

### 8. Diary Craving
- Pencatatan entri dorongan merokok (*craving*) dengan atribut seperti tanggal kejadian, pemicu, intensitas, catatan, dan waktu dibuat (sesuai model/implementasi).
- Mendukung tambah, ubah, dan hapus entri.
- Menampilkan daftar riwayat dan kondisi kosong ketika belum ada catatan.
- Tersedia analisis sederhana pola jam *craving* melalui `PolaCravingHelper`:
  - Menghitung jam lokal teratas dari data entri.
  - Jam teratas hanya ditentukan jika jumlah entri memenuhi ambang minimum (≥ 3 entri).

### 9. Konsumsi Rokok
- Pencatatan konsumsi rokok harian aktual pada tabel `konsumsi_rokok`.
- Mendukung pencatatan cepat (*quick log* +1 batang) dari layar konsumsi.
- Menyediakan formulir entri konsumsi dan penyajian ringkasan harian.
- Dapat menandai kondisi *slip* pada entri konsumsi (ditampilkan sebagai penanda pada ringkasan/daftar).

### 10. SOS Craving
- Layar bantuan cepat saat dorongan merokok muncul dengan tiga tab:
  - **Napas 4-7-8** (latihan pernapasan terstruktur).
  - **Timer 3 Menit**.
  - **Distraksi** (daftar aktivitas pengalihan).
- Menampilkan kartu pengingat alasan berhenti terbaru (jika tersedia) sebagai penguat motivasi.

### 11. Pelacakan Toxin
- Menampilkan estimasi zat berbahaya yang dihindari berdasarkan jumlah rokok yang tidak dihisap (diturunkan dari progres biodata).
- Perhitungan dilakukan oleh helper murni (`ToxinHitungHelper`) menggunakan daftar referensi statis dan faktor ilustratif per batang rokok.
- Zat yang dimodelkan antara lain: Tar, Nikotin, Karbon Monoksida, Formaldehida, Bensen, Ammonia, dan Arsen, beserta jenis zat, kuantitas dihindari, efek singkat, dan sumber referensi umum.
- Menampilkan keadaan khusus ketika biodata belum ada, tanggal mulai berhenti belum ditetapkan, atau belum ada rokok yang dihindari.
- Layar mencantumkan penafian bahwa data merupakan perkiraan ilustratif berdasarkan referensi kesehatan umum (WHO/CDC/AHA/ACS), bukan klaim medis aplikasi.

### 12. Pengaturan dan Notifikasi
- **Tema aplikasi**: pilihan tema Sistem, Terang, atau Gelap dengan penyimpanan preferensi.
- **Pengingat harian** (pada platform yang mendukung):
  - Aktivasi/nonaktivasi, pemilihan waktu, dan penjadwalan ulang saat aplikasi dimulai jika aktif.
  - Uji coba notifikasi langsung.
- **Check-in pagi** (pada platform yang mendukung):
  - Aktivasi/nonaktivasi dan pemilihan waktu pengingat.
- **Pengingat pola craving** (pada platform yang mendukung):
  - Aktivasi/nonaktivasi berdasarkan jam *craving* teratas dari data diary.
  - Jika data diary belum cukup (kurang dari ambang minimum), preferensi dapat disimpan tanpa penjadwalan waktu otomatis.
- **Penanganan izin dan perilaku platform**:
  - Permintaan izin notifikasi dilakukan sesuai platform yang didukung implementasi.
  - Navigasi saat notifikasi ditekan ditangani melalui *payload* dan *navigator key*, termasuk pemeriksaan *launch details* saat aplikasi dibuka dari kondisi tertentu (sesuai dukungan platform).
  - Zona waktu perangkat dideteksi menggunakan `flutter_timezone` dengan fallback ke `Asia/Jakarta` bila deteksi/lokasi zona waktu gagal.
- **Keterbatasan platform notifikasi terjadwal**: penjadwalan/pengaturan notifikasi terjadwal tidak ditampilkan atau tidak didukung pada platform Web, Linux, dan Windows (sesuai pemeriksaan platform dalam kode).

### 13. Cadangan dan Ekspor Data
- Layar **Cadangan & Ekspor Data** untuk:
  - **Ekspor** data lokal ke berkas cadangan JSON.
  - **Pemulihan** data dari berkas cadangan JSON.
- Cakupan data cadangan (versi format saat ini: 1) meliputi tabel: `biodata`, `impian`, `diary_craving`, dan `alasan_berhenti`.
- Ekspor/pemulihan berkas hanya tersedia pada platform yang didukung implementasi (bukan Web). Pada platform tidak didukung, layar menampilkan pesan bahwa fitur tidak tersedia.
- Proses pemulihan:
  - Memvalidasi berkas/payload cadangan sebelum diterapkan.
  - Meminta konfirmasi pengguna (termasuk konfirmasi destruktif karena data lama diganti).
  - Melakukan pemulihan secara atomik (transaksi basis data) dan menyegarkan *provider* terkait setelah berhasil.
- Penanganan kesalahan dilakukan dengan umpan balik kepada pengguna dan pencatatan log.

### 14. Data Dummy
- Layar utilitas untuk memasukkan, menghapus, dan mereset data dummy (biodata dan impian).
- Operasi dijalankan dengan konfirmasi pengguna dan indikator proses.
- Setelah operasi, *provider* terkait diperbarui agar antarmuka menampilkan data terbaru.

### 15. Navigasi Utama dan Layar Lainnya
- Navigasi tab utama menggunakan `NavigationBar` dengan empat tujuan: **Dashboard**, **Biodata**, **Impian**, dan **Lainnya**.
- Inisialisasi tab bersifat *lazy*: tab dibangun saat pertama kali dipilih dan dipertahankan menggunakan `IndexedStack`.
- Layar **Lainnya** menyediakan akses ke: Pengaturan, Dummy, SOS Craving, Pemulihan Kesehatan, Diary Craving, Alasan Berhenti, Kalender *Smoke-Free*, Konsumsi Rokok, dan Pelacakan Toxin.

## Teknologi yang Digunakan

### Bahasa dan Kerangka Kerja
- **Dart** (SDK: `^3.13.7`)
- **Flutter** (Material Design, `uses-material-design: true`)

### Dependensi Utama (`pubspec.yaml`)
| Paket | Kegunaan (berdasarkan penggunaan proyek) |
| --- | --- |
| `flutter_riverpod`, `riverpod_annotation` | Manajemen state reaktif dan anotasi provider/notifier |
| `freezed_annotation` | Model/state *immutable* (dengan kode hasil *generate*) |
| `sqflite` | Basis data SQLite lokal |
| `sqflite_common_ffi_web` | Dukungan SQLite pada platform Web |
| `shared_preferences` | Penyimpanan preferensi lokal (tema, pengaturan notifikasi, dll.) |
| `flutter_local_notifications` | Notifikasi lokal dan penjadwalan |
| `flutter_timezone`, `timezone` | Deteksi dan pengelolaan zona waktu untuk penjadwalan notifikasi |
| `flutter_easyloading` | Indikator pemuatan (*overlay loading*) |
| `adaptive_dialog` | Dialog konfirmasi adaptif |
| `file_picker`, `path_provider` | Pemilihan/lokasi dan penulisan berkas cadangan |
| `share_plus` | Dependensi tersedia untuk kemampuan berbagi (tercantum di proyek) |
| `restart_app` | Dependensi tersedia untuk mekanisme restart aplikasi (tercantum di proyek) |
| `collection` | Utilitas koleksi |
| `cupertino_icons` | Ikon gaya Cupertino |
| `share_global_saya` (path lokal `../share_global_saya`) | Komponen/utilitas bersama yang digunakan aplikasi (mis. navigasi, utilitas *toast*, logging, parser/format, komponen UI bersama) |

### Dependensi Pengembangan
| Paket | Kegunaan |
| --- | --- |
| `build_runner` | Menjalankan *code generation* |
| `riverpod_generator` | Generator provider/notifier Riverpod |
| `freezed` | Generator model/state Freezed |
| `flutter_lints` | Aturan analisis statis/lint |
| `flutter_test` | Kerangka pengujian Flutter |

> Catatan: proyek ini menggunakan berkas hasil *generate* (`*.g.dart`, `*.freezed.dart`) yang merupakan bagian dari basis kode.

## Arsitektur dan Pendekatan Implementasi

- **Pemisahan tanggung jawab per fitur**: kode diorganisasi di bawah `lib/fitur/<nama_fitur>/` (mis. `model`, `notifier`, `state`, `screens`, `helper`, `enum`, `widget` sesuai kebutuhan fitur).
- **Manajemen state**: Riverpod (*notifier/provider*) dengan pola pemuatan data asinkron dan penanganan kondisi *loading/error/data* pada antarmuka.
- **Model dan state *immutable***: Freezed digunakan untuk model/state, termasuk konversi data SQLite (`fromSqflite`/`toSqflite`) pada model yang relevan.
- **Penyimpanan lokal**:
  - SQLite sebagai penyimpanan data utama terstruktur.
  - `SharedPreferences` untuk preferensi dan pengaturan sederhana.
- **Layanan notifikasi terpusat**: inisialisasi, permintaan izin, penjadwalan, pembatalan, dan penanganan interaksi notifikasi dikelola melalui `NotifikasiService`.
- **Utilitas dan konstanta bersama**: skema/tabel/kolom basis data, operasi SQLite, kunci preferensi, dan konstanta domain dikelola di `lib/shared/`.
- **Logging dan umpan balik pengguna**: operasi penting mencatat log (`L`) dan menampilkan umpan balik (mis. *toast*/indikator pemuatan) sesuai alur fitur.

## Struktur Proyek (Ringkasan)

```text
lib/
├── app.dart                     # Widget root aplikasi, tema, lokalisasi, penentuan home awal
├── main.dart                    # Entry point: inisialisasi binding, DB, notifikasi, ProviderScope
├── home.dart                    # Navigasi tab utama (lazy + IndexedStack)
├── lainnya_screen.dart          # Menu akses ke fitur tambahan
├── fitur/
│   ├── alasan_berhenti/         # Alasan berhenti (model, notifier, state, screens)
│   ├── badge/                   # Pencapaian/badge (helper, screens)
│   ├── biodata/                 # Biodata & mode berhenti (enum, model, notifier, screens)
│   ├── cadangan/                # Cadangan & ekspor/pemulihan data (helper, screens)
│   ├── dashboard/               # Dashboard (notifier, state, screens)
│   ├── diary_craving/           # Diary craving & pola (enum, helper, model, notifier, state, screens)
│   ├── dummy/                   # Data dummy (data, helper, screens)
│   ├── impian/                  # Impian/target tabungan (enum, helper, model, notifier, state, screens, widget)
│   ├── kalender_smoke_free/     # Kalender smoke-free (screens)
│   ├── konsumsi_rokok/          # Pencatatan konsumsi rokok (helper, model, notifier, state, screens)
│   ├── pemulihan_kesehatan/     # Milestone pemulihan (helper, screens)
│   ├── pengaturan/              # Pengaturan tema & notifikasi (screens)
│   ├── sos_craving/             # Bantuan cepat craving (screens)
│   ├── tema/                    # Preferensi tema (enum, notifier)
│   └── toxin_pelacakan/         # Estimasi toxin dihindari (helper, model, screens, state)
└── shared/
    ├── db/sqflite/              # Inisialisasi/migrasi database dan operasi SQLite
    ├── helper/                  # Kunci preferensi bersama
    ├── konstanta/               # Konstanta tabel, kolom, milestone kesehatan
    └── notifikasi/              # Layanan notifikasi lokal
```

## Penyimpanan Data

- **SQLite** (`berhenti_merokok.db`, versi skema saat ini: **9**):
  - `biodata`: data profil dan parameter berhenti merokok.
  - `impian`: daftar impian/target.
  - `diary_craving`: catatan dorongan merokok.
  - `alasan_berhenti`: alasan berhenti merokok.
  - `konsumsi_rokok`: pencatatan konsumsi rokok aktual (termasuk indeks pada kolom tanggal).
- **SharedPreferences**: menyimpan preferensi seperti tema dan pengaturan notifikasi (pengingat harian, check-in pagi, pola *craving*, waktu terkait).
- **Format waktu**: tanggal/waktu pada data yang disimpan ke SQLite dikonversi ke representasi UTC (ISO 8601) dan ditampilkan kembali sesuai kebutuhan antarmuka.
- **Dukungan Web (penyimpanan SQLite)**: pada platform Web, inisialisasi menggunakan `databaseFactoryFfiWeb` dengan aset pendukung `web/sqlite3.wasm` dan `web/sqflite_sw.js` yang tersedia di repositori.

## Menjalankan Aplikasi

### Prasyarat
- Flutter SDK yang kompatibel dengan batasan proyek (`environment.sdk: ^3.13.7`).
- Dart SDK yang sesuai dengan Flutter SDK tersebut.
- Dependensi lokal `share_global_saya` tersedia pada path `../share_global_saya` (sesuai konfigurasi `pubspec.yaml`).

### Langkah
1. Pasang dependensi:
   ```bash
   flutter pub get
   ```
2. (Jika diperlukan, setelah mengubah model/notifier yang menggunakan *code generation*) jalankan generator:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. Jalankan aplikasi pada perangkat/emulator yang tersedia:
   ```bash
   flutter run
   ```

## Pengujian

Repositori ini memiliki berkas pengujian di direktori `test/`, antara lain:
- `test/widget_test.dart`
- `test/notifikasi_service_test.dart`
- `test/progres_milestone_helper_test.dart`

Pengujian dapat dijalankan menggunakan perintah Flutter standar (mis. `flutter test`) pada lingkungan yang telah dikonfigurasi dengan benar.

## Lokalisasi

- Aplikasi mengonfigurasi dukungan lokal **Indonesia** (`id_ID`).
- Delegasi lokalisasi Material, Widgets, dan Cupertino disertakan dalam konfigurasi aplikasi.
- Disediakan delegasi lokalisasi tambahan untuk kompatibilitas komponen tertentu yang membutuhkan dukungan locale Indonesia.

## Platform dan Keterbatasan yang Teridentifikasi

- **Target dan cakupan implementasi**: aplikasi dikembangkan sebagai aplikasi Flutter dengan penyimpanan lokal dan notifikasi; perilaku fitur bergantung pada dukungan platform runtime.
- **Notifikasi terjadwal**: fitur pengingat terjadwal (pengingat harian, check-in pagi, pola *craving*) dibatasi/dinonaktifkan pada platform Web, Linux, dan Windows sesuai pemeriksaan dalam kode.
- **Cadangan/ekspor berkas**: fitur cadangan dan pemulihan berkas tidak didukung pada platform Web; ketersediaan bergantung pada dukungan sistem berkas/pemilih berkas platform.
- **Dependensi lokal**: pembangunan proyek memerlukan ketersediaan paket lokal `share_global_saya` pada path yang direferensikan.
- **Informasi lisensi**: berkas lisensi eksplisit tidak ditemukan dalam repositori pada saat dokumentasi ini disusun.

## Kelebihan Proyek (Berdasarkan Implementasi)

- **Cakupan fitur berhenti merokok yang komprehensif**: mencakup pemantauan progres, dukungan saat *craving* (SOS, diary, analisis pola sederhana), motivasi (alasan berhenti), serta visualisasi kemajuan (kalender, pemulihan kesehatan, pencapaian, pelacakan toxin estimatif).
- **Dukungan mode berhenti fleksibel**: tersedia mode seketika dan *tapering* dengan perhitungan target harian berbasis parameter pengguna.
- **Penyimpanan lokal terstruktur dan berversi**: penggunaan SQLite dengan migrasi skema bertahap (hingga versi 9) untuk evolusi data aplikasi.
- **Mekanisme cadangan dan pemulihan**: ekspor/pemulihan data inti dalam format JSON dengan validasi dan pemulihan berbasis transaksi basis data.
- **Pengingat kontekstual**: selain pengingat harian, tersedia check-in pagi dan pengingat berbasis pola jam *craving* (dengan syarat kecukupan data).
- **Pengalaman penggunaan yang diperhatikan**: penanganan kondisi *loading/error/kosong*, konfirmasi untuk aksi penting/destruktif, umpan balik proses, serta navigasi tab yang efisien dengan inisialisasi *lazy*.
- **Fondasi teknis modern**: pemanfaatan Riverpod, Freezed, *code generation*, dan pemisahan kode per fitur untuk menjaga keterbacaan dan pemeliharaan.

## Catatan Keakuratan

Dokumentasi ini disusun berdasarkan isi repositori yang dapat diperiksa (struktur direktori, konfigurasi proyek, dependensi, skema/konstanta, serta implementasi fitur pada kode sumber). Jika terdapat perilaku atau dukungan platform tambahan di luar yang teridentifikasi dalam kode saat ini, hal tersebut tidak dicantumkan dalam README ini.
