`````markdown
---
description: Evaluasi hingga 15 commit terbaru satu per satu, kemudian perbarui aturan khusus proyek dan aturan bersama Flutter berdasarkan hasil evaluasi.
agent: code
---

# Evaluasi dan Pembaruan Aturan Berdasarkan Riwayat Commit

## 1. Tujuan

Tugas utama adalah mengevaluasi perubahan kode dari riwayat commit terbaru untuk memahami pola implementasi, standar penulisan kode, keputusan arsitektur, perbaikan bug, dan preferensi pengembangan yang digunakan dalam proyek.

Hasil evaluasi harus digunakan untuk memperbarui dua file berikut:

1. `.agents/rules/proyek/aturan_khusus.md`
   - Menampung aturan yang hanya berlaku untuk proyek yang sedang dikerjakan.
   - Menampung detail implementasi, pola arsitektur, ketentuan teknis, dan keputusan khusus proyek.

2. `.agents/rules/global/aturan_bersama.md`
   - Menampung aturan yang dapat diterapkan secara konsisten pada seluruh proyek Flutter.
   - Menampung prinsip umum pengembangan Flutter dan Dart yang dapat digunakan kembali di proyek lain.

Tujuan akhirnya adalah membangun dokumentasi aturan yang semakin lengkap berdasarkan perubahan kode yang telah dikerjakan, sehingga AI dapat memahami preferensi dan standar pengembangan yang diharapkan serta menghindari pengulangan kesalahan yang sama.

**Jangan hanya mencatat cara memperbaiki bug. Evaluasi seluruh aspek perubahan kode, termasuk gaya penulisan, struktur, arsitektur, efisiensi, keamanan, pengelolaan state, performa, UX/UI, dan aspek teknis lainnya.**

## 2. Batasan dan Larangan Utama

Ketentuan berikut wajib dipatuhi selama menjalankan command ini.

### 2.1. Jangan mengubah kode sumber

- Jangan memperbaiki, menambah, menghapus, atau memindahkan kode sumber.
- Jangan melakukan refactoring.
- Jangan memperbaiki temuan bug yang ditemukan dalam commit.
- Jangan mengubah implementasi hanya karena menemukan pola yang berbeda.
- Tugas ini hanya untuk mengevaluasi perubahan dan memperbarui dokumentasi aturan.

Perubahan yang diperbolehkan hanya pada:

- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`
- `AGENTS.md`, hanya melalui script yang telah ditentukan.

### 2.2. Jangan mengganggu perubahan Git yang belum di-commit

**Ini merupakan ketentuan yang sangat penting. Jangan sampai perubahan pekerjaan yang belum selesai hilang atau berubah.**

Dilarang melakukan operasi Git yang dapat mengubah kondisi repository, baik perubahan yang sudah masuk staging maupun yang belum masuk staging.

Larangan tersebut mencakup:

- `git checkout`
- `git reset`
- `git restore`
- `git clean`
- `git stash`
- `git add`
- `git commit`
- `git amend`
- `git rebase`
- `git merge`
- `git cherry-pick`
- `git revert`
- `git pull`
- `git push`
- Operasi Git lainnya yang dapat mengubah working tree, staging area, branch, atau riwayat commit.

Jangan menjalankan perintah yang membaca atau membandingkan perubahan working tree maupun staging area, seperti `git diff` tanpa dua referensi commit yang eksplisit.

Jangan menjalankan `git status` atau perintah lain untuk memeriksa perubahan yang belum di-commit. Audit ini hanya membutuhkan riwayat commit.

**Perintah Git yang diperbolehkan hanya perintah baca untuk mengakses riwayat commit dan membandingkan isi antar-commit yang sudah ada.**

Jika suatu perintah berpotensi mengubah kondisi Git, jangan jalankan.

### 2.3. Perlakukan commit sebagai referensi historis

- Anggap perubahan yang sudah di-commit sebagai hasil pekerjaan yang telah disimpan.
- Jangan mengubah isi commit.
- Gunakan hasil implementasi dalam commit sebagai bahan untuk mempelajari pola dan standar pengembangan.
- Jangan langsung menganggap setiap pola dalam commit pasti merupakan aturan yang harus diikuti. Tetap evaluasi kualitas dan kesesuaiannya.
- Apabila ditemukan potensi bug atau pola yang kurang baik, catat sebagai temuan. Jangan memperbaiki kode sumbernya.

## 3. Persiapan Sebelum Evaluasi

Sebelum membaca commit, lakukan langkah berikut.

### 3.1. Baca dokumentasi aturan proyek

Baca seluruh isi file berikut:

1. `AGENTS.md`
2. `.agents/rules/proyek/aturan_khusus.md`
3. `.agents/rules/global/aturan_bersama.md`

Tujuannya:

- Memahami standar yang sudah berlaku.
- Mengetahui aturan yang sudah pernah ditetapkan.
- Menghindari penambahan aturan yang sama.
- Mengetahui prinsip yang sudah dianggap sebagai standar pengembangan.
- Mengetahui kemungkinan pertentangan antara aturan yang sudah ada dan hasil evaluasi.

Jangan hanya membaca bagian awal file. Baca seluruh isi ketiga file tersebut.

### 3.2. Periksa script pembaruan AGENTS.md

Baca seluruh isi file:

`scripts/build_rules_context.sh`

Pahami cara kerja script tersebut sebelum menjalankannya.

Pastikan script digunakan untuk memperbarui konteks aturan ke `AGENTS.md` dan tidak menjalankan operasi yang mengubah staging area, working tree, atau riwayat Git.

Jangan mengubah isi script.

Jika script tidak ditemukan atau memiliki operasi yang berisiko mengganggu perubahan pekerjaan yang belum di-commit, hentikan bagian eksekusi script dan laporkan masalahnya.

## 4. Tentukan Rentang Commit yang Dievaluasi

Evaluasi hanya 15 commit terbaru pada riwayat `HEAD` proyek yang sedang dikerjakan.

Gunakan perintah baca berikut:

```bash
git log -15 --date=short --pretty=format:'%H%x09%ad%x09%s' HEAD
```

Ketentuan:

1. Ambil maksimal 15 commit terbaru.
2. Jika jumlah commit yang tersedia kurang dari 15, evaluasi seluruh commit yang tersedia.
3. Jangan mengambil commit dari branch lain yang tidak termasuk dalam riwayat `HEAD`.
4. Jangan memperluas evaluasi ke seluruh riwayat proyek.
5. Jangan mengevaluasi perubahan working tree atau staging area.
6. Jangan menggunakan perubahan yang belum di-commit sebagai sumber evaluasi.

Catat terlebih dahulu daftar commit yang akan diperiksa, termasuk:

- Hash commit.
- Tanggal commit.
- Pesan commit.

Jangan langsung menarik kesimpulan hanya dari pesan commit. Pesan commit digunakan sebagai informasi awal, bukan sebagai pengganti pemeriksaan kode.

## 5. Baca Setiap Commit Satu Per Satu

**Setiap commit wajib dibaca secara individual. Jangan hanya membaca ringkasan seluruh commit sekaligus.**

Lakukan evaluasi secara berurutan, mulai dari commit yang paling lama dalam rentang terpilih hingga commit terbaru.

Tujuannya agar AI memahami perkembangan implementasi dan dapat mengetahui apabila suatu pola lama sudah diperbaiki atau digantikan oleh commit berikutnya.

Untuk setiap commit:

### 5.1. Periksa metadata commit

Gunakan:

```bash
git show -s --format=fuller <HASH_COMMIT>
```

Pahami tanggal, identitas commit, dan pesan perubahan.

### 5.2. Identifikasi seluruh file yang berubah

Gunakan:

```bash
git diff --name-status <HASH_COMMIT>^1 <HASH_COMMIT> --
```

Perhatikan semua file yang ditambah, diubah, dihapus, atau dipindahkan.

### 5.3. Baca seluruh perubahan kode

Gunakan:

```bash
git diff --no-ext-diff --find-renames --patch <HASH_COMMIT>^1 <HASH_COMMIT> --
```

Baca seluruh perubahan dalam commit tersebut, bukan hanya ringkasannya.

Jika hasil perubahan terlalu panjang, pecah pemeriksaan berdasarkan file agar tidak ada bagian yang terlewat.

Gunakan hanya referensi commit yang eksplisit dalam perintah pembandingan. Jangan mengganti referensi tersebut dengan working tree atau staging area.

Untuk commit pertama yang tidak memiliki parent, gunakan:

```bash
git show --no-ext-diff --format=fuller --find-renames --patch <HASH_COMMIT>
```

Untuk commit merge, evaluasi perubahan terhadap parent pertama.

### 5.4. Evaluasi setiap perubahan

Periksa seluruh perubahan yang relevan, termasuk kode produksi, kode pengujian, konfigurasi, dan dokumentasi teknis yang berkaitan dengan implementasi.

Evaluasi setidaknya aspek berikut:

**A. Gaya dan standar penulisan kode**

- Penamaan class, function, variable, dan file.
- Kerapian dan konsistensi kode.
- Struktur function dan class.
- Pemisahan tanggung jawab.
- Kemudahan membaca dan memelihara kode.
- Penggunaan komentar.
- Penggunaan abstraksi dan penghindaran abstraksi yang tidak diperlukan.

**B. Bug dan keamanan runtime**

- Penanganan null.
- Penanganan error dan exception.
- Potensi race condition.
- Pengelolaan asynchronous.
- Penggunaan `await` dan `Future`.
- Pemeriksaan lifecycle dan `mounted`.
- Pengelolaan resource dan pemanggilan `dispose`.
- Potensi memory leak.
- Penanganan transaksi database.
- Validasi data dan kondisi ekstrem.

**C. Arsitektur dan pengelolaan state**

- Penggunaan Provider dan Notifier.
- Pola `ref.watch`, `ref.read`, dan mekanisme pembaruan state.
- Pemisahan business logic dan UI.
- Pengelolaan cache.
- Aliran data dari database ke state hingga UI.
- Penggunaan model dan immutable state.
- Penggunaan dependency injection.
- Pengelolaan dependensi antar-komponen.

**D. Performa dan efisiensi**

- Potensi rebuild yang tidak diperlukan.
- Efisiensi pemrosesan data.
- Penggunaan cache.
- Penggunaan operasi asynchronous.
- Penggunaan resource.
- Potensi pekerjaan berat pada UI thread.
- Efisiensi query database.

**E. UX/UI**

- Konsistensi desain.
- Kejelasan fungsi tombol.
- Alur interaksi pengguna.
- Loading, success, warning, dan error feedback.
- Pencegahan interaksi ganda.
- Penghapusan data dan konfirmasi tindakan.
- Penanganan kondisi data kosong.
- Responsivitas dan kemudahan penggunaan.

**F. Pengujian dan kualitas implementasi**

- Kualitas unit test.
- Penanganan kondisi normal dan ekstrem.
- Penggunaan mock atau fake.
- Pemisahan kode produksi dan kode pengujian.
- Konsistensi implementasi dengan dokumentasi SDK.

**G. Aspek teknis lainnya**

Jangan membatasi evaluasi pada daftar di atas. Apabila ditemukan pola atau keputusan teknis lain yang penting untuk menjadi aturan, evaluasi juga.

### 5.5. Periksa perkembangan perubahan

Setelah mengevaluasi satu commit, perhatikan commit berikutnya dalam rentang audit.

Cari tahu apakah perubahan tersebut:

- Tetap dipertahankan.
- Diperbaiki.
- Diganti dengan pendekatan lain.
- Dibatalkan.
- Disempurnakan.

Jangan menjadikan pola implementasi lama sebagai aturan jika commit berikutnya menunjukkan bahwa pola tersebut sudah diperbaiki atau diganti.

**Selesaikan evaluasi satu commit sebelum melanjutkan ke commit berikutnya.**

Jangan melewati commit hanya karena perubahan terlihat sederhana.

## 6. Tentukan Aturan yang Layak Ditambahkan

Setelah semua commit selesai dibaca, rangkum hasil evaluasi.

Jangan langsung memasukkan setiap perubahan kode menjadi aturan.

Suatu perubahan harus dievaluasi untuk menentukan apakah mengandung prinsip yang:

- Penting untuk dipertahankan.
- Dapat dijadikan standar pengembangan.
- Dapat mencegah bug yang pernah terjadi.
- Dapat mencegah AI mengulangi kesalahan implementasi.
- Mencerminkan preferensi penulisan kode.
- Meningkatkan konsistensi antarfitur.
- Relevan untuk pengembangan berikutnya.
- Belum dijelaskan secara memadai dalam aturan yang sudah ada.

Perhatikan bahwa satu perubahan kode dapat menghasilkan lebih dari satu aturan.

Sebaliknya, beberapa perubahan kode juga dapat membuktikan bahwa sebenarnya hanya ada satu prinsip aturan yang sama.

Jangan membuat aturan hanya untuk memperbanyak isi dokumentasi.

**Utamakan aturan yang konkret, dapat diterapkan, memiliki alasan yang jelas, dan dapat mencegah kesalahan berulang.**

Jika suatu pola masih belum jelas maksud atau konsistensinya, jangan menjadikannya aturan wajib. Catat sebagai temuan yang belum dapat disimpulkan.

## 7. Pisahkan Aturan Global dan Aturan Khusus Proyek

Setiap aturan yang layak ditambahkan harus dievaluasi berdasarkan cakupannya.

### 7.1. Aturan bersama untuk seluruh proyek Flutter

Simpan pada:

`.agents/rules/global/aturan_bersama.md`

Masukkan aturan apabila prinsipnya dapat diterapkan secara konsisten pada seluruh proyek Flutter yang dikerjakan.

Contohnya:

- Prinsip penggunaan Dart dan Flutter SDK.
- Penanganan lifecycle widget.
- Penanganan asynchronous.
- Pencegahan memory leak.
- Prinsip pengelolaan state.
- Prinsip penulisan kode yang mudah dipelihara.
- Prinsip pengujian.
- Prinsip performa Flutter.
- Prinsip UX/UI yang berlaku lintas proyek.

Jangan memasukkan aturan yang hanya cocok untuk satu aplikasi, satu domain bisnis, satu backend, atau satu susunan folder.

Pastikan aturan tersebut memang dapat diterapkan pada seluruh proyek Flutter tanpa menimbulkan pertentangan dengan arsitektur masing-masing proyek.

### 7.2. Aturan khusus proyek

Simpan pada:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan aturan apabila penerapannya hanya relevan untuk proyek yang sedang dikerjakan.

Contohnya:

- Struktur folder khusus proyek.
- Arsitektur khusus proyek.
- Pola implementasi modul tertentu.
- Penggunaan paket khusus proyek.
- Integrasi database atau backend tertentu.
- Business logic khusus aplikasi.
- Ketentuan implementasi fitur tertentu.
- Keputusan teknis yang tidak bisa diterapkan ke proyek lain.

### 7.3. Jangan melewatkan peluang generalisasi

Ini merupakan ketentuan penting.

Walaupun suatu temuan hanya dapat diterapkan secara langsung pada proyek tertentu, tetap evaluasi apakah terdapat prinsip dasar yang dapat digunakan sebagai aturan bersama.

Contohnya:

- Implementasi detail suatu fitur mungkin hanya berlaku untuk satu proyek.
- Namun, prinsip pencegahan kesalahan asynchronous yang ditemukan dari implementasi tersebut mungkin dapat dijadikan aturan global.

Dengan demikian:

1. Detail implementasi tetap dimasukkan ke `aturan_khusus.md`.
2. Prinsip umum yang dapat diterapkan pada seluruh proyek Flutter dimasukkan ke `aturan_bersama.md`.
3. Jangan menyalin seluruh aturan khusus ke aturan global.
4. Jangan menghilangkan prinsip yang sebenarnya dapat digeneralisasi.
5. Jangan memaksakan generalisasi apabila prinsip tersebut memang tidak cocok diterapkan pada proyek lain.

**Setiap temuan harus diperiksa peluang penerapannya secara global sebelum diputuskan hanya menjadi aturan khusus proyek.**

## 8. Ketentuan Penulisan dan Pembaruan Aturan

Saat menulis atau memperbarui aturan:

1. Gunakan bahasa Indonesia yang baik dan benar.
2. Gunakan kalimat yang tegas dan tidak ambigu.
3. Jelaskan tindakan yang diwajibkan dan tindakan yang dilarang.
4. Jelaskan alasan aturan tersebut diperlukan.
5. Hindari kalimat yang dapat ditafsirkan dengan banyak cara.
6. Jangan membuat aturan yang saling bertentangan.
7. Jangan mengulang aturan yang sudah ada.
8. Utamakan memperbaiki atau memperjelas aturan yang sudah ada daripada membuat duplikat.
9. Jangan menghapus aturan lama tanpa alasan yang jelas.
10. Pertahankan aturan lama yang masih relevan.
11. Jangan mengubah aturan lain yang tidak berhubungan dengan hasil evaluasi.

### 8.1. Wajib menyertakan contoh kode benar dan salah

Setiap aturan baru atau aturan kode yang diperbarui wajib mempunyai contoh implementasi yang benar dan salah.

Gunakan struktur berikut:

````markdown
### Judul Aturan

**Aturan:**
Penjelasan tegas mengenai ketentuan yang harus diikuti.

**Alasan:**
Penjelasan mengapa aturan ini diperlukan.

**Contoh benar:**

```dart
// Implementasi yang sesuai dengan aturan.
```
````
`````

**Contoh salah:**

```dart
// Implementasi yang tidak sesuai dengan aturan.
```

**Sumber evaluasi:**
Commit: <HASH_COMMIT>
File: `path/file.dart`

````

Ketentuan contoh:

- Contoh harus relevan dengan aturan yang dijelaskan.
- Contoh benar harus menunjukkan implementasi yang direkomendasikan.
- Contoh salah harus menunjukkan pola yang dilarang atau berisiko.
- Gunakan contoh Dart/Flutter yang valid dan sesuai konteks.
- Jangan membuat nama API, function, atau method yang tidak ada.
- Pastikan contoh tidak bertentangan dengan aturan global maupun aturan khusus.
- Jika contoh diambil atau disederhanakan dari implementasi proyek, pertahankan maksud teknisnya.

Untuk aturan yang bukan aturan kode, gunakan contoh penerapan yang relevan apabila diperlukan.

### 8.2. Sertakan sumber perubahan

Setiap aturan baru sebaiknya mencantumkan sumber evaluasinya agar dapat ditelusuri.

Cantumkan:
- Hash commit.
- Nama file yang menjadi sumber.
- Alasan mengapa perubahan tersebut menghasilkan aturan.

Jangan mengklaim suatu aturan berasal dari commit tertentu jika perubahan tersebut tidak benar-benar terdapat di dalam commit tersebut.

## 9. Periksa Konflik dengan Aturan yang Sudah Ada

Sebelum menyimpan perubahan, periksa kembali hasil penulisan aturan.

Bandingkan dengan:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`

Periksa kemungkinan:

- Aturan duplikat.
- Aturan yang bertentangan.
- Aturan global yang terlalu spesifik.
- Aturan khusus yang sebenarnya dapat digeneralisasi.
- Aturan yang tidak konsisten dengan standar proyek.
- Contoh kode yang bertentangan dengan ketentuan lain.

Jika menemukan pertentangan:

1. Jangan mengubah aturan berdasarkan asumsi.
2. Periksa apakah dokumentasi sudah menjelaskan prioritas atau cakupan masing-masing aturan.
3. Jika konflik dapat diselesaikan berdasarkan ketentuan yang sudah ada, lakukan penyesuaian.
4. Jika konflik tidak dapat dipastikan, jangan memaksakan keputusan.
5. Laporkan konflik tersebut kepada pengguna beserta lokasi dan isi aturan yang bertentangan.

Jangan mengorbankan aturan yang sudah ditetapkan hanya demi memasukkan temuan baru.

## 10. Perbarui File Aturan

Setelah seluruh evaluasi selesai dan hasilnya sudah diperiksa:

1. Tambahkan atau perbarui aturan khusus proyek pada:

   `.agents/rules/proyek/aturan_khusus.md`

2. Tambahkan atau perbarui aturan global pada:

   `.agents/rules/global/aturan_bersama.md`

3. Pertahankan seluruh aturan lama yang masih relevan.
4. Jangan mengubah kode Dart, file konfigurasi aplikasi, atau file proyek lain.
5. Jangan mengedit `AGENTS.md` secara manual.

Jika file aturan belum tersedia, pastikan dahulu bahwa direktori dan struktur proyek memang sesuai sebelum membuat file yang diperlukan.

## 11. Perbarui AGENTS.md Menggunakan Script

Setelah pembaruan kedua file aturan selesai, jalankan:

```bash
bash scripts/build_rules_context.sh
````

Tujuannya memperbarui konteks aturan ke dalam:

`AGENTS.md`

Ketentuan:

1. Jalankan script setelah seluruh perubahan aturan selesai.
2. Jangan mengganti script dengan proses manual.
3. Jangan mengedit hasil `AGENTS.md` secara manual.
4. Jangan mengubah script.
5. Jika script gagal, periksa penyebabnya dan laporkan.
6. Jangan menjalankan operasi Git untuk mengatasi kegagalan script.
7. Setelah berhasil, baca kembali `AGENTS.md` untuk memastikan konteks aturan terbaru sudah masuk.
8. Pastikan tidak ada aturan penting yang hilang akibat proses pembaruan.

Jika script menghasilkan perubahan pada file lain yang tidak termasuk dalam tujuan pembaruan, jangan lanjutkan perubahan tersebut tanpa alasan yang jelas. Laporkan hasilnya.

## 12. Evaluasi Akhir

Sebelum menyelesaikan tugas, pastikan seluruh ketentuan berikut sudah dipenuhi:

- [ ] Maksimal 15 commit terbaru sudah dipilih.
- [ ] Setiap commit sudah dibaca satu per satu.
- [ ] Seluruh file yang berubah dalam setiap commit sudah diperiksa.
- [ ] Perubahan gaya penulisan kode sudah dievaluasi.
- [ ] Perubahan yang berkaitan dengan bug sudah dievaluasi.
- [ ] Arsitektur, pengelolaan state, performa, UX/UI, dan aspek teknis lain sudah dievaluasi.
- [ ] Perubahan yang diperbaiki atau digantikan oleh commit berikutnya sudah diperhitungkan.
- [ ] Aturan khusus proyek sudah dievaluasi dan diperbarui jika diperlukan.
- [ ] Setiap temuan sudah diperiksa peluang generalisasinya.
- [ ] Prinsip yang dapat diterapkan ke seluruh proyek Flutter sudah dipertimbangkan untuk aturan bersama.
- [ ] Aturan baru atau aturan kode yang diperbarui mempunyai contoh benar dan salah.
- [ ] Tidak ada aturan duplikat.
- [ ] Tidak ada konflik aturan yang dibiarkan tanpa dilaporkan.
- [ ] `scripts/build_rules_context.sh` sudah dijalankan atau kegagalannya sudah dilaporkan.
- [ ] `AGENTS.md` sudah diperiksa setelah pembaruan.
- [ ] Tidak ada kode sumber yang diubah.
- [ ] Tidak ada perubahan Git yang belum di-commit yang disentuh atau diubah.

## 13. Format Laporan Akhir

Setelah semua pekerjaan selesai, berikan laporan dengan format berikut.

### A. Ringkasan Evaluasi Commit

Cantumkan jumlah commit yang diperiksa dan rentang commit.

Buat tabel:

| No. | Hash Commit | Pesan Commit | Hasil Evaluasi   |
| --- | ----------- | ------------ | ---------------- |
| 1   | Hash        | Pesan        | Ringkasan temuan |
| 2   | Hash        | Pesan        | Ringkasan temuan |

Pastikan seluruh commit yang dievaluasi tercantum.

### B. Pembaruan Aturan Khusus

Lokasi:

`.agents/rules/proyek/aturan_khusus.md`

Jelaskan:

- Aturan yang ditambahkan.
- Aturan yang diperbarui.
- Alasan pembaruan.
- Commit sumbernya.

Jika tidak ada perubahan, jelaskan alasannya.

### C. Pembaruan Aturan Bersama

Lokasi:

`.agents/rules/global/aturan_bersama.md`

Jelaskan:

- Prinsip umum Flutter/Dart yang ditambahkan.
- Aturan lama yang diperjelas.
- Aturan yang berhasil digeneralisasi dari temuan khusus proyek.
- Alasan mengapa aturan tersebut dapat diterapkan pada proyek Flutter lainnya.

Jika tidak ada perubahan, jelaskan alasannya.

### D. Temuan yang Tidak Dijadikan Aturan

Cantumkan temuan yang tidak dimasukkan ke dokumentasi, beserta alasannya.

Contohnya:

- Hanya berlaku pada satu kondisi sementara.
- Sudah diatur dalam dokumentasi lain.
- Tidak dapat digeneralisasi.
- Belum cukup bukti untuk dijadikan aturan.
- Bertentangan dengan ketentuan yang belum dapat dipastikan prioritasnya.

### E. Hasil Pembaruan AGENTS.md

Jelaskan:

- Apakah `scripts/build_rules_context.sh` berhasil dijalankan.
- Apakah `AGENTS.md` berhasil diperbarui.
- Apakah isi aturan terbaru sudah masuk.

### F. Konfirmasi Keamanan Git

Nyatakan bahwa audit tidak melakukan operasi yang mengubah working tree, staging area, branch, maupun riwayat commit.

Jangan menyatakan berhasil apabila ada tahapan yang belum dilakukan.

---

# Prinsip Utama

Tujuan command ini bukan sekadar memperbanyak aturan.

Tujuannya adalah mempelajari perubahan yang telah dikerjakan, menemukan pola implementasi yang perlu dipertahankan, mengidentifikasi kesalahan yang tidak boleh terulang, serta membangun standar pengembangan yang semakin konsisten.

**Aturan khusus menjaga keputusan dan kebutuhan proyek. Aturan bersama menjaga konsistensi seluruh proyek Flutter.**

Setiap hasil evaluasi harus memberikan kontribusi nyata terhadap kualitas aturan tersebut, bukan sekadar menambah panjang dokumentasi.

```

```
