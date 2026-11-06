---
description: Evaluasi 10–15 commit terakhir satu per satu untuk mempelajari standar kode, memperbarui aturan khusus proyek, dan mengambil prinsip yang dapat dikembangkan menjadi aturan bersama seluruh proyek Flutter.
agent: code
---

# EVALUASI ATURAN KHUSUS DAN ATURAN BERSAMA

## 1. TUJUAN

Setiap kali pengguna melakukan pekerjaan penambahan, perbaikan, atau perubahan kode, lakukan evaluasi untuk mempelajari standar implementasi yang diinginkan pengguna.

Evaluasi tidak hanya bertujuan menemukan kesalahan, tetapi juga memahami:
- Gaya dan standar penulisan kode.
- Pola implementasi yang disukai pengguna.
- Keputusan arsitektur dan teknis.
- Cara menangani bug dan runtime.
- Cara mengoptimalkan performa.
- Cara mengelola state, cache, dan data.
- Standar UX/UI.
- Praktik pengembangan yang perlu dipertahankan.
- Kesalahan yang harus dicegah agar tidak terulang.

Hasil evaluasi harus digunakan untuk memperbarui dua file berikut.

### A. Aturan khusus proyek

Path:

`.agents/rules/proyek/aturan_khusus.md`

Berisi aturan yang hanya berlaku pada proyek yang sedang dikerjakan.

### B. Aturan bersama seluruh proyek Flutter

Path:

`.agents/rules/global/aturan_bersama.md`

Berisi aturan dan prinsip implementasi yang dapat digunakan kembali pada seluruh proyek Flutter pengguna.

**Prinsip utama:**

Jangan hanya memindahkan aturan yang sudah jelas berlaku lintas proyek. Evaluasi juga setiap aturan khusus untuk menemukan prinsip umum yang dapat diambil sebagai referensi dan dikembangkan menjadi aturan bersama.

---

# 2. MEMAHAMI KONDISI DAN ATURAN PROYEK

Sebelum melakukan evaluasi:

1. Baca `AGENTS.md` dan aturan utama proyek yang berlaku.
2. Baca aturan yang relevan dalam `.agents/rules/`.
3. Baca seluruh isi `.agents/rules/proyek/aturan_khusus.md` jika tersedia.
4. Baca seluruh isi `.agents/rules/global/aturan_bersama.md` jika tersedia.
5. Pahami arsitektur dan struktur proyek.
6. Identifikasi teknologi, SDK, dan paket yang digunakan.
7. Pahami keputusan implementasi yang sudah ditetapkan pengguna.

Periksa kondisi Git:

```bash
git status --short
git branch --show-current
```

Jangan membuat aturan sebelum memahami aturan yang sudah tersedia.

Jika terdapat aturan yang bertentangan, identifikasi konflik dan jelaskan dampaknya. Jangan menentukan sendiri aturan mana yang harus dihapus atau diubah tanpa dasar yang jelas.

---

# 3. MEMBACA 10–15 COMMIT TERAKHIR

Evaluasi maksimal 15 commit terbaru dari branch aktif.

Ketentuan:

1. Prioritaskan 15 commit terakhir.
2. Jika hanya tersedia 10–14 commit, evaluasi seluruhnya.
3. Jika tersedia kurang dari 10 commit, evaluasi seluruh commit yang tersedia.
4. Jangan membaca seluruh riwayat Git jika jumlahnya melebihi batas tersebut.
5. Jangan mengambil commit dari branch lain yang tidak termasuk dalam riwayat branch aktif.

Gunakan:

```bash
git log -15 --reverse --date=iso --format=fuller
```

## WAJIB membaca setiap commit satu per satu

Jangan hanya membaca pesan, judul, atau ringkasan commit.

Untuk setiap commit:

1. Baca hash commit.
2. Baca tanggal commit.
3. Baca pesan commit.
4. Identifikasi file yang mengalami perubahan.
5. Baca diff perubahan kode.
6. Pahami perubahan sebelum dan sesudah commit.
7. Identifikasi tujuan perubahan berdasarkan bukti.
8. Evaluasi pola implementasi.
9. Pelajari keputusan teknis yang digunakan.
10. Catat standar atau pembelajaran yang dapat digunakan kembali.

Gunakan:

```bash
git show --format=fuller --find-renames --find-copies --stat --patch <hash_commit>
```

Lakukan pemeriksaan secara terpisah untuk setiap commit.

Jika diff terlalu besar, baca berdasarkan file atau bagian kode secara bertahap. Jangan melewatkan perubahan yang termasuk dalam batas evaluasi.

## Cara memperlakukan commit yang sudah selesai

Pengguna membuat commit kecil karena ingin perubahan mudah ditelusuri dan diperbaiki jika terjadi kesalahan.

Karena itu, pahami ketentuan berikut:

1. Anggap perubahan yang sudah di-commit sebagai pekerjaan yang telah diselesaikan dan dianggap fix oleh pengguna.
2. Gunakan implementasi hasil commit sebagai sumber pembelajaran mengenai standar yang diinginkan pengguna.
3. Jangan membuka kembali pekerjaan atau mengubah commit lama.
4. Jangan menganggap setiap pola kode lama otomatis menjadi standar permanen.
5. Perhatikan perkembangan implementasi dari commit lama ke commit baru.
6. Jika commit berikutnya memperbaiki implementasi sebelumnya, pelajari pola implementasi hasil perbaikan tersebut.
7. Jangan menggabungkan beberapa commit menjadi satu evaluasi yang menghilangkan identitas masing-masing perubahan.

**Tujuan evaluasi commit adalah memahami bagaimana pengguna menginginkan kode diimplementasikan, bukan mengulang pekerjaan yang sudah diselesaikan.**

Jangan melakukan amend, reset, rebase, revert, atau operasi lain yang mengubah riwayat Git.

---

# 4. MENGEVALUASI SELURUH ASPEK PERUBAHAN KODE

Jangan hanya mencari bug atau runtime error.

Evaluasi seluruh aspek yang relevan dengan perubahan.

### A. Gaya dan standar penulisan kode

Evaluasi:
- Penamaan variabel, fungsi, class, dan file.
- Keterbacaan kode.
- Konsistensi penulisan.
- Struktur kode.
- Pemilihan fungsi dan metode.
- Penggunaan abstraksi.
- Pola implementasi yang dipertahankan pengguna.
- Kesesuaian dengan konvensi Dart dan Flutter.

### B. Logika dan kebenaran implementasi

Evaluasi:
- Ketepatan logika.
- Kondisi percabangan.
- Pengolahan data.
- Penanganan kondisi khusus.
- Operasi yang tidak diperlukan.
- Dampak perubahan terhadap fungsi lain.

### C. Bug dan runtime

Evaluasi:
- Potensi crash.
- Penanganan null.
- Penanganan exception.
- Proses asynchronous.
- Lifecycle widget.
- Pengelolaan resource.
- Memory leak.
- Potensi kehilangan data.

### D. Arsitektur dan struktur aplikasi

Evaluasi:
- Pembagian tanggung jawab.
- Penempatan file.
- Ketergantungan antarbagian.
- Pemisahan UI, state, dan data.
- Konsistensi arsitektur.
- Penggunaan abstraksi.
- Kompleksitas implementasi.

### E. State management

Evaluasi:
- Penggunaan Provider dan Notifier.
- Ketepatan penggunaan `ref.watch` dan `ref.read`.
- Pemilihan jenis provider.
- Provider family.
- Rebuild widget.
- Pengelolaan state asynchronous.
- Pemisahan state dan logika bisnis.

### F. Performa dan efisiensi

Evaluasi:
- Penggunaan cache.
- Pengolahan data berulang.
- Rebuild widget.
- Pemakaian memori.
- Operasi yang tidak diperlukan.
- Perpindahan halaman dan tab.
- Penggunaan resource.
- Efisiensi query dan penyimpanan data.

### G. UX/UI

Evaluasi:
- Konsistensi desain.
- Kemudahan penggunaan.
- Kejelasan tujuan tombol.
- Feedback tindakan pengguna.
- Loading, error, dan empty state.
- Navigasi.
- Perilaku interaksi.
- Konsistensi tampilan.

### H. Pengelolaan data

Evaluasi:
- Validasi data.
- Pembacaan dan penulisan data.
- Konsistensi data.
- Kegagalan penyimpanan.
- Database.
- Sinkronisasi.
- Cache.
- Penanganan data yang tidak tersedia.

### I. Testing dan pemeliharaan

Evaluasi:
- Kemudahan pengujian.
- Kebutuhan unit test dan widget test.
- Struktur pengujian.
- Kemudahan pemeliharaan.
- Kompleksitas kode.
- Kemungkinan regresi.

### J. Aspek lainnya

Jika ditemukan perubahan yang tidak termasuk kategori di atas, tetap evaluasi sesuai tujuan dan dampaknya.

Jangan memaksakan semua kategori untuk setiap commit. Evaluasi hanya aspek yang berkaitan dengan perubahan.

---

# 5. MENGEVALUASI PERUBAHAN TERKINI

Selain membaca riwayat commit, periksa perubahan yang belum di-commit.

Gunakan:

```bash
git status --short
git diff
git diff --cached
```

Periksa juga file baru yang belum di-track apabila relevan.

Pisahkan evaluasi menjadi:
1. Perubahan yang sudah di-commit.
2. Perubahan yang sudah di-stage.
3. Perubahan yang belum di-stage.
4. File baru yang belum di-track.

Jangan mengubah atau menghapus perubahan pengguna.

Jangan melakukan reset, clean, checkout, atau operasi yang berpotensi menghilangkan pekerjaan pengguna.

Jangan mengubah kode sumber selama menjalankan command ini.

---

# 6. MEMPELAJARI PREFERENSI IMPLEMENTASI PENGGUNA

Tujuan utama evaluasi adalah membuat AI semakin memahami cara pengguna menginginkan kode ditulis dan dikembangkan.

Perhatikan:
1. Pola implementasi yang dipilih dan dipertahankan pengguna.
2. Pola yang diperbaiki pada commit berikutnya.
3. Metode yang sengaja dihindari.
4. Struktur kode yang digunakan secara konsisten.
5. Keputusan teknis yang berulang.
6. Cara pengguna membagi tanggung jawab kode.
7. Cara pengguna mengelola state, cache, data, dan lifecycle.
8. Pola desain dan interaksi UI yang dipertahankan.
9. Perubahan untuk meningkatkan performa.
10. Standar implementasi yang belum terdokumentasi.

Bedakan:
- Preferensi pengguna yang jelas.
- Standar yang terbukti digunakan secara konsisten.
- Perubahan sementara.
- Perbaikan khusus satu kondisi.
- Implementasi lama yang sudah digantikan.
- Praktik yang masih perlu diverifikasi.

Jangan menganggap setiap implementasi yang ditemukan sebagai standar pengguna.

Gunakan riwayat perubahan, aturan yang tersedia, dan kondisi kode sebagai bukti.

Jika alasan perubahan tidak dapat dipastikan, jangan membuat aturan permanen berdasarkan dugaan.

---

# 7. MENGEVALUASI ATURAN KHUSUS PROYEK

Setiap temuan yang layak dijadikan aturan harus diperiksa apakah perlu ditambahkan, diperbarui, dipertahankan, atau tidak perlu dijadikan aturan.

## A. Tambahkan aturan

Jika ditemukan:
- Kesalahan yang berpotensi terulang.
- Pola implementasi yang harus dipertahankan.
- Keputusan teknis yang perlu didokumentasikan.
- Standar kode yang diinginkan pengguna.
- Batasan implementasi yang belum tersedia.

## B. Perbarui aturan

Jika:
- Redaksi aturan lama ambigu.
- Contoh kode tidak sesuai.
- Ruang lingkup aturan belum lengkap.
- Ditemukan standar yang lebih tepat.
- Terdapat pembelajaran baru yang memperjelas aturan.

## C. Hapus aturan

Jangan menghapus aturan secara sembarangan.

Usulkan penghapusan jika:
- Sudah tidak relevan.
- Terbukti keliru.
- Sepenuhnya digantikan aturan lain.
- Bertentangan dengan keputusan terbaru yang sudah dikonfirmasi.

Jelaskan alasan penghapusan.

## D. Tidak perlu dijadikan aturan

Tidak semua perubahan harus menjadi aturan permanen.

Contohnya:
- Perubahan nilai variabel yang hanya berlaku pada satu kondisi.
- Perbaikan typo.
- Perubahan implementasi sementara.
- Detail yang tidak memberikan manfaat untuk pekerjaan berikutnya.

---

# 8. MEMPERBARUI ATURAN KHUSUS PROYEK

Perbarui file:

`.agents/rules/proyek/aturan_khusus.md`

Ketentuan:

1. Baca seluruh isi file sebelum mengedit.
2. Pertahankan aturan lama yang masih relevan.
3. Periksa kemungkinan duplikasi.
4. Periksa konflik dengan aturan lain.
5. Tambahkan aturan yang benar-benar khusus proyek.
6. Gunakan bahasa Indonesia yang baik dan benar.
7. Buat redaksi tegas dan tidak ambigu.
8. Jelaskan tindakan yang wajib dilakukan dan yang harus dihindari.
9. Jangan menambahkan aturan tanpa manfaat nyata.
10. Jangan menghapus aturan lama tanpa alasan yang jelas.

## Format aturan

Setiap aturan teknis yang ditambahkan atau diperbarui wajib memuat:

### Nama aturan

**Tujuan:**

Mengapa aturan diperlukan.

**Aturan:**

Tindakan yang wajib dilakukan dan tindakan yang harus dihindari.

**Contoh benar:**

```dart
// Implementasi yang sesuai dengan aturan.
```

**Contoh salah:**

```dart
// Implementasi yang melanggar aturan.
```

**Alasan:**

Jelaskan perbedaan kedua contoh dan dampaknya.

**Prinsip umum yang dapat dijadikan referensi aturan bersama:**

Tuliskan prinsip yang dapat diambil dari aturan khusus tersebut, jika ada.

Jika tidak terdapat prinsip yang dapat diterapkan lintas proyek, tuliskan:

"Tidak terdapat prinsip umum yang layak dijadikan aturan bersama."

Ketentuan contoh:
- Gunakan Dart atau bahasa yang sesuai dengan proyek.
- Pastikan contoh benar-benar menggambarkan aturan.
- Jangan membuat contoh salah yang sebenarnya valid tanpa menjelaskan konteksnya.
- Gunakan contoh singkat dan mudah dipahami.
- Jangan menggunakan nama class atau variabel khusus proyek jika tidak diperlukan.
- Jika aturan tidak berkaitan dengan kode, gunakan contoh tindakan benar dan salah.

---

# 9. MENGAMBIL REFERENSI DARI ATURAN KHUSUS UNTUK ATURAN BERSAMA

**TAHAP INI WAJIB DILAKUKAN UNTUK SETIAP TEMUAN ATURAN KHUSUS YANG LAYAK DIDOKUMENTASIKAN.**

Jangan berhenti setelah memasukkan suatu temuan ke dalam `aturan_khusus.md`.

Periksa kembali apakah terdapat prinsip, pola pikir, atau pembelajaran yang dapat digunakan pada proyek Flutter lainnya.

Walaupun implementasi teknisnya hanya berlaku untuk satu proyek, prinsip yang mendasarinya mungkin dapat dijadikan aturan bersama.

## Cara melakukan generalisasi

Untuk setiap aturan khusus:

### Langkah 1 — Identifikasi inti permasalahan

Pahami masalah atau kebutuhan yang menyebabkan aturan tersebut diperlukan.

### Langkah 2 — Identifikasi alasan teknis

Cari tahu alasan implementasi tersebut dipilih.

Contohnya:
- Mencegah data tidak konsisten.
- Menghindari rebuild yang tidak diperlukan.
- Mencegah penggunaan resource berlebihan.
- Menjaga pemisahan tanggung jawab.
- Mengurangi risiko runtime error.
- Memudahkan pengujian dan pemeliharaan.

### Langkah 3 — Pisahkan implementasi khusus dengan prinsip umum

Tentukan bagian yang hanya berlaku pada proyek tersebut dan bagian yang dapat digunakan lintas proyek.

### Langkah 4 — Rumuskan prinsip umum

Ubah pembelajaran khusus proyek menjadi ketentuan yang lebih umum tanpa menghilangkan tujuan teknisnya.

### Langkah 5 — Evaluasi kelayakan aturan bersama

Pastikan prinsip tersebut:
- Relevan untuk pengembangan Flutter.
- Bisa diterapkan pada proyek lain.
- Tidak bergantung pada nama class, provider, tabel, atau struktur folder khusus.
- Tidak menimbulkan konflik dengan aturan bersama yang tersedia.
- Memiliki alasan teknis yang benar.

### Langkah 6 — Masukkan prinsip yang layak

Jika terdapat prinsip umum yang layak, tambahkan ke:

`.agents/rules/global/aturan_bersama.md`

Simpan implementasi khususnya di:

`.agents/rules/proyek/aturan_khusus.md`

Jangan sekadar menyalin aturan khusus ke aturan bersama. Lakukan generalisasi terlebih dahulu.

## Contoh proses generalisasi

Misalnya ditemukan aturan khusus proyek:

"Ketika mengambil daftar transaksi, gunakan cache transaksi terlebih dahulu jika data masih valid. Jangan selalu mengambil seluruh data dari database."

Aturan tersebut mungkin hanya berlaku pada sistem transaksi proyek ini.

Namun, prinsip yang bisa diambil adalah:

"Pertimbangkan validitas data cache, kebutuhan pembaruan data, dan sumber data utama sebelum menentukan strategi pengambilan data."

Prinsip tersebut bisa dipertimbangkan menjadi aturan bersama Flutter.

Contoh lainnya:

Aturan khusus proyek:

"Gunakan `transaksiProvider` untuk mengelola daftar transaksi."

Tidak boleh langsung dimasukkan ke aturan bersama karena nama provider tersebut hanya ada pada proyek tertentu.

Namun, prinsip yang bisa diambil:

"Pisahkan pengelolaan state dan pengolahan data dari widget presentasi agar tanggung jawab setiap komponen jelas."

Prinsip ini dapat dievaluasi untuk menjadi aturan bersama.

**Penting:**

Jangan memaksakan generalisasi jika memang tidak ada prinsip yang layak digunakan kembali.

Namun, jangan langsung menyimpulkan suatu aturan hanya berlaku pada satu proyek sebelum mencoba mengidentifikasi prinsip umum di baliknya.

---

# 10. MEMPERBARUI ATURAN BERSAMA

Perbarui file:

`.agents/rules/global/aturan_bersama.md`

File ini merupakan pusat dokumentasi standar dan prinsip yang ingin digunakan bersama pada seluruh proyek Flutter pengguna.

Ketentuan:

1. Pastikan folder `.agents/rules/global/` tersedia.
2. Jika file belum tersedia, buat file tersebut.
3. Jika tersedia, baca seluruh isinya terlebih dahulu.
4. Periksa apakah aturan sudah pernah dicatat.
5. Jangan menambahkan duplikasi.
6. Pertahankan aturan yang masih relevan.
7. Tambahkan prinsip umum yang diperoleh dari evaluasi.
8. Gunakan redaksi yang dapat dipahami dan diterapkan lintas proyek.
9. Jangan memasukkan nama implementasi khusus proyek jika tidak diperlukan.
10. Pastikan setiap aturan memiliki alasan teknis.
11. Pastikan contoh benar dan salah tersedia untuk setiap aturan teknis.
12. Pastikan aturan tidak bertentangan dengan praktik Dart dan Flutter yang benar.

## Sumber aturan bersama

Aturan bersama dapat berasal dari:

1. Standar yang sejak awal sudah berlaku di beberapa proyek.
2. Pembelajaran dari aturan khusus proyek.
3. Pola implementasi yang digunakan secara konsisten.
4. Perbaikan bug yang menghasilkan prinsip pencegahan umum.
5. Keputusan teknis yang dapat diterapkan lintas proyek.
6. Praktik Flutter dan Dart yang sudah diverifikasi secara teknis.

Jangan membatasi sumber aturan bersama hanya pada temuan yang awalnya sudah bersifat umum.

## Prinsip penulisan

Gunakan prinsip umum, bukan implementasi khusus.

Contoh aturan bersama yang tepat:

"Setiap resource yang memiliki lifecycle harus dikelola dan dibersihkan ketika sudah tidak diperlukan."

Contoh aturan yang tidak tepat untuk aturan bersama:

"Pada halaman FormTransaksiPage, gunakan transaksiProvider."

Contoh pertama dapat diterapkan lintas proyek. Contoh kedua hanya berlaku untuk proyek tertentu.

---

# 11. HUBUNGAN ANTARA KEDUA FILE ATURAN

Gunakan pembagian berikut:

| Kondisi temuan | Aturan khusus | Aturan bersama |
|---|---|---|
| Hanya berlaku pada satu proyek | Tambahkan | Ambil prinsip umum jika tersedia |
| Berlaku untuk seluruh proyek Flutter | Tidak perlu diduplikasi | Tambahkan |
| Implementasi khusus dengan prinsip umum | Simpan detail implementasi | Tambahkan prinsip umum |
| Hanya berupa pengecualian proyek | Tambahkan | Tidak perlu mengubah |
| Belum terbukti berlaku lintas proyek | Tambahkan jika relevan | Jangan memaksakan |
| Sudah tersedia di aturan bersama | Simpan detail khusus jika diperlukan | Perbarui hanya jika ada pembelajaran baru |

**Prinsip terpenting:**

Aturan khusus merupakan sumber pengalaman dan pembelajaran dari setiap proyek.

Aturan bersama merupakan kumpulan prinsip terbaik yang berhasil diambil dari berbagai pengalaman tersebut.

Setiap evaluasi harus mempertimbangkan hubungan antara keduanya.

---

# 12. MEMPERTAHANKAN COMMIT KECIL

Pengguna sengaja membuat commit dalam ukuran kecil agar perubahan mudah ditelusuri dan diperbaiki jika ditemukan kesalahan.

Karena itu:

1. Jangan menggabungkan beberapa commit kecil menjadi satu commit besar.
2. Jangan melakukan refactoring besar hanya untuk menyeragamkan kode.
3. Jangan memperluas ruang lingkup pekerjaan tanpa kebutuhan.
4. Jangan mengubah kode yang tidak berkaitan dengan tugas.
5. Pertahankan identitas dan urutan setiap commit.
6. Evaluasi setiap commit secara terpisah.
7. Jangan menjadikan evaluasi sebagai alasan untuk mengubah implementasi historis.
8. Catat sumber pembelajaran berdasarkan hash commit.

Evaluasi aturan tidak boleh menyebabkan ruang lingkup pekerjaan menjadi lebih besar dari yang diperlukan.

---

# 13. PEMERIKSAAN HASIL

Setelah memperbarui kedua file, baca kembali seluruh bagian yang berubah.

Pastikan:

1. Aturan baru berdasarkan hasil evaluasi.
2. Aturan lama yang masih relevan tetap dipertahankan.
3. Tidak ada aturan duplikat.
4. Tidak ada aturan yang bertentangan.
5. Contoh benar dan salah sesuai penjelasan.
6. Aturan khusus benar-benar relevan untuk proyek.
7. Prinsip yang diambil ke aturan bersama sudah digeneralisasi.
8. Aturan bersama benar-benar berlaku lintas proyek Flutter.
9. Tidak ada ketergantungan khusus proyek yang tidak diperlukan.
10. Kedua file tidak saling bertentangan.
11. Path file yang diperbarui benar.

Jangan menyatakan pembaruan berhasil sebelum memeriksa hasil akhirnya.

Jangan mengklaim seluruh proyek otomatis membaca aturan bersama hanya karena file berhasil diperbarui. Mekanisme pemuatan aturan harus diperiksa sesuai konfigurasi Kilo Code yang digunakan.

Jangan mengubah konfigurasi lain secara sembarangan hanya untuk memastikan aturan dimuat.

---

# 14. LAPORAN HASIL EVALUASI

Setelah seluruh evaluasi selesai, berikan laporan berikut.

## A. Commit yang dievaluasi

| No. | Hash commit | Pesan commit | Ringkasan perubahan | Hasil evaluasi |
|---|---|---|---|---|

Tampilkan semua commit yang benar-benar diperiksa.

## B. Perubahan yang belum di-commit

Jelaskan perubahan working tree jika tersedia.

## C. Pembelajaran dari perubahan kode

Jelaskan:
- Standar penulisan yang ditemukan.
- Pola implementasi yang dipertahankan.
- Preferensi pengguna yang teridentifikasi.
- Keputusan teknis yang perlu diikuti.
- Kesalahan yang perlu dicegah.

## D. Pembaruan aturan khusus

| Jenis | Nama aturan | Alasan |
|---|---|---|
| Ditambahkan | Nama aturan | Alasan |
| Diperbarui | Nama aturan | Alasan |
| Dipertahankan | Nama aturan | Alasan |
| Diusulkan dihapus | Nama aturan | Alasan |

## E. Hasil generalisasi aturan khusus

Tampilkan pembelajaran dari aturan khusus yang berhasil diambil sebagai referensi aturan bersama.

| Aturan khusus | Prinsip umum yang ditemukan | Hasil |
|---|---|---|
| Nama aturan | Prinsip yang bisa digunakan ulang | Ditambahkan / Tidak layak |

Bagian ini penting agar pengguna dapat mengetahui bahwa AI tidak sekadar menyimpan aturan khusus, tetapi juga belajar mengambil prinsip yang bermanfaat untuk proyek lainnya.

## F. Pembaruan aturan bersama

| Jenis | Nama aturan | Sumber pembelajaran |
|---|---|---|
| Ditambahkan | Nama aturan | Aturan khusus / commit |
| Diperbarui | Nama aturan | Pembelajaran baru |
| Dipertahankan | Nama aturan | Masih relevan |
| Tidak dimasukkan | Nama aturan | Alasan |

## G. Lokasi file yang diperbarui

Tampilkan path lengkap relatif terhadap root proyek.

```text
.agents/rules/proyek/aturan_khusus.md

.agents/rules/global/aturan_bersama.md
```

Cantumkan hanya file yang benar-benar diubah.

## H. Kesimpulan

Jelaskan:
- Jumlah commit yang dievaluasi.
- Standar implementasi yang dipelajari.
- Aturan khusus yang diperbarui.
- Prinsip umum yang berhasil diambil dari aturan khusus.
- Aturan bersama yang diperbarui.
- Kesalahan yang sekarang memiliki aturan pencegahan.
- Konflik atau keputusan yang masih membutuhkan perhatian pengguna.

---

# 15. BATASAN WAJIB

1. Evaluasi maksimal 15 commit terakhir.
2. Baca setiap commit satu per satu.
3. Jangan hanya mengandalkan pesan commit.
4. Perlakukan commit yang sudah selesai sebagai sumber pembelajaran implementasi pengguna.
5. Jangan mengubah atau membuka kembali commit lama.
6. Jangan menggabungkan commit kecil.
7. Jangan mengubah kode sumber selama menjalankan command ini.
8. Jangan menghapus perubahan pengguna.
9. Jangan menambahkan aturan berdasarkan asumsi.
10. Jangan mengulang aturan yang sudah tersedia.
11. Jangan membuat contoh kode yang menyesatkan.
12. Jangan memasukkan detail khusus proyek ke aturan bersama.
13. Jangan mengabaikan prinsip umum yang dapat diambil dari aturan khusus.
14. Jangan memaksakan generalisasi yang tidak memiliki dasar teknis.
15. Jangan menimpa aturan lama tanpa alasan.
16. Jangan melakukan refactoring yang tidak berkaitan.
17. Jangan mengklaim pembaruan berhasil sebelum memeriksa hasilnya.
18. Jangan mengklaim seluruh proyek telah membaca aturan bersama sebelum mekanisme pemuatannya dipastikan.

---

# HASIL AKHIR YANG DIHARAPKAN

Setiap pekerjaan penambahan atau perbaikan kode harus memberikan pembelajaran untuk pekerjaan berikutnya.

AI harus semakin memahami:

- Cara pengguna menginginkan kode ditulis.
- Standar implementasi yang perlu dipertahankan.
- Pola implementasi yang harus dihindari.
- Keputusan teknis yang telah ditetapkan.
- Praktik Flutter yang berlaku lintas proyek.
- Ketentuan khusus setiap proyek.
- Prinsip umum yang dapat diambil dari pengalaman proyek tertentu.

Aturan khusus menjadi tempat menyimpan pengalaman dan keputusan setiap proyek.

Aturan bersama menjadi tempat mengumpulkan prinsip terbaik dari pengalaman seluruh proyek Flutter.

Jangan hanya memindahkan aturan yang sudah umum. Pelajari juga aturan yang tampaknya khusus, kemudian ambil prinsip dasarnya jika memang dapat memberikan manfaat pada proyek lain.

Dengan demikian, setiap proyek tidak hanya belajar dari kesalahannya sendiri, tetapi juga dapat memperoleh pembelajaran dari proyek lainnya.

Tujuan akhirnya adalah meningkatkan konsistensi, kualitas, dan kesesuaian implementasi AI dengan standar yang diinginkan pengguna, sekaligus mempertahankan perubahan kecil yang mudah ditinjau dan ditelusuri.