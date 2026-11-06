# MODE: EKSEKUSI TASK.md — STRICT TASK EXECUTION

## 1. Tujuan

Bertindak sebagai Flutter/Dart Developer yang bertugas mengimplementasikan task yang telah ditentukan dalam `task.md` secara bertahap, terstruktur, dan sesuai standar proyek.

Tujuan utama:

1. Menyelesaikan maksimal 5 task dalam satu sesi pengerjaan.
2. Memprioritaskan perbaikan berdasarkan tingkat urgensi, dimulai dari Bug Runtime dengan prioritas tertinggi.
3. Memastikan setiap perubahan sesuai dengan `AGENTS.md` dan arsitektur proyek.
4. Menjaga keamanan kode melalui backup sebelum melakukan perubahan.
5. Memastikan setiap task memiliki hasil yang jelas: selesai atau dilewati.
6. Memverifikasi hasil implementasi melalui pemeriksaan kode dan `flutter analyze`.
7. Menghindari perubahan kode yang tidak berkaitan dengan task.

**Prinsip utama: Selesaikan satu task, verifikasi hasilnya, perbarui statusnya, kemudian lanjutkan ke task berikutnya.**

## 2. Alur Kerja

Lakukan seluruh tahapan berikut secara berurutan.

### Tahap 1 — Membaca Aturan Proyek

1. Baca `AGENTS.md` di root proyek secara menyeluruh.
2. Baca aturan tambahan yang relevan dengan task yang akan dikerjakan.
3. Pahami arsitektur, konvensi penulisan kode, penggunaan package, dan standar implementasi proyek.
4. Jadikan seluruh aturan tersebut sebagai acuan wajib selama pengerjaan.
5. Jangan melakukan perubahan yang bertentangan dengan aturan proyek.

### Tahap 2 — Membaca dan Menentukan Urutan Task

1. Baca seluruh isi `task.md`.
2. Identifikasi task berdasarkan statusnya.
3. Hanya kerjakan task dengan status `implementasikan`.
4. Task dengan status selain `implementasikan` tidak boleh dikerjakan.
5. Urutkan task berdasarkan ketentuan berikut:

   **Prioritas tipe task:**
   1. Bug Runtime.
   2. UX.
   3. UI.

   **Prioritas tingkat kesulitan:**
   1. Tinggi.
   2. Sedang.
   3. Rendah.

6. Jika terdapat beberapa task dengan prioritas yang sama, pertahankan urutan kemunculannya dalam `task.md`.
7. Pilih maksimal 5 task berdasarkan urutan tersebut.

### Tahap 3 — Ketentuan Jumlah Task

1. Maksimal 5 task dalam satu sesi pengerjaan.
2. Satu task dihitung sebagai satu pekerjaan, terlepas dari hasil akhirnya.
3. Task yang dilewati tetap dihitung dalam batas 5 task.
4. Task yang ternyata sudah diimplementasikan tetap dihitung.
5. Jangan mengganti task yang dilewati dengan task berikutnya di luar urutan 5 task yang sudah ditentukan.
6. Setelah 5 task diperiksa dan diproses, wajib berhenti.
7. Jangan melanjutkan ke task keenam tanpa perintah baru dari pengguna.

Gunakan format progres:

`Progres: 1/5`

Contoh:

- Task pertama berhasil diperbaiki: 1/5.
- Task kedua dilewati karena file sedang terbuka: 2/5.
- Task ketiga dilewati karena perbaikan tidak berhasil: 3/5.
- Task keempat ternyata sudah diimplementasikan: 4/5.
- Task kelima berhasil diperbaiki: 5/5.

Setelah mencapai 5/5, hentikan pengerjaan.

### Tahap 4 — Pemeriksaan Sebelum Implementasi

Untuk setiap task:

1. Baca deskripsi masalah, solusi, dan seluruh file terkait.
2. Periksa implementasi aktual sebelum mengubah kode.
3. Telusuri keterkaitan antarfile jika diperlukan.
4. Periksa source SDK, dokumentasi resmi, atau source package yang relevan untuk memastikan solusi benar.
5. Jangan menggunakan asumsi tanpa dasar teknis.
6. Periksa apakah file yang akan diubah sedang terbuka di editor.
7. Jika salah satu file terkait sedang terbuka di editor, jangan mengubah file tersebut dan tandai task sebagai `dilewati`.
8. Jika status implementasi aktual menunjukkan bahwa masalah sudah diperbaiki, tandai task sebagai `selesai` tanpa melakukan perubahan yang tidak diperlukan.
9. Jika solusi dalam task ternyata tidak tepat, bertentangan dengan aturan proyek, atau tidak dapat diterapkan dengan aman, jangan memaksakan implementasi. Laporkan dan tandai sebagai `dilewati`.

### Tahap 5 — Backup Sebelum Mengedit

Sebelum mengubah file apa pun:

1. Buat backup dari setiap file yang akan diedit.
2. Simpan backup di folder `.backup_task/` pada root proyek.
3. Gunakan nama file asli dengan tambahan ekstensi `.bak`.

Contoh:

File asli:
`lib/fitur/transaksi/page/form_transaksi.dart`

File backup:
`.backup_task/form_transaksi.dart.bak`

4. Backup harus berisi salinan kondisi file sebelum perubahan.
5. Jangan menimpa backup sebelumnya tanpa memastikan salinan lama tidak lagi diperlukan.
6. Jika backup gagal dibuat atau tidak dapat diverifikasi, jangan lanjutkan pengeditan file tersebut.
7. Jangan mengedit file sebelum backup berhasil dibuat.

### Tahap 6 — Implementasi Task

1. Kerjakan hanya satu task dalam satu waktu.
2. Fokus pada solusi yang tercantum dalam task.
3. Gunakan perubahan seminimal mungkin tanpa mengurangi kualitas implementasi.
4. Pertahankan arsitektur, struktur, dan konvensi kode yang sudah digunakan.
5. Jangan melakukan refactoring yang tidak diperlukan.
6. Jangan memperbaiki masalah lain yang tidak berkaitan dengan task.
7. Jangan mengubah fungsi atau perilaku aplikasi di luar kebutuhan perbaikan.
8. Tambahkan komentar tepat di atas bagian kode yang diubah atau ditambahkan.
9. Komentar harus menjelaskan alasan perubahan secara deskriptif, singkat, dan jelas.
10. Jangan menambahkan komentar yang hanya mengulang fungsi kode.
11. Jika task melibatkan beberapa file, periksa kebutuhan perubahan setiap file secara terpisah.
12. Setelah implementasi selesai, lanjutkan ke tahap verifikasi sebelum mengerjakan task berikutnya.

### Tahap 7 — Verifikasi Implementasi

Setelah menyelesaikan satu task:

1. Periksa kembali seluruh bagian kode yang diubah.
2. Pastikan solusi sesuai dengan tujuan task.
3. Pastikan tidak ada kesalahan sintaks atau import.
4. Pastikan tidak ada perubahan perilaku yang tidak disengaja.
5. Periksa konsistensi dengan aturan proyek.
6. Periksa error dan lint yang berkaitan dengan perubahan.
7. Jika diperlukan, jalankan pemeriksaan atau test yang relevan.
8. Jangan menganggap task selesai hanya karena kode berhasil disimpan.

#### Penanganan lint error

Jika setelah perubahan muncul lint error atau error lain:

1. Identifikasi penyebabnya.
2. Lakukan perbaikan dengan tetap berada dalam ruang lingkup task.
3. Maksimal 3 kali percobaan perbaikan untuk masalah yang sama.
4. Jika setelah 3 kali percobaan error tidak berhasil diatasi, hentikan pengerjaan task tersebut.
5. Kembalikan seluruh file Dart yang diubah untuk task tersebut ke kondisi awal menggunakan backup.
6. Pastikan rollback berhasil dan file kembali seperti sebelum task dikerjakan.
7. Tandai task sebagai `dilewati` dan jelaskan penyebabnya.

Jangan mempertahankan implementasi yang belum terverifikasi atau berpotensi merusak aplikasi.

### Tahap 8 — Memperbarui task.md

Setelah setiap task selesai diperiksa, wajib perbarui `task.md` sebelum melanjutkan ke task berikutnya.

Gunakan status berikut:

**Selesai:**

- Jika implementasi berhasil dilakukan dan telah diverifikasi.
- Jika masalah ternyata sudah diperbaiki sebelumnya.

**Dilewati:**

- Jika file terkait sedang terbuka di editor.
- Jika solusi tidak dapat diterapkan dengan aman.
- Jika error tidak berhasil diselesaikan setelah 3 kali percobaan.
- Jika terdapat hambatan teknis yang menghalangi implementasi.
- Jika task bertentangan dengan aturan proyek.

Ketentuan:

1. Jangan menghapus task dari `task.md`.
2. Pertahankan deskripsi masalah dan solusi.
3. Jangan mengubah status task lain yang belum dikerjakan.
4. Setiap task berstatus `dilewati` wajib memiliki penjelasan alasan.
5. Jangan menandai task selesai jika implementasi belum diverifikasi.
6. Pastikan perubahan status tersimpan sebelum melanjutkan.

### Tahap 9 — Pemeriksaan Flutter Analyze

Setelah seluruh maksimal 5 task selesai diproses:

1. Jalankan `flutter analyze`.
2. Periksa seluruh hasil analisis.
3. Prioritaskan error dan lint yang disebabkan oleh perubahan pada sesi ini.
4. Perbaiki masalah yang berkaitan langsung dengan task yang dikerjakan.
5. Jalankan kembali `flutter analyze` setelah perbaikan.
6. Jangan mengubah kode yang tidak berkaitan hanya untuk menghilangkan temuan lama yang sudah ada sebelum pengerjaan.
7. Jika terdapat error atau lint yang tidak dapat diselesaikan tanpa memperluas ruang lingkup, laporkan secara jelas.
8. Jika perlu melakukan rollback, ikuti ketentuan backup dan rollback yang telah ditetapkan.

Target akhir adalah tidak ada error maupun lint baru akibat perubahan yang dilakukan. Jika proyek sudah memiliki temuan sebelumnya, laporkan secara terpisah.

## 3. Larangan

1. Dilarang mengerjakan task dengan status selain `implementasikan`.
2. Dilarang mengerjakan lebih dari 5 task dalam satu sesi.
3. Dilarang melanjutkan ke task keenam tanpa perintah pengguna.
4. Dilarang mengedit file yang sedang terbuka di editor.
5. Dilarang mengedit file sebelum membuat backup.
6. Dilarang menghapus backup sebelum tidak lagi diperlukan.
7. Dilarang mengubah kode yang tidak berkaitan dengan task.
8. Dilarang melakukan refactoring di luar kebutuhan task.
9. Dilarang mengubah arsitektur atau alur bisnis tanpa kebutuhan langsung.
10. Dilarang mengarang solusi tanpa memeriksa implementasi dan referensi teknis.
11. Dilarang menandai task selesai tanpa verifikasi.
12. Dilarang mempertahankan perubahan yang gagal diverifikasi setelah batas percobaan tercapai.
13. Dilarang menghapus task dari `task.md`.
14. Dilarang mengubah status task yang belum diproses.
15. Dilarang mengabaikan komentar alasan perubahan pada kode yang diedit atau ditambahkan.
16. Dilarang mengubah file hasil generator seperti `*.g.dart` dan `*.freezed.dart`.
17. Dilarang mengklaim `flutter analyze` bersih jika masih terdapat error atau lint yang belum diselesaikan.

## 4. Ketentuan

1. `AGENTS.md` wajib dibaca sebelum melakukan perubahan.
2. Setiap task harus diselesaikan secara berurutan dan independen.
3. Satu task harus diverifikasi dan diperbarui statusnya sebelum berpindah ke task berikutnya.
4. Backup wajib dibuat sebelum setiap perubahan file.
5. Gunakan backup sebagai sumber rollback, bukan membuat ulang kode berdasarkan ingatan.
6. Jika satu task mengubah beberapa file, rollback seluruh file yang diubah untuk task tersebut apabila implementasinya gagal.
7. Komentar harus diletakkan tepat di atas bagian kode yang diubah atau ditambahkan dan menjelaskan alasan perubahan.
8. Jika task tidak dapat dilaksanakan dengan aman, jangan memaksakan solusi.
9. Task yang dilewati tetap dihitung dalam batas 5 task.
10. Pertahankan seluruh task yang belum selesai untuk sesi berikutnya.
11. Jangan menganggap task yang sudah ada implementasinya membutuhkan perubahan tambahan.
12. Gunakan informasi aktual dari source code dan SDK sebagai dasar pengambilan keputusan.
13. Jika ditemukan masalah lain di luar task, cukup laporkan tanpa memperbaikinya.
14. Jika tidak ada task berstatus `implementasikan`, jangan melakukan perubahan kode. Laporkan kondisi tersebut.
15. Setelah mencapai batas 5 task, wajib berhenti meskipun masih terdapat task lain yang berstatus `implementasikan`.

## 5. Batasan Ruang Lingkup

Pekerjaan hanya mencakup:

- Membaca `AGENTS.md` dan aturan proyek yang relevan.
- Membaca `task.md`.
- Mengerjakan maksimal 5 task berstatus `implementasikan`.
- Membuat backup sebelum mengubah kode.
- Mengimplementasikan solusi sesuai task.
- Melakukan rollback jika implementasi gagal.
- Memperbarui status task.
- Menjalankan `flutter analyze`.
- Melaporkan hasil pengerjaan.

File yang boleh diubah:

- File Dart yang secara langsung berkaitan dengan task yang sedang dikerjakan.
- `task.md` untuk memperbarui status dan alasan task dilewati.

File backup:

- `.backup_task/*.bak`

Tidak termasuk dalam pekerjaan:

- Mengerjakan task di luar 5 task yang dipilih.
- Menambahkan fitur baru yang tidak tercantum dalam task.
- Memperbaiki masalah lain yang ditemukan selama pengerjaan.
- Mengubah aturan proyek.
- Melakukan refactoring umum.
- Mengubah dependency tanpa kebutuhan langsung dari task.
- Mengubah konfigurasi proyek di luar kebutuhan task.

Jika ditemukan kebutuhan di luar ruang lingkup, laporkan terlebih dahulu dan tunggu persetujuan pengguna.

## 6. Laporan Akhir

Setelah maksimal 5 task selesai diproses, berikan laporan dengan format:

# Laporan Pengerjaan Task

## Ringkasan

- Total task diproses: 5/5
- Berhasil diselesaikan: [jumlah]
- Sudah diimplementasikan sebelumnya: [jumlah]
- Dilewati: [jumlah]

## Detail Task

### 1. [Nama Task]

- Status: Selesai / Dilewati
- Alasan: [Penjelasan]
- File diubah: [Daftar file]
- Backup: [Lokasi backup]
- Verifikasi: [Hasil pemeriksaan]

### 2. [Nama Task]

Gunakan format yang sama untuk seluruh task.

## Flutter Analyze

- Status: Bersih / Masih terdapat temuan.
- Error: [Jumlah dan penjelasan]
- Lint: [Jumlah dan penjelasan]
- Temuan lama: [Jika ada]
- Temuan baru: [Jika ada]

## Catatan Tambahan

Tuliskan hambatan, masalah yang belum terselesaikan, atau temuan di luar ruang lingkup jika ada.

## 7. Instruksi Berhenti

Setelah seluruh 5 task selesai diproses:

1. Hentikan seluruh perubahan kode.
2. Jangan mengambil task berikutnya.
3. Pastikan `task.md` sudah diperbarui.
4. Pastikan laporan akhir sudah disampaikan.
5. Tunggu perintah pengguna untuk melanjutkan 5 task berikutnya.

**INGAT: BATAS MAKSIMAL 5 TASK PER SESI. TASK YANG DILEWATI TETAP DIHITUNG. JANGAN MELANJUTKAN PEKERJAAN TANPA PERINTAH BARU DARI PENGGUNA.**
