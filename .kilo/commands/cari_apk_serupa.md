---
description: Cari aplikasi mobile serupa di GitHub, Google Play, F-Droid, Apple App Store, dan toko aplikasi lainnya, kemudian catat hasilnya di apk_serupa.md.
agent: code
---

# Cari Aplikasi Mobile Serupa

**Lokasi command:** `.kilo/commands/cari_apk_serupa.md`

**File hasil:** `apk_serupa.md` (direktori root proyek).

## Tujuan

Cari aplikasi mobile yang memiliki fungsi, tujuan, atau fitur serupa dengan aplikasi yang sedang dikembangkan dalam repositori ini.

Lakukan pencarian melalui GitHub, F-Droid, Google Play Store, Apple App Store, dan berbagai toko aplikasi mobile lainnya.

Seluruh hasil pencarian wajib dicatat ke dalam file `apk_serupa.md` di direktori root proyek.

## 1. Pahami Aplikasi yang Sedang Dikembangkan

Sebelum melakukan pencarian, pelajari terlebih dahulu aplikasi yang ada di repositori agar hasil pencarian benar-benar relevan.

1. Baca `AGENTS.md` dan seluruh aturan proyek yang relevan dengan tugas ini.
2. Baca `README.md` apabila tersedia.
3. Periksa dokumentasi proyek yang menjelaskan tujuan, fungsi, dan fitur aplikasi.
4. Identifikasi:
   - Tujuan utama aplikasi.
   - Permasalahan yang ingin diselesaikan.
   - Target pengguna.
   - Kategori aplikasi.
   - Fitur-fitur utama.
   - Platform mobile yang didukung.
5. Apabila dokumentasi belum cukup menjelaskan fungsi aplikasi, periksa bagian kode dan halaman UI yang relevan untuk memahami fitur sebenarnya.

Jangan mengubah kode, konfigurasi, atau file proyek lainnya selama proses pencarian.

## 2. Batasan Aplikasi yang Dicari

**Hanya cari aplikasi untuk perangkat mobile.**

Dalam command ini, istilah APK serupa mencakup aplikasi mobile Android dan iOS karena sumber pencarian juga mencakup Apple App Store.

Aplikasi yang boleh dicari:

- Aplikasi Android.
- Aplikasi iOS.
- Aplikasi mobile lintas platform seperti Flutter dan React Native.
- Aplikasi mobile yang tersedia melalui toko aplikasi resmi maupun alternatif.
- Aplikasi mobile open-source yang tersedia di GitHub.

Aplikasi yang tidak boleh dimasukkan:

- Website biasa.
- Aplikasi desktop.
- Aplikasi web yang tidak memiliki versi mobile.
- Backend atau layanan API.
- Library, framework, SDK, dan package yang bukan aplikasi mobile.
- Template UI atau komponen yang bukan aplikasi mobile.
- Proyek yang hanya memiliki kesamaan teknologi, tetapi tidak memiliki kesamaan fungsi dengan aplikasi yang sedang dikembangkan.

Jangan memasukkan suatu proyek hanya karena memiliki kata kunci atau teknologi yang sama.

## 3. Sumber Pencarian

Lakukan pencarian secara sistematis melalui sumber-sumber berikut.

### A. GitHub

Cari repositori aplikasi mobile yang memiliki fungsi serupa.

Periksa apakah repositori tersebut benar-benar merupakan proyek aplikasi mobile, bukan sekadar library atau backend.

Utamakan repositori yang:

- Memiliki README atau dokumentasi fungsi aplikasi.
- Memiliki struktur proyek Android atau iOS.
- Menyediakan screenshot atau demonstrasi aplikasi.
- Menyediakan APK atau hasil build melalui GitHub Releases apabila tersedia.

Gunakan tautan repositori atau halaman Releases yang sesuai.

### B. F-Droid

Cari aplikasi Android open-source yang memiliki fungsi serupa.

Utamakan tautan halaman aplikasi di F-Droid.

### C. Google Play Store

Cari aplikasi Android yang memiliki fungsi dan tujuan serupa.

Utamakan tautan langsung ke halaman aplikasi di Google Play Store.

### D. Apple App Store

Cari aplikasi iOS dengan fungsi dan tujuan serupa.

Utamakan tautan langsung ke halaman aplikasi di Apple App Store.

### E. Toko Aplikasi Lainnya

Jangan membatasi pencarian hanya pada empat sumber di atas.

Cari juga melalui toko aplikasi mobile lainnya yang relevan, antara lain:

- Samsung Galaxy Store.
- Huawei AppGallery.
- Amazon Appstore.
- Xiaomi GetApps.
- APKPure.
- Aptoide.
- Uptodown.
- Toko aplikasi mobile lainnya yang dapat ditemukan.

Daftar tersebut bukan batas maksimal sumber pencarian. Gunakan sumber tambahan apabila ditemukan toko aplikasi lain yang relevan.

## 4. Strategi Pencarian

Agar hasil pencarian tidak terlalu sempit, lakukan pencarian dengan beberapa variasi kata kunci.

Gunakan informasi dari aplikasi proyek untuk menyusun kata kunci berdasarkan:

- Nama atau kategori aplikasi.
- Tujuan utama aplikasi.
- Masalah yang diselesaikan.
- Fitur utama.
- Kebutuhan target pengguna.
- Istilah lain atau sinonim yang umum digunakan.
- Kata kunci dalam bahasa Indonesia dan bahasa Inggris.

Cari berdasarkan fungsi aplikasi secara keseluruhan maupun fitur-fitur utamanya.

Jangan hanya menggunakan nama aplikasi proyek sebagai kata kunci pencarian.

Gunakan fasilitas pencarian web yang tersedia untuk menemukan halaman aplikasi secara langsung. Periksa hasil pencarian melalui halaman sumbernya sebelum memasukkannya ke daftar.

Lakukan pencarian pada setiap sumber yang relevan. Jangan langsung berhenti setelah menemukan beberapa aplikasi.

## 5. Kriteria Pemilihan Hasil

Masukkan aplikasi apabila memenuhi kriteria berikut:

1. Benar-benar merupakan aplikasi mobile.
2. Memiliki fungsi atau tujuan yang serupa dengan aplikasi proyek.
3. Memiliki setidaknya satu kesamaan fungsi atau fitur utama yang relevan.
4. Informasi keberadaan aplikasi dapat diverifikasi melalui halaman toko atau repositori sumbernya.
5. Memiliki tautan langsung yang sesuai dengan aplikasi tersebut.

Prioritaskan aplikasi dengan tingkat kesamaan fungsi paling tinggi.

Jangan mengarang nama aplikasi, deskripsi, toko aplikasi, maupun tautan.

Apabila informasi suatu aplikasi tidak dapat diverifikasi, jangan memasukkannya ke dalam hasil.

Untuk aplikasi yang tersedia di beberapa toko, setiap tautan toko yang berbeda boleh dicatat sebagai entri tersendiri.

Untuk GitHub, pastikan repositorinya memang berisi aplikasi mobile. Jangan menganggap setiap repositori yang berkaitan dengan kategori aplikasi sebagai aplikasi mobile.

## 6. Format Hasil

Semua hasil pencarian harus dimasukkan ke dalam file:

`apk_serupa.md`

Lokasi file wajib berada di direktori root proyek, bukan di dalam `lib/`, `docs/`, atau folder lainnya.

Gunakan format Markdown berupa tabel dengan empat kolom berikut:

| Nama Aplikasi | Ringkasan Singkat                                                              | Store             | Link                    |
| ------------- | ------------------------------------------------------------------------------ | ----------------- | ----------------------- |
| Nama aplikasi | Penjelasan singkat mengenai fungsi aplikasi dan kesamaannya dengan proyek ini. | Google Play Store | [Buka Aplikasi](LINK)   |
| Nama aplikasi | Penjelasan singkat mengenai fungsi aplikasi dan kesamaannya dengan proyek ini. | GitHub            | [Buka Repositori](LINK) |

Ketentuan pengisian:

- **Nama Aplikasi:** Gunakan nama asli yang tercantum pada halaman aplikasi atau repositori.
- **Ringkasan Singkat:** Jelaskan fungsi utama aplikasi dan alasan aplikasi tersebut relevan dengan proyek ini. Gunakan bahasa Indonesia yang jelas dan ringkas.
- **Store:** Cantumkan nama toko aplikasi atau sumber tempat aplikasi tersebut ditemukan, misalnya GitHub, F-Droid, Google Play Store, atau Apple App Store.
- **Link:** Cantumkan tautan langsung menuju halaman aplikasi atau repositorinya.

Jangan menambahkan kolom lain.

Jangan memasukkan informasi seperti rating, jumlah unduhan, harga, ulasan, teknologi, atau riwayat pengembangan karena tidak termasuk informasi yang diminta.

## 7. Aturan Pengelolaan File

Sebelum menulis hasil, periksa apakah `apk_serupa.md` sudah tersedia di root proyek.

Apabila file belum tersedia:

- Buat `apk_serupa.md`.
- Tambahkan judul `# Daftar Aplikasi Mobile Serupa`.
- Buat tabel sesuai format yang ditentukan.

Apabila file sudah tersedia:

- Baca seluruh isinya terlebih dahulu.
- Pertahankan hasil pencarian dan informasi yang sudah ada.
- Jangan menghapus isi yang dibuat atau ditambahkan sebelumnya.
- Tambahkan hasil baru yang belum tercatat.
- Periksa duplikasi berdasarkan nama aplikasi, store, dan tautan.
- Apabila entri yang sama sudah tersedia, jangan menambahkannya kembali.
- Perbarui informasi yang sudah ada hanya apabila ditemukan informasi yang lebih akurat atau tautan yang lebih tepat.
- Pertahankan format tabel empat kolom.

Jangan mengubah file lain.

## 8. Batasan Perubahan

Tugas ini hanya mencakup:

1. Membaca informasi proyek yang diperlukan.
2. Melakukan pencarian aplikasi mobile serupa.
3. Memverifikasi hasil pencarian.
4. Membuat atau memperbarui `apk_serupa.md` di root proyek.

**Dilarang:**

- Mengubah kode sumber aplikasi.
- Mengubah tampilan atau fitur aplikasi.
- Memasang package atau dependency.
- Mengubah konfigurasi proyek.
- Membuat file dokumentasi lain.
- Mengubah aturan proyek.
- Melakukan refactoring atau perubahan lain yang tidak berkaitan dengan tugas ini.

## 9. Laporan Hasil

Setelah pencarian selesai dan file berhasil diperbarui, berikan laporan singkat yang mencakup:

1. Lokasi file hasil: `apk_serupa.md`.
2. Jumlah aplikasi mobile yang berhasil ditemukan dan dicatat.
3. Sumber atau toko aplikasi tempat hasil ditemukan.
4. Kendala pencarian apabila ada.

Jangan menyatakan tugas selesai apabila file belum berhasil dibuat atau diperbarui.

Apabila suatu sumber tidak dapat diakses, jelaskan keterbatasannya. Jangan mengganti hasil yang tidak ditemukan dengan informasi yang dibuat-buat.

**Fokus utama: temukan sebanyak mungkin aplikasi mobile yang benar-benar relevan dengan proyek ini, verifikasi hasilnya, dan catat hanya empat informasi yang diminta ke dalam `apk_serupa.md`.**
