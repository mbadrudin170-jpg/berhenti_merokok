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

| Fitur | Deskripsi | Prioritas   |
| ----- | --------- | ----------- |
|       |           | Must Have   |
|       |           | Should Have |
|       |           | Could Have  |

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

| Lokasi File | Status Perubahan          | Deskripsi Perubahan |
| ----------- | ------------------------- | ------------------- |
|             | Dibuat / Diubah / Dihapus |                     |
|             | Dibuat / Diubah / Dihapus |                     |
