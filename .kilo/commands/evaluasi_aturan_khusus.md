---
description: Evaluasi setiap perubahan kode yang sudah staged, perbarui aturan khusus dan global Flutter, regenerasi AGENTS.md, lalu commit hanya perubahan staged.
agent: code
---

# EVALUASI ATURAN KHUSUS DAN ATURAN BERSAMA

## 1. Tujuan

Setiap kali command ini dijalankan setelah pekerjaan penambahan atau perbaikan kode, lakukan evaluasi menyeluruh terhadap seluruh perubahan yang sudah masuk ke Git Staging Area.

Tujuan utama:

1. Menemukan kesalahan, kekurangan, dan ketidaksesuaian dalam perubahan kode.
2. Memahami pola penulisan kode yang sebenarnya diinginkan pengguna.
3. Mencatat aturan khusus proyek agar AI tidak mengulangi kesalahan ketika mengubah kode di kemudian hari.
4. Mengidentifikasi prinsip yang bisa diterapkan ke seluruh proyek Flutter dan memasukkannya ke aturan bersama.
5. Memberikan contoh kode yang benar dan salah agar AI memiliki pedoman konkret.
6. Memperbarui konteks aturan pada `AGENTS.md`.
7. Melakukan commit hanya terhadap perubahan yang sudah berada di Git Staging Area sebelum proses evaluasi dimulai.

Jangan mengubah tujuan dan ruang lingkup pekerjaan ini.

## 2. Pemeriksaan izin tools

Sebelum melakukan pekerjaan apa pun:

1. Baca seluruh isi file `.kilo/commands/izin_kilo.md`.
2. Periksa tools yang secara eksplisit diizinkan.
3. Gunakan hanya tools yang tercantum dan diizinkan dalam file tersebut.
4. Jangan menggunakan tools lain yang tidak tercantum, sekalipun menurut Anda tools tersebut lebih mudah atau lebih cepat.
5. Jika tools yang diperlukan untuk membaca, mengedit, menjalankan script, atau melakukan commit tidak diizinkan, jangan mencari jalan alternatif untuk melewati pembatasan tersebut.
6. Laporkan pekerjaan yang tidak dapat dilakukan beserta alasan dan tahapan yang terhenti.

Jika tool untuk membaca file izin itu sendiri tidak diizinkan, hentikan pekerjaan dan laporkan kendalanya.

## 3. Identifikasi Git Staging Area

**Fokus evaluasi hanya pada perubahan yang sudah staged.**

Gunakan informasi Git berikut:

- `git status --short` untuk mengetahui kondisi repository.
- `git diff --cached --name-status` untuk mendapatkan daftar file yang sudah staged.
- `git diff --cached --no-ext-diff --no-color` untuk membaca perubahan yang sudah staged.
- `git diff --cached --check` untuk memeriksa kesalahan whitespace pada perubahan staged.

Jangan menggunakan `git diff` tanpa `--cached` sebagai sumber perubahan yang dievaluasi.

### Ketentuan pemeriksaan

1. Identifikasi seluruh file yang sudah staged.
2. Catat daftar file sebelum melakukan evaluasi.
3. Baca setiap file staged satu per satu.
4. Jangan hanya membaca ringkasan atau statistik perubahan.
5. Periksa seluruh bagian diff yang berubah, termasuk penambahan, penghapusan, dan modifikasi kode.
6. Untuk memahami kode secara utuh, periksa versi file yang terdapat dalam Git Index, bukan menganggap isi working directory selalu sama dengan isi staged.
7. Perhatikan perubahan file baru, file yang dihapus, dan file yang dipindahkan.
8. Jika file berisi perubahan biner atau format yang tidak dapat dibaca sebagai teks, identifikasi dan laporkan keterbatasan evaluasinya.
9. Jangan memasukkan perubahan unstaged atau untracked ke dalam objek evaluasi.
10. Jangan mengubah Staging Area selama proses pemeriksaan.

Apabila tidak terdapat perubahan staged, hentikan proses evaluasi dan jangan melakukan commit.

### Larangan

- Jangan menjalankan `git add`.
- Jangan menjalankan `git add .`.
- Jangan menjalankan `git add -A`.
- Jangan memasukkan file baru ke Staging Area.
- Jangan mengeluarkan file dari Staging Area.
- Jangan mengubah isi Git Index.
- Jangan menggunakan perubahan unstaged sebagai dasar evaluasi.
- Jangan menganggap seluruh perubahan pada working directory sudah staged.

**Catatan:** Git Staging Area merupakan sumber utama perubahan yang akan dievaluasi dan menjadi satu-satunya sumber perubahan yang boleh dimasukkan ke commit.

## 4. Evaluasi setiap perubahan kode

Evaluasi seluruh file staged satu per satu.

Jangan hanya mencari kesalahan yang terlihat secara langsung. Pahami tujuan, konteks, alur kerja, dan konsekuensi dari setiap perubahan.

Lakukan evaluasi berdasarkan aspek berikut.

### A. Kebenaran logika dan fungsionalitas

Periksa:

- Apakah logika kode sudah sesuai dengan tujuan fitur?
- Apakah hasil pengolahan data sudah benar?
- Apakah kondisi percabangan sudah tepat?
- Apakah terdapat kesalahan perhitungan?
- Apakah terdapat kondisi yang tidak tertangani?
- Apakah terdapat potensi data tidak konsisten?
- Apakah kode menghasilkan keluaran yang diharapkan?
- Apakah perubahan menyebabkan fitur lain terganggu?

### B. Bug dan runtime

Periksa:

- Potensi exception.
- Null safety.
- Kesalahan asynchronous.
- Penggunaan Future dan Stream.
- Lifecycle widget.
- Pengelolaan state.
- Pengelolaan resource dan dispose.
- Penanganan error.
- Potensi race condition.
- Potensi memory leak.
- Risiko kehilangan atau kerusakan data.

### C. Gaya dan kualitas penulisan kode

Periksa:

- Konsistensi penamaan variabel, fungsi, class, dan file.
- Struktur kode.
- Keterbacaan.
- Konsistensi format.
- Pemisahan tanggung jawab.
- Penggunaan abstraksi.
- Duplikasi kode.
- Kompleksitas logika.
- Kesesuaian dengan pola yang sudah digunakan proyek.
- Kepatuhan terhadap aturan penulisan kode yang berlaku.

Jangan menganggap kode sudah benar hanya karena berhasil dikompilasi.

### D. Arsitektur dan pengelolaan state

Periksa:

- Kesesuaian tanggung jawab setiap lapisan.
- Pemisahan UI, state, dan business logic.
- Alur komunikasi antarkomponen.
- Pengelolaan data.
- Penggunaan cache.
- Penggunaan repository dan service.
- Konsistensi pengelolaan state.
- Potensi ketergantungan yang tidak diperlukan.

### E. Performa dan efisiensi

Periksa:

- Proses yang tidak diperlukan.
- Rebuild widget yang berlebihan.
- Operasi database.
- Pemrosesan data.
- Penggunaan memori.
- Pemanggilan fungsi berulang.
- Pengelolaan cache.
- Operasi asynchronous.
- Potensi pekerjaan berat pada UI thread.

### F. Keamanan dan keandalan

Periksa:

- Validasi input.
- Penanganan data sensitif.
- Pengelolaan autentikasi dan otorisasi.
- Potensi kebocoran data.
- Penanganan kegagalan operasi.
- Konsistensi transaksi database.
- Keamanan operasi yang mengubah atau menghapus data.

### G. Pengalaman pengguna

Periksa perubahan yang berkaitan dengan UI dan UX:

- Kejelasan fungsi tombol.
- Kejelasan status operasi.
- Penanganan loading.
- Penanganan error.
- Konfirmasi tindakan penting.
- Konsistensi desain.
- Kemudahan penggunaan.
- Potensi kebingungan pengguna.
- Responsivitas tampilan.

Jangan menganggap aspek UI dan UX tidak perlu dievaluasi hanya karena perubahan utamanya berada pada business logic.

## 5. Periksa aturan yang sudah tersedia

Sebelum menambahkan aturan baru, baca dan pahami isi:

- `AGENTS.md`
- `.agents/rules/proyek/aturan_khusus.md`
- `.agents/rules/global/aturan_bersama.md`

Jika diperlukan untuk memahami suatu aturan, baca juga file aturan lain yang relevan dengan perubahan staged.

Tujuannya:

1. Memahami standar yang sudah berlaku.
2. Mengetahui apakah kesalahan yang ditemukan sebenarnya sudah diatur.
3. Menghindari aturan duplikat.
4. Mengetahui apakah aturan yang sudah ada perlu diperjelas.
5. Menemukan kemungkinan konflik antaraturan.
6. Memastikan aturan baru tidak bertentangan dengan pedoman yang sudah ditetapkan.

Jangan menambahkan aturan baru hanya dengan mengganti kata-kata dari aturan lama.

Apabila terdapat aturan yang bertentangan, evaluasi konteks dan prioritasnya. Jangan menghapus atau mengganti aturan yang masih digunakan tanpa dasar yang jelas.

## 6. Memperbarui aturan khusus proyek

File tujuan:

`.agents/rules/proyek/aturan_khusus.md`

Masukkan aturan yang:

- Berlaku khusus untuk proyek yang sedang dikerjakan.
- Bergantung pada arsitektur proyek.
- Bergantung pada struktur folder proyek.
- Bergantung pada business logic proyek.
- Bergantung pada ketentuan atau keputusan teknis proyek.
- Mengatur pola implementasi yang memang hanya berlaku pada proyek tersebut.
- Menjelaskan kesalahan spesifik yang ditemukan dalam perubahan staged.

### Ketentuan penulisan

Setiap aturan baru harus menjelaskan:

1. Judul aturan.
2. Kondisi atau konteks penerapannya.
3. Ketentuan yang wajib dipatuhi.
4. Alasan aturan tersebut diperlukan.
5. Contoh kode yang benar.
6. Contoh kode yang salah.
7. Penjelasan mengapa contoh benar harus digunakan dan contoh salah harus dihindari.

Contoh kode wajib relevan dengan masalah yang ditemukan. Jangan memberikan contoh yang tidak berkaitan hanya untuk memenuhi format.

Gunakan contoh Dart atau Flutter yang sesuai dengan implementasi proyek.

### Contoh format aturan

#### Aturan: Jangan menggunakan nilai yang belum divalidasi

**Ketentuan:**

Pastikan nilai sudah divalidasi sebelum digunakan agar tidak menimbulkan kesalahan runtime.

**Contoh yang benar:**

```dart
final id = int.tryParse(value);

if (id == null) {
  return;
}

processData(id);
```

**Contoh yang salah:**

```dart
final id = int.parse(value);

processData(id);
```

**Alasan:**

Penggunaan `tryParse` memungkinkan penanganan nilai yang tidak valid tanpa langsung menghasilkan exception.

Contoh di atas hanya ilustrasi format. Aturan yang dimasukkan harus berasal dari hasil evaluasi perubahan nyata dan harus sesuai dengan standar proyek.

### Ketentuan tambahan

- Pertahankan aturan lama yang masih berlaku.
- Perbarui aturan lama apabila ditemukan kekurangan.
- Gabungkan aturan yang memiliki tujuan sama.
- Hapus duplikasi jika memang tidak lagi diperlukan.
- Jangan membuat aturan yang terlalu umum sehingga kehilangan konteks proyek.
- Jangan menulis aturan berdasarkan asumsi.
- Jangan menambahkan ketentuan teknis yang tidak memiliki dasar dari hasil evaluasi, dokumentasi, atau standar proyek yang sudah ditetapkan.

## 7. Mengidentifikasi aturan untuk seluruh proyek Flutter

File tujuan:

`.agents/rules/global/aturan_bersama.md`

Semua proyek pengguna menggunakan Flutter. Oleh karena itu, setiap temuan perlu diperiksa apakah dapat menghasilkan prinsip yang berlaku lintas proyek Flutter.

Identifikasi prinsip yang dapat diterapkan pada:

- Dart.
- Flutter.
- Widget dan lifecycle.
- State management.
- Asynchronous programming.
- Database.
- Pengelolaan data.
- Penanganan error.
- Performa aplikasi.
- Pengelolaan resource.
- Struktur kode.
- UI dan UX.
- Pengujian.
- Keamanan aplikasi.
- Pemeliharaan kode.

### Kriteria aturan global

Aturan hanya boleh dimasukkan ke `aturan_bersama.md` apabila:

1. Dapat diterapkan pada berbagai proyek Flutter.
2. Tidak bergantung pada business logic satu proyek.
3. Tidak mengharuskan penggunaan package tertentu yang hanya dipakai satu proyek.
4. Tidak bertentangan dengan aturan global yang sudah ada.
5. Memiliki dasar teknis yang dapat dipertanggungjawabkan.
6. Dapat dijadikan pedoman implementasi bagi AI pada proyek Flutter lainnya.

### Hubungan aturan khusus dan aturan global

Aturan khusus tetap menjadi sumber utama untuk ketentuan spesifik proyek.

Namun, jangan membatasi evaluasi hanya pada aturan khusus.

Setiap aturan khusus yang baru ditambahkan atau diperbarui harus diperiksa kembali untuk menemukan prinsip umum yang bisa dijadikan referensi aturan bersama.

Contoh:

Aturan khusus mungkin menjelaskan kesalahan pengelolaan asynchronous pada fitur tertentu.

Dari kesalahan tersebut, evaluasi apakah terdapat prinsip umum Flutter/Dart yang dapat diterapkan pada seluruh proyek.

Jika ada, tambahkan prinsip umumnya ke `aturan_bersama.md` dengan redaksi yang tidak bergantung pada fitur tersebut.

Jangan menyalin seluruh aturan khusus ke aturan bersama.

**Tujuan aturan bersama adalah mengambil prinsip yang dapat digunakan lintas proyek, bukan memindahkan semua ketentuan proyek ke file global.**

### Contoh kode

Setiap aturan global yang baru ditambahkan atau diperbarui juga harus memiliki:

- Contoh implementasi yang benar.
- Contoh implementasi yang salah.
- Penjelasan perbedaan keduanya.

Pastikan contoh benar dan salah menunjukkan prinsip Flutter/Dart yang memang sedang diatur.

## 8. Standar kualitas penulisan aturan

Untuk kedua file aturan, terapkan ketentuan berikut:

1. Gunakan bahasa Indonesia yang baik dan benar.
2. Gunakan istilah teknis secara konsisten.
3. Hindari kalimat yang memiliki banyak penafsiran.
4. Gunakan instruksi yang tegas dan operasional.
5. Jelaskan kondisi kapan aturan harus diterapkan.
6. Hindari aturan yang terlalu panjang tanpa manfaat.
7. Jangan mengulang aturan yang sudah dijelaskan dengan baik.
8. Pisahkan aturan wajib, larangan, dan rekomendasi apabila diperlukan.
9. Jangan mengubah maksud aturan lama yang masih benar.
10. Pastikan AI dapat memahami kapan aturan berlaku dan bagaimana menerapkannya.

**Jangan membuat aturan hanya untuk memperbanyak isi file. Utamakan aturan yang benar-benar dapat mencegah kesalahan berulang.**

## 9. Memperbarui file aturan

Lakukan perubahan pada:

`.agents/rules/proyek/aturan_khusus.md`

`.agents/rules/global/aturan_bersama.md`

Ketentuan:

1. Baca seluruh isi kedua file sebelum mengedit.
2. Identifikasi bagian yang perlu ditambahkan atau diperbarui.
3. Hindari membuat aturan duplikat.
4. Pertahankan isi lain yang tidak berkaitan.
5. Jangan menghapus aturan lama hanya karena ditemukan pendekatan lain yang lebih disukai.
6. Pastikan setiap perubahan memiliki alasan yang jelas berdasarkan hasil evaluasi.
7. Pastikan contoh kode benar dan salah tersedia untuk setiap aturan baru atau yang diperbarui.
8. Periksa kembali seluruh isi kedua file setelah perubahan selesai.

Jika tidak ditemukan aturan baru yang layak, jangan memaksakan penambahan aturan.

Laporkan apabila tidak ada aturan yang perlu ditambahkan atau diperbarui.

## 10. Regenerasi AGENTS.md

Setelah proses evaluasi dan pembaruan kedua file aturan selesai, jalankan script berikut:

`script/build_rules_context.sh`

Sebelum menjalankan:

1. Pastikan file script tersebut benar-benar tersedia.
2. Baca isi script untuk memahami operasinya.
3. Pastikan script tidak menjalankan operasi Git yang mengubah Staging Area, melakukan commit, atau push.
4. Pastikan penggunaan tools untuk membaca dan menjalankan script diizinkan oleh `.kilo/commands/izin_kilo.md`.
5. Jangan mengganti nama atau lokasi script berdasarkan asumsi.

Jika script tidak ditemukan atau tidak aman untuk dijalankan, hentikan tahap ini dan laporkan kendalanya.

Setelah berhasil dijalankan:

1. Periksa hasil eksekusinya.
2. Pastikan tidak ada pesan error.
3. Pastikan `AGENTS.md` berhasil diperbarui sesuai mekanisme script.
4. Jangan mengedit `AGENTS.md` secara langsung apabila file tersebut memang dihasilkan oleh script.
5. Jangan mengubah Staging Area.

## 11. Pemeriksaan sebelum commit

Setelah pembaruan aturan dan regenerasi `AGENTS.md` selesai:

1. Periksa kembali kedua file aturan.
2. Pastikan tidak ada aturan duplikat yang baru dibuat.
3. Pastikan tidak ada konflik baru.
4. Pastikan setiap aturan baru atau diperbarui memiliki contoh kode benar dan salah.
5. Pastikan script berhasil dijalankan.
6. Periksa kembali daftar perubahan staged.
7. Pastikan daftar dan isi perubahan staged masih sama dengan kondisi awal saat evaluasi dimulai.
8. Pastikan tidak ada file baru yang dimasukkan ke staging selama proses ini.

Jika ditemukan perubahan staged yang tidak sesuai dengan kondisi awal, jangan melakukan commit. Laporkan perubahan tersebut.

Jika ditemukan bug kritis, risiko kehilangan atau kerusakan data, kelemahan keamanan serius, atau kegagalan pengujian yang menunjukkan perubahan tidak layak digunakan, hentikan commit dan laporkan temuan tersebut. Jangan memperbaiki kode secara diam-diam dalam command ini.

## 12. Git Commit

Setelah seluruh tahapan pemeriksaan selesai dan tidak terdapat penghalang, lakukan commit.

**Commit hanya boleh menggunakan perubahan yang sudah berada di Git Staging Area sebelum evaluasi dimulai.**

Gunakan:

`git commit -m "Pesan commit dalam bahasa Indonesia"`

### Ketentuan commit

1. Jangan menjalankan `git add` dalam kondisi apa pun.
2. Jangan menggunakan `git add .` atau `git add -A`.
3. Jangan memasukkan file aturan yang baru dibuat atau diperbarui ke staging secara otomatis.
4. Jangan memasukkan hasil regenerasi `AGENTS.md` ke staging secara otomatis.
5. Jangan melakukan commit terhadap perubahan unstaged.
6. Jangan melakukan commit terhadap file untracked.
7. Jangan menjalankan `git commit -a`.
8. Jangan menggunakan `git commit --amend`.
9. Jangan melakukan push ke remote repository.
10. Jangan melewati pemeriksaan Git hooks menggunakan `--no-verify`.
11. Jangan melakukan perubahan pada Staging Area untuk menyesuaikan isi commit.

Gunakan pesan commit berdasarkan perubahan kode yang benar-benar sudah staged.

Pesan commit wajib menggunakan bahasa Indonesia yang jelas, ringkas, dan menggambarkan perubahan utama.

Contoh:

- `Perbaiki validasi data transaksi`
- `Tambahkan pengelolaan error pada repository`
- `Perbaiki perhitungan total persediaan`
- `Sesuaikan tampilan halaman laporan`
- `Tambahkan pengujian untuk proses autentikasi`

Jangan menggunakan pesan commit yang terlalu umum seperti:

- `update`
- `fix`
- `perbaikan kode`
- `perubahan terbaru`

Jika Git commit gagal, jangan mengulangi perintah secara membabi buta, jangan melewati hooks, dan jangan mengubah staging untuk memaksakan commit. Laporkan penyebab kegagalannya.

## 13. Laporan hasil pekerjaan

Setelah selesai, berikan laporan dengan struktur berikut:

### A. Ringkasan evaluasi Git

- Jumlah file staged.
- Daftar file yang diperiksa.
- Ringkasan perubahan yang dievaluasi.

### B. Hasil evaluasi kode

Kelompokkan temuan berdasarkan:

- Bug dan runtime.
- Logika dan fungsionalitas.
- Gaya dan kualitas kode.
- Arsitektur.
- Performa.
- Keamanan.
- UI dan UX.
- Aspek lainnya jika ditemukan.

Jelaskan temuan secara konkret. Jangan menyatakan sebuah bug tanpa menunjukkan dasar atau bagian kode yang menjadi penyebabnya.

Apabila tidak ditemukan masalah pada suatu kategori, nyatakan secara jelas bahwa tidak ditemukan masalah berdasarkan evaluasi yang dilakukan.

### C. Perubahan aturan khusus

- File: `.agents/rules/proyek/aturan_khusus.md`
- Aturan yang ditambahkan.
- Aturan yang diperbarui.
- Alasan perubahan.

### D. Perubahan aturan bersama

- File: `.agents/rules/global/aturan_bersama.md`
- Prinsip umum yang berhasil diambil dari evaluasi.
- Aturan yang ditambahkan.
- Aturan yang diperbarui.
- Alasan mengapa aturan dapat diterapkan lintas proyek Flutter.

Jika tidak ada aturan global baru, jelaskan alasannya.

### E. Hasil regenerasi AGENTS.md

- Script yang dijalankan.
- Status eksekusi.
- Hasil pembaruan.

### F. Hasil Git Commit

- Pesan commit.
- Status commit.
- Pastikan commit hanya menggunakan perubahan yang sebelumnya sudah staged.
- Sebutkan perubahan aturan dan regenerasi `AGENTS.md` yang masih belum staged apabila ada.

## 14. Larangan umum

- Jangan mengabaikan file staged.
- Jangan hanya mengevaluasi sebagian perubahan.
- Jangan menyimpulkan kode benar hanya karena tidak ada error saat kompilasi.
- Jangan membuat aturan berdasarkan asumsi.
- Jangan menyalin aturan khusus secara mentah ke aturan global.
- Jangan mengubah kode sumber dalam command evaluasi ini.
- Jangan melakukan refactor yang tidak diminta.
- Jangan menghapus aturan lama tanpa alasan.
- Jangan menjalankan tools yang tidak diizinkan.
- Jangan mengubah Git Staging Area.
- Jangan memasukkan perubahan unstaged ke commit.
- Jangan melakukan push.
- Jangan mengabaikan kegagalan script atau Git.
- Jangan menyatakan pekerjaan berhasil apabila belum diverifikasi.

**Prinsip akhir: Setiap perubahan kode harus menjadi bahan evaluasi untuk meningkatkan kualitas aturan AI. Kesalahan yang pernah ditemukan harus diubah menjadi pedoman konkret agar AI tidak mengulanginya ketika mengembangkan atau memperbaiki kode pada kesempatan berikutnya.**
