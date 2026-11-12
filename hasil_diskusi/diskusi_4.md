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

Mendokumentasikan hasil diskusi mengenai pembuatan aturan format berkas hasil diskusi, sehingga:

- Format, lokasi, penamaan, status, dan kewajiban pencatatan berkas hasil diskusi terdokumentasi pada satu berkas aturan yang jelas.
- Setiap orang dan AI yang membuat atau memperbarui berkas `hasil_diskusi/diskusi_N.md` menghasilkan isi yang konsisten.
- Rujukan antara mode diskusi, aturan format PRD, dan aturan format hasil diskusi menjadi eksplisit dan tidak saling bertentangan.

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
| Aturan format hasil diskusi | Menetapkan lokasi `hasil_diskusi/`, format `diskusi_N.md`, aturan penomoran, struktur isi, status, dan pencatatan `MEMORI.md`. | Must Have |
| Rujukan ke `format_PRD.md` | Menetapkan `format_PRD.md` sebagai sumber kebenaran struktur PRD dan aturan ini sebagai sumber kebenaran hal khusus hasil diskusi. | Must Have |
| Penyelarasan `mode_diskusi.md` | Mengubah bagian 3 dan 4 pada `.kilo/commands/mode/mode_diskusi.md` agar merujuk ke aturan format hasil diskusi. | Must Have |
| Pendaftaran instruksi Kilo | Mendaftarkan berkas aturan pada `instructions` di `~/.config/kilo/kilo.jsonc` agar selalu dimuat setiap sesi. | Must Have |
| Checklist penulisan | Menyediakan checklist verifikasi sebelum berkas hasil diskusi dianggap selesai. | Should Have |

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

**Kondisi awal:** Pengguna ingin membuat berkas aturan khusus untuk format berkas hasil diskusi, karena ketentuan format tersebar di `mode_diskusi.md` dan `format_PRD.md`.

**Alur yang dijalankan:**

1. Pengguna menyampaikan permintaan pembuatan file rules untuk format berkas hasil diskusi.
2. Model memuat konteks wajib (`MEMORI.md`, skill `memori-check`, inventaris `.agents/rules/global/`) dan memeriksa pola aturan yang sudah ada (`format_PRD.md`, `format_task.md`).
3. Model mengajukan pertanyaan klarifikasi melalui tool `question` (nama file, relasi dengan `format_PRD.md`, pendaftaran `instructions`, pembaruan `mode_diskusi.md`).
4. Pengguna memilih: `format_hasil_diskusi.md`, aturan khusus yang merujuk `format_PRD.md`, didaftarkan ke `instructions`, dan `mode_diskusi.md` diperbarui.
5. Model membuat `.agents/rules/global/format_hasil_diskusi.md` dengan bagian tujuan, cakupan, hubungan dengan `format_PRD.md`, aturan lokasi/penamaan, struktur isi, status, pencatatan, larangan, contoh kerangka, dan checklist.
6. Model memperbarui `.kilo/commands/mode/mode_diskusi.md` bagian 3 dan 4 agar merujuk ke aturan baru.
7. Model mendaftarkan aturan baru pada `instructions` di `~/.config/kilo/kilo.jsonc`.
8. Model memperbarui `MEMORI.md` dan mendokumentasikan hasil diskusi pada `hasil_diskusi/diskusi_4.md`.

**Percabangan/kondisi alternatif:** Jika pengguna memilih aturan hanya berupa rujukan tanpa aturan tambahan, atau memilih tidak mendaftarkan ke `instructions`, langkah 5 dan 7 akan disesuaikan.

**Kondisi akhir yang diharapkan:** Tersedia satu berkas aturan format hasil diskusi yang konsisten, terhubung eksplisit ke `format_PRD.md` dan `mode_diskusi.md`, serta dimuat otomatis oleh Kilo.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. Muat `MEMORI.md` dan skill `memori-check` sebelum melakukan tindakan apa pun.
2. Inventarisasi `.agents/rules/global/` untuk mengetahui pola penamaan dan gaya aturan yang sudah ada.
3. Minta keputusan pengguna melalui tool `question` mengenai nama file, relasi dengan `format_PRD.md`, pendaftaran `instructions`, dan pembaruan `mode_diskusi.md`.
4. Buat `.agents/rules/global/format_hasil_diskusi.md` dengan struktur aturan yang jelas dan rujukan eksplisit ke `format_PRD.md`.
5. Perbarui `.kilo/commands/mode/mode_diskusi.md` bagian 3 dan 4 agar merujuk ke aturan baru.
6. Daftarkan berkas aturan pada `instructions` di `~/.config/kilo/kilo.jsonc`.
7. Perbarui `MEMORI.md` pada bagian `Lokasi Hasil Diskusi`, `Riwayat Diskusi`, dan `Riwayat Perubahan`.
8. Dokumentasikan hasil diskusi pada `hasil_diskusi/diskusi_4.md` sesuai `format_PRD.md` dan `format_hasil_diskusi.md`.

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
| `.agents/rules/global/format_hasil_diskusi.md` | Dibuat | Aturan format berkas hasil diskusi: lokasi, penamaan, penomoran, struktur, status, pencatatan, dan larangan. |
| `.kilo/commands/mode/mode_diskusi.md` | Diubah | Bagian 3 dan 4 ditambahi rujukan ke aturan baru; penomoran butir disesuaikan. |
| `~/.config/kilo/kilo.jsonc` | Diubah | Ditambahkan `.agents/rules/global/format_hasil_diskusi.md` ke array `instructions`. |
| `MEMORI.md` | Diubah | Bagian `Lokasi Hasil Diskusi`, riwayat diskusi, dan changelog diperbarui. |
| `hasil_diskusi/diskusi_4.md` | Dibuat | Mendokumentasikan hasil diskusi pembuatan aturan format hasil diskusi (dokumen ini). |
| `docs/struktur_rules.md` | Belum ditentukan | Berkas ringkasan aturan ini sudah usang (memuat banyak berkas aturan yang tidak ada) dan belum diperbarui; diputuskan tidak diubah pada diskusi ini. |