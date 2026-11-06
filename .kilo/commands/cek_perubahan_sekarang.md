---
description: Audit perubahan kode Dart yang belum di-commit terhadap AGENTS.md dan source SDK. Laporkan setiap masalah dengan path dan nomor baris beserta saran perbaikan tanpa mengubah apa pun.
agent: ask
---

# AUDIT PERUBAHAN KODE DART SEBELUM COMMIT

## 1. Tujuan Utama

Lakukan pemeriksaan terhadap seluruh perubahan kode Dart yang belum di-commit untuk memastikan implementasinya sudah sesuai dengan:

1. `AGENTS.md`.
2. Seluruh aturan tambahan yang berlaku pada proyek.
3. Standar dan preferensi penulisan kode yang telah ditetapkan.
4. Dokumentasi dan source code Flutter SDK.
5. Dokumentasi dan source code Dart SDK.
6. Source code paket eksternal yang digunakan apabila perubahan berkaitan dengan API paket tersebut.
7. Prinsip kualitas kode, keamanan runtime, performa, dan maintainability.

Tujuan pemeriksaan adalah menemukan ketidaksesuaian sebelum pengguna melakukan commit.

**Tugas Anda hanya membaca, menganalisis, menemukan masalah, dan menyampaikan laporan beserta saran perbaikan. Pengguna sendiri yang menentukan apakah suatu temuan perlu diperbaiki.**

Jangan melakukan perubahan kode dalam kondisi apa pun.

## 2. Larangan Utama

### 2.1. Jangan mengubah apa pun

Anda hanya diperbolehkan membaca dan menganalisis.

Dilarang:

- Memperbaiki kode.
- Menambahkan kode.
- Menghapus kode.
- Memindahkan file.
- Melakukan refactoring.
- Mengubah struktur proyek.
- Mengubah konfigurasi.
- Memperbarui dokumentasi.
- Membuat file laporan di dalam proyek.
- Mengubah aturan AI.
- Mengubah `AGENTS.md`.
- Melakukan formatting otomatis.
- Menjalankan code generator.
- Memperbarui atau mengubah dependensi.
- Menjalankan migrasi database.
- Menjalankan perintah yang dapat mengubah file proyek.

**Jangan menerapkan saran perbaikan secara otomatis, meskipun Anda yakin bahwa perbaikan tersebut benar.**

Semua saran hanya boleh disampaikan dalam laporan.

### 2.2. Jangan mengubah kondisi Git

Dilarang menjalankan operasi yang dapat mengubah:

- Working tree.
- Staging area.
- Branch.
- Riwayat commit.

Contoh perintah yang dilarang:

```bash
git add
git commit
git reset
git checkout
git restore
git clean
git stash
git merge
git rebase
git cherry-pick
git revert
git pull
git push
```

Larangan tersebut juga berlaku untuk operasi Git lainnya yang memiliki efek serupa.

Anda hanya boleh menggunakan perintah Git yang bersifat read-only untuk membaca dan membandingkan perubahan.

Jangan mengubah staging area, baik secara langsung maupun tidak langsung.

### 2.3. Jangan menjalankan pemeriksaan yang berpotensi mengubah proyek

Jangan menjalankan:

- `dart format`
- `flutter pub get`
- `flutter pub add`
- Code generator.
- Perintah migrasi.
- Test yang berpotensi menulis data atau file.
- Perintah yang memperbarui cache SDK atau dependensi.
- Perintah lain yang berpotensi mengubah file proyek.

Jangan menjalankan pemeriksaan otomatis yang dapat menulis file atau mengubah kondisi proyek.

Pemeriksaan dilakukan melalui pembacaan kode, perbandingan perubahan, dan pemeriksaan source SDK.

Jika suatu pemeriksaan membutuhkan proses yang berpotensi mengubah file, jangan jalankan. Jelaskan keterbatasannya dalam laporan.

## 3. Baca AGENTS.md dan Aturan Proyek

Sebelum menganalisis kode, baca seluruh isi:

`AGENTS.md`

Jika `AGENTS.md` merujuk ke file aturan lain, baca seluruh aturan yang relevan.

Periksa pula apakah terdapat `AGENTS.md` tambahan pada direktori tempat file Dart yang berubah berada.

Tujuannya:

1. Memahami seluruh standar yang berlaku.
2. Mengetahui larangan dan ketentuan implementasi.
3. Mengetahui standar penulisan kode.
4. Memahami arsitektur proyek.
5. Mengetahui preferensi pengembangan pengguna.
6. Menghindari penilaian berdasarkan asumsi pribadi.
7. Menemukan ketidaksesuaian terhadap aturan yang sudah ditetapkan.

Jangan hanya membaca sebagian aturan atau mengandalkan ingatan dari percakapan sebelumnya.

Jika terdapat aturan yang bertentangan:

1. Identifikasi aturan yang bertentangan.
2. Cantumkan path dan bagian masing-masing aturan.
3. Periksa apakah terdapat ketentuan prioritas.
4. Jangan membuat keputusan berdasarkan asumsi.
5. Laporkan konflik yang belum dapat dipastikan.

**Gunakan AGENTS.md dan aturan proyek sebagai acuan utama pemeriksaan. Jangan mengganti ketentuan proyek dengan preferensi pribadi.**

## 4. Identifikasi Perubahan Git yang Belum Di-commit

Audit hanya mencakup file dengan ekstensi `.dart`.

Periksa tiga jenis perubahan berikut secara terpisah.

### 4.1. Staged Changes

Perubahan yang sudah masuk staging area tetapi belum di-commit.

Untuk melihat daftar file:

```bash
git diff --cached --name-status --find-renames -- '*.dart'
```

Untuk membaca detail perubahan:

```bash
git diff --cached --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa:

- File Dart yang ditambahkan.
- File Dart yang diubah.
- File Dart yang dihapus.
- File Dart yang di-rename.

### 4.2. Unstaged Changes

Perubahan pada working tree yang belum masuk staging area.

Untuk melihat daftar file:

```bash
git diff --name-status --find-renames -- '*.dart'
```

Untuk membaca detail perubahan:

```bash
git diff --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Periksa seluruh perubahan, termasuk file yang sebelumnya sudah di-stage tetapi kemudian diedit kembali.

### 4.3. Untracked Dart Files

Periksa file Dart baru yang belum dilacak Git:

```bash
git ls-files --others --exclude-standard -- '*.dart'
```

Untuk file tersebut, baca seluruh isi karena belum memiliki versi pembanding dalam riwayat Git.

Jangan mengabaikan file Dart baru hanya karena belum masuk staging.

### 4.4. Ketentuan pemeriksaan

1. Periksa staged, unstaged, dan untracked secara terpisah.
2. Jangan mencampurkan ketiganya menjadi satu kesimpulan.
3. Jika satu file mempunyai perubahan staged sekaligus unstaged, audit keduanya secara terpisah.
4. Jika diperlukan, baca file Dart secara lengkap untuk memahami konteks.
5. Untuk file yang dihapus, periksa kode yang dihapus melalui diff.
6. Untuk file yang di-rename, periksa perubahan kode dan lokasi barunya.
7. Jangan hanya membaca ringkasan nama file.
8. Jangan hanya membaca sebagian perubahan.
9. Jangan melewatkan perubahan yang terlihat sederhana.

Gunakan perintah berikut apabila perlu membaca versi file yang sudah berada di staging:

```bash
git show :path/file.dart
```

Jangan menggunakan isi working tree sebagai pengganti isi staging karena keduanya mungkin memiliki implementasi yang berbeda.

Jangan menggunakan perintah yang dapat mengubah index atau working tree untuk mendapatkan isi file.

### 4.5. Perubahan pada file yang sama

Satu file dapat memiliki dua kondisi berbeda:

- Perubahan pertama sudah masuk staging.
- Perubahan berikutnya masih berada di working tree.

Periksa kedua perubahan tersebut secara terpisah.

Pastikan kesimpulan tidak mencampurkan implementasi versi staging dengan implementasi versi working tree.

## 5. Batasan File yang Diperiksa

Fokus audit hanya pada perubahan kode Dart.

File yang menjadi target:

- File `.dart` yang sudah staged.
- File `.dart` yang belum staged.
- File `.dart` baru yang belum dilacak Git.
- File `.dart` yang dihapus.
- File `.dart` yang di-rename.

Jangan melakukan audit terhadap perubahan pada:

- `pubspec.yaml`
- `pubspec.lock`
- `.yaml`
- `.json`
- `.md`
- `.xml`
- `.gradle`
- `.kt`
- `.java`
- `.swift`
- `.html`
- `.css`
- File konfigurasi lainnya.

Namun, file konfigurasi boleh dibaca apabila diperlukan untuk memahami versi SDK, lokasi dependensi, atau konteks implementasi.

Pembacaan file pendukung tersebut bukan berarti Anda harus mengaudit perubahan di dalamnya.

### 5.1. File generated

Jangan langsung mengabaikan file Dart hasil generator.

Jika file generated mengalami perubahan:

1. Identifikasi apakah file tersebut merupakan hasil generator.
2. Periksa apakah implementasinya seharusnya dilakukan melalui file sumber generator.
3. Periksa aturan proyek mengenai generated files.
4. Laporkan jika terdapat pelanggaran.

Jangan menjalankan generator atau mengubah file generated.

## 6. Evaluasi Kesesuaian dengan AGENTS.md

Evaluasi setiap perubahan kode terhadap seluruh aturan yang berlaku.

Periksa aspek berikut.

### A. Standar penulisan kode

- Penamaan class, function, variable, dan file.
- Struktur class dan function.
- Konsistensi penulisan kode.
- Pemisahan tanggung jawab.
- Penggunaan abstraksi.
- Penggunaan komentar.
- Kerapian dan keterbacaan.
- Konsistensi pola implementasi.
- Kemudahan pemeliharaan kode.

### B. Bug dan keamanan runtime

- Potensi null error.
- Penggunaan operator `!`.
- Penggunaan `as`.
- Penggunaan `dynamic`.
- Parsing data yang berisiko.
- Penanganan exception.
- Penggunaan `try/catch`.
- Penanganan Future dan asynchronous.
- Penggunaan `mounted` setelah `await`.
- Pengelolaan lifecycle.
- Pengelolaan resource.
- Pemanggilan `dispose`.
- Potensi memory leak.
- Potensi race condition.
- Penanganan transaksi database.
- Validasi input dan data.
- Potensi kehilangan atau kerusakan data.

### C. Arsitektur dan state management

- Penggunaan Provider dan Notifier.
- Penggunaan `ref.watch` dan `ref.read`.
- Penggunaan Riverpod Generator.
- Pengelolaan state.
- Penggunaan Freezed.
- Pemisahan UI dan business logic.
- Pengelolaan cache.
- Aliran data.
- Penggunaan dependency injection.
- Pemisahan tanggung jawab antar-layer.

### D. Performa

- Rebuild widget yang tidak diperlukan.
- Pemrosesan data yang tidak efisien.
- Query database yang tidak efisien.
- Penggunaan cache.
- Penggunaan resource.
- Operasi berat pada UI thread.
- Penggunaan Future dan Stream.
- Potensi penggunaan memori berlebihan.

### E. UX/UI

- Konsistensi desain.
- Keterbacaan teks.
- Ukuran dan jarak komponen.
- Kejelasan fungsi tombol.
- Loading dan feedback operasi.
- Penanganan error.
- Pencegahan interaksi ganda.
- Pengelolaan kondisi kosong.
- Pengalaman penggunaan yang membingungkan.
- Responsivitas tampilan.

### F. Pengujian

- Kesesuaian implementasi dengan standar testing proyek.
- Kualitas unit test.
- Penggunaan mock dan fake.
- Pengujian kondisi normal dan ekstrem.
- Potensi test yang tidak menguji perilaku sebenarnya.

Jangan membatasi evaluasi hanya pada daftar tersebut. Periksa aspek lain apabila perubahan kode memiliki risiko atau dampak teknis yang relevan.

**Prioritaskan pelanggaran aturan yang benar-benar tertulis dalam AGENTS.md dan aturan proyek.**

Jika suatu saran tidak secara langsung melanggar aturan, klasifikasikan sebagai rekomendasi, bukan pelanggaran.

## 7. Wajib Membaca Source Code Flutter dan Dart SDK

Jangan hanya mengandalkan pengetahuan internal AI atau contoh kode yang pernah dipelajari.

**Periksa source code SDK yang benar-benar digunakan oleh proyek.**

Tujuannya memastikan penggunaan API sesuai kontrak dan implementasi SDK.

### 7.1. Identifikasi SDK yang digunakan

Cari lokasi Flutter SDK:

```bash
command -v flutter
```

Periksa lokasi executable sebenarnya:

```bash
readlink -f "$(command -v flutter)"
```

Identifikasi versi Flutter dan Dart yang digunakan dengan membaca informasi versi SDK yang tersedia.

Contoh lokasi:

```text
<FLUTTER_SDK>/version
<FLUTTER_SDK>/bin/cache/dart-sdk/version
```

Utamakan pembacaan informasi versi yang sudah tersedia.

Jangan mengganti SDK, mengunduh versi baru, atau menjalankan proses pembaruan SDK.

### 7.2. Lokasi source code Flutter SDK

Periksa source code Flutter pada:

```text
<FLUTTER_SDK>/packages/flutter/lib/
```

Untuk implementasi internal framework Flutter:

```text
<FLUTTER_SDK>/packages/flutter/lib/src/
```

### 7.3. Lokasi source code Dart SDK

Periksa source code Dart pada:

```text
<FLUTTER_SDK>/bin/cache/dart-sdk/lib/
```

Sesuaikan subdirektori dengan API yang digunakan.

Contohnya:

- `dart:async`
- `dart:collection`
- `dart:core`
- `dart:convert`
- `dart:io`
- `dart:isolate`

Jangan membaca seluruh SDK tanpa tujuan. Temukan source yang benar-benar berkaitan dengan perubahan kode.

### 7.4. Source code paket eksternal

Jika perubahan menggunakan API paket eksternal, periksa source code paket yang benar-benar digunakan proyek.

Gunakan informasi resolusi dependensi pada:

`.dart_tool/package_config.json`

Temukan lokasi package root berdasarkan konfigurasi tersebut.

Periksa deklarasi API dan implementasinya pada source paket yang tersedia.

Jangan menjalankan `flutter pub get` hanya untuk mendapatkan source paket.

Jika source paket belum tersedia, catat keterbatasannya dan jangan mengklaim sudah memeriksanya.

### 7.5. Hal yang wajib diperiksa dari source SDK

Untuk setiap API yang relevan dengan perubahan, periksa:

1. Deklarasi class dan inheritance.
2. Constructor dan parameter yang tersedia.
3. Tipe data parameter dan nilai kembalian.
4. Generic type.
5. Nullability.
6. Callback signature.
7. Lifecycle method.
8. Kontrak pemanggilan method.
9. Perilaku asynchronous.
10. Penanganan error dan exception.
11. Pengelolaan resource.
12. Perilaku state dan notifikasi perubahan.
13. Default value.
14. API yang deprecated.
15. Ketentuan penggunaan pada platform tertentu.

Jangan menyimpulkan penggunaan API benar hanya karena kode dapat ditulis atau terlihat benar.

### 7.6. Hubungkan source SDK dengan kode yang berubah

Untuk setiap ketidaksesuaian SDK:

- Sebutkan API yang diperiksa.
- Sebutkan path source SDK yang dibaca.
- Sebutkan nomor baris source SDK apabila tersedia.
- Jelaskan kontrak API yang relevan.
- Tunjukkan lokasi kode proyek yang tidak sesuai.
- Jelaskan risiko akibat ketidaksesuaian.
- Berikan saran implementasi yang sesuai.

Gunakan source SDK sesuai versi proyek, bukan source versi terbaru yang belum tentu digunakan.

Jika versi SDK atau source tidak dapat dipastikan, jangan membuat kesimpulan tanpa bukti. Laporkan keterbatasannya.

## 8. Periksa Dampak Perubahan terhadap Kode di Sekitarnya

Jangan hanya menilai baris yang berubah secara terpisah.

Jika perubahan memiliki dampak terhadap kode lain, baca kode Dart yang berkaitan.

Contohnya:

- Perubahan provider yang digunakan beberapa widget.
- Perubahan Notifier yang memengaruhi aliran state.
- Perubahan model yang digunakan beberapa repository.
- Perubahan function yang dipanggil dari beberapa tempat.
- Perubahan parameter yang memengaruhi pemanggil.
- Perubahan pengelolaan cache yang memengaruhi tampilan data.
- Perubahan database yang memengaruhi transaksi.
- Perubahan lifecycle widget yang memengaruhi resource lain.

Tujuannya agar tidak terjadi penilaian yang hanya benar secara lokal tetapi salah secara keseluruhan.

Tetap fokus pada dampak langsung dari perubahan Dart yang belum di-commit.

Jangan memperluas audit menjadi pemeriksaan seluruh proyek tanpa alasan teknis.

## 9. Klasifikasi Hasil Pemeriksaan

Jangan melaporkan dugaan sebagai kesalahan yang sudah pasti.

Pisahkan hasil audit menjadi empat kategori.

### A. Pelanggaran Aturan

Perubahan yang tidak sesuai dengan ketentuan tertulis dalam `AGENTS.md` atau aturan proyek.

### B. Ketidaksesuaian SDK

Penggunaan API yang tidak sesuai dengan kontrak source Flutter, Dart, atau paket yang digunakan.

### C. Potensi Bug

Perubahan yang berpotensi menyebabkan kesalahan runtime, kerusakan data, hasil yang tidak sesuai, atau masalah performa.

### D. Rekomendasi Perbaikan

Perubahan yang tidak selalu salah, tetapi mempunyai pendekatan yang lebih baik berdasarkan standar proyek atau source SDK.

Jangan menyamakan rekomendasi dengan pelanggaran.

### 9.1. Tingkat prioritas

Gunakan kategori berikut:

- **Critical:** berpotensi menyebabkan kerusakan data serius, masalah keamanan, atau kegagalan aplikasi yang sangat parah.
- **High:** berpotensi menyebabkan aplikasi crash, data tidak konsisten, atau fitur utama gagal.
- **Medium:** masalah implementasi yang dapat menimbulkan bug atau mengurangi kualitas secara signifikan.
- **Low:** masalah minor seperti konsistensi penulisan atau peningkatan maintainability.
- **Info:** catatan teknis atau rekomendasi yang tidak menunjukkan adanya kesalahan.

Jangan memberikan prioritas secara berlebihan.

## 10. WAJIB Menyertakan Path dan Nomor Baris

**Setiap temuan yang menunjukkan adanya masalah pada kode wajib menyertakan path file dan nomor baris yang tepat.**

Pengguna hanya menginginkan path dan nomor baris.

**Jangan membuat link Markdown, link GitHub, link editor, URL, atau tautan lain.**

### 10.1. Format lokasi

Gunakan format berikut:

```text
lib/fitur/contoh.dart:42
```

Jika masalah mencakup beberapa baris:

```text
lib/fitur/contoh.dart:42-48
```

Gunakan path relatif terhadap root proyek.

Contoh penulisan dalam laporan:

**Lokasi:** `lib/fitur/pengguna/provider.dart:42`

Jangan hanya menuliskan:

`lib/fitur/pengguna/provider.dart`

Tanpa nomor baris.

### 10.2. Nomor baris harus sesuai dengan versi kode yang diperiksa

Perhatikan bahwa staged dan unstaged dapat memiliki isi yang berbeda.

Ketentuan:

- Untuk perubahan unstaged, gunakan nomor baris dari working tree.
- Untuk perubahan staged, gunakan nomor baris berdasarkan versi yang berada di staging.
- Untuk file yang memiliki perubahan staged sekaligus unstaged, pastikan setiap temuan menggunakan nomor baris dari versi yang benar.
- Untuk file untracked, gunakan nomor baris dari isi file tersebut.
- Untuk kode yang dihapus, gunakan nomor baris lama berdasarkan diff dan nyatakan bahwa baris tersebut telah dihapus.

Jangan memberikan nomor baris perkiraan.

Jangan memberikan nomor baris berdasarkan versi kode yang berbeda dari implementasi yang sedang diperiksa.

Jika nomor baris tidak dapat dipastikan, jelaskan keterbatasannya. Jangan mengarang nomor baris.

### 10.3. Setiap lokasi masalah wajib ditampilkan

Setiap temuan minimal memiliki:

- Path file.
- Nomor baris.
- Status perubahan: staged, unstaged, atau untracked.
- Penjelasan bagian kode yang bermasalah.

Jika ada beberapa lokasi yang berkaitan dengan satu masalah, cantumkan semua path dan nomor barisnya.

**Tidak boleh ada temuan masalah tanpa lokasi kode yang jelas.**

Ketentuan ini juga berlaku untuk rekomendasi yang menunjuk bagian kode tertentu.

### 10.4. Pisahkan lokasi kode proyek dan source SDK

Jika masalah berkaitan dengan penggunaan API SDK, cantumkan:

**Lokasi kode proyek:**

`lib/fitur/contoh.dart:42`

**Lokasi source SDK:**

`<FLUTTER_SDK>/packages/flutter/lib/src/widgets/framework.dart:nomor_baris`

Jangan mencampurkan lokasi kode proyek dengan lokasi source SDK.

## 11. Saran Perbaikan Wajib Disertakan

Jika menemukan ketidaksesuaian, berikan saran perbaikan yang spesifik.

Jangan hanya menulis:

- Kode ini kurang baik.
- Kode ini perlu diperbaiki.
- Sebaiknya gunakan cara lain.
- Implementasi tidak sesuai standar.

Jelaskan secara konkret:

1. Apa masalahnya?
2. Mengapa dianggap bermasalah?
3. Aturan mana yang tidak dipenuhi?
4. Apa dampaknya jika dibiarkan?
5. Bagaimana cara memperbaikinya?
6. Mengapa pendekatan yang disarankan lebih tepat?

Jika diperlukan, berikan contoh kode perbaikan.

Contoh:

**Lokasi:** `lib/fitur/pengguna/provider.dart:42`

**Kode saat ini:**

```dart
final user = state.value!;
```

**Saran perbaikan:**

```dart
final user = state.value;

if (user == null) {
  return;
}
```

Pastikan contoh perbaikan sesuai dengan:

- Konteks kode sebenarnya.
- Aturan proyek.
- Kontrak SDK.
- Tipe data yang digunakan.
- Alur business logic.

Jangan membuat contoh yang hanya terlihat benar tetapi tidak bisa diterapkan pada implementasi proyek.

**Contoh kode perbaikan hanya untuk ditampilkan kepada pengguna. Jangan menerapkannya ke file proyek.**

## 12. Jika Tidak Menemukan Masalah

Jika perubahan sudah sesuai:

- Jangan mengada-ada masalah.
- Jangan mencari kesalahan hanya untuk membuat laporan terlihat panjang.
- Jangan menyarankan perubahan yang tidak memberikan manfaat nyata.
- Jelaskan bahwa perubahan sudah diperiksa dan tidak ditemukan ketidaksesuaian berdasarkan pemeriksaan yang dilakukan.

Jika ada bagian yang tidak dapat diverifikasi karena source SDK tidak tersedia, nyatakan secara jujur.

Jangan menyatakan seluruh kode sudah benar apabila masih ada bagian penting yang belum diperiksa.

## 13. Format Laporan Akhir

Susun laporan menggunakan struktur berikut.

# LAPORAN AUDIT PERUBAHAN KODE DART

## A. Ringkasan

| Keterangan                | Hasil  |
| ------------------------- | ------ |
| Total file Dart diperiksa | Jumlah |
| File staged               | Jumlah |
| File unstaged             | Jumlah |
| File untracked            | Jumlah |
| Pelanggaran aturan        | Jumlah |
| Ketidaksesuaian SDK       | Jumlah |
| Potensi bug               | Jumlah |
| Rekomendasi               | Jumlah |

## B. Daftar File yang Diperiksa

| No. | Path File           | Status    | Hasil             |
| --- | ------------------- | --------- | ----------------- |
| 1   | `lib/.../file.dart` | Staged    | Hasil pemeriksaan |
| 2   | `lib/.../file.dart` | Unstaged  | Hasil pemeriksaan |
| 3   | `lib/.../file.dart` | Untracked | Hasil pemeriksaan |

Pastikan seluruh file Dart yang menjadi target pemeriksaan tercantum.

## C. Temuan Pelanggaran Aturan

Untuk setiap temuan, gunakan format:

### [Prioritas] Judul Temuan

**Lokasi:** `lib/path/file.dart:42`

**Status:** Staged / Unstaged / Untracked

**Kode saat ini:**

```dart
// Kode yang ditemukan.
```

**Aturan yang dilanggar:**

Sebutkan nama file aturan, judul bagian, dan ketentuan yang relevan.

**Alasan:**

Jelaskan secara konkret mengapa kode tidak sesuai.

**Dampak:**

Jelaskan risiko atau akibatnya.

**Saran perbaikan:**

Berikan pendekatan perbaikan yang spesifik.

## D. Temuan Ketidaksesuaian SDK

Untuk setiap temuan:

### [Prioritas] Judul Temuan

**Lokasi kode proyek:** `lib/path/file.dart:42`

**Status:** Staged / Unstaged / Untracked

**API yang diperiksa:**

Nama API Flutter, Dart, atau paket.

**Lokasi source SDK:**

`<path-source-sdk>:nomor_baris`

**Kontrak API:**

Jelaskan ketentuan penggunaan API berdasarkan source yang dibaca.

**Ketidaksesuaian:**

Jelaskan bagian implementasi yang tidak sesuai.

**Dampak:**

Jelaskan risiko yang mungkin terjadi.

**Saran perbaikan:**

Berikan pendekatan yang sesuai dengan API dan versi SDK proyek.

## E. Potensi Bug

Untuk setiap potensi bug, cantumkan:

- Judul masalah dan prioritas.
- Path dan nomor baris yang bermasalah.
- Status perubahan.
- Penjelasan kondisi yang menyebabkan masalah.
- Dampak yang mungkin terjadi.
- Saran perbaikan.

## F. Rekomendasi

Pisahkan rekomendasi yang sifatnya peningkatan kualitas tetapi bukan pelanggaran aturan.

Setiap rekomendasi yang menunjuk bagian kode tertentu wajib mempunyai:

- Path file dan nomor baris.
- Alasan rekomendasi.
- Pendekatan yang disarankan.

Jangan memaksa pengguna melakukan perubahan yang tidak wajib.

## G. Bagian yang Belum Dapat Diverifikasi

Cantumkan apabila terdapat:

- Source SDK yang tidak tersedia.
- Source paket yang tidak ditemukan.
- Kontrak API yang belum dapat dipastikan.
- Konteks kode yang belum cukup.
- Nomor baris yang tidak dapat dipastikan.
- Pemeriksaan yang tidak dapat diselesaikan.

Jelaskan alasan dan dampaknya terhadap kesimpulan audit.

## H. Kesimpulan

Gunakan salah satu status berikut:

- **Tidak ditemukan masalah:** tidak ada ketidaksesuaian yang ditemukan dari pemeriksaan yang berhasil dilakukan.
- **Ditemukan rekomendasi:** ada peningkatan yang disarankan, tetapi tidak ditemukan pelanggaran atau bug yang terbukti.
- **Perlu perhatian:** ditemukan potensi bug atau ketidaksesuaian yang perlu dipertimbangkan sebelum commit.
- **Belum dapat diverifikasi sepenuhnya:** terdapat keterbatasan pemeriksaan yang memengaruhi kesimpulan.

Jangan menyuruh pengguna langsung melakukan commit.

Jangan memperbaiki kode.

Akhiri dengan menegaskan bahwa seluruh temuan dan saran merupakan bahan pertimbangan pengguna.

## 14. Pemeriksaan Akhir Sebelum Menyampaikan Laporan

Sebelum menyelesaikan audit, pastikan:

- [ ] `AGENTS.md` sudah dibaca seluruhnya.
- [ ] Semua aturan yang relevan sudah dibaca.
- [ ] Seluruh perubahan Dart staged sudah diperiksa.
- [ ] Seluruh perubahan Dart unstaged sudah diperiksa.
- [ ] Seluruh file Dart untracked sudah diperiksa.
- [ ] Perubahan pada file yang sama sudah dibedakan berdasarkan statusnya.
- [ ] Seluruh perubahan kode sudah dievaluasi terhadap aturan proyek.
- [ ] Source SDK yang relevan sudah diperiksa.
- [ ] Dampak perubahan terhadap kode terkait sudah dievaluasi.
- [ ] Setiap temuan memiliki bukti yang jelas.
- [ ] Setiap temuan memiliki path dan nomor baris yang tepat.
- [ ] Tidak ada link Markdown atau URL dalam laporan lokasi masalah.
- [ ] Setiap ketidaksesuaian memiliki saran perbaikan.
- [ ] Rekomendasi sudah dipisahkan dari pelanggaran.
- [ ] Keterbatasan pemeriksaan sudah dilaporkan.
- [ ] Tidak ada file yang diubah.
- [ ] Tidak ada staging area atau kondisi Git yang diubah.

Jika ada bagian yang belum selesai, jangan menyatakan audit sudah selesai sepenuhnya.

---

# PRINSIP UTAMA

**AUDIT, BUKAN IMPLEMENTASI.**

Anda bertugas menjadi pemeriksa independen sebelum perubahan kode di-commit.

Baca perubahan secara menyeluruh, cocokkan dengan `AGENTS.md`, dan periksa source SDK yang sebenarnya.

Setiap masalah harus mempunyai bukti, path file, nomor baris, penjelasan, serta saran perbaikan yang konkret.

Jangan mengubah kode meskipun menemukan kesalahan yang jelas.

Jangan mengambil keputusan perbaikan atas nama pengguna.

**Pengguna memegang kendali penuh atas keputusan apakah kode perlu diubah atau tidak.**
