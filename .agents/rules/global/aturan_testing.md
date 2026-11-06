# Aturan Testing

## 1. Cakupan Pengujian

- Setiap method `public` yang terdapat di dalam file `state` wajib memiliki pengujian.
- Pastikan seluruh method `public` pada file tersebut tercakup dalam file test yang sesuai.

## 2. Paket Testing dan Mocking

- Gunakan paket `mockito` untuk kebutuhan testing dan mocking.
- Jangan menggunakan paket mocking lain sebagai pengganti `mockito`.

#### Contoh benar

```dart
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([BaseOpSqflite])
void main() {}
```

**Alasan:** Mocking menggunakan paket `mockito` sesuai standar proyek.

#### Contoh salah

```dart
import 'package:mocktail/mocktail.dart';

class MockDb extends Mock implements BaseOpSqflite {}
```

**Kesalahan:** Menggunakan paket mocking lain padahal proyek mewajibkan `mockito`.

**Rujukan teknis:**
- `pubspec.yaml` — dependensi pengembangan testing.
- `test/*_state_test.dart` — pola pengujian state proyek.

## 3. Struktur File Test

Struktur dan penamaan file test wajib konsisten dengan konvensi proyek.

Pada proyek ini, file test ditempatkan secara datar di folder `test/` dengan penamaan `<nama_fitur>_state_test.dart`, bukan dengan menyalin struktur folder `lib/fitur/...`.

**Contoh:**

Jika file sumber berada di:

```text
lib/fitur/bahan_bakar/state/bahan_bakar_state.dart
```

Maka file test wajib berada di:

```text
test/bahan_bakar_state_test.dart
```

Pastikan penamaan file test menggunakan akhiran `_state_test.dart` dan sesuai dengan nama fitur yang diuji. Jangan membuat struktur folder `test/fitur/...` yang tidak sesuai dengan konvensi proyek.

## 4. Penggunaan Dummy Data

- Setiap pengujian `state` wajib menggunakan dummy data yang tersedia di folder `dummy`.
- Jangan membuat data pengujian secara manual apabila dummy data yang sesuai sudah tersedia.
- Gunakan dummy data sebagai sumber data ketika membuat instance state dalam pengujian.

**Contoh:**

```dart
final state = BahanBakarState(
  listBahanBakar: dummyBahanBakar,
);
```
