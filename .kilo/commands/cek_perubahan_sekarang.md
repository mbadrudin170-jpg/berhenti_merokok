---
description: Audit seluruh perubahan kode Dart yang belum di-commit terhadap AGENTS.md dan source Flutter/Dart SDK. Hanya laporkan temuan dan saran perbaikan tanpa mengubah apa pun.
agent: ask
---

# AUDIT PERUBAHAN DART SEBELUM COMMIT

## 1. Tujuan Utama

Lakukan pemeriksaan terhadap seluruh perubahan kode Dart yang belum di-commit untuk memastikan implementasinya sesuai dengan:

1. `AGENTS.md`.
2. Aturan tambahan yang berlaku pada proyek.
3. Standar penulisan kode yang sudah ditetapkan.
4. Dokumentasi dan source code Flutter SDK.
5. Dokumentasi dan source code Dart SDK.
6. Source code paket eksternal yang digunakan apabila perubahan berkaitan dengan API paket tersebut.
7. Prinsip kualitas kode, keamanan runtime, performa, dan maintainability.

Tujuan pemeriksaan adalah menemukan ketidaksesuaian sebelum pengguna melakukan commit.

**Tugas Anda hanya menganalisis dan memberikan laporan. Pengguna yang akan memutuskan apakah temuan tersebut perlu diperbaiki atau tidak.**

Jangan melakukan perubahan kode dalam kondisi apa pun.

## 2. Larangan Utama

Ketentuan berikut wajib dipatuhi.

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
- Menjalankan perintah yang dapat mengubah file proyek.

**Jangan menerapkan saran perbaikan secara otomatis, meskipun Anda yakin bahwa perbaikan tersebut benar.**

### 2.2. Jangan mengubah kondisi Git

Dilarang menjalankan operasi yang mengubah working tree, staging area, branch, atau riwayat commit.

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

Larangan ini juga berlaku untuk operasi Git lain yang mempunyai efek serupa.

Anda hanya boleh menggunakan perintah Git yang bersifat read-only untuk melihat dan membandingkan perubahan.

Jangan mengubah staging area, baik secara langsung maupun tidak langsung.

### 2.3. Jangan menjalankan pemeriksaan yang dapat menghasilkan perubahan file

Hindari menjalankan:

- `dart format`
- `flutter format`
- `flutter pub get`
- `flutter pub add`
- Code generator.
- Perintah migrasi database.
- Test yang berpotensi menulis data atau file.
- Perintah lain yang berpotensi mengubah proyek.

Audit dilakukan melalui pembacaan kode, perbandingan perubahan, dan pemeriksaan source SDK.

Jika suatu pemeriksaan membutuhkan eksekusi yang berpotensi mengubah file, jangan jalankan. Jelaskan keterbatasannya dalam laporan.

## 3. Baca AGENTS.md dan Aturan Proyek

Sebelum menganalisis kode, baca terlebih dahulu seluruh isi:

`AGENTS.md`

Jangan hanya membaca sebagian atau mengandalkan konteks yang sudah tersedia sebelumnya.

Tujuannya agar Anda memahami seluruh standar dan ketentuan yang berlaku sebelum memberikan penilaian.

Perhatikan ketentuan berikut:

1. Baca seluruh aturan dalam `AGENTS.md`.
2. Jika `AGENTS.md` merujuk ke file aturan lain, baca file aturan tersebut.
3. Periksa `AGENTS.md` tambahan pada direktori yang menjadi lokasi file Dart yang berubah.
4. Pahami aturan global dan aturan khusus proyek.
5. Jangan mengabaikan aturan hanya karena implementasi saat ini sudah berjalan.
6. Jangan membuat standar sendiri yang bertentangan dengan aturan proyek.

Ketika menemukan ketidaksesuaian, sertakan sumber aturan yang dilanggar.

Cantumkan:

- Nama file aturan.
- Judul atau bagian aturan.
- Penjelasan mengenai ketidaksesuaian.

Jika ada dua aturan yang bertentangan dan prioritasnya tidak dapat dipastikan, laporkan konflik tersebut. Jangan menebak keputusan yang harus diambil.

## 4. Identifikasi Perubahan Git yang Belum Di-commit

Audit hanya mencakup file dengan ekstensi `.dart`.

Perubahan yang diperiksa harus dibagi menjadi tiga kelompok.

### 4.1. Staged Changes

Perubahan yang sudah masuk staging area tetapi belum di-commit.

Gunakan:

```bash
git diff --cached --name-status --find-renames -- '*.dart'
```

Baca seluruh detail perubahan:

```bash
git diff --cached --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Perhatikan:

- File Dart yang ditambahkan.
- File Dart yang diubah.
- File Dart yang dihapus.
- File Dart yang dipindahkan atau di-rename.

### 4.2. Unstaged Changes

Perubahan pada working tree yang belum masuk staging area.

Gunakan:

```bash
git diff --name-status --find-renames -- '*.dart'
```

Baca seluruh detail perubahan:

```bash
git diff --no-ext-diff --find-renames --unified=80 -- '*.dart'
```

Perhatikan seluruh perubahan, termasuk perubahan tambahan pada file yang sebelumnya sudah masuk staging.

### 4.3. Untracked Dart Files

Identifikasi file Dart baru yang belum dilacak Git menggunakan:

```bash
git ls-files --others --exclude-standard -- '*.dart'
```

Karena file untracked belum mempunyai riwayat pembanding, baca seluruh isi file tersebut.

Jangan mengabaikan file Dart baru hanya karena belum masuk staging.

### 4.4. Periksa status perubahan

Gunakan perintah berikut jika diperlukan untuk memahami status perubahan:

```bash
git status --short --untracked-files=all
```

Perintah ini hanya digunakan untuk membaca kondisi repository.

Jangan melakukan operasi lanjutan yang mengubah status tersebut.

### 4.5. Ketentuan pembacaan perubahan

1. Periksa staged dan unstaged secara terpisah.
2. Jangan mencampurkan kedua jenis perubahan menjadi satu kesimpulan.
3. Jika satu file memiliki perubahan staged sekaligus unstaged, periksa keduanya.
4. Baca isi file Dart secara lengkap apabila diperlukan untuk memahami konteks perubahan.
5. Untuk file yang dihapus, periksa kode yang dihapus melalui diff.
6. Untuk file yang di-rename, periksa bagian yang berubah dan lokasi barunya.
7. Jangan hanya membaca ringkasan nama file.
8. Jangan hanya membaca sebagian hunks perubahan.
9. Jangan melewatkan perubahan yang terlihat sederhana.

Jika perlu mengetahui versi file yang tersimpan di staging, gunakan mekanisme pembacaan Git yang tidak mengubah index, misalnya `git show :path/file.dart`.

**Jangan menggunakan working tree sebagai pengganti isi staging karena keduanya dapat memiliki isi yang berbeda.**

## 5. Batasan File yang Diperiksa

Fokus pemeriksaan hanya pada kode Dart.

File yang menjadi target pemeriksaan:

- `*.dart`
- File Dart baru yang belum dilacak.
- File Dart yang sudah staged.
- File Dart yang belum staged.

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

Namun, Anda diperbolehkan membaca file konfigurasi yang diperlukan untuk memahami versi SDK atau menemukan lokasi source code dependensi.

Pembacaan file pendukung tersebut bukan berarti Anda harus melakukan audit terhadap isi perubahannya.

### File generated

Jangan langsung mengabaikan file Dart hasil generator.

Jika file generated mengalami perubahan:

1. Identifikasi apakah file tersebut memang merupakan hasil generator.
2. Periksa apakah perubahan kode terkait seharusnya dilakukan pada file sumber generator.
3. Periksa aturan proyek mengenai generated files.
4. Laporkan apabila ada pelanggaran terhadap aturan tersebut.

Jangan mengubah atau menjalankan generator.

## 6. Evaluasi Kesesuaian dengan AGENTS.md

Setelah memperoleh seluruh perubahan Dart, evaluasi setiap perubahan terhadap aturan yang berlaku.

Periksa seluruh aspek berikut.

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

Jangan menambahkan penilaian berdasarkan selera pribadi jika tidak memiliki dasar yang jelas.

**Prioritaskan pelanggaran aturan yang benar-benar tertulis dalam AGENTS.md dan aturan tambahan proyek.**

Jika ada saran yang tidak secara langsung melanggar aturan, tandai sebagai rekomendasi, bukan pelanggaran.

## 7. Wajib Membaca Source Code Flutter dan Dart SDK

Ini merupakan bagian penting dari audit.

Jangan hanya mengandalkan pengetahuan internal AI, dokumentasi yang pernah dibaca, atau contoh kode dari internet.

**Periksa source code SDK yang benar-benar digunakan oleh proyek.**

Tujuannya adalah memastikan implementasi menggunakan API sesuai kontrak SDK yang berlaku.

### 7.1. Identifikasi SDK yang digunakan

Cari lokasi Flutter SDK melalui executable Flutter yang tersedia di lingkungan proyek.

Contoh:

```bash
command -v flutter
```

Jika perlu, periksa lokasi executable sebenarnya:

```bash
readlink -f "$(command -v flutter)"
```

Identifikasi versi Flutter dan Dart yang digunakan tanpa menjalankan proses pembaruan SDK atau dependensi.

Jangan mengganti SDK atau mengunduh versi baru.

### 7.2. Lokasi source code Flutter SDK

Periksa source code Flutter pada:

```text
<FLUTTER_SDK>/packages/flutter/lib/
```

Untuk implementasi internal framework Flutter, periksa:

```text
<FLUTTER_SDK>/packages/flutter/lib/src/
```

### 7.3. Lokasi source code Dart SDK

Periksa source code Dart pada:

```text
<FLUTTER_SDK>/bin/cache/dart-sdk/lib/
```

Sesuaikan subdirektori berdasarkan API yang digunakan.

Contohnya:

- `dart:async`
- `dart:collection`
- `dart:core`
- `dart:convert`
- `dart:io`
- `dart:isolate`

Jangan membaca direktori secara membabi buta. Cari file source yang benar-benar berkaitan dengan perubahan kode.

### 7.4. Source code paket eksternal

Jika perubahan menggunakan API dari paket eksternal, periksa source code paket yang benar-benar digunakan proyek.

Gunakan informasi resolusi dependensi pada:

```text
.dart_tool/package_config.json
```

Temukan lokasi package root berdasarkan konfigurasi tersebut.

Baca deklarasi API dan implementasinya pada source paket yang sudah tersedia.

Jangan menjalankan `flutter pub get` untuk mendapatkan source paket.

Jika source paket belum tersedia, catat keterbatasannya dan jangan mengklaim sudah memeriksanya.

### 7.5. Hal yang wajib diperiksa dari source SDK

Untuk setiap API yang digunakan dalam perubahan kode, periksa hal-hal berikut apabila relevan:

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

Jangan menyimpulkan suatu penggunaan API benar hanya karena kode dapat ditulis atau terlihat benar.

Periksa kontrak dan implementasi API secara langsung pada source code SDK.

### 7.6. Hubungkan hasil pemeriksaan SDK dengan kode yang berubah

Untuk setiap temuan yang berkaitan dengan SDK:

- Sebutkan API yang digunakan.
- Sebutkan file source SDK yang dibaca.
- Jelaskan kontrak API yang relevan.
- Jelaskan bagian kode yang tidak sesuai.
- Jelaskan risiko akibat ketidaksesuaian.
- Berikan saran implementasi yang sesuai dengan SDK.

Gunakan source SDK yang sesuai dengan versi proyek, bukan source dari versi Flutter atau Dart terbaru yang belum tentu digunakan proyek.

Jika source SDK tidak ditemukan atau versi tidak dapat dipastikan, jangan membuat kesimpulan yang tidak didukung bukti.

Laporkan bahwa bagian tersebut belum dapat diverifikasi.

## 8. Periksa Dampak Perubahan terhadap Kode Sekitarnya

Jangan hanya menilai baris yang berubah secara terpisah.

Jika perubahan dapat memengaruhi kode lain, baca kode Dart yang terkait.

Contohnya:

- Perubahan provider yang digunakan beberapa widget.
- Perubahan Notifier yang memengaruhi aliran state.
- Perubahan model yang digunakan beberapa repository.
- Perubahan function yang dipanggil dari beberapa tempat.
- Perubahan parameter yang memengaruhi seluruh pemanggil.
- Perubahan pengelolaan cache yang memengaruhi tampilan data.
- Perubahan database yang memengaruhi proses transaksi.
- Perubahan lifecycle widget yang memengaruhi resource lain.

Tujuannya agar tidak terjadi penilaian yang hanya benar secara lokal tetapi salah secara keseluruhan.

Namun, jangan memperluas audit menjadi pemeriksaan seluruh proyek.

Tetap fokus pada dampak langsung dari perubahan Dart yang belum di-commit.

## 9. Ketentuan Menemukan dan Melaporkan Masalah

Setiap temuan harus memiliki bukti yang jelas.

Jangan melaporkan dugaan sebagai kesalahan yang sudah pasti.

Pisahkan hasil evaluasi menjadi empat kategori.

### A. Pelanggaran Aturan

Perubahan yang tidak sesuai dengan ketentuan tertulis dalam `AGENTS.md` atau aturan proyek.

### B. Ketidaksesuaian SDK

Penggunaan API yang tidak sesuai dengan kontrak source code Flutter, Dart, atau paket yang digunakan.

### C. Potensi Bug

Perubahan yang berpotensi menyebabkan kesalahan runtime, kerusakan data, hasil yang tidak sesuai, atau masalah performa.

### D. Rekomendasi Perbaikan

Perubahan yang tidak selalu salah, tetapi mempunyai pendekatan yang lebih baik berdasarkan standar proyek atau source SDK.

Jangan menyamakan rekomendasi dengan pelanggaran.

### Tingkat Prioritas

Gunakan kategori berikut:

- **Critical:** berpotensi menyebabkan kerusakan data serius, keamanan, atau kegagalan aplikasi yang sangat parah.
- **High:** berpotensi menyebabkan aplikasi crash, data tidak konsisten, atau fitur utama gagal.
- **Medium:** masalah implementasi yang dapat menimbulkan bug atau mengurangi kualitas secara signifikan.
- **Low:** masalah minor seperti konsistensi penulisan atau peningkatan maintainability.
- **Info:** catatan teknis atau rekomendasi yang tidak menunjukkan adanya kesalahan.

Jangan memberikan prioritas secara berlebihan.

## 10. Saran Perbaikan Wajib Disertakan

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

**Saran perbaikan:**

Hindari penggunaan operator `!` karena nilai dapat bernilai null ketika kondisi tertentu terjadi.

Contoh yang berisiko:

```dart
final user = state.value!;
```

Contoh pendekatan yang lebih aman:

```dart
final user = state.value;

if (user == null) {
  return;
}
```

Pastikan contoh perbaikan sesuai dengan konteks kode sebenarnya.

Jangan membuat contoh yang hanya terlihat benar tetapi tidak bisa diterapkan pada implementasi proyek.

**Ingat: contoh tersebut hanya untuk disampaikan kepada pengguna. Jangan menerapkannya ke file proyek.**

## 11. Ketentuan Jika Tidak Menemukan Masalah

Jika suatu perubahan sudah sesuai:

- Jangan mengada-ada masalah.
- Jangan mencari kesalahan hanya untuk membuat laporan terlihat panjang.
- Jangan menyarankan perubahan yang tidak memberikan manfaat nyata.
- Jelaskan bahwa perubahan tersebut telah diperiksa dan tidak ditemukan ketidaksesuaian berdasarkan pemeriksaan yang dilakukan.

Jika ada bagian yang tidak dapat diverifikasi karena source SDK tidak tersedia, nyatakan secara jujur.

Jangan menyatakan seluruh kode sudah benar apabila masih ada bagian penting yang belum diperiksa.

## 12. Format Laporan Akhir

Susun laporan dengan struktur berikut.

# Laporan Audit Perubahan Dart

## A. Ringkasan

| Keterangan              | Hasil  |
| ----------------------- | ------ |
| Total file Dart berubah | Jumlah |
| File staged             | Jumlah |
| File unstaged           | Jumlah |
| File untracked          | Jumlah |
| Pelanggaran aturan      | Jumlah |
| Ketidaksesuaian SDK     | Jumlah |
| Potensi bug             | Jumlah |
| Rekomendasi             | Jumlah |

## B. Daftar File yang Diperiksa

| No. | Path File           | Status    | Hasil             |
| --- | ------------------- | --------- | ----------------- |
| 1   | `lib/.../file.dart` | Staged    | Hasil pemeriksaan |
| 2   | `lib/.../file.dart` | Unstaged  | Hasil pemeriksaan |
| 3   | `lib/.../file.dart` | Untracked | Hasil pemeriksaan |

## C. Temuan Pelanggaran Aturan

Untuk setiap temuan, gunakan format:

### [Prioritas] Judul Temuan

**File:**

`lib/path/file.dart`

**Status:**

Staged / Unstaged / Untracked

**Lokasi kode:**

Nomor baris atau bagian kode yang bermasalah.

**Kode saat ini:**

```dart
// Kode yang ditemukan.
```

**Aturan yang dilanggar:**

`AGENTS.md` atau `path/file_aturan.md`

Sebutkan bagian aturan yang relevan.

**Alasan:**

Jelaskan secara konkret mengapa kode tidak sesuai.

**Dampak:**

Jelaskan risiko atau akibatnya.

**Saran perbaikan:**

Berikan pendekatan perbaikan yang spesifik.

## D. Temuan Ketidaksesuaian SDK

Untuk setiap temuan:

### [Prioritas] Judul Temuan

**File proyek:**

`lib/path/file.dart`

**API yang diperiksa:**

Nama API Flutter, Dart, atau paket.

**Source code SDK:**

`<path-source-sdk>`

**Kontrak API:**

Jelaskan ketentuan penggunaan API berdasarkan source yang dibaca.

**Ketidaksesuaian:**

Jelaskan bagian implementasi yang tidak sesuai.

**Saran perbaikan:**

Berikan pendekatan yang sesuai dengan API dan versi SDK proyek.

## E. Potensi Bug

Cantumkan masalah logika, runtime, data, lifecycle, atau performa yang ditemukan, disertai bukti dan saran perbaikan.

## F. Rekomendasi

Pisahkan rekomendasi yang sifatnya peningkatan kualitas tetapi bukan pelanggaran aturan.

Jangan memaksa pengguna melakukan perubahan yang tidak wajib.

## G. Bagian yang Belum Dapat Diverifikasi

Cantumkan apabila terdapat:

- Source SDK yang tidak tersedia.
- Source paket yang tidak ditemukan.
- Kontrak API yang belum dapat dipastikan.
- Konteks kode yang belum cukup.
- Pemeriksaan yang tidak dapat diselesaikan.

Jelaskan alasan dan dampaknya terhadap kesimpulan audit.

## H. Kesimpulan

Berikan kesimpulan mengenai kondisi perubahan Dart yang diperiksa.

Gunakan salah satu status berikut:

- **Tidak ditemukan masalah:** tidak ada ketidaksesuaian yang ditemukan dari pemeriksaan yang berhasil dilakukan.
- **Ditemukan rekomendasi:** ada peningkatan yang disarankan, tetapi tidak ditemukan pelanggaran atau bug yang terbukti.
- **Perlu perhatian:** ditemukan potensi bug atau ketidaksesuaian yang harus dipertimbangkan sebelum commit.
- **Belum dapat diverifikasi sepenuhnya:** terdapat keterbatasan pemeriksaan yang memengaruhi kesimpulan.

Jangan menyuruh pengguna langsung commit.

Jangan memperbaiki kode.

Akhiri dengan menegaskan bahwa semua temuan dan saran merupakan bahan pertimbangan pengguna.

---

# Prinsip Utama

**Audit, bukan implementasi.**

Anda bertugas menjadi pemeriksa independen sebelum perubahan kode di-commit.

Baca perubahan secara menyeluruh, cocokkan dengan aturan proyek, dan periksa source SDK yang sebenarnya.

Jika menemukan masalah, tunjukkan bukti dan berikan solusi yang jelas.

Jangan mengambil keputusan perbaikan atas nama pengguna.

**Pengguna memegang kendali penuh atas keputusan apakah kode perlu diubah atau tidak.**
