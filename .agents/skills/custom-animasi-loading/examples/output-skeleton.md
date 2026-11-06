# Output

> Satu halaman `ArticleListPage` dengan state loading. Saat `_isLoading == true`, halaman menampilkan `_LoadingView` — satu class privat yang membungkus seluruh skeleton dalam **satu** `Shimmer.fromColors`. Saat data siap, `_LoadingView` dibuang dan `ListView` artikel tampil. `AnimationController` internal shimmer berhenti saat `_LoadingView` di-`dispose`. Jika `MediaQuery.disableAnimations == true`, shimmer tidak dibuat dan placeholder tampil solid.

## Langkah 1 — Dependensi

```bash
flutter pub add shimmer
```

## Langkah 2 — File halaman (dua class)

```dart
// lib/article_list_page.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'article.dart';
import 'article_tile.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  bool _isLoading = true;
  List<Article> _articles = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await fetchArticles();
    if (!mounted) return;
    setState(() {
      _articles = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Artikel')),
      body: _isLoading
          ? const _LoadingView()
          : ListView.builder(
              itemCount: _articles.length,
              itemBuilder: (_, i) => ArticleTile(article: _articles[i]),
            ),
    );
  }
}

/// Animasi loading khusus halaman ini. Semua placeholder dibuat inline.
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    final list = ListView.builder(
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 14, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 14, width: 180, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 12, width: 120, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Semantics(
      label: 'Memuat artikel',
      liveRegion: true,
      child: reduceMotion
          ? list
          : Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: list,
            ),
    );
  }
}
```

## Struktur

| Class             | Akses  | Peran                                                    |
| ----------------- | ------ | -------------------------------------------------------- |
| `ArticleListPage` | publik | Halaman: fetch data, kelola `_isLoading`, pilih tampilan |
| `_LoadingView`    | privat | Animasi loading khusus halaman ini                       |

Placeholder baris dibuat langsung di `itemBuilder` — inline karena hanya dipakai di sini.

## Yang Dihasilkan

- Satu `Shimmer.fromColors` membungkus seluruh `ListView` — satu ticker untuk enam baris.
- `Semantics(label: 'Memuat artikel', liveRegion: true)` mengumumkan status ke screen reader.
- Fallback statis saat `MediaQuery.disableAnimations == true`.
- `Shimmer` di-`dispose` otomatis ketika `_isLoading` menjadi `false` dan `_LoadingView` dibuang dari tree.

## Kapan Menambah Class Privat Kedua

Hanya jika placeholder yang sama dipakai di ≥ 2 halaman. Saat itu baru ekstrak ke widget bersama (mis. `ArticleSkeletonList`). Untuk satu halaman, inline.

## Catatan Versi

Jika proyek memakai `shimmer: ^4.0.0` (Flutter 3.44+) dan konflik dengan `package:flutter/material.dart`, tambahkan `material_ui: ^1.0.1` lalu bungkus `_LoadingView` dengan `MaterialUiCompatibilityBridge`. Untuk Flutter stabil di bawah 3.44, gunakan `shimmer: ^3.0.0` tanpa perubahan kode.
