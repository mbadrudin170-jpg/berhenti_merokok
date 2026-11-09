---
name: pola-ui
description: Pola UI standar: visualisasi progres impian dengan LinearProgressIndicator, isolasi widget timer/animasi periodik, penggunaan withValues untuk opacity warna, dan komponen visual reusable.
kategori: custom
versi: 1.0.0
commit-terakhir: c7337d1519d495d0ccd022fb18d63f72d443866a
---

# Pola UI Standar

Skill ini mendokumentasikan pola UI yang wajib diterapkan, berdasarkan implementasi nyata dari riwayat commit. Fokus pada visualisasi data, performa timer, dan konsistensi styling.

## 1. Visualisasi Progres Impian (LinearProgressIndicator + Stack)

### Aturan
- **WAJIB** menggunakan komponen Flutter bawaan: `Stack`, `LinearProgressIndicator`, `Icon`.
- **DILARANG** menambahkan aset gambar/Lottie baru untuk widget visual progres.
- Rasio progres **WAJIB** diklem (clamp) ke rentang `0.0–1.0` sebelum diteruskan ke `LinearProgressIndicator`.
- Helper progres (`ImpianProgresHelper`) **WAJIB** bersifat murni (static methods, private constructor, no `BuildContext`/`provider`).
- Guard pembagian nol **WAJIB** di helper: `if (target <= 0) return 0.0/false`.

### Contoh Implementasi

#### Helper Murni
```dart
class ImpianProgresHelper {
  const ImpianProgresHelper._();

  static double rasio(double saldo, double target) {
    if (target <= 0) return 0.0;
    return (saldo / target).clamp(0.0, 1.0);
  }

  static bool tercapai(double saldo, double target) {
    if (target <= 0) return false;
    return saldo >= target;
  }

  static double sisa(double saldo, double target) {
    if (target <= 0) return 0;
    final s = target - saldo;
    return s < 0 ? 0 : s;
  }
}
```

#### Widget Visual Progress (VisualTabunganImpian)
```dart
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    required this.rasio,
    required this.saldo,
    required this.target,
    super.key,
  });

  final double rasio; // sudah di-clamp 0.0-1.0
  final double saldo;
  final double target;

  @override
  Widget build(BuildContext context) {
    final warnaProgres = rasio >= 1.0 ? Colors.green : Theme.of(context).colorScheme.primary;
    final warnaBackground = warnaProgres.withValues(alpha: 0.2);

    return Stack(
      children: [
        // Background track
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: warnaBackground,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        // Progress bar
        FractionallySizedBox(
          widthFactor: rasio,
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: warnaProgres,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        // Icon target di ujung (opsional)
        if (rasio < 1.0)
          Positioned(
            left: rasio * MediaQuery.of(context).size.width * 0.8, // estimasi
            child: Icon(Icons.flag, size: 16, color: warnaProgres),
          ),
      ],
    );
  }
}
```

### Referensi Commit
- `c7337d1` — `ImpianProgresHelper`, `VisualTabunganImpian`, `DetailImpianScreen`

## 2. Isolasi Widget Timer/Animasi Periodik

### Aturan
- Widget yang diupdate berkala (`Timer.periodic` per detik) **WAJIB** diisolasi ke `StatefulWidget` terpisah.
- Hanya widget tersebut yang rebuild, **BUKAN** seluruh halaman.
- Timer **WAJIB** dibatalkan (`cancel()`) di `dispose()`.
- Di callback timer, **WAJIB** cek `mounted` sebelum `setState()`.
- **DILARANG** menjalankan `Timer.periodic` di widget tingkat halaman jika hanya sebagian UI butuh update.

### Contoh Implementasi

#### Timer Craving (SOS Craving Screen)
```dart
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

// Penggunaan di SOSCravingScreen:
child: _TimerCravingView(mulai: _waktuMulaiCraving),
```

#### Header Pemulihan Kesehatan
```dart
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
    // Hitung durasi smoke-free (normalisasi tanggal)
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final berhentiDate = DateTime(
      widget.tanggalBerhenti.year,
      widget.tanggalBerhenti.month,
      widget.tanggalBerhenti.day,
    );
    final durasi = hariIniDate.difference(berhentiDate);
    final aman = durasi.isNegative ? Duration.zero : durasi;
    
    return Text('Smoke-free: ${aman.inDays} hari');
  }
}
```

### Referensi Commit
- `3b67d309` — `_TimerCravingView` di `SosCravingScreen`
- `02aa6b29` — `_HeaderPemulihan` di `PemulihanKesehatanScreen`

## 3. Penggunaan `withValues` untuk Opacity Warna

### Aturan
- **WAJIB** gunakan `warna.withValues(alpha: ...)` alih-alih `warna.withOpacity(...)`.
- Konsisten di seluruh widget.
- Sesuai API Flutter 3.47+ (withOpacity deprecated).

### Contoh Implementasi
```dart
// BENAR
Container(
  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
  child: ...,
)

// Progress bar background
color: warnaProgres.withValues(alpha: 0.2),

// Overlay loading
color: Colors.black.withValues(alpha: 0.5),

// SALAH (deprecated)
color: warna.withOpacity(0.2),
```

### Referensi Commit
- `3b67d309` — `warna.withValues(alpha: 0.2)` di `SosCravingScreen`

## 4. Normalisasi Tanggal untuk UI (Tampilan Hari/Status)

### Aturan
- Sebelum menampilkan status hari (smoke-free/belum) atau menghitung total hari, **WAJIB** normalisasi `DateTime` ke komponen tanggal saja.
- Gunakan `DateTime(tahun, bulan, hari)` untuk membuang jam/menit/detik.
- Hasil negatif **WAJIB** diklem ke 0 (hari smoke-free tidak boleh negatif).

### Contoh Implementasi (Kalender Smoke-Free)
```dart
class _SelHari extends StatelessWidget {
  const _SelHari({required this.tanggal, required this.tanggalBerhenti, required this.hariIni});

  final DateTime tanggal;
  final DateTime tanggalBerhenti;
  final DateTime hariIni;

  @override
  Widget build(BuildContext context) {
    // Normalisasi kedua tanggal
    final tanggalDate = DateTime(tanggal.year, tanggal.month, tanggal.day);
    final berhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );
    final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);

    // Status berdasarkan tanggal dinormalisasi
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
```

### Referensi Commit
- `6fd979fd` — `_SelHari`, `_GridKalender` di `KalenderSmokeFreeScreen`
- `02aa6b29` — `_HeaderPemulihan`, `_buildCardMilestone` di `DashboardScreen`

---

## Larangan Umum

- **DILARANG** `withOpacity()` → gunakan `withValues(alpha:)`.
- **DILARANG** timer di widget halaman penuh → isolasi ke widget kecil.
- **DILARANG** lupa `cancel()` di `dispose()` untuk timer.
- **DILARANG** lupa cek `mounted` di callback timer.
- **DILARANG** aset gambar/Lottie untuk visual progres → gunakan `Stack` + `LinearProgressIndicator` + `Icon`.
- **DILARANG** rasio progres tanpa clamp → `LinearProgressIndicator` error jika > 1.0.
- **DILARANG** perbandingan tanggal tanpa normalisasi → hasil bisa salah 1 hari.

## Pengecualian

- Animasi kompleks yang memerlukan `AnimationController` → gunakan pattern isolasi serupa (controller di widget terpisah, dispose di `dispose()`).

---

## Referensi Aturan Terkait

- `aturan_bersama.md` — Isolasi Widget Timer, withValues Opacity, Normalisasi Tanggal
- `aturan_khusus.md` — Visualisasi Progres Impian, Normalisasi Tanggal Kalender