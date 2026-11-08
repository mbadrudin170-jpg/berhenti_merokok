---
description: Evaluasi setiap commit Git satu per satu untuk mempelajari standar kode pengguna, mencegah kesalahan berulang, serta menyempurnakan aturan khusus proyek dan aturan bersama Flutter.
agent: code
---

# EVALUASI ATURAN KHUSUS DAN ATURAN BERSAMA FLUTTER

## 1. TUJUAN

Command ini digunakan untuk mempelajari seluruh perubahan kode melalui riwayat Git agar AI semakin memahami standar implementasi yang diinginkan pengguna.

Setiap kali pengguna memperbaiki, menambahkan, atau mengubah kode, perubahan tersebut harus dapat menjadi bahan pembelajaran untuk mencegah kesalahan yang sama terulang.

Evaluasi mencakup seluruh aspek perubahan kode, bukan hanya bug.

Aspek yang wajib dipertimbangkan:

1. Gaya dan konsistensi penulisan kode.
2. Struktur dan arsitektur.
3. Logika bisnis dan ketepatan implementasi.
4. Bug dan runtime.
5. Performa dan penggunaan memori.
6. Pengelolaan state dan lifecycle.
7. Penggunaan SDK, framework, widget, dan package.
8. Database dan konsistensi data.
9. UX/UI dan pengalaman pengguna.
10. Keamanan dan privasi.
11. Pengujian dan pemeliharaan kode.
12. Aspek lain yang memengaruhi kualitas implementasi.

Hasil evaluasi digunakan untuk:

- Menambahkan atau memperbarui `.agents/rules/proyek/aturan_khusus.md`.
- Menambahkan atau memperbarui `.agents/rules/global/aturan_bersama.md`.
- Mengambil prinsip umum dari temuan khusus proyek sebagai referensi aturan bersama Flutter.
- Mempelajari toleransi dan pengecualian melalui riwayat perubahan `task.md`.
- Memperbarui checkpoint command ini pada `catatan.md`.

**Tujuan akhir: AI mampu menghasilkan implementasi yang semakin sesuai dengan standar pengguna dan tidak mengulangi kesalahan yang sebelumnya sudah diperbaiki.**

---

## 2. BATASAN EKSEKUSI

### 2.1 File yang boleh diperbarui

Hanya file berikut yang boleh diperbarui:

1. `.agents/rules/proyek/aturan_khusus.md`
2. `.agents/rules/global/aturan_bersama.md`
3. `catatan.md`, hanya bagian checkpoint command ini.

File lainnya hanya boleh dibaca untuk memperoleh konteks dan bukti evaluasi.

### 2.2 Larangan

DILARANG:

1. Mengubah kode aplikasi.
2. Memperbaiki bug secara langsung.
3. Melakukan refactoring.
4. Mengubah `task.md`.
5. Mengubah isi command ini.
6. Mengubah konfigurasi proyek.
7. Menambah atau menghapus dependency.
8. Melakukan commit atau push.
9. Menjalankan script apa pun.
10. Menjalankan `script/build_rules_context.sh`.
11. Mengubah atau memperbarui `AGENTS.md` secara manual.
12. Mengubah bagian `catatan.md` milik command lain.
13. Menghapus aturan lama yang masih relevan.
14. Menambahkan aturan berdasarkan asumsi tanpa bukti yang memadai.

**Penting:** Command ini hanya untuk evaluasi dan penyempurnaan dokumentasi aturan. Tidak melakukan implementasi kode.

### 2.3 Prinsip evaluasi

Pisahkan tiga hal:

- **Fakta:** perubahan yang benar-benar ditemukan pada commit.
- **Kesimpulan:** pelajaran yang dapat diambil dari perubahan tersebut.
- **Aturan:** ketentuan yang dirumuskan untuk mencegah kesalahan berulang.

Jangan mengubah setiap temuan menjadi aturan wajib.

---

## 3. PEMERIKSAAN AWAL

Sebelum evaluasi:

1. Pastikan direktori aktif merupakan root repository.
2. Periksa branch aktif.
3. Catat SHA lengkap HEAD.
4. Periksa kondisi repository dengan `git status`.
5. Identifikasi perubahan lokal yang belum di-commit.
6. Pastikan file yang diperlukan tersedia.

Baca terlebih dahulu:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_proyek.md`, jika tersedia.
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`
- `catatan.md`
- `task.md`
- File aturan lain yang relevan.

Baca juga command ini untuk memastikan batasan evaluasi dipahami.

Jangan mengandalkan isi percakapan sebelumnya sebagai pengganti pembacaan file aktual.

### 3.1 Audit aturan yang sudah tersedia

Sebelum menambahkan aturan:

1. Pelajari seluruh aturan yang berkaitan dengan perubahan.
2. Identifikasi aturan yang sudah mencakup temuan.
3. Identifikasi aturan yang memiliki tujuan sama.
4. Identifikasi aturan yang bertentangan.
5. Identifikasi aturan yang terlalu ketat.
6. Identifikasi aturan yang terlalu umum.
7. Identifikasi aturan yang belum memiliki contoh benar dan salah.

Jangan membuat aturan duplikat.

Jika ada konflik, evaluasi berdasarkan tujuan aturan, bukti commit, dan kebutuhan proyek.

Jangan mengubah aturan wajib menjadi opsional hanya karena menemukan satu implementasi yang berbeda.

---

## 4. MENENTUKAN TARGET COMMIT

Baca `catatan.md` terlebih dahulu.

Gunakan bagian khusus:

`# Commit terakhir yang dievaluasi oleh commands [evaluasi_aturan_khusus.md](.kilo/commands/evaluasi_aturan_khusus.md)`

Checkpoint harus menggunakan penanda:

```markdown
<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_START -->

<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_END -->
```

Jangan menggunakan checkpoint milik command lain.

### 4.1 Jika checkpoint tersedia dan valid

Ambil SHA lengkap commit terakhir yang sudah selesai dievaluasi.

Pastikan checkpoint merupakan ancestor dari HEAD:

```bash
git merge-base --is-ancestor SHA_CHECKPOINT HEAD
```

Jika valid, ambil seluruh commit setelah checkpoint sampai HEAD:

```bash
git log --reverse --format="%H%x09%cs%x09%s" SHA_CHECKPOINT..HEAD
```

Jangan membatasi jumlah commit menjadi lima jika checkpoint valid.

Semua commit yang belum dievaluasi harus diperiksa.

### 4.2 Jika checkpoint belum tersedia

Jika belum ada checkpoint yang valid:

Ambil maksimal lima commit terakhir:

```bash
git log --reverse -5 --format="%H%x09%cs%x09%s" HEAD
```

Jika jumlah commit kurang dari lima, evaluasi seluruh commit yang tersedia.

Urutkan dari commit paling lama menuju commit paling baru.

### 4.3 Jika checkpoint tidak valid

Jika checkpoint tidak ditemukan atau bukan ancestor HEAD:

1. Jangan langsung mengganti checkpoint.
2. Periksa kemungkinan perubahan branch.
3. Periksa kemungkinan rebase atau force push.
4. Periksa apakah riwayat Git berubah.
5. Laporkan permasalahan.
6. Jangan menebak rentang evaluasi.

Jangan mengambil lima commit terakhir sebagai pengganti checkpoint yang bermasalah tanpa memastikan kondisi repository.

### 4.4 Kunci TARGET_HEAD

Setelah pemeriksaan awal selesai, tentukan SHA lengkap HEAD sebagai target tetap.

```bash
TARGET_HEAD=$(git rev-parse HEAD)
```

Simpan nilai tersebut selama seluruh proses evaluasi.

Semua daftar commit harus berasal dari rentang yang berakhir pada `TARGET_HEAD`.

**Aturan mutlak:**

Jika ada commit baru setelah `TARGET_HEAD` ditentukan:

- Abaikan seluruh commit baru tersebut.
- Jangan memasukkannya ke daftar evaluasi.
- Jangan membaca diff commit baru.
- Jangan mengubah target evaluasi.
- Selesaikan hanya commit yang sudah ditentukan.
- Evaluasi commit baru pada eksekusi command berikutnya.

Jangan menjalankan ulang pengambilan daftar commit dengan HEAD terbaru di tengah proses.

Dengan demikian, target evaluasi tidak berubah selama pekerjaan berlangsung.

### 4.5 Jika tidak ada commit baru

Jika checkpoint sama dengan target HEAD:

- Jangan membaca ulang commit lama.
- Jangan membuat aturan baru tanpa bahan evaluasi.
- Jangan memperbarui checkpoint dengan nilai yang sama.
- Jangan mengubah riwayat evaluasi.

Laporkan bahwa tidak ada commit baru.

---

## 5. MEMBACA COMMIT SATU PER SATU

Ini merupakan tahapan wajib.

Jangan hanya membaca judul commit, statistik, atau ringkasan.

Setiap commit harus dibaca dan dianalisis secara individual.

### 5.1 Baca informasi commit

```bash
git show -s --format=fuller SHA_COMMIT
```

Periksa:

- SHA lengkap.
- Tanggal.
- Author.
- Judul commit.
- Pesan commit.
- Parent commit.

### 5.2 Identifikasi seluruh file yang berubah

```bash
git diff-tree --no-commit-id --name-status -r SHA_COMMIT
```

Perhatikan:

- File baru.
- File yang diubah.
- File yang dihapus.
- File yang dipindahkan.
- Perubahan nama file.

### 5.3 Baca seluruh diff

```bash
git show --format=fuller --stat --patch --find-renames SHA_COMMIT
```

Jika commit memiliki parent:

```bash
git diff --find-renames SHA_COMMIT^1 SHA_COMMIT
```

Jika root commit:

```bash
git show --root --format=fuller --stat --patch SHA_COMMIT
```

Untuk merge commit, gunakan first parent sebagai pembanding utama.

Jika output terlalu panjang:

1. Bagi pembacaan berdasarkan file.
2. Baca seluruh bagian diff.
3. Jangan melewatkan perubahan kecil.
4. Pastikan seluruh file selesai diperiksa.

### 5.4 Baca konteks kode

Jika diff belum cukup menjelaskan perubahan:

1. Baca kode sebelum perubahan.
2. Baca kode setelah perubahan pada commit tersebut.
3. Periksa fungsi yang berkaitan.
4. Periksa hubungan dengan model, provider, repository, widget, database, dan komponen lain.
5. Periksa apakah perubahan masih berlaku pada target HEAD.

Gunakan isi commit yang sedang dievaluasi untuk memahami sejarah perubahan.

Jangan menggunakan kondisi working tree saat ini sebagai pengganti isi commit lama.

### 5.5 Selesaikan satu commit sebelum berpindah

Untuk setiap commit, catat:

- File yang berubah.
- Tujuan perubahan.
- Implementasi sebelum perubahan.
- Implementasi setelah perubahan.
- Kesalahan yang diperbaiki.
- Kesalahan baru yang mungkin muncul.
- Pola yang dipertahankan.
- Pola yang harus dihindari.
- Kandidat aturan khusus.
- Kandidat aturan global.
- Referensi toleransi.
- Hal yang belum dapat dipastikan.

Setelah satu commit selesai dievaluasi, baru lanjutkan ke commit berikutnya.

Jangan menyatukan seluruh commit menjadi satu analisis tanpa pemeriksaan individual.

---

## 6. EVALUASI SELURUH ASPEK KODE

Evaluasi seluruh perubahan yang ditemukan, bukan hanya perubahan yang terlihat seperti bug.

### 6.1 Tujuan dan logika implementasi

Periksa:

- Kesesuaian dengan kebutuhan.
- Ketepatan logika bisnis.
- Ketepatan hasil.
- Perubahan perilaku aplikasi.
- Asumsi yang tidak memiliki dasar.
- Implementasi yang tidak diperlukan.

### 6.2 Gaya dan konsistensi kode

Periksa:

- Penamaan variabel, fungsi, class, dan file.
- Urutan import.
- Format kode.
- Struktur file.
- Penggunaan konstanta.
- Duplikasi.
- Kompleksitas.
- Keterbacaan.
- Konsistensi dengan pola proyek.

Pelajari perubahan gaya yang dilakukan pengguna. Jangan menganggap semua perbedaan gaya sebagai kesalahan.

### 6.3 Arsitektur dan struktur

Periksa:

- Pemisahan tanggung jawab.
- Penempatan kode.
- Ketergantungan antarlapisan.
- Abstraksi.
- Pemisahan business logic dan UI.
- Struktur fitur.
- Duplikasi logika.

### 6.4 Bug dan runtime

Periksa:

- Null safety.
- Exception.
- Asynchronous.
- Future.
- Error handling.
- Lifecycle.
- mounted.
- BuildContext.
- Navigasi.
- Resource.
- Timer.
- Stream.
- Listener.
- Transaksi database.

### 6.5 State management

Periksa:

- Konsistensi state.
- Loading.
- Error.
- Data kosong.
- Data berhasil.
- Rebuild.
- Provider.
- Sinkronisasi state dan database.
- Race condition.

### 6.6 Performa

Periksa:

- Rebuild berlebihan.
- Operasi berulang.
- Pemrosesan berat.
- Penggunaan memori.
- Pengelolaan resource.
- Operasi yang menghambat UI.

### 6.7 Database dan data

Periksa:

- CRUD.
- Migrasi.
- Kompatibilitas data lama.
- Validasi.
- Konsistensi transaksi.
- Risiko kehilangan data.
- Duplikasi data.
- Penyimpanan dan pengambilan data.

### 6.8 UX/UI

Periksa:

- Kejelasan fungsi tombol.
- Kemudahan penggunaan.
- Konsistensi desain.
- Layout.
- Responsivitas.
- Ukuran komponen.
- Padding, spacing, dan margin.
- Text overflow.
- Loading.
- Success.
- Warning.
- Error.
- Konfirmasi tindakan penting.
- Pencegahan double-submit.
- Feedback kepada pengguna.

Utamakan fungsi dan kemudahan penggunaan sebelum estetika.

### 6.9 SDK dan package

Periksa:

- API yang digunakan.
- Versi SDK.
- Versi package.
- Konstruktor.
- Parameter.
- Deprecated API.
- Dukungan platform.
- Ketepatan penggunaan.
- Alternatif API.

### 6.10 Keamanan dan privasi

Periksa:

- Validasi input.
- Autentikasi.
- Otorisasi.
- Penyimpanan data sensitif.
- Logging.
- Akses database.
- Potensi kebocoran data.

### 6.11 Pengujian dan pemeliharaan

Periksa:

- Unit test.
- Widget test.
- Pengujian state.
- Pengujian error.
- Pengujian batas nilai.
- Kemudahan pemeliharaan.
- Keterbacaan implementasi.

### 6.12 Aspek tambahan

Jika ditemukan aspek lain yang memengaruhi kualitas kode, evaluasi juga.

**Jangan memaksakan setiap perubahan menjadi aturan baru.**

---

## 7. MEMPELAJARI STANDAR PENGGUNA

Tujuan utama evaluasi adalah memahami standar implementasi yang diinginkan pengguna.

Perhatikan:

1. Kode yang diperbaiki berulang kali.
2. Implementasi lama yang diganti.
3. Pola yang dipertahankan.
4. Pola yang dihapus.
5. Struktur yang dipilih.
6. Cara penanganan bug.
7. Cara penanganan error.
8. Cara memperbaiki UX/UI.
9. Perubahan yang mengurangi kompleksitas.
10. Perubahan yang menunjukkan preferensi implementasi.

### 7.1 Kekuatan bukti

**Bukti kuat:**

- Kesalahan diperbaiki secara eksplisit.
- Pola diperbaiki berulang kali.
- Implementasi baru jelas menggantikan pola lama.
- Ketentuan sudah pernah dinyatakan pengguna.

**Bukti pendukung:**

- Perubahan satu kali dengan alasan teknis jelas.
- Pola yang dipertahankan pada beberapa bagian.
- Penyempurnaan yang konsisten dengan aturan sebelumnya.

**Bukti lemah:**

- Perubahan kosmetik satu kali.
- Perubahan yang alasannya tidak diketahui.
- Interpretasi yang belum memiliki pembuktian.

Jangan mengubah bukti lemah menjadi aturan wajib.

Jika alasan perubahan tidak diketahui, nyatakan bahwa kesimpulan merupakan interpretasi dari perubahan kode, bukan fakta tentang maksud pengguna.

---

## 8. PEMERIKSAAN SOURCE SDK DAN PACKAGE

Jika perubahan menyangkut SDK, framework, widget, API, atau package, periksa source aktual sesuai versi yang digunakan proyek.

Jangan hanya mengandalkan pengetahuan model.

### 8.1 Identifikasi versi

Periksa:

- `pubspec.yaml`
- `pubspec.lock`
- `.dart_tool/package_config.json`
- Versi Flutter.
- Versi Dart.

### 8.2 Periksa source

Untuk Flutter dan Dart:

1. Temukan lokasi SDK.
2. Temukan file source API.
3. Baca deklarasi class.
4. Baca konstruktor.
5. Periksa parameter.
6. Periksa tipe data.
7. Periksa nilai default.
8. Periksa status deprecated.
9. Baca implementasi apabila diperlukan.

Untuk package:

1. Identifikasi nama package.
2. Identifikasi versi.
3. Temukan source package.
4. Baca API yang digunakan.
5. Cocokkan dengan implementasi proyek.

### 8.3 Catat bukti

Catat:

- Nama API.
- Path kode proyek.
- Nomor baris.
- Path source SDK/package.
- Versi SDK/package.
- Hasil pemeriksaan.

Jika source tidak tersedia, tandai sebagai belum terverifikasi.

Jangan mengaku sudah memeriksa source yang belum dibaca.

---

## 9. PEMERIKSAAN RIWAYAT TASK.MD

Tahapan ini wajib dilakukan.

File:

`task.md`

Tujuan pemeriksaan ini adalah mempelajari toleransi dan pengecualian yang dapat disimpulkan dari riwayat task.

### 9.1 Identifikasi seluruh perubahan task.md

Cari commit dalam rentang target yang mengubah `task.md`.

```bash
git log --reverse --format="%H%x09%s" TARGET_BASE..TARGET_HEAD -- task.md
```

Jika belum ada checkpoint dan menggunakan lima commit awal, gunakan rentang commit awal yang sudah ditentukan.

Untuk setiap commit yang mengubah `task.md`, baca diff lengkap:

```bash
git show --format=fuller --patch SHA_COMMIT -- task.md
```

Baca setiap perubahan satu per satu.

### 9.2 Cari task berstatus batal yang kemudian dihapus

Fokus pada riwayat berikut:

1. Task pernah tercatat di `task.md`.
2. Task memiliki status `batal`.
3. Task kemudian dihapus dari `task.md`.
4. Identifikasi commit yang menghapusnya.
5. Baca alasan pembatalan jika tersedia.
6. Periksa apakah task benar-benar dihapus atau dipindahkan.
7. Periksa aturan yang berkaitan dengan task tersebut.

Jangan hanya memeriksa isi `task.md` saat ini.

Gunakan riwayat commit untuk mengetahui perubahan status dan penghapusannya.

### 9.3 Jadikan sebagai referensi toleransi

Jika ditemukan task berstatus `batal` yang kemudian dihapus, jadikan peristiwa tersebut sebagai referensi untuk mempelajari aturan yang boleh ditoleransi.

Evaluasi kemungkinan berikut:

- Aturan terlalu ketat.
- Aturan tidak sesuai kebutuhan nyata.
- Ada kondisi yang dapat dikecualikan.
- Solusi yang disarankan tidak diperlukan.
- Risiko tertentu dapat diterima.
- Aturan perlu dibatasi cakupannya.
- Aturan seharusnya menjadi rekomendasi, bukan kewajiban.

Namun, jangan langsung menyimpulkan bahwa semua aturan yang berkaitan boleh dilanggar.

Periksa alasan dan konteks penghapusan.

### 9.4 Klasifikasi hasil toleransi

Jika bukti cukup:

- Perbarui aturan khusus jika toleransi hanya berlaku pada proyek ini.
- Perbarui aturan bersama jika prinsip toleransi dapat diterapkan lintas proyek Flutter.
- Tambahkan kondisi pengecualian secara eksplisit.
- Jelaskan kapan aturan wajib berlaku.
- Jelaskan kapan pengecualian diperbolehkan.
- Tambahkan contoh benar dan salah apabila diperlukan.

Jika alasan pembatalan tidak diketahui, catat sebagai bukti historis yang belum dapat dipastikan.

### 9.5 Larangan

Jangan:

- Mengubah `task.md`.
- Menghapus task.
- Mengubah status task.
- Menganggap task yang dihapus otomatis selesai.
- Menganggap seluruh aturan terkait boleh dilanggar.
- Mengarang alasan pembatalan.
- Menghapus aturan wajib tanpa bukti.

---

## 10. KLASIFIKASI ATURAN

Setelah seluruh commit dievaluasi, kelompokkan temuan.

### 10.1 Aturan khusus proyek

Path:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan aturan yang bergantung pada:

- Fitur tertentu.
- Modul tertentu.
- Struktur proyek.
- Database proyek.
- Logika bisnis.
- Nama tabel.
- Model khusus.
- Package khusus fitur.
- Konfigurasi platform.
- Kebutuhan aplikasi tertentu.

Jelaskan cakupan penerapan setiap aturan.

### 10.2 Aturan bersama Flutter

Path:

`.agents/rules/global/aturan_bersama.md`

Masukkan prinsip yang dapat digunakan pada proyek Flutter lainnya.

Contohnya:

- Null safety.
- Asynchronous.
- Lifecycle.
- Error handling.
- State management.
- Performa widget.
- Pengelolaan resource.
- Penggunaan SDK.
- Pengujian.
- Prinsip UX/UI lintas proyek.

Jangan memasukkan ketentuan yang hanya berlaku untuk fitur khusus aplikasi.

### 10.3 Referensi umum dari temuan khusus

Walaupun temuan hanya dapat diterapkan pada satu proyek, cari prinsip umum yang bisa dipelajari untuk aturan bersama.

Contoh:

**Temuan khusus:**

Perhitungan hari smoke-free harus menghilangkan komponen jam sebelum menghitung selisih tanggal.

**Prinsip umum:**

Perhitungan berbasis hari harus menggunakan representasi tanggal yang konsisten agar komponen waktu tidak menyebabkan pergeseran hasil.

Prinsip umum tersebut boleh dijadikan referensi aturan bersama.

Namun, jangan otomatis menjadikannya aturan wajib apabila belum cukup bukti.

### 10.4 Pertanyaan klasifikasi

Sebelum menambahkan aturan, pastikan:

1. Apakah berlaku pada seluruh proyek Flutter?
2. Apakah bergantung pada fitur tertentu?
3. Apakah bergantung pada package tertentu?
4. Apakah prinsipnya dapat digunakan lintas proyek?
5. Apakah sudah tercakup aturan global?
6. Apakah sudah tercakup aturan khusus?
7. Apakah memerlukan pengecualian?

Jangan menggandakan aturan wajib yang sama pada kedua file.

---

## 11. STANDAR PENULISAN ATURAN

Setiap aturan baru atau aturan yang diperbarui wajib memiliki struktur yang jelas.

Gunakan format:

### Judul Aturan

**Cakupan:**

Jelaskan lokasi, komponen, atau kondisi penerapan.

**Aturan wajib:**

Tuliskan ketentuan yang harus dipatuhi.

**Larangan:**

Jelaskan implementasi yang tidak diperbolehkan.

**Pengecualian:**

Jelaskan kondisi yang membolehkan penyimpangan apabila memang diperlukan.

**Alasan:**

Jelaskan masalah, dampak, dan alasan teknis aturan tersebut dibuat.

**Contoh benar:**

```dart
// Implementasi yang sesuai dengan aturan.
```

**Contoh salah:**

```dart
// Implementasi yang harus dihindari.
```

**Sumber evaluasi:**

- SHA commit.
- Path file.
- Nomor baris jika tersedia.

### 11.1 Ketentuan contoh kode

Contoh benar dan salah wajib tersedia untuk setiap aturan baru atau aturan yang diperbarui.

Contoh harus:

1. Menggunakan Dart/Flutter jika berkaitan dengan Flutter.
2. Relevan dengan aturan.
3. Benar secara sintaksis.
4. Sesuai versi SDK dan package.
5. Menunjukkan perbedaan implementasi yang jelas.
6. Tidak menggunakan placeholder ambigu.
7. Tidak menyesatkan AI.

Jangan membuat contoh yang hanya berbeda nama variabel tanpa menunjukkan kesalahan sebenarnya.

### 11.2 Redaksi aturan

Gunakan bahasa Indonesia baku.

Gunakan istilah:

- WAJIB untuk ketentuan yang harus dilakukan.
- DILARANG untuk tindakan yang tidak diperbolehkan.
- BOLEH untuk tindakan yang diperkenankan.
- HANYA JIKA untuk kondisi tertentu.
- KECUALI untuk pengecualian.

Hindari kalimat ambigu, pengulangan, larangan tanpa alasan, dan pengecualian tanpa kondisi.

---

## 12. MEMPERBARUI FILE ATURAN

### 12.1 Aturan khusus

Perbarui:

`.agents/rules/proyek/aturan_khusus.md`

Ketentuan:

1. Pertahankan aturan lama yang masih relevan.
2. Tambahkan aturan baru yang memiliki bukti.
3. Perbaiki aturan ambigu.
4. Perbaiki contoh benar dan salah.
5. Perbarui sumber evaluasi.
6. Gabungkan aturan yang duplikat.
7. Jangan menghapus riwayat sumber yang masih relevan.

### 12.2 Aturan bersama

Perbarui:

`.agents/rules/global/aturan_bersama.md`

Ketentuan:

1. Masukkan hanya prinsip yang dapat diterapkan lintas proyek Flutter.
2. Ambil referensi umum dari temuan khusus.
3. Jangan menyalin implementasi khusus secara mentah.
4. Jangan menggandakan aturan yang sudah tersedia.
5. Perbarui contoh kode.
6. Sertakan sumber evaluasi.
7. Tambahkan pengecualian jika memiliki bukti.

### 12.3 Aturan yang terlalu ketat

Jika ditemukan aturan yang perlu dilonggarkan:

1. Periksa bukti commit.
2. Periksa riwayat task yang batal.
3. Periksa apakah ada kondisi yang memang membolehkan pengecualian.
4. Tentukan apakah yang perlu diubah adalah cakupan, kewajiban, atau pengecualian.
5. Jelaskan kondisi penerapannya.

Jangan menghapus aturan wajib hanya untuk membuat AI lebih mudah mengerjakan tugas.

Tujuannya adalah aturan yang tepat dan dapat diterapkan.

---

## 13. PEMERIKSAAN AKHIR ATURAN

Setelah kedua file diperbarui:

1. Baca ulang seluruh bagian yang berubah.
2. Periksa konflik dengan aturan lain.
3. Periksa duplikasi.
4. Periksa klasifikasi global dan khusus.
5. Periksa contoh benar dan salah.
6. Periksa sumber commit.
7. Periksa path file.
8. Pastikan aturan lama tidak hilang tanpa alasan.
9. Pastikan pengecualian memiliki kondisi jelas.

Pastikan hasilnya:

- Aturan khusus tidak tercampur dengan aturan global.
- Referensi umum tidak dipaksakan menjadi kewajiban.
- Tidak ada konflik baru.
- Tidak ada contoh kode yang menyesatkan.
- Tidak ada aturan yang terlalu ketat tanpa alasan.
- Tidak ada aturan yang terlalu longgar tanpa batasan.

---

## 14. MEMPERBARUI CATATAN.MD

File:

`catatan.md`

Bagian yang boleh diperbarui HANYA bagian checkpoint command ini:

`# Commit terakhir yang dievaluasi oleh commands [evaluasi_aturan_khusus.md](.kilo/commands/evaluasi_aturan_khusus.md)`

Gunakan penanda:

```markdown
<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_START -->

- Branch evaluasi: NAMA_BRANCH
- Commit terakhir yang dievaluasi: SHA_LENGKAP
- SHA lengkap: SHA_LENGKAP
- Tanggal evaluasi: YYYY-MM-DD
- Status: Selesai

<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_END -->
```

### 14.1 Ketentuan pembaruan

1. Jangan menambahkan bagian riwayat evaluasi baru.
2. Jangan menambahkan ringkasan setiap commit.
3. Jangan menambahkan daftar file yang diperiksa.
4. Jangan menambahkan catatan temuan.
5. Jangan menambahkan checkpoint di luar bagian command ini.
6. Jangan mengubah checkpoint command lain.
7. Jangan mengubah bagian lain dari `catatan.md`.
8. Jangan menggandakan informasi yang sudah tersedia di file aturan.

Cukup perbarui nilai checkpoint yang sudah ada.

Jika checkpoint belum tersedia, buat bagian checkpoint khusus ini tanpa mengubah bagian lainnya.

### 14.2 SHA yang dicatat

Gunakan SHA commit terakhir dari daftar target yang seluruh evaluasinya telah selesai.

Jangan menggunakan HEAD terbaru jika terdapat commit baru setelah TARGET_HEAD ditentukan.

Jika evaluasi belum selesai seluruhnya, jangan memajukan checkpoint melewati commit yang belum selesai.

Jika terjadi kegagalan di tengah evaluasi, checkpoint harus menunjuk ke commit terakhir yang benar-benar selesai dievaluasi, bukan commit terakhir yang baru dibaca sebagian.

**Fungsi catatan.md hanya sebagai penanda progres evaluasi, bukan tempat menyimpan laporan panjang.**

---

## 15. LARANGAN MENJALANKAN SCRIPT

Selama menjalankan command ini:

**DILARANG menjalankan script apa pun.**

Termasuk tetapi tidak terbatas pada:

- `script/build_rules_context.sh`
- Script pembentukan konteks aturan lainnya.
- Script otomatisasi repository.
- Script build.
- Script pengujian.

Jangan menjalankan script untuk memperbarui `AGENTS.md`.

Jangan mengubah `AGENTS.md` secara manual.

Apabila perubahan aturan membutuhkan pembaruan `AGENTS.md`, cukup laporkan bahwa pembaruan konteks belum dilakukan karena command ini tidak mengizinkan eksekusi script.

Jangan mencari cara alternatif untuk menjalankan proses yang sama secara otomatis.

---

## 16. MENANGANI COMMIT BARU SELAMA EVALUASI

Sebelum mengakhiri pekerjaan:

1. Pastikan seluruh commit dalam daftar target telah diperiksa.
2. Pastikan tidak ada commit target yang terlewat.
3. Pastikan checkpoint menunjuk ke commit terakhir yang selesai dievaluasi.
4. Jangan memasukkan commit setelah TARGET_HEAD.
5. Jangan mengubah daftar commit awal.

Commit baru yang muncul setelah target ditentukan menjadi bahan evaluasi pada eksekusi berikutnya.

Jangan mengulang evaluasi hanya karena terdapat commit baru.

---

## 17. LAPORAN AKHIR

Setelah selesai, berikan laporan dengan struktur:

# Laporan Evaluasi Aturan

### A. Informasi Evaluasi

- Branch:
- Target HEAD:
- Checkpoint sebelumnya:
- Checkpoint baru:
- Jumlah commit dievaluasi:
- Rentang commit:
- Status:

### B. Hasil Pemeriksaan Commit

- Jumlah commit yang diperiksa.
- Jumlah file yang diperiksa.
- Aspek perubahan yang ditemukan.
- Kesalahan yang ditemukan.
- Pola implementasi yang dipertahankan.

### C. Pembaruan Aturan Khusus

- Path: `.agents/rules/proyek/aturan_khusus.md`
- Aturan yang ditambahkan.
- Aturan yang diperbarui.
- Aturan yang tidak perlu diubah.
- Alasan perubahan.

### D. Pembaruan Aturan Bersama Flutter

- Path: `.agents/rules/global/aturan_bersama.md`
- Prinsip umum yang ditambahkan.
- Aturan yang diperbarui.
- Referensi yang diambil dari temuan khusus.

### E. Hasil Pemeriksaan task.md

- Task berstatus batal yang ditemukan.
- Commit penghapusan task.
- Bukti toleransi yang ditemukan.
- Aturan yang memerlukan pengecualian.
- Temuan yang belum dapat dipastikan.

### F. Checkpoint

- Apakah bagian checkpoint berhasil diperbarui?
- SHA terakhir yang dicatat.
- Apakah terdapat commit baru yang belum dievaluasi?

### G. Kendala

Laporkan file yang tidak ditemukan, konflik yang belum selesai, source SDK yang belum dapat diperiksa, atau tahapan evaluasi yang belum berhasil dilakukan.

Jangan menyatakan seluruh pekerjaan selesai jika masih ada tahapan yang belum dikerjakan.

---

## 18. KRITERIA SELESAI

Command hanya boleh dinyatakan selesai apabila:

1. Seluruh commit target dibaca satu per satu.
2. Seluruh diff relevan sudah diperiksa.
3. Semua aspek perubahan kode sudah dievaluasi.
4. Riwayat perubahan `task.md` sudah diperiksa.
5. Task berstatus batal yang kemudian dihapus sudah dipelajari.
6. Toleransi yang memiliki bukti sudah dianalisis.
7. Aturan khusus sudah dievaluasi.
8. Aturan bersama Flutter sudah dievaluasi.
9. Prinsip umum dari temuan khusus sudah dipertimbangkan.
10. Contoh benar dan salah tersedia untuk aturan baru atau aturan yang diperbarui.
11. Tidak ada konflik atau duplikasi baru yang dibiarkan tanpa penjelasan.
12. `catatan.md` hanya diperbarui pada bagian checkpoint command ini.
13. Tidak ada script yang dijalankan.
14. Commit baru setelah TARGET_HEAD tidak ikut dievaluasi.

Jika ada tahapan yang gagal, laporkan dengan jujur dan jangan memajukan checkpoint melewati pekerjaan yang belum selesai.

---

## 19. PRINSIP PENUTUP

**Belajar dari perubahan, bukan berasumsi.**

Setiap aturan harus mempunyai dasar yang dapat ditelusuri.

**Jangan terlalu kaku.**

Aturan harus membantu menghasilkan implementasi yang benar, bukan menghambat solusi yang sesuai kebutuhan.

**Jangan terlalu longgar.**

Pengecualian harus mempunyai alasan, kondisi, dan batasan yang jelas.

**Pisahkan aturan global dan khusus.**

Prinsip yang dapat digunakan lintas proyek Flutter harus dipertimbangkan untuk aturan bersama.

**Jaga kesinambungan evaluasi.**

Jangan membaca ulang commit yang sudah selesai dievaluasi apabila checkpoint valid.

**Cegah kesalahan berulang.**

Setiap kesalahan yang pernah diperbaiki harus dipertimbangkan sebagai bahan penyempurnaan aturan agar AI tidak mengulangi kesalahan yang sama.

**Hasil akhir: AI semakin memahami standar implementasi pengguna dan mampu menerapkannya secara konsisten pada seluruh proyek Flutter.**
