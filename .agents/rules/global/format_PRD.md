# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft / Final

**Status Implementasi:** Belum Diimplementasikan / Sedang Diimplementasikan / Sudah Diimplementasikan

---

## 1. Informasi Produk

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi produk dan memberikan gambaran umum proyek. Informasi ini menjadi identitas utama PRD.

**Aturan pengisian:**
- Isi informasi berdasarkan kondisi dan identitas proyek yang sebenarnya.
- Gunakan nama produk yang konsisten dengan proyek.
- Tuliskan platform dan versi yang menjadi target pengembangan.
- Bedakan status dokumen dengan status implementasi.
- Jangan mengarang informasi yang belum diketahui.

**Informasi:**
- Nama aplikasi:
- Deskripsi produk:
- Platform:
- Versi:
- Status pengembangan:

## 2. Latar Belakang

**Konteks penggunaan:**
Digunakan untuk menjelaskan alasan produk dibuat. Tuliskan masalah nyata, kebutuhan pengguna, atau kendala yang ingin diselesaikan.

**Aturan pengisian:**
- Jelaskan kondisi atau permasalahan yang melatarbelakangi pengembangan.
- Hubungkan permasalahan dengan kebutuhan produk.
- Hindari penjelasan yang tidak berhubungan dengan produk.
- Bedakan fakta, asumsi, dan kebutuhan yang belum terverifikasi.
- Jangan langsung menjelaskan solusi teknis sebelum masalahnya jelas.

**Isi:**
Jelaskan masalah, kebutuhan, atau alasan produk ini perlu dibuat.

## 3. Tujuan Produk

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai. Tujuan harus berhubungan langsung dengan masalah pada bagian latar belakang.

**Aturan pengisian:**
- Tuliskan hasil yang diharapkan dari produk.
- Pastikan setiap tujuan memiliki hubungan dengan masalah yang ingin diselesaikan.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup produk.

**Isi:**
Jelaskan hasil dan manfaat yang ingin dicapai melalui aplikasi.

## 4. Target Pengguna

**Konteks penggunaan:**
Digunakan untuk menentukan siapa yang akan menggunakan produk. Informasi ini menjadi dasar dalam menentukan fitur, bahasa, navigasi, hak akses, dan pengalaman pengguna.

**Aturan pengisian:**
- Identifikasi kelompok pengguna yang benar-benar menjadi sasaran produk.
- Jelaskan kebutuhan dan tujuan masing-masing kelompok.
- Cantumkan karakteristik pengguna hanya jika berpengaruh terhadap desain atau fungsi produk.
- Jangan membuat jenis pengguna yang tidak memiliki kebutuhan atau fungsi jelas.

**Isi:**
Jelaskan siapa pengguna aplikasi, kebutuhan mereka, dan masalah yang ingin diselesaikan.

## 5. Ruang Lingkup

**Konteks penggunaan:**
Digunakan untuk membatasi pekerjaan agar pengembangan tidak melebar dan mencegah penambahan fitur di luar kebutuhan.

**Aturan pengisian:**
- Cantumkan kebutuhan dan fitur yang termasuk dalam pengembangan.
- Cantumkan fitur atau kemampuan yang secara sengaja tidak dikerjakan.
- Pastikan batasan sesuai tujuan produk.
- Jangan mencantumkan fitur yang saling bertentangan antara kedua kategori.
- Perbarui ruang lingkup jika terjadi perubahan keputusan produk.

### Termasuk
-

### Tidak Termasuk
-

## 6. Daftar Fitur

**Konteks penggunaan:**
Digunakan untuk melihat keseluruhan fitur produk dan menentukan tingkat kepentingannya.

**Aturan pengisian:**
- Setiap fitur harus memiliki nama dan deskripsi yang jelas.
- Satu baris mewakili satu fitur yang dapat diidentifikasi secara terpisah.
- Hindari menggabungkan beberapa fitur berbeda dalam satu baris.
- Pastikan fitur mendukung tujuan produk dan masuk dalam ruang lingkup.
- Gunakan prioritas berdasarkan kepentingan kebutuhan produk.
- Detail perilaku fitur dijelaskan pada bagian 7.

| Fitur | Deskripsi | Prioritas |
|---|---|---|
| | | Must Have |
| | | Should Have |
| | | Could Have |

## 7. Detail Persyaratan Fitur

**Konteks penggunaan:**
Digunakan ketika suatu fitur membutuhkan penjelasan lebih terperinci. Bagian ini menjadi acuan utama implementasi dan pengujian agar developer tidak perlu menebak perilaku yang diinginkan.

**Aturan pengisian:**
- Buat penjelasan terpisah untuk setiap fitur.
- Jelaskan perilaku yang diharapkan, bukan sekadar nama atau gambaran umum fitur.
- Tuliskan proses secara berurutan dan logis.
- Jelaskan aturan bisnis serta kondisi yang memengaruhi hasil proses.
- Cantumkan validasi untuk setiap data masukan yang relevan.
- Jelaskan kondisi berhasil dan gagal beserta respons sistem.
- Buat kriteria penerimaan yang dapat diperiksa atau diuji.
- Jangan menetapkan perilaku yang bertentangan dengan tujuan produk atau aturan bisnis.

**Informasi setiap fitur:**
- Nama fitur:
- Tujuan:
- Deskripsi:
- Data masukan:
- Proses:
- Aturan bisnis:
- Validasi:
- Kondisi berhasil:
- Kondisi gagal:
- Respons sistem:
- Kriteria penerimaan:

## 8. Alur Pengguna

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan interaksi pengguna dengan aplikasi dari awal hingga tujuan tercapai.

**Aturan pengisian:**
- Mulai dari kondisi awal pengguna.
- Jelaskan setiap langkah secara berurutan.
- Sebutkan tindakan pengguna dan respons aplikasi.
- Sertakan percabangan atau kondisi alternatif jika tersedia.
- Jelaskan kondisi akhir yang diharapkan.
- Pastikan alur sesuai dengan persyaratan fitur.
- Jangan memasukkan proses yang tidak didukung oleh kebutuhan produk.

**Isi:**
Jelaskan langkah-langkah pengguna dalam menjalankan setiap proses utama aplikasi.

## 9. Persyaratan UI/UX

**Konteks penggunaan:**
Digunakan untuk menjelaskan kebutuhan tampilan dan interaksi yang berpengaruh terhadap kemudahan penggunaan.

**Aturan pengisian:**
- Cantumkan kebutuhan tampilan dan interaksi yang berkaitan dengan fitur.
- Jelaskan navigasi dan komponen yang diperlukan.
- Jelaskan informasi yang harus ditampilkan kepada pengguna.
- Cantumkan kondisi tampilan seperti loading, kosong, berhasil, dan gagal jika relevan.
- Utamakan kemudahan penggunaan dan kejelasan fungsi.
- Jangan mengulang seluruh standar desain yang sudah tersedia di dokumen desain proyek.
- Detail standar desain mengikuti dokumen desain proyek yang berlaku.

**Isi:**
Jelaskan kebutuhan navigasi, tampilan, komponen, interaksi, dan pengalaman pengguna.

## 10. Ringkasan Kode Contoh Singkat

**Konteks penggunaan:**
Digunakan apabila contoh kode dapat membantu menjelaskan aturan bisnis, logika, validasi, atau perilaku fitur yang sulit dijelaskan hanya dengan deskripsi.

**Aturan pengisian:**
- Cantumkan kode hanya jika benar-benar membantu memahami persyaratan produk.
- Pilih contoh yang singkat dan langsung berkaitan dengan fitur.
- Gunakan bahasa pemrograman yang sesuai dengan proyek.
- Pastikan contoh kode menggambarkan aturan yang sudah dijelaskan pada PRD.
- Sertakan penjelasan mengenai fungsi kode.
- Jangan memasukkan implementasi lengkap atau detail arsitektur teknis.
- Jangan menjadikan contoh kode sebagai kewajiban implementasi apabila tidak diperlukan.
- Jika tidak ada kode yang relevan, bagian ini boleh dikosongkan.

**Informasi:**
- Nama fitur:
- Bahasa pemrograman:
- Tujuan kode:

**Contoh kode:**

```dart
bool nominalValid(double nominal) {
  return nominal > 0;
}
```

**Penjelasan:**

Kode tersebut memastikan nominal transaksi harus lebih besar dari nol.

**Catatan:** Kode hanya sebagai ilustrasi, bukan ketentuan implementasi atau kode produksi.

## 11. Hak Akses Pengguna

**Konteks penggunaan:**
Digunakan apabila aplikasi memiliki beberapa jenis pengguna atau pembatasan akses.

**Aturan pengisian:**
- Identifikasi setiap jenis pengguna yang memiliki hak akses berbeda.
- Jelaskan tindakan yang boleh dilakukan masing-masing pengguna.
- Jelaskan tindakan yang dibatasi atau tidak diperbolehkan.
- Pastikan hak akses konsisten dengan kebutuhan dan aturan bisnis.
- Jangan memberikan hak akses yang tidak diperlukan.
- Jika aplikasi hanya memiliki satu jenis pengguna tanpa pembatasan khusus, jelaskan kondisi tersebut.

| Jenis Pengguna | Hak Akses | Batasan |
|---|---|---|
| | | |

## 12. Persyaratan Data

**Konteks penggunaan:**
Digunakan untuk menjelaskan kebutuhan data yang berkaitan dengan fitur dan proses bisnis.

**Aturan pengisian:**
- Identifikasi data yang diperlukan oleh setiap proses.
- Jelaskan tujuan penggunaan masing-masing data.
- Cantumkan hubungan antar-data jika ada.
- Jelaskan aturan penyimpanan dan perubahan data.
- Jelaskan validasi serta integritas data.
- Cantumkan kebutuhan sinkronisasi jika aplikasi menggunakan lebih dari satu sumber penyimpanan.
- Bedakan kebutuhan data produk dari keputusan implementasi database.
- Jangan menetapkan data yang tidak memiliki kegunaan jelas.

**Informasi yang perlu dijelaskan:**
- Jenis data yang digunakan.
- Data yang harus disimpan.
- Hubungan antar-data.
- Aturan tambah, baca, ubah, dan hapus data.
- Validasi dan integritas data.
- Kebutuhan sinkronisasi data.

## 13. Persyaratan Nonfungsional

**Konteks penggunaan:**
Digunakan untuk menetapkan standar kualitas dan batasan operasional produk yang tidak secara langsung menjelaskan fungsi fitur.

**Aturan pengisian:**
- Cantumkan persyaratan yang benar-benar relevan dengan produk.
- Gunakan ukuran atau kondisi yang dapat diuji jika memungkinkan.
- Jelaskan kondisi yang harus dipenuhi aplikasi.
- Bedakan kebutuhan wajib dengan kebutuhan tambahan.
- Jangan membuat target angka tanpa dasar atau kebutuhan yang jelas.
- Hindari mengulang persyaratan fungsional pada bagian ini.

**Aspek yang perlu dipertimbangkan:**
- Performa.
- Keamanan.
- Privasi.
- Keandalan.
- Kompatibilitas.
- Skalabilitas.
- Kemudahan pemeliharaan.

## 14. Kriteria Penerimaan

**Konteks penggunaan:**
Digunakan sebagai dasar untuk menentukan apakah fitur sudah memenuhi persyaratan dan dapat dinyatakan selesai.

**Aturan pengisian:**
- Buat kriteria berdasarkan persyaratan fitur.
- Setiap kriteria harus jelas dan dapat diverifikasi.
- Gunakan kondisi yang menghasilkan keputusan lulus atau tidak lulus.
- Sertakan kondisi normal maupun kondisi gagal yang penting.
- Jangan menggunakan kriteria subjektif seperti "berjalan dengan baik" tanpa penjelasan.
- Jangan menyatakan fitur selesai hanya karena tampilannya sudah tersedia.
- Pastikan seluruh kriteria wajib terpenuhi sebelum fitur diterima.

**Isi:**
Tetapkan kondisi terukur yang harus dipenuhi agar fitur dan produk dinyatakan sesuai kebutuhan.

## 15. Prioritas Pengembangan

**Konteks penggunaan:**
Digunakan untuk menentukan tingkat kepentingan fitur ketika pengembangan dilakukan secara bertahap atau memiliki keterbatasan sumber daya.

**Aturan pengisian:**
- Tetapkan prioritas berdasarkan dampak terhadap tujuan utama produk.
- Pertimbangkan kebutuhan pengguna dan ketergantungan antarfitur.
- Jangan menentukan prioritas hanya berdasarkan kemudahan implementasi.
- Gunakan kategori secara konsisten.
- Fitur Won't Have tidak boleh dianggap sebagai bagian dari pengembangan versi saat ini.

**Kategori prioritas:**
- Must Have: wajib tersedia karena merupakan kebutuhan utama produk.
- Should Have: penting, tetapi tidak menghalangi fungsi utama jika belum tersedia.
- Could Have: tambahan jika sumber daya memungkinkan.
- Won't Have: tidak termasuk dalam versi pengembangan saat ini.

## 16. Risiko dan Ketergantungan

**Konteks penggunaan:**
Digunakan untuk mencatat hal-hal yang berpotensi menghambat pengembangan atau memengaruhi keberhasilan fitur.

**Aturan pengisian:**
- Cantumkan risiko yang memiliki dampak terhadap produk atau pengembangan.
- Jelaskan penyebab dan kemungkinan dampaknya.
- Identifikasi fitur, layanan, atau sumber daya yang menjadi ketergantungan.
- Tandai asumsi yang belum terverifikasi.
- Jelaskan cara mengurangi risiko jika sudah diketahui.
- Jangan memasukkan risiko yang tidak memiliki hubungan dengan proyek.

**Isi:**
Jelaskan potensi risiko, asumsi, batasan, layanan eksternal, dan ketergantungan antarfitur.

## 17. Rencana Pengembangan

**Konteks penggunaan:**
Digunakan untuk membagi pengembangan menjadi beberapa tahap atau versi agar pekerjaan memiliki urutan dan target yang jelas.

**Aturan pengisian:**
- Kelompokkan fitur berdasarkan tahap pengembangan.
- Pertimbangkan prioritas dan ketergantungan antarfitur.
- Tentukan target yang realistis.
- Pastikan setiap tahap memiliki hasil yang dapat diperiksa.
- Jangan menetapkan jadwal atau target tanpa dasar yang jelas.
- Perbarui rencana jika terdapat perubahan ruang lingkup.

| Tahap | Fitur | Target |
|---|---|---|
| | | |

## 18. Ketentuan Tambahan

**Konteks penggunaan:**
Digunakan untuk menampung keputusan atau persyaratan produk yang penting tetapi belum memiliki tempat khusus pada bagian sebelumnya.

**Aturan pengisian:**
- Masukkan hanya informasi yang belum tercakup pada bagian lain.
- Pastikan setiap ketentuan memiliki hubungan dengan produk.
- Gunakan penjelasan yang spesifik dan tidak ambigu.
- Jangan menggunakan bagian ini untuk menghindari pengisian bagian yang seharusnya.
- Hindari pengulangan informasi.

**Isi:**
Catat kebutuhan atau keputusan produk yang belum tercakup dalam bagian sebelumnya.

## 19. Riwayat Perubahan

**Konteks penggunaan:**
Digunakan untuk melacak perubahan isi PRD agar perubahan kebutuhan dan keputusan produk dapat diketahui.

**Aturan pengisian:**
- Catat setiap perubahan penting pada PRD.
- Gunakan tanggal perubahan yang sebenarnya.
- Jelaskan bagian yang berubah dan alasan perubahannya jika diketahui.
- Jangan menghapus riwayat perubahan sebelumnya.
- Perbarui catatan setiap kali ada revisi dokumen yang signifikan.

| Tanggal | Perubahan | Keterangan |
|---|---|---|
| | | |

## 20. File-File Terdampak

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi file proyek yang berkaitan dengan implementasi kebutuhan produk. Bagian ini menjadi gambaran awal cakupan perubahan kode.

**Aturan pengisian:**
- Periksa struktur proyek sebelum menentukan file terdampak.
- Cantumkan lokasi file secara spesifik berdasarkan struktur proyek sebenarnya.
- Tandai apakah file perlu dibuat, diubah, atau dihapus.
- Jelaskan alasan dan tujuan perubahan setiap file.
- Cantumkan hanya file yang memiliki hubungan dengan kebutuhan fitur.
- Jangan mengarang lokasi, nama, atau keberadaan file.
- Jika file belum dapat ditentukan, tandai sebagai belum diketahui dan jangan menebak.
- Perbarui daftar setelah analisis teknis atau implementasi apabila ditemukan file terdampak tambahan.

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
|---|---|---|
| | Dibuat / Diubah / Dihapus | |
| | Dibuat / Diubah / Dihapus | |

## 21. Referensi dari refrensi_apk.md

**Konteks penggunaan:**
Digunakan untuk memindahkan informasi relevan dari file `refrensi_apk.md` yang berada di root proyek ke dalam PRD. Tujuannya agar referensi yang berkaitan dengan kebutuhan produk terdokumentasi langsung di PRD tanpa membawa informasi yang tidak diperlukan.

**Aturan pengisian:**
- Baca seluruh isi `refrensi_apk.md` sebelum memilih referensi.
- Pindahkan hanya informasi yang memiliki hubungan langsung dengan kebutuhan produk.
- Pertahankan makna, konteks, dan detail penting dari referensi aslinya.
- Jangan sekadar mencantumkan nama atau lokasi referensi; pindahkan isi relevannya ke PRD.
- Jangan menyalin seluruh isi file sumber.
- Jangan mengarang atau menambahkan informasi yang tidak tersedia dalam referensi.
- Jangan mengubah referensi menjadi persyaratan wajib apabila sumbernya hanya memberikan inspirasi atau contoh.
- Bedakan antara referensi, keputusan produk, dan persyaratan yang sudah ditetapkan.
- Kelompokkan hasil pemindahan sesuai kategori di bawah.
- Jika tidak ada referensi yang relevan, biarkan kategori tersebut kosong.
- Jangan menghapus atau mengubah isi file sumber hanya karena kontennya sudah dipindahkan.

### 21.1 Referensi Fitur

**Konteks:** Menampung referensi mengenai fungsi, perilaku, dan gambaran fitur aplikasi.

**Aturan pengisian:**
- Pindahkan referensi fitur yang berkaitan dengan kebutuhan produk.
- Jelaskan bagian referensi yang dapat digunakan sebagai gambaran fitur.
- Jangan memasukkan fitur yang tidak direncanakan dalam ruang lingkup produk tanpa penjelasan.

-

### 21.2 Referensi UI/UX

**Konteks:** Menampung referensi mengenai tampilan, komponen antarmuka, navigasi, dan interaksi pengguna.

**Aturan pengisian:**
- Pindahkan referensi visual atau interaksi yang relevan.
- Pertahankan informasi mengenai fungsi dan tujuan elemen antarmuka.
- Jangan menganggap seluruh tampilan referensi harus disalin persis.
- Pastikan referensi tidak bertentangan dengan standar desain proyek.

-

### 21.3 Referensi Alur Pengguna

**Konteks:** Menampung referensi mengenai proses dan tahapan interaksi pengguna.

**Aturan pengisian:**
- Pindahkan alur yang berkaitan dengan proses produk.
- Pertahankan urutan langkah dan hubungan antarproses.
- Jangan menambahkan tahapan yang tidak didukung oleh referensi.
- Sesuaikan penempatan hasilnya dengan kebutuhan alur pengguna pada bagian 8.

-

### 21.4 Referensi Lainnya

**Konteks:** Menampung informasi referensi lain yang relevan tetapi tidak termasuk kategori sebelumnya.

**Aturan pengisian:**
- Masukkan hanya informasi yang mendukung pemahaman atau kebutuhan produk.
- Jelaskan konteks dan kegunaan referensi.
- Jangan menjadikan bagian ini tempat menampung seluruh konten yang tidak terpilih.
- Pastikan tidak ada duplikasi informasi dengan kategori lain.

-