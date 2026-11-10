---
name: ekstraksi-perhitungan-turunan
description: Panduan ekstraksi logika perhitungan turunan yang diduplikasi ke ekstensi model atau helper murni agar hanya ditulis sekali dan konsisten di seluruh layar.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "1788a1ce22765ac0614eb3e3ed9e9f164aa49572"
  model: "kilo-auto/free"
---

# Ekstraksi Logika Perhitungan Turunan yang Diduplikasi

Perhitungan turunan yang sama di lebih dari satu layar wajib diekstrak ke satu lokasi bersama (ekstensi model, helper murni, atau utilitas).

## Aturan

1. Apabila perhitungan turunan yang sama digunakan di lebih dari satu layar, ekstrak ke satu lokasi bersama (ekstensi pada model, helper murni, atau utilitas) agar logika hanya ditulis sekali.
2. Konsumen (layar/widget) wajib menggunakan hasil dari lokasi bersama, bukan menghitung ulang secara inline.
3. Helper murni wajib menerima parameter primitif dan tidak bergantung pada `BuildContext` atau provider.
4. Guard pembagian dengan nol wajib diterapkan pada perhitungan yang melakukan pembagian.

## Larangan

- Jangan membuat method perhitungan inline (mis. `_hitungUangDihemat`) di layar yang menggandakan logika yang sudah ada di ekstensi/helper.
- Jangan meletakkan perhitungan turunan di provider (perhitungan bergantung pada waktu saat ini dan lebih tepat di lapisan model).
- Jangan membiarkan formula berbeda antar layar untuk besaran yang sama.

## Contoh Benar

```dart
// Ekstensi pada model (didefinisikan sekali)
extension BiodataModelPerhitungan on BiodataModel {
  double get uangDihemat {
    if (batangPerBungkus == 0) return 0; // Guard pembagian dengan nol
    return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
  }
}

// Konsumsi di layar
final uangDihemat = biodata?.uangDihemat ?? 0;
```

## Contoh Salah

```dart
// Duplikasi perhitungan inline di layar
double _hitungUangDihemat(BiodataModel? biodata) {
  if (biodata == null) return 0;
  // ... logika duplikat
}
```

## Sumber Evaluasi

- Commit: `19f43e510b1478a43c5f0594efeef6f83b6c0299`
- File: `lib/fitur/biodata/model/biodata_model.dart`, `lib/fitur/badge/helper/badge_helper.dart`, `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/badge/screens/badge_screen.dart`