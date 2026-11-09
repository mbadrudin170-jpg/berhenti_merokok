---
name: gaya
description: Panduan styling: penggunaan withValues untuk opacity warna, konsistensi warna tema, dan aturan warna hardcode vs ColorScheme.
kategori: custom
versi: 1.0.0
commit-terakhir: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
---

# Panduan Styling (Gaya)

Skill ini mendokumentasikan aturan styling warna dan tema berdasarkan implementasi nyata.

## 1. Opacity Warna: `withValues` (WAJIB)

### Aturan
- **WAJIB** gunakan `warna.withValues(alpha: ...)` untuk mengatur opacity.
- **DILARANG** gunakan `warna.withOpacity(...)` (deprecated sejak Flutter 3.47+).
- Konsisten di seluruh widget.

### Contoh
```dart
// BENAR
Container(
  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
)
LinearProgressIndicator(
  backgroundColor: warnaProgres.withValues(alpha: 0.2),
  valueColor: AlwaysStoppedAnimation(warnaProgres),
)
Colors.black.withValues(alpha: 0.5), // Overlay modal

// SALAH (deprecated)
warna.withOpacity(0.2)
```

### Referensi Commit
- `3b67d309` — `warna.withValues(alpha: 0.2)` di `SosCravingScreen`

## 2. Warna Tema vs Hardcode

### Aturan
- **WAJIB** gunakan warna dari `Theme.of(context).colorScheme` untuk teks & komponen UI agar menyesuaikan mode terang/gelap.
- **DIPERBOLEHKAN** warna hardcode (HEX/RGBA) **hanya** jika warna **harus tetap sama** di kedua mode tema (mis. brand color, status color semantic: hijau sukses, merah error, kuning warning).
- **DILARANG** mengubah nilai HEX/RGBA yang sudah ada menjadi referensi `ColorScheme` jika memang harus tetap.

### Contoh
```dart
// MENGIKUTI TEMA (WAJIB untuk UI umum)
Text('Judul', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
Card(color: Theme.of(context).colorScheme.surfaceContainerHighest),
FilledButton(onPressed: ..., child: Text('Simpan')), // Otomatis pakai ColorScheme

// HARDCODE DIPERBOLEHKAN (harus sama di light/dark)
Container(color: const Color(0xFF4CAF50), child: ...), // Brand green
Icon(Icons.check_circle, color: const Color(0xFF4CAF50)), // Status sukses
Icon(Icons.error, color: const Color(0xFFEF5350)), // Status error
Icon(Icons.warning, color: const Color(0xFFFF9800)), // Status warning

// Progress bar warna kondisional (semantic)
final warnaProgres = sudahTercapai ? Colors.green : Theme.of(context).colorScheme.primary;
```

### Referensi Commit
- `3b67d309` — Warna progress bar kondisional (hijau/primary)
- `c7337d1` — `VisualTabunganImpian` warna semantic

## 3. Chip Status Pencapaian

### Pola
Gunakan `Chip` dengan warna background semantic untuk status:
```dart
// Tercapai - hijau
Chip(
  label: Text('Tercapai!', style: TextStyle(color: Colors.green)),
  backgroundColor: Color(0xFFE8F5E9), // Green 50
)

// Belum - primary
Chip(
  label: Text('Belum', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
)
```

## 4. Loading Overlay (EasyLoading)

### Aturan
- Gunakan `flutter_easyloading` sesuai konfigurasi proyek.
- **WAJIB** `.catchError(...)` pada `unawaited(EasyLoading.show/dismiss)`.
- Mask type: `EasyLoadingMaskType.black` untuk operasi blocking.

```dart
unawaited(
  EasyLoading.show(
    status: 'Memproses...',
    maskType: EasyLoadingMaskType.black,
  ).catchError((e, s) => L.e('Gagal loading: $e $s')),
);
```

---

## Larangan

- **DILARANG** `withOpacity()` → gunakan `withValues(alpha:)`.
- **DILARANG** hardcode warna untuk komponen yang harus ikut tema.
- **DILARANG** `EasyLoading.show/dismiss` tanpa `.catchError()` pada `unawaited()`.

## Referensi Aturan Terkait

- `aturan_bersama.md` — withValues Opacity
- `aturan_khusus.md` — Standar Notifikasi, Visualisasi Progres
- `optimasi_ui.md` — Penggunaan Warna dan Tema