---
name: withvalues-opacity-warna
description: Indeks - merujuk ke skill 'gaya' untuk aturan withValues opacity. Use 'gaya' skill for complete styling guidance including withValues, theme colors, chip status, loading overlay.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Indeks: withValues Opacity Warna

**Skill ini hanyalah indeks.** Gunakan skill **`gaya`** untuk panduan lengkap styling termasuk:

| Topik                                                                                              | Lokasi di skill `gaya`           |
| -------------------------------------------------------------------------------------------------- | -------------------------------- |
| **withValues opacity** (WAJIB, `withOpacity` deprecated)                                           | Bagian 1: Opacity Warna          |
| **Warna tema vs Hardcode** (ColorScheme untuk UI umum, hardcode hanya untuk brand/status semantic) | Bagian 2: Warna Tema vs Hardcode |
| **Chip Status Pencapaian** (hijau/primary dengan backgroundColor semantic)                         | Bagian 3: Chip Status Pencapaian |
| **Loading Overlay (EasyLoading)** (unawaited + catchError, maskType.black)                         | Bagian 4: Loading Overlay        |

## Ringkasan Aturan withValues (dari `gaya`)

- **WAJIB** gunakan `warna.withValues(alpha: ...)` untuk mengatur opacity.
- **DILARANG** gunakan `warna.withOpacity(...)` (deprecated sejak Flutter 3.47+).
- Konsisten di seluruh widget.

```dart
// BENAR
Container(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1))
LinearProgressIndicator(backgroundColor: warnaProgres.withValues(alpha: 0.2))
Colors.black.withValues(alpha: 0.5) // Overlay modal

// SALAH (deprecated)
warna.withOpacity(0.2)
```

## Referensi Commit

- `3b67d309` — `warna.withValues(alpha: 0.2)` di `SosCravingScreen`
- `c7337d1` — `VisualTabunganImpian` warna semantic

## Referensi Aturan Sumber

- `aturan_bersama.md` — withValues Opacity
- `aturan_khusus.md` — Standar Notifikasi, Visualisasi Progres
- `optimasi_ui.md` — Penggunaan Warna dan Tema
