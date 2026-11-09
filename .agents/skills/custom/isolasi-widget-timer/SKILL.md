---
name: isolasi-widget-timer
description: Panduan mengisolasi widget yang diperbarui berkala (Timer.periodic) ke widget terpisah agar hanya widget tersebut yang rebuild, bukan seluruh halaman.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Isolasi Widget yang Diperbarui Berkala (Timer/Animasi)

Widget yang diperbarui secara berkala (mis. `Timer.periodic` per detik) wajib diisolasi ke widget terpisah (`StatefulWidget`) agar hanya widget tersebut yang melakukan rebuild.

## Aturan

1. Widget yang diperbarui secara berkala wajib diisolasi ke widget terpisah (`StatefulWidget`) agar hanya widget tersebut yang melakukan rebuild, bukan seluruh halaman.
2. Timer wajib dibatalkan (`cancel()`) di `dispose()` widget yang memilikinya.
3. Di dalam callback timer, periksa `mounted` sebelum memanggil `setState`.
4. Jangan menjalankan `Timer.periodic` pada widget yang mencakup seluruh halaman apabila hanya sebagian tampilan yang perlu diperbarui.
5. Jangan membiarkan timer tetap aktif setelah widget tidak lagi terpasang.

## Contoh Benar

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
    // hanya widget ini yang rebuild tiap detik
    return Text('Hari ke-${_hitungHari()}');
  }
}
```

## Contoh Salah

```dart
// Timer.periodic dijalankan di widget tingkat halaman, menyebabkan
// seluruh halaman rebuild setiap detik.
class _HalamanState extends State<Halaman> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {}); // rebuild seluruh halaman
    });
  }
}
```

## Sumber Evaluasi

- Commit: `02aa6b29b0669a4f5bf21651b09b43552f65d6f8`, `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`, `lib/fitur/sos_craving/screens/sos_craving_screen.dart`