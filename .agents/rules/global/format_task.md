# ATURAN FORMAT PENULISAN task.md

**Lokasi file aturan:** `.agents/rules/global/format_task.md`  
**File yang diatur:** `task.md` di root repositori  
**Cakupan:** Semua orang dan AI yang membuat, menambahkan, memperbarui, menghapus, atau menyusun ulang isi `task.md`.

## 1. Tujuan dan ketentuan utama

Aturan ini bertujuan menjaga agar seluruh isi `task.md` selalu memiliki format penulisan, struktur, pengelompokan, dan informasi yang konsisten.

Ketentuan wajib:

1. Setiap orang dan AI yang akan mengubah `task.md` wajib membaca dan memahami seluruh isi file aturan ini terlebih dahulu.
2. Setiap penambahan atau pembaruan task wajib mengikuti struktur dan format yang ditetapkan dalam aturan ini.
3. Jangan membuat format penulisan sendiri atau mengubah struktur yang sudah ditetapkan.
4. Jangan menghilangkan informasi atau field yang sudah menjadi bagian dari format task.
5. Jangan mengubah isi field `Prompt` karena field tersebut hanya boleh diisi dan diperbarui oleh pemilik repositori.
6. Jangan membuat informasi, nama file, lokasi file, nomor baris, atau pelanggaran aturan berdasarkan perkiraan. Periksa kondisi repositori terlebih dahulu.
7. Jika menemukan ketidakjelasan atau informasi yang belum dapat diverifikasi, tuliskan secara eksplisit bahwa informasi tersebut belum diketahui atau belum diverifikasi.

## 2. Pengelompokan task berdasarkan file terdampak

**Ketentuan utama: task harus dikelompokkan berdasarkan hubungan file yang terdampak, bukan berdasarkan kemiripan masalah atau jenis pekerjaan.**

### 2.1. Ketentuan pembentukan kelompok

1. Setiap task harus mencantumkan seluruh file yang perlu diubah atau diperbaiki untuk menyelesaikan task tersebut.
2. Dua atau lebih task wajib berada dalam kelompok yang sama apabila memiliki setidaknya satu file terdampak yang sama.
3. Pengelompokan berlaku secara berantai (transitif). Apabila Task A dan Task B memiliki file yang sama, kemudian Task B dan Task C juga memiliki file yang sama, ketiganya harus berada dalam satu kelompok.
4. Task yang tidak memiliki hubungan file terdampak dengan task lainnya harus ditempatkan dalam kelompok yang berbeda.
5. Satu task hanya boleh dicantumkan satu kali. Jangan menggandakan task hanya untuk memasukkannya ke beberapa kelompok.
6. Setiap kelompok wajib memiliki daftar `File terdampak` yang berisi gabungan seluruh file terdampak dari semua task di kelompok tersebut.
7. File yang sama hanya boleh dicantumkan satu kali dalam daftar `File terdampak` kelompok.
8. Urutkan daftar file berdasarkan path secara alfabetis agar konsisten.
9. Nomor kelompok dimulai dari `Kelompok 1` dan dilanjutkan secara berurutan.
10. Jika file yang terdampak belum dapat diketahui, jangan menebak. Tempatkan task tersebut dalam kelompok tersendiri dengan keterangan `Belum teridentifikasi` sampai file terdampaknya diketahui.

### 2.2. Contoh pengelompokan

Misalnya ditemukan task berikut:

- Task A memperbaiki file A, B, dan C.
- Task B memperbaiki file A saja.
- Task C memperbaiki file C dan D.
- Task D memperbaiki file E saja.

Hasil pengelompokan yang benar:

**Kelompok 1:**

- Task A: file A, B, dan C.
- Task B: file A.
- Task C: file C dan D.
- File terdampak kelompok: A, B, C, dan D.

Task A, B, dan C berada dalam satu kelompok karena memiliki hubungan file terdampak, baik secara langsung maupun berantai.

**Kelompok 2:**

- Task D: file E.
- File terdampak kelompok: E.

Task D berada dalam kelompok berbeda karena tidak memiliki file terdampak yang sama dengan task lainnya.

## 3. Struktur kelompok dan prioritas

Setiap kelompok wajib menggunakan struktur berikut:

1. Judul kelompok menggunakan format `# Kelompok N`.
2. Daftar file menggunakan heading `## File terdampak`.
3. Task dikelompokkan berdasarkan prioritas.
4. Urutan prioritas mengikuti urutan dari yang paling tinggi ke yang lebih rendah.
5. Gunakan heading `## Tinggi` dan `## Rendah` sebagaimana format utama yang ditetapkan dalam contoh.
6. Apabila repositori telah menetapkan kategori prioritas lain, seperti `Sedang`, pertahankan kategori tersebut di antara `Tinggi` dan `Rendah`. Jangan membuat atau menghapus kategori prioritas tanpa persetujuan pemilik repositori.
7. Penomoran task dimulai kembali dari `Task 1` pada setiap bagian prioritas dalam setiap kelompok.
8. Setiap task wajib memiliki field yang sama dan mengikuti urutan field yang ditentukan pada bagian 4.

## 4. Format wajib setiap task

Setiap task wajib menggunakan urutan field berikut:

### 4.1. Status

Menunjukkan kondisi pengerjaan task.

Gunakan hanya nilai berikut:

- `Belum dikerjakan`: pekerjaan belum dimulai.
- `Sedang dikerjakan`: pekerjaan sudah dimulai, tetapi belum selesai.
- `Selesai`: seluruh pekerjaan sudah diselesaikan dan hasilnya telah diverifikasi.

Ketentuan:

- Jangan menggunakan istilah yang tidak konsisten seperti `setengah`, `proses`, atau `kerjakan`.
- Istilah `kerjakan` merupakan instruksi untuk melakukan pekerjaan, bukan status pengerjaan.
- Jangan menetapkan status `Selesai` hanya berdasarkan asumsi. Harus ada bukti bahwa pekerjaan benar-benar selesai.

### 4.2. Masalah

Berisi penjelasan masalah yang ditemukan pada task tersebut.

Ketentuan:

1. Jelaskan masalah secara spesifik dan mudah dipahami.
2. Jelaskan kondisi aktual yang menyebabkan task diperlukan.
3. Gunakan informasi berdasarkan hasil pemeriksaan kode, file, dokumentasi, atau aturan yang relevan.
4. Jangan menuliskan dugaan sebagai fakta.
5. Apabila informasi belum cukup, jelaskan bagian yang belum diketahui.

### 4.3. Solusi

Berisi rekomendasi penyelesaian masalah.

Ketentuan:

1. Jelaskan solusi yang direkomendasikan secara spesifik.
2. Jelaskan bagian atau perilaku yang perlu diperbaiki.
3. Berikan contoh penerapan apabila contoh dapat membantu memperjelas solusi.
4. Pastikan solusi berhubungan langsung dengan masalah yang dijelaskan.
5. Jangan menambahkan pekerjaan lain yang tidak diperlukan untuk menyelesaikan masalah tersebut.
6. Solusi merupakan rekomendasi teknis, bukan klaim bahwa perubahan sudah diterapkan.

### 4.4. Aturan dilanggar

Berisi seluruh aturan repositori yang terbukti dilanggar oleh masalah tersebut.

Ketentuan:

1. Periksa aturan repositori yang relevan sebelum mencantumkan pelanggaran.
2. Cantumkan seluruh aturan yang benar-benar dilanggar, bukan hanya satu aturan yang paling terlihat.
3. Setiap aturan wajib memiliki tautan menuju file aturan yang tepat.
4. Sertakan nomor baris apabila lokasi pelanggaran aturan dapat diketahui.
5. Jangan mencantumkan aturan yang tidak relevan atau belum terbukti dilanggar.
6. Apabila tidak ditemukan pelanggaran, tuliskan `Tidak ada`.
7. Apabila pemeriksaan belum dilakukan, tuliskan `Belum diverifikasi`. Jangan menyamakan kondisi ini dengan `Tidak ada`.

### 4.5. File bermasalah

Berisi seluruh file yang perlu diperbaiki atau diubah untuk menyelesaikan task tersebut.

Ketentuan:

1. Cantumkan semua file yang benar-benar perlu diperbaiki.
2. Setiap file wajib menggunakan path yang benar dan dapat ditemukan di repositori.
3. Sertakan nomor baris apabila bagian yang bermasalah dapat diketahui.
4. Jangan mencantumkan file yang hanya dibaca atau diperiksa apabila file tersebut tidak perlu diubah.
5. Jangan mengarang path atau lokasi kode.
6. Apabila file belum dapat diidentifikasi, tuliskan `Belum teridentifikasi`.
7. Daftar file pada bagian ini harus sesuai dengan file yang menjadi dasar pengelompokan task.

### 4.6. Prompt

Field `Prompt` hanya boleh diisi, diubah, atau dihapus oleh pemilik repositori.

Ketentuan:

1. AI dan pihak lain dilarang mengisi field ini.
2. AI dan pihak lain dilarang mengubah, memperbaiki redaksi, meringkas, menerjemahkan, atau menghapus isi yang sudah ditulis pemilik repositori.
3. Apabila field masih kosong, biarkan tetap kosong.
4. Field ini wajib tetap tersedia pada setiap task, termasuk task prioritas rendah.
5. Jangan menggantinya dengan rekomendasi atau instruksi buatan AI.

## 5. Ketentuan tautan dan referensi file

Gunakan sintaks tautan Markdown standar agar nama file dan aturan dapat dibuka melalui tautan.

### 5.1. Tautan file

Gunakan format:

`[Nama file](path/relatif/menuju/file)`

Contoh:

`[File A](lib/fitur/file_a.dart)`

### 5.2. Tautan aturan beserta nomor baris

Gunakan format:

`[Nama aturan](path/relatif/menuju/aturan.md#L32)`

Contoh:

`[aturan_boilprate.md](.agents/rules/aturan_boilprate.md#L32)`

Jika perlu menunjukkan rentang baris, gunakan format:

`[aturan_boilprate.md](.agents/rules/aturan_boilprate.md#L32-L36)`

### 5.3. Ketentuan penggunaan tautan

1. Semua path harus relatif terhadap root repositori karena file `task.md` berada di root.
2. Gunakan path file yang benar-benar ada di repositori.
3. Nomor baris harus berdasarkan isi file yang diperiksa saat itu.
4. Jangan menggunakan nomor baris perkiraan.
5. Jika nomor baris tidak diketahui, tautkan ke file tanpa menambahkan nomor baris.
6. Jangan menggunakan format tautan terbalik seperti `(Nama file)[path/file]`. Gunakan format Markdown standar seperti `[Nama file](path/file)`.

## 6. Ketentuan ketika menambahkan atau memperbarui task

Setiap kali mengubah `task.md`, lakukan hal berikut:

1. Baca seluruh aturan dalam file `.agents/rules/global/format_task.md`.
2. Periksa struktur dan isi `task.md` yang sudah ada sebelum melakukan perubahan.
3. Periksa file yang berhubungan dengan task agar daftar file terdampak akurat.
4. Periksa aturan repositori yang relevan untuk mengidentifikasi pelanggaran.
5. Tentukan seluruh file yang perlu diubah untuk setiap task.
6. Kelompokkan task berdasarkan hubungan file terdampak sesuai bagian 2.
7. Masukkan task ke kelompok dan prioritas yang sesuai.
8. Gunakan seluruh field dan urutan penulisan yang diwajibkan.
9. Pastikan daftar file terdampak kelompok merupakan gabungan seluruh file dari task di dalam kelompok tersebut.
10. Pastikan tidak ada task ganda, kelompok yang salah, tautan yang rusak, atau informasi yang tidak terverifikasi.
11. Pertahankan isi `Prompt` yang sudah ditulis pemilik repositori tanpa perubahan.
12. Setelah perubahan, periksa kembali seluruh struktur `task.md` untuk memastikan konsistensinya.

Jika perubahan pada sebuah task menyebabkan daftar file terdampaknya berubah, lakukan pengelompokan ulang berdasarkan daftar file terbaru. Jangan mempertahankan pengelompokan lama apabila sudah tidak sesuai dengan ketentuan.

## 7. Template baku task.md

Template berikut menjadi acuan format penulisan. Gunakan struktur ini ketika membuat atau menyusun ulang kelompok dan task.

```markdown
# Kelompok 1

## File terdampak

- [path/menuju/file_a.dart](path/menuju/file_a.dart)
- [path/menuju/file_b.dart](path/menuju/file_b.dart)

## Tinggi

#### Task 1

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah yang ditemukan secara spesifik.
- Solusi: Jelaskan solusi yang direkomendasikan dan berikan contoh jika diperlukan.
- Aturan dilanggar: [Nama aturan](.agents/rules/nama_aturan.md#L32)
- File bermasalah: [file_a.dart](path/menuju/file_a.dart#L15)
- Prompt:

#### Task 2

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah yang ditemukan secara spesifik.
- Solusi: Jelaskan solusi yang direkomendasikan dan berikan contoh jika diperlukan.
- Aturan dilanggar: Tidak ada
- File bermasalah: [file_b.dart](path/menuju/file_b.dart)
- Prompt:

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah yang ditemukan secara spesifik.
- Solusi: Jelaskan solusi yang direkomendasikan dan berikan contoh jika diperlukan.
- Aturan dilanggar: Tidak ada
- File bermasalah: [file_a.dart](path/menuju/file_a.dart)
- Prompt:

# Kelompok 2

## File terdampak

- [path/menuju/file_c.dart](path/menuju/file_c.dart)

## Tinggi

#### Task 1

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah yang ditemukan secara spesifik.
- Solusi: Jelaskan solusi yang direkomendasikan dan berikan contoh jika diperlukan.
- Aturan dilanggar: [Nama aturan](.agents/rules/nama_aturan.md#L32)
- File bermasalah: [file_c.dart](path/menuju/file_c.dart#L20)
- Prompt:

## Rendah

#### Task 1

- Status: Belum dikerjakan
- Masalah: Jelaskan masalah yang ditemukan secara spesifik.
- Solusi: Jelaskan solusi yang direkomendasikan dan berikan contoh jika diperlukan.
- Aturan dilanggar: Tidak ada
- File bermasalah: [file_c.dart](path/menuju/file_c.dart)
- Prompt:
```

## 8. Larangan

Semua pihak yang mengubah `task.md` dilarang:

1. Menggunakan format penulisan task yang berbeda dari template.
2. Mengelompokkan task hanya berdasarkan kemiripan masalah tanpa memperhatikan file terdampak.
3. Memisahkan task yang seharusnya berada dalam satu kelompok karena memiliki hubungan file terdampak.
4. Menggabungkan task yang tidak memiliki hubungan file terdampak.
5. Menghilangkan daftar `File terdampak` pada kelompok.
6. Menghilangkan salah satu field wajib dari task.
7. Mengubah urutan field yang telah ditetapkan.
8. Mengisi atau mengubah field `Prompt`.
9. Membuat tautan file atau aturan yang tidak sesuai dengan path sebenarnya.
10. Mengarang nomor baris, pelanggaran aturan, masalah, atau solusi.
11. Menandai task selesai tanpa bukti penyelesaian.
12. Mengubah struktur format ini tanpa persetujuan pemilik repositori.

**Ketentuan akhir:** Konsistensi struktur dan isi `task.md` wajib dipertahankan setiap kali file dibuat, ditambahkan, diperbarui, maupun disusun ulang. Apabila terdapat konflik antara kebiasaan penulisan sebelumnya dengan aturan ini, gunakan aturan dalam `.agents/rules/global/format_task.md` sebagai acuan format `task.md`.
