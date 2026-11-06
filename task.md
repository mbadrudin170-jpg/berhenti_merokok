# Bug runtime

## Tinggi

Tidak ada temuan.

## Sedang

- Status: Belum dikerjakan
- Masalah: Metode `_simpan` pada `FormBiodata` (`lib/fitur/biodata/screens/form_biodata.dart`) menangkap exception pada blok `catch (e)` tanpa melakukan apa pun (swallow error), sehingga kegagalan `Nav.pop` tidak dicatat maupun diteruskan. Selain itu, `setState` pada blok `finally` dipanggil tanpa pemeriksaan `mounted`.
- Solusi: Tangani error pada blok catch dengan logger `L.e` dan `rethrow` (atau hapus try/catch jika tidak diperlukan), serta tambahkan pemeriksaan `mounted` sebelum `setState` di blok `finally`. Jika kelas logger `L` belum tersedia, tambahkan terlebih dahulu.
- Aturan dilanggar: `.agents/rules/global/optimasi_bug_runtime.md` — poin 6 "Try/Catch dan Penanganan Error" dan poin 4 "Pengecekan `mounted`".
- File terkait: [form_biodata.dart#L29](lib/fitur/biodata/screens/form_biodata.dart#L29), [form_biodata.dart#L34](lib/fitur/biodata/screens/form_biodata.dart#L34), [form_biodata.dart#L36](lib/fitur/biodata/screens/form_biodata.dart#L36)

- Status: Belum dikerjakan
- Masalah: `Home` (`lib/home.dart`) menggunakan `IndexedStack` dengan daftar halaman yang dibangun sekaligus sejak awal (`_pages = [const DashboardScreen(), const LainnyaScreen()]`), sehingga tab yang belum pernah dibuka tetap dibangun dan state/provider-nya aktif. Hal ini melanggar pola lazy loading yang mewajibkan tab hanya dibuat saat pertama kali dipilih.
- Solusi: Terapkan lazy loading dengan `Set<int> _tabTerbuka` (awal `{0}`), representasikan tab yang belum dibuka sebagai `SizedBox.shrink()`, dan pertahankan `GlobalKey` per tab untuk fitur scroll-to-top. Deteksi double-tap dengan jendela waktu <= 500ms.
- Aturan dilanggar: `.agents/rules/proyek/aturan_khusus.md` — bagian "Navigasi Tab Utama (Home) — Inisialisasi Lazy dan Retensi State".
- File terkait: [home.dart#L12](lib/home.dart#L12), [home.dart#L16](lib/home.dart#L16), [home.dart#L30](lib/home.dart#L30)


- Status: Belum dikerjakan
- Masalah: Metode `initState()` dan `dispose()` pada `_DashboardScreenState` (`lib/fitur/dashboard/screens/dashboard_screen.dart`) masih mengandung komentar `// TODO: implement initState` dan `// TODO: implement dispose`, menandakan implementasi siklus hidup belum selesai.
- Solusi: Hapus komentar TODO setelah implementasi selesai, atau implementasikan logika yang diperlukan. Jika tidak ada logika tambahan, cukup hapus komentar TODO.
- Aturan dilanggar: `.agents/rules/proyek/aturan_khusus.md` — bagian "Layar dengan Siklus Hidup Menggunakan ConsumerStatefulWidget" poin 3.
- File terkait: [dashboard_screen.dart#L15](lib/fitur/dashboard/screens/dashboard_screen.dart#L15), [dashboard_screen.dart#L20](lib/fitur/dashboard/screens/dashboard_screen.dart#L20)

- Status: Belum dikerjakan
- Masalah: `BiodataNotifier` (`lib/fitur/biodata/notifier/biodata_notifier.dart`) belum mengelola data biodata: metode `build()` mengembalikan string kosong (`""`) dan tidak ada state/model Freezed yang merepresentasikan data biodata. State notifier seharusnya bertipe model Freezed, bukan `String` mentah.
- Solusi: Implementasikan `BiodataNotifier` dengan state berbasis `BiodataModel` (atau Freezed state khusus) sesuai pola provider proyek, termasuk pemuatan dan penyimpanan data. Pastikan file `.g.dart` dan `.freezed.dart` diregenerasi setelah perubahan.
- Aturan dilanggar: `.agents/rules/global/optimasi_boilerplate.md` — poin 1 "State dan Model" (wajib Freezed). `.agents/rules/global/aturan_riverpod.md` — poin 1 "Penggunaan riverpod_generator".
- File terkait: [biodata_notifier.dart#L5](lib/fitur/biodata/notifier/biodata_notifier.dart#L5), [biodata_notifier.dart#L8](lib/fitur/biodata/notifier/biodata_notifier.dart#L8), [biodata_model.dart#L5](lib/fitur/biodata/model/biodata_model.dart#L5)

- Status: Belum dikerjakan
- Masalah: State `TemaNotifier` menggunakan `AsyncNotifier<TemaEnum>` dengan tipe `TemaEnum` (enum) langsung, bukan state Freezed. Aturan proyek mewajibkan seluruh state menggunakan Freezed.
- Solusi: Pertimbangkan pembuatan state Freezed untuk tema (mis. `TemaState` dengan field `TemaEnum mode`) jika konsistensi dengan aturan boilerplate diperlukan; atau dokumentasikan pengecualian karena state tema sederhana. Verifikasi apakah aturan Freezed berlaku untuk state sederhana berbasis enum.
- Aturan dilanggar: `.agents/rules/global/optimasi_boilerplate.md` — poin 1 "State dan Model".
- File terkait: [tema_notifier.dart#L9](lib/fitur/tema/notifier/tema_notifier.dart#L9), [tema_notifier.dart#L10](lib/fitur/tema/notifier/tema_notifier.dart#L10)

## Rendah

Tidak ada temuan.

# UX

## Tinggi

- Status: Belum dikerjakan
- Masalah: `MaterialApp` pada `lib/app.dart` tidak mendeklarasikan `supportedLocales` maupun `localizationsDelegates`. Aplikasi Flutter wajib mengatur lokalisasi secara eksplisit agar teks sistem (dialog, date picker, toolbar pemilihan teks) mengikuti locale yang didukung. Selain itu, delegate lokalisasi khusus untuk `material_ui.MaterialLocalizations` (diperlukan oleh `adaptive_dialog`) juga tidak terdaftar, yang dapat menyebabkan `Null check operator used on a null value` saat dialog ditampilkan.
- Solusi: Tambahkan `supportedLocales: const [Locale('id', 'ID')]` dan `localizationsDelegates` yang mencakup `GlobalMaterialLocalizations.delegate`, `GlobalWidgetsLocalizations.delegate`, `GlobalCupertinoLocalizations.delegate`, dan `_MaterialUiLocalizationsDelegate()` pada `MaterialApp`. Impor `flutter_localizations` dari Flutter SDK dan buat kelas `_MaterialUiLocalizationsDelegate` dengan `isSupported => true`.
- Aturan dilanggar: `.agents/rules/global/aturan_lainnya.md` — poin 33 "Lokalisasi Aplikasi". `.agents/rules/proyek/aturan_khusus.md` — bagian "Registrasi Delegate Lokalisasi `material_ui` untuk `adaptive_dialog`".
- File terkait: [app.dart#L27](lib/app.dart#L27), [app.dart#L22](lib/app.dart#L22)

## Sedang

Tidak ada temuan.

## Rendah

- Status: Belum dikerjakan
- Masalah: Judul `AppBar` pada halaman Home (`lib/home.dart`), `DashboardScreen` (`lib/fitur/dashboard/screens/dashboard_screen.dart`), dan `FormBiodata` (`lib/fitur/biodata/screens/form_biodata.dart`) menampilkan teks "data" yang tidak informatif dan tidak bermakna bagi pengguna.
- Solusi: Ganti teks "data" dengan judul yang sesuai dan bermakna untuk setiap halaman (misalnya nama aplikasi atau judul halaman).
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — teks yang ditampilkan kepada pengguna seharusnya mudah dipahami dan bermakna (`.agents/rules/global/optimasi_ux.md` bagian 2 "Bahasa yang ditampilkan kepada pengguna").
- File terkait: [home.dart#L27](lib/home.dart#L27), [dashboard_screen.dart#L27](lib/fitur/dashboard/screens/dashboard_screen.dart#L27), [form_biodata.dart#L47](lib/fitur/biodata/screens/form_biodata.dart#L47)


- Status: Belum dikerjakan
- Masalah: `MaterialApp` pada `lib/app.dart` menggunakan `title: 'Flutter Demo'` yang merupakan nilai default template dan tidak mencerminkan nama aplikasi.
- Solusi: Ganti title dengan nama aplikasi yang sesuai (misalnya "Berhenti Merokok").
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — teks yang ditampilkan kepada pengguna seharusnya mudah dipahami dan bermakna (`.agents/rules/global/optimasi_ux.md` bagian 2).
- File terkait: [app.dart#L28](lib/app.dart#L28)

- Status: Belum dikerjakan
- Masalah: `InputTeks` pada `FormBiodata` menggunakan label `'Label'` dan hintText `'Hint'` yang generik dan tidak bermakna bagi pengguna.
- Solusi: Ganti label dan hint dengan teks yang sesuai dengan field (misalnya "Nama" dan "Masukkan nama").
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — teks yang ditampilkan kepada pengguna seharusnya mudah dipahami dan bermakna (`.agents/rules/global/optimasi_ux.md` bagian 2).
- File terkait: [form_biodata.dart#L52](lib/fitur/biodata/screens/form_biodata.dart#L52), [form_biodata.dart#L53](lib/fitur/biodata/screens/form_biodata.dart#L53)

- Status: Belum dikerjakan
- Masalah: `InputTeks` pada `FormBiodata` menerima `focusNode: null` dan `nextFocusNode: null` meskipun `_namaFocusNode` sudah dibuat, sehingga fokus tidak dikelola dengan benar.
- Solusi: Teruskan `_namaFocusNode` ke parameter `focusNode` (dan atur `nextFocusNode` jika ada field berikutnya) agar pengelolaan fokus konsisten.
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — pengelolaan resource dan interaksi yang benar (`.agents/rules/global/optimasi_bug_runtime.md` poin 7 "Dispose dan Pengelolaan Sumber Daya").
- File terkait: [form_biodata.dart#L14](lib/fitur/biodata/screens/form_biodata.dart#L14), [form_biodata.dart#L57](lib/fitur/biodata/screens/form_biodata.dart#L57), [form_biodata.dart#L58](lib/fitur/biodata/screens/form_biodata.dart#L58)

- Status: Belum dikerjakan
- Masalah: `LainnyaScreen` (`lib/lainnya_screen.dart`) masih berupa `Placeholder` tanpa konten yang bermakna, sehingga pengguna tidak memperoleh informasi atau tindakan yang berguna.
- Solusi: Tambahkan konten yang sesuai untuk layar Lainnya sesuai tujuan aplikasi.
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — tampilan harus dirancang agar pengguna dapat memahami informasi dan tindakan yang tersedia (`.agents/rules/global/optimasi_ux.md` bagian 3 "Kejelasan tampilan").
- File terkait: [lainnya_screen.dart#L8](lib/lainnya_screen.dart#L8)

# UI

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

- Status: Belum dikerjakan
- Masalah: Body `Scaffold` pada halaman Home tidak dibungkus dengan `SafeArea` dan tidak memiliki padding tepi layar. Konten dapat tertutup oleh notch, status bar, atau navigation bar, dan dapat menempel pada tepi layar.
- Solusi: Bungkus konten body dengan `SafeArea` dan tambahkan `Padding` dengan nilai yang sesuai pada lapisan container halaman, bukan pada widget reusable.
- Aturan dilanggar: `.agents/rules/global/optimasi_ux.md` — bagian 10 "Padding tepi layar" dan bagian 14 "SafeArea".
- File terkait: [home.dart#L26](lib/home.dart#L26), [home.dart#L28](lib/home.dart#L28), [home.dart#L29](lib/home.dart#L29)

- Status: Belum dikerjakan
- Masalah: Body `Scaffold` pada `FormBiodata` (`lib/fitur/biodata/screens/form_biodata.dart`) tidak dibungkus dengan `SafeArea` dan tidak memiliki padding tepi layar. Widget `InputTeks` dapat menempel pada tepi layar dan berpotensi tertutup oleh notch atau navigation bar.
- Solusi: Bungkus konten body dengan `SafeArea` dan tambahkan `Padding` dengan nilai yang sesuai pada lapisan container halaman, bukan pada widget reusable.
- Aturan dilanggar: `.agents/rules/global/optimasi_ux.md` — bagian 10 "Padding tepi layar" dan bagian 14 "SafeArea".
- File terkait: [form_biodata.dart#L29](lib/fitur/biodata/screens/form_biodata.dart#L29), [form_biodata.dart#L31](lib/fitur/biodata/screens/form_biodata.dart#L31), [form_biodata.dart#L33](lib/fitur/biodata/screens/form_biodata.dart#L33)

- Status: Belum dikerjakan
- Masalah: Body `Scaffold` pada `DashboardScreen` (`lib/fitur/dashboard/screens/dashboard_screen.dart`) tidak dibungkus dengan `SafeArea` dan tidak memiliki padding tepi layar. Konten dapat tertutup oleh notch, status bar, atau navigation bar, dan dapat menempel pada tepi layar.
- Solusi: Bungkus konten body dengan `SafeArea` dan tambahkan `Padding` dengan nilai yang sesuai pada lapisan container halaman, bukan pada widget reusable.
- Aturan dilanggar: `.agents/rules/global/optimasi_ux.md` — bagian 10 "Padding tepi layar" dan bagian 14 "SafeArea".
- File terkait: [dashboard_screen.dart#L26](lib/fitur/dashboard/screens/dashboard_screen.dart#L26), [dashboard_screen.dart#L28](lib/fitur/dashboard/screens/dashboard_screen.dart#L28), [dashboard_screen.dart#L29](lib/fitur/dashboard/screens/dashboard_screen.dart#L29)

- Status: Belum dikerjakan
- Masalah: Body `Scaffold` pada `LainnyaScreen` (`lib/lainnya_screen.dart`) tidak dibungkus dengan `SafeArea` dan tidak memiliki padding tepi layar.
- Solusi: Bungkus konten body dengan `SafeArea` dan tambahkan `Padding` dengan nilai yang sesuai pada lapisan container halaman, bukan pada widget reusable.
- Aturan dilanggar: `.agents/rules/global/optimasi_ux.md` — bagian 10 "Padding tepi layar" dan bagian 14 "SafeArea".
- File terkait: [lainnya_screen.dart#L7](lib/lainnya_screen.dart#L7), [lainnya_screen.dart#L9](lib/lainnya_screen.dart#L9)

- Status: Belum dikerjakan
- Masalah: `Text('Simpan')` pada `OutlinedButton` FormBiodata dan `Text('DashboardScreen')` pada body DashboardScreen tidak menggunakan konstruktor `const`, padahal nilai teksnya statis.
- Solusi: Tambahkan keyword `const` pada kedua widget `Text` untuk meningkatkan efisiensi rebuild.
- Atura dilanggar: Bukan pelanggaran aturan tertulis — praktik terbaik performa Flutter (linter `prefer_const_constructors`).
- File terkait: [dashboard_screen.dart#L28](lib/fitur/dashboard/screens/dashboard_screen.dart#L28), [form_biodata.dart#L60](lib/fitur/biodata/screens/form_biodata.dart#L60)

- Status: Belum dikerjakan
- Masalah: `FormBiodata` menggunakan `Column` langsung sebagai body `Scaffold` tanpa `SingleChildScrollView`/`ListView`, sehingga konten dapat terpotong pada layar kecil atau saat keyboard muncul.
- Solusi: Bungkus konten dengan `SingleChildScrollView` (atau gunakan `ListView`) dan pertahankan `SafeArea` + padding pada lapisan container.
- Atura dilanggar: Bukan pelanggaran aturan tertulis — penanganan overflow layout (`.agents/rules/global/optimasi_ui.md` bagian 3 "Penanganan Text Overflow" dan praktik layout).
- File terkait: [form_biodata.dart#L48](lib/fitur/biodata/screens/form_biodata.dart#L48), [form_biodata.dart#L62](lib/fitur/biodata/screens/form_biodata.dart#L62)
