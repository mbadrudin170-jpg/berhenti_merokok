# Bug runtime

## Tinggi

- Status: Belum dikerjakan
- Masalah: File generated `lib/fitur/tema/notifier/tema_notifier.g.dart` tidak sinkron dengan source `lib/fitur/tema/notifier/tema_notifier.dart`. Source telah diubah untuk menggunakan `Future<TemaEnum>` sebagai tipe pengembalian `build()`, namun file generated masih menggunakan tipe `String` (kelas `_$TemaNotifier extends $Notifier<String>` dan `TemaNotifierProvider extends $NotifierProvider<TemaNotifier, String>`). Ketidaksesuaian ini menyebabkan kegagalan kompilasi karena tipe state yang diharapkan tidak cocok.
- Solusi: Jalankan generator Riverpod (`dart run build_runner build --delete-conflicting-outputs`) untuk meregenerasi file `tema_notifier.g.dart` agar sinkron dengan source yang menggunakan `Future<TemaEnum>`. Pastikan file generated menggunakan tipe `TemaEnum`/`AsyncValue<TemaEnum>` sesuai source.
- Aturan dilanggar: `.agents/rules/global/aturan_riverpod.md` — bagian 1 "Penggunaan riverpod_generator" (file `.g.dart` harus dihasilkan ulang setelah perubahan tipe `build`). `.agents/rules/global/aturan_lainnya.md` — poin 8 "File Hasil Generator" (jangan mengedit file hasil generator secara langsung; ubah file sumber lalu jalankan generator).
- File terkait: [tema_notifier.dart#L12](lib/fitur/tema/notifier/tema_notifier.dart#L12), [tema_notifier.g.dart#L16](lib/fitur/tema/notifier/tema_notifier.g.dart#L16), [tema_notifier.g.dart#L46](lib/fitur/tema/notifier/tema_notifier.g.dart#L46)

## Sedang

Tidak ada temuan.

## Rendah

- Status: Belum dikerjakan
- Masalah: Metode `initState()` dan `dispose()` pada `_HomeState` masih mengandung komentar `// TODO: implement initState` dan `// TODO: implement dispose`, menandakan implementasi siklus hidup belum selesai.
- Solusi: Hapus komentar TODO setelah implementasi selesai, atau implementasikan logika yang diperlukan (misalnya inisialisasi resource di `initState` dan pembersihan di `dispose`). Jika tidak ada logika tambahan yang diperlukan, cukup hapus komentar TODO.
- Aturan dilanggar: `.agents/rules/proyek/aturan_khusus.md` — bagian "Layar Home sebagai ConsumerStatefulWidget dengan Siklus Hidup" poin 3.
- File terkait: [home.dart#L15](lib/home.dart#L15), [home.dart#L20](lib/home.dart#L20)

- Status: Belum dikerjakan
- Masalah: `MyApp` dideklarasikan sebagai `ConsumerStatefulWidget`, namun `_MyAppState.build` tidak mengamati provider apa pun melalui `ref`. Tidak ada kebutuhan akses provider pada root widget saat ini.
- Solusi: Ubah `MyApp` dan `_MyAppState` menjadi `StatelessWidget` jika tidak membutuhkan akses provider. Jika nantinya root perlu mengamati provider (misalnya tema), kembalikan menjadi `ConsumerStatefulWidget`.
- Aturan dilanggar: `.agents/rules/proyek/aturan_khusus.md` — bagian "Root App Widget sebagai ConsumerStatefulWidget" poin 3.
- File terkait: [app.dart#L5](lib/app.dart#L5), [app.dart#L12](lib/app.dart#L12)

# UX

## Tinggi

Tidak ada temuan.

## Sedang

- Status: Belum dikerjakan
- Masalah: `MaterialApp` pada `lib/app.dart` tidak mendeklarasikan `supportedLocales` maupun `localizationsDelegates`. Aplikasi Flutter wajib mengatur lokalisasi secara eksplisit agar teks sistem (dialog, date picker, toolbar pemilihan teks) mengikuti locale yang didukung. Selain itu, delegate lokalisasi khusus untuk `material_ui.MaterialLocalizations` (diperlukan oleh `adaptive_dialog`) juga tidak terdaftar, yang dapat menyebabkan `Null check operator used on a null value` saat dialog ditampilkan.
- Solusi: Tambahkan `supportedLocales: const [Locale('id', 'ID')]` dan `localizationsDelegates` yang mencakup `GlobalMaterialLocalizations.delegate`, `GlobalWidgetsLocalizations.delegate`, `GlobalCupertinoLocalizations.delegate`, dan `_MaterialUiLocalizationsDelegate()` pada `MaterialApp`. Impor `flutter_localizations` dari Flutter SDK dan buat kelas `_MaterialUiLocalizationsDelegate` dengan `isSupported => true`.
- Aturan dilanggar: `.agents/rules/global/aturan_lainnya.md` — poin 33 "Lokalisasi Aplikasi". `.agents/rules/proyek/aturan_khusus.md` — bagian "Registrasi Delegate Lokalisasi `material_ui` untuk `adaptive_dialog`".
- File terkait: [app.dart#L16](lib/app.dart#L16), [app.dart#L22](lib/app.dart#L22)

## Rendah

- Status: Belum dikerjakan
- Masalah: Judul `AppBar` pada halaman Home menampilkan teks "data" yang tidak informatif dan tidak bermakna bagi pengguna.
- Solusi: Ganti teks "data" dengan judul yang sesuai dan bermakna untuk halaman Home (misalnya nama aplikasi atau judul halaman).
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — teks yang ditampilkan kepada pengguna seharusnya mudah dipahami dan bermakna (optimasi_ux.md bagian 2 "Bahasa yang ditampilkan kepada pengguna").
- File terkait: [home.dart#L27](lib/home.dart#L27)

- Status: Belum dikerjakan
- Masalah: Body halaman Home hanya menampilkan teks "Home" tanpa konten yang bermakna, sehingga pengguna tidak memperoleh informasi atau tindakan yang berguna.
- Solusi: Tambahkan konten yang sesuai untuk halaman Home sesuai tujuan aplikasi (misalnya ringkasan, navigasi, atau informasi utama).
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — tampilan harus dirancang agar pengguna dapat memahami informasi dan tindakan yang tersedia (optimasi_ux.md bagian 3 "Kejelasan tampilan").
- File terkait: [home.dart#L28](lib/home.dart#L28)

# UI

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

- Status: Belum dikerjakan
- Masalah: Body `Scaffold` pada halaman Home tidak dibungkus dengan `SafeArea` dan tidak memiliki padding tepi layar. Konten dapat tertutup oleh notch, status bar, atau navigation bar, dan dapat menempel pada tepi layar.
- Solusi: Bungkus konten body dengan `SafeArea` dan tambahkan `Padding` dengan nilai yang sesuai dari referensi desain (optimasi_ui.md) pada lapisan yang bertanggung jawab (container halaman), bukan pada widget reusable.
- Aturan dilanggar: `.agents/rules/global/optimasi_ux.md` — bagian 10 "Padding tepi layar" dan bagian 14 "SafeArea".
- File terkait: [home.dart#L26](lib/home.dart#L26), [home.dart#L28](lib/home.dart#L28), [home.dart#L29](lib/home.dart#L29)

- Status: Belum dikerjakan
- Masalah: Widget `Text('data')` pada `AppBar` dan `Text('Home')` pada body tidak menggunakan konstruktor `const`, padahal nilai teksnya statis dan tidak bergantung pada runtime.
- Solusi: Tambahkan keyword `const` pada kedua widget `Text` untuk meningkatkan efisiensi rebuild dan mengikuti praktik terbaik Flutter.
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — praktik terbaik performa Flutter (linter `prefer_const_constructors`).
- File terkait: [home.dart#L27](lib/home.dart#L27), [home.dart#L28](lib/home.dart#L28)
