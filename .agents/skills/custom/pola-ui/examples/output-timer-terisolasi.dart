# Contoh Output: Widget Timer Terisolasi

## Sumber
- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981` — `_TimerCravingView`
- Commit: `02aa6b29b0669a4f5bf21651b09b43552f65d6f8` — `_HeaderPemulihan`

## Implementasi

### 1. Timer Craving (SOS Craving)
```dart
// lib/fitur/sos_craving/screens/sos_craving_screen.dart

class _TimerCravingView extends StatefulWidget {
  const _TimerCravingView({required this.mulai});
  final DateTime mulai;

  @override
  State<_TimerCravingView> createState() => _TimerCravingViewState();
}

class _TimerCravingViewState extends State<_TimerCravingView> {
  Timer? _timer;
  Duration _durasi = Duration.zero;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _durasi = DateTime.now().difference(widget.mulai);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menit = _durasi.inMinutes.remainder(60).toString().padLeft(2, '0');
    final detik = _durasi.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Text(
      '$menit:$detik',
      style: Theme.of(context).textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}

// Penggunaan di SosCravingScreen (hanya widget ini rebuild tiap detik):
class _SosCravingScreenState extends State<SosCravingScreen> {
  DateTime? _waktuMulaiCraving;

  void _mulaiCraving() {
    setState(() => _waktuMulaiCraving = DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24,
          children: [
            const Text('Craving berlangsung...'),
            if (_waktuMulaiCraving != null)
              _TimerCravingView(mulai: _waktuMulaiCraving!), // ← Terisolasi!
            // Widget lain di sini TIDAK rebuild tiap detik
            FilledButton(
              onPressed: _selesaiCraving,
              child: const Text('Craving Berakhir'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 2. Header Pemulihan Kesehatan (Durasi Smoke-Free)
```dart
// lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart

class _HeaderPemulihan extends StatefulWidget {
  const _HeaderPemulihan({required this.tanggalBerhenti});
  final DateTime tanggalBerhenti;

  @override
  State<_HeaderPemulihan> createState() => _HeaderPemulihanState();
}

class _HeaderPemulihanState extends State<_HeaderPemulihan> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {}); // Hanya rebuild widget ini
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Normalisasi tanggal (wajib!)
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final berhentiDate = DateTime(
      widget.tanggalBerhenti.year,
      widget.tanggalBerhenti.month,
      widget.tanggalBerhenti.day,
    );
    
    final durasi = hariIniDate.difference(berhentiDate);
    final aman = durasi.isNegative ? Duration.zero : durasi; // Klamp negatif ke 0
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          children: [
            Text(
              'Smoke-free: ${aman.inDays} hari',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text('Sejak ${FormatTanggal.formatLengkap(widget.tanggalBerhenti)}'),
          ],
        ),
      ),
    );
  }
}

// Penggunaan di PemulihanKesehatanScreen:
class _PemulihanKesehatanScreenState extends ConsumerState<PemulihanKesehatanScreen> {
  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    
    if (biodataAsync.isLoading) return const _LoadingView();
    if (biodataAsync.hasError) return _ErrorRetry(...);
    
    final biodata = biodataAsync.requireValue;
    if (biodata == null || biodata.tanggalMulaiBerhentiMerokok == null) {
      return const _BelumBerhentiView();
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _HeaderPemulihan(tanggalBerhenti: biodata.tanggalMulaiBerhentiMerokok!),
        ),
        // SliverList milestone di sini TIDAK rebuild tiap detik
        SliverList(delegate: SliverChildBuilderDelegate(...)),
      ],
    );
  }
}
```

## Penjelasan Kunci

| Aspek | Implementasi | Alasan |
|-------|--------------|--------|
| **Widget terpisah** | `_TimerCravingView`, `_HeaderPemulihan` extends `StatefulWidget` | Hanya widget ini rebuild |
| **Timer di `initState`** | `Timer.periodic(Duration(seconds: 1), ...)` | Update tiap detik |
| **`mounted` check** | `if (mounted) setState(() {})` | Mencegah crash jika dispose saat timer jalan |
| **`cancel()` di `dispose`** | `_timer?.cancel()` | Stop timer, prevent memory leak |
| **Normalisasi tanggal** | `DateTime(tahun, bulan, hari)` sebelum `difference` | Hindari salah 1 hari karena jam/menit |
| **Klamp negatif** | `durasi.isNegative ? Duration.zero : durasi` | Hari smoke-free tidak boleh negatif |

## Anti-Pola (DILARANG)
```dart
// SALAH: Timer di widget halaman → seluruh halaman rebuild tiap detik
class _HalamanState extends State<Halaman> {
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {}); // Rebuild SEMUA widget di halaman!
    });
  }
}
```