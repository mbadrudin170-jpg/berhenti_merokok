# Aturan Riverpod

## 1. Penggunaan riverpod_generator

Setiap provider dan notifier wajib dibuat menggunakan `riverpod_generator`.

#### Contoh benar

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pengguna_provider.g.dart';

@riverpod
Future<List<Pengguna>> daftarPengguna(Ref ref) async {
  return ref.watch(repositoryProvider).ambilSemua();
}
```

**Alasan:** Provider dibuat dengan anotasi `@riverpod` dan file `.g.dart` dihasilkan oleh generator.

#### Contoh salah

```dart
final daftarPenggunaProvider = FutureProvider<List<Pengguna>>((ref) async {
  return ref.watch(repositoryProvider).ambilSemua();
});
```

**Kesalahan:** Provider dibuat manual dengan `FutureProvider`, bukan melalui `riverpod_generator`.

**Rujukan teknis:**
- `pubspec.yaml` — `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`.
- `lib/fitur/*/provider/*.dart` dan `*.g.dart`.

## 2. Pengaturan siklus hidup state

- Gunakan `@Riverpod(keepAlive: true)` untuk state yang perlu dipertahankan dan tidak boleh otomatis dihapus ketika tidak lagi digunakan.
- Gunakan `@riverpod` untuk state yang tidak perlu dipertahankan sehingga provider menggunakan mekanisme auto-dispose.

## 3. Penggunaan `ref.watch`

`ref.watch` hanya boleh digunakan di dalam `build`, notifier, dan provider.

- **Di dalam `build`:** tangani status `AsyncValue` dengan urutan pemeriksaan berikut:
  1. Periksa `.isLoading` terlebih dahulu.
  2. Setelah itu, periksa `.hasError`.
  3. Jika kedua kondisi tersebut tidak terpenuhi, ambil data menggunakan `.requireValue`.
- **Di dalam notifier dan provider:** jika sumber data bersifat asynchronous, gunakan `ref.watch(provider.future)`.
- **Larangan:** saat menggunakan `ref.watch`, jangan mengambil nilai menggunakan `.value` atau `.valueOrNull`.

## 4. Penggunaan `ref.read`

- Jika provider yang dibaca menghasilkan data asynchronous dan nilai datanya diperlukan, gunakan `.future` serta `await`.

  Contoh:

  ```dart
  final state = await ref.read(provider.future);
  ```

- Jika fungsi notifier mengembalikan `Future`, panggil fungsi tersebut menggunakan `await`.

  Contoh:

  ```dart
  await ref.read(provider).hapus();
  ```

- Untuk mengambil hasil provider asynchronous di luar `build`, gunakan `.future`. Jangan menangani status `.isLoading` dan `.hasError` secara manual.

  Contoh:

  ```dart
  final data = await ref.read(provider.future);
  ```

## 5. Penggunaan `ref.listen`

`ref.listen` hanya boleh digunakan di dalam `build`.

- Gunakan `.value` untuk mengambil nilai dari `previous` dan `next`.
- Untuk nilai `previous`, gunakan `previous.value` atau `previous?.value`, sesuai dengan nullability variabelnya.
- Untuk nilai `next`, periksa `.isLoading` dan `.hasError` sebelum mengakses atau memproses `.value`.

## 6. Penggunaan `ref.listenManual`

Gunakan `ref.listenManual` hanya di luar `build`. Sebelum menggunakannya, periksa cara penggunaan dan ketentuannya pada source code SDK Riverpod.

## 7. Pemasangan ProviderScope

Setiap proyek yang menggunakan Riverpod wajib memasang scope Riverpod di `main.dart`.

- Gunakan `ProviderScope` untuk penggunaan normal.
- Gunakan `UncontrolledProviderScope` apabila proyek mengelola `ProviderContainer` secara manual.

## 8. Penggunaan `ref.refresh`

Gunakan `ref.refresh(provider)` untuk langsung mengevaluasi ulang provider dan memperoleh hasil evaluasi terbarunya.

- Ketika UI sedang menampilkan error dan provider perlu dicoba kembali, gunakan `ref.refresh`, bukan `ref.invalidate`.
- Gunakan pola berikut:

  ```dart
  final _ = ref.refresh(provider);
  ```

## 9. Optimistic update pada notifier

Setiap optimistic update di dalam notifier wajib mengikuti urutan berikut:

1. Perbarui state terlebih dahulu.
2. Jalankan operasi ke database.
3. Jika operasi database menghasilkan `Exception`, kembalikan state ke data sebelumnya (_rollback_), kemudian teruskan kembali exception menggunakan `rethrow`.

Contoh:

```dart
state = AsyncValue.data(listBaru);

try {
  await ref.read(baseOpSqfliteProvider).tambah(...);
} on Exception {
  state = AsyncValue.data(dataLama);
  rethrow;
}
```

## 10. Pembersihan resource dengan `ref.onDispose`

Gunakan `ref.onDispose(() { ... })` di dalam provider untuk membersihkan resource yang dibuat oleh provider tersebut, seperti controller, subscription, dan timer.

## 11. Membatasi rebuild dengan `select`

Untuk membatasi rebuild UI, gunakan `ref.watch(provider.select((state) => state.field))` ketika UI hanya membutuhkan sebagian state. Dengan demikian, UI hanya bergantung pada field yang dipilih.
