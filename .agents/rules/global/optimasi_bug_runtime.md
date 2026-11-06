# Aturan Optimasi Bug Runtime

**Path file:** `prompt/aturan/optimasi_bug_runtime.md`

## Tujuan

Aturan ini digunakan untuk mencegah kesalahan runtime, kesalahan pengelolaan data, kebocoran sumber daya, kesalahan proses asynchronous, serta masalah lain yang dapat menyebabkan aplikasi Flutter tidak berjalan sebagaimana mestinya.

AI wajib mengikuti aturan ini ketika membaca, membuat, mengubah, atau memperbaiki kode Dart dan Flutter di dalam proyek.

## Aturan

### 1. Penanganan Nilai Null

Selalu tangani kemungkinan nilai `null` sesuai dengan kebutuhan dan logika program.

Ketentuan:

- Hindari penggunaan operator `!` untuk memaksakan nilai nullable agar dianggap tidak null.
- Hindari penggunaan casting `as` untuk memaksakan nilai nullable menjadi tipe non-null tanpa validasi.
- Gunakan operator `??` untuk memberikan nilai pengganti ketika nilai di sebelah kirinya `null`, selama nilai pengganti tersebut sesuai dengan kebutuhan dan logika program.
- Utamakan `??` untuk penanganan null sederhana daripada membuat percabangan `if` yang menghasilkan perilaku sama.
- Gunakan `??=` untuk mengisi variabel hanya ketika nilainya `null`, sesuai rekomendasi linter `prefer_conditional_assignment`.
- Jangan memberikan nilai pengganti secara sembarangan hanya untuk menghilangkan kemungkinan `null`.
- Jangan menyembunyikan kesalahan atau kondisi data tidak valid dengan memberikan nilai default yang tidak sesuai.
- Jika nilai `null` menunjukkan bahwa data tidak valid atau tidak tersedia, tangani kondisi tersebut secara eksplisit. Jangan mengubahnya menjadi nilai lain yang dapat menyebabkan kesalahan logika.

Contoh penggunaan yang direkomendasikan:

```dart
return val ?? true;
```

Bentuk berikut juga benar, tetapi tidak perlu digunakan apabila hanya menghasilkan perilaku yang sama tanpa menambahkan logika:

```dart
if (val == null) {
  return true;
}

return val;
```

### 2. Parsing dan Konversi Tipe Data

Hindari penggunaan `dynamic` dan parsing yang berisiko menimbulkan kesalahan runtime.

Ketentuan:

- Gunakan `tryParse` daripada `parse` ketika mengonversi String menjadi tipe data seperti `int`, `double`, dan tipe lain yang menyediakan metode `tryParse`.
- Hindari menggunakan `dynamic` sebagai tipe variabel apabila tipe datanya dapat ditentukan secara jelas.
- Jangan melakukan konversi tipe secara paksa tanpa memastikan tipe data sumber.
- Tangani hasil parsing yang gagal atau menghasilkan `null` sesuai kebutuhan program.
- Jangan memberikan nilai default secara sembarangan ketika parsing gagal.
- Jika nilai berasal dari data eksternal, pastikan format dan tipe datanya divalidasi sebelum digunakan.

Contoh:

```dart
final nilai = int.tryParse(dataString);
```

Jangan menggunakan:

```dart
final nilai = int.parse(dataString);
```

**Penanganan parameter constructor dan variabel privat yang nullable:**

- Jika nilai nullable berasal dari parameter constructor atau variabel privat, salin terlebih dahulu nilainya ke variabel lokal sebelum melakukan pemeriksaan null, terutama ketika nilai tersebut akan digunakan lebih lanjut setelah pemeriksaan.
- Lakukan pemeriksaan null terhadap variabel lokal tersebut.
- Gunakan variabel lokal yang sudah dipastikan tidak null untuk proses berikutnya.
- Jangan menggunakan `!` atau `as` hanya untuk mengatasi kesulitan promosi tipe data.

Contoh:

```dart
final nilai = _nilai;

if (nilai == null) {
  return;
}

// Gunakan nilai setelah dipastikan tidak null.
```

### 3. Model dan Struktur Data Database

Setiap struktur baris (row) database harus memiliki representasi model data yang jelas.

Ketentuan:

- Buat model untuk merepresentasikan struktur data dari setiap tabel database yang digunakan.
- Nama tabel dan nama kolom harus didefinisikan secara jelas.
- Gunakan model untuk membaca, mengolah, dan menyimpan data database.
- Hindari penggunaan Map database secara langsung dan berulang di berbagai bagian aplikasi apabila pemetaan tersebut dapat ditangani melalui model atau lapisan repository.
- Pastikan pemetaan antara nama kolom database dan properti model sesuai dengan struktur tabel sebenarnya.
- Jangan menggunakan nama tabel atau kolom yang tidak sesuai dengan skema database.

### 4. Pengecekan `mounted`

Setiap operasi asynchronous yang berhubungan dengan UI harus memperhatikan status `mounted`.

Ketentuan:

- Setelah `await` di dalam `State`, periksa `mounted` sebelum melanjutkan operasi yang menggunakan `setState`, `context`, atau sumber daya milik State.
- Jika widget sudah tidak terpasang, hentikan proses lanjutan yang membutuhkan widget tersebut.
- Untuk penggunaan `BuildContext` di luar State, gunakan `context.mounted` sebelum mengakses context setelah operasi asynchronous.
- Jangan memanggil `setState` setelah widget tidak lagi terpasang.
- Jangan menggunakan `BuildContext` yang sudah tidak valid.

Contoh:

```dart
await prosesData();

if (!mounted) return;

setState(() {
  // Perbarui UI.
});
```

Pengecekan `mounted` tidak perlu dipaksakan apabila kode setelah `await` hanya menjalankan proses yang tidak bergantung pada State, UI, atau BuildContext.

### 5. Future di Dalam `build()`

Jangan membuat atau menjalankan Future baru secara langsung di dalam metode `build()`.

Ketentuan:

- Jangan memanggil fungsi asynchronous secara langsung di dalam `build()` untuk menghasilkan Future baru pada setiap rebuild.
- Jangan menempatkan proses pengambilan data asynchronous yang menyebabkan Future terus dibuat ulang ketika widget melakukan rebuild.
- Siapkan Future pada tempat yang sesuai, misalnya melalui `initState`, provider, atau mekanisme pengelolaan state yang sudah digunakan proyek.
- Pastikan Future yang digunakan oleh `FutureBuilder` memiliki referensi yang stabil dan tidak dibuat ulang tanpa kebutuhan.

Tujuannya adalah mencegah proses asynchronous berjalan berulang akibat rebuild yang tidak diperlukan.

### 6. Try/Catch dan Penanganan Error

Operasi yang berpotensi menghasilkan error runtime wajib memiliki penanganan error yang sesuai.

Prioritaskan operasi yang berhubungan dengan:

- Database.
- Jaringan atau API.
- File dan penyimpanan.
- Platform channel.
- Parsing dan pemrosesan data eksternal.
- Operasi asynchronous yang berpotensi gagal.

Ketentuan:

- Gunakan `try/catch` untuk menangani error pada operasi tersebut.
- Setiap blok `catch` wajib menggunakan logger `L.e`.
- Setelah mencatat error, teruskan kembali error menggunakan `rethrow` agar lapisan pemanggil, termasuk UI, dapat menangani kegagalan tersebut.
- Jangan menangkap error lalu mengabaikannya tanpa penanganan yang jelas.
- Jangan mengubah error menjadi nilai default yang dapat menyembunyikan kegagalan operasi.
- Tempatkan penanganan error pada lapisan yang tepat.
- Hindari menangkap dan mencatat error yang sama berulang kali pada banyak lapisan apabila tidak memberikan informasi tambahan.

Pengecualian untuk Future yang dijalankan tanpa `await`:

- Future yang berjalan menggunakan `unawaited` tetap wajib memiliki penanganan error.
- Jika proses tersebut merupakan inisialisasi UI, tangani kegagalan pada batas inisialisasi dan tampilkan kondisi error melalui state UI.
- Jangan melakukan `rethrow` ke Future yang tidak memiliki pemanggil atau mekanisme penanganan error.

### 7. Dispose dan Pengelolaan Sumber Daya

Pastikan seluruh sumber daya yang membutuhkan pelepasan dikelola dengan benar.

Ketentuan:

- Tutup seluruh controller yang sudah tidak digunakan melalui `dispose()`.
- Hentikan `StreamSubscription` melalui `cancel()`.
- Hentikan `Timer` melalui `cancel()`.
- Lepaskan listener yang sudah didaftarkan.
- Hentikan atau lepaskan observer yang sudah didaftarkan.
- Pastikan sumber daya tidak dibiarkan aktif setelah widget atau objek pemiliknya tidak digunakan.
- Jangan memanggil `setState` setelah widget tidak lagi terpasang.
- Pastikan proses pembersihan sumber daya tidak dilakukan berulang kali secara tidak aman.

Contoh sumber daya yang perlu diperhatikan:

- `TextEditingController`.
- `ScrollController`.
- `FocusNode`.
- `AnimationController`.
- `StreamSubscription`.
- `Timer`.
- Listener dan observer.

### 8. Transaksi Database dan Rollback

Operasi perubahan data database wajib memperhatikan konsistensi dan integritas data.

Ketentuan:

- Gunakan transaksi untuk operasi `insert`, `update`, dan `delete` yang menjadi bagian dari suatu proses bisnis.
- Pastikan seluruh perubahan data yang saling berkaitan berada dalam satu transaksi.
- Lakukan commit hanya ketika seluruh operasi dalam transaksi berhasil.
- Jika salah satu operasi gagal, lakukan rollback agar perubahan yang belum berhasil tidak meninggalkan data dalam kondisi tidak konsisten.
- Setelah kegagalan, teruskan error menggunakan `rethrow`.
- Jangan mengabaikan kegagalan transaksi.
- Ikuti mekanisme transaksi yang disediakan oleh library database yang digunakan.
- Jika menggunakan API seperti `transaction()` pada Sqflite, manfaatkan mekanisme commit dan rollback otomatis yang disediakan API tersebut.
- Jangan mencampurkan transaksi otomatis dari library dengan pemanggilan `begin`, `commit`, atau `rollback` manual yang tidak diperlukan.

Tujuannya adalah memastikan data tetap konsisten meskipun salah satu langkah operasi database mengalami kegagalan.

### 9. String Literal dan Konstanta

Hindari penggunaan string literal yang berulang atau berfungsi sebagai identifier tetap di berbagai bagian kode.

Ketentuan:

- Gunakan konstanta atau enum untuk nilai string yang memiliki fungsi tetap dalam logika aplikasi.
- Gunakan `enum` untuk kumpulan nilai yang pilihannya sudah ditentukan dan terbatas.
- Gunakan `const` atau konstanta terpusat untuk nama tabel, nama kolom, key penyimpanan, route, status, kategori, dan identifier lainnya.
- Jangan menyebarkan string yang sama ke banyak file apabila dapat menggunakan satu definisi terpusat.
- Pastikan penggunaan konstanta tidak mengubah makna atau perilaku program.

Tidak perlu mengubah setiap string literal menjadi enum. Pemilihan konstanta atau enum harus disesuaikan dengan fungsi dan karakteristik nilainya.

### 10. Penggunaan `await` dan `unawaited`

Gunakan `await` dan `unawaited` sesuai kebutuhan proses asynchronous.

Ketentuan:

- Gunakan `await` apabila hasil Future diperlukan, proses harus menunggu penyelesaiannya, atau urutan operasi harus dipastikan.
- Gunakan `unawaited()` apabila Future memang tidak perlu ditunggu oleh pemanggil.
- Pastikan operasi yang dijalankan menggunakan `unawaited()` tetap memiliki penanganan error yang sesuai.
- Jangan menggunakan `unawaited()` hanya untuk menghilangkan peringatan analyzer.
- Jangan menggunakan `await` apabila penyelesaian Future tidak diperlukan dan tidak memengaruhi urutan proses.
- Untuk navigasi, gunakan `await` jika hasil navigasi diperlukan atau ada proses lanjutan yang harus menunggu halaman ditutup. Gunakan `unawaited()` jika hasilnya memang tidak diperlukan.

Import yang digunakan apabila `unawaited()` diperlukan:

```dart
import 'dart:async';
```

Contoh:

```dart
unawaited(prosesAsynchronous());
```

### 11. Penggunaan Logger

Gunakan logger dari class `L` yang sudah tersedia di proyek.

Jangan menggunakan `print()`, `debugPrint()`, atau logger lain untuk menggantikan logger proyek.

Ketentuan penggunaan:

| Logger | Kegunaan                                                                                                   |
| ------ | ---------------------------------------------------------------------------------------------------------- |
| `L.i`  | Mencatat alur proses normal, seperti proses dimulai atau selesai.                                          |
| `L.s`  | Mencatat keberhasilan operasi, seperti penyimpanan, penghapusan, dan penambahan data ke database.          |
| `L.w`  | Mencatat kondisi tidak normal yang tidak menyebabkan operasi gagal, seperti data kosong atau izin ditolak. |
| `L.e`  | Mencatat error runtime yang ditangani melalui blok `catch`.                                                |

Ketentuan tambahan:

- Setiap blok `catch` wajib mencatat error menggunakan `L.e`.
- Gunakan `L.i` untuk informasi yang memang memberikan manfaat dalam pemantauan alur aplikasi.
- Jangan menggunakan `L.i` secara berlebihan.
- Jangan menempatkan logging di dalam loop yang berjalan berulang atau berfrekuensi tinggi.
- Hindari penggunaan logger di dalam metode `build()` karena metode tersebut dapat dipanggil berulang kali.
- Pastikan informasi yang dicatat membantu proses debugging dan tidak membocorkan data sensitif.

### 12. Flutter Analyzer

Kode wajib bersih dari seluruh temuan analyzer pada folder `lib/` dan `test/`.

Ketentuan:

- Jalankan `flutter analyze` setelah melakukan perubahan kode.
- Perbaiki seluruh `error`, `warning`, dan `info` yang ditemukan pada folder `lib/` dan `test/`.
- Jangan membiarkan temuan analyzer yang belum diselesaikan.
- Jangan menggunakan komentar `ignore` hanya untuk menyembunyikan temuan analyzer.
- Jika suatu temuan memang tidak dapat dihindari, pastikan terdapat alasan teknis yang jelas sebelum menentukan penanganannya.
- Periksa kembali hasil analyzer setelah perbaikan.

### 13. Restart Aplikasi

Ketika fitur restart aplikasi menggunakan API `Restart.restartApp()`, ikuti ketentuan berikut:

- Panggil `Restart.restartApp()` menggunakan `await`.
- Tangani hasil pengembalian bertipe `RestartResult`.
- Periksa properti `success` untuk mengetahui apakah permintaan restart berhasil diterima oleh platform.
- Jika `success` bernilai `false`, tangani informasi `code` dan `message` sesuai kebutuhan.
- Perhatikan bahwa `code` dan `message` dapat bernilai `null`.
- Jangan menganggap restart berhasil hanya karena pemanggilan Future selesai.
- Gunakan `try/catch` untuk menangani error saat proses restart.
- Setiap blok `catch` wajib mencatat error menggunakan `L.e`.
- Sebelum melakukan `setState` atau mengakses `context` setelah `await`, periksa `mounted`.
- Jika proses restart gagal, berikan informasi kegagalan kepada UI sesuai kebutuhan.

### 14. ParserUtil untuk Data Dynamic dari Map

Seluruh parsing nilai `dynamic` yang berasal dari Map database maupun jaringan wajib menggunakan `ParserUtil` yang sudah tersedia di proyek.

Ketentuan:

- Gunakan `ParserUtil` sebagai tempat penanganan dan konversi tipe data dari Map database atau jaringan.
- Jangan melakukan parsing `dynamic` secara langsung dan berulang di berbagai bagian aplikasi.
- Periksa implementasi `ParserUtil` terlebih dahulu sebelum menggunakannya.
- Gunakan metode parsing yang sudah tersedia dan sesuai dengan tipe data yang dibutuhkan.
- Jika metode yang diperlukan belum tersedia, sesuaikan implementasi `ParserUtil` tanpa membuat fungsi parsing duplikat di berbagai file.
- Pastikan penanganan nilai null dan kegagalan parsing tetap mengikuti aturan pada bagian penanganan null dan parsing.
- Jika perlu menambahkan metode parsing, gunakan pendekatan yang aman terhadap data yang tidak valid.

**Prioritas penerapan:**

`ParserUtil` merupakan jalur utama untuk memproses nilai `dynamic` dari Map database dan jaringan. Penggunaan `tryParse` diterapkan di dalam implementasi parsing apabila diperlukan, bukan sebagai pengganti `ParserUtil` di seluruh bagian aplikasi.

### 15. Inisialisasi Asynchronous di initState

Jangan menjadikan metode `initState()` sebagai metode asynchronous.

Apabila inisialisasi membutuhkan proses asynchronous, gunakan kombinasi `Future.microtask`, `unawaited`, dan pengecekan `mounted`.

Ketentuan:

- Jalankan proses inisialisasi asynchronous melalui `Future.microtask`.
- Gunakan `unawaited` untuk menjalankan Future tersebut dari `initState()`.
- Pastikan proses inisialisasi memiliki penanganan error.
- Periksa `mounted` sebelum mengakses UI setelah proses asynchronous.
- Jangan melakukan pembaruan UI apabila widget sudah tidak terpasang.
- Pastikan error dari Future yang tidak ditunggu tidak dibiarkan menjadi unhandled error.
- Gunakan state error atau mekanisme penanganan UI yang sesuai apabila proses inisialisasi gagal.

### 16. Pengamanan Aksi dan Double Submit

Gunakan flag seperti `_sedangMemuat` atau `_isLoading` untuk mencegah satu aksi dijalankan berulang kali sebelum proses sebelumnya selesai.

Ketentuan:

- Periksa flag sebelum memulai operasi.
- Jika operasi masih berjalan, hentikan pemanggilan berikutnya.
- Aktifkan flag sebelum memulai proses asynchronous.
- Pastikan flag dikembalikan ke kondisi semula setelah operasi selesai, termasuk ketika terjadi error.
- Gunakan `try/finally` apabila diperlukan agar proses pengembalian flag tetap dijalankan.
- Jika flag digunakan untuk memperbarui UI, periksa `mounted` sebelum memanggil `setState`.
- Selama operasi berlangsung, cegah pengguna menjalankan aksi yang sama berulang kali.

Contoh:

```dart
if (_isLoading) return;
```

### 17. Post Frame Callback dan WidgetsBindingObserver

Gunakan `addPostFrameCallback` dan `WidgetsBindingObserver` sesuai kebutuhan siklus hidup widget dan aplikasi.

**A. addPostFrameCallback**

Gunakan `WidgetsBinding.instance.addPostFrameCallback` untuk operasi yang membutuhkan widget sudah selesai dirender.

Contoh penggunaan:

- Mengatur posisi scroll setelah widget selesai ditampilkan.
- Mengatur fokus pada suatu input setelah widget dirender.
- Menampilkan dialog yang membutuhkan widget sudah tersedia.
- Melakukan operasi lain yang bergantung pada hasil rendering frame.

Ketentuan:

- Jangan menggunakan `addPostFrameCallback` untuk pekerjaan yang tidak membutuhkan widget selesai dirender.
- Pastikan widget masih terpasang sebelum mengakses UI dari callback.
- Jika callback menjalankan operasi asynchronous, terapkan pengecekan `mounted` setelah `await` sebelum mengakses UI.

**B. WidgetsBindingObserver**

Gunakan `WidgetsBindingObserver` apabila widget atau objek perlu mengetahui perubahan siklus hidup aplikasi.

Ketentuan:

- Daftarkan observer melalui `WidgetsBinding.instance.addObserver(this)` di dalam `initState()`.
- Lepaskan observer melalui `WidgetsBinding.instance.removeObserver(this)` di dalam `dispose()`.
- Gunakan `didChangeAppLifecycleState` untuk menangani perubahan siklus hidup aplikasi.
- Sesuaikan tindakan dengan status aplikasi, seperti ketika aplikasi berpindah ke background atau kembali ke foreground.
- Pastikan observer tidak didaftarkan berulang kali tanpa kebutuhan.
- Pastikan observer selalu dilepaskan ketika objek pemiliknya sudah tidak digunakan.

Contoh penggunaan:

- Mengunci aplikasi ketika berpindah ke background.
- Memperbarui data ketika aplikasi kembali ke foreground.
- Menghentikan proses tertentu ketika aplikasi tidak aktif.

Referensi:
https://api.flutter.dev/flutter/widgets/WidgetsBindingObserver-class.html

---

## Prioritas Penyelesaian Ketika Menemukan Pelanggaran

Ketika AI menemukan kode yang tidak sesuai dengan aturan ini:

1. Periksa terlebih dahulu konteks kode dan tujuan operasi yang sedang dikerjakan.
2. Identifikasi sumber masalah dan kemungkinan dampaknya terhadap runtime.
3. Perbaiki berdasarkan kebutuhan dan logika program, bukan sekadar menghilangkan peringatan analyzer.
4. Jangan mengganti perilaku program yang sudah benar hanya untuk menyesuaikan bentuk penulisan.
5. Jangan membuat abstraksi, helper, konstanta, atau percabangan baru apabila tidak diperlukan.
6. Pastikan perbaikan tidak menimbulkan masalah baru pada bagian lain.
7. Jalankan `flutter analyze` setelah perubahan dan selesaikan seluruh temuan pada folder `lib/` dan `test/`.

## Rekomendasi (Tidak Bersifat Wajib)

Hal-hal berikut merupakan rekomendasi tambahan untuk meningkatkan kualitas penerapan aturan:

- Pertimbangkan untuk menyediakan unit test pada `ParserUtil`, terutama untuk nilai null, format tidak valid, dan perbedaan tipe data dari database maupun jaringan.
- Pertimbangkan untuk menguji operasi transaksi database ketika salah satu langkah insert, update, atau delete mengalami kegagalan.
- Pertimbangkan untuk menyediakan mekanisme pencatatan error yang konsisten agar proses debugging lebih mudah dilakukan.

Rekomendasi di atas tidak menambahkan kewajiban baru terhadap implementasi apabila belum diperlukan oleh kebutuhan proyek.
