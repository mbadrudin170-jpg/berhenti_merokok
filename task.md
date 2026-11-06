# Bug runtime

## Tinggi

Tidak ada temuan.

## Sedang

- Status: Belum dikerjakan
- Masalah: `TemaNotifier` mengembalikan `String` kosong (`""`) alih-alih menggunakan `TemaEnum` yang sudah didefinisikan di `lib/fitur/tema/enum/tema_enum.dart`. Enum `TemaEnum` (dengan nilai `sistem`, `terang`, `gelap`) tidak digunakan di mana pun, sehingga tipe state notifier tidak konsisten dengan model enum yang tersedia.
- Solusi: Ubah tipe pengembalian `build()` pada `TemaNotifier` dari `String` ke `TemaEnum` (misalnya `TemaEnum.sistem` sebagai nilai awal), dan pastikan enum `TemaEnum` digunakan sebagai sumber kebenaran tipe tema.
- Aturan dilanggar: `.agents/rules/proyek/aturan_khusus.md` — bagian "Pengelolaan Tema melalui TemaNotifier (Riverpod Generator)" poin 1 dan 2.
- File terkait: [tema_notifier.dart#L5](lib/fitur/tema/notifier/tema_notifier.dart#L5), [tema_notifier.dart#L8](lib/fitur/tema/notifier/tema_notifier.dart#L8), [tema_enum.dart#L1](lib/fitur/tema/enum/tema_enum.dart#L1)

- Status: Belum dikerjakan
- Masalah: `SharedKeys.tema` (kunci penyimpanan preferensi tema) sudah didefinisikan di `lib/shared/helper/shared_keys.dart`, namun `TemaNotifier` tidak membaca maupun menyimpan nilai preferensi tema menggunakan kunci tersebut. State tema tidak persisten antar sesi aplikasi.
- Solusi: Integrasikan `SharedKeys.tema` ke dalam `TemaNotifier` agar preferensi tema dibaca saat `build()` dan disimpan setiap kali tema diubah, menggunakan `SharedPreferences` sesuai pola proyek.
- Aturan dilanggar: `.agents/rules/proyek/aturan_khusus.md` — bagian "Sentralisasi Kunci Penyimpanan di SharedKeys" poin 1 dan 2.
- File terkait: [tema_notifier.dart#L5](lib/fitur/tema/notifier/tema_notifier.dart#L5), [shared_keys.dart#L9](lib/shared/helper/shared_keys.dart#L9)

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

- Status: Belum dikerjakan
- Masalah: Enum `TemaEnum` tidak memiliki getter `label` melalui extension. Jika nilai enum ini ditampilkan kepada pengguna (misalnya pada pengaturan tema), representasi teksnya tidak dapat dikelola secara terpusat.
- Solusi: Tambahkan extension pada `TemaEnum` dengan getter `label` (dan `icon` jika diperlukan) sesuai aturan. Terapkan hanya jika enum ini akan ditampilkan kepada pengguna.
- Aturan dilanggar: `.agents/rules/global/optimasi_boilerplate.md` — bagian 9 "Enum yang Ditampilkan kepada Pengguna".
- File terkait: [tema_enum.dart#L1](lib/fitur/tema/enum/tema_enum.dart#L1)

# UX

## Tinggi

Tidak ada temuan.

## Sedang

- Status: Belum dikerjakan
- Masalah: `MaterialApp` pada `lib/app.dart` tidak mendeklarasikan `supportedLocales` maupun `localizationsDelegates`. Aplikasi Flutter wajib mengatur lokalisasi secara eksplisit agar teks sistem (dialog, date picker, toolbar pemilihan teks) mengikuti locale yang didukung.
- Solusi: Tambahkan `supportedLocales: const [Locale('id', 'ID')]` dan `localizationsDelegates` yang mencakup `GlobalMaterialLocalizations.delegate`, `GlobalWidgetsLocalizations.delegate`, dan `GlobalCupertinoLocalizations.delegate` pada `MaterialApp`. Impor `flutter_localizations` dari Flutter SDK.
- Aturan dilanggar: `.agents/rules/global/aturan_lainnya.md` — poin 33 "Lokalisasi Aplikasi".
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
