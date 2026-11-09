---
name: empty-state-daftar
description: Panduan empty state pada daftar - tampilkan widget informatif (ikon, judul, deskripsi), sertakan CTA (FAB), bungkus SafeArea + padding.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Empty State pada Daftar

Ketika daftar kosong, tampilkan widget empty state informatif dengan CTA, bungkus SafeArea + padding.

## Aturan

1. Ketika daftar data kosong, tampilkan widget empty state yang informatif (ikon, judul, deskripsi singkat).
2. Sertakan call-to-action (mis. tombol FAB) agar pengguna dapat menambah data.
3. Empty state wajib dibungkus `SafeArea` dan memiliki padding tepi layar.

## Larangan

- Jangan menampilkan layar kosong tanpa informasi atau CTA.

## Contoh Benar

```dart
class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.book, size: 48),
              Text('Belum ada catatan craving', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Tekan tombol + untuk mencatat craving pertama.', textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Contoh Salah

```dart
if (list.isEmpty) return const Scaffold(body: SizedBox.shrink());
```

## Sumber Evaluasi

- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/screens/diary_craving_screen.dart`