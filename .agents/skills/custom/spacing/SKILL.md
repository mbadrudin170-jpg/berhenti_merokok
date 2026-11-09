---
name: spacing
description: Panduan spacing: penggunaan properti spacing pada Row/Column, SizedBox hanya untuk kebutuhan khusus, konsistensi jarak berdasarkan optimasi_ui.md.
kategori: custom
versi: 1.0.0
commit-terakhir: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
---

# Panduan Spacing (Jarak Antar Elemen)

Skill ini mendokumentasikan aturan pengaturan jarak antar elemen UI berdasarkan `optimasi_ui.md` dan implementasi nyata.

## 1. Properti `spacing` pada Row/Column (WAJIB)

### Aturan
- **WAJIB** gunakan properti `spacing` pada `Row` dan `Column` untuk jarak antar anak yang seragam.
- **DILARANG** menggunakan `SizedBox` berulang hanya untuk jarak standar antar anak.
- Gunakan `SizedBox` **hanya** untuk kebutuhan jarak khusus yang tidak bisa ditangani `spacing`.

### Contoh
```dart
// BENAR: spacing property
Column(
  spacing: 16, // Jarak seragam 16 antar semua anak
  children: [
    Text('Judul'),
    Text('Deskripsi'),
    Text('Lainnya'),
  ],
)

Row(
  spacing: 12,
  children: [
    Icon(Icons.star),
    Text('Rating'),
    Text('4.5'),
  ],
)

// SALAH: SizedBox berulang
Column(
  children: [
    Text('Judul'),
    SizedBox(height: 16),
    Text('Deskripsi'),
    SizedBox(height: 16),
    Text('Lainnya'),
  ],
)
```

### Referensi Commit
- `3b67d309` — `Column(spacing: 8)` di `_EmptyDiaryCraving`, `VisualTabunganImpian`
- `c7337d1` — `Column(spacing: 12)` di card impian
- `e659574` — `Column(spacing: 8)` di kartu motivasi dashboard

## 2. `SizedBox` Hanya untuk Kebutuhan Khusus

### Kapan Boleh Pakai `SizedBox`
- Jarak **tidak seragam** antar anak tertentu (mis. jarak besar sebelum tombol aksi).
- Jarak di dalam widget yang **bukan** `Row`/`Column` (mis. `Container` padding internal).
- Spacing horizontal di `Wrap` (gunakan `spacing` + `runSpacing` di `Wrap`).

```dart
// BENAR: SizedBox untuk jarak khusus (sebelum FAB)
Column(
  spacing: 8,
  children: [
    Text('Label'),
    Text('Nilai'),
    const SizedBox(height: 24), // Jarak khusus besar sebelum tombol
    FilledButton(onPressed: ..., child: Text('Aksi')),
  ],
)

// BENAR: Wrap spacing
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: chips.map((c) => FilterChip(...)).toList(),
)
```

## 3. Padding Tepi Layar (Screen Padding)

### Aturan (dari `optimasi_ux.md` #10)
- Padding tepi layar = tanggung jawab **container halaman/parent**, bukan widget reusable.
- Widget reusable **BOLEH** punya padding internal untuk desain komponennya (mis. `Card` padding isi).
- **DILARANG** widget reusable ambil alih tanggung jawab padding tepi layar.
- **DILARANG** padding ganda (parent sudah padding, anak juga padding tepi).
- Nilai padding **WAJIB** mengikuti `optimasi_ui.md`.

### Struktur Benar
```dart
// Halaman (Parent) - bertanggung jawab padding tepi layar
Scaffold(
  body: SafeArea(
    child: Padding(
      padding: EdgeInsets.all(16), // Mengikuti optimasi_ui.md
      child: ListView(
        children: [
          RingkasanWidget(),     // Widget reusable - HANYA padding internal
          StatistikWidget(),     // Widget reusable - HANYA padding internal
          DaftarWidget(),        // Widget reusable
        ],
      ),
    ),
  ),
)

// Widget Reusable (Card dengan padding internal)
class RingkasanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16), // Padding INTERNAL komponen
        child: Column(...),
      ),
    );
  }
}
```

### Referensi Commit
- `3b67d309` — `_EmptyDiaryCraving` pakai `Padding(16)` di dalam `SafeArea`
- `e659574` — Dashboard `Padding` di `SafeArea` → `ListView`

## 4. Konsistensi Jarak (dari `optimasi_ux.md` #11)

### Aturan
- Jarak antarelemen **WAJIB** serasi, proporsional, konsisten per `optimasi_ui.md`.
- Bedakan jarak berdasarkan: hubungan antar elemen, kelompok konten, bagian halaman.
- **DILARANG** jarak terlalu sempit (berhimpitan) atau terlalu lebar (tidak berkaitan).
- **DILARANG** nilai padding/margin acak tanpa referensi desain.

### Skala Spacing Standar (contoh)
| Konteks | Nilai | Penggunaan |
|---------|-------|------------|
| `spacing` Row/Column dalam card | 8 | Elemen terkait dekat (label+nilai) |
| `spacing` Row/Column antar card | 12-16 | Kelompok konten terpisah |
| `padding` Card/Container internal | 16 | Padding standar komponen |
| `padding` Halaman (tepi layar) | 16 | Mengikuti `optimasi_ui.md` |
| `runSpacing` Wrap chips | 8 | Baris baru chip |
| `SizedBox` khusus sebelum aksi | 24 | Separator visual sebelum FAB/tombol utama |

---

## Larangan

- **DILARANG** `SizedBox` berulang untuk jarak standar di `Row`/`Column`.
- **DILARANG** widget reusable mengandung padding tepi layar.
- **DILARANG** padding ganda (parent + anak keduanya padding tepi).
- **DILARANG** nilai spacing acak tanpa acuan `optimasi_ui.md`.

## Referensi Aturan Terkait

- `optimasi_ui.md` — Pengaturan Jarak, Padding Tepi Layar
- `optimasi_ux.md` — Padding Tepi Layar (#10), Konsistensi Jarak (#11)
- `aturan_bersama.md` — Penggunaan `spacing` Row/Column (Pemanfaatan Paket 3.1)