---
name: parsing-nullable-int
description: Panduan parsing field nullable integer dari database pakai parseIntOrNull - int? dari DB wajib parseIntOrNull, null tetap null, bukan 0.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "adc85b57da72eb4c000a29c324db7cdb15d388bc"
  model: "kilo-auto/free"
---

# Parsing Field Nullable Integer dari Database Menggunakan parseIntOrNull

Field `int?` dari DB wajib `ParserUtil.parseIntOrNull(...)`, null tetap null, bukan 0. Bisa pakai `parseInt` default 0 hanya jika field non-nullable dan 0 valid bisnis.

## Aturan

1. Field nullable `int?` dari database wajib di-parse pakai `ParserUtil.parseIntOrNull(...)` (return null untuk null), bukan `ParserUtil.parseInt(...)` default 0.
2. Null dari DB harus tetap null di model, bukan jadi 0, agar bisa bedakan "belum diatur" vs "diatur ke nol".

## Larangan

- Jangan `ParserUtil.parseInt(row[kolom])` (default 0) untuk `int?` yang null artinya "belum diset".
- Jangan ganti parsing null jadi 0 tanpa validasi bisnis.

## Pengecualian

- BOLEH `parseInt` default 0 jika field bukan nullable dan 0 valid bisnis.

## Contoh Benar

```dart
targetSmokeFreeHari: ParserUtil.parseIntOrNull(row[NamaKolom.targetSmokeFreeHari]),
```

## Contoh Salah

```dart
targetSmokeFreeHari: ParserUtil.parseInt(row[NamaKolom.targetSmokeFreeHari]), // null jadi 0
```

## Sumber Evaluasi

- Commit: `adc85b57da72eb4c000a29c324db7cdb15d388bc`
- File: `lib/fitur/biodata/model/biodata_model.dart`