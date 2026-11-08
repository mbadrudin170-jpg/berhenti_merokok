---
description: Evaluasi setiap commit satu per satu untuk mempelajari standar kode pengguna, mencegah kesalahan berulang, dan menyempurnakan aturan khusus serta aturan bersama Flutter berdasarkan perubahan kode dan riwayat task yang dibatalkan.
agent: code
---

# Evaluasi Aturan Khusus dan Aturan Bersama Flutter

## 1. Tujuan

Command ini bertugas mempelajari standar implementasi yang diinginkan pengguna melalui riwayat perubahan kode Git.

Setiap perubahan harus dievaluasi agar AI semakin memahami cara menulis kode yang diinginkan pengguna dan tidak mengulangi kesalahan yang sebelumnya sudah diperbaiki.

Tujuan evaluasi:

1. Memahami perubahan kode yang dilakukan pengguna.
2. Menemukan pola implementasi yang benar dan yang harus dihindari.
3. Mengevaluasi gaya penulisan, struktur, arsitektur, bug, runtime, performa, UX/UI, database, keamanan, SDK, dan aspek lainnya.
4. Mempelajari kesalahan yang pernah diperbaiki.
5. Mempelajari keputusan pengguna ketika suatu task dibatalkan.
6. Mencegah AI mengulangi kesalahan implementasi.
7. Memperbarui aturan khusus proyek.
8. Menemukan prinsip yang dapat diterapkan pada proyek Flutter lainnya.
9. Memperbarui aturan bersama Flutter.
10. Menyimpan checkpoint evaluasi agar commit lama tidak perlu dibaca ulang.

Tujuan akhirnya adalah meningkatkan ketepatan AI dalam menghasilkan kode yang sesuai dengan standar dan keinginan pengguna.

## 2. File Target

Gunakan path berikut:

| File | Fungsi |
|---|---|
| `.kilo/commands/evaluasi_aturan_khusus.md` | Instruksi command ini. Jangan diubah saat dieksekusi. |
| `.agents/rules/proyek/aturan_khusus.md` | Aturan khusus proyek aktif. |
| `.agents/rules/global/aturan_bersama.md` | Aturan bersama untuk seluruh proyek Flutter. |
| `task.md` | Sumber pembelajaran mengenai task, termasuk task yang dibatalkan. |
| `catatan.md` | Checkpoint dan riwayat evaluasi. |
| `AGENTS.md` | Hasil penggabungan aturan. |
| `script/build_rules_context.sh` | Script pembentukan konteks aturan jika tersedia. |

Jangan mengarang path. Jika file atau script tidak ditemukan, periksa repository dan laporkan kondisi sebenarnya.

## 3. Batasan Eksekusi

Command ini bertugas mengevaluasi dan memperbarui dokumentasi aturan.

File yang boleh diperbarui:

1. `.agents/rules/proyek/aturan_khusus.md`
2. `.agents/rules/global/aturan_bersama.md`
3. `catatan.md`
4. `AGENTS.md`, hanya melalui script pembentukan konteks aturan.

Larangan:

- Jangan mengubah kode Dart.
- Jangan memperbaiki bug secara langsung.
- Jangan melakukan refactoring.
- Jangan mengubah konfigurasi aplikasi.
- Jangan mengubah `task.md`.
- Jangan mengubah script pembentukan konteks aturan.
- Jangan mengubah command ini.
- Jangan melakukan commit atau push.
- Jangan menghapus aturan lama yang masih relevan.
- Jangan menghapus riwayat evaluasi sebelumnya.
- Jangan menimpa perubahan lokal pengguna.

Jika terdapat perubahan lokal pada file target, pertahankan dan integrasikan secara hati-hati.

Jika suatu tahapan tidak dapat dilakukan, laporkan kendalanya. Jangan berpura-pura bahwa tahapan tersebut sudah selesai.

## 4. Pemeriksaan Awal Repository

Sebelum evaluasi:

1. Pastikan direktori kerja merupakan root repository Git.
2. Identifikasi branch aktif.
3. Identifikasi SHA lengkap HEAD.
4. Periksa `git status`.
5. Periksa keberadaan seluruh file target.

Baca terlebih dahulu:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_proyek.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`
- `task.md`
- `catatan.md`
- Script pembentukan konteks aturan.

Baca juga aturan lain dalam `.agents/rules/` yang relevan.

Sebelum membuat aturan baru, pahami:

1. Aturan yang sudah tersedia.
2. Kesalahan yang pernah diperbaiki.
3. Pola implementasi yang dipertahankan.
4. Pola implementasi yang dilarang.
5. Aturan khusus proyek.
6. Aturan global Flutter.
7. Riwayat task yang dibatalkan.
8. Potensi konflik dan duplikasi.

Jangan hanya mengandalkan pengetahuan model atau percakapan sebelumnya. Gunakan isi repository yang aktual.

## 5. Membaca catatan.md dan Menentukan Commit Target

Baca `catatan.md` di root sebelum mengambil riwayat Git.

Gunakan checkpoint khusus:

`# Commit terakhir yang dievaluasi oleh commands evaluasi_aturan_khusus.md`

Jangan mencampurkan checkpoint ini dengan checkpoint command lain.

Jangan mengubah bagian yang digunakan oleh `cek_perubahan_sekarang.md`.

### 5.1 Jika checkpoint tersedia

Ambil SHA lengkap commit terakhir yang sudah selesai dievaluasi.

Pastikan checkpoint merupakan ancestor dari HEAD aktif:

```bash
git merge-base --is-ancestor SHA_CHECKPOINT HEAD
```

Jika valid, ambil hanya commit setelah checkpoint:

```bash
git log --reverse --format="%H%x09%cs%x09%s" SHA_CHECKPOINT..HEAD
```

Jangan membaca ulang commit yang sudah selesai dievaluasi.

### 5.2 Jika checkpoint belum tersedia

Ambil maksimal lima commit terakhir:

```bash
git log --reverse -5 --format="%H%x09%cs%x09%s" HEAD
```

Jika jumlah commit kurang dari lima, gunakan seluruh commit yang tersedia.

### 5.3 Jika checkpoint tidak valid

Jika checkpoint tidak ditemukan atau bukan ancestor HEAD:

1. Jangan mengganti checkpoint secara otomatis.
2. Periksa kemungkinan rebase, force push, atau pergantian branch.
3. Identifikasi riwayat yang sebenarnya.
4. Laporkan jika rentang evaluasi tidak dapat dipastikan.

Jangan menebak commit yang sudah dievaluasi.

### 5.4 Tetapkan HEAD target

Setelah daftar commit diperoleh:

1. Catat SHA lengkap HEAD.
2. Simpan daftar commit target.
3. Tetapkan urutan evaluasi.
4. Jangan mengubah daftar tersebut selama evaluasi.

**Ketentuan commit baru:**

Jika terdapat commit baru setelah HEAD target ditentukan:

- Abaikan commit baru tersebut.
- Jangan masukkan ke daftar evaluasi.
- Jangan memperluas rentang commit.
- Jangan mengganti HEAD target.
- Selesaikan hanya commit yang sudah ditentukan.

Commit baru menjadi bahan evaluasi untuk pelaksanaan command berikutnya.

Jangan mengambil commit baru hanya karena HEAD berubah ketika AI sedang bekerja.

### 5.5 Jika tidak ada commit baru

Jika checkpoint sama dengan HEAD:

- Jangan membaca ulang commit lama.
- Jangan membuat aturan tanpa bahan evaluasi.
- Jangan mengubah riwayat evaluasi.
- Laporkan bahwa tidak ada commit baru.

## 6. Membaca Commit Satu per Satu

Setiap commit harus dibaca dan dievaluasi secara individual.

Jangan hanya membaca judul commit atau ringkasan Git.

Untuk setiap commit lakukan langkah berikut.

### 6.1 Identifikasi commit

```bash
git show -s --format=fuller SHA_COMMIT
```

Periksa SHA, tanggal, author, pesan, dan parent.

### 6.2 Identifikasi file yang berubah

```bash
git diff-tree --no-commit-id --name-status -r SHA_COMMIT
```

Identifikasi file baru, berubah, dihapus, dan dipindahkan.

### 6.3 Baca seluruh diff

```bash
git show --format=fuller --stat --patch --find-renames SHA_COMMIT
```

Jika output panjang, baca berdasarkan file dan bagi menjadi beberapa bagian.

Pastikan seluruh diff sudah dibaca.

Untuk root commit, gunakan:

```bash
git show --root --format=fuller --stat --patch SHA_COMMIT
```

Untuk merge commit, evaluasi perubahan terhadap first parent.

### 6.4 Periksa konteks kode

Jika diff belum cukup:

1. Baca kode sebelum perubahan.
2. Baca kode setelah perubahan.
3. Periksa hubungan dengan fungsi, class, widget, provider, model, dan file terkait.
4. Periksa apakah perubahan masih berlaku pada HEAD target.
5. Periksa apakah commit berikutnya memperbaiki implementasi tersebut.

Gunakan isi commit historis sebagai sumber kebenaran, bukan hanya working tree saat ini.

### 6.5 Catat setiap commit

Sebelum berpindah ke commit berikutnya, catat:

- Tujuan perubahan.
- File yang berubah.
- Implementasi yang ditambahkan.
- Implementasi yang diperbaiki.
- Kesalahan yang ditemukan.
- Pola yang dipertahankan.
- Pelajaran yang diperoleh.
- Kandidat aturan khusus.
- Kandidat aturan global.
- Referensi global dari temuan khusus.
- Hal yang belum terverifikasi.

Jangan melewatkan commit tanpa alasan yang jelas.

## 7. Evaluasi Seluruh Aspek Perubahan Kode

Evaluasi tidak hanya berfokus pada bug.

Periksa seluruh aspek berikut apabila relevan.

### A. Gaya dan konsistensi kode

- Penamaan variabel, fungsi, class, dan file.
- Struktur kode.
- Urutan import.
- Format penulisan.
- Penggunaan konstanta.
- Penggunaan komentar.
- Konsistensi antarfile.
- Keterbacaan kode.
- Kompleksitas yang tidak diperlukan.
- Pola implementasi yang dipertahankan pengguna.

### B. Arsitektur

- Penempatan file.
- Pembagian tanggung jawab.
- Pemisahan lapisan.
- Ketergantungan antarfitur.
- Duplikasi kode.
- Abstraksi yang tidak diperlukan.
- Konsistensi arsitektur.

### C. Bug dan runtime

- Null safety.
- Exception.
- Kesalahan logika.
- Asynchronous.
- Future yang tidak ditangani.
- Lifecycle widget.
- Penggunaan BuildContext.
- Navigasi.
- Race condition.
- Pengelolaan resource.
- Transaksi database.

### D. State management

- Konsistensi state.
- Penggunaan provider.
- Loading dan error.
- Pembaruan state setelah operasi berhasil.
- Rebuild yang tidak diperlukan.
- Sinkronisasi data.

### E. Performa

- Penggunaan memori.
- Operasi berulang.
- Rebuild widget.
- Operasi berat.
- Timer, stream, listener, dan controller.
- Pengelolaan resource.

### F. Database dan data

- Struktur tabel.
- Migrasi.
- CRUD.
- Konsistensi data.
- Transaksi.
- Validasi input.
- Risiko kehilangan data.
- Risiko duplikasi.

### G. UX/UI

- Kejelasan fungsi.
- Hierarki visual.
- Konsistensi desain.
- Responsivitas.
- Ukuran komponen.
- Spacing, padding, dan margin.
- Feedback pengguna.
- Loading dan empty state.
- Error dan peringatan.
- Konfirmasi tindakan.
- Pencegahan double-submit.
- Pengurangan beban kognitif.

### H. SDK, framework, dan package

- Ketersediaan API.
- Konstruktor dan parameter.
- Tipe data.
- API deprecated.
- Kompatibilitas versi.
- Dukungan platform.
- Alternatif API.

### I. Keamanan

- Pengelolaan kredensial.
- Validasi input.
- Autentikasi.
- Otorisasi.
- Data sensitif.
- Logging.
- Penyimpanan data.

### J. Testing

- Unit test.
- Widget test.
- Integration test.
- Keterujian kode.
- Mock dan fake.
- Pengujian perilaku.
- Pemeliharaan kode.

### K. Aspek lainnya

Evaluasi juga perubahan lain yang tidak termasuk daftar di atas jika berpengaruh terhadap kualitas aplikasi.

Jangan menganggap setiap perubahan harus menghasilkan aturan baru.

## 8. Pelajari Standar Implementasi Pengguna

Pelajari pola yang terlihat dari perubahan kode.

Perhatikan:

1. Kode yang diperbaiki.
2. Kode yang sengaja diganti.
3. Pola yang dipertahankan.
4. Perubahan yang berulang.
5. Struktur yang dipilih.
6. Perbaikan bug sebelumnya.
7. Penyempurnaan UX/UI.
8. Cara penggunaan SDK.
9. Pilihan solusi dibandingkan alternatif.
10. Perubahan yang menunjukkan preferensi implementasi.

Bedakan bukti kuat dan bukti pendukung.

**Bukti kuat:**

- Perbaikan kesalahan yang jelas.
- Pola perubahan berulang.
- Instruksi eksplisit pengguna.
- Implementasi yang sesuai aturan yang sudah ada.

**Bukti pendukung:**

- Perubahan satu kali.
- Perapian gaya.
- Pola yang terlihat konsisten.
- Penyempurnaan yang memiliki alasan teknis.

Jangan menyimpulkan keinginan pengguna hanya berdasarkan asumsi.

Jika alasan perubahan tidak diketahui, nyatakan sebagai interpretasi, bukan fakta.

## 9. Evaluasi Riwayat task.md

Bagian ini wajib dilakukan.

Tujuannya adalah mempelajari keputusan pengguna ketika suatu task dibatalkan dan kemudian dihapus dari `task.md`.

Penghapusan task yang berstatus Batal merupakan petunjuk bahwa terdapat perbaikan atau ketentuan yang tidak perlu dipaksakan dalam semua keadaan.

Namun, jangan langsung menganggap seluruh aturan yang berkaitan dengan task tersebut harus dihapus.

### 9.1 Baca task.md saat ini

Baca seluruh isi:

`task.md`

Pahami:

- Kelompok task.
- File terdampak.
- Prioritas.
- Status task.
- Task yang masih dikerjakan.
- Task yang sudah selesai.
- Task yang dibatalkan.

Jangan mengubah file ini.

### 9.2 Periksa perubahan task.md pada commit target

Identifikasi commit yang mengubah `task.md` dalam rentang evaluasi.

Gunakan:

```bash
git log --reverse --format="%H %s" SHA_CHECKPOINT..HEAD_TARGET -- task.md
```

Jika checkpoint belum tersedia, gunakan batas commit awal yang sudah ditentukan.

Untuk setiap commit yang mengubah `task.md`:

1. Baca isi `task.md` sebelum commit.
2. Baca isi `task.md` setelah commit.
3. Identifikasi task yang ditambahkan.
4. Identifikasi task yang statusnya berubah.
5. Identifikasi task yang dihapus.
6. Bandingkan alasan perubahan jika tersedia.

Gunakan:

```bash
git show SHA_COMMIT^:task.md
```

Dan:

```bash
git show SHA_COMMIT:task.md
```

Untuk root commit atau file yang belum tersedia pada parent, sesuaikan pemeriksaan.

### 9.3 Temukan task berstatus Batal yang dihapus

Periksa riwayat task secara berurutan.

Cari task yang:

1. Sebelumnya tercatat dalam `task.md`.
2. Memiliki status `Batal`, `Dibatalkan`, atau status pembatalan yang maknanya sama.
3. Kemudian dihapus dari `task.md`.

Jangan menganggap task yang hanya dihapus berarti dibatalkan.

Bedakan:

- Task selesai kemudian dihapus.
- Task batal kemudian dihapus.
- Task dipindahkan ke dokumen lain.
- Task digabung dengan task lain.
- Task dihapus karena duplikasi.
- Task dihapus karena tidak lagi relevan.

Hanya task yang terbukti pernah berstatus Batal dan kemudian dihapus yang masuk kategori utama evaluasi toleransi.

Jika status tidak dapat dibuktikan, catat sebagai belum terverifikasi.

### 9.4 Pelajari alasan pembatalan

Untuk setiap task yang terbukti dibatalkan:

1. Baca isi task sebelum dihapus.
2. Identifikasi masalah yang ingin diperbaiki.
3. Identifikasi aturan yang berkaitan dengan task tersebut.
4. Baca commit yang mengubah statusnya menjadi Batal.
5. Baca commit yang menghapusnya.
6. Periksa perubahan kode terkait.
7. Periksa perubahan aturan yang terjadi pada periode tersebut.
8. Periksa apakah task dibatalkan karena solusi tidak diperlukan, terlalu berlebihan, berisiko, tidak sesuai kebutuhan, atau alasan lainnya.

Jangan mengarang alasan pembatalan.

Jika alasan tidak tercantum, gunakan konteks commit sebagai bukti pendukung dan tandai tingkat kepastiannya.

### 9.5 Temukan aturan yang boleh ditoleransi

Untuk setiap task Batal yang dihapus, jawab:

- Aturan apa yang berkaitan dengan task tersebut?
- Apakah aturan tersebut terlalu ketat?
- Apakah ada keadaan tertentu ketika aturan tidak perlu diterapkan?
- Apakah solusi yang diusulkan ternyata tidak diperlukan?
- Apakah terdapat alternatif yang lebih sederhana?
- Apakah aturan tersebut masih penting dalam kondisi lain?
- Apakah toleransi berlaku untuk seluruh proyek atau hanya fitur tertentu?

Contoh ilustrasi:

**Aturan awal:**

Setiap fungsi harus memiliki abstraksi terpisah.

**Task yang dibatalkan:**

Memisahkan fungsi sederhana ke beberapa class tambahan.

**Pelajaran:**

Abstraksi tidak wajib dibuat jika hanya menambah kompleksitas tanpa manfaat yang jelas.

**Toleransi yang benar:**

Abstraksi digunakan apabila memberikan manfaat nyata terhadap pemisahan tanggung jawab, penggunaan ulang, atau keterujian kode.

Jangan menganggap contoh tersebut sebagai fakta proyek. Gunakan bukti aktual dari repository.

### 9.6 Jangan menghapus aturan penting secara berlebihan

Task Batal tidak otomatis membuktikan bahwa aturan dasarnya salah.

Bedakan:

1. Aturan yang memang perlu dihapus.
2. Aturan yang perlu diperjelas.
3. Aturan yang perlu diberi pengecualian.
4. Aturan yang tetap berlaku tetapi tidak wajib dalam semua kondisi.
5. Task yang dibatalkan karena tidak relevan dengan kebutuhan proyek.

Utamakan aturan bersyarat dibandingkan penghapusan aturan secara keseluruhan apabila prinsip dasarnya masih bermanfaat.

### 9.7 Simpan hasil evaluasi task

Setiap task yang memenuhi kriteria harus dicatat dengan format:

```markdown
### Task Batal yang Dihapus

- Nama task:
- Kelompok:
- File terkait:
- Status sebelum dihapus:
- Commit perubahan status:
- Commit penghapusan:
- Aturan yang berkaitan:
- Alasan pembatalan:
- Bukti:
- Pelajaran:
- Toleransi yang ditemukan:
- Cakupan toleransi:
- Aturan yang perlu diperbarui:
- Tingkat kepastian:
```

### 9.8 Hubungan dengan aturan global

Untuk setiap toleransi yang ditemukan:

1. Cari prinsip umum di balik keputusan tersebut.
2. Periksa apakah prinsip tersebut relevan untuk proyek Flutter lain.
3. Jika relevan, masukkan sebagai referensi atau aturan bersyarat pada `aturan_bersama.md`.
4. Jika hanya berlaku pada fitur proyek aktif, masukkan ke `aturan_khusus.md`.
5. Jangan memaksakan toleransi khusus menjadi ketentuan global.

**Tujuan bagian ini:** AI harus memahami bukan hanya hal yang wajib dilakukan, tetapi juga hal yang tidak perlu dipaksakan ketika kondisi dan kebutuhan tidak mendukungnya.

## 10. Pemeriksaan Source SDK dan Package

Jika perubahan menggunakan atau mengubah API SDK, framework, widget, atau package:

1. Identifikasi versi Flutter dan Dart.
2. Periksa `pubspec.yaml`.
3. Periksa `pubspec.lock`.
4. Temukan source SDK atau package.
5. Baca deklarasi class, konstruktor, metode, dan parameter.
6. Periksa tipe data serta nilai default.
7. Periksa API deprecated.
8. Periksa dukungan platform.
9. Periksa kompatibilitas versi.

Jangan hanya mengandalkan pengetahuan model atau dokumentasi versi terbaru.

Catat:

- Nama API.
- Versi SDK atau package.
- Path source proyek.
- Path source SDK atau package.
- Hasil verifikasi.
- Bagian yang belum dapat diverifikasi.

Jangan menyatakan API sudah diverifikasi jika source aktual belum diperiksa.

## 11. Klasifikasi Aturan

Setiap temuan harus dipisahkan berdasarkan cakupannya.

### A. Aturan khusus proyek

Path:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan ketentuan yang bergantung pada:

- Fitur proyek.
- Modul tertentu.
- Logika bisnis.
- Struktur direktori.
- Nama model atau tabel.
- Konfigurasi khusus.
- Penggunaan package untuk kebutuhan khusus.
- Keputusan implementasi yang tidak berlaku umum.

### B. Aturan bersama Flutter

Path:

`.agents/rules/global/aturan_bersama.md`

Masukkan prinsip yang dapat diterapkan pada proyek Flutter lainnya.

Contoh:

- Null safety.
- Asynchronous.
- Lifecycle.
- Pengelolaan resource.
- Penanganan exception.
- State management.
- Performa.
- Penggunaan SDK.
- Testing.
- UX/UI umum.
- Keterpeliharaan kode.

### C. Referensi global dari aturan khusus

Meskipun suatu temuan hanya berlaku pada proyek aktif, tetap cari prinsip umum yang mendasarinya.

Contoh:

Temuan khusus: Perhitungan tanggal pada fitur berhenti merokok harus mengabaikan komponen jam ketika menghitung jumlah hari.

Prinsip umum: Perhitungan berbasis tanggal harus mempertimbangkan normalisasi waktu agar hasil tidak bergeser karena perbedaan jam.

Prinsip umum dapat dicatat sebagai referensi atau aturan bersama jika memang bermanfaat.

### D. Referensi dari task Batal

Jika task yang dibatalkan menunjukkan adanya toleransi terhadap suatu aturan:

- Masukkan ke aturan khusus jika cakupannya lokal.
- Masukkan ke referensi aturan bersama jika prinsipnya dapat diterapkan lintas proyek.
- Gunakan ketentuan bersyarat jika aturan tetap penting pada kondisi tertentu.

Jangan menghilangkan informasi toleransi hanya karena tidak dapat dijadikan aturan global.

## 12. Standar Penulisan Aturan

Setiap aturan harus:

1. Menggunakan bahasa Indonesia yang baik dan benar.
2. Memiliki tujuan dan cakupan jelas.
3. Menjelaskan tindakan yang harus dilakukan AI.
4. Menjelaskan larangan apabila diperlukan.
5. Memiliki alasan teknis.
6. Tidak ambigu.
7. Tidak bertentangan dengan aturan lain.
8. Tidak menduplikasi aturan lama.
9. Memiliki sumber temuan.
10. Menyertakan contoh benar dan salah untuk aturan teknis.

Gunakan struktur:

```markdown
## Nama Aturan

**Cakupan:**
Jelaskan kondisi penerapan.

**Aturan wajib:**
1. Ketentuan yang harus diikuti.

**Toleransi dan pengecualian:**
Jelaskan kondisi ketika aturan tidak wajib diterapkan.

**Larangan:**
Jelaskan tindakan yang harus dihindari.

**Alasan:**
Jelaskan masalah yang ingin dicegah.

**Contoh benar:**
```dart
// Implementasi yang benar.
```

**Contoh salah:**
```dart
// Implementasi yang salah.
```

**Sumber evaluasi:**
- Commit:
- File:
- Task terkait jika ada:
```

### 12.1 Contoh benar dan salah

Contoh:

**Benar:**

```dart
if (!context.mounted) return;

Navigator.of(context).pop();
```

**Salah:**

```dart
await prosesAsinkron();

Navigator.of(context).pop();
```

Contoh tersebut hanya ilustrasi. Sesuaikan dengan aturan yang sedang dibuat.

Jangan membuat contoh yang tidak relevan dengan aturan.

### 12.2 Contoh toleransi

Jika aturan memiliki pengecualian, contoh benar dan salah harus mencerminkan kondisi tersebut.

Jelaskan:

- Kondisi normal.
- Kondisi pengecualian.
- Implementasi yang benar ketika pengecualian berlaku.
- Implementasi yang salah ketika aturan dipaksakan tanpa alasan.

Jangan membuat aturan mutlak jika bukti menunjukkan bahwa penerapannya bergantung pada kondisi.

## 13. Audit Konflik dan Duplikasi

Sebelum memperbarui file:

1. Bandingkan dengan aturan lama.
2. Cari aturan yang memiliki tujuan sama.
3. Periksa aturan yang saling bertentangan.
4. Periksa cakupan aturan.
5. Periksa toleransi dan pengecualian.
6. Periksa aturan yang sudah tidak relevan.
7. Periksa aturan yang terlalu kaku.

Jika terdapat konflik:

- Jangan menyembunyikannya.
- Jangan menghapus aturan secara sepihak.
- Periksa maksud dan cakupannya.
- Perjelas redaksi jika konflik berasal dari ambiguitas.
- Pertahankan dan laporkan konflik yang belum dapat diselesaikan.

Tujuan utama adalah membuat aturan yang tepat, bukan memperbanyak aturan.

## 14. Memperbarui Aturan Khusus

Perbarui:

`.agents/rules/proyek/aturan_khusus.md`

Lakukan:

1. Pertahankan aturan lama yang masih relevan.
2. Tambahkan aturan baru berdasarkan bukti.
3. Perbarui aturan yang belum jelas.
4. Tambahkan contoh benar dan salah.
5. Tambahkan toleransi yang ditemukan dari task Batal.
6. Cantumkan sumber commit.
7. Cantumkan path file.
8. Hindari duplikasi.
9. Jelaskan kondisi pengecualian jika diperlukan.

## 15. Memperbarui Aturan Bersama Flutter

Perbarui:

`.agents/rules/global/aturan_bersama.md`

Lakukan:

1. Pertahankan aturan global yang masih relevan.
2. Tambahkan prinsip lintas proyek.
3. Perbaiki redaksi aturan yang ambigu.
4. Ambil prinsip umum dari temuan khusus.
5. Ambil referensi dari task Batal jika relevan.
6. Pisahkan aturan wajib dan referensi.
7. Tambahkan toleransi bersyarat jika diperlukan.
8. Tambahkan contoh benar dan salah.
9. Cantumkan sumber evaluasi.
10. Hindari ketergantungan pada fitur proyek tertentu.

Jangan memaksakan semua temuan menjadi aturan global.

Jika temuan hanya cocok untuk satu proyek, pertahankan sebagai aturan khusus tetapi tetap ambil prinsip umumnya jika tersedia.

## 16. Memperbarui catatan.md

Perbarui:

`catatan.md` di root repository.

Gunakan checkpoint khusus:

`# Commit terakhir yang dievaluasi oleh commands evaluasi_aturan_khusus.md`

Jangan mengubah checkpoint command lain.

### 16.1 Format checkpoint

```markdown
# Commit terakhir yang dievaluasi oleh commands evaluasi_aturan_khusus.md

<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_START -->

- Branch evaluasi:
- HEAD target:
- Commit terakhir yang dievaluasi:
- SHA lengkap:
- Tanggal evaluasi:
- Jumlah commit dievaluasi:
- Status:

<!-- EVALUASI_ATURAN_KHUSUS_CHECKPOINT_END -->
```

Gunakan data aktual.

### 16.2 Riwayat setiap commit

Catat setiap commit secara individual:

```markdown
### Commit: SHA_LENGKAP

- Tanggal:
- Pesan commit:
- File yang berubah:
- Ringkasan evaluasi:
- Temuan penting:
- Aturan khusus yang diperbarui:
- Aturan bersama yang diperbarui:
- Referensi global:
- Task Batal yang berkaitan:
- Status evaluasi:
```

### 16.3 Riwayat task Batal

Tambahkan bagian khusus jika ditemukan:

```markdown
## Riwayat Evaluasi Task Batal

### Task: NAMA_TASK

- Commit status Batal:
- Commit penghapusan:
- Aturan terkait:
- Alasan pembatalan:
- Toleransi yang ditemukan:
- Cakupan toleransi:
- Aturan khusus yang diperbarui:
- Aturan bersama yang diperbarui:
- Status verifikasi:
```

Jangan mencatat task yang hanya dihapus tanpa bukti bahwa sebelumnya berstatus Batal sebagai toleransi.

### 16.4 Ketentuan checkpoint

Checkpoint hanya boleh maju jika:

1. Semua commit target selesai dievaluasi.
2. Semua temuan sudah dicatat.
3. Pemeriksaan task.md selesai.
4. Aturan khusus sudah diperiksa.
5. Aturan bersama sudah diperiksa.
6. Konflik sudah diaudit.
7. Pembentukan AGENTS.md berhasil jika diperlukan.
8. Verifikasi akhir berhasil.

Jika proses terhenti:

- Pertahankan checkpoint sebelumnya.
- Catat progres.
- Tandai commit yang belum selesai.
- Jangan menandai evaluasi seluruh rentang selesai.

Commit baru setelah HEAD target tidak boleh masuk checkpoint sesi ini.

## 17. Pembentukan AGENTS.md

Periksa:

`script/build_rules_context.sh`

Sebelum menjalankan:

1. Baca seluruh script.
2. Pahami input dan output.
3. Periksa apakah script menghasilkan ulang AGENTS.md.
4. Periksa instruksi manual yang tidak tersimpan dalam aturan.
5. Pastikan tidak ada instruksi penting yang hilang.

Jika aman, jalankan:

```bash
bash script/build_rules_context.sh
```

Jika path berbeda, gunakan path aktual yang ditemukan.

Setelah eksekusi:

1. Periksa kode keluar.
2. Baca hasil AGENTS.md.
3. Pastikan aturan khusus tercakup.
4. Pastikan aturan global tercakup.
5. Pastikan toleransi dan pengecualian tidak hilang.
6. Periksa duplikasi.
7. Periksa perubahan dengan `git diff -- AGENTS.md`.

Jika gagal, laporkan. Jangan menganggap pembentukan konteks berhasil.

## 18. Verifikasi Akhir

Jalankan:

```bash
git status --short
```

Pastikan:

- Tidak ada kode aplikasi yang berubah.
- Tidak ada task.md yang berubah.
- Tidak ada script yang berubah.
- Tidak ada konfigurasi aplikasi yang berubah.
- Tidak ada perubahan lokal pengguna yang tertimpa.
- Aturan khusus telah diperiksa.
- Aturan bersama telah diperiksa.
- Contoh benar dan salah tersedia.
- Toleransi task Batal sudah dianalisis.
- Tidak ada duplikasi aturan.
- Tidak ada konflik yang disembunyikan.
- Checkpoint benar.
- Commit baru di luar target tidak dievaluasi.

## 19. Format Laporan Akhir

# Laporan Evaluasi Aturan

## A. Ringkasan

- Branch:
- HEAD target:
- Commit terakhir dievaluasi:
- Jumlah commit:
- Rentang commit:
- Jumlah file diperiksa:
- Status keseluruhan:

## B. Daftar Commit

| No. | SHA | Tanggal | Pesan | Status |
|---|---|---|---|---|

Urutkan dari commit paling lama ke paling baru.

## C. Hasil Evaluasi Per Commit

Untuk setiap commit jelaskan:

- Tujuan perubahan.
- File yang berubah.
- Aspek yang dievaluasi.
- Implementasi yang benar.
- Kesalahan yang ditemukan.
- Pola yang dipertahankan.
- Pelajaran yang diperoleh.

## D. Temuan Kode

Kelompokkan:

1. Gaya kode.
2. Arsitektur.
3. Bug dan runtime.
4. State management.
5. Performa.
6. UX/UI.
7. SDK dan package.
8. Database.
9. Keamanan.
10. Testing.
11. Aspek lainnya.

Cantumkan path dan nomor baris jika tersedia.

## E. Evaluasi task.md

Laporkan:

- Jumlah task yang diperiksa.
- Task yang pernah berstatus Batal.
- Task Batal yang kemudian dihapus.
- Task yang dihapus karena selesai.
- Task yang dihapus karena alasan lain.
- Task yang belum dapat dipastikan statusnya.

Untuk setiap task Batal yang dihapus, jelaskan:

- Nama task.
- Commit perubahan status.
- Commit penghapusan.
- Aturan terkait.
- Alasan pembatalan.
- Toleransi yang ditemukan.
- Bukti.
- Tingkat kepastian.

## F. Aturan Khusus

Path:

`.agents/rules/proyek/aturan_khusus.md`

Laporkan:

- Aturan baru.
- Aturan diperbarui.
- Aturan dipertahankan.
- Toleransi khusus.
- Sumber temuan.

## G. Aturan Bersama Flutter

Path:

`.agents/rules/global/aturan_bersama.md`

Laporkan:

- Prinsip global baru.
- Aturan global diperbarui.
- Referensi umum dari temuan khusus.
- Toleransi yang dapat diterapkan lintas proyek.
- Temuan yang tidak dimasukkan dan alasannya.

## H. Konflik dan Duplikasi

Laporkan aturan yang bertentangan, duplikat, atau belum dapat dipastikan.

## I. Pembentukan AGENTS.md

- Path script:
- Status eksekusi:
- Status verifikasi:
- Kendala:

## J. Checkpoint catatan.md

- Checkpoint sebelumnya:
- HEAD target:
- Checkpoint baru:
- Jumlah commit selesai:
- Jumlah commit belum selesai:
- Status pembaruan:

## K. Kesimpulan

Jelaskan apakah evaluasi meningkatkan standar AI dalam menulis kode.

Bedakan:

- Selesai.
- Selesai dengan temuan.
- Sebagian selesai.
- Belum terverifikasi.
- Gagal.

## 20. Checklist Wajib

### Commit

- [ ] catatan.md sudah dibaca.
- [ ] Checkpoint sudah diperiksa.
- [ ] Maksimal lima commit digunakan jika belum ada checkpoint.
- [ ] HEAD target ditetapkan.
- [ ] Daftar commit target dibekukan.
- [ ] Commit baru setelah target diabaikan.
- [ ] Setiap commit dibaca satu per satu.
- [ ] Seluruh diff diperiksa.

### Evaluasi kode

- [ ] Gaya kode.
- [ ] Arsitektur.
- [ ] Bug dan runtime.
- [ ] State management.
- [ ] Performa.
- [ ] UX/UI.
- [ ] SDK dan package.
- [ ] Database.
- [ ] Keamanan.
- [ ] Testing.
- [ ] Pola implementasi pengguna.

### Evaluasi task

- [ ] task.md dibaca.
- [ ] Riwayat perubahan task.md diperiksa.
- [ ] Task berstatus Batal diidentifikasi.
- [ ] Task Batal yang dihapus ditelusuri.
- [ ] Alasan pembatalan diperiksa.
- [ ] Aturan terkait diidentifikasi.
- [ ] Toleransi dianalisis.
- [ ] Toleransi khusus dan global dipisahkan.
- [ ] Task selesai tidak disalahartikan sebagai task Batal.

### Aturan

- [ ] aturan_khusus.md diperiksa dan diperbarui jika diperlukan.
- [ ] aturan_bersama.md diperiksa dan diperbarui jika diperlukan.
- [ ] Referensi global dari temuan khusus dipertimbangkan.
- [ ] Contoh benar dan salah tersedia.
- [ ] Pengecualian dijelaskan.
- [ ] Konflik dan duplikasi diperiksa.

### Penyelesaian

- [ ] AGENTS.md dibentuk dan diverifikasi.
- [ ] catatan.md diperbarui.
- [ ] Riwayat setiap commit tersimpan.
- [ ] Checkpoint tidak melewati commit yang belum selesai.
- [ ] Tidak ada kode aplikasi yang berubah.
- [ ] task.md tidak berubah.
- [ ] Tidak ada perubahan lokal pengguna yang tertimpa.

## 21. Prinsip Akhir

Jangan hanya mengajarkan AI apa yang harus dilakukan.

AI juga harus memahami:

- Apa yang harus dipertahankan.
- Apa yang harus diperbaiki.
- Apa yang harus dihindari.
- Apa yang tidak perlu dipaksakan.
- Kapan suatu aturan wajib diterapkan.
- Kapan suatu aturan boleh ditoleransi.
- Bagaimana menerapkan pengecualian tanpa merusak standar kualitas.

Aturan khusus menjaga konsistensi proyek.

Aturan bersama menjaga standar lintas proyek Flutter.

Referensi global memastikan pelajaran dari proyek khusus tetap dapat dimanfaatkan pada proyek lainnya.

Riwayat task Batal membantu AI memahami keputusan pengguna dan mencegah AI terus memaksakan perbaikan yang sebelumnya sudah diputuskan untuk tidak dikerjakan.

**Tujuan akhir: AI harus semakin memahami standar, preferensi, keputusan, dan toleransi pengguna sehingga perubahan kode berikutnya semakin tepat dan tidak mengulangi kesalahan sebelumnya.**
