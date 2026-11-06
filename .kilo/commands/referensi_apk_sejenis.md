# Referensi APK Sejenis

**Path file:** `.kilo/commands/referensi_apk_sejenis.md`  
**Nama command:** `/referensi_apk_sejenis`

## Tujuan

Command ini digunakan untuk meminta AI melakukan penelitian terhadap aplikasi Android sejenis dengan memanfaatkan alat pencarian dan referensi yang tersedia.

Hasil penelitian digunakan untuk menemukan:

1. Fitur baru dari aplikasi sejenis yang berpotensi ditambahkan ke proyek.
2. Referensi peningkatan fitur yang sudah tersedia di proyek.
3. Referensi penerapan UI dan UX dari aplikasi lain yang dapat menjadi bahan evaluasi dan perbaikan proyek.

Setelah penelitian selesai, AI wajib memperbarui file `refrensi_apk.md` yang berada di root proyek dengan hasil penelitian yang relevan.

## Instruksi Pelaksanaan

### 1. Pemeriksaan Proyek

Sebelum melakukan penelitian:

1. Baca `AGENTS.md` terlebih dahulu jika tersedia.
2. Periksa aturan dan instruksi proyek yang relevan dengan pelaksanaan command ini.
3. Periksa apakah terdapat aturan yang bertentangan dengan instruksi command ini.
4. Jika ditemukan pertentangan, identifikasi sumber aturan, bagian yang bertentangan, dan dampaknya. Jangan mengabaikan atau mengubah aturan proyek secara sepihak.
5. Pelajari proyek untuk memahami:
   - Jenis dan tujuan aplikasi.
   - Target pengguna.
   - Platform yang didukung.
   - Fitur yang sudah tersedia.
   - Alur penggunaan aplikasi.
   - Struktur navigasi dan halaman.
   - Penerapan UI dan UX yang sudah digunakan.
6. Periksa file `refrensi_apk.md` apabila sudah tersedia agar penelitian tidak mengulang referensi yang sama.

Gunakan file dan kode proyek yang relevan sebagai sumber informasi. Jangan menyimpulkan keberadaan suatu fitur hanya berdasarkan nama halaman atau nama file. Periksa implementasinya apabila diperlukan.

### 2. Penelitian Referensi Aplikasi

Cari aplikasi lain yang memiliki tujuan, kategori, atau fungsi serupa dengan proyek yang sedang dikerjakan.

Ketentuan penelitian:

1. Gunakan alat pencarian, browser, atau tools lain yang benar-benar tersedia dalam lingkungan Kilo Code.
2. Utamakan aplikasi Android yang tersedia melalui Google Play Store.
3. Pilih aplikasi yang relevan dengan jenis dan kebutuhan proyek.
4. Periksa informasi aplikasi serta bukti yang tersedia, seperti deskripsi, tangkapan layar, dokumentasi, atau sumber resmi lainnya.
5. Jangan mengarang nama aplikasi, fitur, cara kerja, maupun alamat referensi.
6. Setiap informasi yang belum dapat dipastikan harus ditandai sebagai hasil pengamatan atau dugaan, bukan sebagai fakta.
7. Utamakan referensi yang memberikan manfaat nyata terhadap proyek. Jangan memaksakan jumlah aplikasi atau rekomendasi.
8. Jangan menjadikan fitur yang hanya dapat digunakan melalui website atau aplikasi desktop sebagai rekomendasi fitur mobile.

Apabila alat pencarian tidak tersedia atau informasi tidak dapat diverifikasi, jelaskan keterbatasannya. Jangan mengganti informasi yang tidak ditemukan dengan asumsi.

## 3. Penelitian Fitur

Penelitian fitur dibagi menjadi dua kategori.

### A. Fitur Baru

Cari fitur dari aplikasi sejenis yang belum tersedia di proyek dan berpotensi memberikan manfaat kepada pengguna.

Ketentuan:

1. Hanya rekomendasikan fitur yang dapat digunakan melalui aplikasi mobile.
2. Pastikan fitur tersebut relevan dengan tujuan dan jenis proyek.
3. Periksa terlebih dahulu apakah fitur tersebut benar-benar belum tersedia di proyek.
4. Jelaskan tujuan fitur dan masalah pengguna yang ingin diselesaikan.
5. Jelaskan bagaimana aplikasi referensi menerapkan fitur tersebut berdasarkan informasi yang ditemukan.
6. Jelaskan alasan fitur tersebut layak dipertimbangkan untuk proyek.
7. Jangan merekomendasikan fitur hanya karena tersedia di aplikasi lain. Pastikan terdapat relevansi dan manfaat yang jelas.

### B. Peningkatan Fitur yang Sudah Ada

Untuk fitur yang sudah tersedia di proyek, jangan merekomendasikannya kembali sebagai fitur baru.

Sebaliknya, cari referensi aplikasi lain yang menerapkan fitur sejenis dengan kualitas atau pendekatan yang terlihat lebih baik.

Perhatikan hal-hal berikut:

1. Cara aplikasi lain menerapkan fitur tersebut.
2. Kemudahan penggunaan dan alur interaksinya.
3. Pengaturan tampilan dan struktur informasinya.
4. Pengalaman pengguna ketika menggunakan fitur tersebut.
5. Perbedaan pendekatan antara aplikasi referensi dan proyek.
6. Bagian yang berpotensi menjadi bahan peningkatan proyek.

Jelaskan bagian yang dapat ditingkatkan tanpa menganggap bahwa seluruh implementasi aplikasi referensi harus ditiru.

## 4. Penelitian UI dan UX

Cari referensi penerapan UI dan UX dari aplikasi sejenis maupun aplikasi lain yang memiliki pendekatan desain relevan.

Perhatikan bagaimana aplikasi tersebut mengatur:

1. Tata letak halaman.
2. Navigasi dan perpindahan ant halaman.
3. Hierarki informasi.
4. Penempatan tombol dan tindakan.
5. Formulir dan input data.
6. Penyajian informasi.
7. Tampilan daftar, kartu, dan detail.
8. Kondisi loading, kosong, berhasil, dan gagal.
9. Feedback terhadap tindakan pengguna.
10. Konsistensi desain dan kemudahan penggunaan.

Ketentuan:

- Utamakan referensi yang dapat diamati langsung melalui aplikasi mobile.
- Jelaskan bagian UI atau UX yang menjadi referensi.
- Jelaskan masalah pengguna yang dapat diselesaikan melalui pendekatan tersebut.
- Jelaskan alasan pendekatan tersebut relevan untuk proyek.
- Jangan menyarankan perubahan hanya berdasarkan selera visual.
- Utamakan kemudahan penggunaan, kejelasan informasi, konsistensi, dan efisiensi interaksi.

## 5. Penentuan Prioritas

Semua hasil penelitian harus dikelompokkan berdasarkan tingkat prioritas.

Gunakan kategori berikut:

**Prioritas Tinggi**

- Memberikan manfaat besar terhadap fungsi utama aplikasi.
- Menyelesaikan masalah pengguna yang penting.
- Memiliki relevansi kuat dengan tujuan proyek.

**Prioritas Sedang**

- Memberikan peningkatan yang bermanfaat, tetapi bukan kebutuhan utama.
- Mendukung kemudahan penggunaan atau melengkapi fungsi aplikasi.

**Prioritas Rendah**

- Bersifat tambahan atau pelengkap.
- Manfaatnya relatif terbatas dibandingkan rekomendasi lainnya.

Urutkan setiap kategori dari rekomendasi yang paling penting.

Sertakan alasan penetapan prioritas. Jangan menentukan prioritas hanya berdasarkan popularitas aplikasi referensi.

## 6. Pemisahan Hasil Penelitian dan Rekomendasi

Jangan mencampurkan fakta hasil penelitian dengan pendapat atau rekomendasi AI.

Pisahkan informasi berikut:

- **Referensi:** informasi yang ditemukan dari aplikasi atau sumber lain.
- **Hasil pengamatan:** penjelasan mengenai cara aplikasi menerapkan fitur, UI, atau UX.
- **Analisis:** perbandingan dan penilaian terhadap kebutuhan proyek.
- **Rekomendasi:** saran yang diberikan AI berdasarkan hasil penelitian dan relevansinya terhadap proyek.

Rekomendasi harus memiliki alasan yang jelas dan didukung oleh referensi yang dicantumkan.

## 7. Pembaruan File Hasil Penelitian

Setelah penelitian selesai, perbarui file berikut:

`refrensi_apk.md`

Lokasi: root proyek.

Ketentuan pembaruan:

1. Baca isi file terlebih dahulu apabila sudah tersedia.
2. Pertahankan referensi lama yang masih relevan dan dapat diverifikasi.
3. Hindari menambahkan referensi duplikat.
4. Perbarui atau hapus informasi yang terbukti tidak relevan, keliru, atau sudah tidak berlaku.
5. Jangan menghapus referensi yang masih bermanfaat tanpa alasan yang jelas.
6. Susun kembali isi file agar terstruktur dan mudah dipahami.
7. Gunakan bahasa Indonesia yang baik, formal, dan baku.
8. Pastikan setiap referensi memiliki tautan yang dapat ditelusuri.
9. Jangan menuliskan informasi yang tidak didukung oleh hasil penelitian.
10. Jangan mengubah kode Dart atau file proyek lain untuk menjalankan command ini.

Apabila tidak ditemukan referensi yang cukup valid, jangan membuat rekomendasi fiktif hanya untuk mengisi file.

## 8. Format Penulisan File `refrensi_apk.md`

Gunakan struktur berikut:

# Referensi APK Sejenis

## Informasi Penelitian

- Nama proyek:
- Jenis aplikasi:
- Platform:
- Tanggal penelitian:
- Ringkasan hasil penelitian:

## 1. Referensi Fitur Baru

Kelompokkan berdasarkan prioritas: Tinggi, Sedang, dan Rendah.

Untuk setiap referensi, gunakan format:

### [Nama Fitur]

- **Prioritas:** Tinggi / Sedang / Rendah
- **Aplikasi referensi:** Nama aplikasi
- **Link aplikasi:** URL Google Play Store
- **Link sumber pendukung:** URL dokumentasi, halaman resmi, atau sumber terkait apabila tersedia.
- **Tujuan fitur:** Tujuan dan masalah yang ingin diselesaikan.
- **Penerapan pada aplikasi referensi:** Penjelasan cara fitur tersebut digunakan.
- **Relevansi terhadap proyek:** Alasan fitur tersebut sesuai dengan kebutuhan proyek.
- **Rekomendasi:** Alasan dan gambaran penerapan yang disarankan.

## 2. Referensi Peningkatan Fitur yang Sudah Ada

Kelompokkan berdasarkan prioritas: Tinggi, Sedang, dan Rendah.

Untuk setiap referensi, gunakan format:

### [Nama Fitur]

- **Prioritas:** Tinggi / Sedang / Rendah
- **Fitur pada proyek:** Nama fitur atau halaman yang sudah tersedia.
- **Aplikasi referensi:** Nama aplikasi.
- **Link aplikasi:** URL Google Play Store.
- **Link sumber pendukung:** URL sumber terkait apabila tersedia.
- **Penerapan pada aplikasi referensi:** Penjelasan cara aplikasi tersebut menerapkan fitur.
- **Perbandingan:** Perbedaan pendekatan antara proyek dan aplikasi referensi.
- **Potensi peningkatan:** Bagian yang dapat diperbaiki pada proyek.
- **Tujuan peningkatan:** Manfaat yang diharapkan bagi pengguna.

## 3. Referensi UI dan UX

Kelompokkan berdasarkan prioritas: Tinggi, Sedang, dan Rendah.

Untuk setiap referensi, gunakan format:

### [Nama Halaman atau Pola UI/UX]

- **Prioritas:** Tinggi / Sedang / Rendah
- **Aplikasi referensi:** Nama aplikasi.
- **Link aplikasi:** URL Google Play Store.
- **Link sumber pendukung:** URL tangkapan layar, dokumentasi, atau sumber terkait apabila tersedia.
- **Bagian yang menjadi referensi:** Penjelasan tampilan atau interaksi yang diamati.
- **Tujuan UI/UX:** Masalah pengguna yang ingin diselesaikan.
- **Relevansi terhadap proyek:** Alasan pendekatan tersebut sesuai dengan proyek.
- **Rekomendasi:** Bagian yang dapat diadaptasi atau ditingkatkan.

## 4. Rekomendasi Utama

Tuliskan rekomendasi terbaik dari seluruh hasil penelitian.

Pisahkan rekomendasi menjadi:

1. Fitur baru yang paling layak dipertimbangkan.
2. Peningkatan fitur yang sudah tersedia.
3. Peningkatan UI dan UX.

Urutkan berdasarkan prioritas dan jelaskan alasan pemilihannya.

## 5. Sumber dan Keterbatasan Penelitian

Tuliskan sumber yang digunakan serta keterbatasan informasi apabila ada.

Pastikan tautan yang dicantumkan sesuai dengan informasi yang dijelaskan.

---

## 9. Pelaporan Setelah Command Selesai

Setelah penelitian dan pembaruan file selesai, berikan laporan singkat kepada pengguna yang mencakup:

1. File yang berhasil diperbarui beserta path-nya.
2. Aplikasi yang berhasil dijadikan referensi.
3. Jumlah referensi fitur baru.
4. Jumlah referensi peningkatan fitur.
5. Jumlah referensi UI dan UX.
6. Ringkasan rekomendasi dengan prioritas tertinggi.
7. Konflik aturan yang ditemukan, jika ada.
8. Keterbatasan penelitian, jika ada.

Jangan menyatakan file berhasil diperbarui apabila perubahan belum benar-benar tersimpan.

## Batasan Pelaksanaan

- Command ini hanya digunakan untuk penelitian dan pembaruan `refrensi_apk.md`.
- Jangan mengubah kode Dart.
- Jangan mengubah konfigurasi proyek.
- Jangan memasang atau menghapus paket.
- Jangan melakukan refactoring.
- Jangan mengubah aturan proyek.
- Jangan membuat rekomendasi yang tidak didukung hasil penelitian.
- Kerjakan bagian yang tidak bertentangan dengan aturan proyek dan laporkan bagian yang tidak dapat dilakukan.

**Hasil akhir yang diharapkan:** File `refrensi_apk.md` berisi referensi aplikasi sejenis yang relevan, dikelompokkan berdasarkan fitur baru, peningkatan fitur yang sudah ada, serta UI dan UX. Seluruh referensi disertai tautan, penjelasan tujuan, dan rekomendasi yang disusun berdasarkan prioritas.
