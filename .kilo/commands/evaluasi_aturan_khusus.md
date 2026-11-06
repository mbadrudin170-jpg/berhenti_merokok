---
description: Evaluasi tepat 5 commit terakhir satu per satu untuk menemukan standar dan preferensi implementasi, memperbarui aturan khusus dan aturan bersama Flutter, lalu memperbarui AGENTS.md.
agent: code
---

# EVALUASI RIWAYAT COMMIT DAN PEMBARUAN ATURAN

## 1. Tujuan Utama

Tugas Anda adalah mempelajari 5 commit terakhir untuk memahami standar penulisan kode, pola implementasi, keputusan teknis, preferensi pengembangan, dan kualitas kode yang ingin dipertahankan pengguna.

Hasil evaluasi harus digunakan untuk memperbarui:

1. `.agents/rules/proyek/aturan_khusus.md`
   - Menampung aturan yang berlaku khusus untuk proyek saat ini.
   - Menampung keputusan implementasi, pola arsitektur, standar teknis, dan preferensi khusus proyek.

2. `.agents/rules/global/aturan_bersama.md`
   - Menampung prinsip yang dapat diterapkan pada seluruh proyek Flutter.
   - Menampung standar umum penulisan Dart dan Flutter, kualitas implementasi, keamanan, performa, dan prinsip pengembangan lainnya yang berlaku lintas proyek.

3. `AGENTS.md`
   - Memperbarui konteks aturan menggunakan script `scripts/build_rules_context.sh`.

Tujuan akhirnya adalah membangun dokumentasi aturan yang semakin lengkap berdasarkan pekerjaan yang sudah dilakukan pengguna.

Dengan demikian, AI dapat memahami standar dan preferensi pengguna serta menghindari pengulangan kesalahan ketika memperbaiki atau menambahkan kode pada kemudian hari.

**Jangan hanya mengevaluasi apakah kode berjalan. Evaluasi juga apakah cara implementasinya sudah sesuai dengan standar dan preferensi pengguna.**

## 2. Ketentuan Utama

### 2.1. Evaluasi tepat 5 commit terakhir

Anda WAJIB mengevaluasi tepat 5 commit terakhir dari `HEAD` pada branch yang sedang aktif.

Ketentuan:

1. Ambil tepat 5 commit terbaru.
2. Jangan mengambil lebih dari 5 commit.
3. Jangan mengambil kurang dari 5 commit.
4. Jangan mengambil commit dari branch lain.
5. Jangan memperluas pemeriksaan ke seluruh riwayat proyek.
6. Jangan mengganti commit yang tidak dapat diperiksa dengan commit dari branch lain.

Gunakan:

```bash
git log -5 --date=short --pretty=format:'%H%x09%ad%x09%s' HEAD
```

Pastikan hasilnya berisi tepat 5 commit.

**Jika riwayat yang tersedia kurang dari 5 commit, hentikan evaluasi dan laporkan jumlah commit yang tersedia. Jangan memaksakan evaluasi menggunakan jumlah yang lebih sedikit.**

Jangan melanjutkan pembaruan aturan berdasarkan evaluasi yang tidak memenuhi ketentuan tepat 5 commit.

### 2.2. Setiap commit wajib dibaca satu per satu

Jangan hanya membaca ringkasan seluruh commit sekaligus.

Setiap commit harus diperiksa secara individual, termasuk commit yang hanya memiliki sedikit perubahan.

Jangan melewatkan commit dengan alasan:

- Perubahannya hanya sedikit.
- Hanya mengubah satu file.
- Hanya memperbaiki satu function.
- Terlihat sederhana.
- Pesan commit dianggap sudah cukup menjelaskan perubahan.

Setiap commit tetap memiliki kemungkinan mengandung preferensi atau standar implementasi yang penting.

### 2.3. Jangan mengubah commit yang sudah ada

Commit yang sudah tersimpan dianggap sebagai riwayat pekerjaan yang telah diselesaikan.

Ketentuan:

- Jangan mengubah isi commit.
- Jangan melakukan amend.
- Jangan melakukan rebase.
- Jangan melakukan cherry-pick.
- Jangan melakukan revert.
- Jangan mengubah urutan riwayat commit.
- Jangan memperbaiki kode langsung berdasarkan commit lama.

Tugas Anda adalah mempelajari perubahan tersebut dan mengambil pelajaran untuk dokumentasi aturan.

**Evaluasi commit tidak berarti memperbaiki atau mengubah commit tersebut.**

### 2.4. Jangan mengubah pekerjaan Git yang belum di-commit

Jangan menyentuh perubahan kode yang belum di-commit, baik yang sudah masuk staging maupun yang belum masuk staging.

Dilarang menggunakan:

- `git checkout`
- `git reset`
- `git restore`
- `git stash`
- `git clean`
- `git add`
- `git commit`
- `git amend`
- `git rebase`
- `git merge`
- `git cherry-pick`
- `git revert`
- `git pull`
- `git push`

Larangan berlaku untuk seluruh operasi lain yang dapat mengubah kondisi Git.

Audit hanya menggunakan riwayat commit yang sudah tersimpan.

Jangan menggunakan perubahan Dart yang belum di-commit sebagai bahan evaluasi atau mengubahnya untuk kepentingan audit.

Pengecualian yang diperbolehkan hanya perubahan dokumentasi pada tiga lokasi yang memang menjadi tujuan command ini:

- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`
- `AGENTS.md`, melalui script yang ditentukan.

Pengecualian tersebut tidak memberikan izin untuk mengubah staging area atau pekerjaan kode yang belum di-commit.

Jika file aturan memiliki perubahan yang belum di-commit, pertahankan seluruh isinya dan lakukan pembaruan tanpa menghilangkan pekerjaan yang sudah ada.

Jangan pernah menggunakan operasi Git untuk mengatasi konflik atau kehilangan isi file.

## 3. Persiapan Sebelum Evaluasi

Sebelum membaca commit, lakukan langkah berikut.

### 3.1. Baca seluruh dokumentasi aturan

Baca seluruh isi file:

1. `AGENTS.md`
2. `.agents/rules/proyek/aturan_khusus.md`
3. `.agents/rules/global/aturan_bersama.md`

Tujuannya:

- Memahami standar yang sudah ditetapkan.
- Mengetahui aturan yang sudah berlaku.
- Menghindari penambahan aturan yang sama.
- Memahami hubungan antara aturan khusus dan aturan global.
- Mengetahui kemungkinan konflik.
- Memahami preferensi yang sudah pernah didokumentasikan.

Jangan hanya membaca bagian awal atau mengandalkan ingatan dari percakapan sebelumnya.

Jika file belum tersedia, pastikan kondisinya terlebih dahulu sebelum membuatnya.

### 3.2. Pahami script pembaruan AGENTS.md

Baca seluruh isi:

`scripts/build_rules_context.sh`

Pahami:

- Cara kerja script.
- File sumber yang dibaca.
- File yang dihasilkan.
- Apakah script menimpa atau menggabungkan isi `AGENTS.md`.
- Apakah terdapat operasi penghapusan.
- Apakah terdapat operasi Git.
- Apakah terdapat efek samping lainnya.

Script tidak boleh diubah.

Jangan menjalankan script sebelum memahami dampaknya terhadap file proyek dan pekerjaan yang belum di-commit.

### 3.3. Periksa keamanan file tujuan

Sebelum memperbarui aturan, pastikan seluruh isi file tujuan yang sudah ada tetap aman.

Gunakan pemeriksaan baca-saja apabila diperlukan untuk mengetahui apakah target memiliki perubahan staged atau unstaged.

Jangan memeriksa atau mengubah file Dart yang belum di-commit untuk kepentingan evaluasi ini.

Ketentuan:

1. Jangan menghilangkan perubahan dokumentasi yang sudah ada.
2. Jangan mengganti isi file secara membabi buta.
3. Jangan menghapus aturan yang belum dievaluasi.
4. Pertahankan isi yang masih relevan.
5. Jika script akan menimpa perubahan pengguna pada `AGENTS.md`, jangan jalankan script tersebut.
6. Jika keamanan pembaruan tidak dapat dipastikan, hentikan bagian yang berisiko dan laporkan.

## 4. Pengambilan 5 Commit Terakhir

Ambil 5 commit terakhir dari `HEAD` menggunakan:

```bash
git log -5 --date=short --pretty=format:'%H%x09%ad%x09%s' HEAD
```

Catat seluruh informasi berikut:

- Hash commit lengkap.
- Tanggal commit.
- Pesan commit.

Jangan menganggap pesan commit sebagai penjelasan lengkap perubahan kode.

Pesan commit hanya digunakan untuk mengetahui konteks awal.

Setelah memperoleh tepat 5 commit, urutkan pemeriksaan dari commit paling lama menuju commit terbaru.

**Urutan pengambilan adalah terbaru ke terlama, tetapi urutan evaluasi adalah terlama ke terbaru.**

Tujuannya agar Anda memahami perkembangan implementasi dan dapat mengetahui apabila pendekatan lama telah diperbaiki atau digantikan oleh perubahan berikutnya.

## 5. Evaluasi Setiap Commit Satu per Satu

Ini merupakan ketentuan wajib.

Untuk setiap commit, lakukan seluruh langkah berikut sebelum beralih ke commit berikutnya.

### 5.1. Baca informasi commit

Gunakan:

```bash
git show -s --format=fuller <HASH_COMMIT>
```

Pahami:

- Tanggal commit.
- Pesan commit.
- Informasi perubahan.
- Konteks pekerjaan berdasarkan metadata yang tersedia.

### 5.2. Identifikasi seluruh file yang berubah

Gunakan:

```bash
git diff-tree --no-commit-id --name-status -r --find-renames <HASH_COMMIT>
```

Untuk commit merge, gunakan pembandingan terhadap parent pertama.

Jangan hanya melihat file Dart. Perhatikan seluruh file yang berubah untuk mengetahui apakah terdapat perubahan konfigurasi, testing, atau dokumentasi teknis yang berkaitan dengan implementasi.

### 5.3. Baca seluruh perubahan commit

Untuk commit yang memiliki parent:

```bash
git diff --no-ext-diff --find-renames --unified=80 <HASH_COMMIT>^1 <HASH_COMMIT> --
```

Untuk commit awal yang tidak memiliki parent:

```bash
git show --root --no-ext-diff --format=fuller --find-renames --patch <HASH_COMMIT>
```

Untuk commit merge, gunakan parent pertama sebagai dasar perbandingan.

Ketentuan:

1. Baca seluruh perubahan.
2. Jangan hanya membaca ringkasan statistik.
3. Jangan hanya membaca nama file.
4. Jangan mengabaikan perubahan kecil.
5. Jangan melewatkan perubahan kode yang tampak sederhana.
6. Jika hasil terlalu panjang, pecah pembacaan berdasarkan file.
7. Pastikan seluruh bagian perubahan sudah dibaca.

Jika satu commit mengubah banyak file, periksa seluruh file satu per satu.

### 5.4. Evaluasi isi perubahan

Periksa seluruh aspek implementasi yang relevan, termasuk:

**A. Gaya dan standar penulisan kode**

- Penamaan class, function, variable, dan file.
- Struktur class dan function.
- Susunan kode.
- Konsistensi penulisan.
- Pemisahan tanggung jawab.
- Penggunaan abstraksi.
- Penggunaan komentar.
- Keterbacaan.
- Maintainability.

**B. Bug dan keamanan runtime**

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

**C. Arsitektur dan pengelolaan state**

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

**D. Performa**

- Rebuild widget.
- Efisiensi pemrosesan data.
- Efisiensi query database.
- Penggunaan cache.
- Penggunaan resource.
- Operasi berat pada UI thread.
- Penggunaan Future dan Stream.
- Penggunaan memori.

**E. UX/UI**

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

**F. Testing**

- Kualitas pengujian.
- Unit test.
- Penggunaan mock dan fake.
- Pengujian kondisi normal dan ekstrem.
- Pengujian business logic.
- Pengujian terhadap kemungkinan kesalahan.

**G. Aspek lainnya**

Jangan membatasi evaluasi pada daftar tersebut.

Jika perubahan mengandung keputusan teknis lain yang dapat menjadi standar, evaluasi juga.

### 5.5. Catat hasil evaluasi sebelum melanjutkan

Setelah satu commit selesai diperiksa, catat:

- Apa yang berubah?
- Mengapa perubahan tersebut dilakukan, jika dapat diketahui?
- Pola implementasi apa yang digunakan?
- Standar penulisan apa yang terlihat?
- Preferensi pengguna apa yang dapat disimpulkan?
- Keputusan teknis apa yang perlu dipertahankan?
- Apakah ada pola yang dapat digeneralisasi?
- Apakah terdapat pola yang belum cukup jelas untuk dijadikan aturan?

Jangan melanjutkan ke commit berikutnya sebelum seluruh perubahan commit saat ini selesai dibaca dan dievaluasi.

## 6. Pahami Preferensi Pengguna dari Riwayat Commit

Jangan hanya mengevaluasi benar atau salah secara teknis.

Perhatikan juga bagaimana pengguna mengembangkan proyek.

Tujuannya adalah membantu AI memahami pola pekerjaan dan standar yang benar-benar diinginkan pengguna.

Identifikasi preferensi berdasarkan bukti perubahan.

Contohnya:

- Cara pengguna menyusun function.
- Cara pengguna memisahkan business logic.
- Cara pengguna menggunakan provider.
- Cara pengguna mengelola state.
- Cara pengguna menangani error.
- Cara pengguna mengelola cache.
- Cara pengguna menghindari abstraksi yang tidak diperlukan.
- Cara pengguna menyusun widget.
- Cara pengguna mengelola asynchronous.
- Cara pengguna menulis unit test.
- Cara pengguna memperbaiki bug.
- Cara pengguna mempertahankan konsistensi implementasi.

Jangan menyimpulkan preferensi hanya dari satu perubahan yang belum tentu disengaja.

Perhatikan pola yang berulang dan perubahan yang menunjukkan keputusan teknis secara jelas.

### 6.1. Bedakan preferensi dengan kebetulan implementasi

Tidak semua kode yang muncul dalam commit harus dijadikan aturan.

Bedakan:

1. Preferensi yang terlihat konsisten.
2. Keputusan teknis yang memang disengaja.
3. Implementasi sementara.
4. Solusi khusus untuk satu kondisi.
5. Pola yang muncul karena keterbatasan teknis.
6. Kesalahan implementasi.
7. Perubahan yang sudah diperbaiki oleh commit selanjutnya.

Jangan menjadikan implementasi yang kebetulan digunakan sebagai standar wajib.

### 6.2. Commit dianggap pekerjaan yang sudah disimpan

Perlakukan commit sebagai riwayat implementasi yang sudah selesai dan disimpan pengguna.

Namun, jangan menganggap seluruh pola di dalamnya otomatis benar atau harus diterapkan kembali.

Jika menemukan implementasi yang secara teknis berisiko:

- Catat sebagai temuan evaluasi.
- Periksa apakah commit berikutnya sudah memperbaikinya.
- Jangan mengubah commit.
- Jangan menjadikan pola yang salah sebagai aturan.
- Jangan membuat aturan berdasarkan satu contoh yang belum dapat dipastikan.

Tujuannya adalah mengambil pelajaran dari riwayat pekerjaan, bukan menyalin semua implementasi tanpa penilaian.

## 7. Perhatikan Hubungan Antar-Commit

Setelah kelima commit diperiksa satu per satu, lakukan evaluasi hubungan antar-commit.

Perhatikan:

- Apakah ada implementasi yang disempurnakan?
- Apakah ada function yang mengalami perubahan pola?
- Apakah ada pendekatan yang diganti?
- Apakah ada bug yang diperbaiki?
- Apakah ada aturan yang sebelumnya belum terlihat tetapi kemudian menjadi jelas?
- Apakah ada pola yang konsisten pada beberapa commit?

Jangan menggunakan implementasi lama sebagai acuan apabila commit terbaru jelas menunjukkan bahwa implementasi tersebut telah diganti.

Jika commit berikutnya memperbaiki pola sebelumnya, gunakan hasil akhir yang lebih baru sebagai referensi utama.

Jangan menggabungkan dua pendekatan yang saling bertentangan menjadi satu aturan.

### 7.1. Jangan menganggap commit kecil tidak penting

Pengguna memang menyukai commit kecil agar setiap perubahan lebih mudah diperiksa dan dipisahkan apabila terjadi kesalahan.

Karena itu:

- Periksa setiap commit secara mandiri.
- Pertahankan batas antar-commit saat mengevaluasi.
- Jangan melewati commit yang hanya mengubah sedikit kode.
- Jangan menyimpulkan bahwa satu commit tidak memiliki nilai pembelajaran hanya karena kecil.
- Perhatikan apakah serangkaian commit kecil menunjukkan perkembangan standar implementasi.

Jangan menyarankan pengguna menggabungkan commit atau mengubah strategi commit.

## 8. Tentukan Aturan yang Layak Didokumentasikan

Setelah kelima commit selesai dievaluasi, rangkum seluruh hasilnya.

Jangan langsung memasukkan setiap perubahan ke dalam dokumentasi aturan.

Suatu perubahan layak menjadi aturan apabila mengandung prinsip yang:

1. Penting untuk dipertahankan.
2. Mencerminkan preferensi pengguna.
3. Dapat mencegah kesalahan berulang.
4. Memiliki alasan teknis yang jelas.
5. Dapat diterapkan secara konsisten.
6. Belum diatur atau belum dijelaskan dengan baik.
7. Relevan untuk pengembangan berikutnya.

Perhatikan bahwa:

- Satu perubahan dapat menghasilkan beberapa aturan.
- Beberapa commit dapat membuktikan satu aturan yang sama.
- Satu aturan dapat berasal dari perkembangan beberapa commit.
- Satu aturan dapat memiliki contoh benar dan salah berdasarkan pola yang ditemukan.

Jangan membuat aturan hanya untuk memperbanyak isi dokumentasi.

**Utamakan aturan yang konkret, dapat diterapkan, dan mempunyai manfaat nyata.**

## 9. Pisahkan Aturan Khusus dan Aturan Bersama

Setiap temuan yang layak menjadi aturan harus diperiksa cakupan penerapannya.

### 9.1. Aturan khusus proyek

Lokasi:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan aturan jika ketentuannya hanya relevan untuk proyek saat ini.

Contohnya:

- Struktur folder khusus proyek.
- Arsitektur khusus aplikasi.
- Pola implementasi modul tertentu.
- Penggunaan paket khusus proyek.
- Integrasi database atau backend tertentu.
- Business logic khusus aplikasi.
- Ketentuan implementasi fitur tertentu.
- Keputusan teknis yang tidak bisa diterapkan pada proyek lain.
- Preferensi implementasi yang memang hanya relevan pada proyek tersebut.

Jangan memasukkan ketentuan khusus proyek ke aturan global hanya karena menggunakan Flutter.

### 9.2. Aturan bersama seluruh proyek Flutter

Lokasi:

`.agents/rules/global/aturan_bersama.md`

Masukkan prinsip yang dapat diterapkan secara konsisten pada seluruh proyek Flutter.

Contohnya:

- Standar penulisan Dart.
- Penanganan asynchronous.
- Pencegahan bug runtime.
- Pengelolaan lifecycle widget.
- Pengelolaan resource.
- Prinsip state management.
- Pencegahan rebuild yang tidak diperlukan.
- Prinsip maintainability.
- Pengujian.
- Prinsip UX/UI lintas proyek.
- Penggunaan Flutter dan Dart SDK.

Pastikan aturan tersebut memang dapat diterapkan pada proyek Flutter lainnya tanpa bertentangan dengan arsitektur masing-masing proyek.

### 9.3. Wajib mencari peluang generalisasi

Ini merupakan ketentuan yang sangat penting.

Walaupun suatu implementasi hanya dapat diterapkan secara langsung pada proyek tertentu, tetap evaluasi apakah terdapat prinsip dasar yang bisa digunakan sebagai aturan bersama.

Contohnya:

- Detail implementasi provider tertentu mungkin hanya cocok untuk satu aplikasi.
- Namun, prinsip pemisahan business logic dari UI mungkin dapat digunakan di seluruh proyek Flutter.

Dengan demikian:

1. Detail implementasi tetap dimasukkan ke `aturan_khusus.md`.
2. Prinsip umum yang dapat diterapkan lintas proyek dimasukkan ke `aturan_bersama.md`.
3. Jangan menyalin seluruh aturan khusus ke aturan global.
4. Jangan menghilangkan prinsip umum yang sebenarnya dapat digeneralisasi.
5. Jangan memaksakan generalisasi apabila memang tidak sesuai dengan proyek Flutter lainnya.

**Setiap aturan khusus wajib diperiksa apakah mempunyai prinsip dasar yang dapat dijadikan referensi aturan bersama.**

Walaupun hasil akhirnya tetap hanya dimasukkan ke aturan khusus, dokumentasikan pertimbangan mengapa prinsip tersebut tidak cocok digeneralisasi.

## 10. Penulisan Aturan

Gunakan bahasa Indonesia yang baik dan benar.

Ketentuan:

1. Gunakan kalimat tegas.
2. Hindari kalimat ambigu.
3. Jelaskan tindakan yang diwajibkan.
4. Jelaskan tindakan yang dilarang.
5. Jelaskan alasan aturan.
6. Hindari aturan yang terlalu umum.
7. Jangan membuat aturan duplikat.
8. Jangan menghilangkan aturan lama yang masih relevan.
9. Perjelas aturan lama jika memang diperlukan.
10. Pertahankan struktur dokumentasi yang sudah ada.

Jangan mengubah aturan yang tidak berhubungan dengan hasil evaluasi.

### 10.1. Setiap aturan kode wajib memiliki contoh benar dan salah

Setiap aturan baru atau aturan kode yang diperbarui wajib menyertakan contoh implementasi yang benar dan salah.

Gunakan struktur berikut:

### Judul Aturan

**Aturan:**

Jelaskan ketentuan yang harus diikuti.

**Alasan:**

Jelaskan mengapa aturan ini diperlukan.

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
- Contoh harus sesuai dengan konteks Flutter dan Dart.
- Jangan menggunakan kode yang mengandung kesalahan lain yang tidak berkaitan dengan aturan.
- Jangan membuat nama function atau API fiktif.

Jika satu aturan berasal dari beberapa commit, cantumkan sumber commit yang relevan.

Untuk aturan yang bukan aturan kode, gunakan contoh penerapan benar dan salah yang sesuai dengan konteksnya.

### 10.2. Sertakan sumber setiap aturan

Setiap aturan baru harus memiliki sumber evaluasi yang jelas.

Cantumkan:

- Hash commit.
- Path file sumber.
- Alasan perubahan tersebut menghasilkan aturan.

Jika satu aturan merupakan hasil pengamatan dari beberapa commit, cantumkan seluruh commit yang mendukung kesimpulan tersebut.

Jangan mengklaim sebuah aturan berasal dari commit tertentu apabila perubahan tersebut tidak terdapat dalam commit terkait.

## 11. Evaluasi Konflik dan Duplikasi

Sebelum memperbarui dokumentasi, bandingkan hasil evaluasi dengan:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`

Periksa:

1. Aturan duplikat.
2. Aturan yang saling bertentangan.
3. Aturan global yang terlalu spesifik.
4. Aturan khusus yang sebenarnya bisa digeneralisasi.
5. Aturan yang tidak konsisten dengan preferensi pengguna.
6. Contoh benar yang bertentangan dengan aturan lain.
7. Contoh salah yang sebenarnya diperbolehkan oleh aturan lain.
8. Aturan yang sudah tidak relevan.

Jika menemukan konflik:

1. Periksa prioritas aturan yang sudah ditentukan.
2. Jangan menebak penyelesaian.
3. Jangan menghapus aturan lama secara sembarangan.
4. Jangan memasukkan aturan baru yang bertentangan.
5. Jika konflik tidak bisa dipastikan, laporkan kepada pengguna.

Utamakan memperbaiki redaksi aturan yang sudah ada daripada membuat aturan baru dengan maksud yang sama.

## 12. Perbarui File Aturan

Setelah semua evaluasi selesai, lakukan pembaruan.

### 12.1. Perbarui aturan khusus

Path:

`.agents/rules/proyek/aturan_khusus.md`

Tindakan:

- Tambahkan aturan khusus yang benar-benar diperlukan.
- Perbarui aturan lama yang perlu diperjelas.
- Pertahankan seluruh aturan yang masih relevan.
- Hindari duplikasi.
- Sertakan contoh benar dan salah.
- Sertakan sumber commit.

### 12.2. Perbarui aturan bersama

Path:

`.agents/rules/global/aturan_bersama.md`

Tindakan:

- Tambahkan prinsip yang dapat diterapkan ke seluruh proyek Flutter.
- Perjelas aturan global yang sudah ada.
- Ambil prinsip umum dari temuan aturan khusus.
- Hindari memasukkan detail implementasi khusus proyek.
- Sertakan contoh benar dan salah.
- Sertakan sumber evaluasi.

### 12.3. Jaga isi dokumentasi sebelumnya

Jangan mengganti seluruh isi file tanpa alasan.

Jangan menghapus aturan lama hanya karena ditemukan pendekatan baru.

Jika sebuah aturan lama perlu diganti:

1. Pastikan terdapat bukti dari hasil evaluasi.
2. Pastikan aturan baru memang lebih sesuai.
3. Pastikan tidak menimbulkan konflik.
4. Pertahankan informasi lama yang masih relevan.

Jika tidak ada aturan baru yang layak ditambahkan, jangan membuat aturan yang dipaksakan.

## 13. Perbarui AGENTS.md Menggunakan Script

Setelah kedua file aturan selesai diperbarui, jalankan script berikut:

```bash
bash scripts/build_rules_context.sh
```

Tujuannya memperbarui konteks aturan ke dalam:

`AGENTS.md`

### 13.1. Ketentuan eksekusi

1. Script harus dibaca dan dipahami terlebih dahulu.
2. Jalankan hanya setelah seluruh pembaruan aturan selesai.
3. Jangan mengubah script.
4. Jangan mengganti proses script dengan pembaruan manual.
5. Jangan menjalankan script lain sebagai pengganti.
6. Jangan mengedit `AGENTS.md` secara manual.
7. Jangan menjalankan operasi Git untuk mengatasi kegagalan script.

### 13.2. Lindungi perubahan pengguna

Sebelum menjalankan script, pastikan script tidak akan menghilangkan perubahan `AGENTS.md` yang sudah ada.

Apabila `AGENTS.md` memiliki perubahan staged atau unstaged:

- Periksa apakah script mempertahankan perubahan tersebut.
- Jika script terbukti aman dan tidak menghapus pekerjaan pengguna, script boleh dijalankan.
- Jika script akan menimpa atau menghilangkan perubahan pengguna, jangan jalankan.
- Laporkan konflik tersebut kepada pengguna.

Jangan menggunakan `checkout`, `reset`, `restore`, atau `stash` untuk mengatasi kondisi tersebut.

### 13.3. Periksa hasil pembaruan

Setelah script berhasil:

1. Baca kembali `AGENTS.md`.
2. Pastikan konteks aturan terbaru sudah masuk.
3. Pastikan tidak ada aturan penting yang hilang.
4. Pastikan pembaruan tidak mengubah kode sumber.
5. Pastikan script tidak mengubah staging area.
6. Pastikan tidak ada file lain yang berubah di luar tujuan yang diizinkan.

Jika script gagal, jangan melakukan tindakan berisiko untuk memaksakan keberhasilan.

Laporkan penyebab kegagalan kepada pengguna.

## 14. Evaluasi Akhir

Sebelum menyelesaikan tugas, pastikan:

### Riwayat commit

- [ ] Tepat 5 commit terakhir sudah dipilih.
- [ ] Tidak ada commit tambahan di luar 5 commit tersebut yang dievaluasi.
- [ ] Setiap commit dibaca satu per satu.
- [ ] Tidak ada commit yang dilewati.
- [ ] Seluruh perubahan dalam setiap commit sudah diperiksa.
- [ ] Evaluasi dilakukan dari commit paling lama menuju commit terbaru.
- [ ] Perkembangan implementasi antar-commit sudah diperhitungkan.

### Evaluasi kualitas

- [ ] Gaya penulisan kode sudah dievaluasi.
- [ ] Pola implementasi sudah dievaluasi.
- [ ] Bug dan keamanan runtime sudah dievaluasi.
- [ ] Arsitektur dan state management sudah dievaluasi.
- [ ] Performa sudah dievaluasi.
- [ ] UX/UI sudah dievaluasi.
- [ ] Testing sudah dievaluasi.
- [ ] Preferensi pengguna sudah dipertimbangkan.
- [ ] Pola yang hanya kebetulan digunakan tidak dijadikan aturan.

### Pembaruan aturan

- [ ] Aturan khusus sudah dievaluasi dan diperbarui jika diperlukan.
- [ ] Aturan bersama sudah dievaluasi dan diperbarui jika diperlukan.
- [ ] Setiap aturan khusus sudah diperiksa peluang generalisasinya.
- [ ] Tidak ada aturan duplikat.
- [ ] Tidak ada konflik aturan yang dibiarkan tanpa laporan.
- [ ] Contoh kode benar dan salah sudah disertakan.
- [ ] Sumber commit setiap aturan baru sudah dicantumkan.
- [ ] Aturan lama yang masih relevan tetap dipertahankan.

### Pembaruan AGENTS.md

- [ ] `scripts/build_rules_context.sh` sudah diperiksa.
- [ ] Script berhasil dijalankan atau kegagalannya sudah dilaporkan.
- [ ] `AGENTS.md` sudah diperiksa setelah pembaruan.
- [ ] Konteks aturan terbaru sudah masuk.

### Keamanan Git

- [ ] Tidak ada commit lama yang diubah.
- [ ] Tidak ada perubahan kode yang belum di-commit yang disentuh.
- [ ] Tidak ada file Dart yang diubah.
- [ ] Tidak ada staging area yang diubah.
- [ ] Tidak ada operasi checkout, reset, restore, atau stash.
- [ ] Tidak ada commit baru yang dibuat.
- [ ] Hanya file aturan dan hasil pembaruan `AGENTS.md` yang diubah sesuai tujuan command.

Jika ada ketentuan yang tidak terpenuhi, laporkan dengan jujur. Jangan menyatakan seluruh pekerjaan berhasil apabila masih ada tahapan yang belum selesai.

## 15. Format Laporan Akhir

Setelah seluruh pekerjaan selesai, buat laporan dengan struktur berikut.

### A. Ringkasan Evaluasi

Cantumkan bahwa tepat 5 commit sudah dievaluasi.

### B. Riwayat Commit yang Dievaluasi

| No. | Hash Commit | Tanggal | Pesan Commit | Hasil Evaluasi |
| --- | ----------- | ------- | ------------ | -------------- |
| 1   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 2   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 3   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 4   | Hash        | Tanggal | Pesan        | Ringkasan      |
| 5   | Hash        | Tanggal | Pesan        | Ringkasan      |

Urutkan sesuai urutan evaluasi, yaitu dari commit paling lama menuju terbaru.

### C. Pembaruan Aturan Khusus

Path:

`.agents/rules/proyek/aturan_khusus.md`

Jelaskan:

- Aturan baru yang ditambahkan.
- Aturan lama yang diperbarui.
- Alasan pembaruan.
- Commit sumber.
- File sumber perubahan.

Jika tidak ada perubahan, jelaskan alasannya.

### D. Pembaruan Aturan Bersama

Path:

`.agents/rules/global/aturan_bersama.md`

Jelaskan:

- Prinsip Flutter/Dart yang ditambahkan.
- Aturan lama yang diperjelas.
- Prinsip umum yang berhasil digeneralisasi dari temuan khusus.
- Alasan aturan dapat diterapkan pada proyek Flutter lainnya.
- Commit sumber.

Jika tidak ada perubahan, jelaskan alasannya.

### E. Hasil Generalisasi Aturan

Jelaskan temuan khusus yang berhasil atau tidak berhasil digeneralisasi menjadi aturan bersama.

Jika tidak berhasil digeneralisasi, jelaskan mengapa temuan tersebut hanya relevan untuk proyek saat ini.

### F. Temuan yang Tidak Dijadikan Aturan

Cantumkan temuan yang tidak dimasukkan ke dokumentasi beserta alasannya.

Contohnya:

- Hanya berlaku untuk satu kondisi sementara.
- Sudah diatur dalam dokumentasi lain.
- Tidak dapat digeneralisasi.
- Belum cukup bukti untuk dijadikan aturan.
- Merupakan implementasi lama yang sudah digantikan.
- Berpotensi merupakan kesalahan implementasi.

### G. Hasil Pembaruan AGENTS.md

Jelaskan:

- Apakah script berhasil dijalankan.
- Apakah `AGENTS.md` berhasil diperbarui.
- Apakah aturan terbaru sudah masuk.
- Apakah terdapat kendala.

### H. Konfirmasi Keamanan Git

Nyatakan bahwa:

- Lima commit lama tidak diubah.
- Perubahan kode yang belum di-commit tidak diubah.
- Staging area tidak diubah.
- Tidak ada checkout, reset, restore, atau stash.
- Tidak ada operasi commit baru.

### I. Kesimpulan

Jelaskan hasil akhir dan manfaat aturan yang telah diperbarui.

---

# PRINSIP UTAMA

Tujuan command ini bukan memperbanyak jumlah aturan.

Tujuannya adalah mempelajari pola kerja dan perubahan yang sudah dilakukan pengguna agar AI semakin memahami standar implementasi yang diharapkan.

**Lima commit terakhir harus menjadi bahan pembelajaran, bukan alasan untuk mengubah pekerjaan lama.**

Aturan khusus menjaga konsistensi dan keputusan teknis proyek.

Aturan bersama menjaga standar pengembangan seluruh proyek Flutter.

Setiap temuan harus diperiksa peluang generalisasinya, tetapi tidak boleh dipaksakan menjadi aturan global.

Jangan menganggap semua implementasi lama otomatis benar. Evaluasi terlebih dahulu sebelum menjadikannya standar.

**Jangan pernah mengorbankan pekerjaan Git pengguna yang belum di-commit demi menjalankan evaluasi atau memperbarui aturan.**

Hasil akhirnya harus membuat AI semakin memahami cara pengguna ingin kode ditulis, diperbaiki, dan dikembangkan tanpa mengulang kesalahan yang sama.
