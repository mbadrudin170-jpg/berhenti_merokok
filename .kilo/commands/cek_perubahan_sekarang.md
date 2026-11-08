---
description: Evaluasi commit baru terhadap aturan proyek dan source SDK/paket, lalu perbarui checkpoint serta saran tanpa mengubah kode.
agent: code
---

<!-- Lokasi file di repository: .kilo/commands/cek_perubahan_sekarang.md -->

# Evaluasi Perubahan Commit Terbaru

## 1. Tujuan dan Hasil yang Diharapkan

Evaluasi seluruh commit yang belum pernah diperiksa oleh command ini. Pastikan perubahan yang di-commit sesuai dengan:

1. `AGENTS.md` dan seluruh aturan proyek yang berlaku.
2. Source Flutter SDK, Dart SDK, dan source paket pada versi yang benar-benar digunakan proyek.
3. API, konstruktor, parameter, properti, metode, enum, callback, nilai balik, dan perilaku bawaan yang tersedia pada versi tersebut.
4. Ketentuan penggunaan API yang tidak deprecated.
5. Ketentuan runtime, keamanan, performa, data, testing, dan UX/UI yang relevan.

Hasil evaluasi harus:

- Menjelaskan perubahan yang diperiksa dan commit asalnya.
- Menyebutkan setiap pelanggaran aturan beserta path dan nomor baris kode serta aturan yang dilanggar.
- Menyebutkan bukti pemeriksaan source SDK/paket beserta versi dan path sumbernya.
- Memberikan saran perbaikan apabila ditemukan masalah.
- Memperbarui `saran.md` apabila ada saran baru atau saran lama yang perlu diperbarui.
- Memperbarui checkpoint dan ringkasan terakhir di `catatan.md` agar commit yang sama tidak perlu dievaluasi ulang.
- Menyajikan laporan akhir dengan format yang mudah dibaca.

Command ini adalah **audit dan dokumentasi**, bukan command implementasi.

## 2. Batasan Mutlak

Selama command dijalankan, patuhi ketentuan berikut:

1. Jangan mengubah kode Dart.
2. Jangan mengubah kode sumber bahasa pemrograman apa pun.
3. Jangan memperbaiki bug, melakukan refactoring, menambah fitur, atau mengubah perilaku aplikasi.
4. Jangan mengubah `pubspec.yaml`, `pubspec.lock`, konfigurasi, migrasi database, file test, file aturan, atau file command.
5. Jangan menjalankan formatter atau generator yang mengubah file.
6. Jangan menjalankan operasi Git yang mengubah repository atau riwayat, termasuk `commit`, `push`, `reset`, `rebase`, `checkout`, `switch`, `merge`, `cherry-pick`, `stash`, dan operasi sejenis.
7. Jangan memasukkan perubahan working tree yang belum di-commit ke dalam hasil evaluasi commit.
8. Jangan menghapus atau menimpa perubahan lokal pengguna.
9. Jangan mengarang aturan, hasil pemeriksaan source, nomor baris, versi paket, atau kesimpulan.
10. Jangan menyatakan pemeriksaan SDK selesai apabila source yang relevan belum dibaca.
11. Jangan memajukan checkpoint apabila masih ada commit atau pemeriksaan wajib yang belum selesai.
12. Jangan menyertakan tautan/link dalam laporan atau entri `saran.md`. Gunakan path file biasa beserta nomor baris.

**File repository yang boleh diperbarui oleh command ini hanya:**

- `catatan.md` di root repository.
- `saran.md` di root repository.

File lain hanya boleh dibaca. Apabila salah satu dari dua file tersebut memiliki perubahan lokal yang belum di-commit, jangan menimpa perubahan pengguna. Lakukan pembaruan hanya jika dapat mempertahankan seluruh perubahan lokal dengan aman. Jika tidak aman, jangan menulis ke file tersebut dan jangan memajukan checkpoint.

## 3. Pemeriksaan Awal Repository

Lakukan pemeriksaan berikut sebelum membaca rentang commit:

1. Pastikan direktori aktif adalah root repository Git dengan `git rev-parse --show-toplevel`.
2. Catat branch aktif dengan `git branch --show-current`.
3. Catat apakah repository berada pada detached HEAD.
4. Ambil SHA lengkap HEAD dengan `git rev-parse HEAD`.
5. Periksa kondisi working tree dengan `git status --short`.
6. Catat perubahan staged, unstaged, dan untracked secara terpisah.
7. Tetapkan SHA HEAD tersebut sebagai `TARGET_HEAD` dan jangan menggantinya di tengah evaluasi.

Jika HEAD berubah sebelum pencatatan akhir, batalkan pembaruan checkpoint. Jangan mencampur hasil evaluasi dari dua HEAD yang berbeda.

Detached HEAD tidak otomatis menggagalkan evaluasi. Jika SHA HEAD valid dan rentang commit dapat ditentukan, evaluasi tetap dapat dilakukan dengan melaporkan bahwa repository berada pada detached HEAD.

## 4. Membaca Aturan Proyek Sebelum Menganalisis Kode

**Jangan mulai menilai perubahan kode sebelum membaca aturan yang berlaku.**

### 4.1. Urutan Membaca Aturan

1. Baca `AGENTS.md` di root repository secara menyeluruh.
2. Ikuti instruksi dan referensi file yang ditentukan oleh `AGENTS.md`.
3. Cari `AGENTS.md` tambahan pada direktori atau induk direktori dari setiap file yang berubah.
4. Temukan dan baca file aturan yang berlaku di repository, termasuk aturan pada `.agents/`, `.kilo/rules/`, `.kilocode/rules/`, `prompt/aturan/`, atau lokasi lain yang benar-benar ditemukan.
5. Periksa aturan umum dan aturan khusus proyek yang berhubungan dengan file atau jenis perubahan yang sedang dievaluasi.
6. Baca instruksi Skills yang secara eksplisit diwajibkan oleh aturan proyek dan relevan dengan API atau teknologi yang berubah.
7. Catat path dan nomor baris aturan yang berpotensi menjadi dasar penilaian.

Jangan menganggap semua file Markdown sebagai aturan. Pastikan file tersebut memang berisi instruksi yang berlaku.

Jangan hanya membaca nama atau ringkasan aturan. Baca isi ketentuannya agar penilaian tidak terlepas dari pengecualian, konteks, atau prioritas aturan.

### 4.2. Konflik Antaraturan

Jika dua atau lebih aturan bertentangan:

1. Catat isi inti aturan yang bertentangan.
2. Catat path dan nomor baris setiap aturan.
3. Periksa apakah `AGENTS.md` atau aturan lain sudah menetapkan prioritas secara eksplisit.
4. Jika prioritas sudah jelas, gunakan aturan yang ditetapkan sebagai prioritas.
5. Jika prioritas tidak jelas, jangan memilih sendiri aturan yang dianggap benar.
6. Laporkan sebagai **konflik aturan yang memerlukan keputusan**, bukan sebagai pelanggaran kode yang sudah pasti.

Jangan menyebut kode melanggar aturan sebelum konflik dan prioritas aturan diselesaikan.

## 5. Membaca `catatan.md` dan `saran.md`

Baca kedua file di root repository sebelum menentukan rentang commit dan menyusun temuan.

### 5.1. `catatan.md`

Baca `catatan.md` secara menyeluruh untuk memahami struktur dan memastikan bagian command lain tidak tertimpa.

Untuk menentukan commit terakhir yang sudah diperiksa oleh command ini, **hanya gunakan checkpoint di antara penanda berikut**:

`<!-- CEK_PERUBAHAN_SEKARANG: CHECKPOINT START -->`

`<!-- CEK_PERUBAHAN_SEKARANG: CHECKPOINT END -->`

Abaikan checkpoint, riwayat, atau catatan milik command lain. Jangan menggunakan checkpoint milik `.kilo/commands/evaluasi_aturan_khusus.md` atau command lain.

Jangan menebak checkpoint dari judul commit, tanggal, urutan paragraf, atau posisi entri terakhir.

### 5.2. `saran.md`

Baca `saran.md` untuk mengetahui:

- Temuan yang sudah pernah dicatat.
- Saran yang masih belum diperbaiki.
- Saran yang sudah diperbaiki atau sebagian diperbaiki.
- Saran yang perlu diperbarui berdasarkan kondisi kode pada HEAD.
- Temuan yang sama agar tidak dibuat berulang.

Gunakan akar masalah dan perilaku yang sama untuk mengenali duplikasi, bukan hanya membandingkan judul atau path file.

## 6. Menentukan Rentang Commit

Tentukan rentang evaluasi hanya berdasarkan checkpoint command ini dan riwayat Git.

### 6.1. Checkpoint Sudah Ada dan Valid

Jika checkpoint berisi SHA lengkap:

1. Pastikan SHA tersebut merupakan commit yang dapat ditemukan di repository.
2. Pastikan checkpoint merupakan ancestor dari `TARGET_HEAD`, misalnya dengan `git merge-base --is-ancestor <checkpoint> <TARGET_HEAD>`.
3. Jika valid dan berbeda dari `TARGET_HEAD`, ambil seluruh commit pada first-parent history setelah checkpoint sampai `TARGET_HEAD`.
4. Urutkan commit dari yang paling lama ke paling baru.
5. Evaluasi hanya commit dalam rentang tersebut.

Rentang commit harus ditentukan dari graf Git, bukan dari tanggal atau judul commit.

Jika checkpoint sama dengan `TARGET_HEAD`, tidak ada commit baru. Laporkan bahwa tidak ada perubahan commit yang perlu dievaluasi, lalu hentikan proses tanpa mengubah `catatan.md` atau `saran.md`.

### 6.2. Belum Pernah Ada Checkpoint

Gunakan kondisi ini hanya jika kedua penanda checkpoint memang belum pernah dibuat dan tidak ada bukti checkpoint lama milik command ini, atau kedua penanda tersedia dengan nilai kosong karena command belum pernah dijalankan. Jika terdapat riwayat lama yang menunjukkan command ini pernah berjalan tetapi checkpoint hilang, jangan anggap sebagai evaluasi pertama; gunakan ketentuan checkpoint tidak valid.

1. Ambil maksimal 5 commit terakhir dari first-parent history sampai `TARGET_HEAD`.
2. Jika repository memiliki kurang dari 5 commit, gunakan seluruh commit yang tersedia.
3. Urutkan dari yang paling lama ke paling baru.

Gunakan perintah yang setara dengan `git log -5 --first-parent --reverse --format=%H <TARGET_HEAD>` dan pastikan setiap hasil berupa SHA lengkap.

**Fallback 5 commit hanya untuk evaluasi pertama.** Jangan menggunakan fallback ini untuk menggantikan checkpoint lama yang rusak atau tidak valid.

### 6.3. Checkpoint Tidak Valid atau Ambigu

Checkpoint dianggap tidak valid apabila:

- SHA tidak ditemukan dalam repository.
- SHA bukan ancestor dari `TARGET_HEAD`.
- Riwayat berubah akibat rebase atau force push sehingga hubungan checkpoint tidak dapat dipastikan.
- Penanda START atau END hilang, terbalik, atau muncul lebih dari satu kali.
- Terdapat lebih dari satu nilai checkpoint yang menyebabkan posisi terakhir tidak jelas.
- Format checkpoint rusak atau tidak dapat diidentifikasi.

Jika checkpoint pernah ada tetapi sekarang tidak valid:

1. Jangan menggunakan fallback 5 commit.
2. Jangan menebak rentang evaluasi.
3. Jangan mengubah atau menghapus checkpoint yang rusak.
4. Laporkan masalah dan bukti Git yang ditemukan.
5. Hentikan evaluasi sebelum memperbarui `catatan.md` atau `saran.md`.

Jika file `catatan.md` belum ada, hentikan proses dan laporkan. Jika kedua penanda checkpoint tidak ada dan tidak ada bukti evaluasi terdahulu milik command ini, perlakukan sebagai evaluasi pertama sesuai bagian 6.2. Jika ada bukti evaluasi terdahulu tetapi penanda hilang atau tidak dapat dipastikan, perlakukan sebagai checkpoint tidak valid dan hentikan proses.

### 6.4. Perlakuan terhadap Merge Commit

Gunakan first-parent history agar commit yang masuk melalui merge tidak diperiksa berulang sebagai rangkaian commit cabang samping sekaligus sebagai merge.

- Commit biasa: evaluasi diff terhadap parent-nya.
- Merge commit: evaluasi diff terhadap first parent (`<commit>^1`).
- Root commit tanpa parent: gunakan diff root commit terhadap keadaan kosong.

Diff merge terhadap first parent harus mencakup perubahan bersih yang masuk ke branch utama, termasuk resolusi konflik merge.

## 7. Menganalisis Setiap Commit

Evaluasi semua commit yang sudah dipilih, dari yang paling lama hingga paling baru. Jangan melewatkan commit hanya karena judulnya terlihat seperti dokumentasi atau perubahan kecil.

Untuk setiap commit:

1. Catat SHA lengkap.
2. Catat tanggal commit dan judul commit.
3. Identifikasi file yang ditambah, diubah, dihapus, dipindahkan, atau diganti nama.
4. Baca diff lengkap untuk setiap file yang relevan.
5. Periksa konteks kode di sekitar baris yang berubah.
6. Identifikasi class, fungsi, widget, konstruktor, parameter, properti, metode, enum, callback, dan API yang terpengaruh.
7. Periksa perubahan dependency, versi SDK, konfigurasi, skema database, serta file pendukung yang berkaitan.
8. Periksa apakah perubahan berikutnya memperbaiki atau mengubah kembali implementasi yang diperkenalkan oleh commit sebelumnya.

Gunakan diff commit untuk mengetahui perubahan yang diperkenalkan oleh commit tersebut. Setelah itu, periksa kondisi file pada `TARGET_HEAD` untuk menentukan apakah masalah tersebut masih ada.

Bedakan tiga hal berikut:

- **Masalah diperkenalkan:** commit tertentu pertama kali menambahkan perilaku yang bermasalah.
- **Masalah masih aktif:** perilaku tersebut masih terdapat pada `TARGET_HEAD`.
- **Masalah sudah diperbaiki:** commit berikutnya terbukti menghilangkan masalah pada `TARGET_HEAD`.

Jangan melaporkan masalah lama sebagai masalah aktif apabila perubahan berikutnya sudah memperbaikinya. Jika relevan, catat commit yang memperkenalkan dan commit yang memperbaikinya.

Evaluasi semua jenis file yang memengaruhi implementasi, termasuk Dart, konfigurasi, dependency, database/migrasi, pengujian, serta dokumentasi teknis. Jangan menganggap file non-Dart otomatis tidak relevan.

## 8. Memeriksa Kesesuaian dengan Aturan

Bandingkan setiap perubahan kode dengan aturan yang relevan dan sudah dibaca.

Periksa sesuai konteks perubahan, sekurang-kurangnya:

1. Arsitektur dan struktur proyek.
2. Gaya penulisan dan konvensi kode.
3. Pemanfaatan SDK dan paket.
4. Pengelolaan state dan lifecycle widget.
5. Database, transaksi, migrasi, dan integritas data.
6. Null safety, parsing, asynchronous, dan penanganan error.
7. Keamanan dan privasi data.
8. Performa dan pengelolaan sumber daya.
9. UX/UI apabila perubahan berhubungan dengan tampilan atau interaksi.
10. Testing apabila perubahan berkaitan dengan perilaku yang wajib diuji menurut aturan proyek.
11. Ketentuan khusus lain yang berlaku pada file yang berubah.

Jangan memaksakan aturan yang tidak relevan terhadap perubahan. Namun, jangan melewatkan aturan yang memang berlaku hanya karena perubahan terlihat sederhana.

### 8.1. Bukti Pelanggaran Wajib

Setiap pelanggaran aturan harus memuat kedua lokasi berikut.

**Lokasi kode:**

- Path file kode.
- Nomor baris atau rentang baris.
- Penjelasan kode yang bermasalah.

**Lokasi aturan:**

- Path file aturan.
- Nomor baris atau rentang baris aturan.
- Inti ketentuan yang dilanggar.

Contoh format:

```text
Pelanggaran aturan:
- Kode: lib/fitur/contoh.dart:35-42
- Aturan: .agents/rules/global/optimasi_bug_runtime.md:40-48
- Ketentuan: Periksa mounted sebelum menggunakan State atau BuildContext setelah await.
- Bukti: Kode menggunakan context setelah await tanpa pemeriksaan context.mounted.
- Dampak: Dapat menggunakan BuildContext yang sudah tidak valid.
```

Jangan menulis "melanggar aturan proyek" tanpa menyebutkan file aturan dan nomor baris yang membuktikannya.

Jika tidak ditemukan aturan tertulis yang secara langsung mengatur suatu masalah, jangan mengarang pelanggaran. Masukkan sebagai **risiko teknis atau saran peningkatan**, bukan pelanggaran aturan.

## 9. Pemeriksaan Source Flutter SDK, Dart SDK, dan Paket — WAJIB

Bagian ini wajib dilakukan untuk setiap perubahan yang menggunakan atau mengubah API SDK/paket. **Tidak ada pengecualian hanya karena widget atau API dianggap sederhana, umum, atau sudah dikenal.**

Jangan mengandalkan ingatan model, contoh dari versi lain, atau asumsi bahwa API masih sama. Baca source dari versi yang benar-benar dipakai repository.

### 9.1. Identifikasi Versi dan Lokasi SDK

1. Identifikasi executable Flutter yang benar-benar digunakan melalui `command -v flutter`.
2. Temukan lokasi sebenarnya executable tersebut, misalnya menggunakan `readlink -f`.
3. Identifikasi root Flutter SDK dari lokasi executable yang ditemukan.
4. Catat versi Flutter dan Dart menggunakan `flutter --version` dan `dart --version`.
5. Jangan mengasumsikan path SDK selalu sama. Gunakan path hasil pemeriksaan lingkungan saat ini.

Untuk Flutter, source biasanya berada di bawah:

`<FLUTTER_SDK>/packages/flutter/lib/`

Untuk Dart, source SDK berada di bawah:

`<DART_SDK>/lib/`

Jika source yang dibutuhkan tidak tersedia pada instalasi tersebut, nyatakan bahwa pemeriksaan source belum dapat diverifikasi. Jangan menggantinya dengan klaim berdasarkan ingatan.

### 9.2. Identifikasi Versi Paket yang Benar-benar Digunakan

Untuk setiap paket yang API-nya digunakan atau diubah:

1. Periksa versi terkunci pada `pubspec.lock`.
2. Periksa dependency yang benar-benar terselesaikan melalui `.dart_tool/package_config.json` apabila tersedia.
3. Temukan direktori source paket berdasarkan `rootUri` atau lokasi cache paket yang benar-benar digunakan.
4. Verifikasi versi pada `pubspec.yaml` milik paket tersebut.
5. Catat nama paket, versi tepat, dan lokasi source.

Jangan hanya membaca batas versi pada `pubspec.yaml` proyek. Batas versi dependency tidak selalu sama dengan versi yang terpasang.

Jangan menjalankan `flutter pub get`, `flutter pub upgrade`, atau perintah lain yang mengubah dependency/lockfile untuk mempermudah pemeriksaan.

Jika paket merupakan dependency lokal/path dependency, baca source pada lokasi aktual yang dirujuk konfigurasi paket.

### 9.3. Baca Source API yang Berubah atau Digunakan

Untuk setiap API SDK/paket yang berhubungan dengan diff, baca definisi dan implementasi source yang relevan. Periksa sekurang-kurangnya:

- Deklarasi class atau fungsi.
- Konstruktor dan seluruh parameter bernama/posisional yang digunakan.
- Tipe data setiap parameter.
- Nilai default parameter.
- Nullability parameter dan nilai balik.
- Properti, getter, setter, metode, enum, dan callback terkait.
- Dokumentasi komentar pada deklarasi.
- Anotasi `@Deprecated` atau penanda deprecated lain.
- Perubahan API yang memengaruhi perilaku atau kompatibilitas.
- Implementasi internal yang diperlukan untuk memahami perilaku aktual.

Gunakan pencarian simbol pada source, lalu baca konteks deklarasi dan implementasinya. Gunakan nomor baris aktual, misalnya melalui `rg -n` dan `nl -ba`.

Jangan hanya membaca nama class atau hasil pencarian satu baris. Baca rentang source yang cukup untuk memahami konstruktor, parameter, default, anotasi, dan perilaku yang sedang dipakai.

### 9.4. Widget Flutter Biasa Tetap Wajib Diperiksa

Setiap widget Flutter yang konstruktor, parameter, properti, atau penggunaannya berubah wajib diperiksa ke source SDK. Termasuk, tetapi tidak terbatas pada:

- `Scaffold`
- `AppBar`
- `SafeArea`
- `Padding`
- `Container`
- `Row` dan `Column`
- `Text` dan `RichText`
- `Icon`
- `Card`
- `ListView` dan `GridView`
- `SingleChildScrollView`
- `TextField` dan `TextFormField`
- `ElevatedButton`, `TextButton`, dan `IconButton`
- Widget Material, Cupertino, atau widget framework lain yang muncul dalam perubahan.

Daftar tersebut hanya contoh, bukan daftar pengecualian. Jika widget lain berubah, periksa juga source widget tersebut.

Jangan menyatakan widget aman hanya karena sering digunakan atau sudah dikenal.

### 9.5. Paket Pihak Ketiga

Untuk setiap class, widget, konstruktor, metode, atau enum dari paket pihak ketiga:

1. Baca source paket pada versi tepat yang dikunci dan terselesaikan.
2. Periksa deklarasi API yang digunakan.
3. Periksa implementasi yang berkaitan dengan perilaku perubahan.
4. Periksa penanda deprecated dan alternatif yang disediakan versi tersebut.
5. Periksa contoh pada folder `example` atau dokumentasi paket apabila tersedia dan relevan.

Dokumentasi README atau contoh hanya menjadi sumber pendukung. Dokumentasi tersebut tidak menggantikan pemeriksaan deklarasi dan source API pada versi paket yang terpasang.

### 9.6. Perubahan Versi Dependency

Jika commit mengubah `pubspec.yaml` atau `pubspec.lock`:

1. Catat versi sebelum dan sesudah perubahan.
2. Identifikasi API yang dipakai kode dan berpengaruh terhadap perubahan versi.
3. Periksa source versi yang benar-benar terselesaikan pada kondisi `TARGET_HEAD`.
4. Jika source versi sebelumnya tersedia, bandingkan deklarasi API yang relevan untuk mengetahui perubahan kompatibilitas.
5. Jangan menganggap API pada versi terbaru otomatis tersedia pada versi yang terkunci di proyek.

### 9.7. Bukti Pemeriksaan SDK

Untuk setiap API/widget yang diperiksa, catat:

- Nama API/widget.
- Nama SDK atau paket.
- Versi Flutter/Dart atau versi paket.
- Path source yang dibaca.
- Nomor baris deklarasi/konstruktor/implementasi yang relevan.
- Hasil: sesuai, tidak sesuai, deprecated, berisiko, atau belum dapat diverifikasi.

Contoh format:

```text
Pemeriksaan SDK:
- API: AppBar
- SDK: Flutter 3.x.x
- Source: /path/flutter/packages/flutter/lib/src/material/app_bar.dart:190-260
- Pemeriksaan: Konstruktor, default value, dan parameter yang digunakan pada kode.
- Hasil: Sesuai dengan API versi Flutter yang terpasang.
```

Contoh di atas hanya format. Jangan menyalin versi atau path contoh sebagai fakta. Gunakan hasil pemeriksaan aktual.

Jika source SDK/paket yang wajib diperiksa tidak dapat ditemukan atau dibaca, tulis **Belum dapat diverifikasi** dan jelaskan alasannya. Jangan menandai API tersebut sesuai atau tidak deprecated tanpa bukti source. Evaluasi commit terkait harus berstatus **Sebagian selesai**; jangan memajukan checkpoint melewati commit yang masih memiliki API wajib yang belum diverifikasi.

## 10. Menentukan Temuan dan Rekomendasi

Kelompokkan hasil menjadi kategori yang jelas:

1. **Pelanggaran aturan:** kode terbukti tidak sesuai dengan aturan tertulis.
2. **Ketidaksesuaian SDK/paket:** penggunaan API tidak cocok dengan source atau versi yang terpasang, termasuk API deprecated yang masih digunakan tanpa alasan yang dapat diterima.
3. **Bug atau risiko runtime:** terdapat bukti teknis bahwa perubahan dapat menghasilkan perilaku salah, crash, kehilangan data, atau kegagalan proses.
4. **Risiko UX/UI atau performa:** terdapat bukti dampak terhadap penggunaan atau performa.
5. **Saran peningkatan opsional:** penyederhanaan atau perbaikan kualitas yang bukan pelanggaran aturan dan bukan bug yang terbukti.

Untuk setiap temuan:

- Tentukan prioritas Tinggi, Sedang, atau Rendah berdasarkan dampak dan kemungkinan terjadi.
- Jelaskan bukti, dampak, dan alasan prioritas.
- Sertakan path dan nomor baris kode.
- Sertakan path dan nomor baris aturan jika merupakan pelanggaran.
- Sertakan path dan nomor baris source SDK/paket jika berkaitan dengan API.
- Berikan saran perbaikan yang spesifik, tanpa menerapkannya.
- Tentukan status pada kondisi `TARGET_HEAD`: Belum diperbaiki, Sebagian diperbaiki, Sudah diperbaiki, atau Perlu verifikasi.

Pisahkan rekomendasi opsional dari pelanggaran dan bug. Jangan membuat masalah terlihat seperti pelanggaran aturan apabila tidak ada aturan tertulis yang dilanggar.

Jangan membuat temuan hanya karena suatu file test tidak muncul pada commit. Nyatakan kekurangan test sebagai pelanggaran hanya jika aturan proyek memang mewajibkannya untuk perubahan tersebut. Jika tidak, tulis sebagai saran pengujian.

## 11. Memperbarui `saran.md`

Perbarui `saran.md` hanya jika evaluasi menghasilkan saran baru atau informasi saran lama perlu diperbarui.

### 11.1. Mencegah Duplikasi

1. Cari saran lama berdasarkan akar masalah, perilaku, dan API yang terlibat.
2. Jika masalah yang sama sudah tercatat, perbarui entri lama. Jangan membuat entri duplikat.
3. Jika implementasi sudah diperbaiki oleh commit berikutnya, perbarui status dan sertakan bukti commit perbaikannya.
4. Jika baru sebagian diperbaiki, jelaskan bagian yang selesai dan bagian yang masih bermasalah.
5. Jika masalah baru dan benar-benar berbeda, buat entri baru.
6. Jangan menghapus saran lama hanya karena tidak muncul pada commit yang sedang dievaluasi.

### 11.2. Urutan Entri

- Entri baru wajib diletakkan tepat di bawah judul `# Saran Perbaikan`, sebelum entri yang lebih lama.
- Entri yang diperbarui wajib dipindahkan ke bagian paling atas setelah judul.
- Jika beberapa entri diperbarui dalam satu evaluasi, urutkan berdasarkan tanggal pembaruan terbaru; untuk tanggal yang sama, urutkan berdasarkan prioritas tertinggi.
- Jangan mengubah urutan entri lama yang tidak diperbarui.
- Jangan mengubah judul utama file.

### 11.3. Format Entri

Gunakan format yang konsisten dan mudah dipindai:

```markdown
## [YYYY-MM-DD] [SHA_COMMIT_PEMICU]

### Prioritas: Tinggi/Sedang/Rendah

**Status:** Belum diperbaiki/Sebagian diperbaiki/Sudah diperbaiki/Perlu verifikasi.

**Masalah:**
Penjelasan masalah dan bukti perilaku yang ditemukan.

**Lokasi kode:**

- `path/file.dart:baris-awal-akhir`

**Aturan yang dilanggar:**

- `path/aturan.md:baris-awal-akhir` — inti ketentuan yang dilanggar.

**Bukti SDK/paket:**

- `path/source_sdk_atau_paket.dart:baris-awal-akhir` — nama API dan versi yang diperiksa.

**Dampak:**
Dampak teknis atau dampak terhadap pengguna.

**Rekomendasi:**
Langkah perbaikan yang disarankan tanpa mengubah kode.

**Riwayat status:**
Informasi commit perbaikan atau alasan status terakhir, jika ada.
```

Sesuaikan bagian **Aturan yang dilanggar** dan **Bukti SDK/paket** dengan jenis temuannya. Jika tidak ada aturan yang dilanggar, tulis `Tidak ditemukan pelanggaran aturan tertulis` dan jangan mencantumkan aturan yang tidak relevan. Jika tidak ada API SDK/paket yang terkait, tulis `Tidak relevan`.

Gunakan tanggal aktual dan SHA commit pemicu yang benar. Jangan memasukkan link atau URL. Gunakan path file dan nomor baris.

Jika tidak ada saran baru dan tidak ada saran lama yang perlu diperbarui, jangan mengubah `saran.md`.

## 12. Memperbarui `catatan.md` dan Mencegah Pembengkakan File

`catatan.md` dapat digunakan oleh beberapa command. Karena itu, jangan menulis ulang seluruh file dan jangan mengubah bagian milik command lain.

### 12.1. Memperbarui Checkpoint

Setelah seluruh commit pada rentang evaluasi berhasil diperiksa, seluruh pemeriksaan source wajib selesai, dan pembaruan `saran.md` berhasil dilakukan apabila diperlukan, perbarui hanya isi di antara penanda checkpoint milik command ini:

`<!-- CEK_PERUBAHAN_SEKARANG: CHECKPOINT START -->`

`<!-- CEK_PERUBAHAN_SEKARANG: CHECKPOINT END -->`

Isi checkpoint harus ringkas dan tetap, menggunakan format:

```text
Commit terakhir dievaluasi penuh: <SHA_LENGKAP_TARGET_HEAD>
Tanggal evaluasi: <YYYY-MM-DD>
Rentang evaluasi: <SHA_COMMIT_PERTAMA> sampai <SHA_LENGKAP_TARGET_HEAD>
Jumlah commit dievaluasi: <JUMLAH>
Status evaluasi: Selesai
Ringkasan: <maksimal 2 kalimat>
```

Jika fallback 5 commit digunakan, isi rentang sesuai lima commit atau jumlah commit yang benar-benar tersedia.

Checkpoint harus berisi SHA lengkap, bukan SHA pendek.

### 12.2. Batas Riwayat Agar `catatan.md` Tidak Membeludak

1. Jangan menambahkan uraian panjang untuk setiap commit ke `catatan.md`.
2. Jangan menambahkan diff, daftar seluruh file, atau seluruh temuan secara berulang ke `catatan.md`.
3. Jangan membuat riwayat evaluasi baru dengan menambahkan blok panjang setiap kali command dijalankan.
4. Gunakan checkpoint dan satu ringkasan evaluasi terbaru sebagai satu-satunya catatan berkelanjutan milik command ini.
5. Pada evaluasi berikutnya, **ganti isi checkpoint dan ringkasan lama di dalam blok yang sama**; jangan menambahkan ringkasan baru di bawahnya.
6. Simpan rincian rekomendasi di `saran.md`, bukan menyalinnya berulang kali ke `catatan.md`.
7. Jangan menghapus atau mengubah checkpoint dan riwayat milik command lain.

Jika `catatan.md` sudah memiliki bagian `## Riwayat Evaluasi Commit` lama yang jelas berada di bawah judul command ini dan sebelum bagian command lain, ringkas bagian milik command ini menjadi satu ringkasan evaluasi terbaru. Jangan menghapus bagian lain. Jika batas kepemilikan bagian lama tidak dapat dipastikan, jangan menghapusnya; cukup hentikan penambahan riwayat rinci dan gunakan blok checkpoint sebagai catatan berkelanjutan.

Jangan menambah atau memperbarui checkpoint jika:

- Ada commit yang belum selesai dievaluasi.
- Ada source SDK/paket wajib yang belum dapat diperiksa untuk API pada commit terkait.
- Pembaruan `saran.md` yang diperlukan gagal dilakukan.
- `TARGET_HEAD` berubah.
- Struktur checkpoint tidak valid atau ambigu.
- Pembaruan akan menimpa perubahan lokal pengguna.

**Checkpoint hanya boleh dimajukan sampai commit terakhir yang benar-benar selesai dievaluasi.**

## 13. Pemeriksaan Sebelum Menyelesaikan Command

Sebelum memberikan laporan:

1. Pastikan seluruh commit dalam rentang sudah diperiksa.
2. Pastikan setiap perubahan API/widget yang relevan sudah dicocokkan dengan source SDK/paket versi aktual.
3. Pastikan setiap klaim deprecated didukung anotasi atau keterangan source yang dapat ditunjukkan.
4. Pastikan setiap pelanggaran memiliki path dan nomor baris kode serta path dan nomor baris aturan.
5. Pastikan setiap rekomendasi di `saran.md` tidak menduplikasi masalah yang sudah ada.
6. Pastikan entri baru atau entri yang diperbarui berada di paling atas `saran.md`.
7. Pastikan checkpoint berisi SHA lengkap `TARGET_HEAD` dan hanya dimajukan setelah evaluasi selesai.
8. Pastikan bagian milik command lain di `catatan.md` tidak berubah.
9. Pastikan tidak ada file kode, konfigurasi, dependency, atau file lain yang diubah oleh command ini.
10. Periksa kembali `git status --short` dan bandingkan dengan kondisi awal. Perubahan yang muncul hanya boleh berupa pembaruan yang memang diizinkan pada `catatan.md` dan/atau `saran.md`.
11. Pastikan `TARGET_HEAD` tetap sama dengan `git rev-parse HEAD`.

Jika ada langkah wajib yang gagal, ubah status akhir menjadi **Sebagian selesai** atau **Terhenti**, jelaskan alasannya, dan jangan memajukan checkpoint melewati commit yang belum selesai.

## 14. Format Laporan Akhir

Gunakan bahasa Indonesia yang baik dan benar. Susun laporan dengan urutan berikut.

### A. Status Evaluasi

- Status: Selesai / Sebagian selesai / Terhenti / Tidak ada commit baru.
- Branch dan kondisi detached HEAD jika ada.
- SHA lengkap `TARGET_HEAD`.
- Checkpoint sebelum evaluasi.
- Rentang commit yang dievaluasi.
- Jumlah commit yang dievaluasi.

### B. Ringkasan Hasil

Ringkas hasil utama, jumlah temuan berdasarkan prioritas, jumlah pelanggaran aturan, jumlah ketidaksesuaian SDK/paket, serta apakah ada pemeriksaan yang belum dapat diverifikasi.

### C. Daftar Commit yang Diperiksa

Untuk setiap commit, tampilkan:

- SHA lengkap.
- Tanggal.
- Judul commit.
- Ringkasan perubahan.
- Status evaluasi.

### D. Temuan dan Pelanggaran

Urutkan dari prioritas tertinggi ke terendah. Untuk setiap temuan, gunakan struktur:

- **Prioritas dan kategori.**
- **Status pada HEAD.**
- **Commit pemicu:** SHA lengkap.
- **Lokasi kode:** `path/file:baris-awal-akhir`.
- **Aturan yang dilanggar:** `path/aturan:baris-awal-akhir` dan inti ketentuannya.
- **Bukti source SDK/paket:** versi dan `path/source:baris-awal-akhir`.
- **Masalah dan bukti:** jelaskan apa yang tidak sesuai.
- **Dampak:** jelaskan konsekuensi teknis atau pengguna.
- **Saran perbaikan:** tuliskan tindakan spesifik, tetapi jangan menerapkannya.

Jika tidak ada aturan yang dilanggar, jangan mengarang lokasi aturan. Tandai sebagai risiko teknis atau saran opsional.

### E. Hasil Pemeriksaan Source SDK/Paket

Tampilkan daftar API/widget yang wajib diperiksa, termasuk yang hasilnya sesuai. Untuk setiap item cantumkan nama API, versi SDK/paket, path source, nomor baris yang dibaca, dan kesimpulan.

Jangan hanya menampilkan API yang bermasalah. Bagian ini harus membuktikan bahwa source untuk API/widget yang berubah benar-benar telah diperiksa.

### F. Pembaruan Dokumentasi

Nyatakan secara terpisah:

- `catatan.md`: checkpoint diperbarui atau tidak, SHA yang disimpan, serta apakah ringkasan lama dipadatkan.
- `saran.md`: entri baru, entri yang diperbarui, atau tidak ada perubahan.

### G. Keterbatasan

Sebutkan source yang tidak dapat diakses, versi yang belum dapat dipastikan, file yang tidak dapat dibaca, konflik aturan yang belum memiliki prioritas, atau pemeriksaan lain yang belum selesai.

### H. Konfirmasi Batasan

Nyatakan secara eksplisit bahwa tidak ada kode Dart, kode sumber program, konfigurasi, dependency, atau file lain di luar `catatan.md` dan `saran.md` yang diubah oleh command ini.

## 15. Ketentuan Akhir

- Utamakan bukti aktual dari diff, aturan repository, dan source SDK/paket versi terpasang.
- Jangan mengganti pembacaan source dengan asumsi atau ingatan.
- Jangan melewatkan pemeriksaan widget sederhana.
- Jangan menyimpulkan pelanggaran tanpa menunjukkan aturan yang tepat.
- Jangan menyertakan link; gunakan path dan nomor baris.
- Jangan mengubah kode. Tugas perbaikan kode hanya dilakukan setelah pengguna memberikan instruksi terpisah dan jelas.
