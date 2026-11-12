# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

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

- Nama aplikasi: `berhenti_merokok`
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok (berdasarkan `MEMORI.md`).
- Platform: Flutter (Android, iOS, Web, Desktop).
- Versi: 1.0.0+1 (berdasarkan `pubspec.yaml`/`MEMORI.md`).
- Status pengembangan: Sedang Diimplementasikan (berdasarkan `MEMORI.md`).

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**

Mendokumentasikan hasil diskusi mengenai pemindahan folder hasil diskusi dari `prd/hasil_diskusi/` ke root proyek `hasil_diskusi/`, sehingga:

- Lokasi artefak hasil diskusi menjadi lebih mudah dijangkau dan terlihat pada tingkat root proyek.
- Seluruh referensi path pada command aktif, mirror `gpt/`, dan `MEMORI.md` konsisten dengan lokasi baru.
- Struktur folder `prd/` tetap dipertahankan untuk dokumen PRD lain tanpa duplikasi lokasi.

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
| Pemindahan folder hasil diskusi | Memindahkan `prd/hasil_diskusi/` menjadi `hasil_diskusi/` di root proyek beserta seluruh berkas `diskusi_N.md` di dalamnya. | Must Have |
| Penyesuaian path pada command aktif | Memperbarui path rujukan pada `.kilo/commands/mode/mode_diskusi.md` dan `.kilo/commands/kerjakan_hasil_diskusi.md` menjadi `hasil_diskusi/`. | Must Have |
| Penyesuaian path pada mirror `gpt/` | Memastikan `gpt/mode/mode_diskusi.md` dan `gpt/kerjakan_hasil_diskusi.md` memakai path root `hasil_diskusi/` sesuai keputusan pengguna. | Should Have |
| Pembaruan dokumentasi `MEMORI.md` | Memperbarui bagian `Lokasi Hasil Diskusi`, riwayat diskusi, dan changelog agar mencerminkan lokasi baru. | Must Have |
| Dokumentasi hasil diskusi | Mencatat keputusan pemindahan ini sebagai PRD `hasil_diskusi/diskusi_3.md`. | Must Have |

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

Konteks alur di sini adalah **alur kerja proses pengembangan (developer/maintainer)**, bukan alur pengguna akhir aplikasi.

**Kondisi awal:** Pengguna meminta folder `prd/hasil_diskusi/` dipindahkan ke root proyek agar artefak hasil diskusi lebih mudah dijangkau.

**Alur yang dijalankan:**

1. Pengguna menyampaikan permintaan pemindahan folder hasil diskusi ke root proyek.
2. Model memuat konteks wajib (`MEMORI.md`, rules, konfigurasi izin Kilo) dan memeriksa struktur folder `prd/` serta seluruh referensi path `hasil_diskusi` di proyek.
3. Model mengajukan pertanyaan klarifikasi melalui tool `question` (nama folder tujuan, cakupan pembaruan path, nasib folder `prd/`).
4. Pengguna memilih: nama folder `hasil_diskusi/` di root, pembaruan mencakup command aktif + `MEMORI.md` + `gpt/`, dan folder `prd/` dipertahankan.
5. Model memindahkan folder (`mkdir` + `git mv` untuk berkas tracked, `mv` untuk berkas untracked, lalu `rmdir` folder lama).
6. Model memperbarui referensi path pada command aktif dan `MEMORI.md`; memverifikasi bahwa mirror `gpt/` sudah memakai path root sehingga tidak perlu diubah.
7. Model mendokumentasikan hasil diskusi ke `hasil_diskusi/diskusi_3.md` dan memperbarui `MEMORI.md`.

**Percabangan/kondisi alternatif:** Jika pengguna memilih nama folder lain (mis. `diskusi/`) atau cakupan pembaruan yang lebih luas, path pada command, mirror `gpt/`, dan/atau berkas diskusi lama akan disesuaikan mengikuti pilihan tersebut.

**Kondisi akhir yang diharapkan:** Folder hasil diskusi berada di root `hasil_diskusi/` dan seluruh referensi path aktif konsisten dengan lokasi baru.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. Muat konteks wajib (`MEMORI.md`, rules global, `~/.config/kilo/kilo.jsonc`) sebelum melakukan tindakan apa pun.
2. Periksa struktur `prd/hasil_diskusi/` dan inventarisasi seluruh berkas yang menyebut path `hasil_diskusi`.
3. Minta keputusan pengguna melalui tool `question` untuk nama folder tujuan, cakupan pembaruan path, dan nasib folder `prd/`.
4. Pindahkan folder: `mkdir -p hasil_diskusi`, `git mv` untuk berkas tracked, `mv` untuk berkas untracked, lalu `rmdir prd/hasil_diskusi`.
5. Perbarui path pada `.kilo/commands/mode/mode_diskusi.md` dan `.kilo/commands/kerjakan_hasil_diskusi.md`.
6. Verifikasi dan sinkronkan mirror `gpt/mode/mode_diskusi.md` serta `gpt/kerjakan_hasil_diskusi.md`.
7. Perbarui `MEMORI.md`: bagian `Lokasi Hasil Diskusi`, tabel riwayat diskusi, catatan ketersediaan berkas, dan changelog.
8. Dokumentasikan hasil diskusi pada `hasil_diskusi/diskusi_3.md` sesuai `format_PRD.md`.

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
| `hasil_diskusi/diskusi_1.md` | Dihapus dari lokasi lama / dipindahkan | Dipindahkan dari `prd/hasil_diskusi/diskusi_1.md` ke root `hasil_diskusi/` menggunakan `git mv` (berkas tracked). |
| `hasil_diskusi/diskusi_2.md` | Dihapus dari lokasi lama / dipindahkan | Dipindahkan dari `prd/hasil_diskusi/diskusi_2.md` ke root `hasil_diskusi/` menggunakan `mv` (berkas untracked). |
| `prd/hasil_diskusi/` | Dihapus | Folder lama dihapus setelah seluruh isinya dipindahkan (`rmdir`). |
| `.kilo/commands/mode/mode_diskusi.md` | Diubah | Path rujukan pada bagian 3 diubah dari `prd/hasil_diskusi/` menjadi `hasil_diskusi/`. |
| `.kilo/commands/kerjakan_hasil_diskusi.md` | Diubah | Path rujukan pada deskripsi dan butir input diubah menjadi `hasil_diskusi/diskusi_N.md`. |
| `gpt/mode/mode_diskusi.md` | Tidak diubah | Sudah memakai path `hasil_diskusi/`; kini kembali benar setelah pemindahan. |
| `gpt/kerjakan_hasil_diskusi.md` | Tidak diubah | Sudah memakai path `hasil_diskusi/diskusi_N.md`; kini kembali benar setelah pemindahan. |
| `MEMORI.md` | Diubah | Bagian `Lokasi Hasil Diskusi`, tabel riwayat diskusi, catatan ketersediaan berkas, dan changelog diperbarui ke lokasi root. |
| `hasil_diskusi/diskusi_3.md` | Dibuat | Mendokumentasikan hasil diskusi pemindahan folder ini (dokumen ini). |