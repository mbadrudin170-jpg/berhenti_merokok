---
name: visualisasi-progres-impian
description: Panduan visualisasi progres impian dan perayaan pencapaian - helper murni ImpianProgresHelper, guard divisi nol, SharedPreferences penandaan, AppToast sukses, saldo dari biodata.uangDihemat, widget bawaan, clamp rasio 0-1.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "c7337d1519d495d0ccd022fb18d63f72d443866a"
  model: "kilo-auto/free"
---

# Visualisasi Progres Impian dan Perayaan Pencapaian

Helper murni untuk rasio/sisa/tercapai, guard divisi nol, SharedPreferences penandaan perayaan, AppToast, saldo dari biodata.uangDihemat, widget bawaan, clamp rasio.

## Aturan

1. Perhitungan progres (rasio, sisa, tercapai) diekstrak ke helper murni (class static, private constructor, no BuildContext/provider).
2. Helper wajib guard divisi nol (target <= 0 → return 0.0/false).
3. Penandaan impian diraikan (perayaan sekali) disimpan di SharedPreferences (`impian_diraikan`), bukan variabel memori.
4. Impian baru tercapai → `AppToast.sukses` perayaan, penandaan via `unawaited()` non-blocking.
5. Layar progres impian wajib watch `biodataProvider` untuk `uangDihemat` sebagai saldo, bukan `totalJumlah` dari `ImpianState`.
6. Widget visual (`VisualTabunganImpian`) pakai komponen bawaan (Stack, LinearProgressIndicator, Icon), no aset baru.
7. Rasio clamp 0.0–1.0 sebelum ke LinearProgressIndicator.

## Larangan

- Jangan hitung rasio/sisa/tercapai inline di layar dengan formula berbeda.
- Jangan pakai `totalJumlah` `ImpianState` sebagai saldo.
- Jangan toast perayaan berulang untuk impian sama (pakai SharedPreferences penandaan).
- Jangan tambah aset gambar/Lottie untuk visual progres.

## Sumber Evaluasi

- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File: `lib/fitur/impian/helper/impian_progres_helper.dart`, `lib/fitur/impian/screens/detail_impian_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/widget/visual_tabungan_impian.dart`