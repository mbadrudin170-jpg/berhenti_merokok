---
name: penamaan-konstanta-snake-case
description: Panduan penamaan konstanta kolom database snake_case - NamaKolom value lowercase + underscore, konsisten dengan skema/migrasi SQLite.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "adc85b57da72eb4c000a29c324db7cdb15d388bc"
  model: "kilo-auto/free"
---

# Penamaan Konstanta Kolom Database Menggunakan snake_case

Nilai konstanta `NamaKolom` wajib lowercase + underscore (snake_case), konsisten dengan skema/migrasi SQLite.

## Aturan

1. Nilai konstanta nama kolom di `NamaKolom` wajib lowercase + underscore (snake_case), konsisten dengan nama kolom di `onCreate`/`onUpgrade`.
2. Setiap konstanta wajib cocok persis (case-sensitive) dengan nama kolom di database SQLite.

## Larangan

- Jangan huruf kapital di nilai konstanta (mis. `'Tanggal_mulai_tapering'` alih-alih `'tanggal_mulai_tapering'`).
- Jangan nilai konstanta berbeda dari nama kolom aktual di skema/migrasi.

## Contoh Benar

```dart
static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';
static const String targetSmokeFreeHari = 'target_smoke_free_hari';
```

## Contoh Salah

```dart
static const String tanggalMulaiTapering = 'Tanggal_mulai_tapering'; // kapital T, tidak konsisten
```

## Sumber Evaluasi

- Commit: `adc85b57da72eb4c000a29c324db7cdb15d388bc`
- File: `lib/shared/konstanta/nama_kolom.dart`