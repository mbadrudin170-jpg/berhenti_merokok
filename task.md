# Bug runtime

## Tinggi

Tidak ada temuan.

## Sedang

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
