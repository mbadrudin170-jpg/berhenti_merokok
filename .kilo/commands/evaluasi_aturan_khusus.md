---
description: Evaluasi 5 commit terakhir untuk menyempurnakan aturan khusus dan global Flutter berdasarkan perubahan kode yang telah di-commit.
agent: code
---

# Prompt: Evaluasi dan Penyempurnaan Aturan Kode

## Tujuan

Evaluasi 5 commit terakhir yang sudah tercatat dalam riwayat Git untuk memahami pola perubahan kode, menemukan kesalahan, dan mengidentifikasi standar implementasi yang sesuai dengan keinginan pengguna.

Berdasarkan hasil evaluasi tersebut:

1. Tambahkan atau perbarui aturan khusus proyek pada `.agents/rules/proyek/aturan_khusus.md`.
2. Tambahkan atau perbarui aturan global Flutter pada `.agents/rules/global/aturan_bersama.md` jika temuan dapat diterapkan pada seluruh proyek Flutter.
3. Sertakan contoh kode yang benar dan salah agar AI memahami implementasi yang diharapkan dan kesalahan yang harus dihindari.
4. Jalankan `script/build_rules_context.sh` untuk memperbarui konteks aturan pada `AGENTS.md`.

Tujuan akhirnya adalah mencegah AI mengulangi kesalahan implementasi yang pernah terjadi dan membuat AI semakin memahami standar kode yang diinginkan pengguna.

---

## 1. Batasan sumber evaluasi

**Hanya gunakan riwayat commit yang sudah tercatat dalam Git sebagai sumber evaluasi.**

Ketentuan:

- Baca tepat 5 commit terakhir.
- Jangan membaca perubahan yang belum di-commit.
- Jangan mengevaluasi perubahan staged maupun unstaged.
- Jangan menggunakan `git diff`, `git diff --cached`, atau perintah lain untuk membaca perubahan lokal yang belum di-commit.
- Jangan menjadikan isi file lokal yang belum di-commit sebagai dasar kesimpulan.
- Jangan mengasumsikan perubahan lokal sama dengan isi commit terakhir.

Gunakan perintah berikut untuk mendapatkan 5 commit terakhir:

```bash
git log -5 --format="%H %s"
```

Jika jumlah commit dalam repository kurang dari 5, evaluasi seluruh commit yang tersedia dan laporkan jumlah sebenarnya.

## 2. Baca setiap commit satu per satu

Setelah mendapatkan daftar commit, baca masing-masing commit secara berurutan.

Gunakan perintah:

```bash
git show --format=fuller --stat --patch --find-renames HASH_COMMIT
```

Ganti `HASH_COMMIT` dengan hash commit yang sedang diperiksa.

Ketentuan:

1. Jangan hanya membaca pesan commit.
2. Baca perubahan kode dalam setiap commit sampai selesai.
3. Periksa file yang diubah, kode sebelum perubahan, dan kode sesudah perubahan jika diperlukan untuk memahami konteks.
4. Jangan melewatkan commit hanya karena perubahan terlihat sederhana.
5. Jangan menggabungkan seluruh commit menjadi satu evaluasi tanpa memeriksa masing-masing commit terlebih dahulu.
6. Catat temuan dari setiap commit secara terpisah sebelum membuat kesimpulan keseluruhan.

Jika output terlalu panjang, gunakan pemeriksaan bertahap sampai seluruh perubahan dalam commit tersebut selesai dibaca.

## 3. Evaluasi seluruh perubahan kode dalam commit

Evaluasi perubahan kode secara menyeluruh, bukan hanya mencari bug.

Periksa aspek-aspek berikut jika relevan dengan perubahan yang ditemukan:

### A. Kualitas implementasi

- Apakah implementasi sudah sesuai dengan tujuan fitur?
- Apakah struktur dan penempatan kode sudah tepat?
- Apakah terdapat implementasi yang tidak diperlukan?
- Apakah terdapat duplikasi kode?
- Apakah terdapat abstraksi yang tidak diperlukan?
- Apakah kode mudah dipahami dan dipelihara?

### B. Bug dan runtime

- Apakah terdapat potensi bug?
- Apakah terdapat kesalahan logika?
- Apakah terdapat kondisi yang dapat menyebabkan aplikasi crash?
- Apakah penanganan error sudah tepat?
- Apakah pengelolaan state dan lifecycle sudah benar?
- Apakah terdapat potensi memory leak atau resource yang tidak dilepas?

### C. Performa

- Apakah implementasi menyebabkan pekerjaan yang tidak diperlukan?
- Apakah terdapat proses berulang yang seharusnya dapat dihindari?
- Apakah pengelolaan widget dan state sudah efisien?
- Apakah terdapat potensi rebuild berlebihan?
- Apakah implementasi sudah mempertimbangkan penggunaan memori?

### D. Konsistensi kode

- Apakah penulisan kode konsisten?
- Apakah penamaan variabel, fungsi, class, dan file sudah tepat?
- Apakah implementasi mengikuti pola yang digunakan dalam proyek?
- Apakah terdapat perubahan gaya penulisan yang tidak sesuai dengan standar proyek?

### E. UX/UI

Jika perubahan berkaitan dengan tampilan atau interaksi pengguna, evaluasi:

- Kemudahan penggunaan.
- Kejelasan fungsi setiap komponen.
- Konsistensi tampilan.
- Kejelasan informasi dan status proses.
- Penanganan kondisi loading, kosong, berhasil, dan gagal.
- Kenyamanan interaksi pengguna.

### F. Aspek lainnya

Jangan membatasi evaluasi pada daftar di atas. Evaluasi aspek lain jika ditemukan masalah atau pola implementasi yang perlu dijadikan aturan.

**Penting:** Jangan membuat aturan berdasarkan asumsi. Setiap temuan harus memiliki bukti dari perubahan kode dalam commit yang diperiksa.

## 4. Identifikasi pola dan keinginan pengguna

Perhatikan pola perubahan yang dilakukan pengguna dalam 5 commit terakhir.

Cari tahu:

- Kesalahan implementasi yang diperbaiki.
- Pola kode yang diubah menjadi lebih baik.
- Gaya penulisan yang dipertahankan atau disesuaikan.
- Implementasi yang dihindari oleh pengguna.
- Standar arsitektur dan struktur kode yang terlihat dari perubahan.
- Perilaku aplikasi yang diharapkan pengguna.
- Pola keputusan teknis yang berulang.

Gunakan pola tersebut untuk memahami standar implementasi yang diinginkan pengguna.

Jangan menganggap setiap perubahan sebagai aturan baru. Pastikan perubahan tersebut memang menunjukkan kebutuhan, standar, atau pelajaran yang layak dipertahankan.

## 5. Perbarui aturan khusus proyek

Simpan aturan yang hanya relevan untuk proyek saat ini di:

`.agents/rules/proyek/aturan_khusus.md`

Ketentuan:

1. Tambahkan aturan baru jika ditemukan standar atau kesalahan yang perlu dicegah agar tidak terulang.
2. Perbarui aturan yang sudah ada jika ditemukan penyempurnaan.
3. Jangan menambahkan aturan yang hanya berupa kesimpulan umum tanpa bukti.
4. Jangan menghapus aturan lama yang masih relevan.
5. Periksa aturan yang sudah ada sebelum menambahkan aturan baru.
6. Hindari aturan duplikat atau aturan yang memiliki maksud sama.
7. Jika aturan lama bertentangan dengan temuan baru, evaluasi keduanya berdasarkan bukti commit dan konteks proyek.
8. Jangan mengubah maksud aturan lama tanpa alasan yang jelas.

Tujuan aturan khusus adalah memastikan AI tidak mengulangi kesalahan implementasi yang pernah terjadi pada proyek tersebut, termasuk ketika AI mengubah atau memperbaiki kode di kemudian hari.

## 6. Sertakan contoh kode benar dan salah

Setiap aturan teknis yang membutuhkan contoh implementasi harus memiliki contoh kode yang benar dan salah.

Gunakan format berikut:

### Aturan: [Nama aturan]

**Tujuan:**

Jelaskan kesalahan yang ingin dicegah dan perilaku implementasi yang diharapkan.

**Contoh yang salah:**

```dart
// Contoh implementasi yang tidak sesuai
```

**Contoh yang benar:**

```dart
// Contoh implementasi yang sesuai
```

**Alasan:**

Jelaskan perbedaan kedua contoh dan mengapa implementasi yang benar harus digunakan.

Ketentuan:

- Contoh harus relevan dengan aturan yang sedang dijelaskan.
- Contoh salah harus menggambarkan kesalahan yang benar-benar perlu dihindari.
- Contoh benar harus menunjukkan implementasi yang sesuai dengan standar proyek.
- Jangan membuat contoh yang terlalu sederhana sehingga tidak menjelaskan maksud aturan.
- Jangan menggunakan kode fiktif yang tidak sesuai dengan API atau pola Flutter/Dart yang sebenarnya.
- Jangan menambahkan contoh kode yang tidak diperlukan untuk aturan tersebut.

## 7. Evaluasi kemungkinan menjadi aturan global

Selain memperbarui aturan khusus, evaluasi setiap temuan untuk menentukan apakah prinsipnya dapat diterapkan pada seluruh proyek Flutter.

File tujuan:

`.agents/rules/global/aturan_bersama.md`

Ketentuan:

1. Periksa setiap temuan dari 5 commit terakhir.
2. Tentukan apakah temuan hanya berlaku untuk proyek saat ini atau memiliki prinsip yang dapat digunakan di proyek Flutter lainnya.
3. Jika dapat diterapkan secara umum, masukkan prinsipnya ke aturan global.
4. Jika hanya berlaku untuk proyek saat ini, pertahankan sebagai aturan khusus.
5. Jangan memaksakan aturan khusus menjadi aturan global.
6. Jangan menyalin aturan khusus secara mentah ke aturan global.
7. Jika prinsip dari aturan khusus dapat digunakan secara global, rumuskan ulang agar tidak bergantung pada nama file, fitur, class, atau struktur proyek tertentu.
8. Pastikan aturan global tidak bertentangan dengan aturan global yang sudah ada.
9. Hindari duplikasi dan pertahankan aturan global yang masih relevan.

### Prinsip pengambilan referensi global

Walaupun suatu temuan hanya dapat diterapkan secara langsung pada proyek saat ini, tetap evaluasi apakah ada prinsip umum di balik temuan tersebut yang dapat dijadikan referensi aturan global.

Contoh:

- Aturan khusus: Fungsi tertentu pada modul proyek harus menggunakan pola penanganan error yang sudah ditetapkan proyek.
- Referensi global: Setiap proyek Flutter perlu memiliki pola penanganan error yang konsisten dan mudah ditelusuri.

Jangan menyalin contoh tersebut sebagai aturan otomatis. Gunakan hanya sebagai gambaran cara mengabstraksikan prinsip khusus menjadi prinsip umum.

## 8. Periksa konsistensi seluruh aturan

Sebelum menyelesaikan perubahan:

1. Baca isi `.agents/rules/proyek/aturan_khusus.md`.
2. Baca isi `.agents/rules/global/aturan_bersama.md`.
3. Periksa apakah aturan baru sudah tercakup dalam aturan lama.
4. Periksa apakah terdapat aturan yang bertentangan.
5. Periksa apakah ada aturan yang terlalu umum sehingga dapat menimbulkan penafsiran berbeda.
6. Pastikan contoh kode benar dan salah sesuai dengan aturan yang dijelaskan.
7. Pastikan aturan khusus tidak masuk ke global tanpa proses abstraksi.
8. Pastikan aturan global tetap relevan untuk proyek Flutter lainnya.

Jika tidak ditemukan temuan yang layak menjadi aturan baru, jangan membuat aturan hanya untuk memenuhi jumlah tertentu.

## 9. Perbarui AGENTS.md

Setelah evaluasi dan pembaruan kedua file aturan selesai, jalankan:

```bash
script/build_rules_context.sh
```

Tujuannya adalah memperbarui konteks aturan yang digunakan AI melalui `AGENTS.md`.

Ketentuan:

1. Jalankan script tersebut setelah seluruh pembaruan aturan selesai.
2. Jangan mengganti fungsi script dengan mengedit `AGENTS.md` secara manual.
3. Periksa hasil pembaruan `AGENTS.md`.
4. Pastikan aturan khusus dan global yang relevan sudah tercakup sesuai mekanisme script.
5. Jika script gagal, periksa penyebabnya dan laporkan. Jangan menganggap pembaruan berhasil.
6. Jangan mengubah isi `AGENTS.md` secara manual untuk menutupi kegagalan script.

## 10. Verifikasi akhir

Sebelum menyelesaikan pekerjaan, pastikan:

- Lima commit terakhir sudah diperiksa satu per satu, atau seluruh commit yang tersedia jika jumlahnya kurang dari lima.
- Tidak ada perubahan lokal yang belum di-commit yang digunakan sebagai bahan evaluasi.
- Semua temuan memiliki dasar dari perubahan kode yang diperiksa.
- Aturan khusus sudah ditambahkan atau diperbarui jika memang diperlukan.
- Aturan global sudah dievaluasi berdasarkan kemungkinan penerapannya pada proyek Flutter lainnya.
- Referensi prinsip umum dari temuan khusus sudah dipertimbangkan.
- Contoh kode benar dan salah sudah disertakan pada aturan teknis yang membutuhkannya.
- Tidak ada aturan duplikat atau konflik yang belum diselesaikan.
- `script/build_rules_context.sh` sudah dijalankan.
- Hasil pembaruan `AGENTS.md` sudah diperiksa.

## 11. Laporan hasil

Setelah selesai, berikan laporan yang mencakup:

### A. Riwayat commit yang dievaluasi

- Daftar 5 commit yang diperiksa.
- Hash dan pesan setiap commit.
- Ringkasan perubahan yang ditemukan.

### B. Hasil evaluasi

- Kesalahan atau potensi masalah yang ditemukan.
- Pola implementasi yang perlu dipertahankan.
- Standar kode yang dapat disimpulkan dari perubahan.

### C. Pembaruan aturan khusus

- Aturan yang ditambahkan.
- Aturan yang diperbarui.
- Alasan setiap perubahan.

### D. Pembaruan aturan global

- Aturan global yang ditambahkan atau diperbarui.
- Referensi prinsip umum yang diperoleh dari temuan khusus.
- Alasan mengapa aturan tersebut dapat diterapkan pada proyek Flutter lainnya.

### E. Pembaruan AGENTS.md

- Status eksekusi `script/build_rules_context.sh`.
- Hasil pemeriksaan `AGENTS.md`.
- Kendala jika terjadi kegagalan.

Jika tidak ada perubahan aturan yang diperlukan, jelaskan alasannya. Jangan mengklaim pekerjaan berhasil jika belum diverifikasi.

---

## 12. Larangan dan prinsip utama

- Dilarang membaca atau mengevaluasi perubahan yang belum di-commit.
- Dilarang menggunakan perubahan staged maupun unstaged sebagai sumber evaluasi.
- Dilarang melewatkan salah satu dari 5 commit terakhir tanpa alasan yang jelas.
- Dilarang membuat aturan berdasarkan asumsi.
- Dilarang menambahkan aturan yang tidak memiliki dasar dari hasil evaluasi.
- Dilarang menyalin aturan khusus ke aturan global tanpa mengevaluasi prinsip umumnya.
- Dilarang menghapus aturan lama yang masih relevan.
- Dilarang membuat aturan duplikat.
- Dilarang mengubah maksud aturan yang sudah ada tanpa alasan yang jelas.
- Dilarang menganggap script berhasil jika belum dijalankan dan diverifikasi.

**Prinsip akhir:** Gunakan riwayat commit sebagai bahan pembelajaran untuk menyempurnakan aturan proyek dan standar global Flutter. Setiap aturan harus memiliki tujuan yang jelas, dapat dipahami AI, dan membantu mencegah kesalahan implementasi terulang.
