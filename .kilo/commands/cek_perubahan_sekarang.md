---
description: Evaluasi seluruh commit yang belum diperiksa berdasarkan aturan proyek dan source SDK, perbarui catatan.md serta task.md tanpa mengubah kode.
agent: code
---

# Evaluasi Perubahan Commit

## Tujuan

Analisis perubahan kode yang sudah di-commit agar sesuai dengan:

1. `AGENTS.md` dan seluruh aturan proyek yang berlaku.
2. Aturan khusus dalam `.agents/rules/`.
3. Source SDK Flutter dan Dart yang benar-benar digunakan proyek.
4. Source package atau dependency yang digunakan oleh kode yang berubah.

Tugas ini adalah **AUDIT DAN ANALISIS, BUKAN IMPLEMENTASI**.

AI hanya boleh:

- Membaca commit dan perubahan kode.
- Membaca aturan proyek.
- Membaca source SDK dan source package.
- Menganalisis kesesuaian implementasi.
- Memperbarui `catatan.md` di root.
- Menambah atau memperbarui temuan di `task.md` root sesuai `.agents/rules/global/format_task.md`.
- Memberikan laporan dan saran perbaikan.

**LARANGAN MUTLAK: JANGAN MENGUBAH, MEMFORMAT ULANG, MEMPERBAIKI, ATAU MENGIMPLEMENTASIKAN KODE DART.**

---

# 1. Persiapan dan pembacaan aturan

Sebelum menganalisis commit:

1. Baca `AGENTS.md` yang berlaku untuk proyek, termasuk aturan dari direktori induk jika ada.
2. Baca `.agents/rules/AGENTS.md` jika tersedia dan berlaku.
3. Baca seluruh aturan relevan di `.agents/rules/`.
4. Baca `.agents/rules/global/format_task.md`.
5. Baca `pubspec.yaml` untuk mengetahui dependency dan versi SDK yang digunakan.
6. Baca `pubspec.lock` untuk mengetahui versi dependency yang benar-benar terkunci.
7. Baca `catatan.md` di root jika file tersebut tersedia.
8. Baca `task.md` di root jika file tersebut tersedia.

Patuhi aturan proyek selama seluruh proses analisis.

Jika file aturan yang wajib dibaca tidak ditemukan atau tidak dapat dibaca:

- Jangan mengarang isi aturan.
- Jangan menganggap aturan tersebut tidak berlaku.
- Laporkan file yang tidak ditemukan atau tidak dapat dibaca.
- Jika ketidaktersediaan aturan membuat analisis tidak dapat dilakukan dengan benar, hentikan proses dan minta arahan pengguna.

---

# 2. Menentukan commit yang akan dievaluasi

**Jangan membaca semua riwayat commit tanpa batas. Evaluasi hanya commit yang belum pernah diperiksa.**

Gunakan `catatan.md` sebagai penanda checkpoint evaluasi terakhir.

## 2.1. Jika catatan.md sudah memiliki checkpoint

1. Baca commit hash terakhir yang tercatat sebagai commit yang sudah dievaluasi.
2. Pastikan commit tersebut dapat ditemukan di riwayat Git.
3. Tentukan seluruh commit setelah checkpoint tersebut sampai HEAD saat penentuan target.
4. Commit checkpoint tidak boleh dianalisis ulang.
5. Jangan membaca commit sebelum checkpoint.
6. Catat hash HEAD pada saat penentuan target sebagai `TARGET_HEAD`.

## 2.2. Jika belum ada checkpoint

Jika `catatan.md` belum tersedia, kosong, atau belum memiliki informasi checkpoint evaluasi yang valid:

1. Ambil 5 commit terbaru dari riwayat Git.
2. Tentukan commit paling baru yang akan menjadi `TARGET_HEAD`.
3. Evaluasi hanya 5 commit yang sudah ditentukan tersebut.
4. Jangan memperluas target ke commit lain selama sesi berjalan.

Jika `catatan.md` memiliki checkpoint tetapi commit tersebut tidak dapat ditemukan atau riwayatnya tidak dapat diverifikasi, jangan langsung menggunakan 5 commit terbaru. Laporkan masalah checkpoint kepada pengguna agar tidak ada commit yang terlewat atau dievaluasi dua kali tanpa alasan.

## 2.3. Tetapkan daftar target sebelum analisis

Sebelum membaca isi perubahan:

1. Tetapkan `TARGET_HEAD`.
2. Tetapkan daftar hash seluruh commit yang akan dievaluasi.
3. Catat jumlah commit yang menjadi target.
4. Urutkan commit dari yang paling lama ke yang paling baru.
5. Gunakan daftar tersebut sebagai batas tetap selama sesi.

**Jangan menambahkan commit baru ke daftar target setelah proses analisis dimulai.**

## 2.4. Jika ada commit baru setelah target ditentukan

Jika terdapat commit baru setelah `TARGET_HEAD` ditentukan:

1. Abaikan commit baru tersebut selama sesi ini.
2. Jangan memasukkannya ke daftar target.
3. Jangan membaca diff atau isi commit baru tersebut.
4. Selesaikan hanya commit yang sudah masuk daftar target.
5. Saat memperbarui `catatan.md`, gunakan hash `TARGET_HEAD`, bukan HEAD terbaru yang muncul selama pengerjaan.
6. Commit baru akan dievaluasi pada pemanggilan command berikutnya.

**Contoh:**

Pada awal analisis:

- Commit A
- Commit B
- Commit C

`TARGET_HEAD` ditentukan pada Commit C.

Ketika AI sedang menganalisis, pengguna membuat:

- Commit D
- Commit E

AI hanya boleh mengevaluasi Commit A, B, dan C jika ketiganya memang termasuk daftar target.

Commit D dan E tidak boleh ikut dianalisis. Keduanya harus tetap terdeteksi sebagai commit baru untuk evaluasi berikutnya.

**Dilarang menggeser checkpoint ke Commit E hanya karena Commit E merupakan HEAD terbaru ketika sesi selesai.**

---

# 3. Membaca perubahan setiap commit

Setelah daftar target ditetapkan:

1. Periksa setiap commit berdasarkan urutan yang sudah ditentukan.
2. Baca pesan commit.
3. Periksa file yang ditambahkan, diubah, dipindahkan, dan dihapus.
4. Baca diff setiap file yang berubah.
5. Baca konteks kode di sekitar perubahan agar memahami fungsi dan dampaknya.
6. Periksa hubungan perubahan dengan file lain yang terkait.
7. Jangan hanya mengandalkan pesan commit.
8. Jangan menganggap perubahan sudah benar hanya karena berhasil di-commit.
9. Jangan mengabaikan perubahan kecil, termasuk perubahan pada widget, parameter, konstruktor, import, dan konfigurasi.
10. Jangan memperluas analisis ke perubahan yang tidak termasuk dalam daftar target.

Jika beberapa commit mengubah file yang sama, periksa urutan perubahan agar dapat memahami kondisi akhir dan hubungan antarperubahannya.

Jika file dihapus atau dipindahkan, periksa diff dan riwayat yang relevan tanpa menganggap file tersebut masih tersedia pada HEAD.

---

# 4. Audit kesesuaian dengan AGENTS.md dan aturan proyek

Untuk setiap perubahan:

1. Identifikasi aturan yang berkaitan dengan kode tersebut.
2. Periksa apakah implementasi mematuhi aturan.
3. Periksa apakah perubahan melanggar aturan proyek.
4. Periksa apakah ada konflik antara implementasi baru dan aturan yang berlaku.
5. Periksa apakah perubahan menyebabkan ketidakkonsistenan dengan pola kode yang sudah digunakan.
6. Periksa apakah implementasi menimbulkan risiko bug runtime, kesalahan state, kebocoran resource, atau masalah performa.
7. Periksa apakah perubahan memengaruhi UX dan UI.
8. Periksa apakah implementasi menambahkan kompleksitas yang tidak diperlukan.
9. Periksa apakah solusi sudah sesuai dengan tujuan perubahan.
10. Catat aturan yang dilanggar beserta path file dan lokasi kode yang relevan.

Jika tidak menemukan pelanggaran, jangan membuat temuan yang tidak memiliki dasar.

Jangan mengarang aturan yang tidak tertulis dalam dokumentasi proyek atau dokumentasi SDK.

---

# 5. WAJIB MEMBACA SOURCE SDK DAN SOURCE PACKAGE

**AI TIDAK BOLEH MENGABAIKAN SOURCE SDK, MESKIPUN PERUBAHAN HANYA MELIBATKAN WIDGET BIASA.**

Setiap kode yang berubah harus diperiksa terhadap API dan implementasi yang benar-benar tersedia pada versi SDK atau package yang digunakan proyek.

## 5.1. Tentukan versi yang digunakan

Sebelum membaca source:

1. Periksa versi Flutter dan Dart proyek.
2. Periksa konfigurasi SDK di `pubspec.yaml`.
3. Periksa versi dependency yang terkunci di `pubspec.lock`.
4. Pastikan source yang dibaca sesuai dengan versi yang benar-benar digunakan proyek.
5. Jangan menggunakan dokumentasi versi terbaru jika proyek menggunakan versi yang berbeda tanpa memverifikasi kesesuaiannya.

## 5.2. Lokasi source yang harus diperiksa

Gunakan source lokal yang sesuai dengan lingkungan proyek, misalnya:

- Source Flutter SDK.
- Source Dart SDK.
- Source package di `.pub-cache`.
- Source package yang dikelola melalui dependency proyek.
- Dokumentasi API resmi yang sesuai dengan versi dependency jika source lokal tidak tersedia.

Untuk proyek Flutter, periksa source yang relevan di instalasi Flutter SDK dan package cache.

Jangan menganggap dokumentasi umum sudah cukup jika source implementasinya tersedia.

## 5.3. Periksa setiap API yang digunakan

Untuk setiap kode yang berubah, periksa hal-hal berikut sesuai relevansinya:

1. Apakah class atau widget benar-benar tersedia pada versi yang digunakan?
2. Apakah konstruktor yang dipanggil sesuai dengan source?
3. Apakah parameter wajib dan opsional sudah benar?
4. Apakah tipe parameter dan nilai kembaliannya sesuai?
5. Apakah terdapat parameter baru yang belum dimanfaatkan?
6. Apakah terdapat parameter yang sudah deprecated?
7. Apakah API tersebut sudah diganti atau tidak direkomendasikan?
8. Apakah terdapat perubahan perilaku pada versi SDK yang digunakan?
9. Apakah penggunaan API sesuai dengan dokumentasi dan contoh implementasi resmi?
10. Apakah terdapat cara penggunaan yang lebih tepat berdasarkan source SDK?

## 5.4. Pemeriksaan widget biasa tetap wajib

Jangan hanya membaca source untuk API yang dianggap rumit.

Contoh kode yang tetap harus diperiksa source-nya:

- `Container`
- `Padding`
- `Row`
- `Column`
- `Stack`
- `Scaffold`
- `AppBar`
- `Text`
- `Icon`
- `ListView`
- `GridView`
- `ListTile`
- `TextField`
- `ElevatedButton`
- `IconButton`
- `FutureBuilder`
- `StreamBuilder`
- Widget dan API lain yang berubah.

Jika konstruktor, parameter, atau perilaku widget mengalami perubahan, catat temuan tersebut.

Tujuannya agar AI dan pengguna memahami API berdasarkan implementasi SDK yang sebenarnya, bukan hanya berdasarkan ingatan model.

## 5.5. Bukti pemeriksaan source

Setiap temuan yang berkaitan dengan SDK atau package harus mencantumkan:

- Nama API, class, atau widget.
- Versi SDK atau package yang diperiksa.
- Lokasi source yang diperiksa.
- Konstruktor atau parameter yang relevan.
- Hasil pemeriksaan.
- Dampak terhadap kode yang berubah.
- Rekomendasi penggunaan yang sesuai.

Jika source tidak ditemukan atau tidak dapat dibaca:

- Jangan mengklaim API sudah sesuai.
- Jangan menebak konstruktor atau parameter.
- Catat bagian yang belum dapat diverifikasi.
- Jelaskan sumber yang sudah dicoba diperiksa.

**Tidak boleh memberikan kesimpulan bahwa kode sesuai SDK jika source yang relevan belum diperiksa.**

---

# 6. Analisis dampak dan saran perbaikan

Setelah memeriksa commit, aturan proyek, dan source SDK:

1. Tentukan apakah perubahan sudah benar.
2. Identifikasi masalah yang benar-benar ditemukan.
3. Jelaskan penyebab masalah.
4. Jelaskan dampak masalah terhadap aplikasi.
5. Tunjukkan lokasi file dan baris yang relevan jika tersedia.
6. Cantumkan aturan proyek atau source SDK yang menjadi dasar penilaian.
7. Berikan saran perbaikan yang spesifik dan dapat diterapkan.
8. Pisahkan masalah yang wajib diperbaiki dari saran peningkatan.
9. Jangan menyarankan refactor besar jika perbaikan kecil sudah mencukupi.
10. Jangan menambahkan persyaratan yang tidak berkaitan dengan perubahan.

Gunakan kategori prioritas sesuai format `task.md` dan aturan proyek.

Jika perubahan sudah sesuai, nyatakan bahwa tidak ditemukan masalah berdasarkan pemeriksaan yang dilakukan. Jangan membuat task hanya untuk mengisi daftar.

---

# 7. Pembaruan task.md

Jika ditemukan masalah yang membutuhkan perbaikan kode:

1. Tambahkan task baru atau perbarui task yang sudah ada di `task.md` root.
2. Baca kembali `.agents/rules/global/format_task.md` sebelum mengubah `task.md`.
3. Ikuti format penulisan, pengelompokan, prioritas, dan struktur task sesuai aturan tersebut.
4. Kelompokkan task berdasarkan file terdampak sesuai aturan `format_task.md`.
5. Jika task yang sama sudah tersedia, perbarui task tersebut daripada membuat duplikat.
6. Jangan menghapus task lama yang tidak berkaitan.
7. Jangan mengubah status task yang sudah ada tanpa alasan yang dibenarkan.
8. Tuliskan masalah berdasarkan hasil pemeriksaan aktual.
9. Tuliskan solusi yang spesifik dan dapat diterapkan.
10. Cantumkan aturan yang dilanggar.
11. Cantumkan seluruh file yang bermasalah.
12. Sertakan referensi commit yang menjadi sumber temuan jika relevan.

Jangan membuat task untuk hal yang belum terbukti bermasalah.

Jika tidak ditemukan masalah yang memerlukan implementasi, jangan menambahkan task baru.

**Penting:** Memperbarui `task.md` bukan berarti memberikan izin untuk langsung mengerjakan task tersebut.

Jangan mengubah status task menjadi `Kerjakan` hanya karena AI menemukan masalah. Status pengerjaan tetap mengikuti aturan dan keputusan pengguna.

---

# 8. Aturan pengelolaan catatan.md

File `catatan.md` di root berfungsi sebagai checkpoint evaluasi dan ringkasan pengetahuan hasil evaluasi commit.

**Tujuan utamanya adalah mencegah commit yang sudah dievaluasi dibaca dan dianalisis berulang kali, sekaligus mencegah isi catatan membengkak.**

## 8.1. Informasi yang wajib disimpan

Simpan informasi berikut:

1. Hash commit terakhir yang sudah dievaluasi.
2. Tanggal evaluasi terakhir.
3. Ringkasan singkat hasil evaluasi.
4. Temuan penting yang masih relevan untuk pekerjaan berikutnya.
5. Aturan atau pengetahuan SDK yang penting dan perlu dipertahankan.

## 8.2. Jangan menyimpan seluruh riwayat evaluasi

Hindari:

- Menyalin seluruh pesan commit.
- Menyalin seluruh diff.
- Menyimpan ulang seluruh isi laporan.
- Menyimpan daftar perubahan setiap file secara panjang.
- Menyimpan temuan yang sudah tidak relevan.
- Mengulang informasi yang sudah tersedia di `task.md`.
- Menambahkan laporan lengkap setiap sesi tanpa merangkum catatan sebelumnya.

## 8.3. Cara menjaga ukuran catatan tetap terkendali

Setiap kali memperbarui `catatan.md`:

1. Pertahankan checkpoint evaluasi terakhir yang benar.
2. Perbarui checkpoint ke `TARGET_HEAD` setelah seluruh commit target berhasil dievaluasi.
3. Perbarui ringkasan evaluasi sebelumnya menjadi ringkasan yang lebih padat jika diperlukan.
4. Pertahankan hanya pengetahuan SDK dan aturan yang masih relevan untuk evaluasi mendatang.
5. Hapus catatan sementara yang sudah tidak diperlukan.
6. Jangan menyimpan detail temuan yang sudah dicatat lengkap di `task.md`.
7. Jangan menumpuk laporan setiap sesi menjadi riwayat panjang.

Gunakan struktur ringkas seperti berikut:

```markdown
# Catatan Evaluasi Commit

## Checkpoint

- Commit terakhir dievaluasi: <hash>
- Tanggal evaluasi: <tanggal>
- Jumlah commit yang dievaluasi: <jumlah>

## Ringkasan Evaluasi Terakhir

- <ringkasan singkat>

## Pengetahuan Penting

- <aturan atau pengetahuan SDK yang masih relevan>

## Temuan yang Masih Perlu Diperhatikan

- <temuan ringkas yang belum tercatat di task.md>
```

Struktur tersebut merupakan pedoman ringkas. Jika `catatan.md` sudah memiliki format yang lebih sesuai, pertahankan bagian yang masih berguna dan rapikan tanpa menghilangkan checkpoint.

**Jangan mengorbankan ketepatan checkpoint demi membuat catatan lebih pendek.**

## 8.4. Kapan checkpoint boleh diperbarui

Checkpoint hanya boleh diperbarui setelah:

1. Seluruh commit target berhasil diperiksa.
2. Seluruh perubahan yang termasuk target sudah dianalisis.
3. Temuan sudah dicatat.
4. `task.md` sudah diperbarui jika diperlukan.
5. Tidak ada commit target yang sengaja terlewat tanpa penjelasan.

Jika ada commit target yang gagal dibaca atau belum selesai dievaluasi:

- Jangan mengklaim seluruh target sudah selesai.
- Jangan menggeser checkpoint melewati commit yang belum dievaluasi.
- Laporkan commit yang belum berhasil diperiksa.
- Simpan checkpoint hanya sampai commit terakhir yang benar-benar selesai dievaluasi secara berurutan.

Jika commit baru muncul setelah `TARGET_HEAD`, jangan gunakan commit baru tersebut sebagai checkpoint.

---

# 9. Larangan mengubah kode

**COMMAND INI TIDAK BOLEH MELAKUKAN IMPLEMENTASI.**

Dilarang:

1. Mengubah file `.dart`.
2. Memperbaiki bug secara langsung.
3. Mengubah konstruktor atau parameter widget.
4. Mengganti API deprecated.
5. Melakukan refactor.
6. Memformat ulang kode.
7. Mengubah konfigurasi proyek untuk memperbaiki temuan.
8. Mengubah dependency.
9. Membuat perubahan implementasi yang tidak diminta.

File yang boleh diperbarui oleh command ini hanya:

- `catatan.md` di root.
- `task.md` di root.

File dokumentasi lain hanya boleh dibaca, kecuali pengguna memberikan instruksi terpisah.

Jika menemukan masalah pada kode, cukup catat di `task.md` dan berikan saran perbaikan dalam laporan.

**Jangan memperbaiki kode meskipun perbaikannya terlihat sangat sederhana.**

---

# 10. Urutan pelaksanaan wajib

Lakukan pekerjaan dengan urutan berikut:

1. Baca `AGENTS.md` dan aturan proyek.
2. Baca `.agents/rules/global/format_task.md`.
3. Baca `pubspec.yaml` dan `pubspec.lock`.
4. Baca `catatan.md`.
5. Baca `task.md`.
6. Tentukan checkpoint evaluasi sebelumnya.
7. Tetapkan `TARGET_HEAD`.
8. Tetapkan seluruh daftar commit target.
9. Pastikan daftar target tidak berubah selama sesi.
10. Analisis setiap commit sesuai urutan.
11. Periksa seluruh kode yang berubah.
12. Baca source SDK dan source package untuk API yang digunakan oleh perubahan.
13. Bandingkan hasil pemeriksaan dengan aturan proyek.
14. Identifikasi masalah dan saran perbaikan.
15. Tambahkan atau perbarui temuan di `task.md` sesuai `format_task.md`.
16. Perbarui `catatan.md` dengan checkpoint terakhir yang benar-benar selesai dievaluasi.
17. Periksa ulang kedua file dokumentasi yang diperbarui.
18. Berikan laporan akhir kepada pengguna.

Jangan mengubah urutan tersebut tanpa alasan teknis yang jelas.

---

# 11. Format laporan akhir

Berikan laporan yang terstruktur dan tidak hanya menyatakan bahwa pemeriksaan selesai.

## A. Informasi evaluasi

- Checkpoint sebelumnya.
- `TARGET_HEAD`.
- Jumlah commit target.
- Rentang commit yang diperiksa.
- Apakah terdapat commit baru setelah target ditentukan.
- Konfirmasi bahwa commit baru tersebut tidak ikut dianalisis.

## B. Hasil evaluasi per commit

Untuk setiap commit:

- Hash commit.
- Pesan commit.
- File yang berubah.
- Ringkasan perubahan.
- Hasil pemeriksaan aturan proyek.
- Hasil pemeriksaan source SDK.
- Masalah yang ditemukan.
- Saran perbaikan.

## C. Temuan

Kelompokkan temuan berdasarkan prioritas dan jenis masalah sesuai aturan proyek.

Pisahkan:

- Pelanggaran aturan.
- Kesalahan penggunaan SDK atau package.
- Potensi bug runtime.
- Masalah UX/UI.
- Masalah performa.
- Saran peningkatan yang tidak wajib.

## D. Pembaruan dokumentasi

Laporkan:

- Apakah `catatan.md` diperbarui.
- Checkpoint yang disimpan.
- Apakah ukuran dan isi catatan sudah diringkas.
- Apakah `task.md` ditambahkan atau diperbarui.
- Daftar task yang ditambahkan atau diperbarui.

## E. Status implementasi

Nyatakan secara eksplisit:

**Tidak ada kode Dart yang diubah atau diimplementasikan.**

Jika ada kendala pemeriksaan, sebutkan dengan jelas agar pengguna mengetahui bagian yang belum dapat diverifikasi.

---

# 12. Prinsip utama yang tidak boleh dilanggar

1. Evaluasi hanya commit yang belum diperiksa.
2. Baca `catatan.md` sebelum menentukan commit target.
3. Jika belum ada checkpoint, gunakan 5 commit terbaru.
4. Tetapkan `TARGET_HEAD` sebelum membaca perubahan.
5. Jangan memasukkan commit baru setelah target ditentukan.
6. Baca dan patuhi seluruh aturan proyek.
7. Baca source SDK dan package, termasuk untuk widget biasa.
8. Jangan menyimpulkan API sesuai tanpa memeriksa source yang relevan.
9. Tambahkan atau perbarui temuan di `task.md` sesuai `format_task.md`.
10. Jaga `catatan.md` tetap ringkas dan tidak membengkak.
11. Jangan mengubah kode Dart.
12. Jangan mengimplementasikan saran perbaikan.
13. Laporkan hasil pemeriksaan secara jelas dan dapat diverifikasi.

**Prioritas tertinggi command ini adalah ketepatan evaluasi, kepatuhan terhadap aturan proyek, pemeriksaan source SDK, dan keamanan agar tidak ada perubahan kode yang dilakukan tanpa persetujuan pengguna.**
