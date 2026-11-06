# Bug runtime

## Tinggi

Tidak ada temuan.

## Sedang

- Status: Selesai
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
- Masalah: State `TemaNotifier` menggunakan `AsyncNotifier<TemaEnum>` dengan tipe `TemaEnum` (enum) langsung, bukan state Freezed. Aturan proyek mewajibkan seluruh state menggunakan Freezed.
- Solusi: Pertimbangkan pembuatan state Freezed untuk tema (mis. `TemaState` dengan field `TemaEnum mode`) jika konsistensi dengan aturan boilerplate diperlukan; atau dokumentasikan pengecualian karena state tema sederhana. Verifikasi apakah aturan Freezed berlaku untuk state sederhana berbasis enum.
- Aturan dilanggar: `.agents/rules/global/optimasi_boilerplate.md` — poin 1 "State dan Model".
- File terkait: [tema_notifier.dart#L9](lib/fitur/tema/notifier/tema_notifier.dart#L9), [tema_notifier.dart#L10](lib/fitur/tema/notifier/tema_notifier.dart#L10)

## Rendah

Tidak ada temuan.

# UX

## Tinggi

Tidak ada temuan.

## Sedang

Tidak ada temuan.

## Rendah

- Status: Belum dikerjakan
- Masalah: Judul `AppBar` pada halaman Home (`lib/home.dart`) dan `DashboardScreen` (`lib/fitur/dashboard/screens/dashboard_screen.dart`) menampilkan teks "data" yang tidak informatif dan tidak bermakna bagi pengguna.
- Solusi: Ganti teks "data" dengan judul yang sesuai dan bermakna untuk setiap halaman (misalnya nama aplikasi atau judul halaman).
- Aturan dilanggar: Bukan pelanggaran aturan tertulis — teks yang ditampilkan kepada pengguna seharusnya mudah dipahami dan bermakna (`.agents/rules/global/optimasi_ux.md` bagian 2 "Bahasa yang ditampilkan kepada pengguna").
- File terkait: [home.dart#L27](lib/home.dart#L27), [dashboard_screen.dart#L27](lib/fitur/dashboard/screens/dashboard_screen.dart#L27)

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
- Masalah: `Text('DashboardScreen')` pada body DashboardScreen tidak menggunakan konstruktor `const`, padahal nilai teksnya statis.
- Solusi: Tambahkan keyword `const` pada widget `Text` untuk meningkatkan efisiensi rebuild.
- Atura dilanggar: Bukan pelanggaran aturan tertulis — praktik terbaik performa Flutter (linter `prefer_const_constructors`).
- File terkait: [dashboard_screen.dart#L28](lib/fitur/dashboard/screens/dashboard_screen.dart#L28)
