---
name: validasi-tapering
description: Panduan validasi dan perhitungan mode berhenti bertahap (tapering) - enum ModeBerhenti, penurunanPerMinggu positif, tanggalMulaiTapering, normalisasi tanggal, targetRokokHariIni di ekstensi.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "ceacc6a1c388b24b7647a37ccde411d6c85ee01c"
  model: "kilo-auto/free"
---

# Validasi dan Perhitungan Mode Berhenti Bertahap (Tapering)

Mode seketika pakai jumlahRokokPerHari. Mode bertahap wajib penurunanPerMinggu > 0, tanggalMulaiTapering valid, targetRokokHariIni di ekstensi.

## Aturan

1. `ModeBerhenti.seketika` pakai jumlahRokokPerHari sebagai target, tanpa penurunan.
2. `ModeBerhenti.bertahap` wajib `penurunanPerMinggu` bilangan bulat positif.
3. Input penurunan mingguan tidak boleh kosong, nol, atau negatif saat mode bertahap.
4. Tanggal mulai tapering diinisialisasi saat aktifkan mode bertahap, divalidasi sebelum simpan.
5. Jika tanggal mulai di masa depan, minggu berlalu = 0 sampai tanggal tercapai.
6. Hitung minggu pakai tanggal dinormalisasi (sesuai aturan normalisasi-tanggal).
7. Target: `jumlahRokokPerHari - (penurunanPerMinggu * mingguBerlalu)`.
8. Target tidak boleh < 0 (clamp ke 0).
9. Target mode seketika = jumlahRokokPerHari.
10. Jangan duplikasi formula di layar. Pakai getter `targetRokokHariIni` dari ekstensi `BiodataModelPerhitungan`.
11. Pertahankan kompatibilitas data lama (fallback di fromSqflite).

## Larangan

- Jangan duplikasi formula target di layar.
- Jangan simpan mode bertahap tanpa penurunanPerMinggu > 0 dan tanggal mulai valid.
- Jangan biarkan target negatif.
- Jangan hitung minggu dari tanggal tanpa normalisasi.

## Sumber Evaluasi

- Commit: `ceacc6a1c388b24b7647a37ccde411d6c85ee01c`
- File: `lib/fitur/biodata/enum/mode_berhenti.dart`, `lib/fitur/biodata/model/biodata_model.dart`, `lib/fitur/biodata/screens/form_biodata.dart`, `lib/shared/db/sqflite/sqflite.dart`, `lib/shared/konstanta/nama_kolom.dart`