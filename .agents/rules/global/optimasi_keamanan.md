# Aturan Optimasi Keamanan

## Tujuan

Menetapkan standar penyimpanan dan perlindungan data agar informasi sensitif pengguna tetap aman, tidak terekspos melalui media yang tidak semestinya, serta dibersihkan ketika pengguna melakukan logout.

## Ketentuan

### 1. Penyimpanan Data Sensitif

Seluruh data sensitif wajib disimpan menggunakan paket `flutter_secure_storage` yang memanfaatkan mekanisme penyimpanan aman pada masing-masing platform:

- iOS: Keychain.
- Android: Keystore.

Data yang wajib menggunakan penyimpanan aman meliputi:

- PIN dan hash PIN.
- Salt.
- Access token.
- Refresh token.
- Kredensial.
- Kunci enkripsi.

Dilarang menyimpan data sensitif tersebut menggunakan `SharedPreferences`.

#### Contoh benar

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
await storage.write(key: 'access_token', value: token);
```

**Alasan:** Token disimpan pada secure storage, bukan SharedPreferences.

#### Contoh salah

```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('access_token', token);
```

**Kesalahan:** Menyimpan token pada SharedPreferences.

**Rujukan teknis:**
- `pubspec.yaml` — `flutter_secure_storage: ^11.2.0`, `shared_preferences: ^2.5.6`.
- `lib/fitur/kunci_aplikasi/service/kunci_aplikasi_service.dart`.
```

### 2. Penggunaan SharedPreferences

`SharedPreferences` hanya boleh digunakan untuk menyimpan preferensi pengguna yang tidak bersifat sensitif.

Contoh data yang diperbolehkan:

- Preferensi tema.
- Preferensi bahasa.
- Pilihan UI.
- Flag onboarding.

Jangan menyimpan kredensial, token, kunci enkripsi, maupun informasi sensitif lainnya menggunakan `SharedPreferences`.

#### Contoh benar

```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('is_onboarding_selesai', true);
```

**Alasan:** Flag onboarding bukan data sensitif.

#### Contoh salah

```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('refresh_token', refreshToken);
```

**Kesalahan:** Menyimpan refresh token pada SharedPreferences.

**Rujukan teknis:**
- `pubspec.yaml` — `shared_preferences: ^2.5.6`.
```

### 3. Perlindungan Data Sensitif

Data sensitif tidak boleh terekspos melalui clipboard maupun screenshot.

Ketentuan perlindungan:

- Gunakan `enableInteractiveSelection: false` pada field yang menampilkan atau menerima data sensitif untuk mencegah pengguna menyeleksi dan menyalin teks tersebut.
- Terapkan perlindungan screenshot pada layar yang menampilkan data sensitif agar informasi tersebut tidak dapat ditangkap melalui screenshot.

### 4. Pembersihan Data Saat Logout

Ketika pengguna melakukan logout, seluruh data sensitif wajib dihapus dari:

- Secure storage.
- Memory aplikasi.

Pastikan tidak ada data sensitif milik sesi sebelumnya yang masih tersimpan atau dapat diakses setelah proses logout.
