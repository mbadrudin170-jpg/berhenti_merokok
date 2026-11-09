---
name: normalisasi-tanggal
description: Panduan normalisasi DateTime ke komponen tanggal saja (tahun, bulan, hari) sebelum perbandingan dan perhitungan berbasis hari, plus klamping nilai negatif ke nol.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "6fd979fd9e8296bc7d9c40e9037870faef9c846a"
  model: "kilo-auto/free"
---

# Normalisasi Tanggal untuk Perbandingan dan Perhitungan Berbasis Hari

Normalisasi `DateTime` ke komponen tanggal saja sebelum membandingkan atau menghitung selisih hari, dan klamping hasil negatif ke nol.

## Aturan

1. Sebelum membandingkan atau menghitung selisih hari antara dua tanggal, normalisasi nilai `DateTime` ke komponen tanggal saja (tahun, bulan, hari) dengan membuang komponen waktu.
2. Gunakan `DateTime(tanggal.year, tanggal.month, tanggal.day)` untuk memperoleh representasi tanggal tanpa waktu.
3. Saat menghitung selisih hari dengan `difference(...).inDays`, pastikan kedua operand sudah dinormalisasi agar hasil tidak terpengaruh oleh jam/menit/detik.
4. Hasil perhitungan durasi atau jumlah hari yang dapat bernilai negatif wajib diklem (clamp) ke nol apabila nilai negatif tidak bermakna dalam konteks (mis. "hari smoke-free" tidak boleh negatif).
5. Gunakan `isBefore`/`isAfter` pada nilai yang sudah dinormalisasi untuk menentukan rentang tanggal, agar batas hari konsisten.

## Larangan

- Jangan membandingkan `DateTime.now()` (yang menyertakan waktu) langsung dengan tanggal yang dinormalisasi tanpa penyesuaian.
- Jangan membiarkan hasil perhitungan hari bernilai negatif pada konteks yang mensyaratkan nilai non-negatif.
- Jangan menggunakan komponen waktu dalam penentuan status hari (smoke-free / belum) pada kalender.

## Contoh Benar

```dart
final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
final tanggalBerhentiDate = DateTime(
  tanggalBerhenti.year,
  tanggalBerhenti.month,
  tanggalBerhenti.day,
);
final totalHari = hariIniDate.difference(tanggalBerhentiDate).inDays + 1;
final totalAman = totalHari < 0 ? 0 : totalHari;

// Klamping durasi negatif ke nol.
final durasi = DateTime.now().difference(tanggalBerhenti);
final aman = durasi.isNegative ? Duration.zero : durasi;
```

## Contoh Salah

```dart
// Membandingkan DateTime.now() (dengan waktu) langsung dengan tanggal berhenti.
final totalHari = DateTime.now().difference(tanggalBerhenti).inDays + 1;
// Bisa salah satu hari karena komponen waktu.
```

## Sumber Evaluasi

- Commit: `6fd979fd9e8296bc7d9c40e9037870faef9c846a`, `02aa6b29b0669a4f5bf21651b09b43552f65d6f8`
- File: `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`, `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`