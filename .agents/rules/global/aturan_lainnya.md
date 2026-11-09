# ATURAN UMUM PENGEMBANGAN FLUTTER DAN DART

**Path:** `prompt/aturan/aturan_lainnya.md`

## 1. Prioritas dan kepatuhan aturan

1. Seluruh aturan dalam file ini wajib dipatuhi selama mengerjakan proyek.
2. Jangan mengabaikan, melewati, atau mengubah ketentuan tanpa alasan yang dapat dipertanggungjawabkan.
3. Jika terdapat konflik dengan aturan lain di proyek, jangan menentukan sendiri aturan mana yang harus diikuti. Identifikasi konflik, jelaskan dampaknya, dan tanyakan kepada pengguna menggunakan tool `question`.
4. Jangan membuat asumsi mengenai struktur proyek, implementasi, dependency, versi SDK, atau perilaku aplikasi tanpa memeriksa kondisi aktual.
5. Jika suatu aturan tidak dapat dilaksanakan karena keterbatasan lingkungan atau tool, jelaskan alasannya dan jangan mengklaim bahwa aturan tersebut sudah dipenuhi.

## 2. Referensi desain

1. Sebelum membuat atau mengubah tampilan Flutter, wajib membaca `optimasi_ui.md`.
2. Jadikan file tersebut sebagai referensi utama untuk menentukan:
   - Ukuran komponen.
   - Spacing, padding, dan margin.
   - Tipografi dan ukuran font.
   - Layout dan struktur tampilan.
   - Konsistensi desain.
   - Penggunaan warna dan tema.
3. Jangan membuat standar desain sendiri apabila ketentuannya sudah tersedia dalam `optimasi_ui.md`.
4. Jika nilai desain yang dibutuhkan belum tersedia, gunakan nilai yang paling konsisten dengan sistem desain proyek. Jangan membuat konstanta desain sembarangan di dalam widget.
5. Jika diperlukan nilai desain baru, tempatkan pada file referensi desain yang sesuai.

## 3. Pembacaan SDK dan dependency

### 3.1. Prinsip utama

Sebelum mengimplementasikan API Flutter, Dart, atau paket pihak ketiga, wajib memeriksa implementasi dan dokumentasi yang sesuai dengan versi yang benar-benar digunakan proyek.

Jangan hanya mengandalkan pengetahuan hasil pelatihan AI karena API dapat berubah, deprecated, atau memiliki parameter dan konstruktor baru.

### 3.2. Sumber referensi

Gunakan sumber berikut sesuai kebutuhan:

**A. Flutter SDK**

Periksa Flutter SDK yang benar-benar digunakan proyek.

Lokasi yang perlu diperiksa:

- `$FLUTTER_ROOT/packages/flutter/lib/src/` untuk implementasi framework Flutter.
- `$FLUTTER_ROOT/packages/flutter/lib/` untuk API publik Flutter.
- `$FLUTTER_ROOT/bin/cache/dart-sdk/lib/` untuk implementasi pustaka Dart.
- `$FLUTTER_ROOT/bin/cache/` untuk informasi dan artefak SDK yang relevan.

Jangan menganggap seluruh sumber implementasi Flutter dan Dart berada di `bin/cache`.

**B. Paket pihak ketiga**

Lokasi cache paket:

`$HOME/.pub-cache/hosted/pub.dev/`

Gunakan `pubspec.lock` untuk mengetahui versi paket yang benar-benar digunakan.

Setelah mengetahui nama dan versi paket, periksa direktori paket yang sesuai.

Periksa bagian berikut jika relevan:

- `lib/` untuk implementasi dan API paket.
- `example/` untuk contoh implementasi resmi.
- `README.md` untuk panduan penggunaan.
- `CHANGELOG.md` untuk perubahan versi dan API.
- Dokumentasi tambahan yang disediakan paket.

**C. Dokumentasi resmi**

Jika diperlukan, cari dokumentasi resmi Flutter, Dart, atau pengembang paket.

Pastikan dokumentasi sesuai dengan versi dependency yang digunakan proyek. Jangan menggunakan contoh dari versi berbeda tanpa memverifikasi kompatibilitasnya.

### 3.3. Urutan pemeriksaan referensi

Sebelum implementasi, gunakan urutan berikut:

1. Baca kode proyek yang berkaitan dengan pekerjaan.
2. Periksa `pubspec.yaml` dan `pubspec.lock`.
3. Identifikasi dependency serta versi yang digunakan.
4. Tentukan apakah API yang dibutuhkan berasal dari Flutter SDK, Dart SDK, atau paket pihak ketiga.
5. Periksa implementasi API pada sumber yang sesuai.
6. Periksa folder `example` dari paket yang digunakan.
7. Periksa dokumentasi resmi dan catatan perubahan versi jika diperlukan.
8. Implementasikan berdasarkan hasil pemeriksaan.

Jika informasi dari sumber berbeda, utamakan implementasi aktual dan dokumentasi yang sesuai dengan versi proyek. Jangan menggabungkan contoh dari versi API yang berbeda.

## 4. Pemeriksaan kode proyek

1. Wajib membaca kode yang sudah ada sebelum menganalisis atau mengubah implementasi.
2. Jangan memberikan solusi berdasarkan asumsi atau hanya berdasarkan potongan kode yang belum dipahami konteksnya.
3. Periksa file yang berhubungan dengan pekerjaan, termasuk:
   - File pemanggil.
   - File yang menyediakan dependency.
   - Provider dan state management.
   - Model dan repository.
   - Service dan helper.
   - Database dan konfigurasi.
   - File pengujian.
4. Jangan menganggap sumber masalah selalu berada pada file yang sedang dikerjakan.
5. Untuk pemeriksaan awal, usahakan membaca minimal 10 file yang relevan jika tersedia.
6. Jangan membaca file secara acak hanya untuk memenuhi jumlah minimal. Jika file relevan kurang dari 10, baca seluruh file relevan yang tersedia.
7. Jika ditemukan kemungkinan masalah pada file lain, periksa file tersebut sebelum menentukan solusi.
8. Periksa implementasi serupa di file lain untuk menjaga konsistensi pola kode proyek.
9. Jangan mengandalkan cache konteks AI sebagai pengganti pembacaan file aktual. Cache dapat tidak lengkap atau sudah tidak sesuai dengan kondisi proyek.

## 5. Skills

1. Sebelum mengerjakan kode, periksa skills yang tersedia pada proyek dan lingkungan Kilo Code.
2. Baca atau load skills yang relevan sebelum melakukan implementasi.
3. Gunakan pengetahuan, prosedur, dan standar implementasi yang disediakan oleh skills.
4. Jangan mengabaikan skills yang relevan hanya karena AI sudah memiliki pengetahuan mengenai topik tersebut.
5. Jangan menduplikasi instruksi skills jika tidak diperlukan.

## 6. Instalasi dan penghapusan dependency

1. Dilarang mengubah dependency dengan menulis atau mengedit secara manual bagian `dependencies` maupun `dev_dependencies` di `pubspec.yaml`.
2. Untuk menambahkan paket, wajib menggunakan:

   `flutter pub add nama_paket`

3. Untuk menghapus paket, wajib menggunakan:

   `flutter pub remove nama_paket`

4. Setelah perubahan dependency, periksa hasil perubahan pada `pubspec.yaml` dan `pubspec.lock`.
5. Pastikan versi paket yang terpasang sesuai dengan kebutuhan dan kompatibilitas proyek.
6. Jangan memasang paket baru jika fitur yang dibutuhkan sudah tersedia melalui Flutter SDK, Dart SDK, atau dependency yang sudah digunakan proyek, kecuali terdapat alasan teknis yang jelas.

## 7. Prosedur pengeditan kode

1. Fokus hanya pada kode dan file yang berkaitan dengan topik pekerjaan.
2. Dilarang melakukan refactoring luas yang tidak berkaitan dengan permintaan.
3. Utamakan perubahan sekecil mungkin dengan mempertahankan struktur dan implementasi yang sudah benar.
4. Untuk mengubah kode, utamakan tool `edit` atau `apply_patch` yang hanya mengubah bagian tertentu.
5. Jangan menggunakan tool terminal atau perintah shell untuk mengedit kode.
6. Tool `write` hanya digunakan apabila:
   - Membuat file baru.
   - Mengisi file yang memang harus dibuat ulang.
   - Penulisan ulang seluruh file benar-benar diperlukan dan sudah memiliki alasan yang jelas.
7. Jangan menulis ulang seluruh isi file jika perubahan sebagian sudah mencukupi.
8. Jangan mengubah file di luar ruang lingkup pekerjaan tanpa persetujuan pengguna.
9. Jangan mengedit file hasil generator seperti `.g.dart` dan `.freezed.dart`.
10. Jika file generator perlu diperbarui, ubah sumber aslinya kemudian jalankan generator yang sesuai.
11. Jangan menghapus implementasi yang masih digunakan tanpa memeriksa seluruh pemanggilnya.

## 8. Konsistensi implementasi

1. Kode wajib mengikuti pola, arsitektur, dan konvensi yang sudah diterapkan proyek.
2. Jika belum memahami pola implementasi, cari contoh pada file lain yang memiliki fungsi serupa.
3. Jangan memperkenalkan pola baru apabila pola yang tersedia masih sesuai.
4. Gunakan helper, utility, service, dan komponen bersama yang sudah tersedia.
5. Hindari duplikasi kode yang sebenarnya dapat menggunakan implementasi bersama.
6. Jangan membuat abstraksi baru yang tidak memberikan manfaat nyata.

## 9. Aturan pencarian file dan kode

Gunakan tool pencarian sesuai kebutuhan:

- `rg`: mencari teks, nama simbol, fungsi, class, atau pola kode.
- `glob`: mencari file berdasarkan nama atau pola direktori.
- `ls`: melihat isi suatu folder.
- `grep -rn`: hanya digunakan apabila `rg` gagal digunakan.

Jika `rg` dilaporkan belum terpasang:

1. Jalankan `which rg` melalui shell.
2. Periksa apakah executable tersedia.
3. Jika memang tidak tersedia, gunakan alternatif pencarian yang sesuai.

Jangan langsung mengganti `rg` dengan `grep` tanpa memeriksa ketersediaan `rg`.

## 10. Penamaan kode

1. Nama variabel, fungsi, class, method, getter, dan provider wajib menggunakan bahasa Indonesia sesuai konvensi penamaan proyek.
2. Nama file wajib menggunakan `snake_case`.
3. Gunakan nama yang singkat, jelas, dan mudah dipahami hanya dengan melihat namanya.
4. Hindari singkatan yang membingungkan.
5. Jangan menerjemahkan nama API bawaan Flutter, Dart, maupun dependency pihak ketiga.
6. Pertahankan nama yang diwajibkan framework atau generator.

## 11. Dokumentasi dan komentar

1. API publik wajib memiliki dokumentasi menggunakan doc comment `///`.
2. Logika kompleks wajib memiliki dokumentasi singkat apabila tanpa penjelasan dapat menyulitkan pemahaman atau pemeliharaan kode.
3. Dokumentasi kode wajib menggunakan satu baris apabila penjelasan dapat disampaikan secara singkat dan jelas.
4. Gunakan bahasa Indonesia yang baik dan benar.
5. Jangan menambahkan komentar yang hanya mengulang kode.
6. Hapus komentar yang tidak relevan, sudah kedaluwarsa, atau tidak memberikan informasi tambahan.
7. Jangan menghapus dokumentasi API yang masih diperlukan.

## 12. Logging dan debugging

### 12.1. Console

Dilarang menggunakan:

- `print()`
- `debugPrint()`

Gunakan class `P` yang sudah tersedia di proyek untuk mencetak log ke console.

Periksa implementasi class tersebut sebelum menggunakannya.

### 12.2. Log aplikasi

Untuk debugging yang perlu ditampilkan melalui sistem logging aplikasi, gunakan class `L` atau `l.dart` yang sudah tersedia di proyek.

Jangan mencampuradukkan fungsi logging console dan logging aplikasi.

Jangan membuat sistem logging baru jika implementasi yang tersedia sudah mencukupi.

## 13. Pengujian dan pemeriksaan kode

Setiap pekerjaan yang mengubah kode wajib menjalani pemeriksaan berikut.

### 13.1. Formatting

Jalankan `dart format` pada file Dart yang dibuat atau diubah.

Contoh:

`dart format lib/fitur/contoh/contoh.dart`

Jangan memformat seluruh proyek jika pekerjaan hanya mengubah beberapa file dan pemformatan terbatas sudah mencukupi.

### 13.2. Flutter Analyze

Setelah perubahan selesai, wajib menjalankan:

`flutter analyze`

Periksa seluruh hasil analisis.

Jika terdapat error atau warning baru akibat perubahan:

1. Identifikasi sumber masalah.
2. Perbaiki masalah yang berkaitan dengan pekerjaan.
3. Jalankan kembali formatting.
4. Jalankan kembali `flutter analyze`.

Jangan menyatakan pekerjaan selesai apabila pemeriksaan belum dilakukan.

### 13.3. Hasil pemeriksaan

Laporkan secara jelas:

- File yang diubah.
- Perubahan yang dilakukan.
- Hasil `dart format`.
- Hasil `flutter analyze`.
- Pengujian tambahan yang dilakukan.
- Pemeriksaan yang belum dapat dilakukan beserta alasannya.

Jangan mengklaim pengujian berhasil jika perintahnya belum dijalankan.

## 14. Git

1. Operasi Git hanya diperbolehkan untuk membaca informasi.
2. Contoh operasi yang diperbolehkan:
   - `git status`
   - `git diff`
   - `git log`
   - `git show`
   - `git branch --show-current`
3. Dilarang menjalankan operasi Git yang mengubah kondisi repositori tanpa persetujuan pengguna.
4. Operasi yang memerlukan persetujuan meliputi commit, push, pull, merge, rebase, checkout yang mengubah kondisi kerja, reset, stash, dan perubahan branch.
5. Jika operasi Git diperlukan, jelaskan tujuan dan dampaknya kemudian tanyakan persetujuan pengguna menggunakan tool `question`.

## 15. Manajemen aset

1. Aset gambar dan font yang digunakan secara lokal wajib didaftarkan di `pubspec.yaml`.
2. Gunakan path aset yang konsisten dengan struktur proyek.
3. Jangan memuat aset menggunakan path yang tidak jelas atau tidak terdaftar.
4. Sebelum menambahkan aset, periksa apakah aset serupa sudah tersedia.
5. Jangan menduplikasi aset yang sebenarnya dapat digunakan bersama.

## 16. Font

1. Gunakan paket Google Fonts yang sudah tersedia apabila proyek menerapkannya.
2. Aktifkan dan manfaatkan mekanisme cache font agar font tidak dimuat berulang kali dari jaringan.
3. Hindari ketergantungan pada jaringan untuk pemuatan font yang sebenarnya dapat disediakan secara lokal.
4. Jika font dibundel secara lokal, daftarkan melalui konfigurasi `fonts` di `pubspec.yaml`.
5. Jangan menambahkan paket font baru tanpa memeriksa dependency yang sudah tersedia.

## 17. Splash Screen

1. Gunakan `flutter_native_splash` untuk membuat splash screen.
2. Jangan membuat splash screen native secara manual menggunakan widget Flutter.
3. Periksa konfigurasi dan versi paket yang sudah digunakan proyek.
4. Jika konfigurasi splash screen berubah, jalankan generator sesuai dokumentasi paket.
5. Pastikan hasil splash screen sesuai dengan desain proyek.

## 18. Feedback pengguna

1. Gunakan `fluttertoast` untuk feedback singkat kepada pengguna apabila sesuai dengan kebutuhan interaksi.
2. Hindari penggunaan toast secara berulang atau berlebihan.
3. Jangan menggunakan toast untuk informasi penting yang membutuhkan tindakan atau perhatian lebih lama.
4. Pastikan feedback tidak mengganggu alur penggunaan aplikasi.
5. Ikuti sistem feedback yang sudah tersedia dalam proyek apabila sudah memiliki implementasi khusus.

## 19. UUID

1. Gunakan paket `uuid` untuk menghasilkan ID unik.
2. Jangan menggunakan timestamp sebagai pengganti ID unik.
3. Periksa konfigurasi dan versi paket sebelum mengimplementasikannya.
4. Gunakan mekanisme UUID yang konsisten dengan kebutuhan penyimpanan dan identifikasi data.

## 20. Shared Preferences

1. Gunakan `shared_preferences` untuk menyimpan pengaturan sederhana.
2. Jangan menggunakannya untuk menyimpan data sensitif.
3. Jangan menggunakannya untuk menyimpan data berukuran besar.
4. Untuk data kompleks atau data utama aplikasi, gunakan penyimpanan yang sesuai dengan arsitektur proyek.
5. Periksa implementasi penyimpanan yang sudah tersedia sebelum menambahkan mekanisme baru.

## 21. Daftar panjang

1. Untuk daftar yang berpotensi menampilkan lebih dari 20 item, gunakan mekanisme lazy loading.
2. Utamakan:
   - `ListView.builder`
   - `SliverList`
3. Jangan membuat seluruh item sekaligus menggunakan `ListView` biasa atau widget lain yang melakukan rendering seluruh elemen tanpa kebutuhan khusus.
4. Pastikan daftar panjang tidak menyebabkan penggunaan memori berlebihan dan penurunan performa.
5. Gunakan pagination apabila ukuran data dan kebutuhan aplikasi memerlukannya.

## 22. Navigasi antarhalaman

1. Navigasi antarhalaman wajib menggunakan helper `Nav` yang tersedia di `core_shared`.
2. Jangan menggunakan mekanisme navigasi langsung apabila helper `Nav` sudah menyediakan fungsi yang diperlukan.
3. Periksa implementasi helper `Nav` dan contoh penggunaannya sebelum mengimplementasikan navigasi.
4. Ikuti pola navigasi yang sudah diterapkan proyek.

Contoh:

`unawaited(Nav.to(context, const StatistikBahanBakar()))`

Jangan mengasumsikan signature method `Nav` tanpa memeriksa implementasinya.

## 23. Import

1. Seluruh import file proyek wajib menggunakan format `package:`.
2. Dilarang menggunakan relative import untuk mengimpor file proyek.
3. Ikuti konvensi import yang sudah diterapkan proyek.

Contoh yang benar:

`import 'package:myapp/fitur/contoh/contoh.dart';`

## 24. Pengelolaan tanggal dan waktu

### 24.1. Penyimpanan

1. Simpan tanggal dan waktu dalam format UTC.
2. Sebelum serialisasi, gunakan `toUtc()`.
3. Untuk serialisasi ISO 8601, gunakan:

   `tanggal.toUtc().toIso8601String()`

4. Jika menggunakan `DateTime.now()` untuk data yang akan disimpan, gunakan:

   `DateTime.now().toUtc()`

### 24.2. Pembacaan

1. Gunakan `ParserUtil.parseDateTime(...)` untuk membaca tanggal dan waktu apabila helper tersebut tersedia.
2. Konversikan hasil pembacaan ke waktu lokal menggunakan `.toLocal()` apabila diperlukan untuk ditampilkan kepada pengguna.
3. Jangan mencampuradukkan waktu UTC dan waktu lokal dalam proses perbandingan atau penyimpanan.

Contoh:

`ParserUtil.parseDateTime(nilai)?.toLocal()`

## 25. Aturan lokalisasi

### 25.1. Konfigurasi

1. `MaterialApp` wajib mendeklarasikan `supportedLocales`.
2. Aplikasi yang menargetkan pengguna Indonesia wajib menyertakan:

   `Locale('id', 'ID')`

3. Gunakan `flutter_localizations` dari Flutter SDK.
4. `localizationsDelegates` wajib mencakup minimal:
   - `GlobalMaterialLocalizations.delegate`
   - `GlobalWidgetsLocalizations.delegate`
   - `GlobalCupertinoLocalizations.delegate`

5. Jangan mengandalkan delegate paket pihak ketiga sebagai satu-satunya sumber lokalisasi jika paket tersebut tidak menyediakan locale yang dibutuhkan.

### 25.2. Penerapan

1. Seluruh teks sistem yang ditampilkan kepada pengguna wajib mengikuti locale aplikasi.
2. Cakupan meliputi:
   - Toolbar pemilihan teks.
   - Dialog.
   - Date picker.
   - Time picker.
   - Komponen Material.
   - Komponen Cupertino.
3. Pastikan format tanggal, angka, dan informasi lokal sesuai dengan bahasa serta locale yang didukung.

### 25.3. Verifikasi

1. Setiap perubahan lokalisasi wajib diverifikasi secara visual.
2. Pastikan teks sistem benar-benar menggunakan locale yang ditentukan.
3. Jangan hanya mengandalkan pemeriksaan kode untuk menyatakan lokalisasi berhasil.
4. Jika aplikasi tidak dapat dijalankan atau diverifikasi secara visual, laporkan keterbatasan tersebut.

## 26. Penggunaan folder example

1. Sebelum menggunakan atau mengubah implementasi paket pihak ketiga, periksa folder `example` paket tersebut apabila tersedia.
2. Pelajari cara pengembang paket menggunakan API yang dibutuhkan.
3. Bandingkan contoh resmi dengan implementasi proyek.
4. Periksa apakah terdapat perbedaan konstruktor, parameter, konfigurasi, atau urutan inisialisasi.
5. Jangan menyalin contoh secara langsung tanpa menyesuaikannya dengan arsitektur proyek.
6. Jangan menganggap implementasi proyek sudah benar hanya karena kode berhasil dikompilasi.

## 27. Inisialisasi Sqflite FFI

1. Sebelum membuka database pada platform yang membutuhkan SQLite FFI, lakukan inisialisasi sesuai platform.
2. Gunakan `sqfliteFfiInit()` sebelum menggunakan database factory FFI.
3. Pada platform desktop, gunakan `databaseFactoryFfi`.
4. Pada platform web, gunakan `databaseFactoryFfiWeb` sesuai dukungan dan dependency paket yang digunakan.
5. Pastikan `databaseFactory` sudah ditentukan sebelum membuka database.
6. Jangan menjalankan inisialisasi FFI secara sembarangan pada platform mobile yang menggunakan implementasi native.
7. Periksa dokumentasi, versi paket, dan contoh resmi untuk memastikan urutan inisialisasi yang benar.
8. Hindari inisialisasi database berulang kali jika proyek sudah menyediakan mekanisme inisialisasi terpusat.

## 28. Penggunaan tools Kilo Code

### 28.1. Pembacaan dan pencarian

Gunakan tools sesuai fungsi:

- `read` untuk membaca isi file.
- `glob` untuk mencari file.
- `grep` atau `rg` untuk mencari kode dan teks.
- `ls` untuk melihat isi direktori.

### 28.2. Pengeditan

1. Gunakan `edit` atau `apply_patch` untuk perubahan sebagian.
2. Hindari penggunaan terminal untuk mengedit file kode.
3. Jangan menggunakan `write` untuk menulis ulang seluruh file jika perubahan sebagian sudah cukup.

### 28.3. Pertanyaan

1. Gunakan tool `question` apabila terdapat informasi yang belum pasti dan dapat memengaruhi hasil pekerjaan.
2. Jangan menebak keputusan yang seharusnya ditentukan pengguna.
3. Ajukan pertanyaan yang spesifik dan mudah dipahami.
4. Jika ada beberapa pilihan yang memiliki konsekuensi berbeda, jelaskan pilihan tersebut.
5. Jangan menanyakan kembali informasi yang sudah tersedia dalam aturan atau konteks proyek.

### 28.4. TodoWrite

1. Gunakan tool `todowrite` sebagai peta jalan pekerjaan yang memiliki beberapa tahapan.
2. Buat daftar pekerjaan sebelum memulai implementasi.
3. Susun pekerjaan berdasarkan urutan ketergantungan.
4. Perbarui status pekerjaan selama proses berlangsung.
5. Tandai pekerjaan selesai hanya setelah benar-benar dilaksanakan.
6. Jangan menganggap pekerjaan selesai hanya karena kode sudah ditulis.

## 29. Verifikasi penerapan aturan Kilo Code

1. Seluruh file rules yang diwajibkan proyek harus didaftarkan secara eksplisit dalam `kilo.jsonc` melalui konfigurasi `instructions`.
2. Jangan menganggap file aturan otomatis diterapkan hanya karena sudah tersedia di dalam direktori proyek.
3. Periksa apakah path yang didaftarkan benar-benar menunjuk ke file yang tersedia.
4. Pastikan tidak terdapat kesalahan penulisan path.
5. Jika bundel rules terlalu besar, pecah berdasarkan tanggung jawab dan topik agar lebih mudah dibaca serta dipatuhi.
6. Jangan menghapus aturan ketika memecah file tanpa mempertahankan seluruh maksud aslinya.
7. Setiap aturan wajib mempunyai kriteria pelaksanaan yang dapat diperiksa.
8. Jika aturan belum terdaftar, laporkan bahwa aturan tersebut belum terverifikasi penerapannya.
9. Jangan mengklaim seluruh rules sudah aktif hanya berdasarkan keberadaan file.
10. Setelah perubahan konfigurasi rules, periksa kembali konfigurasi dan pastikan sesi Kilo Code memuat instruksi terbaru.

## 30. Alur kerja wajib

Setiap pekerjaan pengembangan harus mengikuti alur berikut.

### Tahap 1 — Memahami pekerjaan

1. Pahami permintaan pengguna.
2. Tentukan ruang lingkup perubahan.
3. Identifikasi fitur dan file yang berkaitan.
4. Gunakan `question` jika terdapat keputusan penting yang belum jelas.

### Tahap 2 — Membaca aturan dan skills

1. Baca aturan proyek yang relevan.
2. Baca `optimasi_ui.md` jika pekerjaan berkaitan dengan tampilan.
3. Periksa seluruh skills yang relevan.
4. Pastikan rules sudah terdaftar dan diterapkan.

### Tahap 3 — Menganalisis implementasi

1. Baca kode aktual yang berkaitan dengan pekerjaan.
2. Periksa file pemanggil dan dependency terkait.
3. Periksa pola implementasi pada file lain.
4. Baca `pubspec.yaml` dan `pubspec.lock`.
5. Identifikasi sumber API yang diperlukan.
6. Periksa kode SDK atau paket yang relevan.
7. Baca contoh resmi paket jika tersedia.
8. Periksa dokumentasi resmi jika diperlukan.
9. Identifikasi kemungkinan deprecated API, perubahan signature, dan potensi bug runtime.

### Tahap 4 — Menyusun rencana

1. Gunakan `todowrite` untuk membuat peta jalan.
2. Tentukan file yang akan diubah.
3. Tentukan implementasi yang akan digunakan.
4. Identifikasi risiko dan ketergantungan.
5. Pastikan solusi tidak menimbulkan perubahan di luar ruang lingkup.

### Tahap 5 — Implementasi

1. Ubah hanya bagian kode yang diperlukan.
2. Gunakan tools edit, bukan terminal.
3. Ikuti seluruh aturan dependency dan SDK.
4. Pertahankan konsistensi arsitektur.
5. Hindari refactoring yang tidak berkaitan.

### Tahap 6 — Verifikasi

1. Jalankan `dart format` pada file Dart yang berubah.
2. Jalankan `flutter analyze`.
3. Perbaiki error atau warning baru yang berkaitan dengan perubahan.
4. Jalankan pengujian tambahan yang relevan.
5. Verifikasi visual apabila pekerjaan mengubah tampilan atau lokalisasi.
6. Periksa kembali hasil perubahan.

### Tahap 7 — Pelaporan

Sampaikan laporan yang mencakup:

1. Ringkasan pekerjaan.
2. Daftar file yang diubah.
3. Penjelasan perubahan.
4. Hasil formatting.
5. Hasil analisis.
6. Hasil pengujian.
7. Hal yang belum diverifikasi.
8. Kendala atau keputusan yang masih membutuhkan persetujuan pengguna.

Jangan mengklaim keberhasilan pada tahapan yang belum benar-benar dilakukan.
