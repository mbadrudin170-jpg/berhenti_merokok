---
name: penanganan-error-unawaited
description: Panduan penanganan error pada Future yang dilepas (unawaited) - wajib catchError dengan logging L.e, jangan biarkan unhandled.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "fd6b45afbb4064038b4bc1131aaf6125dae538ec"
  model: "kilo-auto/free"
---

# Penanganan Error pada Future yang Dilepas (unawaited)

Future yang dilepas dengan `unawaited()` wajib memiliki penanganan error via `catchError()` yang mencatat error melalui logger proyek.

## Aturan

1. Future yang dilepas dengan `unawaited()` dan berpotensi gagal wajib memiliki penanganan error melalui `catchError(...)` atau `try/catch` yang mencatat error melalui logger proyek (`L.e`).
2. Jangan melepas `unawaited(...)` tanpa penanganan error hanya untuk menghilangkan peringatan analyzer.
3. Jangan mengandalkan keberhasilan implisit pada Future yang dilepas.

## Larangan

- Jangan memanggil `unawaited(Nav.to(...))`, `unawaited(EasyLoading.show(...))`, atau sejenisnya tanpa `.catchError(...)`/`try/catch`.
- Jangan mengabaikan error pada Future yang dilepas.

## Contoh Benar

```dart
unawaited(
  Nav.to(context, const HalamanLain()).catchError((Object e, StackTrace s) {
    L.e('Gagal navigasi: $e $s');
    return null;
  }),
);
```

## Contoh Salah

```dart
unawaited(Nav.to(context, const HalamanLain()));
```

## Sumber Evaluasi

- Commit: `fd6b45afbb4064038b4bc1131aaf6125dae538ec`, `d80e637179ed969c19c97f2cc2ced3d3d5fa2d12`
- File: `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/biodata/screens/form_biodata.dart`