---
name: tipografi
description: Panduan tipografi: penggunaan textTheme, copyWith untuk customisasi, hierarki visual label/sub-label/nilai, dan penggunaan bold terarah.
kategori: custom
versi: 1.0.0
commit-terakhir: c7337d1519d495d0ccd022fb18d63f72d443866a
---

# Panduan Tipografi

Skill ini mendokumentasikan aturan tipografi berdasarkan `optimasi_ui.md` dan implementasi nyata.

## 1. Referensi Utama: `textTheme`

### Aturan
- **WAJIB** gunakan `Theme.of(context).textTheme` sebagai referensi utama gaya teks.
- **WAJIB** gunakan `copyWith()` untuk menyesuaikan (bold, warna, ukuran) dari style dasar tema.
- **DILARANG** menentukan `fontSize`, `fontWeight`, `fontFamily` manual tanpa acuan `textTheme` (kecuali hardcode diperlukan khusus).

### Contoh
```dart
final textTheme = Theme.of(context).textTheme;

// BENAR: Berbasis textTheme + copyWith
Text(
  'Judul Halaman',
  style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
)
Text(
  'Deskripsi',
  style: textTheme.bodyMedium?.copyWith(color: textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
)
Text(
  'Nilai Utama',
  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
)

// SALAH: Manual tanpa acuan tema
Text('Judul', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
Text('Nilai', style: TextStyle(fontSize: 18, color: Colors.blue)),
```

## 2. Hierarki Visual: Label → Sub-Label → Nilai

### Aturan
- Setiap tingkat teks **WAJIB** memiliki perbedaan minimal 1 properti gaya (ukuran, ketebalan, warna).
- **DILARANG** dua tingkat informasi berbeda menggunakan gaya identik.
- Gunakan `textTheme` sebagai dasar, `copyWith()` untuk variasi.

### Pola Standar (Card Info)
```dart
final textTheme = Theme.of(context).textTheme;

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  spacing: 4,
  children: [
    // Level 1: Label (kecil, warna secondary/muted)
    Text('Total Pengeluaran', style: textTheme.bodySmall),
    
    // Level 2: Sub-Label (sedang, warna secondary)
    Text('Pengeluaran bulan ini', 
      style: textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
    ),
    
    // Level 3: Nilai Utama (besar, bold, warna primary/onSurface)
    Text('Rp500.000', 
      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    ),
  ],
)
```

### Referensi Commit
- `c7337d1` — DetailImpianScreen hierarki label/sub-label/nilai
- `e659574` — Dashboard kartu motivasi

## 3. Penggunaan Bold Terarah

### Aturan
- **WAJIB** gunakan bold untuk: judul halaman, informasi utama, nilai penting, elemen butuh penekanan.
- **DILARANG** bold pada seluruh teks.
- **DILARANG** teks biasa lebih dominan dari informasi utama.
- Konsisten pada bagian yang fungsi serupa.

### Contoh
```dart
// BENAR: Bold terarah
Text('Hari ke-30', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)), // Nilai penting
Text('Smoke-free', style: textTheme.bodyMedium), // Label biasa

// SALAH: Semua bold
Text('Label', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
Text('Nilai', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
```

## 4. Text Overflow Handling

### Aturan
- **WAJIB** antisipasi teks panjang yang bisa overflow.
- Gunakan `FittedBox` atau `Flexible` **hanya** pada bagian yang benar-benar butuh.
- **DILARANG** terapkan `FittedBox`/`Flexible` sembarangan di semua teks.

### Contoh
```dart
// Hanya untuk teks yang WAJIB terlihat penuh (mis. judul card terbatas lebar)
FittedBox(
  fit: BoxFit.scaleDown,
  alignment: Alignment.centerLeft,
  child: Text(namaImpianPanjang, style: textTheme.titleMedium),
)

// Atau Flexible di Row
Row(
  children: [
    Expanded(
      child: Text(namaPanjang, style: textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
    ),
    Icon(Icons.chevron_right),
  ],
)
```

## 5. Tabular Figures untuk Timer/Angka

### Aturan
- Timer, jam, angka monetary **WAJIB** pakai `FontFeature.tabularFigures()` agar lebar digit sama (tidak bergeser saat update).

```dart
Text(
  '$menit:$detik',
  style: textTheme.displayMedium?.copyWith(
    fontWeight: FontWeight.bold,
    fontFeatures: const [FontFeature.tabularFigures()],
  ),
)
Text(
  FormatUang.format(uang),
  style: textTheme.titleLarge?.copyWith(
    fontFeatures: const [FontFeature.tabularFigures()],
  ),
)
```

### Referensi Commit
- `3b67d309` — `_TimerCravingView` pakai `tabularFigures`
- `c7337d1` — `VisualTabunganImpian` nilai uang

---

## Larangan

- **DILARANG** `TextStyle(fontSize: ..., fontWeight: ...)` manual tanpa `textTheme`.
- **DILARANG** hierarki visual dengan gaya identik untuk tingkat berbeda.
- **DILARANG** bold sembarangan tanpa hierarki jelas.
- **DILARANG** `FittedBox`/`Flexible` di seluruh teks tanpa alasan.

## Referensi Aturan Terkait

- `optimasi_ui.md` — Pengaturan Tipografi, Text Overflow
- `aturan_khusus.md` — Visualisasi Progres, Kartu Motivasi