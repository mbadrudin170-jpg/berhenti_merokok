# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft

**Status Implementasi:** Sudah Diimplementasikan

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

- Nama aplikasi: berhenti_merokok
- Deskripsi produk: Perbaikan pada perintah agen `perbarui_skills_index` yang memindai seluruh `SKILL.md` di `.agents/skills/**/` lalu menulis indeks ke `SKILLS_INDEX.md`. Perbaikan menambahkan mekanisme validasi dan pelaporan agar pengguna diberi tahu ketika ditemukan skill yang berada di luar kategori standar `bawaan`/`custom`, skill tanpa `metadata.kategori`, atau konflik antara folder dan `metadata.kategori`.
- Platform: Perkakas perintah agen (Kilo command, `.kilo/commands/*.md`) yang berjalan di dalam proyek Flutter `berhenti_merokok`.
- Versi: 1.0.0+1 (versi proyek)
- Status pengembangan: Perintah `perbarui_skills_index.md` sudah ada dan berfungsi; bagian validasi/pelaporan anomali belum ada.

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**
PRD ini bertujuan menghilangkan "kebisuan" perintah `perbarui_skills_index.md` saat menemui skill yang tidak sesuai kategori standar. Hasil yang diharapkan:

1. Perintah menetapkan satu sumber kebenaran kategori, yaitu **folder fisik** skill (`bawaan` atau `custom`), karena skill bawaan tidak memiliki field `metadata.kategori`.
2. Perintah mendeteksi dan **melaporkan** skill yang berada di luar folder `bawaan`/`custom` (mis. langsung di `.agents/skills/<nama>/`).
3. Perintah mendeteksi dan **melaporkan** skill yang tidak memiliki `metadata.kategori`.
4. Perintah mendeteksi dan **melaporkan** konflik antara folder dan `metadata.kategori`.
5. Perintah menampilkan ringkasan jumlah skill per kategori beserta daftar anomali, sehingga pengguna selalu mengetahui kondisi sebenarnya.

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
| Sumber kategori berbasis folder | Kategori skill ditentukan dari folder fisik induk (`bawaan`/`custom`), bukan dari `metadata.kategori`, karena skill bawaan tidak memiliki field tersebut. | Must Have |
| Deteksi skill di luar kategori standar | Menandai skill yang tidak berada di `.agents/skills/bawaan/` maupun `.agents/skills/custom/` (mis. langsung di `.agents/skills/`). | Must Have |
| Deteksi `metadata.kategori` kosong | Menandai skill yang tidak memiliki field `metadata.kategori` di front matter. | Must Have |
| Deteksi konflik folder vs `metadata.kategori` | Menandai skill yang folder fisiknya berbeda dengan nilai `metadata.kategori`. | Should Have |
| Ringkasan dan laporan anomali | Menampilkan total skill, jumlah per kategori, dan daftar anomali di output; laporan tidak boleh diam ketika ada anomali. | Must Have |
| Format waktu Asia/Jakarta | Seluruh timestamp pada indeks memakai format `TZ=Asia/Jakarta date`. | Must Have |

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

1. Pengguna menjalankan perintah `perbarui_skills_index` (Mode Command) untuk memperbarui `SKILLS_INDEX.md`.
2. Perintah memindai seluruh `SKILL.md` di `.agents/skills/**/` dan membaca front matter setiap file.
3. Perintah menentukan kategori tiap skill dari **folder fisik** induknya (`bawaan` atau `custom`).
4. Perintah menjalankan validasi: mendeteksi skill di luar folder standar, `metadata.kategori` kosong, dan konflik folder vs `metadata.kategori`.
5. Jika ditemukan anomali, perintah **menampilkan laporan anomali** (daftar file + jenis anomali) dan ringkasan jumlah per kategori; jika tidak ada anomali, perintah menampilkan ringkasan "tidak ada anomali".
6. Perintah menulis `SKILLS_INDEX.md` di root proyek sesuai kategori dan urutan alfabetis.
7. Kondisi akhir: pengguna mengetahui persis apakah ada skill yang menyimpang, dan `SKILLS_INDEX.md` selalu mencerminkan kondisi folder sebenarnya.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. Ubah bagian "Alur Kerja" pada `.kilo/commands/perbarui_skills_index.md`: tegaskan bahwa kategori berasal dari folder fisik induk (`bawaan`/`custom`), bukan dari `metadata.kategori`.
2. Tambahkan langkah validasi yang mendeteksi tiga anomali: (a) skill di luar folder `bawaan`/`custom`, (b) `metadata.kategori` kosong, (c) konflik folder vs `metadata.kategori`.
3. Tambahkan langkah pelaporan: cetak ringkasan total per kategori dan daftar anomali (path + jenis anomali); jika kosong, cetak "tidak ada anomali".
4. Tambahkan bagian "Laporan Anomali" (atau setara) ke output agar pengguna selalu diberi tahu.
5. Perbarui `SKILLS_INDEX.md` agar konsisten (kategori bawaan tetap 33 entri, custom 53 entri) dan verifikasi tidak ada entri yang hilang.
6. Verifikasi akhir: jalankan pengecekan jumlah (33 bawaan + 53 custom = 86) dan pastikan laporan anomali tampil benar.

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
| `.kilo/commands/perbarui_skills_index.md` | Diubah | Menetapkan sumber kategori dari folder fisik, menambah langkah validasi (skill di luar `bawaan`/`custom`, `metadata.kategori` kosong, konflik folder vs kategori) dan laporan anomali. |
| `SKILLS_INDEX.md` | Diubah | Diperbarui agar konsisten dengan hasil scan terbaru (33 bawaan + 53 custom) dan mencerminkan aturan kategori berbasis folder. |
| `MEMORI.md` | Diubah | Mengoreksi catatan usang ("folder `bawaan` kosong") dan mencatat riwayat diskusi/perubahan. |