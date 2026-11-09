# Contoh Output: Spacing Card Impian dengan Column.spacing

## Sumber
- Commit: `c7337d1519d495d0ccd022fb18d63f72d443866a`
- File rujukan: `lib/fitur/impian/widget/visual_tabungan_impian.dart`, `lib/fitur/impian/screens/impian_screen.dart`

## Implementasi
```dart
// Widget reusable: Card impian di daftar
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
      // Card TIDAK punya padding tepi layar - itu tanggung jawab parent halaman
      child: Padding(
        // Padding INTERNAL komponen (standar 16)
        padding: const EdgeInsets.all(16),
        child: Column(
          // SPACING: Jarak seragam 12 antar semua anak
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anak 1: Row judul + chip status
            Row(
              children: [
                Expanded(
                  child: Text(impian.nama, style: Theme.of(context).textTheme.titleMedium),
                ),
                if (sudahTercapai)
                  const Chip(
                    label: Text('Tercapai!', style: TextStyle(color: Colors.green)),
                    backgroundColor: Color(0xFFE8F5E9),
                  ),
              ],
            ),
            
            // Anak 2: Visual progress bar (sudah punya spacing internal 8)
            VisualTabunganImpian(
              rasio: rasio,
              saldo: saldo,
              target: target,
            ),
            
            // Anak 3: Row label info (terkumpul/sisa) - tidak perlu SizedBox tambahan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terkumpul: ${FormatUang.format(saldo)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  sudahTercapai 
                      ? 'Target tercapai!' 
                      : 'Sisa: ${FormatUang.format(ImpianProgresHelper.sisa(saldo, target))}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget reusable: Visual progress bar (punya spacing internal sendiri)
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    required this.rasio,
    required this.saldo,
    required this.target,
    super.key,
  });

  final double rasio;
  final double saldo;
  final double target;

  @override
  Widget build(BuildContext context) {
    // ...
    return Column(
      // SPACING INTERNAL: 8 antar progress bar & label
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar Stack
        SizedBox(height: 12, child: Stack(...)),
        // Label row
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [...]),
      ],
    );
  }
}

// HALAMAN (Parent) - Bertanggung jawab padding tepi layar
class _ImpianScreenState extends ConsumerState<ImpianScreen> {
  @override
  Widget build(BuildContext context) {
    // ...
    return Scaffold(
      body: SafeArea(
        child: Padding(
          // PADDING TEPI LAYAR: 16 (mengikuti optimasi_ui.md)
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: listImpian.length,
            itemBuilder: (context, index) {
              return _ImpianItem(...); // Widget reusable - TIDAK padding tepi layar
            },
          ),
        ),
      ),
    );
  }
}
```

## Penjelasan Struktur Spacing

| Lapisan | Tanggung Jawab | Nilai | Catatan |
|---------|----------------|-------|---------|
| **Halaman (Parent)** | Padding tepi layar | `EdgeInsets.all(16)` | `SafeArea` → `Padding` → `ListView` |
| **Card (Reusable)** | Padding internal | `EdgeInsets.all(16)` | Di dalam `Card` child `Padding` |
| **Column di Card** | Spacing antar elemen utama | `spacing: 12` | Judul → Progress → Label info |
| **VisualTabunganImpian** | Spacing internal progress | `spacing: 8` | Progress bar → Label row |
| **Wrap FilterChip** | Spacing horizontal/vertikal | `spacing: 8, runSpacing: 8` | Chip pilihan cepat |

## Anti-Pola (DILARANG)
```dart
// SALAH: SizedBox berulang di Column
Column(
  children: [
    Text('Judul'),
    SizedBox(height: 12),
    VisualTabunganImpian(...),
    SizedBox(height: 12),
    Row(...),
  ],
)

// SALAH: Widget reusable punya padding tepi layar
class _ImpianItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding( // SALAH! Ini padding tepi layar, bukan internal
      padding: EdgeInsets.all(16),
      child: Card(...),
    );
  }
}

// SALAH: Padding ganda (parent padding 16 + anak padding 16 = 32 total)
Scaffold(
  body: Padding(16, child: ListView(children: [
    Padding(16, child: _ImpianItem(...)), // DOUBLE PADDING!
  ])),
)
```