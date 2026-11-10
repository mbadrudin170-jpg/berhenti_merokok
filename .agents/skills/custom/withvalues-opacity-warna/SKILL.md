---
name: withvalues-opacity-warna
description: Indeks aturan withValues untuk opacity warna di Flutter - merujuk ke skill 'gaya' untuk panduan lengkap styling. Wajib menggunakan warna.withValues(alpha: ...) untuk opacity, DILARANG menggunakan warna.withOpacity() yang deprecated sejak Flutter 3.47+.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Indeks: withValues Opacity Warna

**Skill ini hanyalah indeks.** Gunakan skill **`gaya`** untuk panduan lengkap styling termasuk withValues opacity, warna tema vs hardcode, chip status pencapaian, dan loading overlay EasyLoading.

## Cakupan yang Di-Cover

- Package: `package:flutter` (class `Color`, `ThemeData`, `ColorScheme`, `AlwaysStoppedAnimation`)
- Class: `Color`, `ThemeData`, `ColorScheme`, `AlwaysStoppedAnimation`
- Method: `Color.withValues(alpha:)`, `Color.withOpacity()`, `Theme.of(context)`

## Aturan

1. Wajib menggunakan `warna.withValues(alpha: ...)` untuk mengatur opacity warna.
2. DILARANG menggunakan `warna.withOpacity(...)` karena deprecated sejak Flutter 3.47+.
3. Konsisten menggunakan `withValues` di seluruh widget, tidak boleh bercampur dengan `withOpacity`.
4. Untuk panduan lengkap (warna tema vs hardcode, chip status, loading overlay), lihat skill `gaya`.

## Larangan

- DILARANG `withOpacity()` → gunakan `withValues(alpha:)`.
- DILARANG mencampur `withValues` dan `withOpacity` dalam satu file/widget.

## Contoh Benar

```dart
// BENAR: withValues untuk opacity
Container(
  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
)
LinearProgressIndicator(
  backgroundColor: warnaProgres.withValues(alpha: 0.2),
  valueColor: AlwaysStoppedAnimation(warnaProgres),
)
Colors.black.withValues(alpha: 0.5), // Overlay modal
```

## Contoh Salah

```dart
// DILARANG: withOpacity deprecated
warna.withOpacity(0.2)

// DILARANG: Campur withValues dan withOpacity
Container(color: warnaA.withValues(alpha: 0.1))
Container(color: warnaB.withOpacity(0.2)) // SALAH! Bercampur dengan withValues di atas
```

## Sumber Evaluasi

- File: `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/fitur/impian/widget/visual_tabungan_impian.dart`
- Class terkait: `Color`, `ThemeData`, `ColorScheme`, `AlwaysStoppedAnimation`
- Commit rujukan: `3b67d309` — `warna.withValues(alpha: 0.2)` di `SosCravingScreen`; `c7337d1` — `VisualTabunganImpian` warna semantic
- Skill lengkap: `gaya`