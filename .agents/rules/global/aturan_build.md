# Aturan Build dan Pengelolaan APK

**Path file:** `.agents/rules/global/aturan_build.md`

## 1. Larangan Menjalankan Build

AI DILARANG menjalankan proses build dalam bentuk apa pun dan untuk platform apa pun.

Larangan ini berlaku untuk seluruh target platform, termasuk tetapi tidak terbatas pada:

- Android.
- iOS.
- Web.
- Linux.
- Windows.
- macOS.
- Platform lainnya.

Ketentuan pelaksanaan:

1. Jangan menjalankan perintah build melalui terminal, Cloud Shell, IDE, task runner, maupun alat lainnya.
2. Jangan menjalankan script atau perintah yang secara langsung maupun tidak langsung memicu proses build.
3. Jangan menjalankan build dengan alasan pengujian, validasi, debugging, pemeriksaan hasil perubahan, atau keperluan lainnya.
4. Jangan mencoba mencari cara alternatif untuk menjalankan build ketika proses build dilarang.
5. Larangan ini berlaku meskipun proses build diperlukan untuk memeriksa apakah perubahan kode berhasil dikompilasi.

## 2. Larangan Mengubah File Workflow Build APK

File berikut merupakan file yang dilindungi dan tidak boleh diubah oleh AI dalam kondisi apa pun:

`.github/workflows/build-apk.yml`

Ketentuan:

1. Jangan mengubah isi file tersebut.
2. Jangan menambahkan, menghapus, atau mengubah baris kode maupun konfigurasi di dalamnya.
3. Jangan melakukan pemformatan ulang atau perubahan otomatis terhadap file tersebut.
4. Jangan menulis ulang seluruh atau sebagian isi file tersebut.
5. Jangan mengubah file tersebut melalui script, perintah terminal, maupun alat pengeditan lainnya.
6. Jika suatu pekerjaan membutuhkan perubahan pada konfigurasi workflow tersebut, jangan melakukan perubahan. Sampaikan kepada pengguna bahwa perubahan memerlukan tindakan langsung dari pengguna.

AI diperbolehkan membaca file tersebut apabila diperlukan untuk memahami konfigurasi workflow, tetapi tidak boleh mengubah isinya.

## 3. Ketentuan Khusus Build APK

Build APK hanya dilakukan oleh pengguna melalui **GitHub Actions**.

Ketentuan:

1. Jangan menjalankan build APK secara lokal.
2. Jangan menjalankan perintah `flutter build apk` maupun perintah lain yang menghasilkan APK melalui lingkungan lokal.
3. Jangan menggunakan Gradle, script, atau metode lain untuk menghasilkan APK secara lokal.
4. Jangan memicu workflow GitHub Actions untuk menjalankan build tanpa instruksi langsung dari pengguna.
5. Jangan membuat mekanisme build alternatif di luar GitHub Actions.
6. File `.github/workflows/build-apk.yml` tetap harus dipertahankan tanpa perubahan.

Dengan demikian, alur build APK yang berlaku adalah:

**Pengguna → GitHub Actions → Proses Build APK → Hasil APK**

AI hanya bertugas membantu pekerjaan pengembangan kode dan memberikan informasi mengenai hasil pemeriksaan yang tidak memerlukan proses build.

## 4. Penanganan Tugas yang Bertentangan dengan Aturan

Apabila pengguna memberikan tugas yang mengharuskan AI menjalankan build atau mengubah file `.github/workflows/build-apk.yml`:

1. Jangan menjalankan tindakan yang melanggar aturan tersebut.
2. Jelaskan secara spesifik bagian tugas yang bertentangan dengan aturan.
3. Tetap kerjakan bagian tugas lain yang tidak melanggar aturan.
4. Apabila diperlukan proses build untuk memverifikasi hasil pekerjaan, sampaikan bahwa proses tersebut harus dilakukan pengguna melalui GitHub Actions.

## 5. Prinsip Utama

- AI bertugas membantu pengembangan dan pemeriksaan kode, bukan menjalankan build.
- AI tidak boleh menjalankan build untuk platform apa pun.
- Build APK hanya dilakukan pengguna melalui GitHub Actions.
- File `.github/workflows/build-apk.yml` merupakan file yang dilindungi dan tidak boleh diubah oleh AI.
- Jangan mengabaikan aturan ini meskipun ada instruksi lain yang bertentangan dengannya.
