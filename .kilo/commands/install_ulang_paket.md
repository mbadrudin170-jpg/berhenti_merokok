---
description: Instal ulang seluruh paket dalam pubspec.yaml satu per satu menggunakan flutter pub add, perbarui ke versi stabil terbaru yang kompatibel, lalu susun dependency berdasarkan abjad.
agent: code
---

# INSTALL ULANG SELURUH PAKET FLUTTER

## TUJUAN

Lakukan instalasi ulang seluruh paket yang tercantum dalam `pubspec.yaml` menggunakan perintah `flutter pub add`.

Tujuan utama:

1. Memperbarui batasan versi paket agar menggunakan versi stabil terbaru yang kompatibel dengan SDK dan dependency lainnya.
2. Memastikan seluruh paket diproses satu per satu.
3. Memastikan tidak ada paket yang dihapus.
4. Menyusun seluruh nama paket berdasarkan urutan abjad setelah proses instalasi selesai.
5. Mempertahankan struktur dan konfigurasi dependency yang sudah ada.

**Prinsip utama:** Jangan menghapus paket. Gunakan `flutter pub add` untuk memperbarui dependency yang sudah terdaftar.

---

# TAHAP 1 — MEMERIKSA KONDISI PROYEK

Sebelum melakukan instalasi:

1. Pastikan berada di root proyek Flutter.
2. Baca seluruh isi `pubspec.yaml`.
3. Baca `pubspec.lock` jika tersedia.
4. Periksa versi Flutter dan Dart yang sedang digunakan.
5. Identifikasi seluruh paket berdasarkan kelompok dependency.

Periksa menggunakan:

```bash
flutter --version
git status --short
```

Identifikasi paket dari bagian:

- `dependencies`
- `dev_dependencies`
- `dependency_overrides`

Catat seluruh nama paket dan sumber dependency sebelum melakukan perubahan.

Jangan melewatkan paket hanya karena sumbernya berasal dari Git, path lokal, atau Flutter SDK.

---

# TAHAP 2 — MENGIDENTIFIKASI JENIS PAKET

Sebelum menjalankan instalasi, kelompokkan paket berdasarkan jenis dan lokasinya.

## A. Dependencies biasa

Paket yang berada di bagian `dependencies` dan berasal dari pub.dev.

Contoh:

```yaml
dependencies:
  http: ^1.0.0
  intl: ^0.19.0
```

Gunakan:

```bash
flutter pub add http
```

## B. Dev dependencies

Paket yang berada di bagian `dev_dependencies`.

Contoh:

```yaml
dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^3.0.0
```

Gunakan:

```bash
flutter pub add dev:build_runner
```

Jangan menambahkan paket development ke bagian `dependencies`.

## C. Dependency overrides

Paket yang berada di bagian `dependency_overrides`.

Gunakan prefix `override:` agar paket tetap diproses sebagai dependency override.

Contoh:

```bash
flutter pub add override:nama_paket
```

Pertahankan tujuan dan sumber dependency override yang sudah digunakan.

## D. Flutter SDK dan Dart SDK dependencies

Jika paket menggunakan sumber SDK, pertahankan sumber tersebut.

Contoh:

```yaml
dependencies:
  flutter:
    sdk: flutter
```

Perintah:

```bash
flutter pub add "flutter:{sdk: flutter}"
```

Contoh dev dependency:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

Perintah:

```bash
flutter pub add "dev:flutter_test:{sdk: flutter}"
```

Paket SDK tidak memiliki versi pub.dev yang dapat diperbarui secara independen. Versinya mengikuti SDK yang digunakan.

## E. Git dependencies

Jika paket menggunakan Git, pertahankan:

- URL repository.
- Branch atau tag.
- Commit reference.
- Subdirectory jika tersedia.

Jangan mengubah sumber Git menjadi pub.dev.

Contoh format:

```bash
flutter pub add 'nama_paket:{git: {url: https://github.com/contoh/paket.git, ref: main}}'
```

Untuk paket dengan ref commit tertentu, pertahankan ref tersebut. Jangan mengubahnya secara otomatis.

## F. Path dependencies

Jika paket menggunakan path lokal, pertahankan lokasi path yang sudah terdaftar.

Contoh:

```bash
flutter pub add 'nama_paket:{path: ../nama_paket}'
```

Jangan mengganti path dependency menjadi paket pub.dev.

**Penting:** Seluruh paket harus dipertahankan sesuai sumber dependency aslinya. Jangan sampai proses pembaruan versi mengubah jenis dependency tanpa alasan.

---

# TAHAP 3 — INSTALASI PAKET SATU PER SATU

Ini merupakan ketentuan utama command ini.

**WAJIB menjalankan `flutter pub add` untuk setiap paket secara terpisah.**

Ketentuan:

1. Jalankan `flutter pub add` untuk satu paket saja.
2. Tunggu sampai proses instalasi dan dependency resolution selesai.
3. Periksa hasil perintah dan exit code.
4. Pastikan paket berhasil diproses.
5. Baru jalankan `flutter pub add` untuk paket berikutnya.
6. Ulangi sampai seluruh paket selesai diproses.

Contoh yang benar:

```bash
flutter pub add http
```

Tunggu sampai selesai, kemudian:

```bash
flutter pub add intl
```

Tunggu sampai selesai, kemudian:

```bash
flutter pub add dev:build_runner
```

Lanjutkan sampai seluruh paket selesai.

**DILARANG menjalankan beberapa paket dalam satu perintah.**

Contoh salah:

```bash
flutter pub add http intl dio
```

Contoh salah:

```bash
flutter pub add http & flutter pub add intl
```

Contoh benar:

```bash
flutter pub add http
```

Setelah selesai:

```bash
flutter pub add intl
```

Jangan menjalankan instalasi secara paralel.

Setiap perintah harus selesai sebelum perintah berikutnya dimulai.

## Ketentuan pembaruan versi

Untuk paket dari pub.dev yang sudah terdaftar, gunakan `flutter pub add` tanpa menetapkan versi secara manual agar Pub memilih versi stabil terbaru yang kompatibel.

Jangan mempertahankan batasan versi lama secara manual apabila tujuan proses ini adalah memperbarui batasan versi melalui `flutter pub add`.

Namun:

- Jangan mengubah batasan SDK proyek hanya untuk memaksakan versi paket terbaru.
- Jangan memaksa penggunaan versi yang tidak kompatibel.
- Jangan menggunakan versi prerelease atau beta jika tidak diminta.
- Jangan mengubah sumber dependency.
- Jangan mengubah paket SDK, Git, atau path menjadi hosted dependency.

## Jika instalasi gagal

Jika suatu paket gagal diproses:

1. Hentikan proses instalasi berikutnya.
2. Baca pesan error secara lengkap.
3. Identifikasi penyebab kegagalan.
4. Jangan menghapus paket yang gagal.
5. Jangan menghapus dependency lain untuk mengatasi konflik.
6. Jangan mengubah batasan SDK secara otomatis.
7. Jangan memaksakan versi yang tidak kompatibel.
8. Laporkan paket yang gagal, penyebabnya, dan paket yang belum diproses.

Jangan mengklaim seluruh paket berhasil diperbarui jika masih ada paket yang gagal.

---

# TAHAP 4 — MENYUSUN PAKET BERDASARKAN ABJAD

Setelah seluruh paket berhasil diproses, susun nama paket berdasarkan urutan abjad.

Pengurutan dilakukan secara terpisah pada setiap bagian:

1. `dependencies`
2. `dev_dependencies`
3. `dependency_overrides`

Contoh sebelum:

```yaml
dependencies:
  supabase_flutter: ^2.0.0
  http: ^1.0.0
  dio: ^5.0.0
  cached_network_image: ^3.0.0
```

Contoh sesudah:

```yaml
dependencies:
  cached_network_image: ^3.0.0
  dio: ^5.0.0
  http: ^1.0.0
  supabase_flutter: ^2.0.0
```

Ketentuan:

1. Urutkan berdasarkan nama paket secara alfabetis A–Z.
2. Lakukan pengurutan pada setiap kelompok dependency secara terpisah.
3. Jangan menggabungkan `dependencies` dengan `dev_dependencies`.
4. Jangan memindahkan paket dari kelompok asalnya.
5. Jangan mengubah versi atau sumber dependency ketika mengurutkan.
6. Pertahankan konfigurasi SDK.
7. Pertahankan komentar dan konfigurasi YAML yang sudah ada.
8. Jangan mengubah bagian `environment`, `flutter`, atau bagian lainnya hanya untuk keperluan pengurutan.
9. Jangan mengurutkan isi `dependency_overrides` berdasarkan versi; urutkan hanya berdasarkan nama paket.

Gunakan pendekatan yang menjaga struktur YAML dan komentar.

Jangan menulis ulang seluruh `pubspec.yaml` dengan cara yang berisiko menghilangkan konfigurasi atau komentar.

---

# TAHAP 5 — PEMERIKSAAN HASIL

Setelah instalasi dan pengurutan selesai, baca kembali seluruh isi `pubspec.yaml` dan periksa `pubspec.lock`.

Pastikan:

1. Semua paket awal masih tersedia.
2. Tidak ada paket yang terhapus.
3. Tidak ada paket yang berpindah kelompok tanpa alasan.
4. Batasan versi paket telah diperbarui sesuai hasil `flutter pub add`.
5. Sumber dependency tetap benar.
6. Tidak ada dependency yang terduplikasi.
7. Nama paket sudah tersusun berdasarkan abjad.
8. Struktur YAML tetap valid.
9. `pubspec.lock` mencerminkan hasil resolusi dependency terakhir.
10. Tidak ada perubahan tidak sengaja pada bagian lain dari `pubspec.yaml`.

Bandingkan daftar paket sebelum dan sesudah instalasi.

Jika jumlah atau identitas paket berubah tanpa alasan yang dapat dijelaskan, hentikan proses dan laporkan perbedaannya.

Jika seluruh paket sudah diproses, jalankan:

```bash
flutter analyze
```

Gunakan hasilnya untuk mengetahui apakah pembaruan dependency menyebabkan masalah analisis.

Jangan memperbaiki kode sumber secara otomatis karena perbaikan kode bukan bagian dari ruang lingkup command ini.

---

# LARANGAN

1. DILARANG menghapus paket dari `pubspec.yaml`.
2. DILARANG menjalankan `flutter pub remove`.
3. DILARANG menghapus dependency hanya karena terjadi konflik versi.
4. DILARANG menjalankan beberapa perintah `flutter pub add` sekaligus.
5. DILARANG menjalankan instalasi paket secara paralel.
6. DILARANG mengubah versi Flutter atau Dart SDK.
7. DILARANG mengubah batasan SDK hanya untuk memaksakan versi paket terbaru.
8. DILARANG mengubah sumber dependency Git menjadi pub.dev.
9. DILARANG mengubah path dependency menjadi hosted dependency.
10. DILARANG menghapus dependency override tanpa alasan dan persetujuan.
11. DILARANG menggunakan versi prerelease atau beta tanpa permintaan pengguna.
12. DILARANG mengubah kode sumber aplikasi.
13. DILARANG melakukan refactoring yang tidak berkaitan.
14. DILARANG menimpa konfigurasi `pubspec.yaml` secara keseluruhan.
15. DILARANG menghapus `pubspec.lock` untuk memaksa pembaruan versi.
16. DILARANG mengklaim instalasi berhasil jika masih terdapat paket yang gagal.
17. DILARANG melanjutkan ke paket berikutnya sebelum instalasi paket saat ini selesai.

---

# KETENTUAN

1. Seluruh paket dalam `pubspec.yaml` harus didata sebelum instalasi.
2. Setiap paket harus diproses menggunakan `flutter pub add`.
3. Setiap perintah hanya boleh memproses satu paket.
4. Tunggu setiap proses instalasi selesai sebelum menjalankan perintah berikutnya.
5. Pertahankan kategori dependency masing-masing paket.
6. Pertahankan sumber dependency masing-masing paket.
7. Gunakan versi stabil terbaru yang kompatibel dengan SDK dan dependency lainnya.
8. Jika terjadi konflik, cari tahu penyebabnya tanpa menghapus paket.
9. Setelah semua paket berhasil diproses, susun nama paket berdasarkan abjad.
10. Pertahankan format dan struktur YAML.
11. Periksa kembali seluruh paket setelah instalasi.
12. Jalankan `flutter analyze` setelah proses berhasil.
13. Laporkan setiap kendala yang tidak dapat diselesaikan.
14. Jangan mengubah kode sumber aplikasi.
15. Jangan melakukan perubahan di luar ruang lingkup pengelolaan dependency.

---

# BATASAN RUANG LINGKUP

Command ini hanya bertugas melakukan instalasi ulang dan pengelolaan dependency dalam `pubspec.yaml`.

Pekerjaan yang diperbolehkan:

- Membaca `pubspec.yaml`.
- Membaca `pubspec.lock`.
- Mengidentifikasi seluruh dependency.
- Menjalankan `flutter pub add` untuk setiap paket secara berurutan.
- Memperbarui batasan versi dependency sesuai hasil resolusi.
- Mempertahankan sumber dependency.
- Mengurutkan paket berdasarkan abjad.
- Memeriksa hasil instalasi.
- Memeriksa hasil analisis menggunakan `flutter analyze`.

Pekerjaan yang tidak termasuk ruang lingkup:

- Menghapus paket.
- Mengganti paket dengan alternatif lain.
- Mengubah arsitektur aplikasi.
- Mengubah kode sumber.
- Memperbaiki error kode aplikasi.
- Mengubah versi Flutter atau Dart SDK.
- Mengubah struktur folder proyek.
- Melakukan refactoring.
- Mengubah konfigurasi selain yang diperlukan untuk mempertahankan dependency.

Jika pembaruan paket menyebabkan error pada kode aplikasi, cukup laporkan error tersebut beserta paket yang berkaitan. Jangan memperbaiki kode secara otomatis.

---

# LAPORAN HASIL

Setelah seluruh proses selesai, berikan laporan dengan format:

## 1. Ringkasan instalasi

- Jumlah paket awal.
- Jumlah paket berhasil diproses.
- Jumlah paket gagal diproses.
- Jumlah paket yang belum diproses.

## 2. Daftar paket

| No. | Nama paket | Kelompok | Status | Versi sebelum | Versi sesudah |
| --- | ---------- | -------- | ------ | ------------- | ------------- |

Tampilkan seluruh paket yang diproses.

Untuk paket Git, path, atau SDK yang tidak menggunakan versi pub.dev, jelaskan sumber dependency-nya.

## 3. Hasil pengurutan

Jelaskan bahwa:

- `dependencies` sudah urut abjad.
- `dev_dependencies` sudah urut abjad.
- `dependency_overrides` sudah urut abjad jika tersedia.

## 4. Hasil pemeriksaan

Jelaskan:

- Apakah seluruh paket berhasil diproses.
- Apakah ada paket yang gagal.
- Apakah ada konflik dependency.
- Apakah struktur YAML tetap valid.
- Hasil `flutter analyze`.

## 5. File yang berubah

Tampilkan path file yang benar-benar diperbarui.

Contoh:

```text
pubspec.yaml
pubspec.lock
```

Jangan mencantumkan file yang tidak mengalami perubahan.

## 6. Kesimpulan

Berikan kesimpulan apakah seluruh paket berhasil diperbarui, apakah masih ada kendala, dan apakah seluruh nama paket sudah tersusun berdasarkan abjad.

---

# HASIL AKHIR YANG DIHARAPKAN

Seluruh paket dalam `pubspec.yaml` telah diproses satu per satu menggunakan `flutter pub add`, tanpa menghapus satu pun paket.

Paket dari pub.dev menggunakan versi stabil terbaru yang kompatibel dengan SDK dan dependency lainnya.

Seluruh nama paket tersusun berdasarkan abjad pada kelompok dependency masing-masing.

Struktur YAML, kategori dependency, dan sumber dependency tetap terjaga.

Tidak ada perubahan kode aplikasi di luar ruang lingkup pengelolaan dependency.
