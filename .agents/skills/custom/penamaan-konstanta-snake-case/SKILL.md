---
name: penamaan-konstanta-snake-case
description: Panduan penamaan konstanta kolom database dengan snake_case lowercase yang harus sama persis dengan skema dan migrasi SQLite.
metadata:
  kategori: "custom"
  versi: "1.0.1"
  diperbarui: "Thu Nov 12 06:27:35 WIB 2026"
  sumber-terakhir: "perintah pengguna: perbarui skill index"
  model: "GPT-6"
---

# Penamaan Konstanta Kolom Database Menggunakan snake_case

Nilai konstanta kolom dalam `NamaKolom` wajib menggunakan huruf kecil dan underscore (`snake_case`) serta harus cocok persis dengan nama kolom pada skema dan migrasi SQLite.

## Aturan

1. Nilai konstanta nama kolom di `NamaKolom` wajib lowercase + underscore (snake_case).
2. Setiap konstanta wajib cocok persis (case-sensitive) dengan nama kolom pada `onCreate`, `onUpgrade`, dan query database.
3. Saat memperbaiki nama kolom, periksa konsistensi pemetaan model dan skema/migrasi agar aplikasi tidak membaca nama kolom yang berbeda.

## Larangan

- Jangan menggunakan huruf kapital pada nilai konstanta (mis. `'Tanggal_mulai_tapering'` alih-alih `'tanggal_mulai_tapering'`).
- Jangan menggunakan nilai konstanta yang berbeda dari nama kolom aktual pada skema atau migrasi.

## Contoh Benar

```dart
static const String tanggalMulaiTapering = 'tanggal_mulai_tapering';
static const String targetSmokeFreeHari = 'target_smoke_free_hari';
```

## Contoh Salah

```dart
static const String tanggalMulaiTapering = 'Tanggal_mulai_tapering';
```

## Sumber Evaluasi

- Commit: `c9f96b2debb9e678513229c5a4a68a062e3a8afc`
- File: `lib/shared/konstanta/nama_kolom.dart`
