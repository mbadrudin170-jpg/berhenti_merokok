# INSTRUKSI PEMASANGAN CUSTOM COMMAND KILO CODE

## Mode

Pemasangan custom command. Jangan menjalankan command setelah pemasangan.

## Tujuan

Buat atau perbarui custom command Kilo Code dengan menyalin seluruh definisi command yang tersedia di bawah ini.

## Ketentuan pemasangan

1. Baca `AGENTS.md` di root repository terlebih dahulu.
2. Baca aturan tambahan yang relevan dengan pembuatan atau perubahan custom command.
3. Pastikan direktori `.kilo/commands/` tersedia. Buat jika belum ada.
4. Buat atau perbarui file berikut:

   `.kilo/commands/referensi_apk_sejenis.md`

5. Salin seluruh isi definisi command di bawah ini secara utuh. Jangan meringkas, mengubah urutan, atau menghilangkan instruksi.
6. Pertahankan YAML frontmatter pada awal file, termasuk `description` dan `agent: code`.
7. Pastikan nama slash command menjadi `/referensi_apk_sejenis`.
8. Path file hasil riset wajib tetap `refrensi_apk.md` di root proyek.
9. Jangan menjalankan `/referensi_apk_sejenis` setelah memasangnya.
10. Jangan membuat atau mengubah `refrensi_apk.md` selama proses pemasangan.
11. Jangan mengubah file lain, kode sumber, konfigurasi, dependency, maupun aturan proyek.
12. Jangan membuat commit.
13. Setelah selesai, baca kembali file target dan periksa seluruh isinya.
14. Tampilkan diff dan hasil `git status --short`.

---

# DEFINISI CUSTOM COMMAND

Salin seluruh isi di antara batas berikut ke file target.

````markdown
---
description: Riset aplikasi mobile sejenis, temukan peluang fitur, evaluasi optimasi fitur, analisis UI/UX, lalu perbarui refrensi_apk.md di root proyek
agent: code
---

# Riset Referensi Aplikasi Mobile Sejenis

## Identitas dan lokasi file

- **Path command:** `.kilo/commands/referensi_apk_sejenis.md`
- **Nama command:** `/referensi_apk_sejenis`
- **Path file hasil riset:** `./refrensi_apk.md` (root proyek)
- **Jenis pekerjaan:** riset aplikasi mobile, evaluasi fitur, analisis UI/UX, dan pembaruan dokumentasi referensi.

## Tujuan

Lakukan riset terhadap aplikasi mobile lain yang memiliki kategori, tujuan, atau fitur yang sama dengan aplikasi dalam proyek ini. Gunakan tools pencarian, penelusuran halaman, inspeksi gambar/screenshot, browser, dan MCP yang benar-benar tersedia pada sesi Kilo Code.

Hasil riset harus membantu pemilik proyek untuk:

1. Menemukan fitur tambahan dari aplikasi sejenis yang layak dipertimbangkan untuk proyek ini.
2. Menemukan cara yang lebih baik untuk mengoptimalkan fitur yang sebenarnya sudah tersedia di proyek.
3. Membandingkan aplikasi kompetitor yang memiliki fitur sejenis, kemudian mengidentifikasi pola UI, UX, dan layout mereka.
4. Mendapatkan rekomendasi berdasarkan bukti dan tautan sumber agar pemilik proyek dapat menyortir sendiri fitur maupun saran desain yang akan digunakan.
5. Menyimpan seluruh hasil riset yang relevan ke `refrensi_apk.md` di root proyek.

**Penting:** command ini hanya melakukan riset dan memperbarui file `refrensi_apk.md`. Jangan mengimplementasikan fitur, mengubah UI aplikasi, membuat roadmap, atau mengubah file proyek lain.

---

## 1. Baca aturan dan pahami proyek terlebih dahulu

Jangan memulai pencarian aplikasi kompetitor sebelum memahami proyek dan aturan yang berlaku.

### 1.1. Baca aturan proyek

1. Periksa keberadaan `AGENTS.md` di root proyek dan baca seluruh isinya terlebih dahulu.
2. Ikuti instruksi, urutan kerja, dan referensi dokumen yang diwajibkan oleh `AGENTS.md`.
3. Cari serta baca aturan tambahan yang benar-benar ditemukan dan relevan, misalnya `AGENTS.md` pada direktori terkait, `.kilo/rules/`, `.kilocode/rules/`, `.agents/`, `prompt/aturan/`, atau lokasi aturan lain yang disebutkan oleh proyek.
4. Baca aturan dokumentasi atau aturan riset apabila proyek memilikinya.
5. Jangan menganggap semua file Markdown sebagai aturan. Pastikan isi dan konteks file tersebut memang menetapkan instruksi.
6. Jika ada konflik aturan, catat path dan inti aturan yang bertentangan. Ikuti prioritas yang sudah dinyatakan secara eksplisit. Jika tidak ada aturan prioritas yang jelas, jangan memilih sendiri; laporkan konflik tersebut.

### 1.2. Pahami aplikasi dari kondisi proyek yang sebenarnya

Periksa struktur dan file proyek untuk mengetahui:

- Nama dan tujuan aplikasi.
- Kategori atau bidang aplikasi.
- Platform yang benar-benar didukung, terutama Android dan/atau iOS.
- Pengguna sasaran dan masalah utama yang diselesaikan aplikasi.
- Fitur yang sudah diterapkan, fitur yang masih dalam pengembangan, dan fitur yang belum tersedia.
- Alur penggunaan utama dari awal sampai selesai.
- Navigasi, halaman, komponen, dan pola UI/UX yang sedang digunakan.
- Batasan teknis atau produk yang relevan untuk menilai apakah suatu fitur dapat digunakan pada perangkat mobile.

Gunakan file dan kode aktual sebagai bukti. Periksa berkas konfigurasi platform, manifest, daftar dependensi, dokumentasi proyek, struktur direktori fitur, halaman, navigasi, provider/state, dan implementasi terkait sesuai teknologi proyek.

Untuk setiap fitur penting yang ditemukan, catat bukti internal proyek berupa path file dan nama halaman, class, fungsi, atau komponen yang relevan apabila dapat diketahui. Jangan menyimpulkan bahwa fitur belum tersedia hanya karena tidak ditemukan dari nama file; lakukan pencarian dan pemeriksaan implementasi yang relevan terlebih dahulu.

Periksa juga dokumen produk seperti `README.md`, `task.md`, `rencana_fitur_baru.md`, atau dokumen sejenis apabila benar-benar tersedia dan relevan. Dokumen tersebut hanya menjadi konteks tambahan; kondisi implementasi tetap harus diverifikasi dari proyek.

### 1.3. Periksa file hasil riset yang sudah ada

Sebelum menulis hasil:

1. Periksa apakah `./refrensi_apk.md` sudah tersedia.
2. Jika tersedia, baca seluruh isinya agar informasi lama yang masih relevan tidak hilang.
3. Identifikasi referensi, rekomendasi, dan keputusan yang sudah tercatat.
4. Jangan membuat entri duplikat. Perbarui entri lama jika sumbernya berubah, informasinya bertambah, atau penilaiannya perlu dikoreksi.
5. Pertahankan catatan atau keputusan pemilik proyek yang masih relevan. Jangan menghapusnya hanya karena riset baru menghasilkan alternatif lain.
6. Jika file belum tersedia, buat file baru dengan struktur pada bagian **Format `refrensi_apk.md`**.

---

## 2. Temukan dan gunakan tools riset yang tersedia

### 2.1. Inventarisasi kemampuan tools

Periksa tools yang tersedia pada sesi Kilo Code sebelum menggunakannya. Gunakan nama dan parameter sesuai tools yang benar-benar tersedia.

Prioritaskan kemampuan berikut jika tersedia:

- Pencarian web untuk menemukan aplikasi, halaman Google Play, App Store, situs pengembang, dokumentasi, ulasan, dan demonstrasi aplikasi.
- Pengambilan isi halaman web untuk memverifikasi informasi aplikasi dan fitur.
- Browser atau browser automation untuk membuka halaman dan memeriksa konten yang dapat diakses.
- Pencarian gambar atau pembacaan gambar untuk memeriksa screenshot aplikasi.
- MCP yang memang sudah terpasang dan menyediakan pencarian aplikasi, informasi store, screenshot, browser, atau kemampuan riset lain yang relevan.

Jangan menganggap suatu MCP, browser automation, atau layanan tertentu pasti sudah terpasang. Temukan dahulu tool yang tersedia. Jangan memasang MCP, mengubah konfigurasi Kilo, meminta API key, atau mengubah permission dalam command ini.

### 2.2. Strategi pencarian

1. Susun kata kunci berdasarkan kategori aplikasi, tujuan aplikasi, nama fitur yang sudah ditemukan, dan masalah pengguna yang diselesaikan.
2. Cari aplikasi Android sejenis terlebih dahulu melalui Google Play atau sumber resmi pengembang.
3. Gunakan App Store sebagai referensi tambahan jika aplikasi iOS tersebut memiliki fungsi yang relevan. Jangan menyebut aplikasi iOS sebagai APK Android.
4. Cari aplikasi kompetitor langsung dan aplikasi dari kategori lain yang memiliki implementasi fitur tertentu yang dapat dibandingkan secara masuk akal.
5. Untuk setiap fitur utama proyek, cari aplikasi yang benar-benar memiliki fungsi yang sama atau alur penggunaan yang sebanding.
6. Jangan memasukkan aplikasi hanya karena populer. Kesesuaian kategori, fungsi, alur, dan kebutuhan pengguna lebih penting daripada popularitas.
7. Buka sumber yang ditemukan dan verifikasi bahwa halaman, aplikasi, atau informasi yang dirujuk benar-benar relevan.

### 2.3. Urutan kualitas sumber

Gunakan sumber dengan urutan kepercayaan berikut:

1. Halaman aplikasi resmi di Google Play atau App Store.
2. Situs resmi pengembang, halaman fitur resmi, pusat bantuan, panduan pengguna, dokumentasi, dan catatan rilis resmi.
3. Screenshot resmi yang disediakan di halaman store atau situs pengembang.
4. Video demonstrasi atau walkthrough yang dapat diidentifikasi berasal dari pengembang atau memperlihatkan aplikasi yang dimaksud secara jelas.
5. Ulasan pengguna dan sumber pihak ketiga tepercaya sebagai bahan tambahan untuk menemukan masalah penggunaan atau memvalidasi konteks.

Jangan menjadikan deskripsi promosi sebagai bukti bahwa seluruh alur fitur benar-benar tersedia. Cocokkan informasi penting dengan sumber lain apabila memungkinkan.

Jangan mengunduh atau memasang APK dari situs mirror yang tidak tepercaya. Tidak perlu memasang APK untuk menyelesaikan riset ini. Utamakan halaman store resmi, screenshot resmi, dokumentasi, dan demonstrasi yang dapat diperiksa dengan aman.

### 2.4. Jika tools tidak tersedia

- Jika `websearch` tidak tersedia, periksa apakah ada tool pencarian lain yang dapat digunakan.
- Jika browser automation tidak tersedia, gunakan halaman web dan sumber visual publik yang dapat diakses.
- Jika inspeksi gambar tidak tersedia, jangan mengaku telah memeriksa tampilan visual. Cantumkan keterbatasan tersebut.
- Jika tidak ada kemampuan pencarian web atau sumber eksternal yang dapat diakses, jangan mengarang aplikasi, fitur, screenshot, URL, maupun hasil analisis. Laporkan bahwa riset eksternal tidak dapat diverifikasi dan jangan mengisi file dengan dugaan.
- Jangan menyatakan telah membuka, memasang, atau mencoba aplikasi jika tindakan tersebut tidak benar-benar dilakukan.

---

## 3. Batasan: hanya fitur yang dapat digunakan pada perangkat mobile

Semua fitur baru yang disarankan harus dapat dijalankan dan digunakan melalui aplikasi pada perangkat mobile.

### 3.1. Fitur yang boleh dipertimbangkan

- Fitur yang alur utama penggunaannya tersedia di aplikasi Android atau iOS.
- Fitur yang memanfaatkan kamera, lokasi, notifikasi, penyimpanan lokal, sensor, biometrik, konektivitas, atau kemampuan perangkat mobile apabila relevan.
- Fitur yang menggunakan backend, API, sinkronisasi cloud, atau layanan eksternal, selama interaksi dan penggunaan utamanya tetap dapat dilakukan melalui aplikasi mobile.
- Fitur yang mendukung penggunaan offline atau kondisi jaringan terbatas apabila memang relevan dengan kebutuhan aplikasi.

### 3.2. Fitur yang tidak boleh disarankan

- Fitur yang hanya bisa digunakan melalui aplikasi desktop.
- Fitur yang mengharuskan pengguna membuka dashboard web atau komputer untuk menyelesaikan alur utamanya.
- Fitur administratif yang tidak memiliki alur penggunaan mobile dan tidak relevan dengan aplikasi mobile pengguna.
- Fitur yang hanya berupa kemampuan backend tanpa manfaat atau alur penggunaan yang jelas pada aplikasi mobile.

Jika fitur memiliki keterbatasan tertentu pada perangkat mobile atau memerlukan proses tambahan di luar aplikasi, jelaskan keterbatasannya. Jangan menyajikannya sebagai fitur mobile penuh apabila kenyataannya tidak demikian.

---

## 4. Riset fitur baru dari aplikasi sejenis

Tujuan bagian ini adalah menemukan peluang fitur yang belum tersedia pada proyek dan dapat menambah manfaat aplikasi.

Untuk setiap kandidat fitur:

1. Pastikan fitur tersebut benar-benar ditemukan pada aplikasi referensi.
2. Pastikan fitur itu belum tersedia dalam bentuk yang sama di proyek. Jika sudah tersedia, masukkan ke bagian **Optimasi fitur yang sudah ada**, bukan sebagai fitur baru.
3. Jelaskan nama dan tujuan fitur.
4. Jelaskan masalah pengguna yang diselesaikan dan manfaat praktisnya.
5. Jelaskan gambaran alur penggunaan fitur pada perangkat mobile dari tindakan pengguna sampai hasil yang diterima.
6. Sebutkan aplikasi referensi dan tautan langsung ke halaman aplikasi serta sumber yang membuktikan keberadaan fitur tersebut.
7. Jelaskan persyaratan atau ketergantungan penting, seperti internet, izin perangkat, akun, API, backend, pembayaran, atau layanan pihak ketiga, jika benar-benar relevan.
8. Nilai kesesuaian fitur dengan tujuan, pengguna, dan kondisi proyek. Jangan merekomendasikan fitur hanya karena aplikasi kompetitor memilikinya.
9. Jelaskan alasan prioritasnya.

Jangan membuat desain implementasi kode atau mengubah proyek. Berikan rekomendasi agar pemilik proyek yang menentukan apakah fitur tersebut akan dipakai.

---

## 5. Riset optimasi fitur yang sudah ada

Tujuan bagian ini adalah menemukan cara meningkatkan fitur yang telah dimiliki proyek berdasarkan perbandingan dengan aplikasi sejenis.

Untuk setiap fitur yang dibandingkan:

1. Catat bagaimana fitur tersebut berjalan pada proyek saat ini berdasarkan implementasi aktual. Sertakan path file dan nama halaman, class, fungsi, atau komponen yang relevan apabila dapat ditemukan.
2. Temukan aplikasi kompetitor yang memiliki fungsi atau alur sejenis.
3. Jelaskan bagaimana aplikasi referensi menyajikan dan menjalankan fitur tersebut. Pisahkan fakta dari hasil pengamatan visual dan interpretasi.
4. Identifikasi pola yang lebih baik, misalnya alur lebih singkat, pengelompokan informasi, pengurangan langkah, kemudahan akses, pengelolaan data, feedback tindakan, atau dukungan kondisi jaringan.
5. Bandingkan dengan implementasi proyek. Jelaskan kelebihan yang sudah dimiliki proyek dan bagian yang masih dapat ditingkatkan.
6. Berikan saran optimasi yang spesifik, alasan, manfaat bagi pengguna, serta sumber referensinya.
7. Berikan prioritas berdasarkan dampak, kesesuaian, bukti, dan kelayakan mobile.

Jangan menyebut sesuatu sebagai kekurangan proyek jika tidak didukung pemeriksaan implementasi atau alur yang benar-benar dapat diamati. Jangan mengusulkan penggantian total apabila perbaikan kecil sudah cukup.

---

## 6. Riset UI, UX, dan layout aplikasi kompetitor

Cari aplikasi kompetitor yang memiliki fitur sama atau alur pengguna yang sebanding dengan proyek. Fokus pada pola yang dapat dipelajari, bukan menyalin desain aplikasi lain.

### 6.1. Aspek yang harus diperiksa

Analisis aspek berikut sejauh bukti visual atau interaksi yang tersedia memungkinkan:

1. **Navigasi dan arsitektur informasi:** struktur tab, menu, hierarki halaman, posisi fitur utama, dan cara pengguna berpindah halaman.
2. **Layout halaman:** susunan konten, pembagian section, penggunaan kartu, daftar, tabel, formulir, bottom sheet, dialog, dan komponen lain.
3. **Hierarki visual:** urutan informasi, penekanan informasi penting, judul, label, ikon, warna, dan kepadatan konten.
4. **Alur UX:** jumlah dan urutan langkah, kejelasan tindakan, kemudahan menemukan fitur, pencegahan kesalahan, dan konsistensi perilaku.
5. **Interaksi mobile:** penggunaan tombol, gesture, input, keyboard, pemilih tanggal, kamera, izin perangkat, dan kontrol sentuh apabila relevan.
6. **Feedback dan status:** indikator loading, status proses, keberhasilan, peringatan, kesalahan, konfirmasi tindakan, serta kondisi kosong apabila dapat diamati.
7. **Keterbacaan dan aksesibilitas:** ukuran teks, kontras, label, area sentuh, scroll, dan kemudahan penggunaan pada layar kecil apabila bukti memungkinkan.
8. **Kondisi khusus:** tampilan saat data banyak, data kosong, jaringan lambat atau terputus, izin ditolak, dan proses gagal apabila tersedia bukti.

### 6.2. Cara menyusun hasil analisis

Untuk setiap pola UI/UX yang relevan:

- Sebutkan nama aplikasi dan fitur/halaman yang diperiksa.
- Jelaskan pola UI, UX, atau layout yang ditemukan.
- Sertakan tautan sumber visual yang relevan, seperti screenshot resmi, halaman store, video demonstrasi, atau halaman panduan.
- Jelaskan tujuan atau manfaat pola tersebut bagi pengguna.
- Bandingkan dengan pola yang digunakan proyek saat ini jika implementasinya dapat diperiksa.
- Berikan saran yang dapat dipertimbangkan untuk proyek.
- Jelaskan alasan dan prioritas saran.

Jangan menyimpulkan detail layout hanya dari deskripsi teks aplikasi. Jika screenshot atau demonstrasi tidak tersedia, tulis bahwa pola visual belum dapat diverifikasi. Jangan mengarang posisi tombol, warna, jumlah tab, ukuran komponen, urutan halaman, atau perilaku interaksi.

Jangan menilai desain hanya berdasarkan selera. Hubungkan setiap saran dengan kegunaan, kejelasan, efisiensi alur, konsistensi, keterbacaan, atau pengurangan beban kognitif.

---

## 7. Standar bukti dan pencatatan referensi

Setiap rekomendasi dan analisis wajib memiliki tautan sumber yang dapat dibuka.

Untuk setiap aplikasi referensi, catat sebanyak mungkin informasi yang dapat diverifikasi:

- Nama aplikasi.
- Nama pengembang/penerbit.
- Platform yang tersedia.
- Tautan langsung Google Play atau App Store.
- Tautan situs resmi atau dokumentasi terkait.
- Tautan screenshot, video, atau halaman yang menjadi bukti UI/UX jika tersedia.
- Nama fitur yang benar-benar relevan dengan pembahasan.
- Versi aplikasi dan tanggal pembaruan terakhir jika sumber menyediakannya.
- Tanggal riset dilakukan.

Gunakan tautan langsung ke halaman aplikasi atau bukti spesifik. Hindari hanya menautkan homepage mesin pencari, hasil pencarian umum, atau halaman utama pengembang apabila tersedia halaman yang lebih tepat.

Berikan penanda yang jelas pada setiap informasi:

- **Terverifikasi:** tercantum pada sumber resmi atau dapat diperiksa langsung.
- **Teramati:** terlihat dari screenshot, video, halaman, atau interaksi yang benar-benar diperiksa.
- **Interpretasi:** kesimpulan analitis berdasarkan bukti yang ditemukan.
- **Saran:** usulan untuk dipertimbangkan pada proyek.
- **Belum terverifikasi:** informasi belum dapat dipastikan karena keterbatasan sumber atau tools.

Jangan menyamarkan interpretasi atau dugaan sebagai fakta. Jika tautan tidak dapat dibuka atau sumber tidak lagi tersedia, tandai secara jelas dan jangan gunakan sebagai satu-satunya dasar rekomendasi penting.

---

## 8. Sistem prioritas rekomendasi

Urutkan setiap rekomendasi berdasarkan prioritas **Tinggi**, **Sedang**, lalu **Rendah**. Terapkan sistem ini secara terpisah pada:

1. Fitur baru.
2. Optimasi fitur yang sudah ada.
3. Rekomendasi UI, UX, dan layout.

Gunakan kriteria berikut:

| Prioritas  | Kriteria                                                                                                                                                                                                                               |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Tinggi** | Sangat sesuai dengan tujuan aplikasi dan kebutuhan utama pengguna; manfaatnya jelas; didukung bukti yang kuat; dapat digunakan melalui mobile; serta tidak memiliki hambatan kelayakan yang besar berdasarkan informasi yang tersedia. |
| **Sedang** | Relevan dan bermanfaat, tetapi dampaknya lebih terbatas, hanya cocok untuk sebagian alur/pengguna, atau memerlukan pertimbangan teknis/produk tambahan.                                                                                |
| **Rendah** | Bersifat tambahan atau khusus, manfaatnya belum kuat, bukti masih terbatas, atau ketergantungan/kompleksitasnya relatif besar dibanding manfaat yang diperkirakan.                                                                     |

Setiap rekomendasi wajib menyertakan alasan penetapan prioritas. Jangan memberi prioritas tinggi hanya karena fitur terlihat menarik atau dimiliki banyak kompetitor.

Prioritas adalah urutan bahan pertimbangan, bukan keputusan untuk mengimplementasikan fitur. Jangan menghapus opsi prioritas sedang atau rendah hanya karena ada opsi prioritas tinggi. Pemilik proyek yang akan menyortir dan menentukan pilihan.

---

## 9. Format `refrensi_apk.md`

Tulis hasil ke **`./refrensi_apk.md` di root proyek**. Kelompokkan berdasarkan fitur serta UI/UX, kemudian urutkan berdasarkan prioritas.

Gunakan struktur berikut dan sesuaikan jumlah entri dengan hasil riset nyata:

```markdown
# Referensi APK Sejenis

## Informasi Riset

- Nama proyek:
- Kategori aplikasi:
- Platform proyek:
- Tanggal riset:
- Ringkasan cakupan:
- Keterbatasan riset:

## Ringkasan Temuan

- Ringkasan singkat temuan paling penting.
- Jangan mengambil keputusan implementasi atas nama pemilik proyek.

## A. Rekomendasi Fitur Baru

### Prioritas Tinggi

#### 1. [Nama fitur]

- **Tujuan:**
- **Masalah pengguna yang diselesaikan:**
- **Cara kerja di mobile:**
- **Aplikasi referensi:**
- **Bukti dan tautan:**
- **Ketergantungan/keterbatasan:**
- **Manfaat untuk proyek:**
- **Alasan prioritas:**

### Prioritas Sedang

### Prioritas Rendah

## B. Optimasi Fitur yang Sudah Ada

### Prioritas Tinggi

#### 1. [Nama fitur]

- **Kondisi fitur di proyek:**
- **Path implementasi proyek:**
- **Pembanding aplikasi:**
- **Pola/implementasi referensi:**
- **Perbedaan atau peluang optimasi:**
- **Saran optimasi:**
- **Manfaat:**
- **Bukti dan tautan:**
- **Alasan prioritas:**

### Prioritas Sedang

### Prioritas Rendah

## C. Rekomendasi UI, UX, dan Layout

### Prioritas Tinggi

#### 1. [Nama pola atau halaman]

- **Fitur/halaman yang dibandingkan:**
- **Aplikasi referensi:**
- **Pola UI:**
- **Pola UX:**
- **Pola layout:**
- **Tujuan/manfaat pola:**
- **Kondisi pada proyek:**
- **Saran untuk proyek:**
- **Bukti visual dan tautan:**
- **Alasan prioritas:**

### Prioritas Sedang

### Prioritas Rendah

## D. Daftar Aplikasi Kompetitor/Referensi

| Aplikasi | Pengembang | Platform | Fitur yang relevan | Tautan store | Sumber tambahan |
| -------- | ---------- | -------- | ------------------ | ------------ | --------------- |

## E. Catatan Validasi dan Keterbatasan

- Informasi yang belum dapat diverifikasi.
- Screenshot atau alur yang tidak dapat diperiksa.
- Tools atau sumber yang tidak tersedia.
- Hal yang perlu diperiksa lebih lanjut.
```
````

Ketentuan format:

1. Jangan menyisakan judul kosong atau placeholder dari contoh format. Tulis hanya temuan yang benar-benar diperoleh.
2. Setiap item harus memiliki tautan referensi yang relevan. Tautan dapat ditempatkan pada bagian item dan juga dicatat dalam daftar aplikasi.
3. Kelompokkan berdasarkan fitur atau pola UI/UX, bukan hanya berdasarkan nama aplikasi.
4. Jika satu aplikasi memiliki beberapa fitur relevan, aplikasi tersebut boleh muncul pada beberapa kelompok fitur. Hindari mengulang penjelasan yang sama secara berlebihan.
5. Bedakan fitur baru, optimasi fitur yang sudah ada, dan saran UI/UX. Jangan mencampurkan ketiganya.
6. Cantumkan path implementasi proyek hanya jika benar-benar ditemukan. Jangan menebak path atau nama class.
7. Gunakan bahasa Indonesia yang baik, baku, jelas, dan langsung.
8. Pertahankan tautan dalam format Markdown yang dapat diklik.
9. Jangan mengisi bagian dengan rekomendasi generik seperti "buat UI lebih menarik" tanpa penjelasan pola, alasan, dan manfaat.

---

## 10. Aturan pembaruan file

1. Hanya buat atau ubah `./refrensi_apk.md` sebagai hasil command ini.
2. Jangan mengubah file kode, konfigurasi, dependency, `AGENTS.md`, aturan, command lain, `task.md`, `rencana_fitur_baru.md`, atau dokumentasi lain.
3. Jika `refrensi_apk.md` sudah ada, gabungkan hasil riset baru dengan isi lama secara hati-hati. Jangan langsung menimpa seluruh dokumen tanpa membaca dan mengevaluasinya.
4. Pertahankan informasi lama yang masih relevan dan tautan yang masih valid.
5. Perbarui informasi yang sudah usang hanya jika tersedia bukti baru. Jangan menghapus catatan lama yang masih berguna tanpa alasan.
6. Periksa duplikasi berdasarkan inti fitur, manfaat, aplikasi referensi, dan pola UI/UX. Jika temuan sama, perbarui entri yang sudah ada.
7. Jangan mengubah saran menjadi keputusan atau status implementasi. Pemilik proyek yang menentukan item mana yang akan dipilih.
8. Jangan membuat perubahan pada file lain untuk merapikan dokumentasi.

---

## 11. Pemeriksaan akhir

Sebelum menyelesaikan command:

1. Baca kembali seluruh `refrensi_apk.md`.
2. Pastikan seluruh rekomendasi fitur baru benar-benar dapat digunakan melalui perangkat mobile.
3. Pastikan fitur yang sudah ada tidak keliru dimasukkan sebagai fitur baru.
4. Pastikan setiap rekomendasi memiliki tujuan, manfaat, alasan prioritas, dan tautan referensi.
5. Pastikan analisis UI/UX didukung screenshot, demonstrasi, atau sumber visual yang benar-benar diperiksa. Jika tidak, beri catatan keterbatasan.
6. Pastikan fakta, pengamatan, interpretasi, dan saran tidak tercampur.
7. Pastikan kelompok prioritas tersusun Tinggi, Sedang, lalu Rendah.
8. Pastikan tidak ada duplikasi dan tidak ada tautan yang dibuat-buat.
9. Periksa perubahan file menggunakan tool yang tersedia. Pastikan hanya `refrensi_apk.md` yang diubah oleh pelaksanaan command ini. Bedakan perubahan yang sudah ada sebelum command dimulai.
10. Jangan melakukan commit atau operasi Git yang mengubah riwayat repository.

## 12. Laporan akhir

Sampaikan laporan dalam bahasa Indonesia dengan susunan:

1. **Status riset:** selesai, sebagian selesai, atau terhambat.
2. **File hasil:** `./refrensi_apk.md`.
3. **Ringkasan aplikasi referensi:** nama aplikasi dan fitur yang dibandingkan.
4. **Jumlah temuan:** jumlah kandidat fitur baru, optimasi fitur, dan saran UI/UX pada setiap prioritas.
5. **Sumber:** tautan utama yang berhasil diperiksa.
6. **Keterbatasan:** bagian yang belum dapat diverifikasi atau tools yang tidak tersedia.
7. **Perubahan file:** konfirmasi bahwa hanya `refrensi_apk.md` yang diubah oleh pelaksanaan command ini.

Jangan mengklaim riset selesai apabila sumber utama atau bukti yang dibutuhkan belum berhasil diperiksa. Jangan mengimplementasikan rekomendasi. Hasil akhir adalah bahan pertimbangan agar pemilik proyek dapat menyortir sendiri.

```

---

## Laporan pemasangan yang wajib diberikan

Setelah selesai, laporkan:

1. Path file yang dibuat atau diperbarui.
2. Konfirmasi seluruh isi definisi command tersalin lengkap.
3. Validitas YAML frontmatter (`description` dan `agent: code`).
4. Nama slash command: `/referensi_apk_sejenis`.
5. Konfirmasi `refrensi_apk.md` tidak dibuat atau diubah saat pemasangan.
6. Hasil pemeriksaan diff dan `git status --short`.

**Jangan menjalankan command yang baru dipasang. Jangan melakukan perubahan di luar tugas pemasangan ini.**
```
