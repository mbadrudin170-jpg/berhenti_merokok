# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

**Status Implementasi:** Sudah Diimplementasikan (perbaikan pada dokumen aturan)

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
- Deskripsi produk: Dokumen PRD hasil diskusi mengenai penyelarasan aturan struktur bagian PRD antara `.kilo/commands/mode/mode_diskusi.md` dan `.agents/rules/global/format_PRD.md`, beserta perbaikan aturan yang ditindaklanjuti.
- Platform: Aturan dan dokumentasi proyek Flutter `berhenti_merokok` (folder `.kilo/commands/`, `.agents/rules/global/`, `prd/hasil_diskusi/`)
- Versi: 1.0
- Status pengembangan: Selesai untuk lingkup perbaikan aturan (bukan fitur aplikasi)

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**
Menghilangkan konflik aturan mengenai jumlah dan judul bagian PRD yang wajib ditulis pada `prd/hasil_diskusi/diskusi_N.md`, agar setiap hasil diskusi berikutnya memiliki struktur yang konsisten dan tidak bergantung pada hardcode yang mudah kedaluwarsa.

Tujuan turunan:

1. Menetapkan `.agents/rules/global/format_PRD.md` sebagai satu-satunya sumber kebenaran struktur bagian PRD.
2. Menghapus penyebutan "Bagian 1 sampai Bagian 21" yang sudah tidak sesuai dengan templat PRD terbaru.
3. Menghapus penyebutan bagian PRD yang sudah dihapus dari templat (Latar Belakang, Tujuan Produk, Ruang Lingkup, Detail Persyaratan Fitur, Kriteria Penerimaan, Ketentuan Tambahan, Riwayat Perubahan).
4. Mencegah terulangnya aturan yang kedaluwarsa ketika templat PRD diperbarui di kemudian hari.

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
| Penyesuaian bagian §4.2 | Mengubah bunyi "File WAJIB mencakup seluruh bagian PRD dari Bagian 1 sampai Bagian 21" menjadi rujukan ke `format_PRD.md` sebagai sumber kebenaran. | Must Have   |
| Larangan hardcode jumlah bagian | Menambahkan aturan bahwa jumlah dan judul bagian tidak ditulis secara hardcode di `mode_diskusi.md`, serta mencantumkan 6 bagian saat ini hanya sebagai contoh yang dapat kedaluwarsa. | Must Have   |
| Penyesuaian bagian §4.6 | Mengganti daftar bagian PRD yang sudah tidak ada dengan bagian yang benar-benar berlaku: `Daftar Fitur`, `Alur Pengguna`, `Steps`, `File-File Terdampak`, plus bagian lain yang ditetapkan `format_PRD.md`. | Must Have   |
| Perbaikan penomoran butir | Merapikan penomoran butir pada bagian §4 agar tidak ada duplikasi nomor (dua butir bernomor `4`) setelah penyisipan butir baru. | Should Have |

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

1. Pengguna meminta klarifikasi bagian PRD mana yang dipakai untuk hasil diskusi, karena `mode_diskusi.md` §4.2 mensyaratkan "Bagian 1 sampai Bagian 21" sedangkan `format_PRD.md` hanya mendefinisikan 6 bagian.
2. Asisten membaca `MEMORI.md`, `kilo.jsonc`, `format_PRD.md`, `mode_diskusi.md`, dan arsip `prd/hasil_diskusi/diskusi_4.md` untuk memperoleh konteks.
3. Asisten memeriksa riwayat commit `format_PRD.md` dan menemukan bahwa templat PRD memang sengaja disederhanakan bertahap (9 bagian → 7 bagian → 6 bagian) pada 2026-11-11.
4. Asisten menyimpulkan bahwa `format_PRD.md` adalah versi terbaru dan benar, sedangkan `mode_diskusi.md` yang kedaluwarsa.
5. Asisten mengusulkan perbaikan pada `mode_diskusi.md` dan meminta persetujuan melalui tool `question`.
6. Pengguna menyetujui opsi "Ya, perbaiki mode_diskusi.md".
7. Asisten memperbaiki §4.2 dan §4.6 beserta penomoran butir, lalu memperbarui `MEMORI.md`.
8. Kondisi akhir: aturan struktur bagian PRD hanya bersumber dari `format_PRD.md`, dan hasil diskusi terdokumentasi pada `prd/hasil_diskusi/diskusi_5.md`.

Percabangan yang tidak diambil: penyeragaman nilai `**Status Dokumen:** final` menjadi `Final` pada `prd/hasil_diskusi/diskusi_4.md` (bersifat kosmetik dan tidak disetujui pengguna pada sesi ini).

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. Membaca `MEMORI.md` dan konfigurasi izin `~/.config/kilo/kilo.jsonc` sebelum melakukan tindakan apa pun.
2. Membaca `.agents/rules/global/format_PRD.md` dan `.kilo/commands/mode/mode_diskusi.md`, lalu membandingkan isinya.
3. Menjalankan `git log` dan `git show` terhadap `format_PRD.md` untuk memastikan bagian mana yang sengaja dihapus.
4. Melakukan pencarian teks (`grep`) untuk menemukan seluruh rujukan ke "Bagian 21" dan ke bagian PRD yang sudah dihapus.
5. Menyimpulkan akar masalah: penomoran 1–21 merupakan sisa templat lama, bukan bagian yang masih berlaku.
6. Mengubah bunyi §4.2 menjadi rujukan ke `format_PRD.md` tanpa menyebut angka bagian secara wajib.
7. Menambahkan butir baru yang melarang hardcode jumlah/judul bagian, dengan 6 bagian saat ini sebagai contoh.
8. Mengubah §4.6 agar hanya menyebut bagian yang benar-benar ada.
9. Memperbaiki penomoran butir pada bagian §4 agar berurutan 1–7.
10. Memverifikasi ulang dengan `grep` bahwa tidak ada sisa rujukan "Bagian 21" di seluruh berkas aturan.
11. Memperbarui `MEMORI.md` (bagian riwayat diskusi, riwayat perubahan, dan catatan lokasi hasil diskusi).

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
| `.kilo/commands/mode/mode_diskusi.md` | Diubah | Mengganti "Bagian 1 sampai Bagian 21" menjadi rujukan ke `format_PRD.md`, menambahkan larangan hardcode jumlah/judul bagian, memperbaiki daftar bagian pada §4.6, dan merapikan penomoran butir menjadi 1–7. |
| `.agents/rules/global/format_PRD.md` | Tidak diubah | Dikonfirmasi sebagai sumber kebenaran versi terbaru (6 bagian) hasil penyederhanaan commit `4ce508d`, `06634a2`, `aedb325`, dan `30ff01b`. |
| `prd/hasil_diskusi/diskusi_5.md` | Dibuat | Mendokumentasikan hasil diskusi penyelarasan aturan struktur bagian PRD ini. |
| `MEMORI.md` | Diubah | Memperbarui catatan lokasi hasil diskusi (file tertinggi menjadi `diskusi_5.md`), riwayat diskusi, dan riwayat perubahan. |
| `prd/hasil_diskusi/diskusi_4.md` | Tidak diubah | Diseragamkan status dokumen (`final` → `Final`) ditawarkan namun tidak disetujui pada sesi ini; tidak ada perubahan. |