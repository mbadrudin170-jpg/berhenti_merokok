# Contoh Output: Widget Custom VisualTabunganImpian

## Sumber
- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File rujukan: `lib/fitur/impian/widget/visual_tabungan_impian.dart`

## Implementasi Lengkap
```dart
// lib/fitur/impian/widget/visual_tabungan_impian.dart
import 'package:flutter/material.dart';
import 'package:berhenti_merokok/fitur/impian/helper/impian_progres_helper.dart';
import 'package:berhenti_merokok/shared/utils/format_uang.dart';

class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    required this.rasio,
    required this.saldo,
    required this.target,
    super.key,
  });

  /// Rasio progres 0.0 - 1.0 (sudah di-clamp oleh ImpianProgresHelper)
  final double rasio;
  
  /// Uang yang sudah terkumpul
  final double saldo;
  
  /// Target uang impian
  final double target;

  @override
  Widget build(BuildContext context) {
    final bool sudahTercapai = rasio >= 1.0;
    
    // WARNA KONDISIONAL: Semantic green untuk tercapai, ColorScheme primary untuk belum
    final Color warnaProgres = sudahTercapai 
        ? const Color(0xFF4CAF50)  // Hardcode diperbolehkan: status sukses
        : Theme.of(context).colorScheme.primary;
    
    // OPACITY: withValues (WAJIB), bukan withOpacity
    final Color warnaBackground = warnaProgres.withValues(alpha: 0.2);

    return Column(
      // SPACING INTERNAL: 8 antar progress bar dan label
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // PROGRESS BAR CUSTOM dengan Stack
        SizedBox(
          height: 12,
          child: Stack(
            children: [
              // 1. Background track
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: warnaBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              // 2. Progress fill (FractionallySizedBox widthFactor = rasio)
              FractionallySizedBox(
                widthFactor: rasio, // AMAN: sudah di-clamp 0.0-1.0 di helper
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: warnaProgres,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              // 3. Icon flag di ujung progress (opsional, hanya jika belum tercapai)
              if (!sudahTercapai)
                Positioned(
                  // Estimasi posisi: rasio * lebar available * faktor
                  left: rasio * MediaQuery.of(context).size.width * 0.7,
                  top: -2,
                  child: Icon(
                    Icons.flag_outlined,
                    size: 16,
                    color: warnaProgres,
                  ),
                ),
            ],
          ),
        ),
        // LABEL ROW: Terkumpul / Sisa atau Tercapai
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sudahTercapai 
                  ? 'Target tercapai! 🎉' 
                  : 'Terkumpul: ${FormatUang.format(saldo)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: sudahTercapai 
                    ? const Color(0xFF4CAF50)  // Semantic green
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontFeatures: const [FontFeature.tabularFigures()], // Angka monospace
              ),
            ),
            if (!sudahTercapai)
              Text(
                'Sisa: ${FormatUang.format(ImpianProgresHelper.sisa(saldo, target))}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
```

## Penggunaan di ImpianScreen & DetailImpianScreen
```dart
// lib/fitur/impian/screens/impian_screen.dart
class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    final impianAsync = ref.watch(impianProvider);
    
    // ... handle loading/error ...
    
    final uangDihemat = biodataAsync.requireValue?.uangDihemat ?? 0;
    final listImpian = impianAsync.requireValue.listImpian;

    return ListView.builder(
      padding: const EdgeInsets.all(16), // Padding tepi layar (parent responsibility)
      itemCount: listImpian.length,
      itemBuilder: (context, index) {
        final impian = listImpian[index];
        final target = impian.jumlah.toDouble();
        
        // LOGIKA DI HELPER (bukan di widget!)
        final rasio = ImpianProgresHelper.rasio(uangDihemat, target);
        final sudahTercapai = ImpianProgresHelper.tercapai(uangDihemat, target);

        return _ImpianItem(
          impian: impian,
          saldo: uangDihemat,
          target: target,
          sudahTercapai: sudahTercapai,
        );
      },
    );
  }
}

// Widget item card (reusable)
class _ImpianItem extends StatelessWidget {
  const _ImpianItem({
    required this.impian,
    required this.saldo,
    required this.target,
    required this.sudahTercapai,
    super.key,
  });

  final ImpianModel impian;
  final double saldo;
  final double target;
  final bool sudahTercapai;

  @override
  Widget build(BuildContext context) {
    final rasio = ImpianProgresHelper.rasio(saldo, target);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16), // Padding INTERNAL komponen
        child: Column(
          spacing: 12, // Spacing antar elemen card
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(impian.nama, style: Theme.of(context).textTheme.titleMedium)),
                if (sudahTercapai)
                  const Chip(
                    label: Text('Tercapai!', style: TextStyle(color: Colors.green)),
                    backgroundColor: Color(0xFFE8F5E9),
                  ),
              ],
            ),
            // WIDGET CUSTOM REUSABLE DI SINI
            VisualTabunganImpian(
              rasio: rasio,
              saldo: saldo,
              target: target,
            ),
          ],
        ),
      ),
    );
  }
}
```

## Checklist Kualitas Widget Custom

| Kriteria | Status | Detail |
|----------|--------|--------|
| **StatelessWidget** | ✅ | Tidak butuh state internal |
| **Pure (no logic)** | ✅ | Rasio/tercapai dihitung di helper, bukan di sini |
| **No external assets** | ✅ | Stack + FractionallySizedBox + Icon bawaan |
| **withValues opacity** | ✅ | `warnaProgres.withValues(alpha: 0.2)` |
| **Clamp rasio** | ✅ | Di `ImpianProgresHelper.rasio()` → `.clamp(0.0, 1.0)` |
| **Tabular figures** | ✅ | `FontFeature.tabularFigures()` pada angka uang |
| **Column.spacing** | ✅ | `spacing: 8` internal, `spacing: 12` di parent card |
| **Semantic colors** | ✅ | Hijau hardcode untuk sukses, ColorScheme untuk UI |
| **Reusable** | ✅ | Dipakai di `ImpianScreen` & `DetailImpianScreen` |

## Anti-Pola (DILARANG)
```dart
// SALAH: Logika di widget
class VisualTabunganImpian extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rasio = saldo / target; // LOGIKA DI WIDGET - SALAH!
    // ...
  }
}

// SALAH: LinearProgressIndicator langsung (kurang custom)
LinearProgressIndicator(value: rasio, backgroundColor: warna.withOpacity(0.2))

// SALAH: Pakai aset Lottie/gambar
Lottie.asset('assets/progress.json')

// SALAH: withOpacity deprecated
color: warna.withOpacity(0.2)

// SALAH: Tidak clamp rasio (crash jika > 1.0)
FractionallySizedBox(widthFactor: rasioTanpaClamp)
```