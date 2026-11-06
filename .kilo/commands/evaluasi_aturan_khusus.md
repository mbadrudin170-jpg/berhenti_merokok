---
description: Evaluasi 10–15 commit terakhir dan perubahan kode untuk mempelajari standar implementasi, mencegah kesalahan berulang, serta memperbarui aturan khusus proyek dan aturan bersama seluruh proyek Flutter.
agent: code
---

# EVALUASI ATURAN KHUSUS DAN ATURAN BERSAMA

## TUJUAN

Setiap kali pengguna menyelesaikan pekerjaan penambahan, perbaikan, atau perubahan kode, lakukan evaluasi untuk mempelajari standar implementasi yang diinginkan pengguna.

Evaluasi mencakup seluruh aspek perubahan kode, bukan hanya bug atau error. Perhatikan juga gaya penulisan, struktur, arsitektur, logika, performa, UX/UI, pengelolaan data, dan keputusan teknis lainnya.

Hasil evaluasi harus digunakan untuk memperbarui dokumentasi aturan agar:

1. Kesalahan yang sama tidak terulang pada pekerjaan berikutnya.
2. AI memahami standar penulisan kode yang diinginkan pengguna.
3. AI mempertahankan keputusan implementasi yang sudah ditetapkan.
4. AI semakin konsisten ketika mengembangkan proyek.
5. Aturan yang berlaku lintas proyek tidak perlu ditulis berulang kali pada setiap proyek.

Terdapat dua lokasi penyimpanan aturan.

### A. Aturan khusus proyek

Path:

`.agents/rules/proyek/aturan_khusus.md`

Digunakan untuk menyimpan:

- Keputusan arsitektur khusus proyek.
- Ketentuan implementasi khusus proyek.
- Pola pengolahan data khusus proyek.
- Aturan bisnis aplikasi.
- Ketentuan struktur folder.
- Preferensi implementasi yang hanya berlaku pada proyek tersebut.
- Pengecualian terhadap aturan bersama.

### B. Aturan bersama seluruh proyek Flutter

Path:

`.agents/rules/global/aturan_bersama.md`

Digunakan untuk menyimpan:

- Standar Dart dan Flutter.
- Standar penulisan kode yang digunakan bersama.
- Praktik pengembangan Flutter yang berlaku lintas proyek.
- Standar penanganan bug dan runtime.
- Prinsip optimasi performa.
- Standar pengelolaan resource.
- Standar UX/UI yang berlaku pada semua aplikasi.
- Ketentuan teknis lain yang dapat diterapkan pada seluruh proyek Flutter pengguna.

**Prinsip utama:** Jangan memasukkan aturan yang hanya berlaku untuk satu proyek ke dalam aturan bersama. Sebaliknya, jangan menyimpan aturan yang sebenarnya berlaku untuk seluruh proyek Flutter hanya ke dalam aturan khusus proyek.

---

# TAHAP 1 — MEMAHAMI ATURAN DAN KONDISI PROYEK

Sebelum melakukan evaluasi:

1. Baca `AGENTS.md` atau aturan utama proyek.
2. Baca aturan yang relevan di dalam `.agents/rules/`.
3. Baca seluruh isi `.agents/rules/proyek/aturan_khusus.md` jika tersedia.
4. Baca seluruh isi `.agents/rules/global/aturan_bersama.md` jika tersedia.
5. Pahami arsitektur dan struktur proyek.
6. Identifikasi framework, SDK, dan paket yang digunakan.
7. Pahami keputusan implementasi yang sudah ditetapkan.

Periksa kondisi Git:

```bash
git status --short
git branch --show-current
```

Tujuannya agar evaluasi tidak bertentangan dengan keputusan teknis maupun standar yang sudah berlaku.

Jangan menganggap implementasi salah hanya karena berbeda dari kebiasaan AI.

Gunakan aturan proyek, preferensi pengguna, kondisi kode, dan bukti teknis sebagai dasar evaluasi.

Jika terdapat aturan yang saling bertentangan, identifikasi konflik dan jelaskan dampaknya. Jangan menghapus atau mengubah aturan secara sembarangan.

---

# TAHAP 2 — MEMBACA 10–15 COMMIT TERAKHIR

Evaluasi riwayat perubahan Git dengan batas maksimal 15 commit terakhir dari branch aktif.

Ketentuan:

1. Ambil maksimal 15 commit terbaru.
2. Jika tersedia 10–14 commit, evaluasi seluruhnya.
3. Jika tersedia kurang dari 10 commit, evaluasi semua commit yang tersedia.
4. Jangan membaca seluruh riwayat Git jika melebihi batas tersebut.
5. Jangan mengambil commit dari branch lain yang tidak termasuk dalam riwayat branch aktif.

Gunakan:

```bash
git log -15 --format=fuller
```

## WAJIB membaca setiap commit satu per satu

Jangan hanya membaca judul, pesan, atau ringkasan commit.

Evaluasi setiap commit secara terpisah.

Untuk memudahkan pemahaman perkembangan implementasi, ambil 15 commit terbaru kemudian baca secara berurutan dari commit yang lebih lama menuju commit yang lebih baru.

Untuk setiap commit:

1. Baca hash commit.
2. Baca tanggal commit.
3. Baca pesan commit.
4. Periksa file yang diubah.
5. Baca seluruh diff perubahan kode.
6. Pahami implementasi sebelum perubahan.
7. Pahami implementasi setelah perubahan.
8. Identifikasi tujuan perubahan berdasarkan bukti.
9. Evaluasi pola implementasi yang digunakan.
10. Catat pembelajaran yang relevan.

Gunakan:

```bash
git show --format=fuller --find-renames --find-copies --stat --patch <hash_commit>
```

Jalankan pemeriksaan untuk setiap hash commit secara terpisah.

Jangan menggabungkan beberapa commit menjadi satu evaluasi yang tidak membedakan sumber perubahannya.

Jika diff terlalu besar, baca per file atau bagian kode secara bertahap. Pastikan semua perubahan yang termasuk dalam batas evaluasi tetap diperiksa.

Jika menemukan merge commit, evaluasi perubahan terhadap first parent agar perubahan yang masuk melalui merge tetap dapat diperiksa.

## Cara memahami commit yang sudah dibuat

Pengguna sengaja membuat commit kecil karena perubahan lebih mudah ditelusuri dan diperbaiki apabila terdapat kesalahan.

Karena itu, pahami ketentuan berikut:

1. Anggap perubahan yang sudah di-commit sebagai pekerjaan atau tahap perubahan yang telah diselesaikan oleh pengguna.
2. Evaluasi commit untuk mempelajari standar dan keputusan implementasi, bukan untuk membuka kembali pekerjaan tersebut.
3. Jangan menganggap pola kode yang ada pada setiap commit otomatis menjadi standar permanen.
4. Periksa perkembangan perubahan dari commit lama ke commit baru.
5. Jika commit berikutnya memperbaiki implementasi sebelumnya, gunakan implementasi yang sudah diperbaiki sebagai acuan.
6. Jangan mengubah, menghapus, atau memperbaiki commit historis.
7. Jangan melakukan amend, reset, rebase, revert, atau operasi lain yang mengubah riwayat Git.

Jika menemukan indikasi kesalahan pada implementasi yang sudah di-commit, catat sebagai temuan evaluasi. Jangan langsung mengubah kode lama.

**Penting:** Status committed menunjukkan bahwa tahap pekerjaan telah diselesaikan dalam alur kerja pengguna. Status tersebut bukan bukti mutlak bahwa setiap keputusan teknis sudah benar. Karena itu, evaluasi tetap diperlukan sebelum mengambil kesimpulan dan membentuk aturan.

---

# TAHAP 3 — MENGEVALUASI SELURUH ASPEK PERUBAHAN KODE

Jangan hanya mencari bug atau error.

Evaluasi seluruh aspek yang relevan dengan perubahan, termasuk:

## A. Gaya dan standar penulisan kode

Periksa:

- Penamaan variabel, fungsi, class, dan file.
- Keterbacaan kode.
- Konsistensi struktur kode.
- Pemilihan fungsi dan metode.
- Penggunaan abstraksi.
- Pola implementasi yang digunakan pengguna.
- Kesesuaian dengan standar Dart dan Flutter.

Perhatikan pola yang berulang karena dapat menunjukkan preferensi implementasi pengguna.

## B. Logika dan kebenaran implementasi

Periksa:

- Ketepatan logika.
- Kondisi percabangan.
- Pengolahan data.
- Kemungkinan hasil yang tidak sesuai.
- Proses yang sebenarnya tidak diperlukan.
- Dampak perubahan terhadap fungsi lainnya.

## C. Bug dan runtime

Periksa:

- Potensi crash.
- Penanganan null.
- Penanganan exception.
- Proses asynchronous.
- Lifecycle widget.
- Pengelolaan resource.
- Memory leak.
- Potensi kehilangan data.

## D. Arsitektur dan struktur aplikasi

Periksa:

- Pembagian tanggung jawab.
- Penempatan file.
- Ketergantungan antarbagian.
- Pemisahan UI, state, dan data.
- Konsistensi arsitektur.
- Penggunaan abstraksi.
- Kompleksitas implementasi.

## E. State management

Periksa:

- Ketepatan penggunaan Provider dan Notifier.
- `ref.watch` dan `ref.read`.
- Pemilihan jenis provider.
- Penggunaan provider family.
- Rebuild widget yang tidak diperlukan.
- Pengelolaan state asynchronous.
- Pemisahan state dan logika bisnis.

## F. Performa dan efisiensi

Periksa:

- Penggunaan cache.
- Pengolahan data berulang.
- Rebuild widget.
- Pemakaian memori.
- Operasi yang tidak diperlukan.
- Perpindahan halaman dan tab.
- Penggunaan resource secara berlebihan.
- Efisiensi query dan penyimpanan data.

## G. UX/UI

Periksa:

- Konsistensi desain.
- Kemudahan penggunaan.
- Kejelasan tujuan tombol.
- Feedback terhadap tindakan pengguna.
- Loading, error, dan empty state.
- Navigasi.
- Perilaku interaksi.
- Konsistensi tampilan.

## H. Pengelolaan data

Periksa:

- Validasi data.
- Pembacaan dan penulisan data.
- Konsistensi data.
- Penanganan kegagalan penyimpanan.
- Database.
- Sinkronisasi.
- Cache.
- Penanganan data yang tidak tersedia.

## I. Testing dan pemeliharaan

Periksa:

- Kemudahan pengujian.
- Kebutuhan unit test dan widget test.
- Struktur pengujian.
- Kemudahan pemeliharaan.
- Kompleksitas kode.
- Kemungkinan regresi.

## J. Aspek lainnya

Jika terdapat perubahan yang tidak termasuk kategori di atas, tetap lakukan evaluasi sesuai dampaknya.

Jangan memaksakan semua kategori untuk setiap commit. Evaluasi berdasarkan aspek yang benar-benar berkaitan dengan perubahan.

---

# TAHAP 4 — MENGEVALUASI PERUBAHAN TERKINI

Selain membaca commit, evaluasi juga perubahan pada working tree.

Gunakan:

```bash
git status --short
git diff
git diff --cached
```

Periksa juga file baru yang belum di-track jika berkaitan dengan pekerjaan kode.

Pisahkan hasil evaluasi menjadi:

1. Perubahan yang sudah di-commit.
2. Perubahan yang sudah di-stage.
3. Perubahan yang belum di-stage.
4. File baru yang belum di-track.

Ketentuan:

- Jangan menganggap perubahan yang belum di-commit sebagai pekerjaan yang sudah disetujui.
- Jangan mengubah atau menghapus perubahan pengguna.
- Jangan melakukan reset, clean, checkout, atau operasi yang berpotensi menghilangkan pekerjaan pengguna.
- Jangan mengubah kode sumber selama menjalankan evaluasi.

Jika working tree bersih, lanjutkan berdasarkan riwayat commit.

---

# TAHAP 5 — MEMPELAJARI PREFERENSI IMPLEMENTASI PENGGUNA

Tujuan evaluasi bukan hanya menemukan kesalahan, tetapi juga mempelajari cara pengguna menginginkan kode ditulis.

Perhatikan:

1. Pola implementasi yang dipilih dan dipertahankan pengguna.
2. Pola yang diperbaiki pada commit berikutnya.
3. Metode yang sengaja dihindari.
4. Struktur kode yang digunakan secara konsisten.
5. Keputusan teknis yang berulang.
6. Cara pengguna membagi tanggung jawab kode.
7. Cara pengguna mengelola state, cache, data, dan lifecycle.
8. Pola desain dan interaksi UI yang dipertahankan.
9. Perubahan yang dilakukan untuk meningkatkan performa.
10. Standar implementasi yang sebelumnya belum terdokumentasi.

Bedakan antara:

- Preferensi yang jelas dari keputusan pengguna.
- Standar yang terbukti digunakan secara konsisten.
- Perubahan sementara.
- Perbaikan khusus satu kondisi.
- Implementasi lama yang sudah digantikan.
- Praktik yang perlu diverifikasi secara teknis.

Jangan menjadikan setiap kode lama sebagai standar pengguna.

Jika alasan perubahan tidak dapat dipastikan, tandai sebagai belum terkonfirmasi. Jangan membuat aturan permanen berdasarkan dugaan.

---

# TAHAP 6 — MENENTUKAN PENEMPATAN ATURAN

Setiap temuan yang layak dijadikan aturan harus dievaluasi penempatannya.

## A. Aturan khusus proyek

Masukkan ke:

`.agents/rules/proyek/aturan_khusus.md`

Jika aturan berkaitan dengan:

- Kebutuhan bisnis aplikasi tertentu.
- Struktur folder khusus proyek.
- Arsitektur khusus proyek.
- Alur pengolahan data tertentu.
- Konfigurasi database khusus proyek.
- Integrasi API tertentu.
- Keputusan teknis yang tidak berlaku pada proyek lain.
- Pengecualian implementasi yang hanya diperlukan proyek tersebut.

## B. Aturan bersama Flutter

Masukkan ke:

`.agents/rules/global/aturan_bersama.md`

Jika aturan:

- Berlaku pada seluruh proyek Flutter pengguna.
- Berkaitan dengan standar Dart dan Flutter.
- Dapat digunakan kembali pada berbagai proyek.
- Tidak bergantung pada kebutuhan bisnis satu proyek.
- Tidak bertentangan dengan standar teknis yang benar.
- Memberikan manfaat nyata pada konsistensi, keamanan, kualitas, performa, atau pemeliharaan.

Contoh kategori aturan bersama:

1. Standar penulisan Dart.
2. Penggunaan widget Flutter.
3. Lifecycle widget.
4. Penanganan asynchronous.
5. Penanganan error dan exception.
6. Pengelolaan resource dan dispose.
7. Optimasi rebuild.
8. Prinsip state management.
9. Penggunaan cache.
10. Standar UX/UI bersama.
11. Testing Flutter.
12. Penggunaan SDK dan dependency.
13. Pencegahan memory leak.
14. Keamanan aplikasi.

Daftar tersebut merupakan kategori evaluasi, bukan perintah untuk menambahkan semua kategori secara otomatis.

## C. Aturan khusus paket atau teknologi

Jika aturan berkaitan dengan paket tertentu, jangan langsung memasukkannya sebagai aturan khusus proyek.

Periksa apakah:

- Paket tersebut digunakan pada seluruh proyek pengguna.
- Aturannya dapat diterapkan secara kondisional ketika paket tersebut digunakan.
- Prinsipnya sebenarnya merupakan praktik umum Flutter.
- Aturannya hanya relevan untuk satu implementasi tertentu.

Contoh:

Aturan umum:

"Jangan melakukan pekerjaan berat secara sinkron pada UI thread."

Dapat menjadi aturan bersama.

Aturan paket:

"Gunakan `ref.watch` untuk mengamati perubahan provider dalam build widget."

Dapat menjadi aturan bersama jika ditulis dengan ruang lingkup yang jelas untuk proyek yang menggunakan Riverpod.

Aturan khusus:

"Gunakan `transaksiProvider` untuk mengelola transaksi aplikasi ini."

Termasuk aturan khusus proyek.

## D. Ketentuan ketika aturan dapat masuk ke dua tempat

Jika satu temuan memiliki prinsip umum dan implementasi khusus:

1. Simpan prinsip umumnya di `aturan_bersama.md`.
2. Simpan detail implementasi atau pengecualiannya di `aturan_khusus.md`.
3. Jangan menyalin seluruh isi aturan bersama ke aturan khusus.
4. Pastikan kedua aturan tidak bertentangan.

Contoh:

Aturan bersama:
"Setiap resource yang memiliki lifecycle harus dikelola dengan benar dan dibersihkan ketika tidak diperlukan."

Aturan khusus:
"Pada halaman pemutar audio proyek ini, controller audio harus dihentikan dan di-dispose ketika halaman tidak lagi digunakan."

## E. Jangan membuat aturan berdasarkan asumsi

Sebelum memindahkan aturan ke kategori bersama, pastikan prinsipnya memang dapat digunakan lintas proyek.

Jika perilaku teknis Flutter atau Dart belum jelas, verifikasi berdasarkan dokumentasi resmi atau sumber SDK yang sesuai dengan versi proyek.

Jika ruang lingkupnya belum jelas, jangan memaksakan penempatan. Catat sebagai temuan yang perlu dipastikan.

---

# TAHAP 7 — MEMPERBARUI ATURAN KHUSUS PROYEK

Perbarui:

`.agents/rules/proyek/aturan_khusus.md`

Ketentuan:

1. Baca seluruh isi file sebelum mengedit.
2. Pertahankan aturan lama yang masih relevan.
3. Jangan menghapus aturan tanpa alasan.
4. Periksa kemungkinan duplikasi.
5. Periksa konflik dengan aturan lainnya.
6. Tambahkan standar yang benar-benar khusus proyek.
7. Gunakan bahasa Indonesia yang baik dan benar.
8. Gunakan kalimat yang tegas dan tidak ambigu.
9. Jelaskan tindakan yang wajib dilakukan dan yang dilarang.
10. Pastikan aturan memiliki manfaat nyata untuk pekerjaan berikutnya.

## Format aturan

Setiap aturan teknis yang ditambahkan atau diperbarui wajib menggunakan format:

### Nama aturan

**Tujuan:**

Jelaskan mengapa aturan diperlukan.

**Aturan:**

Jelaskan tindakan yang wajib dilakukan dan tindakan yang harus dihindari.

**Contoh benar:**

```dart
// Implementasi yang sesuai dengan aturan.
```

**Contoh salah:**

```dart
// Implementasi yang melanggar aturan.
```

**Alasan:**

Jelaskan perbedaan implementasi dan dampak yang ditimbulkan.

Ketentuan contoh:

- Gunakan bahasa pemrograman yang sesuai.
- Contoh harus menggambarkan aturan secara langsung.
- Jangan membuat contoh salah yang sebenarnya masih valid untuk kondisi tertentu tanpa menjelaskan konteksnya.
- Jangan menggunakan contoh yang menyesatkan.
- Pastikan contoh benar sesuai standar proyek.
- Gunakan contoh pendek dan mudah dipahami.
- Jangan menggunakan nama class atau variabel yang hanya ada dalam proyek jika tidak diperlukan.

Jika aturan bukan aturan teknis yang dapat ditunjukkan menggunakan kode, gunakan contoh tindakan benar dan salah sebagai penggantinya.

---

# TAHAP 8 — MEMPERBARUI ATURAN BERSAMA

Perbarui:

`.agents/rules/global/aturan_bersama.md`

File ini merupakan tempat penyimpanan standar yang ingin digunakan bersama pada seluruh proyek Flutter pengguna.

Ketentuan:

1. Pastikan folder `.agents/rules/global/` tersedia.
2. Jika file belum tersedia, buat file tersebut.
3. Jika file tersedia, baca seluruh isinya terlebih dahulu.
4. Periksa apakah aturan yang akan ditambahkan sudah tersedia.
5. Jangan mengulang aturan yang sama.
6. Pertahankan aturan bersama yang masih relevan.
7. Jangan memasukkan kebutuhan bisnis satu proyek.
8. Jangan memasukkan konfigurasi khusus satu proyek.
9. Gunakan redaksi yang dapat diterapkan secara konsisten.
10. Pastikan setiap aturan teknis memiliki contoh benar dan salah.
11. Periksa kesesuaian aturan dengan versi Flutter, Dart, dan paket yang digunakan.
12. Jangan menambahkan aturan yang membatasi pilihan implementasi tanpa alasan teknis yang jelas.

## Prinsip penulisan aturan bersama

Tuliskan prinsip umum, bukan nama implementasi khusus proyek.

Contoh yang benar:

"Jangan menjalankan operasi asynchronous yang bergantung pada lifecycle widget tanpa memastikan widget masih aktif sebelum menggunakan context."

Contoh yang kurang tepat untuk aturan bersama:

"Pada halaman FormTransaksiPage, gunakan transaksiProvider untuk mengambil data transaksi."

Contoh pertama dapat diterapkan pada berbagai proyek Flutter. Contoh kedua hanya relevan untuk proyek yang memiliki halaman dan provider tersebut.

## Pengelolaan aturan yang sudah tersedia

Jika aturan yang ditemukan memiliki kesamaan dengan aturan lama:

- Perbarui aturan lama jika ruang lingkupnya sama.
- Tambahkan bagian baru jika memang memiliki tujuan berbeda.
- Jangan membuat aturan duplikat hanya karena ditemukan pada proyek lain.
- Jangan mengubah makna aturan yang sudah berlaku tanpa alasan teknis.

Jika aturan bersama memerlukan pengecualian untuk proyek tertentu, simpan pengecualian tersebut pada `aturan_khusus.md`.

---

# TAHAP 9 — MEMPERTAHANKAN COMMIT KECIL

Pengguna sengaja membuat commit dalam ukuran kecil agar perubahan mudah ditelusuri dan diperbaiki jika terjadi kesalahan.

Karena itu:

1. Jangan menggabungkan beberapa commit kecil menjadi satu commit besar.
2. Jangan menyarankan refactoring besar hanya untuk menyeragamkan kode.
3. Jangan memperluas ruang lingkup pekerjaan tanpa kebutuhan.
4. Jangan mengubah kode yang tidak berkaitan dengan tugas.
5. Pertahankan keterlacakan perubahan.
6. Evaluasi setiap commit secara terpisah.
7. Jangan menjadikan evaluasi aturan sebagai alasan untuk mengubah implementasi lama.
8. Pisahkan pembelajaran setiap perubahan berdasarkan sumber commit-nya.

Evaluasi harus membantu mempertahankan kualitas pekerjaan, bukan menambah kompleksitas yang tidak diperlukan.

---

# TAHAP 10 — MEMERIKSA HASIL PEMBARUAN

Setelah memperbarui kedua file aturan, baca kembali isi file yang berubah.

Pastikan:

1. Aturan baru berdasarkan hasil evaluasi.
2. Aturan lama yang relevan tetap dipertahankan.
3. Tidak ada duplikasi.
4. Tidak ada aturan yang bertentangan.
5. Contoh benar dan salah sesuai dengan penjelasan.
6. Aturan bersama benar-benar berlaku lintas proyek Flutter.
7. Aturan khusus tidak salah dimasukkan ke aturan bersama.
8. Aturan bersama tidak memuat ketergantungan yang tidak diperlukan.
9. Pengecualian khusus proyek tidak bertentangan dengan prinsip bersama.
10. Path file yang diperbarui benar.

Jangan menyatakan pembaruan berhasil jika belum memeriksa hasil akhirnya.

Jangan mengklaim bahwa aturan sudah otomatis diterapkan oleh semua proyek hanya karena file berhasil dibuat. Pastikan mekanisme pemuatan aturan yang berlaku pada proyek-proyek pengguna memang membaca file tersebut.

Jika mekanisme pemuatan belum diketahui, laporkan kondisi tersebut tanpa mengubah konfigurasi secara sembarangan.

---

# TAHAP 11 — LAPORAN HASIL EVALUASI

Setelah seluruh pekerjaan selesai, berikan laporan dengan struktur berikut.

## 1. Riwayat commit yang dievaluasi

| No. | Hash commit | Pesan commit | Ringkasan perubahan | Hasil evaluasi |
| --- | ----------- | ------------ | ------------------- | -------------- |

Tampilkan seluruh commit yang benar-benar dibaca.

## 2. Perubahan terbaru

Jelaskan perubahan yang belum di-commit jika tersedia.

## 3. Pembelajaran dari perubahan

Jelaskan:

- Standar penulisan yang ditemukan.
- Pola implementasi yang dipertahankan.
- Keputusan teknis yang perlu diikuti.
- Kesalahan yang perlu dicegah.
- Praktik yang harus dihindari.

## 4. Pembaruan aturan khusus proyek

| Jenis perubahan         | Nama aturan | Alasan |
| ----------------------- | ----------- | ------ |
| Ditambahkan             | Nama aturan | Alasan |
| Diperbarui              | Nama aturan | Alasan |
| Dipertahankan           | Nama aturan | Alasan |
| Diusulkan untuk dihapus | Nama aturan | Alasan |

## 5. Pembaruan aturan bersama

| Jenis perubahan  | Nama aturan | Alasan                            |
| ---------------- | ----------- | --------------------------------- |
| Ditambahkan      | Nama aturan | Berlaku lintas proyek             |
| Diperbarui       | Nama aturan | Penyempurnaan standar             |
| Dipertahankan    | Nama aturan | Masih relevan                     |
| Tidak dimasukkan | Nama aturan | Khusus proyek atau belum terbukti |

## 6. Lokasi file yang diperbarui

Tampilkan path lengkap relatif terhadap root proyek.

Contoh:

```text
.kilo/commands/evaluasi_aturan_khusus.md

.agents/rules/proyek/aturan_khusus.md

.agents/rules/global/aturan_bersama.md
```

Tampilkan hanya file yang benar-benar dibuat atau diubah selama pekerjaan.

## 7. Kesimpulan

Jelaskan:

- Jumlah commit yang dievaluasi.
- Standar implementasi yang berhasil dipelajari.
- Aturan khusus yang diperbarui.
- Aturan bersama yang diperbarui.
- Kesalahan yang sekarang memiliki aturan pencegahan.
- Konflik atau keputusan yang masih memerlukan perhatian pengguna.

---

# BATASAN WAJIB

1. Evaluasi maksimal 15 commit terakhir.
2. Baca setiap commit satu per satu.
3. Jangan hanya mengandalkan pesan commit.
4. Jangan menganggap seluruh pola kode lama sebagai standar pengguna.
5. Jangan membuka kembali atau mengubah commit lama.
6. Jangan menggabungkan commit kecil.
7. Jangan mengubah kode sumber selama menjalankan command ini.
8. Jangan menghapus perubahan pengguna.
9. Jangan menambahkan aturan berdasarkan asumsi.
10. Jangan mengulang aturan yang sudah tersedia.
11. Jangan membuat contoh kode yang menyesatkan.
12. Jangan memasukkan aturan khusus proyek ke aturan bersama.
13. Jangan menyimpan aturan lintas proyek Flutter hanya di aturan khusus.
14. Jangan menimpa aturan lama tanpa alasan.
15. Jangan melakukan refactoring yang tidak berkaitan.
16. Jangan mengklaim pembaruan berhasil sebelum memeriksa hasilnya.
17. Jangan mengklaim semua proyek sudah menggunakan aturan bersama sebelum mekanisme pemuatannya dipastikan.
18. Jangan memaksakan penambahan aturan jika tidak ada pembelajaran baru yang layak didokumentasikan.

---

# HASIL AKHIR YANG DIHARAPKAN

Setiap pekerjaan penambahan atau perbaikan kode harus memberikan pembelajaran yang dapat digunakan kembali.

AI harus semakin memahami:

- Cara pengguna menginginkan kode ditulis.
- Standar implementasi yang harus dipertahankan.
- Pola kode yang harus dihindari.
- Keputusan teknis yang sudah ditetapkan.
- Praktik Flutter yang berlaku pada semua proyek.
- Ketentuan khusus yang hanya berlaku pada proyek tertentu.

Aturan khusus berfungsi sebagai dokumentasi pengalaman masing-masing proyek.

Aturan bersama berfungsi sebagai pusat standar pengembangan Flutter yang digunakan pada seluruh proyek pengguna.

Dengan demikian, setiap proyek dapat berkembang berdasarkan pengalaman sebelumnya tanpa harus mengulang kesalahan yang sama.

Tujuan akhirnya adalah meningkatkan kualitas dan konsistensi pekerjaan AI, menjaga perubahan tetap kecil dan mudah ditelusuri, serta memastikan implementasi semakin sesuai dengan keinginan pengguna.
