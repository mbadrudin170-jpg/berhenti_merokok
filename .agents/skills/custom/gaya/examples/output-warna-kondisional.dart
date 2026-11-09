# Contoh Output: Styling Warna Progress Bar Kondisional

## Sumber
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File rujukan: `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/fitur/impian/widget/visual_tabungan_impian.dart`

## Implementasi
```dart
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    required this.rasio,
    required this.saldo,
    required this.target,
    super.key,
  });

  final double rasio; // 0.0 - 1.0 (sudah di-clamp)
  final double saldo;
  final double target;

  @override
  Widget build(BuildContext context) {
    final bool sudahTercapai = rasio >= 1.0;
    
    // WARNA KONDISIONAL: Semantic green untuk tercapai, ColorScheme primary untuk belum
    final Color warnaProgres = sudahTercapai 
        ? const Color(0xFF4CAF50) // Hardcode DIPERBOLEHKAN: status sukses harus sama di light/dark
        : Theme.of(context).colorScheme.primary; // WAJIB: ikut tema
    
    // OPACITY: withValues (WAJIB), BUKAN withOpacity
    final Color warnaBackground = warnaProgres.withValues(alpha: 0.2);

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
                  color: warnaBackground, // withValues(alpha: 0.2)
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              // Progress fill
              FractionallySizedBox(
                widthFactor: rasio, // Aman: sudah di-clamp 0.0-1.0
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: warnaProgres,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sudahTercapai 
                  ? 'Target tercapai! 🎉' 
                  : 'Terkumpul: ${FormatUang.format(saldo)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: sudahTercapai 
                    ? const Color(0xFF4CAF50) // Hardcode semantic green
                    : Theme.of(context).colorScheme.onSurfaceVariant,
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

## Penjelasan

| Elemen | Pendekatan | Alasan |
|--------|------------|--------|
| **Warna progress** | Kondisional: `Colors.green` (hardcode) vs `ColorScheme.primary` | Status sukses harus konsisten visual di light/dark mode; warna UI biasa ikut tema |
| **Background opacity** | `warnaProgres.withValues(alpha: 0.2)` | Flutter 3.47+ standard, `withOpacity` deprecated |
| **Teks status** | Hardcode green jika tercapai, `onSurfaceVariant` jika tidak | Konsisten dengan warna progress bar |
| **Chip status** | `Chip(backgroundColor: Color(0xFFE8F5E9), label: Text(..., color: Colors.green))` | Light green background + green text untuk status "Tercapai" |

## Anti-Pola (DILARANG)
```dart
// SALAH: withOpacity deprecated
final bg = warnaProgres.withOpacity(0.2);

// SALAH: Hardcode primary color (harus ikut tema)
final primary = const Color(0xFF2196F3); // JANGAN!

// SALAH: Semua warna hardcode (tidak support dark mode)
Container(color: Colors.blue, child: Text('...', style: TextStyle(color: Colors.white)))
```