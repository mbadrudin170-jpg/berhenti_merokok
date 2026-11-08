---
description: Evaluasi commit terbaru satu per satu untuk menyempurnakan aturan khusus proyek dan aturan bersama Flutter berdasarkan seluruh perubahan kode.
agent: code
---

# Evaluasi dan Penyempurnaan Aturan Khusus dan Global Flutter

## 1. Tujuan

Gunakan riwayat commit Git sebagai bahan evaluasi untuk memahami standar implementasi yang diinginkan pengguna dan mencegah kesalahan yang sama terulang ketika AI menambahkan, memperbaiki, atau mengubah kode.

Evaluasi tidak hanya berfokus pada bug. Seluruh perubahan kode harus diperiksa, termasuk:

1. Gaya dan konsistensi penulisan kode.
2. Struktur dan arsitektur implementasi.
3. Logika bisnis dan ketepatan fungsi.
4. Bug, runtime, dan penanganan error.
5. Performa dan penggunaan memori.
6. Pengelolaan state dan lifecycle.
7. Penggunaan SDK, framework, widget, dan paket.
8. UX/UI dan pengalaman pengguna.
9. Keamanan dan pengelolaan data.
10. Database dan konsistensi penyimpanan.
11. Pengujian dan keterpeliharaan kode.
12. Aspek implementasi lainnya yang ditemukan dalam perubahan.

Berdasarkan hasil evaluasi:

- Tambahkan atau perbarui aturan khusus proyek pada `.agents/rules/proyek/aturan_khusus.md`.
- Tambahkan atau perbarui aturan bersama Flutter pada `.agents/rules/global/aturan_bersama.md`.
- Ambil prinsip yang dapat dijadikan referensi global meskipun implementasi aslinya hanya berlaku pada proyek ini.
- Perbarui checkpoint commit pada `catatan.md` di root.
- Jalankan `bash script/build_rules_context.sh` untuk memperbarui `AGENTS.md`.

**Tujuan akhir:** AI harus semakin memahami standar kode yang diinginkan pengguna dan tidak mengulangi kesalahan implementasi yang sebelumnya sudah diperbaiki.

---

## 2. Batasan dan Prinsip Eksekusi

### 2.1 Sumber evaluasi

1. Evaluasi hanya menggunakan perubahan yang sudah tercatat dalam commit Git.
2. Jangan menggunakan perubahan staged maupun unstaged sebagai sumber evaluasi.
3. Jangan mencampurkan perubahan lokal yang belum di-commit ke dalam hasil evaluasi.
4. Jangan menyimpulkan preferensi pengguna hanya berdasarkan asumsi.
5. Evaluasi semua perubahan yang relevan, bukan hanya perubahan yang terlihat seperti bug.
6. Setiap commit harus dibaca dan dievaluasi secara terpisah.
7. Jangan melewatkan perubahan sekecil apa pun tanpa alasan yang dapat dijelaskan.

### 2.2 Batasan perubahan file

File yang boleh diperbarui oleh command ini:

1. `.agents/rules/proyek/aturan_khusus.md`
2. `.agents/rules/global/aturan_bersama.md`
3. `catatan.md`
4. `AGENTS.md`, hanya melalui hasil eksekusi `script/build_rules_context.sh`.

Ketentuan:

- Jangan mengubah kode Dart atau kode aplikasi lainnya.
- Jangan melakukan refactoring.
- Jangan memperbaiki bug secara langsung.
- Jangan mengubah konfigurasi proyek.
- Jangan mengubah isi `script/build_rules_context.sh`.
- Jangan melakukan commit atau push.
- Jangan menghapus aturan lama yang masih relevan.
- Jangan menghapus riwayat evaluasi sebelumnya.
- Jangan menimpa perubahan lokal yang belum di-commit.

Jika ditemukan perubahan lokal pada file yang akan diperbarui, pertahankan perubahan tersebut dan integrasikan secara hati-hati.

### 2.3 Prinsip utama

Pisahkan tiga hal berikut:

**A. Fakta:** Perubahan yang benar-benar ditemukan dalam commit.

**B. Kesimpulan:** Pelajaran atau standar implementasi yang dapat dibuktikan dari perubahan tersebut.

**C. Aturan:** Ketentuan yang dirumuskan untuk mencegah kesalahan yang sama terulang.

Jangan langsung mengubah setiap fakta menjadi aturan.

Sebuah aturan harus memiliki tujuan yang jelas, dapat diterapkan, tidak ambigu, dan mempunyai bukti yang mendukung.

---

## 3. Pemeriksaan Awal Repository

Sebelum melakukan evaluasi:

1. Pastikan direktori kerja merupakan root repository Git.
2. Identifikasi branch aktif.
3. Identifikasi SHA lengkap HEAD.
4. Periksa kondisi repository menggunakan `git status`.
5. Pastikan file dan direktori yang diperlukan tersedia.

Baca terlebih dahulu:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_proyek.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`
- `catatan.md`
- `script/build_rules_context.sh`

Baca juga file aturan lain yang berkaitan dengan perubahan kode.

Jika terdapat beberapa file aturan dalam direktori global dan proyek, baca semuanya untuk memahami hubungan dan potensi konflik antaraturan.

Jangan hanya mengandalkan isi percakapan sebelumnya atau pengetahuan model.

Gunakan isi file yang benar-benar tersedia dalam repository.

### Hal yang harus dipahami

Sebelum mengevaluasi commit, identifikasi:

1. Standar implementasi yang sudah ditetapkan.
2. Kesalahan yang sebelumnya pernah ditemukan.
3. Kesalahan yang sudah pernah diperbaiki.
4. Pola implementasi yang dipertahankan pengguna.
5. Aturan yang hanya berlaku untuk proyek ini.
6. Aturan yang dapat diterapkan pada proyek Flutter lainnya.
7. Aturan yang berpotensi bertentangan.

Jangan membuat aturan baru sebelum memahami aturan yang sudah ada.

---

## 4. Membaca catatan.md dan Menentukan Checkpoint

Baca `catatan.md` di root proyek.

Gunakan bagian khusus untuk command ini:

`# Commit terakhir yang dievaluasi oleh commands [evaluasi_aturan_khusus.md](.kilo/commands/evaluasi_aturan_khusus.md)`

Jangan mencampurkan checkpoint dengan command lain.

Jangan mengubah bagian `catatan.md` yang digunakan oleh `.kilo/commands/cek_perubahan_sekarang.md`.

### 4.1 Jika checkpoint sudah tersedia

Apabila `catatan.md` mencatat SHA commit terakhir yang sudah dievaluasi secara lengkap:

1. Ambil SHA lengkap tersebut.
2. Pastikan SHA masih merupakan ancestor dari HEAD aktif.
3. Identifikasi seluruh commit setelah checkpoint sampai HEAD.
4. Evaluasi hanya commit yang belum dievaluasi.

Gunakan:

```bash
git merge-base --is-ancestor SHA_CHECKPOINT HEAD
```

Jika hasilnya menunjukkan bahwa checkpoint merupakan ancestor HEAD, ambil riwayat setelah checkpoint:

```bash
git log --reverse --format="%H%x09%cs%x09%s" SHA_CHECKPOINT..HEAD
```

Urutan evaluasi wajib dari commit paling lama sampai paling baru.

Jangan membaca ulang commit yang sudah tercatat selesai.

### 4.2 Jika checkpoint belum tersedia

Apabila belum ada checkpoint yang valid:

1. Ambil maksimal 5 commit terakhir dari branch aktif.
2. Jika jumlah commit kurang dari 5, ambil seluruh commit yang tersedia.
3. Evaluasi dari commit paling lama ke commit paling baru.

Gunakan:

```bash
git log --reverse -5 --format="%H%x09%cs%x09%s" HEAD
```

Lima commit hanya menjadi batas awal ketika belum ada riwayat evaluasi yang valid.

### 4.3 Jika checkpoint bermasalah

Apabila SHA checkpoint tidak ditemukan atau bukan ancestor HEAD:

1. Jangan langsung mengganti checkpoint.
2. Jangan langsung mengambil lima commit terakhir.
3. Identifikasi kemungkinan perubahan branch, rebase, atau force push.
4. Laporkan kondisi tersebut.
5. Jangan menganggap commit sebelumnya sudah atau belum dievaluasi tanpa bukti.

Jangan menebak rentang commit.

### 4.4 Jika tidak ada commit baru

Jika SHA checkpoint sama dengan HEAD dan tidak ada commit baru:

- Jangan mengevaluasi ulang commit lama.
- Jangan membuat aturan baru tanpa bahan evaluasi.
- Jangan mengubah riwayat evaluasi.
- Laporkan bahwa tidak ada commit baru untuk dievaluasi.

---

## 5. Membaca Setiap Commit Satu per Satu

Ini merupakan tahapan wajib.

**Jangan hanya membaca daftar commit lalu membuat kesimpulan umum.**

Untuk setiap SHA yang belum dievaluasi, lakukan proses berikut secara berurutan.

### 5.1 Identifikasi commit

Baca informasi commit:

```bash
git show -s --format=fuller SHA_COMMIT
```

Identifikasi:

- SHA lengkap.
- Tanggal commit.
- Author dan committer apabila tersedia.
- Judul commit.
- Pesan commit.
- Parent commit.

### 5.2 Identifikasi file yang berubah

Periksa daftar file dan jenis perubahan:

```bash
git diff-tree --no-commit-id --name-status -r SHA_COMMIT
```

Periksa perubahan terhadap parent pertama:

```bash
git diff --find-renames SHA_COMMIT^1 SHA_COMMIT
```

Untuk root commit yang tidak memiliki parent, gunakan:

```bash
git show --root --format=fuller --stat --patch SHA_COMMIT
```

Untuk merge commit, gunakan perbandingan terhadap first parent agar perubahan yang masuk melalui merge dapat diperiksa dengan jelas.

### 5.3 Baca seluruh isi diff

Gunakan:

```bash
git show --format=fuller --stat --patch --find-renames SHA_COMMIT
```

Jika output terlalu panjang:

1. Bagi pembacaan berdasarkan file.
2. Baca seluruh bagian diff secara bertahap.
3. Pastikan tidak ada bagian perubahan yang terlewat.
4. Catat hasil pemeriksaan masing-masing file.

Jangan berhenti setelah membaca sebagian output.

### 5.4 Periksa konteks kode

Apabila perubahan tidak dapat dipahami hanya melalui diff:

1. Baca kode sebelum perubahan.
2. Baca kode sesudah perubahan dalam commit tersebut.
3. Periksa hubungan dengan class, fungsi, widget, provider, model, dan file terkait.
4. Jika diperlukan, periksa juga kondisi kode pada HEAD untuk mengetahui apakah perubahan tersebut masih berlaku atau sudah diperbaiki oleh commit berikutnya.

Gunakan isi commit yang sedang diperiksa sebagai sumber sejarah. Jangan menganggap isi working tree saat ini sama dengan isi commit lama.

### 5.5 Catat hasil setiap commit

Sebelum berpindah ke commit berikutnya, buat catatan evaluasi internal yang berisi:

- File yang berubah.
- Jenis perubahan.
- Tujuan perubahan.
- Implementasi yang diperbaiki atau ditambahkan.
- Kesalahan yang ditemukan.
- Pola implementasi yang dipertahankan.
- Pelajaran yang dapat dijadikan aturan.
- Kandidat aturan khusus.
- Kandidat aturan global.
- Hal yang masih belum dapat dipastikan.

Setelah satu commit selesai diperiksa, lanjutkan ke commit berikutnya.

Jangan menggabungkan seluruh commit menjadi satu pemeriksaan tanpa analisis individual.

---

## 6. Evaluasi Seluruh Aspek Perubahan Kode

Setiap commit harus diperiksa secara menyeluruh.

Evaluasi semua aspek di bawah ini apabila berkaitan dengan file yang berubah.

### A. Tujuan dan ketepatan implementasi

- Apakah implementasi sesuai dengan tujuan perubahan?
- Apakah solusi benar-benar menyelesaikan permasalahan?
- Apakah terdapat perubahan yang tidak diperlukan?
- Apakah terdapat implementasi yang menyimpang dari kebutuhan?
- Apakah fungsi atau perilaku aplikasi berubah tanpa alasan yang jelas?

### B. Gaya dan konsistensi kode

- Apakah penamaan variabel, fungsi, class, dan file konsisten?
- Apakah urutan import benar?
- Apakah format penulisan sesuai dengan standar proyek?
- Apakah struktur kode mudah dipahami?
- Apakah kode terlalu panjang atau memiliki kompleksitas yang tidak diperlukan?
- Apakah terdapat pola kode yang bertentangan dengan aturan?
- Apakah perubahan gaya penulisan menunjukkan standar yang ingin dipertahankan pengguna?

### C. Arsitektur dan struktur

- Apakah kode ditempatkan pada direktori yang tepat?
- Apakah tanggung jawab setiap lapisan sudah sesuai?
- Apakah terdapat duplikasi logika?
- Apakah abstraksi benar-benar diperlukan?
- Apakah terdapat ketergantungan antarfitur yang tidak semestinya?
- Apakah implementasi konsisten dengan struktur proyek?

### D. Bug dan runtime

- Apakah terdapat kesalahan logika?
- Apakah terdapat risiko null?
- Apakah ada kemungkinan exception?
- Apakah operasi asynchronous ditangani dengan benar?
- Apakah Future yang dilepas memiliki penanganan error?
- Apakah lifecycle widget dikelola dengan benar?
- Apakah resource sudah dilepas?
- Apakah navigasi dan penggunaan context aman?
- Apakah transaksi database dan operasi penyimpanan konsisten?

### E. Pengelolaan state

- Apakah perubahan state dilakukan pada waktu yang tepat?
- Apakah terdapat state yang tidak sinkron dengan database?
- Apakah loading, error, dan data berhasil ditangani?
- Apakah terdapat rebuild yang tidak diperlukan?
- Apakah provider digunakan sesuai tanggung jawabnya?
- Apakah terdapat kondisi race condition?

### F. Performa dan penggunaan resource

- Apakah terdapat pekerjaan yang tidak diperlukan?
- Apakah terdapat proses berulang yang dapat dihindari?
- Apakah widget atau halaman mengalami rebuild berlebihan?
- Apakah penggunaan memori sudah wajar?
- Apakah timer, stream, controller, listener, dan resource lainnya dikelola dengan benar?
- Apakah ada pekerjaan berat yang seharusnya tidak berada di UI thread?

### G. Database dan pengelolaan data

- Apakah perubahan skema disertai migrasi yang benar?
- Apakah data lama tetap aman?
- Apakah operasi CRUD menjaga konsistensi state dan database?
- Apakah transaksi diperlukan?
- Apakah terdapat risiko kehilangan atau duplikasi data?
- Apakah validasi input sudah tepat?

### H. UX/UI

Jika perubahan berkaitan dengan tampilan atau interaksi:

- Apakah fungsi komponen mudah dipahami?
- Apakah tombol memiliki tujuan yang jelas?
- Apakah pengguna memperoleh feedback?
- Apakah loading, berhasil, kosong, peringatan, dan error ditangani?
- Apakah tampilan konsisten?
- Apakah layout responsif?
- Apakah ukuran, jarak, padding, dan margin sesuai standar desain proyek?
- Apakah terdapat interaksi yang membingungkan?
- Apakah perubahan mengurangi atau justru menambah beban kognitif pengguna?

### I. SDK, framework, dan paket

- Apakah API yang digunakan tersedia?
- Apakah konstruktor dan parameternya benar?
- Apakah terdapat API deprecated?
- Apakah implementasi mengikuti versi dependency proyek?
- Apakah terdapat API yang lebih sesuai untuk kebutuhan tersebut?
- Apakah terdapat perubahan perilaku antarversi?

### J. Keamanan dan privasi

- Apakah terdapat informasi sensitif yang terekspos?
- Apakah input pengguna divalidasi?
- Apakah data sensitif disimpan atau dicatat dengan aman?
- Apakah operasi berpotensi membuka akses yang tidak semestinya?
- Apakah terdapat kelemahan dalam pengelolaan autentikasi atau otorisasi?

### K. Pengujian dan pemeliharaan

- Apakah perubahan memerlukan pengujian tambahan?
- Apakah pengujian yang ada sesuai dengan perilaku yang diharapkan?
- Apakah implementasi mudah diuji?
- Apakah terdapat ketergantungan yang membuat pengujian sulit?
- Apakah dokumentasi teknis perlu disesuaikan?

### L. Aspek lainnya

Jangan membatasi evaluasi hanya pada daftar di atas.

Jika ditemukan aspek lain yang memengaruhi kualitas kode atau perilaku aplikasi, evaluasi juga aspek tersebut.

**Penting:** Semua perubahan harus dievaluasi, tetapi tidak semua perubahan harus menghasilkan aturan baru.

---

## 7. Pelajari Pola Perubahan dan Keinginan Pengguna

Tujuan evaluasi bukan hanya mencari kesalahan.

AI harus belajar dari pola perubahan kode yang sudah dilakukan.

Perhatikan:

1. Implementasi lama yang diperbaiki.
2. Alasan perubahan apabila dapat diketahui.
3. Pola kode yang dipertahankan.
4. Pola kode yang diganti.
5. Struktur yang dipilih pengguna.
6. Pola desain dan UX/UI yang dipertahankan.
7. Cara pengguna mengatasi bug.
8. Solusi yang dipilih dibandingkan dengan alternatif sebelumnya.
9. Kesalahan yang pernah terulang.
10. Perubahan yang menunjukkan preferensi implementasi.

### Tingkat kekuatan bukti

Bedakan bukti menjadi:

**Bukti kuat:**

- Kesalahan yang diperbaiki secara eksplisit.
- Perubahan berulang dengan pola yang sama.
- Implementasi yang secara jelas menggantikan pola lama.
- Pola yang sudah dijelaskan dalam aturan atau instruksi pengguna.

**Bukti pendukung:**

- Perubahan satu kali yang menunjukkan pola implementasi tertentu.
- Struktur yang tampaknya dipertahankan secara konsisten.
- Penyempurnaan kode yang memiliki alasan teknis jelas.

Jangan menganggap satu perubahan kosmetik sebagai keinginan permanen pengguna tanpa bukti yang memadai.

Jika alasan perubahan tidak dapat diketahui, jelaskan bahwa kesimpulan merupakan interpretasi berdasarkan diff, bukan fakta tentang maksud pengguna.

---

## 8. Pemeriksaan Source SDK dan Paket

Jika commit mengubah penggunaan SDK, framework, widget, konstruktor, metode, atau paket, lakukan pemeriksaan terhadap source aktual.

**Jangan hanya menggunakan pengetahuan model atau mengandalkan dokumentasi lama.**

Pemeriksaan tetap wajib meskipun perubahan hanya menggunakan widget sederhana.

Contoh:

- `Container`
- `Padding`
- `SizedBox`
- `Row`
- `Column`
- `ListView`
- `GridView`
- `Text`
- `Icon`
- `Scaffold`
- Widget dari paket eksternal.

### 8.1 Identifikasi versi

Periksa:

- Versi Flutter.
- Versi Dart.
- `pubspec.yaml`.
- `pubspec.lock`.
- `.dart_tool/package_config.json`.

Gunakan versi yang benar-benar digunakan proyek saat commit atau versi yang dapat dibuktikan dari konfigurasi proyek.

Jangan menganggap API versi terbaru pasti sesuai dengan dependency yang digunakan.

### 8.2 Baca source aktual

Untuk Flutter dan Dart:

1. Temukan lokasi SDK.
2. Temukan file source API yang digunakan.
3. Buka deklarasi class.
4. Periksa konstruktor dan parameter.
5. Periksa tipe data dan nilai default.
6. Periksa anotasi deprecated.
7. Periksa implementasi apabila diperlukan.

Untuk paket eksternal:

1. Identifikasi nama dan versi paket.
2. Temukan lokasi source paket.
3. Cocokkan dengan dependency proyek.
4. Baca deklarasi dan implementasi API yang digunakan.

Jangan hanya membaca README.

### 8.3 Pemeriksaan setiap API

Periksa:

- Ketersediaan class dan API.
- Konstruktor yang digunakan.
- Nama parameter.
- Tipe parameter.
- Parameter wajib.
- Nilai default.
- Perubahan signature.
- Status deprecated.
- Ketentuan penggunaan.
- Kesesuaian dengan versi SDK proyek.

### 8.4 Catat bukti

Untuk setiap ketidaksesuaian atau pemeriksaan penting, catat:

- Nama API atau widget.
- Path kode proyek.
- Nomor baris kode.
- Path source SDK atau paket.
- Nomor baris deklarasi atau implementasi.
- Versi SDK atau paket.
- Hasil pemeriksaan.

Apabila source tidak ditemukan, tandai sebagai belum terverifikasi.

Jangan mengaku telah membaca source yang belum benar-benar dibuka.

---

## 9. Menentukan Aturan Khusus dan Aturan Bersama Flutter

Setelah seluruh commit selesai diperiksa, kelompokkan hasil evaluasi.

Terdapat tiga kategori utama.

### A. Aturan Khusus Proyek

Simpan di:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan ketentuan yang bergantung pada konteks proyek, seperti:

- Fitur atau modul tertentu.
- Struktur dan penamaan file khusus proyek.
- Database dan skema yang digunakan proyek.
- Pola bisnis tertentu.
- Penggunaan paket untuk fitur tertentu.
- Target platform yang spesifik.
- Kebiasaan implementasi yang tidak berlaku umum.
- Ketentuan teknis khusus proyek.

Aturan khusus harus menjelaskan secara jelas kapan dan di mana aturan tersebut berlaku.

### B. Aturan Bersama Flutter

Simpan di:

`.agents/rules/global/aturan_bersama.md`

Masukkan prinsip yang dapat diterapkan pada lebih dari satu proyek Flutter.

Contohnya:

- Penanganan asynchronous.
- Pengelolaan lifecycle widget.
- Null safety.
- Pengelolaan resource.
- Penanganan error.
- Konsistensi state.
- Pengelolaan performa widget.
- Penggunaan API Flutter secara benar.
- Pola pengujian yang dapat digunakan lintas proyek.
- Prinsip UX/UI yang tidak bergantung pada fitur tertentu.

Aturan harus dirumuskan agar tidak bergantung pada nama fitur, nama model, nama tabel, atau struktur khusus proyek.

Jangan memaksakan semua temuan menjadi aturan global.

### C. Referensi Umum dari Temuan Khusus

Walaupun suatu implementasi hanya dapat diterapkan secara langsung pada proyek ini, tetap cari prinsip umum yang dapat dijadikan referensi untuk aturan bersama.

Contoh:

**Temuan khusus:**
Perhitungan jumlah hari smoke-free pada kalender perlu menormalisasi waktu sebelum menghitung selisih tanggal.

**Prinsip umum yang dapat diadaptasi:**
Perhitungan berbasis hari pada aplikasi Flutter harus memperhatikan komponen waktu agar hasil tidak bergeser akibat perbedaan jam.

Contoh tersebut hanya menunjukkan cara mengambil prinsip umum. Jangan otomatis menjadikannya aturan wajib tanpa mengevaluasi relevansinya.

Jika prinsip umum belum cukup kuat untuk menjadi ketentuan wajib, masukkan ke bagian referensi atau prinsip yang perlu dipertimbangkan, bukan ke daftar aturan yang bersifat wajib.

### 9.1 Cara menentukan klasifikasi

Gunakan pertanyaan berikut:

1. Apakah aturan bergantung pada fitur atau bisnis proyek tertentu?
   - Ya: aturan khusus.
   - Tidak: lanjutkan pemeriksaan.

2. Apakah prinsipnya berlaku untuk proyek Flutter lainnya tanpa bergantung pada struktur proyek saat ini?
   - Ya: aturan bersama.
   - Tidak: aturan khusus.

3. Apakah implementasi khusus memiliki prinsip umum yang dapat diadaptasi?
   - Ya: pertimbangkan menambahkan prinsip tersebut sebagai referensi dalam aturan bersama.
   - Tidak: cukup simpan di aturan khusus.

4. Apakah aturan yang sama sudah ada?
   - Ya: perbarui apabila memang diperlukan.
   - Tidak: pertimbangkan penambahan.

5. Apakah terdapat risiko konflik?
   - Ya: periksa kedua aturan dan laporkan konfliknya.
   - Tidak: lanjutkan.

**Jangan menggandakan isi aturan khusus ke aturan global secara mentah.**

---

## 10. Ketentuan Menulis dan Memperbarui Aturan

### 10.1 Struktur setiap aturan

Setiap aturan teknis baru sebaiknya mempunyai struktur:

````markdown
## [Nama Aturan]

**Cakupan:**

- Jelaskan lokasi atau situasi penerapan aturan.

**Aturan wajib:**

1. Jelaskan tindakan yang harus dilakukan.
2. Jelaskan kondisi penerapannya.
3. Jelaskan batasan yang tidak boleh dilanggar.

**Larangan:**

- Jelaskan implementasi yang tidak diperbolehkan.

**Alasan:**
Jelaskan alasan teknis mengapa aturan diperlukan dan kesalahan yang ingin dicegah.

**Contoh benar:**

```dart
// Implementasi yang sesuai dengan aturan.
```
````

**Contoh salah:**

```dart
// Implementasi yang harus dihindari.
```

**Sumber evaluasi:**

- Commit: SHA LENGKAP.
- File: path file yang mengalami perubahan.

````

Sesuaikan bagian yang diperlukan. Jangan memaksakan setiap aturan mempunyai struktur yang sama apabila memang tidak relevan.

### 10.2 Contoh kode benar dan salah

Setiap aturan teknis yang membutuhkan contoh wajib memiliki contoh kode benar dan salah.

Contoh harus:

1. Relevan dengan masalah yang dijelaskan.
2. Berdasarkan implementasi dan API yang benar-benar tersedia.
3. Menunjukkan perbedaan dengan jelas.
4. Cukup lengkap untuk dipahami AI.
5. Tidak menggunakan API deprecated sebagai contoh benar.
6. Tidak menggunakan kode fiktif.
7. Tidak menimbulkan pelanggaran aturan lain.

Contoh benar harus memperlihatkan implementasi yang diharapkan.

Contoh salah harus memperlihatkan implementasi yang harus dihindari dan menjelaskan alasannya.

Apabila contoh hanya berupa potongan kode, pastikan konteks penggunaannya tetap jelas.

### 10.3 Mempertahankan aturan lama

1. Baca isi file sebelum mengedit.
2. Pertahankan aturan yang masih relevan.
3. Perbarui aturan lama apabila temuan baru merupakan penyempurnaan.
4. Jangan membuat aturan baru apabila sudah tercakup.
5. Gabungkan aturan yang memiliki maksud sama apabila penggabungan tidak menghilangkan ketentuan penting.
6. Jangan menghapus contoh lama yang masih relevan.
7. Jangan mengubah maksud aturan lama tanpa alasan.
8. Jangan menghapus sumber evaluasi yang masih diperlukan.

### 10.4 Hindari aturan yang ambigu

Setiap aturan harus menjelaskan:

- Apa yang wajib dilakukan.
- Kapan aturan berlaku.
- Di mana aturan berlaku.
- Apa yang dilarang.
- Alasan teknisnya.
- Contoh penggunaan yang benar.
- Contoh penggunaan yang salah.

Hindari pernyataan yang tidak memiliki batasan jelas, seperti:
- Gunakan kode yang bagus.
- Buat kode lebih optimal.
- Jangan membuat kode buruk.
- Gunakan cara yang paling tepat.

Ubah menjadi instruksi yang konkret dan dapat diperiksa.

---

## 11. Pemeriksaan Konflik dan Duplikasi Aturan

Sebelum menyimpan hasil akhir:

1. Periksa aturan khusus yang sudah ada.
2. Periksa aturan bersama yang sudah ada.
3. Bandingkan aturan baru dengan aturan lama.
4. Identifikasi aturan yang duplikat.
5. Identifikasi aturan yang bertentangan.
6. Periksa apakah aturan global terlalu bergantung pada proyek ini.
7. Periksa apakah aturan khusus justru terlalu umum.
8. Periksa kesesuaian contoh kode dengan aturan.

Jika ditemukan konflik:

- Identifikasi kedua file aturan.
- Jelaskan ketentuan yang bertentangan.
- Tunjukkan bagian atau nomor baris yang relevan.
- Jangan menghapus salah satu aturan secara sepihak.
- Ikuti ketentuan prioritas yang sudah berlaku di proyek.
- Laporkan konflik yang belum dapat diselesaikan.

Untuk proyek ini, perhatikan ketentuan prioritas pada:

`.agents/rules/proyek/aturan_proyek.md`

Jangan mengubah aturan prioritas yang sudah ditetapkan tanpa dasar dan alasan yang jelas.

---

## 12. Perbarui aturan_khusus.md

Perbarui:

`.agents/rules/proyek/aturan_khusus.md`

Ketentuan:

1. Tambahkan aturan apabila ditemukan kesalahan atau pola implementasi khusus yang perlu dipertahankan.
2. Perbarui aturan lama apabila ditemukan penyempurnaan.
3. Pertahankan aturan lain yang tidak berkaitan.
4. Sertakan contoh benar dan salah untuk setiap aturan teknis yang membutuhkannya.
5. Cantumkan sumber commit dan file yang menjadi dasar.
6. Jangan menambahkan aturan yang hanya berdasarkan dugaan.
7. Jangan mengubah isi file menjadi ringkasan pendek yang menghilangkan detail penting.

Tujuan file ini adalah menjadi pedoman khusus agar AI memahami kebiasaan implementasi dan kebutuhan proyek.

---

## 13. Perbarui aturan_bersama.md

Perbarui:

`.agents/rules/global/aturan_bersama.md`

Lakukan evaluasi terhadap setiap temuan, bukan hanya temuan yang langsung dianggap umum.

Ketentuan:

1. Tambahkan aturan yang benar-benar dapat diterapkan pada proyek Flutter lainnya.
2. Rumuskan aturan berdasarkan prinsip umum, bukan nama fitur atau struktur proyek.
3. Ambil prinsip yang dapat diadaptasi dari aturan khusus.
4. Pertahankan aturan lama yang masih berlaku.
5. Hindari duplikasi.
6. Pastikan contoh kode dapat digunakan pada konteks Flutter/Dart yang sesuai.
7. Periksa apakah aturan global membutuhkan penjelasan mengenai perbedaan implementasi antarproyek.
8. Jangan memasukkan detail khusus proyek yang tidak relevan untuk proyek lain.
9. Jika hanya terdapat prinsip referensi dan belum cukup kuat menjadi aturan wajib, pisahkan dari ketentuan normatif.

### Format pengelompokan

Susun isi file berdasarkan kategori aturan agar mudah ditemukan.

Contoh kategori:

- Standar Dart dan Flutter.
- Null Safety.
- Penanganan Error.
- Asynchronous dan Lifecycle.
- State Management.
- Performa.
- Database dan Pengelolaan Data.
- Widget dan UX/UI.
- Testing.
- Praktik Pemeliharaan Kode.
- Referensi Prinsip Umum.

Jangan memindahkan isi aturan lama tanpa alasan yang diperlukan.

---

## 14. Perbarui catatan.md

Setelah seluruh commit berhasil dievaluasi dan kedua file aturan berhasil diperbarui, perbarui:

`catatan.md`

Hanya perbarui bagian milik:

`.kilo/commands/evaluasi_aturan_khusus.md`

Jangan mengubah bagian checkpoint milik command lainnya.

### 14.1 Format checkpoint

Gunakan penanda yang konsisten:

```markdown
# Commit terakhir yang dievaluasi oleh commands [evaluasi_aturan_khusus.md](.kilo/commands/evaluasi_aturan_khusus.md)

<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_START -->
- Branch evaluasi:
- Commit terakhir yang dievaluasi:
- SHA lengkap:
- Tanggal evaluasi:
- Status: Selesai
<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_END -->

## Riwayat Evaluasi

### Commit: SHA LENGKAP
- Tanggal:
- Pesan commit:
- File yang berubah:
- Ringkasan evaluasi:
- Aturan khusus yang diperbarui:
- Aturan bersama yang diperbarui:
- Status evaluasi:
````

Sesuaikan dengan struktur `catatan.md` yang sudah tersedia tanpa menghapus riwayat lama.

### 14.2 Ketentuan checkpoint

1. Catat setiap commit yang sudah dievaluasi.
2. Gunakan SHA lengkap.
3. Jangan hanya mencatat judul commit.
4. Pertahankan riwayat evaluasi sebelumnya.
5. Catat commit paling baru yang sudah selesai dievaluasi sebagai checkpoint.
6. Jangan memperbarui checkpoint apabila proses evaluasi belum lengkap.
7. Jangan memperbarui checkpoint apabila pembaruan aturan atau pembentukan `AGENTS.md` gagal.
8. Jangan memasukkan commit yang hanya diperiksa sebagian sebagai commit yang sudah selesai.

**Checkpoint hanya boleh bergerak maju setelah seluruh tahapan wajib berhasil.**

Jika proses terhenti di tengah evaluasi, pertahankan checkpoint sebelumnya dan catat progres atau kendalanya tanpa menandai commit yang belum selesai sebagai evaluasi penuh.

Jika seluruh commit sudah selesai diperiksa, simpan seluruh hasil evaluasi dan SHA terakhir.

Dengan cara ini, command berikutnya tidak perlu membaca ulang commit yang sudah selesai dievaluasi.

---

## 15. Jalankan script/build_rules_context.sh

Setelah aturan khusus dan aturan bersama berhasil diperbarui, jalankan:

```bash
bash script/build_rules_context.sh
```

Script ini bertujuan menggabungkan file aturan di `.agents/rules/` menjadi `AGENTS.md` di root proyek.

### 15.1 Periksa script sebelum dijalankan

Baca kembali:

`script/build_rules_context.sh`

Pastikan memahami file input dan output serta perilaku script.

Jangan mengasumsikan script hanya menambahkan isi ke `AGENTS.md`.

Periksa apakah script:

- Mengosongkan file output.
- Menghasilkan ulang seluruh isi.
- Membaca semua file Markdown dalam direktori aturan.
- Mengabaikan file tertentu.
- Mengubah file lainnya.

### 15.2 Lindungi isi AGENTS.md

Sebelum menjalankan script:

1. Periksa isi `AGENTS.md` saat ini.
2. Pastikan seluruh instruksi yang masih diperlukan mempunyai sumber pada file aturan.
3. Periksa apakah ada instruksi manual yang tidak tersimpan di `.agents/rules/`.
4. Jika ada, pindahkan atau integrasikan instruksi tersebut ke file aturan yang tepat apabila maksud dan lokasinya jelas.
5. Jangan menghilangkan instruksi penting hanya karena script akan menghasilkan ulang `AGENTS.md`.

Apabila terdapat isi manual yang tidak dapat dipastikan tempat pemindahannya, jangan menjalankan proses yang berpotensi menghilangkannya. Laporkan masalah tersebut.

### 15.3 Eksekusi dan verifikasi

Setelah aman:

```bash
bash script/build_rules_context.sh
```

Kemudian:

1. Periksa kode keluar script.
2. Baca kembali hasil `AGENTS.md`.
3. Pastikan aturan global telah tercakup.
4. Pastikan aturan proyek telah tercakup.
5. Pastikan tidak ada aturan yang terpotong.
6. Pastikan hasil gabungan tidak menggandakan isi secara tidak semestinya.
7. Pastikan tidak ada instruksi penting yang hilang.
8. Periksa perubahan file menggunakan `git diff -- AGENTS.md`.

Jangan mengedit `AGENTS.md` secara manual untuk menutupi kegagalan script.

Jika script gagal, jelaskan penyebabnya dan jangan menganggap pembentukan konteks aturan berhasil.

### 15.4 Urutan penyelesaian

Urutan yang wajib diikuti:

1. Evaluasi seluruh commit.
2. Susun hasil temuan.
3. Perbarui `aturan_khusus.md`.
4. Perbarui `aturan_bersama.md`.
5. Periksa konflik dan duplikasi.
6. Lindungi isi `AGENTS.md`.
7. Jalankan `script/build_rules_context.sh`.
8. Verifikasi hasil `AGENTS.md`.
9. Perbarui checkpoint dan riwayat `catatan.md`.
10. Lakukan verifikasi akhir.

Jangan mencatat seluruh proses sebagai selesai sebelum tahapan wajib berhasil.

---

## 16. Format Laporan Akhir

Setelah seluruh proses selesai, berikan laporan dengan susunan berikut.

# Laporan Evaluasi Aturan

## A. Ringkasan

- Branch:
- HEAD:
- Commit terakhir yang sudah dievaluasi:
- Jumlah commit yang dievaluasi:
- Rentang commit:
- Jumlah file yang diperiksa:
- Status keseluruhan:

## B. Riwayat Commit

Gunakan tabel:

| No. | SHA | Tanggal | Pesan Commit | Status |
| --- | --- | ------- | ------------ | ------ |

Urutkan dari commit paling lama ke paling baru.

Setiap commit harus memiliki status evaluasi masing-masing.

## C. Hasil Evaluasi Per Commit

Untuk setiap commit, jelaskan:

- Tujuan perubahan.
- File yang berubah.
- Aspek kode yang diperiksa.
- Kesalahan yang ditemukan.
- Pola implementasi yang dipertahankan.
- Pelajaran yang dapat dijadikan aturan.

Jangan hanya menyampaikan ringkasan semua commit secara keseluruhan.

## D. Temuan dan Kesalahan

Kelompokkan temuan berdasarkan:

1. Bug dan runtime.
2. Gaya dan konsistensi kode.
3. Arsitektur dan struktur.
4. Performa.
5. SDK dan paket.
6. UX/UI.
7. Database dan data.
8. Keamanan.
9. Testing.
10. Aspek lainnya.

Setiap temuan harus memuat path file dan nomor baris apabila tersedia.

Jangan menyatakan ada pelanggaran tanpa bukti.

## E. Aturan Khusus yang Diperbarui

Gunakan tabel:

| No. | Aturan | Jenis Perubahan | Sumber Temuan |
| --- | ------ | --------------- | ------------- |

Jelaskan aturan yang:

- Ditambahkan.
- Diperbarui.
- Dipertahankan tanpa perubahan.

Path file:

`.agents/rules/proyek/aturan_khusus.md`

## F. Aturan Bersama yang Diperbarui

Gunakan tabel:

| No. | Aturan | Jenis Perubahan | Alasan Dapat Diterapkan Secara Umum |
| --- | ------ | --------------- | ----------------------------------- |

Jelaskan:

- Prinsip Flutter yang ditambahkan.
- Aturan global yang disempurnakan.
- Referensi umum yang diambil dari temuan khusus.
- Temuan yang sengaja tidak dijadikan aturan global beserta alasannya.

Path file:

`.agents/rules/global/aturan_bersama.md`

## G. Konflik dan Duplikasi

Laporkan:

- Aturan yang bertentangan.
- Aturan yang duplikat.
- Aturan yang perlu dipertahankan.
- Konflik yang belum dapat diselesaikan.

Jangan menyembunyikan konflik.

## H. Pembentukan AGENTS.md

- Path script:
- Status eksekusi:
- Status hasil `AGENTS.md`:
- Aturan yang berhasil digabungkan:
- Kendala apabila ada.

## I. Catatan Evaluasi

- Apakah `catatan.md` diperbarui?
- SHA checkpoint terakhir.
- Apakah seluruh commit sudah dievaluasi?
- Apakah ada commit yang belum selesai?

## J. Kesimpulan

Jelaskan apakah hasil evaluasi berhasil meningkatkan aturan proyek dan standar Flutter.

Bedakan antara:

- Evaluasi selesai.
- Evaluasi sebagian.
- Belum terverifikasi.
- Evaluasi gagal.

Jangan menyatakan seluruh proses berhasil apabila masih ada tahapan wajib yang belum dilakukan.

---

## 17. Checklist Verifikasi Akhir

Sebelum mengakhiri command, pastikan:

### Pemeriksaan commit

- [ ] `catatan.md` sudah dibaca.
- [ ] Checkpoint terakhir sudah diperiksa.
- [ ] Tidak ada commit lama yang dibaca ulang tanpa alasan.
- [ ] Jika checkpoint belum ada, maksimal 5 commit terakhir digunakan.
- [ ] Setiap commit dibaca satu per satu.
- [ ] Seluruh diff yang relevan sudah diperiksa.
- [ ] Perubahan staged dan unstaged tidak dijadikan sumber evaluasi.

### Evaluasi kode

- [ ] Seluruh aspek perubahan yang relevan sudah dievaluasi.
- [ ] Gaya kode sudah diperiksa.
- [ ] Bug dan runtime sudah diperiksa.
- [ ] Arsitektur dan struktur sudah diperiksa.
- [ ] Performa sudah diperiksa.
- [ ] UX/UI sudah diperiksa apabila relevan.
- [ ] SDK dan paket sudah diverifikasi apabila relevan.
- [ ] Kesimpulan didukung bukti, bukan asumsi.

### Pembaruan aturan

- [ ] `aturan_khusus.md` sudah diperiksa dan diperbarui apabila diperlukan.
- [ ] `aturan_bersama.md` sudah diperiksa dan diperbarui apabila diperlukan.
- [ ] Prinsip global dari temuan khusus sudah dipertimbangkan.
- [ ] Contoh benar dan salah tersedia untuk aturan teknis yang membutuhkannya.
- [ ] Tidak ada aturan duplikat yang tidak diperlukan.
- [ ] Konflik aturan sudah diidentifikasi.

### Pembentukan konteks

- [ ] `script/build_rules_context.sh` sudah diperiksa.
- [ ] Isi manual `AGENTS.md` sudah dilindungi.
- [ ] Script sudah dijalankan.
- [ ] Hasil `AGENTS.md` sudah diverifikasi.

### Checkpoint

- [ ] `catatan.md` sudah diperbarui.
- [ ] Bagian command lain di `catatan.md` tidak berubah.
- [ ] SHA terakhir yang dicatat benar.
- [ ] Tidak ada commit yang belum selesai tetapi sudah ditandai selesai.

### Batasan perubahan

- [ ] Tidak ada kode aplikasi yang diubah.
- [ ] Tidak ada script yang diubah.
- [ ] Tidak ada commit atau push.
- [ ] Tidak ada perubahan lokal pengguna yang tertimpa.

---

## 18. Prinsip Akhir

Gunakan setiap perubahan kode sebagai kesempatan untuk memahami standar implementasi yang diinginkan pengguna.

Jangan hanya mencari kesalahan teknis. Pelajari juga:

- Bagaimana pengguna menginginkan kode ditulis.
- Bagaimana struktur kode seharusnya disusun.
- Bagaimana bug sebelumnya diperbaiki.
- Bagaimana pengalaman pengguna diharapkan bekerja.
- Bagaimana AI seharusnya menggunakan SDK dan paket.
- Prinsip mana yang layak diberlakukan pada semua proyek Flutter.

Aturan khusus menjaga standar proyek.

Aturan bersama menjaga standar yang dapat dipakai lintas proyek Flutter.

Keduanya harus saling melengkapi tanpa duplikasi dan tanpa konflik yang tidak diselesaikan.

**Tujuan utama bukan memperbanyak jumlah aturan, melainkan meningkatkan ketepatan AI dalam menghasilkan kode yang sesuai dengan standar dan keinginan pengguna.**
