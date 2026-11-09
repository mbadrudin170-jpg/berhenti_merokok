# Contoh Output: Type Promotion & Normalisasi Tanggal

## Sumber
- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec` — Type promotion
- Commit: `6fd979fd9e8296bc7d9c40e9037870faef9c846a` — Normalisasi tanggal
- Commit: `02aa6b29b0669a4f5bf21651b09b43552f65d6f8` — Klamp durasi negatif
- File rujukan: `lib/fitur/biodata/screens/biodata_screen.dart`, `lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart`, `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`

## Implementasi

### 1. Type Promotion di BiodataScreen
```dart
// lib/fitur/biodata/screens/biodata_screen.dart
class _BiodataScreenState extends ConsumerState<BiodataScreen> {
  @override
  Widget build(BuildContext context) {
    final biodataAsync = ref.watch(biodataProvider);
    
    // ... handle loading/error ...
    
    final biodata = biodataAsync.requireValue;
    
    // TYPE PROMOTION: Copy field nullable ke lokal DULU
    final tanggalLahir = biodata?.tanggalLahir;
    final tanggalMulaiMerokok = biodata?.tanggalMulaiMerokok;
    final tanggalMulaiBerhenti = biodata?.tanggalMulaiBerhentiMerokok;
    
    // Sekarang type promotion kerja: tanggalLahir non-null di branch else
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildItem(
          'Tanggal Lahir',
          tanggalLahir == null 
              ? 'Belum dipilih' 
              : FormatTanggal.formatDasar(tanggalLahir), // tanggalLahir non-null di sini
        ),
        _buildItem(
          'Mulai Merokok',
          tanggalMulaiMerokok == null 
              ? 'Belum dipilih' 
              : FormatTanggal.formatDasar(tanggalMulaiMerokok),
        ),
        _buildItem(
          'Mulai Berhenti',
          tanggalMulaiBerhenti == null 
              ? 'Belum dipilih' 
              : FormatTanggal.formatDasar(tanggalMulaiBerhenti),
        ),
      ],
    );
  }

  Widget _buildItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
```

### 2. Normalisasi Tanggal di KalenderSmokeFreeScreen
```dart
// lib/fitur/kalender_smoke_free/screens/kalender_smoke_free_screen.dart

class _SelHari extends StatelessWidget {
  const _SelHari({
    required this.tanggal,
    required this.tanggalBerhenti,
    required this.hariIni,
  });

  final DateTime tanggal;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;

  @override
  Widget build(BuildContext context) {
    // NORMALISASI: Buang jam/menit/detik
    final tanggalDate = DateTime(tanggal.year, tanggal.month, tanggal.day);
    final berhentiDate = DateTime(tanggalBerhenti.year, tanggalBerhenti.month, tanggalBerhenti.day);
    final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);

    // Bandingkan pakai tanggal dinormalisasi
    final sudahLewat = tanggalDate.isBefore(hariIniDate) || tanggalDate.isAtSameMomentAs(hariIniDate);
    final sudahMulai = tanggalDate.isAtSameMomentAs(berhentiDate) || tanggalDate.isAfter(berhentiDate);
    
    final bool isSmokeFree = sudahLewat && sudahMulai;
    final bool isHariIni = tanggalDate.isAtSameMomentAs(hariIniDate);

    return Container(
      decoration: BoxDecoration(
        color: isSmokeFree 
            ? Colors.green.withValues(alpha: 0.1) 
            : Colors.grey.withValues(alpha: 0.1),
        border: isHariIni ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          '${tanggal.day}',
          style: TextStyle(
            fontWeight: isHariIni ? FontWeight.bold : FontWeight.normal,
            color: isSmokeFree ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}

class _GridKalender extends StatelessWidget {
  // ...
  
  @override
  Widget build(BuildContext context) {
    // Total hari smoke-free (normalisasi + klamp)
    final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
    final berhentiDate = DateTime(tanggalBerhenti.year, tanggalBerhenti.month, tanggalBerhenti.day);
    final totalHari = hariIniDate.difference(berhentiDate).inDays + 1;
    final totalAman = totalHari < 0 ? 0 : totalHari; // KLAMP NEGATIF KE 0
    
    return Column(
      children: [
        Text('Total Smoke-free: $totalAman hari'),
        GridView.builder(...),
      ],
    );
  }
}
```

### 3. Klamp Durasi Negatif di PemulihanKesehatanScreen & Dashboard
```dart
// lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart
// lib/fitur/dashboard/screens/dashboard_screen.dart

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
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // NORMALISASI TANGGAL
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final berhentiDate = DateTime(
      widget.tanggalBerhenti.year,
      widget.tanggalBerhenti.month,
      widget.tanggalBerhenti.day,
    );
    
    // DIFFERENCE PAKAI TANGGAL DINORMALISASI
    final durasi = hariIniDate.difference(berhentiDate);
    
    // KLAMP NEGATIF KE DURATION.ZERO
    final aman = durasi.isNegative ? Duration.zero : durasi;
    
    return Text('Smoke-free: ${aman.inDays} hari ${aman.inHours.remainder(24)} jam');
  }
}
```

## Anti-Pola (DILARANG)
```dart
// SALAH: Type promotion TIDAK kerja - paksa dengan !
_buildItem('Lahir', biodata.tanggalLahir == null ? '-' : FormatTanggal.formatDasar(biodata.tanggalLahir!));

// SALAH: Tanggal tanpa normalisasi - bisa salah 1 hari
final totalHari = DateTime.now().difference(tanggalBerhenti).inDays + 1;

// SALAH: Durasi negatif tidak diklem
final durasi = DateTime.now().difference(tanggalBerhenti); // Bisa negatif!
Text('Smoke-free: ${durasi.inDays} hari'); // Tampil negatif jika belum berhenti
```