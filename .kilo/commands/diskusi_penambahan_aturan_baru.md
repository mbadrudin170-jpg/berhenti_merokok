# Diskusi Penambahan Aturan Baru

**Path:** `.kilo/commands/diskusi_penambahan_aturan_baru.md`

## Tujuan

Command ini digunakan untuk mendiskusikan kemungkinan penambahan atau penyempurnaan aturan standarisasi dalam proyek.

AI bertugas membantu mengevaluasi kebutuhan aturan, memeriksa aturan yang sudah tersedia, menemukan potensi konflik, dan memberikan usulan aturan yang relevan.

Command ini hanya untuk diskusi dan pemberian rekomendasi. Keputusan akhir serta penulisan perubahan file tetap menjadi tanggung jawab pengguna.

## Ketentuan Utama

1. **Dilarang mengubah kode Dart.**
   - Jangan membuat, mengubah, menghapus, atau memformat file Dart.
   - Jangan melakukan refactoring atau perubahan implementasi kode.

2. **Batasi pembahasan sesuai topik.**
   - Berikan saran aturan hanya yang berkaitan langsung dengan topik yang sedang didiskusikan.
   - Jangan memperluas pembahasan ke topik lain yang tidak diminta.
   - Jangan memberikan rekomendasi yang tidak memiliki hubungan jelas dengan tujuan standarisasi yang sedang dibahas.

3. **Gunakan tool Question untuk bertanya.**
   - Jika terdapat informasi yang belum jelas atau keputusan pengguna diperlukan, gunakan tool `question`.
   - Jangan menebak maksud pengguna atau mengambil keputusan berdasarkan asumsi sendiri.
   - Ajukan pertanyaan yang spesifik dan relevan dengan pembahasan.

4. **Periksa aturan yang sudah tersedia terlebih dahulu.**
   - Sebelum mengusulkan aturan baru, periksa file aturan yang relevan di dalam proyek.
   - Identifikasi apakah kebutuhan tersebut sudah diatur dalam file yang ada.
   - Tentukan apakah kebutuhan tersebut lebih tepat ditangani dengan:
     - Mempertahankan aturan yang sudah ada.
     - Memperbarui aturan yang sudah ada.
     - Menambahkan aturan baru.
   - Hindari membuat aturan duplikat atau aturan yang memiliki tujuan sama dengan aturan sebelumnya.

5. **Dilarang mengubah file aturan.**
   - Jangan membuat, mengubah, menghapus, atau memindahkan file aturan.
   - Jangan langsung menerapkan rekomendasi ke dalam proyek.
   - Sampaikan hasil evaluasi dan usulan redaksi kepada pengguna.
   - Pengguna akan menentukan sendiri apakah usulan tersebut diterapkan dan menuliskannya secara manual.

6. **Laporkan konflik antaraturan.**
   - Periksa apakah usulan aturan baru bertentangan dengan aturan yang sudah tersedia.
   - Jika ditemukan konflik, jelaskan kedua aturan yang bertentangan beserta path file masing-masing.
   - Jelaskan bagian yang menyebabkan konflik dan dampaknya terhadap penerapan aturan.
   - Jangan mengubah, menghapus, atau mengesampingkan aturan lama untuk menyelesaikan konflik.
   - Serahkan keputusan penyelesaian konflik kepada pengguna.

## Alur Kerja

Ikuti tahapan berikut secara berurutan.

### 1. Pahami Topik Diskusi

- Identifikasi tujuan dan maksud pengguna.
- Tentukan ruang lingkup pembahasan.
- Jika terdapat informasi yang belum jelas, gunakan tool `question` untuk meminta penjelasan.

### 2. Periksa Aturan yang Sudah Ada

- Telusuri file aturan yang relevan dengan topik pembahasan.
- Baca isi file secara menyeluruh apabila diperlukan untuk memahami konteksnya.
- Identifikasi aturan yang sudah mengatur kebutuhan tersebut.
- Periksa kemungkinan duplikasi, tumpang tindih, dan pertentangan antaraturan.

### 3. Evaluasi Kebutuhan Aturan

Tentukan solusi yang paling tepat berdasarkan hasil pemeriksaan:

- **Tidak memerlukan perubahan:** Aturan yang tersedia sudah mencukupi.
- **Memperbarui aturan lama:** Aturan sudah tersedia, tetapi redaksi atau ketentuannya perlu diperjelas atau disempurnakan.
- **Menambahkan aturan baru:** Kebutuhan belum diatur dan tidak cukup ditangani dengan memperbarui aturan yang tersedia.

Jangan merekomendasikan penambahan aturan baru jika kebutuhan tersebut sebenarnya sudah tercakup dalam aturan lama.

### 4. Susun Usulan

Jika terdapat kebutuhan perubahan, berikan usulan dengan ketentuan berikut:

- Pertahankan tujuan dan maksud standarisasi yang diinginkan pengguna.
- Gunakan bahasa Indonesia yang baik, benar, formal, dan baku.
- Gunakan redaksi yang tegas, spesifik, dan tidak ambigu.
- Hindari kalimat yang dapat ditafsirkan dengan berbagai cara.
- Jangan menambahkan kewajiban baru yang tidak diminta atau tidak diperlukan untuk mencapai tujuan.
- Bedakan ketentuan wajib dengan rekomendasi.
- Sertakan path file tujuan yang disarankan.
- Pastikan usulan tidak menduplikasi aturan yang sudah ada.

### 5. Laporkan Hasil Evaluasi

Sampaikan hasil diskusi menggunakan struktur berikut.

## Format Laporan

### A. Hasil Evaluasi

Jelaskan apakah kebutuhan tersebut:

- Tidak memerlukan perubahan.
- Memerlukan pembaruan aturan lama.
- Memerlukan penambahan aturan baru.

Sertakan alasan berdasarkan hasil pemeriksaan.

### B. Aturan yang Sudah Tersedia

Cantumkan aturan relevan yang ditemukan beserta path file dan penjelasan singkat mengenai isinya.

Jika tidak ditemukan aturan yang relevan, sampaikan secara jelas.

### C. Konflik Antaraturan

Jika ditemukan konflik, cantumkan:

- Path file aturan pertama.
- Path file aturan kedua.
- Isi ketentuan yang bertentangan.
- Penjelasan letak dan dampak konflik.

Jika tidak ditemukan konflik, sampaikan bahwa tidak ditemukan konflik berdasarkan pemeriksaan.

**Jangan menentukan sendiri aturan mana yang harus dipertahankan.**

### D. Usulan Perubahan Aturan

Pisahkan usulan berdasarkan jenis perubahan:

**1. Pembaruan Aturan Lama**

- Path file yang disarankan untuk diperbarui.
- Alasan pembaruan.
- Redaksi aturan yang disarankan.

**2. Penambahan Aturan Baru**

- Path file yang disarankan.
- Tujuan aturan.
- Redaksi aturan yang siap disalin.

Tampilkan hanya bagian yang memang diperlukan.

### E. Rekomendasi Tambahan

Pisahkan rekomendasi tambahan dari ketentuan utama.

Rekomendasi bersifat opsional dan tidak boleh dianggap sebagai kewajiban baru.

Jelaskan alasan setiap rekomendasi secara singkat.

### F. Konfirmasi Pengguna

Akhiri pembahasan dengan meminta keputusan pengguna apabila masih terdapat usulan yang memerlukan persetujuan.

Jangan melakukan perubahan apa pun sebelum pengguna memutuskan untuk menerapkannya.

## Batasan Eksekusi

Command ini merupakan mode diskusi, bukan mode implementasi.

Selama menjalankan command ini, AI hanya diperbolehkan:

- Membaca dan memeriksa file aturan yang relevan.
- Menganalisis isi dan hubungan antaraturan.
- Mengidentifikasi duplikasi dan konflik.
- Menyusun usulan redaksi aturan.
- Memberikan rekomendasi yang relevan.
- Mengajukan pertanyaan menggunakan tool `question`.

AI tidak diperbolehkan:

- Mengubah kode Dart.
- Mengubah file aturan.
- Membuat file aturan baru.
- Menghapus atau memindahkan file.
- Menjalankan implementasi perubahan aturan.
- Menganggap rekomendasi sebagai persetujuan pengguna.

**Prinsip utama: Periksa terlebih dahulu, evaluasi kebutuhan, laporkan konflik, susun usulan, kemudian tunggu keputusan pengguna.**
