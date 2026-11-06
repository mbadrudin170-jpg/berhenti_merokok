# Tujuan

Mengidentifikasi dan menyusun rekomendasi aturan baru untuk proyek berdasarkan pola, konvensi, dan praktik yang ditemukan dalam kode proyek serta referensi eksternal, khususnya referensi Flutter dan Dart.

Setiap rekomendasi harus relevan dengan kebutuhan dan kondisi proyek, belum tercakup dalam aturan yang sudah ada, serta memiliki usulan lokasi penempatan yang jelas.

# Alur kerja

## 1. Pemeriksaan aturan yang sudah ada

1. Baca terlebih dahulu file `AGENTS.md` di root proyek untuk mengetahui aturan yang sudah berlaku.
2. Periksa juga seluruh file aturan yang relevan agar dapat mengetahui ketentuan yang sudah ditetapkan dan menghindari rekomendasi aturan duplikat.
3. Perhatikan hubungan antara aturan yang sudah ada agar rekomendasi baru tidak bertentangan dengan ketentuan proyek.

## 2. Pemeriksaan kode proyek

1. Pindai seluruh kode di folder `lib/` dan `test/`, termasuk subfolder di dalamnya.
2. Abaikan hanya file dengan ekstensi `.g.dart` dan `.freezed.dart`. File lainnya tetap harus diperiksa.
3. Identifikasi pola, konvensi, dan praktik yang sering muncul dalam kode tetapi belum diatur dalam file aturan yang tersedia.
4. Perhatikan pola implementasi yang digunakan secara berulang, termasuk konsistensi struktur kode, arsitektur, pengelolaan state, pengujian, penggunaan SDK, dan pemanfaatan paket.
5. Dasarkan setiap rekomendasi pada pola kode yang benar-benar ditemukan dalam proyek. Jangan membuat aturan berdasarkan asumsi atau kebiasaan pribadi AI.

## 3. Pencarian referensi eksternal

1. Lakukan pencarian referensi melalui web dan GitHub untuk menemukan aturan, praktik, konvensi, serta rekomendasi yang biasa digunakan oleh pengembang Flutter dan Dart.
2. Cari aturan yang digunakan oleh proyek lain, termasuk proyek open source, boilerplate, dokumentasi, dan konfigurasi AI coding agent.
3. Prioritaskan referensi yang relevan dengan teknologi, arsitektur, struktur kode, dan paket yang digunakan dalam proyek ini.
4. Jangan hanya mencari aturan secara umum. Perhatikan juga bagaimana proyek lain menerapkan aturan tersebut dalam kode dan dokumentasinya.
5. Gunakan hasil pencarian sebagai bahan evaluasi, bukan sebagai aturan yang otomatis harus diterapkan.
6. Pilih rekomendasi yang sesuai dengan kebutuhan, struktur, dan kondisi aktual proyek.

## 4. Pemeriksaan referensi wajib

Seluruh tautan pada daftar referensi di bawah wajib diperiksa satu per satu. Jangan melewatkan satu pun tautan yang tercantum.

### 4.1. GitHub

- https://github.com/flutter/flutter

### 4.2. Dokumentasi resmi Flutter

- https://docs.flutter.dev/resources/inside-flutter
- https://docs.flutter.dev/app-architecture/concepts#layered-architecture
- https://docs.flutter.dev/app-architecture/guide
- https://docs.flutter.dev/app-architecture/case-study
- https://docs.flutter.dev/app-architecture/case-study/ui-layer
- https://docs.flutter.dev/app-architecture/case-study/data-layer
- https://docs.flutter.dev/app-architecture/case-study/testing
- https://docs.flutter.dev/app-architecture/case-study/dependency-injection
- https://docs.flutter.dev/app-architecture/design-patterns
- https://docs.flutter.dev/app-architecture/recommendations
- https://docs.flutter.dev/perf/rendering-performance
- https://docs.flutter.dev/perf/best-practices
- https://docs.flutter.dev/perf/antialiasing
- https://docs.flutter.dev/perf/impeller
- https://docs.flutter.dev/perf
- https://docs.flutter.dev/perf/isolates
- https://docs.flutter.dev/ui/design/text/typography
- https://docs.flutter.dev/ui/interactivity/focus
- https://docs.flutter.dev/ui/internationalization

### 4.3. Referensi GitHub lainnya

- https://github.com/aios-labs/projectrules/blob/main/data/rules/manual/flutter.md
- https://github.com/firebase/flutterfire/blob/main/.gemini/styleguide.md
- https://github.com/aios-labs/projectrules/blob/main/data/rules/manual/riverpod.md
- https://github.com/ittae/clean_architecture_linter
- https://github.com/flutter/flutter/blob/master/.github/PULL_REQUEST_TEMPLATE.md

### 4.4. Ketentuan pemeriksaan referensi

1. Periksa isi setiap tautan, bukan hanya nama atau deskripsinya.
2. Identifikasi aturan, praktik, atau rekomendasi yang relevan dari setiap referensi.
3. Jangan menganggap seluruh isi referensi harus diterapkan ke proyek.
4. Jika suatu tautan tidak dapat diakses, catat tautan tersebut beserta kendala yang ditemukan. Jangan menganggapnya sudah diperiksa.
5. Jangan menyatakan seluruh referensi sudah diperiksa apabila masih ada tautan yang belum berhasil diperiksa.

## 5. Pencarian referensi tambahan

1. Jangan membatasi pencarian hanya pada daftar tautan wajib di atas.
2. Daftar tersebut merupakan referensi awal yang wajib diperiksa, bukan satu-satunya sumber pencarian.
3. Selalu cari referensi tambahan dari web dan GitHub untuk menemukan praktik serta aturan lain yang mungkin lebih relevan dengan proyek.
4. Utamakan pencarian referensi mengenai:
   - Flutter Architecture Patterns.
   - Flutter Clean Architecture Boilerplate.
   - Flutter Architecture Hub.
   - Flutter Riverpod Best Practices.
   - Dart Best Practices.
   - Flutter Testing Best Practices.
   - Flutter Performance Best Practices.
   - Flutter Project Structure.
   - AI Coding Agent Rules untuk Flutter dan Dart.
5. Gunakan kata kunci pencarian yang sesuai untuk menemukan proyek, dokumentasi, dan aturan yang relevan.
6. Jangan membatasi hasil pencarian pada daftar kategori di atas apabila terdapat referensi lain yang lebih sesuai dengan kebutuhan proyek.

## 6. Evaluasi dan pemilihan saran aturan

1. Bandingkan hasil pemeriksaan kode proyek dengan aturan yang sudah tersedia dan referensi eksternal.
2. Identifikasi aturan yang belum tersedia tetapi relevan untuk meningkatkan konsistensi, kualitas, pemeliharaan, dan keandalan kode proyek.
3. Pilih hanya aturan yang sesuai dengan teknologi, paket, arsitektur, dan pola implementasi proyek.
4. Jangan menyalin aturan dari referensi eksternal tanpa mengevaluasi kesesuaiannya.
5. Jangan merekomendasikan aturan yang sudah tercakup dalam `AGENTS.md` atau file aturan lainnya.
6. Jika suatu aturan sudah ada tetapi redaksinya belum mencakup praktik tertentu, bedakan antara rekomendasi aturan baru dan rekomendasi penyempurnaan aturan yang sudah ada.
7. Jangan membuat rekomendasi yang bertentangan dengan aturan proyek yang berlaku.
8. Jangan mengubah tingkat kewajiban suatu aturan dari sumber aslinya tanpa alasan yang jelas.
9. Jika terdapat beberapa alternatif aturan, pilih yang paling sesuai dengan kondisi proyek dan jelaskan alasannya.

## 7. Penentuan lokasi aturan baru

Untuk setiap saran aturan, tentukan lokasi penempatannya berdasarkan ketentuan berikut:

1. Jika aturan tersebut sesuai dengan salah satu file yang sudah tersedia di folder `prompt/aturan/`, sebutkan nama file yang direkomendasikan sebagai lokasi penambahannya.
2. Jika aturan tersebut tidak sesuai dengan cakupan file aturan yang tersedia, rekomendasikan pembuatan file aturan baru di folder `prompt/aturan/`.
3. Jika merekomendasikan file baru, berikan nama file dan jelaskan cakupan aturan yang akan ditampung di dalamnya.
4. Jangan menambahkan aturan secara langsung ke file tujuan. Cukup berikan rekomendasi lokasi penempatannya.
5. Pastikan lokasi yang direkomendasikan sesuai dengan fungsi dan ruang lingkup aturan tersebut.

## 8. Penulisan hasil rekomendasi

1. Tulis seluruh hasil rekomendasi ke file `saran_aturan_baru.md` di root proyek.
2. Gunakan format penulisan yang konsisten dan mudah dipahami.
3. Setiap saran harus menjelaskan:
   - Aturan yang direkomendasikan.
   - Alasan aturan tersebut diperlukan.
   - Pola kode atau referensi yang menjadi dasar rekomendasi.
   - Lokasi file aturan yang direkomendasikan untuk menampung aturan tersebut.
4. Sertakan tautan referensi yang mendukung rekomendasi apabila berasal dari sumber eksternal.
5. Pisahkan saran aturan baru dan saran penyempurnaan aturan yang sudah tersedia.
6. Hindari pengulangan rekomendasi yang memiliki maksud sama.

## 9. Pemeriksaan dan pembersihan hasil

1. Periksa kembali seluruh isi `saran_aturan_baru.md`.
2. Cocokkan setiap saran dengan `AGENTS.md` dan file aturan lainnya.
3. Jika ternyata suatu saran sudah tercakup dalam `AGENTS.md`, hapus saran tersebut dari `saran_aturan_baru.md`.
4. Jika saran sudah tercakup dalam file aturan lainnya, jangan mempertahankannya sebagai aturan baru. Evaluasi apakah saran tersebut merupakan penyempurnaan yang memang belum tercakup.
5. Pastikan tidak ada rekomendasi duplikat.
6. Pastikan seluruh saran memiliki dasar yang jelas dan lokasi penempatan yang sesuai.

# Larangan

1. Dilarang mengedit, menambah, atau menghapus kode Dart.
2. Dilarang mengubah isi `AGENTS.md` maupun file aturan yang sudah ada.
3. Dilarang menambahkan aturan baru secara langsung ke folder `prompt/aturan/`.
4. Dilarang membuat rekomendasi aturan berdasarkan asumsi yang tidak didukung oleh kode proyek atau referensi.
5. Dilarang menyalin aturan dari proyek lain tanpa mengevaluasi kesesuaiannya dengan proyek ini.
6. Dilarang mempertahankan saran aturan yang ternyata sudah tercakup dalam `AGENTS.md`.
7. Dilarang membuat rekomendasi aturan yang duplikat.
8. Dilarang menganggap tautan referensi sudah diperiksa apabila belum benar-benar diakses dan diperiksa isinya.

# Ketentuan

## 1. File yang boleh diperbarui

Hanya file berikut yang boleh diperbarui dalam pelaksanaan tugas ini:

- `saran_aturan_baru.md` di root proyek.

File kode Dart dan file aturan yang sudah ada tidak boleh diubah.

## 2. Fokus rekomendasi

Berikan perhatian khusus pada aturan yang berkaitan dengan Flutter dan Dart, termasuk arsitektur aplikasi, struktur kode, pengelolaan state, penggunaan SDK, pengujian, performa, konsistensi implementasi, dan praktik pengembangan lainnya yang relevan dengan proyek.

## 3. Hasil akhir

Setelah seluruh proses selesai, laporkan:

1. Ringkasan pola dan praktik yang ditemukan dalam kode proyek.
2. Daftar saran aturan baru.
3. Daftar saran penyempurnaan aturan yang sudah ada.
4. Lokasi file di `prompt/aturan/` yang direkomendasikan untuk setiap saran.
5. Referensi web dan GitHub yang digunakan.
6. Tautan wajib yang tidak berhasil diperiksa beserta alasannya.
7. Konfirmasi bahwa kode Dart dan file aturan yang sudah ada tidak diubah.
