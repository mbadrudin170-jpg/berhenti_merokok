---
description: Evaluasi tepat 5 commit terakhir yang sudah tersimpan, baca satu per satu, pelajari standar implementasi pengguna, perbarui aturan khusus dan aturan bersama Flutter, kemudian perbarui AGENTS.md.
agent: code
---

# EVALUASI COMMIT DAN PEMBARUAN ATURAN PROYEK

## 1. Tujuan Utama

Setiap kali pengguna mengerjakan kode, baik memperbaiki bug, memperbarui implementasi, maupun menambahkan fitur, lakukan evaluasi terhadap 5 commit terakhir untuk mempelajari standar pengembangan, pola implementasi, keputusan teknis, dan preferensi pengguna.

Hasil evaluasi digunakan untuk menambah atau memperbarui dua file aturan:

**A. Aturan khusus proyek**

Path:

`.agents/rules/proyek/aturan_khusus.md`

File ini berisi aturan yang hanya berlaku pada proyek yang sedang dikerjakan.

Contohnya:

- Struktur folder proyek.
- Arsitektur khusus proyek.
- Pola implementasi fitur.
- Business logic.
- Integrasi database dan backend.
- Penggunaan paket khusus proyek.
- Keputusan teknis khusus aplikasi.
- Preferensi implementasi yang hanya relevan untuk proyek tersebut.
- Kesalahan implementasi khusus proyek yang harus dicegah agar tidak terulang.

**B. Aturan bersama seluruh proyek Flutter**

Path:

`.agents/rules/global/aturan_bersama.md`

File ini berisi prinsip dan standar yang bisa diterapkan pada seluruh proyek Flutter.

Contohnya:

- Standar penulisan Dart.
- Penggunaan Flutter SDK.
- Penanganan asynchronous.
- Pencegahan bug runtime.
- Pengelolaan lifecycle.
- Pengelolaan state.
- Performa.
- Maintainability.
- Testing.
- Prinsip UX/UI lintas proyek.
- Prinsip pengembangan yang dapat digunakan kembali pada proyek Flutter lainnya.

**C. Perbarui AGENTS.md**

Setelah kedua file aturan selesai diperbarui, jalankan:

`script/build_rules_context.sh`

Tujuannya memperbarui isi `AGENTS.md` berdasarkan aturan terbaru.

### Hasil akhir yang diharapkan

AI semakin memahami cara pengguna menginginkan kode ditulis, diperbaiki, dan dikembangkan.

Aturan harus membantu mencegah kesalahan yang sama terulang apabila AI melakukan perubahan kode di kemudian hari.

Jangan hanya mengevaluasi apakah kode berjalan. Evaluasi juga apakah cara implementasinya sudah sesuai dengan standar dan preferensi pengguna.

## 2. Ketentuan Utama: Hanya 5 Commit Terakhir

**WAJIB mengevaluasi tepat 5 commit terakhir dari HEAD pada branch yang sedang aktif.**

Gunakan:

```bash
git log -5 --date=short --pretty=format:'%H%x09%ad%x09%s' HEAD
```

Ketentuan:

1. Ambil tepat 5 commit terakhir.
2. Jangan mengambil lebih dari 5 commit.
3. Jangan mengambil kurang dari 5 commit.
4. Jangan mengambil commit dari branch lain.
5. Jangan memperluas pemeriksaan ke seluruh riwayat proyek.
6. Jangan mengganti commit yang tidak dapat diperiksa dengan commit dari branch lain.

Setelah mengambil hasilnya, hitung dan pastikan terdapat tepat 5 commit berbeda.

**Jika repository hanya memiliki kurang dari 5 commit, hentikan evaluasi. Jangan melanjutkan menggunakan jumlah yang lebih sedikit. Laporkan jumlah commit yang tersedia.**

Jangan membuat kesimpulan aturan berdasarkan evaluasi yang tidak memenuhi ketentuan ini.

## 3. Larangan Membaca Git yang Belum Di-commit

**AI hanya boleh membaca riwayat dan isi commit yang sudah tersimpan di repository.**

Jangan membaca, memeriksa, menganalisis, atau membandingkan perubahan Git yang belum di-commit.

Hal yang dilarang untuk diperiksa:

1. Perubahan staged.
2. Perubahan unstaged.
3. File untracked.
4. Perbedaan working tree dengan staging area.
5. Perbedaan working tree dengan HEAD.
6. Perubahan yang belum masuk riwayat commit.

Dilarang menjalankan perintah berikut:

```bash
git status
git diff
git diff --cached
git diff HEAD
git ls-files --others
```

Jangan menggunakan perintah lain yang bertujuan memeriksa perubahan Git yang belum di-commit.

### 3.1. Jangan mengubah kondisi Git

Dilarang menjalankan operasi yang dapat mengubah:

- Working tree.
- Staging area.
- Branch.
- Riwayat commit.

Contoh perintah yang dilarang:

```bash
git checkout
git reset
git restore
git clean
git stash
git add
git commit
git amend
git rebase
git merge
git cherry-pick
git revert
git pull
git push
```

Larangan berlaku untuk seluruh operasi Git lain yang mempunyai efek serupa.

### 3.2. Sumber evaluasi hanya dari commit

Perintah Git yang diperbolehkan hanya perintah baca yang mengakses objek commit yang sudah tersimpan.

Contohnya:

```bash
git log -5 HEAD
```

```bash
git show <HASH_COMMIT>
```

```bash
git show <HASH_COMMIT>:<PATH_FILE>
```

```bash
git diff <HASH_COMMIT_LAMA> <HASH_COMMIT_BARU> --
```

Ketentuan:

- Jika menggunakan `git diff`, kedua referensi harus berupa hash commit yang sudah tersimpan.
- Jangan menggunakan `git diff` untuk membandingkan working tree atau staging area.
- Jangan menggunakan sintaks referensi staging seperti `:path/file.dart`.
- Jangan menggunakan isi working tree sebagai pengganti isi file pada commit.
- Jangan membaca perubahan yang belum di-commit untuk melengkapi informasi commit.

**Jika kode dalam commit perlu dibaca lebih lengkap, ambil isinya menggunakan hash commit, bukan dari file proyek yang sedang aktif.**

### 3.3. Pengecualian pembacaan file dokumentasi

Untuk memperbarui dokumentasi, Anda tetap diperbolehkan membaca isi terkini dari:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`
- `script/build_rules_context.sh`

Pembacaan tersebut diperlukan untuk mempertahankan dokumentasi lama dan memahami proses pembaruan.

Namun, jangan menggunakan Git untuk mengetahui atau memeriksa apakah file tersebut mempunyai perubahan staged maupun unstaged.

Jangan membaca Git diff dari file-file tersebut.

**Pembedaan penting:**

- Kode sumber untuk bahan evaluasi harus berasal dari commit yang sudah tersimpan.
- Isi dokumentasi boleh dibaca langsung sebagai referensi pembaruan.
- Perubahan Git yang belum di-commit tidak boleh dijadikan bahan audit.

## 4. Persiapan Sebelum Evaluasi

### 4.1. Baca seluruh dokumentasi aturan

Sebelum mengevaluasi commit, baca seluruh isi:

1. `AGENTS.md`
2. `.agents/rules/proyek/aturan_khusus.md`
3. `.agents/rules/global/aturan_bersama.md`

Tujuannya:

- Memahami standar yang sudah berlaku.
- Mengetahui aturan yang telah ditetapkan.
- Menghindari penambahan aturan duplikat.
- Memahami hubungan aturan khusus dan global.
- Mengetahui preferensi pengembangan pengguna.
- Mengetahui kemungkinan konflik antaraturan.

Jangan hanya membaca sebagian isi file.

Jika salah satu file belum tersedia, pastikan kondisinya sebelum membuat file baru.

### 4.2. Periksa script pembaruan AGENTS.md

Baca seluruh isi:

`script/build_rules_context.sh`

Pahami:

- Cara kerja script.
- File aturan yang dibaca.
- Bagaimana konteks aturan dibangun.
- File yang dihasilkan.
- Apakah script menimpa atau menggabungkan isi `AGENTS.md`.
- Apakah terdapat operasi penghapusan.
- Apakah terdapat efek samping lain.
- Apakah terdapat perintah Git.

**Jangan mengubah isi script.**

Jika script menggunakan operasi untuk membaca atau mengubah Git yang belum di-commit, jangan menjalankan operasi tersebut.

Jika script berpotensi mengubah file yang tidak berkaitan dengan pembaruan `AGENTS.md`, periksa dampaknya terlebih dahulu.

Jangan mengambil risiko menghilangkan pekerjaan pengguna.

## 5. Identifikasi Tepat 5 Commit

Ambil lima commit terakhir menggunakan:

```bash
git log -5 --date=short --pretty=format:'%H%x09%ad%x09%s' HEAD
```

Catat:

- Hash commit lengkap.
- Tanggal commit.
- Pesan commit.

Pastikan terdapat tepat 5 commit.

Urutkan pemeriksaan dari commit paling lama menuju commit terbaru.

**Pengambilan commit dimulai dari yang terbaru, tetapi evaluasi dilakukan dari yang paling lama menuju yang terbaru.**

Jangan menganggap pesan commit sebagai penjelasan lengkap perubahan kode.

Pesan commit hanya digunakan sebagai informasi awal.

## 6. Baca Setiap Commit Satu per Satu

Ini merupakan ketentuan wajib.

**Setiap commit harus dibaca dan dievaluasi secara individual sebelum melanjutkan ke commit berikutnya.**

Jangan hanya membaca ringkasan seluruh commit sekaligus.

### 6.1. Baca metadata commit

Gunakan:

```bash
git show -s --format=fuller <HASH_COMMIT>
```

Pahami:

- Tanggal commit.
- Pesan commit.
- Pembuat commit.
- Konteks perubahan berdasarkan informasi yang tersedia.

### 6.2. Identifikasi seluruh file yang berubah

Gunakan:

```bash
git show --format= --name-status --find-renames <HASH_COMMIT>
```

Periksa semua file yang mengalami perubahan.

Jangan hanya memilih file Dart atau file yang terlihat penting.

Perubahan konfigurasi, testing, platform, dan dokumentasi teknis juga dapat memberikan informasi tentang keputusan implementasi.

### 6.3. Baca seluruh perubahan commit

Untuk commit biasa, gunakan:

```bash
git show --format=fuller --no-ext-diff --find-renames --stat --patch <HASH_COMMIT>
```

Baca seluruh perubahan dalam commit tersebut.

Untuk commit merge, evaluasi terhadap parent pertama menggunakan dua referensi commit yang eksplisit:

```bash
git diff <HASH_COMMIT>^1 <HASH_COMMIT> --
```

Untuk commit pertama yang tidak memiliki parent:

```bash
git show --root --format=fuller --no-ext-diff --find-renames --stat --patch <HASH_COMMIT>
```

Ketentuan:

1. Periksa seluruh perubahan.
2. Jangan hanya membaca ringkasan statistik.
3. Jangan hanya membaca nama file.
4. Jangan melewatkan perubahan kecil.
5. Jangan melewatkan file yang terlihat sederhana.
6. Jika hasil terlalu panjang, pecah pembacaan berdasarkan file.
7. Pastikan seluruh bagian perubahan sudah dibaca.

Jika satu commit mengubah banyak file, periksa setiap file secara individual.

### 6.4. Baca isi file pada snapshot commit

Jika patch belum memberikan konteks yang cukup, baca isi file langsung dari commit yang sedang diperiksa.

Gunakan:

```bash
git show <HASH_COMMIT>:<PATH_FILE>
```

Hal ini bertujuan agar AI memahami implementasi lengkap pada saat commit dibuat.

Ketentuan:

- Gunakan hash commit yang sedang dievaluasi.
- Jangan menggunakan versi file dari working tree.
- Jangan menggunakan isi staging area.
- Jangan menggunakan file untracked.
- Jangan mengambil isi dari commit lain tanpa alasan yang jelas.

**Versi kode yang menjadi bahan evaluasi harus berasal dari snapshot commit yang sedang diperiksa.**

### 6.5. Evaluasi isi perubahan

Evaluasi seluruh aspek perubahan yang relevan.

#### A. Gaya dan standar penulisan kode

- Penamaan class, function, variable, dan file.
- Struktur class dan function.
- Susunan kode.
- Konsistensi penulisan.
- Pemisahan tanggung jawab.
- Penggunaan abstraksi.
- Penggunaan komentar.
- Keterbacaan kode.
- Maintainability.

#### B. Bug dan keamanan runtime

- Penanganan null.
- Penanganan exception.
- Penggunaan `!`, `as`, dan `dynamic`.
- Penanganan asynchronous.
- Penggunaan `await`.
- Pemeriksaan `mounted`.
- Pengelolaan lifecycle.
- Pengelolaan resource.
- Pemanggilan `dispose`.
- Potensi memory leak.
- Potensi race condition.
- Penanganan database dan transaksi.
- Validasi data.

#### C. Arsitektur dan state management

- Penggunaan Provider dan Notifier.
- Penggunaan `ref.watch` dan `ref.read`.
- Pengelolaan state.
- Penggunaan Freezed.
- Pemisahan UI dan business logic.
- Pengelolaan cache.
- Aliran data.
- Penggunaan repository.
- Dependency injection.
- Pemisahan tanggung jawab.

#### D. Performa

- Rebuild widget.
- Efisiensi pemrosesan data.
- Efisiensi query database.
- Penggunaan cache.
- Penggunaan resource.
- Operasi berat pada UI thread.
- Penggunaan Future dan Stream.
- Penggunaan memori.

#### E. UX/UI

- Konsistensi desain.
- Keterbacaan.
- Jarak dan ukuran komponen.
- Kejelasan fungsi tombol.
- Loading dan feedback.
- Penanganan error.
- Pencegahan interaksi ganda.
- Pengelolaan data kosong.
- Kemudahan penggunaan.
- Responsivitas.

#### F. Testing

- Kualitas pengujian.
- Unit test.
- Penggunaan mock dan fake.
- Pengujian kondisi normal dan ekstrem.
- Pengujian business logic.
- Pengujian terhadap kemungkinan kesalahan.

#### G. Aspek teknis lainnya

Jangan membatasi evaluasi hanya pada daftar tersebut.

Jika perubahan mengandung keputusan teknis lain yang dapat menjadi standar pengembangan, evaluasi juga.

### 6.6. Catat hasil evaluasi setiap commit

Setelah satu commit selesai diperiksa, catat:

- Apa yang berubah?
- Apa tujuan perubahan berdasarkan konteks yang tersedia?
- Pola implementasi apa yang digunakan?
- Gaya penulisan apa yang terlihat?
- Preferensi pengguna apa yang dapat disimpulkan?
- Keputusan teknis apa yang perlu dipertahankan?
- Kesalahan apa yang berhasil diperbaiki?
- Prinsip apa yang bisa digeneralisasi?
- Hal apa yang belum cukup jelas untuk dijadikan aturan?

Jangan melanjutkan ke commit berikutnya sebelum seluruh perubahan commit saat ini selesai dievaluasi.

## 7. Perlakukan Commit sebagai Pekerjaan yang Sudah Disimpan

Pengguna menganggap pekerjaan yang sudah di-commit sebagai pekerjaan yang telah disimpan dan diselesaikan.

Karena itu:

1. Gunakan implementasi dalam commit sebagai referensi hasil pekerjaan pengguna.
2. Pelajari pola implementasi yang dipilih.
3. Identifikasi preferensi yang terlihat dari perubahan.
4. Jangan menganggap commit sebagai pekerjaan yang masih harus diperbaiki.
5. Jangan mengubah kode di dalam commit.
6. Jangan membuat ulang commit.
7. Jangan mengubah riwayat commit.

Namun, tetap evaluasi kualitas implementasinya sebelum menjadikannya aturan.

Jika suatu implementasi terlihat berisiko:

- Catat sebagai temuan.
- Periksa apakah commit berikutnya memperbaikinya.
- Jangan mengubah commit.
- Jangan menjadikan pola yang bermasalah sebagai aturan.
- Jangan menyimpulkan preferensi pengguna hanya dari satu implementasi yang belum jelas.

**Tujuannya adalah mengambil standar dan pelajaran dari pekerjaan yang sudah disimpan, bukan menyalin setiap implementasi tanpa penilaian.**

## 8. Evaluasi Perkembangan Antar-Commit

Setelah setiap commit dibaca secara individual, periksa hubungan antara kelima commit.

Perhatikan:

- Apakah ada implementasi yang disempurnakan?
- Apakah ada pendekatan yang diganti?
- Apakah ada bug yang diperbaiki?
- Apakah ada pola lama yang tidak lagi digunakan?
- Apakah ada standar yang konsisten?
- Apakah preferensi pengguna semakin jelas?
- Apakah ada keputusan teknis yang diperkuat oleh commit berikutnya?

Jika commit terbaru menggantikan pendekatan lama, gunakan pendekatan terbaru sebagai referensi utama.

Jangan menggabungkan dua pendekatan yang saling bertentangan menjadi satu aturan.

### 8.1. Jangan mengabaikan commit kecil

Pengguna menyukai commit perubahan kecil agar setiap pekerjaan lebih mudah dipisahkan dan dievaluasi.

Karena itu:

- Setiap commit tetap wajib diperiksa.
- Jangan melewati commit kecil.
- Jangan menyarankan penggabungan commit.
- Jangan mengubah strategi commit pengguna.
- Jangan menganggap perubahan kecil tidak mengandung pelajaran penting.
- Perhatikan perkembangan standar melalui rangkaian commit kecil.

## 9. Identifikasi Preferensi Pengguna

Jangan hanya mengevaluasi kebenaran teknis kode.

Pelajari juga bagaimana pengguna ingin kode dikembangkan.

Identifikasi preferensi yang terlihat dari perubahan, seperti:

- Cara menyusun function.
- Cara memisahkan business logic.
- Cara menggunakan Provider dan Notifier.
- Cara mengelola state.
- Cara menangani error.
- Cara mengelola cache.
- Cara menghindari abstraksi yang tidak diperlukan.
- Cara menyusun widget.
- Cara mengelola asynchronous.
- Cara menulis unit test.
- Cara memperbaiki bug.
- Cara mempertahankan konsistensi implementasi.

Utamakan pola yang berulang atau didukung oleh bukti kuat dari beberapa commit.

Jangan menganggap satu contoh implementasi sebagai preferensi wajib tanpa bukti yang cukup.

## 10. Tentukan Aturan yang Layak Ditambahkan

Setelah kelima commit selesai dievaluasi, rangkum seluruh temuan.

Jangan langsung memasukkan setiap perubahan kode menjadi aturan.

Suatu perubahan layak menjadi aturan apabila:

1. Penting untuk dipertahankan.
2. Mencerminkan preferensi pengguna.
3. Dapat mencegah kesalahan berulang.
4. Memiliki alasan teknis yang jelas.
5. Dapat diterapkan secara konsisten.
6. Belum diatur atau belum dijelaskan secara memadai.
7. Relevan untuk pengembangan berikutnya.

Perhatikan:

- Satu commit dapat menghasilkan beberapa aturan.
- Beberapa commit dapat mendukung satu aturan yang sama.
- Satu aturan dapat berasal dari perkembangan implementasi antar-commit.
- Satu aturan dapat berisi prinsip umum dan contoh implementasi khusus.

Jangan membuat aturan hanya untuk memperbanyak dokumentasi.

**Utamakan aturan yang konkret, tegas, dan memiliki manfaat nyata.**

## 11. Pisahkan Aturan Khusus dan Aturan Bersama

Setiap temuan yang layak menjadi aturan harus diperiksa cakupan penerapannya.

### 11.1. Aturan khusus proyek

Path:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan aturan apabila hanya relevan untuk proyek saat ini.

Contohnya:

- Struktur folder khusus proyek.
- Arsitektur khusus aplikasi.
- Pola implementasi modul tertentu.
- Penggunaan paket khusus proyek.
- Integrasi database atau backend tertentu.
- Business logic khusus aplikasi.
- Ketentuan implementasi fitur tertentu.
- Keputusan teknis khusus proyek.

Jangan memasukkan detail yang hanya berlaku pada satu proyek ke aturan global.

### 11.2. Aturan bersama seluruh proyek Flutter

Path:

`.agents/rules/global/aturan_bersama.md`

Masukkan prinsip yang bisa diterapkan pada seluruh proyek Flutter.

Contohnya:

- Standar penulisan Dart.
- Penanganan asynchronous.
- Pencegahan bug runtime.
- Pengelolaan lifecycle widget.
- Pengelolaan resource.
- Prinsip state management.
- Pencegahan rebuild yang tidak diperlukan.
- Maintainability.
- Pengujian.
- Prinsip UX/UI lintas proyek.
- Penggunaan Flutter dan Dart SDK.

Pastikan aturan tersebut benar-benar dapat diterapkan pada proyek Flutter lainnya tanpa menimbulkan konflik dengan arsitektur masing-masing.

### 11.3. Wajib mengambil prinsip umum dari aturan khusus

Ini merupakan ketentuan penting.

Walaupun suatu implementasi hanya dapat diterapkan secara langsung pada proyek tertentu, tetap evaluasi apakah terdapat prinsip dasar yang bisa dijadikan referensi untuk aturan bersama.

Contohnya:

- Detail implementasi repository tertentu hanya berlaku untuk satu aplikasi.
- Namun, prinsip pemisahan business logic dari UI dapat berlaku untuk proyek Flutter lainnya.

Lakukan pemisahan berikut:

1. Detail implementasi khusus tetap ditulis dalam `aturan_khusus.md`.
2. Prinsip umum yang dapat diterapkan lintas proyek ditulis dalam `aturan_bersama.md`.
3. Jangan menyalin seluruh aturan khusus ke aturan global.
4. Jangan menghilangkan prinsip umum yang dapat digeneralisasi.
5. Jangan memaksakan generalisasi yang tidak tepat.

**Setiap aturan khusus wajib diperiksa peluang generalisasinya sebelum diputuskan hanya berlaku untuk proyek saat ini.**

Jika sebuah aturan khusus tidak bisa digeneralisasi, jelaskan alasannya dalam laporan akhir.

Jika hanya sebagian prinsip yang dapat digunakan secara global, masukkan hanya bagian prinsip tersebut.

Jangan membawa detail teknis khusus proyek ke aturan bersama.

## 12. Penulisan Aturan dan Contoh Kode

Gunakan bahasa Indonesia yang baik dan benar.

Ketentuan:

1. Gunakan kalimat tegas.
2. Hindari kalimat ambigu.
3. Jelaskan tindakan yang diwajibkan.
4. Jelaskan tindakan yang dilarang.
5. Jelaskan alasan aturan.
6. Hindari aturan terlalu umum.
7. Jangan membuat aturan duplikat.
8. Pertahankan aturan lama yang masih relevan.
9. Perjelas aturan lama jika diperlukan.
10. Jangan mengubah aturan yang tidak berkaitan dengan evaluasi.

### 12.1. Wajib menyertakan contoh benar dan salah

Setiap aturan kode yang baru ditambahkan atau diperbarui wajib mempunyai contoh kode benar dan salah.

Gunakan struktur berikut:

### Judul Aturan

**Aturan:**

Jelaskan ketentuan yang harus diikuti.

**Alasan:**

Jelaskan mengapa aturan diperlukan.

**Contoh benar:**

```dart
// Implementasi yang sesuai dengan aturan.
```

**Contoh salah:**

```dart
// Implementasi yang tidak sesuai dengan aturan.
```

**Sumber evaluasi:**

- Commit: `<HASH_COMMIT>`
- File: `lib/path/file.dart`

Ketentuan contoh:

- Contoh harus relevan dengan aturan.
- Contoh benar menunjukkan implementasi yang direkomendasikan.
- Contoh salah menunjukkan pola yang harus dihindari.
- Kode harus valid secara sintaksis.
- API harus benar-benar tersedia.
- Contoh harus sesuai dengan Flutter dan Dart.
- Jangan membuat nama API atau method fiktif.
- Jangan memasukkan kesalahan lain yang tidak berkaitan dengan aturan.

Jika satu aturan didukung beberapa commit, cantumkan seluruh commit yang relevan.

Untuk aturan non-kode, gunakan contoh penerapan benar dan salah yang sesuai dengan konteksnya.

### 12.2. Sumber aturan wajib dicantumkan

Setiap aturan baru harus mempunyai sumber evaluasi yang jelas.

Cantumkan:

- Hash commit.
- Path file sumber.
- Alasan perubahan tersebut menghasilkan aturan.

Jangan mengklaim aturan berasal dari commit tertentu apabila tidak terdapat bukti di dalamnya.

## 13. Evaluasi Konflik dan Duplikasi

Sebelum menyimpan perubahan, bandingkan hasil evaluasi dengan:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`

Periksa:

1. Aturan duplikat.
2. Aturan yang saling bertentangan.
3. Aturan global yang terlalu spesifik.
4. Aturan khusus yang sebenarnya dapat digeneralisasi.
5. Aturan yang tidak konsisten dengan preferensi pengguna.
6. Contoh benar yang bertentangan dengan aturan lain.
7. Contoh salah yang sebenarnya diperbolehkan.
8. Aturan lama yang sudah tidak relevan.

Jika menemukan konflik:

1. Periksa prioritas aturan yang berlaku.
2. Jangan menebak penyelesaian.
3. Jangan menghapus aturan lama secara sembarangan.
4. Jangan memasukkan aturan baru yang bertentangan.
5. Laporkan konflik yang belum dapat dipastikan.

Utamakan memperjelas aturan lama daripada membuat aturan baru dengan maksud yang sama.

## 14. Perbarui File Aturan

Setelah seluruh evaluasi selesai, lakukan pembaruan.

### 14.1. Perbarui aturan khusus

Path:

`.agents/rules/proyek/aturan_khusus.md`

Lakukan:

- Tambahkan aturan khusus yang diperlukan.
- Perbarui aturan lama yang perlu diperjelas.
- Pertahankan aturan lama yang masih relevan.
- Hindari duplikasi.
- Sertakan contoh benar dan salah.
- Sertakan sumber commit.

### 14.2. Perbarui aturan bersama

Path:

`.agents/rules/global/aturan_bersama.md`

Lakukan:

- Tambahkan prinsip umum Flutter dan Dart.
- Perjelas aturan global yang sudah ada.
- Ambil prinsip umum dari temuan aturan khusus.
- Hindari memasukkan detail implementasi khusus proyek.
- Sertakan contoh benar dan salah.
- Sertakan sumber evaluasi.

### 14.3. Pertahankan isi dokumentasi sebelumnya

Jangan mengganti seluruh isi file tanpa alasan.

Jangan menghapus aturan lama hanya karena ditemukan pendekatan baru.

Jika sebuah aturan lama perlu diperbarui:

1. Pastikan terdapat bukti dari commit.
2. Pastikan aturan baru lebih sesuai.
3. Pastikan tidak menimbulkan konflik.
4. Pertahankan bagian lama yang masih relevan.

Lakukan perubahan secara terarah.

Jangan mengubah file selain dua file aturan tersebut, kecuali `AGENTS.md` melalui script yang telah ditentukan.

## 15. Perbarui AGENTS.md Menggunakan Script

Setelah kedua file aturan selesai diperbarui, jalankan:

```bash
bash script/build_rules_context.sh
```

Tujuannya memperbarui isi:

`AGENTS.md`

**Path yang wajib digunakan adalah `script/build_rules_context.sh`, menggunakan direktori `script` dalam bentuk tunggal.**

Jangan diam-diam menggantinya menjadi `scripts/build_rules_context.sh`.

### 15.1. Pastikan script tersedia

Sebelum menjalankan, periksa keberadaan file:

`script/build_rules_context.sh`

Jika tidak ditemukan:

1. Jangan membuat script pengganti.
2. Jangan otomatis mencari dan menjalankan script dengan nama berbeda.
3. Jangan mengubah path tujuan berdasarkan asumsi.
4. Laporkan bahwa script tidak ditemukan.
5. Sampaikan path yang diperiksa kepada pengguna.

### 15.2. Periksa isi script

Baca seluruh isi script dan pahami dampaknya.

Pastikan script:

- Membaca aturan dari lokasi yang benar.
- Menghasilkan pembaruan `AGENTS.md`.
- Tidak membaca perubahan Git yang belum di-commit.
- Tidak menggunakan Git diff untuk memeriksa working tree.
- Tidak mengubah staging area.
- Tidak membuat commit.
- Tidak mengubah branch atau riwayat commit.
- Tidak menghapus pekerjaan pengguna.
- Tidak mengubah file lain di luar tujuan yang diperlukan.

Jangan mengubah isi script.

Jika script melakukan operasi yang bertentangan dengan ketentuan ini, jangan jalankan. Laporkan masalahnya.

### 15.3. Jalankan script

Jika script tersedia dan dampaknya sudah dipastikan aman, jalankan:

```bash
bash script/build_rules_context.sh
```

Jalankan hanya setelah pembaruan kedua file aturan selesai.

Jangan mengganti proses script dengan pembaruan manual.

### 15.4. Verifikasi AGENTS.md

Setelah script berhasil:

1. Baca kembali `AGENTS.md`.
2. Pastikan aturan terbaru sudah masuk.
3. Pastikan tidak ada aturan penting yang hilang.
4. Pastikan isi aturan sesuai dengan kedua file sumber.
5. Pastikan tidak ada kode sumber yang berubah akibat script.
6. Jangan menggunakan `git status` atau `git diff` untuk verifikasi.
7. Jangan memeriksa perubahan staged dan unstaged.

Jika script gagal, laporkan penyebabnya. Jangan melakukan tindakan Git untuk memaksakan keberhasilan.

## 16. Format Laporan Akhir

Setelah seluruh pekerjaan selesai, berikan laporan dengan struktur berikut.

### A. Ringkasan Evaluasi

Cantumkan bahwa tepat 5 commit telah dievaluasi.

### B. Daftar Commit yang Diperiksa

| No. | Hash Commit | Tanggal | Pesan Commit | Hasil Evaluasi |
| --- | ----------- | ------- | ------------ | -------------- |
| 1   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 2   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 3   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 4   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 5   | Hash        | Tanggal | Pesan        | Ringkasan      |

Urutkan berdasarkan evaluasi, yaitu dari commit paling lama menuju commit terbaru.

### C. Pembaruan Aturan Khusus

Path:

`.agents/rules/proyek/aturan_khusus.md`

Jelaskan:

- Aturan baru yang ditambahkan.
- Aturan lama yang diperbarui.
- Alasan perubahan.
- Commit sumber.
- File sumber.

Jika tidak ada perubahan, jelaskan alasannya.

### D. Pembaruan Aturan Bersama

Path:

`.agents/rules/global/aturan_bersama.md`

Jelaskan:

- Prinsip Flutter/Dart yang ditambahkan.
- Aturan lama yang diperjelas.
- Prinsip yang berhasil digeneralisasi dari aturan khusus.
- Alasan aturan dapat diterapkan pada proyek Flutter lainnya.
- Commit sumber.

Jika tidak ada perubahan, jelaskan alasannya.

### E. Hasil Generalisasi

Jelaskan:

- Temuan khusus yang berhasil digeneralisasi.
- Prinsip yang dimasukkan ke aturan bersama.
- Bagian aturan khusus yang tetap berlaku untuk proyek saat ini.
- Alasan apabila suatu temuan tidak bisa digeneralisasi.

### F. Temuan yang Tidak Dijadikan Aturan

Cantumkan temuan yang tidak dimasukkan ke dokumentasi beserta alasannya.

Contohnya:

- Hanya berlaku untuk kondisi sementara.
- Sudah diatur dalam dokumentasi lain.
- Tidak dapat digeneralisasi.
- Belum cukup bukti.
- Merupakan implementasi lama yang sudah digantikan.
- Tidak layak menjadi standar.

### G. Hasil Pembaruan AGENTS.md

Jelaskan:

- Apakah `script/build_rules_context.sh` ditemukan.
- Apakah script berhasil dijalankan.
- Apakah `AGENTS.md` berhasil diperbarui.
- Apakah aturan terbaru sudah masuk.
- Apakah terdapat kendala.

### H. Konfirmasi Keamanan Git

Nyatakan bahwa:

- Tepat 5 commit yang sudah tersimpan menjadi bahan evaluasi.
- Tidak ada commit di luar batas tersebut yang dievaluasi.
- Tidak ada perubahan staged yang dibaca.
- Tidak ada perubahan unstaged yang dibaca.
- Tidak ada file untracked yang diperiksa.
- Tidak ada kode sumber yang diubah.
- Tidak ada staging area yang diubah.
- Tidak ada branch yang diubah.
- Tidak ada riwayat commit yang diubah.
- Tidak ada checkout, reset, restore, atau stash.
- Tidak ada commit baru yang dibuat.

### I. Kesimpulan

Jelaskan hasil akhir dan manfaat aturan yang telah diperbarui.

Jika ada tahapan yang gagal, sampaikan secara jujur.

Jangan menyatakan seluruh proses berhasil apabila masih ada tahapan yang belum selesai.

## 17. Checklist Pemeriksaan Akhir

### Riwayat commit

- [ ] Tepat 5 commit terakhir sudah dipilih.
- [ ] Tidak ada commit tambahan yang dievaluasi.
- [ ] Tidak ada commit yang terlewat.
- [ ] Setiap commit dibaca satu per satu.
- [ ] Evaluasi dilakukan dari commit paling lama ke terbaru.
- [ ] Seluruh perubahan dalam setiap commit sudah diperiksa.
- [ ] Versi kode yang dibaca berasal dari snapshot commit.

### Perlindungan Git

- [ ] Tidak membaca staged changes.
- [ ] Tidak membaca unstaged changes.
- [ ] Tidak membaca file untracked melalui Git.
- [ ] Tidak menjalankan `git status`.
- [ ] Tidak menjalankan `git diff` terhadap working tree atau staging area.
- [ ] Tidak mengubah file kode.
- [ ] Tidak mengubah staging area.
- [ ] Tidak mengubah branch.
- [ ] Tidak mengubah riwayat commit.

### Evaluasi dan dokumentasi

- [ ] Gaya penulisan kode sudah dievaluasi.
- [ ] Bug dan keamanan runtime sudah dievaluasi.
- [ ] Arsitektur dan state management sudah dievaluasi.
- [ ] Performa sudah dievaluasi.
- [ ] UX/UI sudah dievaluasi.
- [ ] Testing sudah dievaluasi.
- [ ] Preferensi pengguna sudah dipertimbangkan.
- [ ] Aturan khusus sudah diperbarui jika diperlukan.
- [ ] Aturan global sudah diperbarui jika diperlukan.
- [ ] Setiap aturan khusus sudah diperiksa peluang generalisasinya.
- [ ] Contoh kode benar dan salah sudah disertakan.
- [ ] Sumber commit setiap aturan baru sudah dicantumkan.
- [ ] Tidak ada aturan duplikat atau konflik yang dibiarkan tanpa laporan.

### Pembaruan AGENTS.md

- [ ] `script/build_rules_context.sh` sudah diperiksa.
- [ ] Script berhasil dijalankan atau kegagalannya dilaporkan.
- [ ] `AGENTS.md` sudah dibaca kembali.
- [ ] Konteks aturan terbaru sudah masuk.

Jika ada ketentuan yang belum terpenuhi, laporkan dengan jujur.

---

# PRINSIP UTAMA

Tujuan command ini bukan sekadar memperbanyak aturan.

Tujuannya adalah mempelajari standar, keputusan teknis, dan preferensi pengguna dari pekerjaan yang sudah tersimpan dalam riwayat commit.

**Hanya 5 commit terakhir yang sudah di-commit yang boleh menjadi bahan evaluasi.**

Jangan membaca perubahan staged, unstaged, atau untracked.

Aturan khusus menjaga standar implementasi dan keputusan teknis setiap proyek.

Aturan bersama menjaga konsistensi seluruh proyek Flutter.

Setiap temuan khusus wajib diperiksa apakah memiliki prinsip yang dapat digeneralisasi menjadi aturan bersama.

Jangan menganggap semua implementasi otomatis benar. Evaluasi terlebih dahulu sebelum menjadikannya standar.

Jangan mengubah pekerjaan lama, kode sumber, staging area, atau riwayat commit.

**Lindungi seluruh pekerjaan pengguna yang belum di-commit. Pelajari hanya lima commit yang sudah tersimpan dan gunakan hasil evaluasinya untuk meningkatkan kualitas aturan AI.**
