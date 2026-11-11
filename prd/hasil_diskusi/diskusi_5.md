# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft / Final

**Status Implementasi:** Belum Diimplementasikan / Sedang Diimplementasikan / Sudah Diimplementasikan

---

## 1. Informasi Produk

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi produk dan memberikan gambaran umum proyek. Informasi ini menjadi identitas utama PRD.

**Aturan pengisian:**

- Isi informasi berdasarkan kondisi dan identitas proyek yang sebenarnya.
- Gunakan nama yang konsisten dengan proyek.
- Tuliskan platform dan versi yang menjadi target pengembangan.
- Bedakan status dokumen dengan status implementasi.
- Jangan mengarang informasi yang belum diketahui.

**Informasi:**

- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Command `.kilo/commands/kerjakan_hasil_diskusi.md` untuk menindaklanjuti hasil diskusi dari file `hasil_diskusi/diskusi_N.md` dengan mengekstrak keputusan dan tindak lanjut, memetakan ke draf terstruktur `task.md` atau rekomendasi PRD, dan meminta konfirmasi sebelum menulis. Tidak mengubah kode implementasi dalam command ini.
- Platform: Flutter / Dart (repo-level command)
- Versi: 1.0.0 (draft)
- Status pengembangan: Belum Diimplementasikan

---

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**

1. Menghasilkan draf terstruktur `task.md` (atau rekomendasi PRD bila cakupan besar) dari keputusan dan tindak lanjut diskusi.
2. Memastikan hanya diskusi berstatus `Final` yang ditindaklanjuti; diskusi `Draft` tidak boleh dikerjakan walaupun ditunjuk oleh pengguna.
3. Meminta konfirmasi pengguna sebelum menulis file apapun.
4. Tidak mengubah kode implementasi dalam command ini (hanya menghasilkan draf terstruktur).
5. Menggunakan `AGENTS.md` (root) sebagai konteks wajib yang dibaca terlebih dahulu, lalu file diskusi sumber untuk validasi status, kemudian konteks lain sesuai kebutuhan.
6. Keluaran yang disetujui menjadi masukan eksekusi melalui `kerjakan_task.md` atau alur PRD.

---

## 3. Daftar Fitur

**Konteks penggunaan:**
Digunakan untuk melihat keseluruhan fitur produk dan menentukan tingkat kepentingannya.

**Aturan pengisian:**

- Setiap fitur harus memiliki nama dan deskripsi yang jelas.
- Satu baris mewakili satu fitur yang dapat diidentifikasi secara terpisah.
- Hindari menggabungkan beberapa fitur berbeda dalam satu baris.
- Pastikan fitur mendukung tujuan produk dan masuk dalam ruang lingkup.
- Gunakan prioritas berdasarkan kepentingan kebutuhan produk.

| Fitur | Deskripsi | Prioritas   |
| ----- | --------- | ----------- |
| Validasi status diskusi | Jika file diskusi berstatus `Draft`, jangan dikerjakan walaupun ditunjuk oleh pengguna; proses dihentikan dan pengguna diminta mengubah status menjadi `Final` (atau `Batal`) terlebih dahulu. Hanya diskusi berstatus `Final` yang boleh ditindaklanjuti. | Must Have |
| Ekstraksi keputusan dan tindak lanjut | Mengekstrak keputusan dan tindak lanjut dari file diskusi sumber (`hasil_diskusi/diskusi_N.md`). | Must Have |
| Pemetaan ke draf terstruktur | Memetakan hasil ekstraksi ke draf terstruktur `task.md` (sesuai `.agents/rules/global/format_task.md`) atau rekomendasi PRD bila cakupan besar. | Must Have |
| Konfirmasi sebelum menulis | Meminta konfirmasi pengguna sebelum menulis file apapun; tidak menulis tanpa persetujuan. | Must Have |
| Tidak mengubah kode implementasi | Command ini tidak mengubah kode implementasi, hanya menghasilkan draf terstruktur. | Must Have |
| Konteks wajib dibaca | Membaca `AGENTS.md` (root) terlebih dahulu, lalu file diskusi sumber untuk validasi status, kemudian konteks lain (mis. `format_task.md`, `format_PRD.md`) sesuai kebutuhan. | Must Have |
| Pilihan file sumber | File sumber `diskusi_N.md` wajib dipilih/ditentukan oleh pengguna; atau biarkan memilih diskusi `Final` terbaru. | Must Have |
| Keluaran sebagai masukan eksekusi | Keluaran yang disetujui menjadi masukan eksekusi melalui `kerjakan_task.md` atau alur PRD. | Must Have |

---

## 4. Alur Pengguna

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

1. Pengguna menentukan file sumber `hasil_diskusi/diskusi_N.md` yang akan ditindaklanjuti (atau meminta memilih diskusi `Final` terbaru).
2. Command membaca `AGENTS.md` (root) terlebih dahulu dan mematuhi aturannya.
3. Command membaca file diskusi sumber untuk memvalidasi status.
4. Jika status diskusi adalah `Draft`, proses dihentikan dan pengguna diminta mengubah status menjadi `Final` (atau `Batal`) terlebih dahulu.
5. Jika status diskusi adalah `Final`, command mengekstrak keputusan dan tindak lanjut dari file sumber.
6. Command memetakan hasil ekstraksi ke draf terstruktur `task.md` (atau rekomendasi PRD bila cakupan besar).
7. Command meminta konfirmasi pengguna sebelum menulis file apapun.
8. Setelah konfirmasi, command menulis draf terstruktur.
9. Keluaran yang disetujui menjadi masukan eksekusi melalui `kerjakan_task.md` atau alur PRD.
10. Kondisi akhir: draf task/PRD terstruktur siap dieksekusi melalui alur yang sesuai, tanpa perubahan kode implementasi pada tahap ini.

---

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. Buat command `.kilo/commands/kerjakan_hasil_diskusi.md`.
2. Definisikan input: file sumber `hasil_diskusi/diskusi_N.md` wajib dipilih/ditentukan oleh pengguna.
3. Tetapkan konteks wajib dibaca: hanya `AGENTS.md` (root) terlebih dahulu, lalu file diskusi sumber, kemudian konteks lain sesuai kebutuhan.
4. Implementasikan validasi status: jika `Draft`, hentikan proses dan minta pengguna mengubah ke `Final` (atau `Batal`); hanya `Final` yang boleh ditindaklanjuti.
5. Implementasi ekstraksi keputusan dan tindak lanjut dari file diskusi sumber.
6. Implementasi pemetaan ke draf terstruktur `task.md` (sesuai `format_task.md`) atau rekomendasi PRD bila cakupan besar.
7. Implementasi konfirmasi pengguna sebelum menulis file apapun.
8. Pastikan command tidak mengubah kode implementasi (hanya menghasilkan draf terstruktur).
9. Verifikasi keluaran dapat digunakan sebagai masukan eksekusi melalui `kerjakan_task.md` atau alur PRD.

---

## 6. File-File Terdampak

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
| `.kilo/commands/kerjakan_hasil_diskusi.md` | Dibuat | Command baru untuk menindaklanjuti hasil diskusi dari `hasil_diskusi/diskusi_N.md` menjadi draf task/PRD terstruktur. |
