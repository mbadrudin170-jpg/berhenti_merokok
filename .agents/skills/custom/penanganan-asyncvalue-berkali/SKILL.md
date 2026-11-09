---
name: penanganan-asyncvalue-berkali
description: Panduan penanganan beberapa provider AsyncValue pada satu layar - loading gabungan, error terpisah per provider, requireValue setelah loading/error ditangani.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "19f43e510b1478a43c5f0594efeef6f83b6c0299"
  model: "kilo-auto/free"
---

# Penanganan Beberapa Provider Asynchronous pada Satu Layar

Ketika layar memuat lebih dari satu provider async, tangani loading gabungan, error terpisah per provider, lalu requireValue.

## Aturan

1. Ketika layar memuat lebih dari satu provider asynchronous, tangani status `isLoading` gabungan (tampilkan indikator loading jika salah satu masih loading).
2. Tangani status `hasError` untuk setiap provider secara terpisah, dengan pesan error dan tombol retry yang memanggil `ref.refresh(provider)` yang sesuai.
3. Panggil `requireValue` pada masing-masing provider hanya setelah status loading dan error-nya ditangani.
4. Kondisi data tidak lengkap (mis. biodata null) tetap ditangani sebagai tampilan tersendiri dengan informasi dan call-to-action.

## Larangan

- Jangan memanggil `requireValue` pada provider yang masih loading atau error.
- Jangan menggabungkan penanganan error beberapa provider menjadi satu blok yang tidak jelas provider mana yang gagal.

## Contoh Benar

```dart
final biodataAsync = ref.watch(biodataProvider);
final impianAsync = ref.watch(impianProvider);

if (biodataAsync.isLoading || impianAsync.isLoading) {
  return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
if (biodataAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(biodataProvider));
}
if (impianAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(impianProvider));
}

final biodata = biodataAsync.requireValue;
final impianState = impianAsync.requireValue;
```

## Contoh Salah

```dart
// Memanggil requireValue tanpa menangani loading/error (berisiko crash)
final biodata = biodataAsync.requireValue;
final impianState = impianAsync.requireValue;
```

## Sumber Evaluasi

- Commit: `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/badge/screens/badge_screen.dart`