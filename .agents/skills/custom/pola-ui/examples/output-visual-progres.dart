# Contoh Output: Visualisasi Progres Impian

## Sumber
- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File rujukan: `lib/fitur/impian/helper/impian_progres_helper.dart`, `lib/fitur/impian/widget/visual_tabungan_impian.dart`

## Implementasi

### 1. Helper Murni (Pure Class)
```dart
// lib/fitur/impian/helper/impian_progres_helper.dart
class ImpianProgresHelper {
  const ImpianProgresHelper._(); // Private constructor → tidak bisa di-instantiate

  /// Rasio progres 0.0 - 1.0 (sudah di-clamp)
  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0; // Guard pembagian nol
    return (saldo / target).clamp(0.0, 1.0);
  }

  /// Apakah target tercapai
  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false; // Guard pembagian nol
    return saldo >= target;
  }

  /// Sisa uang untuk mencapai target (>= 0)
  static double sisa(double saldo, double target) {
    if (target <= 0) return 0;
    final s = target - saldo;
    return s < 0 ? 0 : s; // Klamp negatif ke 0
  }
}
```

### 2. Widget Visual Progress (Stack + LinearProgressIndicator)
```dart
// lib/fitur/impian/widget/visual_tabungan_impian.dart
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    required this.rasio,
    required this.saldo,
    required this.target,
    super.key,
  });

  final double rasio; // Sudah di-clamp 0.0-1.0 oleh helper
  final double saldo;
  final double target;

  @override
  Widget build(BuildContext context) {
    final bool sudahTercapai = rasio >= 1.0;
    final Color warnaProgres = sudahTercapai ? Colors.green : Theme.of(context).colorScheme.primary;
    final Color warnaBackground = warnaProgres.withValues(alpha: 0.2); // withValues, BUKAN withOpacity

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        // Progress bar custom dengan Stack
        SizedBox(
          height: 12,
          child: Stack(
            children: [
              // Background track
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: warnaBackground,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              // Progress fill
              FractionallySizedBox(
                widthFactor: rasio, // Sudah aman 0.0-1.0
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: warnaProgres,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              // Icon target di ujung progress (opsional)
              if (!sudahTercapai)
                Positioned(
                  left: rasio * MediaQuery.of(context).size.width * 0.7, // Estimasi posisi
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
        // Label informatif
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sudahTercapai 
                  ? 'Target tercapai! 🎉' 
                  : 'Terkumpul: ${FormatUang.format(saldo)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: sudahTercapai ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (!sudahTercapai)
              Text(
                'Sisa: ${FormatUang.format(ImpianProgresHelper.sisa(saldo, target))}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
```

### 3. Penggunaan di ImpianScreen & DetailImpianScreen
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
      itemCount: listImpian.length,
      itemBuilder: (context, index) {
        final impian = listImpian[index];
        final target = impian.jumlah.toDouble();
        final rasio = ImpianProgresHelper.rasio(uangDihemat, target);
        final sudahTercapai = ImpianProgresHelper.tercapai(uangDihemat, target);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
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
                VisualTabunganImpian(
                  rasio: rasio,
                  saldo: uangDihemat,
                  target: target,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

## Penjelasan Kunci

| Komponen | Pola | Alasan |
|----------|------|--------|
| **Helper pure class** | `static` methods, `private constructor` | Testable, reusable, no BuildContext dependency |
| **Guard pembagian nol** | `if (target <= 0) return 0.0/false` | Prevent crash/NaN |
| **Rasio clamp** | `.clamp(0.0, 1.0)` di helper | `LinearProgressIndicator` error jika > 1.0 |
| **Stack + FractionallySizedBox** | Custom progress bar | Full control visual, no external assets |
| **withValues(alpha:)** | `warnaProgres.withValues(alpha: 0.2)` | Flutter 3.47+ standard, not deprecated |
| **Warna kondisional** | Hijau jika tercapai, primary jika belum | Visual feedback pencapaian |

## Anti-Pola (DILARANG)
```dart
// SALAH: Inline calculation di layar (duplikasi, tidak konsisten)
final rasio = uangDihemat <= 0 || item.jumlah <= 0
    ? 0
    : (uangDihemat / item.jumlah).clamp(0.0, 1.0);

// SALAH: Menggunakan totalJumlah impian sebagai saldo (salah sumber)
final rasio = ImpianProgresHelper.rasio(impianState.totalJumlah, item.jumlah);

// SALAH: LinearProgressIndicator dengan value > 1.0
LinearProgressIndicator(value: rasioTanpaClamp) // CRASH!

// SALAH: Menggunakan withOpacity (deprecated)
color: warna.withOpacity(0.2)

// SALAH: Menambah aset Lottie/gambar untuk progress bar
Image.asset('assets/progress_animation.json')
```