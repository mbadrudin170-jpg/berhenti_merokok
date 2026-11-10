---
name: bug-runtime
description: Indeks pencegahan bug runtime di Flutter - merujuk ke skill spesifik untuk type promotion null safety, normalisasi tanggal, AsyncValue handling, validasi form, error handling unawaited, validasi platform dan izin, tipe exception khusus, dan guard pembagian nol.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "be04199e5b44537ee1052a3815f5af8518308148"
  model: "kilo-auto/free"
---

# Indeks Pencegahan Bug Runtime

Skill ini berfungsi sebagai indeks/ringkasan yang merujuk ke skill spesifik untuk setiap topik pencegahan bug runtime. Jangan menduplikasi isi skill spesifik di sini.

## Cakupan yang Di-Cover

- Package: `package:flutter_riverpod` (class `AsyncValue`, `ref`, `ConsumerWidget`), `package:flutter` (class `DateTime`, `Timer`)
- Class: `AsyncValue`, `DateTime`, `Timer`, `Exception`, `ImpianProgresHelper`, `BiodataModel`
- Method: `AsyncValue.requireValue()`, `AsyncValue.asData?.value`, `ref.watch()`, `ref.refresh()`, `DateTime.normalize()`, `Timer.periodic()`, `Timer.cancel()`

## Aturan

1. Untuk implementasi detail, buka skill spesifik yang tercantum di tabel di bawah.
2. Untuk code review, periksa apakah kode mengikuti aturan dari skill spesifik yang relevan.
3. Untuk onboarding, gunakan indeks ini untuk memahami lanskap pencegahan bug runtime, lalu pelajari setiap skill spesifik.

## Larangan

- JANGAN menyalin isi skill spesifik ke skill indeks ini.
- JANGAN menambahkan contoh kode detail di skill indeks ini (contoh ada di skill spesifik).
- JANGAN membuat aturan baru di skill indeks ini yang seharusnya ada di skill spesifik.

## Contoh Benar

```dart
// Rujuk ke skill spesifik untuk implementasi detail
// type promotion → lihat skill `type-promotion-null-safety`
final tanggalLahir = biodata?.tanggalLahir;
if (tanggalLahir == null) {
  return 'Belum dipilih';
} // type promotion berlaku di sini

// normalisasi tanggal → lihat skill `normalisasi-tanggal`
final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);

// AsyncValue handling → lihat skill `penanganan-async-data-kosong`
if (dataAsync.isLoading) return const _LoadingView();
if (dataAsync.hasError) return _ErrorRetry(onRetry: () => ref.refresh(provider));
final data = dataAsync.requireValue;
```

## Contoh Salah

```dart
// Jangan menyalin isi skill spesifik ke sini
// Jangan menambahkan contoh kode detail di skill indeks

// SALAH: requireValue tanpa handle loading/error
final state = ref.watch(provider).requireValue;

// SALAH: Tanggal tanpa normalisasi
final totalHari = DateTime.now().difference(tanggalBerhenti).inDays + 1;
```

## Sumber Evaluasi

- File: `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`, `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/badge/screens/badge_screen.dart`
- Class terkait: `AsyncValue`, `DateTime`, `Timer`, `ImpianProgresHelper`
- Commit rujukan: `1e7b71e` — Type promotion di `biodata_screen.dart`; `6fd979fd` — Normalisasi tanggal di `KalenderSmokeFreeScreen`; `02aa6b29` — Normalisasi tanggal di `PemulihanKesehatanScreen`, `DashboardScreen`; `19f43e5` — Multiple AsyncValue di `BadgeScreen`; `3b67d309` — Async data handling di `DiaryCravingScreen`, `PemulihanKesehatanScreen`; `c7337d1` — Guard pembagian di `ImpianProgresHelper`
