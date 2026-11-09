# Contoh Output: Hierarki Teks Card Info Impian

## Sumber
- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File rujukan: `lib/fitur/impian/screens/detail_impian_screen.dart`

## Implementasi
```dart
class _InfoCardImpian extends StatelessWidget {
  const _InfoCardImpian({
    required this.label,
    required this.subLabel,
    required this.nilai,
    this.warnaNilai,
    super.key,
  });

  final String label;
  final String subLabel;
  final String nilai;
  final Color? warnaNilai;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4, // spacing konsisten
          children: [
            // Level 1: Label - kecil, warna muted
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
            
            // Level 2: Sub-Label - sedang, warna secondary
            Text(
              subLabel,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
            
            // Level 3: Nilai Utama - besar, BOLD, warna primary/custom
            Text(
              nilai,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: warnaNilai ?? colorScheme.onSurface,
                fontFeatures: const [FontFeature.tabularFigures()], // Untuk angka
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Penggunaan:
_InfoCardImpian(
  label: 'Total Pengeluaran',
  subLabel: 'Pengeluaran bulan ini',
  nilai: 'Rp500.000',
  warnaNilai: Colors.red, // Custom untuk pengeluaran
),
_InfoCardImpian(
  label: 'Uang Dihemat',
  subLabel: 'Dari tidak merokok',
  nilai: FormatUang.format(biodata.uangDihemat),
  warnaNilai: Colors.green, // Custom untuk hemat
),
```

## Penjelasan Perbedaan Tingkat

| Tingkat | Style Dasar | Modifikasi | Visual |
|---------|-------------|------------|--------|
| **Label** | `bodySmall` | `color: onSurfaceVariant.withValues(alpha: 0.7)` | Kecil, abu-abu muted |
| **Sub-Label** | `bodyMedium` | `color: secondary` | Sedang, warna aksen tema |
| **Nilai** | `titleLarge` | `fontWeight: bold`, `tabularFigures` | Besar, tebal, monospace angka |

**Total 3 properti berbeda** (ukuran, weight, warna) → hierarki jelas.

## Anti-Pola (DILARANG)
```dart
// SALAH: Manual TextStyle tanpa textTheme
Text('Label', style: TextStyle(fontSize: 12, color: Colors.grey)),
Text('Nilai', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

// SALAH: Gaya identik untuk tingkat berbeda
final style = textTheme.bodyMedium;
Text('Label', style: style),
Text('Sub-Label', style: style),
Text('Nilai', style: style), // Hierarchy TIDAK terlihat!

// SALAH: Semua bold
Text('Label', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
Text('Nilai', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
```