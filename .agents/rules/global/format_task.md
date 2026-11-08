# Aturan Format Penulisan `task.md`

**Path aturan:** `.agents/rules/global/format_task.md`  
**File yang diatur:** `task.md` pada root repositori.

## 1. Tujuan

File ini menetapkan standar penulisan, penyusunan, pengelompokan, dan pembaruan seluruh task di `task.md` pada root repositori.

Tujuannya:

1. Memastikan seluruh AI dan manusia menggunakan format penulisan yang konsisten.
2. Memastikan setiap task dikelompokkan berdasarkan file yang terdampak.
3. Memudahkan identifikasi file yang harus diperbaiki.
4. Memudahkan penentuan prioritas pengerjaan.
5. Mencegah duplikasi, kehilangan informasi, dan ketidakkonsistenan ketika task diperbarui.
6. Memastikan setiap rekomendasi solusi dapat dipahami dan dilaksanakan oleh developer.

## 2. Cakupan Penerapan

1. Aturan ini berlaku untuk seluruh pihak yang menambahkan, memperbarui, mengubah, memindahkan, atau menghapus isi `task.md` di root repositori.
2. AI wajib membaca dan memahami file ini sebelum melakukan perubahan terhadap `task.md`.
3. Aturan ini berlaku untuk seluruh kategori temuan, termasuk Bug Runtime, UX, dan UI.
4. Tidak boleh membuat format penulisan alternatif tanpa persetujuan pengguna.
5. Seluruh isi `task.md` wajib mengikuti struktur yang ditentukan dalam dokumen ini.
6. Perubahan terhadap task tidak boleh menghilangkan informasi penting dari temuan sebelumnya.

## 3. Aturan Pengelompokan Task Berdasarkan File Terdampak

### 3.1 Prinsip Pengelompokan

1. Setiap task wajib memiliki daftar file yang terdampak.
2. Task yang memiliki setidaknya satu file terdampak yang sama wajib dimasukkan ke dalam kelompok yang sama.
3. Pengelompokan menggunakan prinsip keterhubungan file secara transitif.
4. Apabila Task A dan Task B memiliki file yang sama, keduanya masuk kelompok yang sama.
5. Apabila Task C memiliki file yang sama dengan Task A atau Task B, Task C juga wajib dimasukkan ke kelompok tersebut.
6. Task yang tidak memiliki hubungan file dengan kelompok lain wajib ditempatkan pada kelompok tersendiri.
7. Setiap task hanya boleh tercatat satu kali. Jangan menduplikasi task ke beberapa kelompok.

### 3.2 Contoh Pengelompokan

Data awal:

| Task   | File terdampak                           |
| ------ | ---------------------------------------- |
| Task A | `lib/a.dart`, `lib/b.dart`, `lib/c.dart` |
| Task B | `lib/a.dart`                             |
| Task C | `lib/c.dart`, `lib/d.dart`               |
| Task D | `lib/e.dart`                             |

Hasil pengelompokan:

**Kelompok 1**

- Task A
- Task B
- Task C

File terdampak: `lib/a.dart`, `lib/b.dart`, `lib/c.dart`, `lib/d.dart`.

**Kelompok 2**

- Task D

File terdampak: `lib/e.dart`.

### 3.3 Ketentuan Daftar File Terdampak

1. Setiap kelompok wajib memiliki bagian `File Terdampak`.
2. Cantumkan seluruh file yang berhubungan dengan task dalam kelompok tersebut.
3. Setiap path file hanya boleh dicantumkan satu kali dalam daftar kelompok.
4. Gunakan path relatif terhadap root repositori.
5. Gunakan tautan Markdown yang mengarah ke file sebenarnya.
6. Urutkan daftar file secara alfabetis.
7. Jangan mengarang path file.
8. Pastikan file benar-benar ada atau telah teridentifikasi berdasarkan pemeriksaan kode dan struktur repositori.
9. Apabila file belum dapat diidentifikasi, jangan membuat asumsi. Tandai sebagai belum teridentifikasi dan laporkan keterbatasannya.

## 4. Struktur Prioritas Task

Setiap kelompok wajib memiliki tiga bagian prioritas:

1. Tinggi
2. Sedang
3. Rendah

Ketentuan:

- Tempatkan setiap task pada prioritas yang sesuai.
- Jangan menghilangkan tingkat prioritas yang tidak memiliki task. Tuliskan `Tidak ada temuan.`.
- Jangan mengubah prioritas tanpa alasan yang dapat dipertanggungjawabkan.
- Setiap task hanya boleh memiliki satu prioritas utama.
- Urutkan task dalam prioritas yang sama berdasarkan urutan pengerjaan yang direkomendasikan.

## 5. Format Penulisan Setiap Task

Gunakan struktur berikut untuk setiap task.

### 5.1 Identitas Task

Gunakan heading:

`#### Task 1`

Nomor task dimulai dari 1 untuk setiap kelompok dan bertambah secara berurutan.

Jangan menggunakan nomor task yang sama untuk dua task dalam kelompok yang sama.

### 5.2 Status

Gunakan format:

`- Status: [status]`

Status yang diperbolehkan:

- `Belum`: Task belum dikerjakan.
- `Setengah`: Task sudah dikerjakan sebagian, tetapi belum selesai.
- `Kerjakan`: Task sudah diidentifikasi dan siap untuk dikerjakan.
- `Selesai`: Task sudah diselesaikan dan hasilnya telah diverifikasi.

Jangan menggunakan istilah status lain tanpa persetujuan pengguna.

### 5.3 Kategori

Gunakan format:

`- Kategori: [kategori]`

Kategori yang digunakan:

- Bug Runtime
- UX
- UI

Pertahankan kategori temuan agar klasifikasi yang sudah digunakan dalam `task.md` tidak hilang.

### 5.4 Masalah

Gunakan format:

`- Masalah: [penjelasan masalah]`

Ketentuan:

1. Jelaskan masalah secara spesifik dan mudah dipahami.
2. Jelaskan kondisi aktual yang ditemukan.
3. Jelaskan dampak masalah terhadap aplikasi, pengguna, atau kode.
4. Hindari penjelasan yang terlalu umum.
5. Jangan menyatakan dugaan sebagai fakta.
6. Apabila penyebab belum diketahui, jelaskan bahwa penyebab masih perlu diperiksa.

### 5.5 Solusi

Gunakan format:

`- Solusi: [rekomendasi penyelesaian]`

Ketentuan:

1. Berikan solusi yang spesifik dan dapat dilaksanakan.
2. Jelaskan bagian yang harus diperbaiki.
3. Berikan contoh implementasi apabila diperlukan untuk memperjelas solusi.
4. Contoh harus relevan dengan struktur kode aktual.
5. Jangan memberikan solusi yang bertentangan dengan aturan repositori.
6. Jangan merekomendasikan perubahan yang tidak berhubungan dengan masalah.
7. Apabila terdapat beberapa alternatif, pisahkan rekomendasi utama dan alternatifnya.
8. Jangan menganggap solusi sudah diterapkan sebelum diverifikasi.

### 5.6 Aturan Dilanggar

Gunakan format:

`- Aturan Dilanggar: [daftar aturan]`

Ketentuan:

1. Cantumkan seluruh aturan yang benar-benar dilanggar oleh task.
2. Gunakan nama file aturan dan nomor baris atau referensi bagian yang relevan.
3. Gunakan tautan Markdown yang dapat dibuka.
4. Jangan mengarang nama file aturan, nomor baris, atau isi aturan.
5. Apabila tidak ada aturan yang dilanggar, tuliskan `Tidak ada.`.
6. Apabila pelanggaran belum dapat dipastikan, tuliskan `Belum terverifikasi.`.

Contoh:

`- Aturan Dilanggar: [optimasi_boilerplate.md:32](.agents/rules/global/optimasi_boilerplate.md#L32)`

### 5.7 File Bermasalah

Gunakan format:

`- File Bermasalah: [daftar file]`

Ketentuan:

1. Cantumkan seluruh file yang benar-benar perlu diperbaiki untuk menyelesaikan task.
2. Gunakan path relatif terhadap root repositori.
3. Gunakan tautan Markdown.
4. Apabila memungkinkan, sertakan nomor baris yang relevan.
5. Jangan mencantumkan file hanya karena file tersebut berhubungan secara tidak langsung.
6. File yang hanya perlu diperiksa tetapi tidak perlu diubah tidak boleh dianggap sebagai file bermasalah.
7. Apabila belum diketahui file mana yang harus diperbaiki, tuliskan `Belum teridentifikasi.`.

Contoh:

`- File Bermasalah: [tema_notifier.dart:9](lib/fitur/tema/notifier/tema_notifier.dart#L9)`

## 6. Standar Penulisan Markdown

1. Gunakan bahasa Indonesia yang baik dan benar.
2. Gunakan istilah teknis secara konsisten.
3. Gunakan heading Markdown sesuai struktur yang ditentukan.
4. Gunakan format `- Nama Field: Isi`.
5. Jangan mengubah urutan field dalam task.
6. Gunakan tautan Markdown dengan format `[nama](path)`.
7. Hindari penggunaan format tautan yang tidak valid.
8. Gunakan satu baris kosong untuk memisahkan bagian agar mudah dibaca.
9. Jangan menggunakan heading yang tidak diperlukan.
10. Jangan menambahkan penjelasan di luar struktur task apabila tidak diperlukan.

## 7. Ketentuan Pembaruan Task

### 7.1 Menambahkan Task

1. Periksa terlebih dahulu apakah masalah sudah tercatat.
2. Jangan menambahkan task duplikat.
3. Identifikasi seluruh file terdampak.
4. Tentukan kelompok berdasarkan hubungan file.
5. Tentukan kategori dan prioritas.
6. Tuliskan seluruh field sesuai format.
7. Pastikan rekomendasi solusi dapat dipahami.

### 7.2 Memperbarui Task

1. Pertahankan identitas dan informasi task yang masih relevan.
2. Perbarui status sesuai hasil pekerjaan aktual.
3. Perbarui masalah atau solusi hanya apabila terdapat informasi baru yang terverifikasi.
4. Perbarui daftar file apabila cakupan perubahan diketahui bertambah atau berkurang.
5. Apabila daftar file berubah, evaluasi kembali pengelompokan seluruh task.
6. Jangan menghapus informasi penting tanpa alasan yang jelas.

### 7.3 Memindahkan Task

Apabila perubahan file terdampak menyebabkan suatu task harus berpindah kelompok:

1. Periksa kembali hubungan file seluruh task.
2. Susun ulang kelompok berdasarkan prinsip keterhubungan file.
3. Pindahkan task ke kelompok yang benar.
4. Jangan menggandakan task.
5. Sesuaikan nomor kelompok dan nomor task jika diperlukan.

### 7.4 Menghapus Task

Task hanya boleh dihapus apabila:

1. Task terbukti duplikat.
2. Temuan terbukti tidak valid.
3. Task tidak lagi relevan berdasarkan hasil pemeriksaan.
4. Pengguna secara langsung meminta penghapusan.

Jangan menghapus task hanya karena belum dikerjakan atau sulit diperbaiki.

## 8. Template Wajib `task.md`

Seluruh isi `task.md` wajib menggunakan struktur berikut:

# Kelompok 1

## File Terdampak

- [file_a.dart](lib/file_a.dart)
- [file_b.dart](lib/file_b.dart)
- [file_c.dart](lib/file_c.dart)

## Tinggi

#### Task 1

- Status: Belum
- Kategori: Bug Runtime
- Masalah: Jelaskan masalah yang ditemukan secara spesifik.
- Solusi: Jelaskan solusi yang direkomendasikan beserta contoh implementasi apabila diperlukan.
- Aturan Dilanggar: [nama_aturan.md:32](.agents/rules/global/nama_aturan.md#L32)
- File Bermasalah: [file_a.dart:10](lib/file_a.dart#L10)

#### Task 2

- Status: Kerjakan
- Kategori: UX
- Masalah: Jelaskan masalah yang ditemukan.
- Solusi: Jelaskan solusi yang direkomendasikan.
- Aturan Dilanggar: Tidak ada.
- File Bermasalah: [file_b.dart](lib/file_b.dart)

## Sedang

Tidak ada temuan.

## Rendah

#### Task 3

- Status: Setengah
- Kategori: UI
- Masalah: Jelaskan masalah yang ditemukan.
- Solusi: Jelaskan solusi yang direkomendasikan.
- Aturan Dilanggar: Belum terverifikasi.
- File Bermasalah: Belum teridentifikasi.

---

# Kelompok 2

## File Terdampak

- [file_d.dart](lib/file_d.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status: Belum
- Kategori: Bug Runtime
- Masalah: Jelaskan masalah yang ditemukan.
- Solusi: Jelaskan solusi yang direkomendasikan.
- Aturan Dilanggar: Tidak ada.
- File Bermasalah: [file_d.dart](lib/file_d.dart)

## Rendah

Tidak ada temuan.

## 9. Pemeriksaan Sebelum Menyimpan `task.md`

Sebelum menyimpan perubahan, wajib melakukan pemeriksaan berikut:

1. Seluruh task sudah dikelompokkan berdasarkan hubungan file terdampak.
2. Tidak ada task yang tercatat lebih dari satu kali.
3. Tidak ada task yang salah kelompok.
4. Setiap kelompok memiliki daftar file terdampak.
5. Setiap task memiliki seluruh field wajib.
6. Status menggunakan nilai yang diperbolehkan.
7. Kategori menggunakan kategori yang diperbolehkan.
8. Prioritas menggunakan Tinggi, Sedang, atau Rendah.
9. Tautan file menggunakan sintaks Markdown yang benar.
10. Seluruh path file telah diverifikasi.
11. Referensi aturan tidak dibuat berdasarkan perkiraan.
12. Rekomendasi solusi sesuai dengan masalah.
13. Tidak ada informasi penting dari task sebelumnya yang hilang.
14. Struktur heading dan urutan field konsisten.
15. Tidak ada bagian yang bertentangan dengan aturan repositori.

Apabila ditemukan kesalahan, perbaiki sebelum menyimpan.

## 10. Ketentuan Utama

Aturan dalam file ini wajib diterapkan oleh seluruh AI dan manusia yang mengelola `task.md` di root repositori.

Tidak diperbolehkan menggunakan format alternatif, mengabaikan pengelompokan berdasarkan file terdampak, atau mengubah struktur secara sepihak.

Apabila terdapat kondisi yang belum diatur dalam dokumen ini, jangan membuat asumsi yang dapat mengubah tujuan atau struktur utama. Laporkan kondisi tersebut kepada pengguna untuk mendapatkan keputusan.

**Prioritas utama: konsistensi format, ketepatan pengelompokan file, keterlacakan masalah, dan kejelasan solusi.**
