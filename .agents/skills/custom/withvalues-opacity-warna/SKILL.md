---
name: withvalues-opacity-warna
description: Panduan menggunakan withValues(alpha: ...) alih-alih withOpacity(...) untuk mengatur opacity warna sesuai API Flutter terpasang.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Penggunaan `withValues` untuk Opacity Warna

Gunakan `withValues(alpha: ...)` alih-alih `withOpacity(...)` untuk mengatur opacity warna, sesuai API Flutter terpasang.

## Aturan

1. Gunakan `withValues(alpha: ...)` alih-alih `withOpacity(...)` untuk mengatur opacity warna, sesuai API Flutter terpasang (3.47+).
2. Pertahankan konsistensi penggunaan pada seluruh widget.

## Contoh Benar

```dart
warna.withValues(alpha: 0.2)
```

## Contoh Salah

```dart
warna.withOpacity(0.2)
```

## Sumber Evaluasi

- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/sos_craving/screens/sos_craving_screen.dart`