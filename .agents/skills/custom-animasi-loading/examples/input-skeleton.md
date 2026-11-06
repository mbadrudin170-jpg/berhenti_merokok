# Input

> "Bikin halaman daftar artikel Flutter dengan animasi loading. Satu class privat khusus untuk loading view, pakai shimmer, satu shimmer untuk seluruh skeleton, hormati reduce motion. Aku sudah punya class `Article` dan widget `ArticleTile`."

# Ekspektasi

- Satu file Dart berisi **dua class**: `ArticleListPage` (publik) dan `_LoadingView` (privat).
- `_LoadingView` membungkus seluruh `ListView` placeholder dengan **satu** `Shimmer.fromColors`.
- Placeholder baris dibuat **inline** di `itemBuilder` — tidak ada `_SkeletonTile`.
- `Semantics(label: 'Memuat artikel', liveRegion: true)` di wrapper.
- Fallback statis saat `MediaQuery.disableAnimations == true`.
- `_LoadingView` diganti `ListView` artikel saat `_isLoading == false`.
- `if (!mounted) return;` sebelum `setState` setelah `await`.

# Batasan

- **Dua class total** dalam file: satu halaman publik, satu `_LoadingView` privat.
- Jangan buat class tambahan untuk tile, kartu, atau wrapper adaptif.
- Jangan gunakan `skeletonizer_plus` atau package skeleton lain.
- Jangan membuat `AnimationController` manual.
- Jangan bungkus setiap baris dengan `Shimmer` sendiri.
