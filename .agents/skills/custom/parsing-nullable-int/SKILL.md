---
name: parsing-nullable-int
description: Panduan parsing field nullable integer dari database memakai parseIntOrNull agar null tetap null dan tidak berubah menjadi nol.
metadata:
  kategori: "custom"
  versi: "1.0.1"
  commit-terakhir: "c9f96b2debb9e678513229c5a4a68a062e3a8afc"
  model: "GPT-6"
---

# Parsing Field Nullable Integer dari Database Menggunakan parseIntOrNull

Field `int?` yang dibaca dari database wajib menggunakan `ParserUtil.parseIntOrNull(...)`. Nilai null harus tetap null, bukan berubah menjadi 0.

## Aturan

1. Field nullable `int?` dari database wajib di-parse menggunakan `ParserUtil.parseIntOrNull(...)`, bukan `ParserUtil.parseInt(...)` yang menggunakan nilai default 0.
2. Pertahankan null dari database di model agar aplikasi dapat membedakan kondisi "belum diatur" dengan nilai nol yang memang ditetapkan.
3. Gunakan `parseInt` dengan default 0 hanya untuk field non-nullable ketika nol memang nilai bisnis yang valid.
4. Terapkan aturan ini pada seluruh field nullable yang dipetakan dalam factory model dari baris SQLite.

## Larangan

- Jangan menggunakan `ParserUtil.parseInt(row[kolom])` untuk field `int?` yang null berarti belum diatur.
- Jangan mengubah null menjadi 0 tanpa keputusan dan validasi bisnis yang jelas.

## Contoh Benar

```dart
targetSmokeFreeHari: ParserUtil.parseIntOrNull(
  row[NamaKolom.targetSmokeFreeHari],
),
```

## Contoh Salah

```dart
targetSmokeFreeHari: ParserUtil.parseInt(
  row[NamaKolom.targetSmokeFreeHari],
), // null berubah menjadi 0
```

## Sumber Evaluasi

- Commit: `c9f96b2debb9e678513229c5a4a68a062e3a8afc`
- File: `lib/fitur/biodata/model/biodata_model.dart`
