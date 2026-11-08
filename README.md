# Berhenti Merokok

Aplikasi mobile pendamping proses berhenti merokok yang membantu pengguna mencatat data pribadi, memantau progres smoke-free, mengelola impian (tujuan) yang ingin dicapai, serta menyediakan bantuan cepat saat mengalami dorongan merokok. Aplikasi dibangun dengan Flutter dan berjalan secara luring (*offline-first*) dengan penyimpanan lokal berbasis SQLite. Aplikasi juga mendukung penjadwalan pengingat harian melalui notifikasi lokal.

## Tujuan Aplikasi

Aplikasi ini dirancang untuk mendukung pengguna yang sedang berupaya berhenti merokok dengan menyediakan:

- Pencatatan biodata pengguna, termasuk riwayat merokok, tanggal mulai berhenti merokok, dan mode berhenti (seketika atau bertahap/tapering).
- Pemantauan progres smoke-free secara real-time: durasi berhenti, uang yang dihemat, dan jumlah rokok yang tidak dihisap.
- Pengelolaan daftar impian (tujuan) beserta target jumlah dan target tanggal, dengan progres berbasis saldo terkumpul.
- Pencatatan dorongan merokok (*craving*) beserta pemicu dan intensitasnya.
- Kalender smoke-free yang menandai hari-hari tanpa rokok.
- Pemulihan kesehatan berbasis milestone durasi smoke-free.
- Pencapaian (*badge*) berdasarkan progres pengguna.
- Bantuan cepat (SOS Craving) saat dorongan merokok muncul.
- Pengingat harian melalui notifikasi lokal.
- Penyesuaian tampilan tema aplikasi (sistem, terang, gelap).
- Penyediaan data dummy untuk keperluan pengujian dan pengembangan.

## Fitur Utama

### 1. Biodata Pengguna

- Menyimpan dan menampilkan data biodata pengguna: nama, tanggal lahir, jumlah rokok per hari, harga rokok per bungkus, batang per bungkus, tanggal mulai merokok, dan tanggal mulai berhenti merokok.
- Mendukung alur pertama kali (onboarding): pengguna baru diarahkan ke formulir biodata sebelum masuk ke aplikasi.
- Mendukung mode ubah: biodata yang sudah ada dapat diperbarui tanpa membuat data baru.
- Data disimpan secara lokal di SQLite dan dimuat ulang saat aplikasi dijalankan.
- Formulir menggunakan validasi (`GlobalKey<FormState>`) dengan pemeriksaan nilai positif sebelum penyimpanan.

### 2. Mode Berhenti (Seketika / Bertahap)

- Mendukung dua mode berhenti merokok:
  - **Seketika**: target rokok per hari tetap sama dengan jumlah rokok per hari.
  - **Bertahap (tapering)**: target rokok per hari menurun secara kumulatif berdasarkan minggu yang telah berlalu sejak tanggal mulai penurunan.
- Mode bertahap memerlukan nilai penurunan per minggu (bilangan bulat positif) dan tanggal mulai penurunan yang valid.
- Target rokok dihitung dengan rumus `target = jumlahRokokPerHari - (penurunanPerMinggu * mingguBerlalu)`, dengan klamping agar tidak kurang dari nol dan tidak melebihi jumlah rokok per hari.
- Jika tanggal mulai berada di masa depan, jumlah minggu yang telah berlalu dianggap nol sampai tanggal tersebut tercapai.

### 3. Dashboard

- Menampilkan durasi berhenti merokok secara real-time (hari, jam, menit, detik) dengan pembaruan per detik pada widget terisolasi agar tidak memicu rebuild seluruh halaman.
- Menampilkan uang yang dihemat dan jumlah rokok yang tidak dihisap selama periode smoke-free.
- Menampilkan informasi kerugian saat merokok: total rokok yang dihisap, uang yang terbuang, dan waktu hidup yang hilang.
- Menyediakan kartu milestone pemulihan kesehatan (navigasi ke halaman Pemulihan Kesehatan) dan kartu pencapaian (navigasi ke halaman Pencapaian).
- Menampilkan sapaan nama pengguna.
- Menyediakan tombol SOS Craving pada app bar.

### 4. Pemulihan Kesehatan

- Menampilkan daftar milestone pemulihan kesehatan berdasarkan durasi smoke-free (20 menit hingga 15 tahun), beserta deskripsi manfaat pada setiap milestone.
- Setiap milestone ditandai status tercapai atau belum.
- Menampilkan header durasi smoke-free yang diperbarui setiap detik pada widget terisolasi.

### 5. Pencapaian (Badge)

- Menghitung dan menampilkan daftar badge berdasarkan progres pengguna: durasi smoke-free, jumlah rokok yang tidak dihisap, uang yang dihemat, dan jumlah impian tercapai.
- Menampilkan ringkasan jumlah badge tercapai dari total badge.
- Menampilkan state kosong (informasi) apabila biodata belum lengkap.

### 6. Kalender Smoke-Free

- Menampilkan kalender bulanan yang menandai hari-hari smoke-free sejak tanggal mulai berhenti merokok.
- Menyediakan navigasi bulan sebelumnya dan berikutnya.
- Menampilkan ringkasan progres smoke-free.

### 7. Impian (Tujuan)

- Menampilkan daftar impian dengan nama, jumlah target, dan target tanggal.
- Mendukung penambahan, pengubahan, dan penghapusan impian.
- Menyediakan halaman detail impian dengan aksi ubah.
- Menampilkan state kosong ("Belum ada impian") beserta tombol tambah untuk menambah impian pertama.
- Setiap item daftar memiliki identitas stabil (`ValueKey`) agar posisi scroll dan identitas item tetap konsisten.
- Daftar menggunakan `ListView.separated` untuk efisiensi pada jumlah data yang besar.
- Mendukung pengurutan (sort) impian melalui bottom sheet (mendekati terkumpul, dan lainnya).
- Menampilkan saldo terkumpul (uang yang dihemat dari tidak merokok) dan progress bar serta teks "Sisa" pada setiap item impian berbasis saldo terkumpul.
- Menampilkan total jumlah impian.

### 8. SOS Craving

- Halaman bantuan cepat saat dorongan merokok muncul, dengan tiga tab:
  - Latihan napas 4-7-8 (tarik 4 detik, tahan 7 detik, hembus 8 detik) sebanyak 4 siklus.
  - Timer craving 3 menit.
  - Daftar distraksi untuk membantu pengguna melewati dorongan merokok.

### 9. Diary Craving

- Mencatat dorongan merokok (*craving*) dengan pemicu (kategori), intensitas (1-5), catatan, dan tanggal kejadian.
- Mendukung penambahan, pengubahan, dan penghapusan catatan craving.
- Menampilkan state kosong ("Belum ada catatan craving") beserta tombol tambah.
- Setiap item daftar memiliki identitas stabil (`ValueKey`).
- Daftar menggunakan `ListView.separated`.

### 10. Notifikasi Pengingat Harian

- Menyediakan pengingat harian terjadwal pada jam dan menit yang dipilih pengguna, dengan payload untuk navigasi saat notifikasi ditekan.
- Mendukung permintaan izin notifikasi per platform (Web, Android, iOS, macOS).
- Mendukung uji coba notifikasi langsung.
- Menyimpan status aktif dan waktu pengingat melalui `SharedPreferences`.
- Menjadwalkan ulang pengingat saat aplikasi dibuka apabila aktif.
- Menangani tiga kondisi lifecycle aplikasi saat notifikasi ditekan (foreground, background, terminated) melalui `getNotificationAppLaunchDetails()`.
- Menggunakan zona waktu perangkat (dengan fallback `Asia/Jakarta`) agar pengingat mengikuti waktu lokal pengguna.
- ID notifikasi uji coba terpisah dari ID pengingat utama.
- Fitur pengingat terjadwal tidak ditampilkan pada platform yang tidak mendukung (Web, Linux, Windows).

### 11. Pengaturan

- Halaman pengaturan menyediakan pemilihan tema aplikasi (Sistem, Terang, Gelap) melalui menu popup.
- Menyediakan pengaturan pengingat harian: toggle aktif/nonaktif, pemilih waktu, dan uji coba notifikasi.
- Penanganan error pada aksi dicatat melalui logger proyek.

### 12. Data Dummy

- Menyediakan operasi masukkan, hapus, dan reset data dummy untuk biodata dan impian.
- Data dummy menggunakan tanggal relatif terhadap waktu sekarang agar tetap realistis.
- Sebelum memasukkan data dummy biodata, data biodata yang ada dihapus agar data dummy menjadi satu-satunya biodata yang terbaca (karena `ambilSatu` mengembalikan baris pertama).
- Dialog konfirmasi ditampilkan sebelum operasi dijalankan, dengan pesan yang menjelaskan konsekuensi penggantian biodata.
- Setelah operasi dummy, provider data diperbarui sehingga UI menampilkan data terbaru.

### 13. Navigasi Utama

- Tab utama: Dashboard, Biodata, Impian, dan Lainnya.
- Inisialisasi tab secara *lazy*: tab hanya dibangun saat pertama kali dipilih, lalu state-nya dipertahankan melalui `IndexedStack`.
- Layar "Lainnya" menyediakan akses ke Pengaturan, Dummy, SOS Craving, Pemulihan Kesehatan, Diary Craving, dan Kalender Smoke-Free.

## Teknologi yang Digunakan

### Framework dan Bahasa

- **Flutter** (SDK `^3.13.7`)
- **Dart**

### Dependensi Utama (pubspec.yaml)

| Paket | Kegunaan |
| --- | --- |
| `flutter_riverpod` | Pengelolaan state reaktif |
| `riverpod_annotation` / `riverpod_generator` | Generator provider dan notifier |
| `freezed_annotation` / `freezed` | State dan model immutable |
| `sqflite` | Database SQLite lokal |
| `sqflite_common_ffi_web` | Dukungan SQLite pada platform web |
| `shared_preferences` | Penyimpanan preferensi sederhana (tema, notifikasi) |
| `flutter_easyloading` | Overlay loading pada aksi simpan |
| `adaptive_dialog` | Dialog konfirmasi adaptif |
| `flutter_local_notifications` | Notifikasi lokal dan penjadwalan |
| `flutter_timezone` | Deteksi zona waktu perangkat |
| `timezone` | Pengolahan zona waktu (`TZDateTime`) |
| `collection` | Utilitas koleksi (`sorted`, `firstWhereOrNull`, `maxBy`) |
| `cupertino_icons` | Ikon Cupertino |
| `share_global_saya` (path lokal) | Widget dan helper reusable (`InputTeks`, `Nav`, `AppToast`, `L`, `ParserUtil`, `FormatUang`, `FormatTanggal`, dll.) |

### Dependensi Transitif yang Digunakan Langsung dalam Kode

| Paket | Kegunaan |
| --- | --- |
| `uuid` | Pembuatan ID unik (impian, diary craving, biodata) |
| `material_ui` | Komponen UI adaptif (tema, lokalisasi) |

### Dependensi Pengembangan

| Paket | Kegunaan |
| --- | --- |
| `build_runner` | Menjalankan generator kode |
| `freezed` | Generator state/model |
| `riverpod_generator` | Generator provider/notifier |
| `flutter_lints` | Linting kode |
| `flutter_test` | Pengujian widget |

## Arsitektur

Proyek mengikuti pola berlapis (layered) yang memisahkan tanggung jawab:

- **UI (screens/pages)**: menampilkan data dan menangani interaksi pengguna.
- **Notifier (Riverpod)**: pengelolaan state dan logika bisnis, termasuk operasi database.
- **State (Freezed)**: representasi state immutable.
- **Model (Freezed)**: representasi data dengan factory `fromSqflite` dan metode `toSqflite`.
- **Shared**: konstanta skema database (`NamaTabel`, `NamaKolom`), operasi CRUD generik (`SqfliteOp`), dan helper bersama (logging `L`, parser, format).

Prinsip utama:

- *Offline-first*: seluruh data utama disimpan di SQLite lokal.
- State management menggunakan Riverpod dengan generator.
- State dan model menggunakan Freezed (immutable).
- Penanganan `AsyncValue` mengikuti urutan loading → error → data, dengan early return.
- Operasi asynchronous dibungkus `try/catch`, dicatat dengan logger `L`, dan diteruskan dengan `rethrow`.
- Perhitungan turunan (hari smoke-free, rokok tidak dihisap, uang dihemat, target tapering) didefinisikan sekali pada ekstensi model (`BiodataModelPerhitungan`) agar konsisten di seluruh layar.
- Widget yang diperbarui secara berkala (timer per detik) diisolasi ke widget terpisah (`StatefulWidget`) dengan pembatalan timer di `dispose()`.
- Normalisasi tanggal (`DateTime(year, month, day)`) sebelum perbandingan/perhitungan berbasis hari.
- Guard pembagian dengan nol pada perhitungan yang melakukan pembagian.

## Struktur Proyek

```
lib/
├── app.dart                 # Widget root (App), tema, routing awal
├── main.dart                # Titik masuk aplikasi
├── home.dart                # Navigasi tab utama (lazy, IndexedStack)
├── lainnya_screen.dart      # Layar "Lainnya"
├── fitur/
│   ├── badge/               # Pencapaian (helper, screens)
│   ├── biodata/             # Biodata (enum, model, notifier, screens)
│   ├── dashboard/           # Dashboard (notifier, state, screens)
│   ├── diary_craving/       # Diary craving (enum, model, notifier, state, screens)
│   ├── dummy/               # Data dummy (data, helper, screens)
│   ├── impian/              # Impian (enum, model, notifier, state, screens)
│   ├── kalender_smoke_free/ # Kalender smoke-free (screens)
│   ├── pemulihan_kesehatan/ # Pemulihan kesehatan (screens)
│   ├── pengaturan/          # Pengaturan (screens)
│   ├── sos_craving/         # SOS craving (screens)
│   └── tema/                # Enum dan notifier tema
└── shared/
    ├── db/sqflite/          # AppDatabase, SqfliteOp
    ├── helper/              # SharedKeys
    ├── konstanta/           # NamaTabel, NamaKolom, MilestoneKesehatan
    └── notifikasi/          # NotifikasiService
```

## Penyimpanan Data

- **SQLite** (`berhenti_merokok.db`) melalui `sqflite` untuk data utama (biodata, impian, diary craving).
- **SharedPreferences** untuk preferensi sederhana (tema, status dan waktu pengingat harian).
- Tanggal dan waktu disimpan dalam format UTC ISO8601 dan dikonversi ke waktu lokal saat ditampilkan.
- Skema database saat ini berada pada versi 6, dengan migrasi bertahap untuk penambahan tabel/kolom.
- Pada platform web, SQLite menggunakan `sqflite_common_ffi_web` (file `sqlite3.wasm` dan `sqflite_sw.js` pada folder `web/`).

## Menjalankan Aplikasi

### Prasyarat

- Flutter SDK (sesuai `environment.sdk: ^3.13.7`)
- Dart SDK

### Langkah

1. Pasang dependensi:
   ```bash
   flutter pub get
   ```
2. Jalankan generator kode (jika diperlukan):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

> Pengujian aplikasi saat ini dilakukan melalui Web Server. Kompatibilitas Android tetap menjadi target utama. Build APK dilakukan melalui GitHub Actions.

## Lokalisasi

- Aplikasi mendukung locale Indonesia (`id_ID`).
- Komponen sistem (Material/Cupertino) mengikuti locale yang didukung melalui `flutter_localizations`.

## Platform dan Keterbatasan

- Aplikasi menargetkan Android sebagai platform utama.
- Pengujian melalui Web Server tidak dapat dianggap sebagai bukti bahwa seluruh implementasi berjalan dengan benar di Android.
- Fitur pengingat harian terjadwal tidak tersedia pada platform Web, Linux, dan Windows; pada platform tersebut pengaturan pengingat tidak ditampilkan.
- Notifikasi uji coba dan pengingat harian menggunakan ikon aplikasi (`ic_launcher`).

## Lisensi

Informasi lisensi tidak ditemukan dalam repositori.
