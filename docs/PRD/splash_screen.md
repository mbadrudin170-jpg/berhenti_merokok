# MASALAH

1. saya ingin menampilkan splash screen setelah apk dibuka.
2. gunakan paket flutter_native_splash.
3. harus ada logo apk saya dan posisinya harus di tengah-tengah.

# SOLUSI

<!-- semua masalah diatas harus di berikan solusi -->

## Fitur yang Harus Dibuat

### Fitur 1: Tambahkan Dependency flutter_native_splash

- Masalah yang diatasi: gunakan paket flutter_native_splash.
- Solusi: Tambahkan `flutter_native_splash` ke `pubspec.yaml` (pada `dependencies` jika menggunakan `preserve()`/`remove()`, atau `dev_dependencies` jika tidak). Jalankan `flutter pub get`.

### Fitur 2: Konfigurasi Splash Screen

- Masalah yang diatasi: saya ingin menampilkan splash screen setelah apk dibuka.
- Solusi: Tambahkan konfigurasi `flutter_native_splash:` di `pubspec.yaml` (atau file terpisah `flutter_native_splash.yaml`) dengan `color`, `image` (PNG untuk 4x), serta section `android_12`. Siapkan asset gambar splash (misal `assets/splash.png`) dan daftarkan di `flutter: assets:`. Jalankan `dart run flutter_native_splash:create` untuk menghasilkan kode native Android/iOS/Web.

### Fitur 3: Inisialisasi Opsional (preserve/remove)

- Masalah yang diatasi: splash screen perlu ditahan saat inisialisasi aplikasi.
- Solusi: Jika splash perlu ditahan selama inisialisasi, gunakan `WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();` lalu `FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);` di `main()`, dan panggil `FlutterNativeSplash.remove();` setelah inisialisasi selesai. Jika tidak diperlukan, dependency boleh ditempatkan di `dev_dependencies`.

### Fitur 4: Verifikasi dan Pembersihan

- Masalah yang diatasi: memastikan splash screen tampil dengan benar di semua platform.
- Solusi: Jalankan `flutter clean` lalu `flutter pub get` dan rebuild aplikasi jika splash screen tidak terbarui. Untuk menghapus konfigurasi, jalankan `dart run flutter_native_splash:remove`.

### Fitur 5: Logo APK pada Splash Screen

- Masalah yang diatasi: harus ada logo apk saya nya.
- Solusi: Siapkan file logo aplikasi dalam format PNG (disarankan 4x, misal 1152x1152 px) dan daftarkan pada konfigurasi `flutter_native_splash:` melalui properti `image` (atau `image_dark` untuk dark mode) serta `android_12.image`. Jalankan `dart run flutter_native_splash:create` agar logo terpasang di splash native Android/iOS/Web. Pastikan asset logo juga terdaftar di `flutter: assets:` jika digunakan di dalam aplikasi. Posisi logo berada di tengah layar (perilaku default flutter_native_splash untuk properti `image`).

- Status implementasi: Konfigurasi warna dan logo splash sudah diterapkan di `pubspec.yaml`; native splash sudah di-regenerate (`flutter_native_splash:create`).
