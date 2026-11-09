---
name: widget-custom
description: Widget custom reusable: VisualTabunganImpian (progress visual), Timer widgets terisolasi (_TimerCravingView, _HeaderPemulihan), Empty State widgets (_EmptyDiaryCraving, _PlaceholderAlasanBerhenti).
kategori: custom
versi: 1.0.0
commit-terakhir: c7337d1519d495d0ccd022fb18d63f72d443866a
---

# Widget Custom Reusable

Skill ini mendokumentasikan widget custom yang dibuat di proyek ini, pola pembuatannya, dan cara penggunannya agar reusable lintas proyek.

## 1. VisualTabunganImpian (Progress Visual Impian)

### Deskripsi
Widget menampilkan progress bar visual impian menggunakan `Stack` + `FractionallySizedBox` (bukan `LinearProgressIndicator` langsung untuk kontrol penuh visual). Menggunakan komponen Flutter bawaan, **tanpa aset gambar/Lottie**.

### Properti
```dart
class VisualTabunganImpian extends StatelessWidget {
  const VisualTabunganImpian({
    required this.rasio,    // 0.0 - 1.0 (sudah di-clamp oleh helper)
    required this.saldo,    // Uang terkumpul
    required this.target,   // Target uang impian
    super.key,
  });

  final double rasio;
  final double saldo;
  final double target;
}
```

### Karakteristik
- **Pure widget** → tidak bergantung `Provider`/`BuildContext` untuk logika (hanya untuk theme/colorScheme).
- **Rasio di-clamp** → aman untuk `FractionallySizedBox.widthFactor`.
- **Warna kondisional** → hijau jika tercapai, `ColorScheme.primary` jika belum.
- **Spacing internal** → `Column(spacing: 8)` untuk progress bar + label.
- **Tabular figures** → angka uang pakai `FontFeature.tabularFigures()`.

### Penggunaan
```dart
VisualTabunganImpian(
  rasio: ImpianProgresHelper.rasio(uangDihemat, target),
  saldo: uangDihemat,
  target: target,
)
```

### Referensi Commit
- `c7337d1` — `lib/fitur/impian/widget/visual_tabungan_impian.dart`

---

## 2. _TimerCravingView (Timer Craving Terisolasi)

### Deskripsi
Widget `StatefulWidget` terisolasi untuk menampilkan timer durasi craving yang update setiap detik. Hanya widget ini yang rebuild, bukan halaman penuh.

### Pola Implementasi
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
      if (mounted) setState(() => _durasi = DateTime.now().difference(widget.mulai));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Format MM:SS dengan tabularFigures
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
```

### Penggunaan
```dart
// Di SosCravingScreen - hanya widget ini rebuild tiap detik
if (_waktuMulaiCraving != null)
  _TimerCravingView(mulai: _waktuMulaiCraving!),
```

### Referensi Commit
- `3b67d309` — `lib/fitur/sos_craving/screens/sos_craving_screen.dart`

---

## 3. _HeaderPemulihan (Header Durasi Smoke-Free Terisolasi)

### Deskripsi
Widget `StatefulWidget` terisolasi untuk menampilkan durasi smoke-free (hari/jam) yang update setiap detik di halaman Pemulihan Kesehatan.

### Pola Implementasi
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
      if (mounted) setState(() {}); // Rebuild widget ini saja
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Normalisasi tanggal WAJIB
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final berhentiDate = DateTime(
      widget.tanggalBerhenti.year,
      widget.tanggalBerhenti.month,
      widget.tanggalBerhenti.day,
    );
    final durasi = hariIniDate.difference(berhentiDate);
    final aman = durasi.isNegative ? Duration.zero : durasi; // Klamp negatif

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(spacing: 8, children: [
          Text('Smoke-free: ${aman.inDays} hari', style: ...),
          Text('Sejak ${FormatTanggal.formatLengkap(widget.tanggalBerhenti)}'),
        ]),
      ),
    );
  }
}
```

### Penggunaan
```dart
// Di PemulihanKesehatanScreen
SliverToBoxAdapter(
  child: _HeaderPemulihan(tanggalBerhenti: biodata.tanggalMulaiBerhentiMerokok!),
),
// SliverList milestone di bawah TIDAK rebuild tiap detik
```

### Referensi Commit
- `02aa6b29` — `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`

---

## 4. Empty State Widgets

### _EmptyDiaryCraving
```dart
class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              const Icon(CupertinoIcons.book, size: 48),
              const Text('Belum ada catatan craving', style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Tekan tombol + untuk mencatat craving pertama.', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => unawaited(Nav.to(context, const FormDiaryCraving()).catchError(...)),
                icon: const Icon(Icons.add),
                label: const Text('Tambah Craving'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### _PlaceholderAlasanBerhenti (SOS Craving)
```dart
class _PlaceholderAlasanBerhenti extends StatelessWidget {
  const _PlaceholderAlasanBerhenti();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(CupertinoIcons.heart, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Belum ada alasan berhenti. Tambahkan di menu Alasan Berhenti.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Pola Empty State Standar
1. `SafeArea` + `Padding(16)` (padding tepi layar di widget ini karena dipakai langsung di `Scaffold.body`).
2. `Column(spacing: 8)` atau `Row` dengan `spacing`.
3. Ikon + Judul Bold + Deskripsi.
4. CTA (FAB/FilledButton) dengan `unawaited(Nav.to(...).catchError(...))`.
3. **Tidak** pakai `SizedBox.shrink()` di sini (ditangani parent dengan early return).

### Referensi Commit
- `3b67d309` — `_EmptyDiaryCraving`
- `e659574` — `_PlaceholderAlasanBerhenti`

---

## 5. _ErrorRetry Widget (Reusable Error State)

### Deskripsi
Widget reusable untuk menampilkan error + tombol retry di layar yang memuat async data.

```dart
class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.onRetry, this.pesan = 'Gagal memuat data', super.key});
  final VoidCallback onRetry;
  final String pesan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              const Icon(CupertinoIcons.exclamationmark_triangle, size: 48, color: Colors.orange),
              Text(pesan, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(CupertinoIcons.refresh),
                label: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Penggunaan
```dart
if (dataAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(provider));
}
```

### Referensi Commit
- `3b67d309` — `DiaryCravingScreen`, `PemulihanKesehatanScreen`
- `19f43e5` — `BadgeScreen`

---

## 5. _LoadingView Widget (Reusable Loading State)

```dart
class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
```

---

## Pola Umum Widget Custom Reusable

| Prinsip | Implementasi |
|---------|--------------|
| **Single Responsibility** | Setiap widget handle 1 hal (timer, progress, empty, error, loading) |
| **Terisolasi Timer** | Timer di widget kecil sendiri, bukan halaman |
| **Pure Widget** | Logika bisnis di helper/provider, widget hanya render |
| **SafeArea + Padding** | Empty/Error/Loading state handle padding tepi sendiri |
| **unawaited + catchError** | Navigasi non-blocking dengan error handling |
| **textTheme + copyWith** | Styling konsisten via tema |
| **Column.spacing** | Jarak konsisten tanpa SizedBox berulang |

---

## Larangan

- **DILARANG** timer di widget halaman penuh.
- **DILARANG** aset gambar/Lottie untuk progress visual.
- **DILARANG** widget reusable ambil tanggung jawab padding tepi layar (kecuali empty/error/loading yang dipakai langsung di Scaffold.body).
- **DILARANG** logika bisnis (hitung rasio, cek tercapai) di widget → gunakan helper murni.

## Referensi Aturan Terkait

- `aturan_bersama.md` — Isolasi Widget Timer, Visualisasi Progres, Ekstraksi Perhitungan
- `aturan_khusus.md` — Visualisasi Progres, Timer Terisolasi, Empty State, Kartu Motivasi
- `pola-ui.md` — Visualisasi Progres, Timer Terisolasi
- `pola-ux.md` — Empty State, Kartu Motivasi