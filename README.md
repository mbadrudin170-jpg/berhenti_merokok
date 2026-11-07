# Berhenti Merokok

Aplikasi mobile pendamping proses berhenti merokok yang membantu pengguna mencatat data pribadi, memantau progres, dan mengelola impian (tujuan) yang ingin dicapai. Aplikasi dibangun dengan Flutter dan berjalan secara luring (*offline-first*) dengan penyimpanan lokal berbasis SQLite.

## Tujuan Aplikasi

Aplikasi ini dirancang untuk mendukung pengguna yang sedang berupaya berhenti merokok dengan menyediakan:

- Pencatatan biodata pengguna, termasuk riwayat merokok dan tanggal mulai berhenti merokok.
- Pengelolaan daftar impian (tujuan) beserta target jumlah dan target tanggal.
- Penyesuaian tampilan tema aplikasi (sistem, terang, gelap).
- Penyediaan data dummy untuk keperluan pengujian dan pengembangan.

## Fitur Utama

### 1. Biodata Pengguna

- Menyimpan dan menampilkan data biodata pengguna: nama, tanggal lahir, jumlah rokok per hari, harga rokok per bungkus, tanggal mulai merokok, dan tanggal mulai berhenti merokok.
- Mendukung alur pertama kali (onboarding): pengguna baru diarahkan ke formulir biodata sebelum masuk ke aplikasi.
- Mendukung mode ubah: biodata yang sudah ada dapat diperbarui tanpa membuat data baru.
- Data disimpan secara lokal di SQLite dan dimuat ulang saat aplikasi dijalankan.

### 2. Impian (Tujuan)

- Menampilkan daftar impian dengan nama, jumlah target, dan target tanggal.
- Mendukung penambahan, pengubahan, dan penghapusan impian.
- Menyediakan halaman detail impian dengan aksi ubah.
- Menampilkan state kosong ("Belum ada impian") beserta tombol tambah untuk menambah impian pertama.
- Setiap item daftar memiliki identitas stabil (`ValueKey`) agar posisi scroll dan identitas item tetap konsisten.
- Daftar menggunakan `ListView.separated` untuk efisiensi pada jumlah data yang besar.

### 3. Tema Aplikasi

- Pilihan tema: Sistem, Terang, dan Gelap.
- Preferensi tema disimpan melalui `SharedPreferences` dan dipulihkan saat aplikasi dijalankan.
- Tampilan komponen `material_ui` (termasuk dialog) mengikuti mode tema aktif.

### 4. Data Dummy

- Menyediakan operasi masukkan, hapus, dan reset data dummy untuk biodata dan impian.
- Data dummy menggunakan tanggal relatif terhadap waktu sekarang agar tetap realistis.
- Setelah operasi dummy, provider data diperbarui sehingga UI menampilkan data terbaru.
- Dialog konfirmasi ditampilkan sebelum operasi dijalankan.

### 5. Navigasi Utama

- Tab utama: Dashboard, Biodata, Impian, dan Lainnya.
- Inisialisasi tab secara *lazy*: tab hanya dibangun saat pertama kali dipilih, lalu state-nya dipertahankan.
- Double-tap pada tab aktif memicu scroll ke atas (jika tab mendukung).

### 6. Pengaturan

- Halaman pengaturan menyediakan pemilihan tema aplikasi melalui menu popup.
- Penanganan error pada aksi ubah tema dicatat melalui logger proyek.

### Catatan

- Tab **Dashboard** saat ini menampilkan layar placeholder dan belum memiliki konten fungsional.
- Fitur lain yang mungkin dirujuk dalam dokumentasi perencanaan (misalnya jadwal service, statistik bahan bakar, tabungan) belum diimplementasikan pada kode saat ini.

## Teknologi yang Digunakan

### Framework dan Bahasa

- **Flutter** (SDK `^3.13.7`)
- **Dart**

### Dependensi Utama

| Paket | Kegunaan |
| --- | --- |
| `flutter_riverpod` | Pengelolaan state reaktif |
| `riverpod_annotation` / `riverpod_generator` | Generator provider dan notifier |
| `freezed` / `freezed_annotation` | State dan model immutable |
| `sqflite` | Database SQLite lokal |
| `sqflite_common_ffi_web` | Dukungan SQLite pada platform web |
| `shared_preferences` | Penyimpanan preferensi sederhana (tema) |
| `flutter_easyloading` | Overlay loading pada aksi simpan |
| `adaptive_dialog` | Dialog konfirmasi adaptif |
| `material_ui` | Komponen UI adaptif (termasuk lokalisasi) |
| `uuid` | Pembuatan ID unik |
| `collection` | Utilitas koleksi (`sorted`, `firstWhereOrNull`, `maxBy`) |
| `cupertino_icons` | Ikon Cupertino |
| `share_global_saya` (path lokal) | Widget dan helper reusable (`InputTeks`, `Nav`, `AppToast`, dll.) |

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
- **State (Freezed)**: representasi state immutable, termasuk field turunan (jumlah, total).
- **Model (Freezed)**: representasi data dengan factory `fromSqflite` dan metode `toSqflite`.
- **Shared**: konstanta skema database (`NamaTabel`, `NamaKolom`), operasi CRUD generik (`SqfliteOp`), dan helper bersama.

Prinsip utama:

- *Offline-first*: seluruh data utama disimpan di SQLite lokal.
- State management menggunakan Riverpod dengan generator.
- State dan model menggunakan Freezed (immutable).
- Penanganan `AsyncValue` mengikuti urutan loading → error → data.
- Operasi asynchronous dibungkus `try/catch`, dicatat dengan logger `L`, dan diteruskan dengan `rethrow`.

## Struktur Proyek

```
lib/
├── app.dart                 # Widget root (App), tema, routing awal
├── main.dart                # Titik masuk aplikasi
├── home.dart                # Navigasi tab utama (lazy)
├── lainnya_screen.dart      # Layar "Lainnya"
├── fitur/
│   ├── biodata/             # Biodata pengguna (model, notifier, screens)
│   ├── dashboard/           # Dashboard (placeholder)
│   ├── dummy/               # Data dummy (helper, screens, data)
│   ├── impian/              # Impian (model, notifier, state, screens)
│   ├── pengaturan/          # Pengaturan (tema)
│   └── tema/                # Enum dan notifier tema
└── shared/
    ├── db/sqflite/          # AppDatabase, SqfliteOp
    ├── helper/              # SharedKeys
    └── konstanta/           # NamaTabel, NamaKolom
```

## Penyimpanan Data

- **SQLite** (`berhenti_merokok.db`) melalui `sqflite` untuk data utama (biodata, impian).
- **SharedPreferences** untuk preferensi sederhana (tema).
- Tanggal dan waktu disimpan dalam format UTC ISO8601 dan dikonversi ke waktu lokal saat ditampilkan.
- Skema database saat ini berada pada versi 3, dengan migrasi untuk penambahan tabel/kolom.

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

> Pengujian aplikasi saat ini dilakukan melalui Web Server. Kompatibilitas Android tetap menjadi target utama.

## Lokalisasi

- Aplikasi mendukung locale Indonesia (`id_ID`).
- Komponen sistem (Material/Cupertino) mengikuti locale yang didukung.

## Lisensi

Informasi lisensi tidak ditemukan dalam repositori.