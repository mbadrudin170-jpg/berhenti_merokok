---
name: visualisasi-progres-impian
description: Panduan visualisasi progres impian dan perayaan pencapaian Flutter - helper murni ImpianProgresHelper, guard divisi nol, SharedPreferences penandaan perayaan sekali, AppToast sukses, saldo dari biodata.uangDihemat, widget bawaan (Stack, LinearProgressIndicator, Icon), clamp rasio 0-1, dan VisualTabunganImpian widget reusable.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "c7337d1519d495d0ccd022fb18d63f72d443866a"
  model: "kilo-auto/free"
---

# Visualisasi Progres Impian dan Perayaan Pencapaian

Helper murni untuk rasio/sisa/tercapai, guard divisi nol, SharedPreferences penandaan perayaan, AppToast, saldo dari biodata.uangDihemat, widget bawaan, clamp rasio.

## Cakupan yang Di-Cover

- Package: `package:flutter` (class `LinearProgressIndicator`, `Stack`, `FractionallySizedBox`, `Container`, `Icon`, `Text`, `ListTile`, `ListView`), `package:flutter_riverpod` (class `AsyncValue`, `ref`, `ConsumerWidget`), `package:shared_preferences` (class `SharedPreferences`)
- Class: `ImpianProgresHelper`, `VisualTabunganImpian`, `SharedPreferences`, `AppToast`, `LinearProgressIndicator`
- Method: `ImpianProgresHelper.rasio()`, `ImpianProgresHelper.tercapai()`, `ImpianProgresHelper.sisa()`, `SharedPreferences.getInstance()`, `AppToast.sukses()`, `unawaited()`

## Aturan

1. Perhitungan progres (rasio, sisa, tercapai) diekstrak ke helper murni (class static, private constructor, no BuildContext/provider).
2. Helper wajib guard divisi nol (target <= 0 → return 0.0/false).
3. Penandaan impian diraikan (perayaan sekali) disimpan di SharedPreferences (`impian_diraikan`), bukan variabel memori.
4. Impian baru tercapai → `AppToast.sukses` perayaan, penandaan via `unawaited()` non-blocking.
5. Layar progres impian wajib watch `biodataProvider` untuk `uangDihemat` sebagai saldo, bukan `totalJumlah` dari `ImpianState`.
6. Widget visual (`VisualTabunganImpian`) pakai komponen bawaan (Stack, LinearProgressIndicator, Icon), no aset baru.
7. Rasio clamp 0.0–1.0 sebelum ke `LinearProgressIndicator`.

## Larangan

- Jangan hitung rasio/sisa/tercapai inline di layar dengan formula berbeda.
- Jangan pakai `totalJumlah` `ImpianState` sebagai saldo.
- Jangan toast perayaan berulang untuk impian sama (pakai SharedPreferences penandaan).
- Jangan tambah aset gambar/Lottie untuk visual progres.

## Contoh Benar

```dart
// Helper murni tanpa BuildContext/provider
class ImpianProgresHelper {
  const ImpianProgresHelper._();
  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0; // Guard divisi nol
    return (saldo / target).clamp(0.0, 1.0);
  }
  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false;
    return saldo >= target;
  }
}

// Layar progres: saldo dari biodata.uangDihemat
class ImpianScreenBenar extends ConsumerWidget {
  @override Widget build(BuildContext context, WidgetRef ref) {
    final impianState = ref.watch(impianProvider).requireValue;
    final biodataAsync = ref.watch(biodataProvider);
    final biodata = biodataAsync.asData?.value;
    final uangDihemat = biodata?.uangDihemat ?? 0;

    return ListView.builder(itemCount: impianState.list.length, itemBuilder: (_, i) {
      final item = impianState.list[i];
      final rasio = ImpianProgresHelper.rasio(uangDihemat, item.jumlah);
      final tercapai = ImpianProgresHelper.tercapai(uangDihemat, item.jumlah);

      if (tercapai) {
        unawaited(_tandaiDanRaiikan(context, item.id, item.nama));
      }

      return ListTile(
        title: Text(item.nama),
        subtitle: LinearProgressIndicator(value: rasio),
        trailing: tercapai ? const Icon(Icons.celebration, color: Colors.amber) : null,
      );
    });
  }

  Future<void> _tandaiDanRaiikan(BuildContext context, String id, String nama) async {
    final prefs = await SharedPreferences.getInstance();
    final daftar = prefs.getStringList('impian_diraikan') ?? <String>[];
    if (!daftar.contains(id)) {
      daftar.add(id);
      await prefs.setStringList('impian_diraikan', daftar);
      AppToast.sukses(context, 'Selamat! Impian "$nama" telah tercapai!');
    }
  }
}
```

## Contoh Salah

```dart
// DILARANG: Hitung inline di layar dengan formula berbeda
final rasio = uangDihemat <= 0 || item.jumlah <= 0 ? 0 : (uangDihemat / item.jumlah).clamp(0.0, 1.0);

// DILARANG: Pakai totalJumlah sebagai saldo (bukan uangDihemat)
final rasio2 = impianState.totalJumlah <= 0 ? 0 : (impianState.totalJumlah / item.jumlah).clamp(0.0, 1.0);

// DILARANG: Helper tanpa guard divisi nol
class ImpianProgresHelperSalah {
  static double rasio(double saldo, double target) => saldo / target;
}

// DILARANG: Toast berulang tanpa penandaan SharedPreferences
AppToast.sukses(context, 'Tercapai!'); // Muncul setiap build
```

## Sumber Evaluasi

- File: `lib/fitur/impian/helper/impian_progres_helper.dart`, `lib/fitur/impian/screens/detail_impian_screen.dart`, `lib/fitur/impian/screens/impian_screen.dart`, `lib/fitur/impian/widget/visual_tabungan_impian.dart`
- Class terkait: `ImpianProgresHelper`, `VisualTabunganImpian`, `LinearProgressIndicator`, `SharedPreferences`
- Commit rujukan: `c7337d1519d495d0ccd022fb18d63f72d443866a` — `ImpianProgresHelper`, `VisualTabunganImpian`, `DetailImpianScreen`