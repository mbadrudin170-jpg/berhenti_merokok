# Pola Animasi Loading (satu halaman, satu `_LoadingView`)

Kumpulan potongan siap pakai. Pilih yang relevan — jangan salin seluruh file ke output.

Aturan tetap: **satu halaman publik + satu `_LoadingView` privat**. Semua placeholder inline di dalam `_LoadingView`.

---

## 0. Dependensi & Cara Kerja

```yaml
dependencies:
  flutter:
    sdk: flutter
  shimmer: ^4.0.0 # Flutter 3.44+
  material_ui: ^1.0.1
```

**Catatan versi**: `shimmer 4.0` menggunakan package `material_ui` standalone. Aplikasi yang masih meng-import `package:flutter/material.dart` dapat membungkus subtree shimmer dengan `MaterialUiCompatibilityBridge`.[reference:10] Untuk Flutter stabil di bawah 3.44, gunakan `shimmer: ^3.0.0`.

**Cara kerja internal**: `Shimmer` menggerakkan `AnimationController` dan melukis `ShaderMaskLayer` di atas child dengan `BlendMode.srcIn`. Persegi panjang highlight berukuran **tiga kali** ukuran child agar band dapat melintas sepenuhnya.[reference:11]

```dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
```

---

## 1. Skeleton List — Halaman + `_LoadingView`

```dart
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

**Satu `Shimmer`** membungkus seluruh `ListView`. Dokumentasi resmi: "Wrap a list of placeholders in one Shimmer, not one Shimmer per row."[reference:12]

---

## 2. Skeleton Kartu Profil (masih inline di `_LoadingView`)

Jika halaman berupa profil, ganti isi `_LoadingView` (child `Shimmer`) dengan susunan ini — tetap inline, tidak ada class kartu terpisah.

```dart
child: Padding(
  padding: const EdgeInsets.all(16),
  child: Row(
    children: [
      Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 16, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 12, width: 140, color: Colors.white),
          ],
        ),
      ),
    ],
  ),
),
```

---

## 3. Dark Theme

Dokumentasi resmi menyarankan `grey.shade800` / `grey.shade600` untuk dark theme.[reference:13]

```dart
final isDark = Theme.of(context).brightness == Brightness.dark;

Shimmer.fromColors(
  baseColor: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
  highlightColor: isDark ? Colors.grey.shade600 : Colors.grey.shade100,
  child: list,
);
```

---

## 4. Arah, Kecepatan, dan Loop (parameter resmi)

```dart
Shimmer.fromColors(
  direction: ShimmerDirection.rtl,               // ltr | rtl | ttb | btt
  period: const Duration(milliseconds: 1200),    // default 1500ms
  loop: 0,                                       // 0 = infinite
  enabled: isLoading,                            // false = ticker berhenti
  baseColor: Colors.grey.shade300,
  highlightColor: Colors.grey.shade100,
  child: list,
);
```

Tabel parameter resmi dari dokumentasi:

| Parameter   | Default    | Role                                                                |
| ----------- | ---------- | ------------------------------------------------------------------- |
| `child`     | required   | Area opaque tempat highlight di-blend[reference:14]                 |
| `gradient`  | required\* | Warna highlight (dibangun otomatis oleh `fromColors`)[reference:15] |
| `direction` | `ltr`      | `ltr`, `rtl`, `ttb`, `btt`[reference:16]                            |
| `period`    | `1500ms`   | Durasi satu siklus[reference:17]                                    |
| `loop`      | `0`        | Berhenti setelah N kali; `0` = selamanya[reference:18]              |
| `enabled`   | `true`     | `false` menghentikan animasi[reference:19]                          |

---

## 5. Gradient Kustom dari `Theme`

Dokumentasi: gunakan konstruktor default `Shimmer(gradient: ...)` saat butuh `RadialGradient`, `SweepGradient`, atau `LinearGradient` yang mengikuti `Theme`.[reference:20]

```dart
Shimmer(
  gradient: LinearGradient(
    colors: [
      Theme.of(context).colorScheme.surfaceContainerHighest,
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.surfaceContainerHighest,
    ],
    stops: const [0.35, 0.5, 0.65],
  ),
  period: const Duration(milliseconds: 1400),
  child: list,
);
```

---

## 6. Fallback Reduce Motion

Selalu di dalam `_LoadingView`:

```dart
final reduceMotion = MediaQuery.of(context).disableAnimations;

return Semantics(
  label: 'Memuat …',
  liveRegion: true,
  child: reduceMotion
      ? list                      // placeholder statis
      : Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: list,
        ),
);
```

`list` adalah susunan `Container` solid yang sama. Saat reduce motion aktif, gradient tidak dibuat sama sekali.

---

## 7. Spinner untuk Aksi Tunggal (tombol submit)

Untuk tombol, tidak perlu `_LoadingView`. Cukup inline di tombol:

```dart
ElevatedButton(
  onPressed: _isSubmitting ? null : _submit,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (_isSubmitting) ...[
        const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
        const SizedBox(width: 8),
      ],
      Text(_isSubmitting ? 'Memproses…' : 'Kirim'),
    ],
  ),
)
```

`CircularProgressIndicator` sudah aksesibel secara bawaan.

---

## 8. Integrasi `FutureBuilder`

Jika halaman memakai `FutureBuilder`, `_LoadingView` dipanggil di state `waiting`:

```dart
FutureBuilder<List<Article>>(
  future: _future,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const _LoadingView();
    }
    if (snapshot.hasError) {
      return const Center(child: Text('Gagal memuat'));
    }
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (_, i) => ArticleTile(article: snapshot.data![i]),
    );
  },
)
```

`Shimmer` internal berhenti otomatis saat `_LoadingView` dibuang dari tree.

---

## 9. Catatan Performa (dari dokumentasi resmi)

- **Satu `Shimmer` per list**, bukan per baris.[reference:21]
- **Jaga `child` sederhana dan statis.** Widget mewah (`Image`, `Text` berdekorasi, `elevation`) sering terlihat salah karena shader mengganti warnanya.[reference:22]
- **Toggle `enabled` ke `false`** saat loading selesai agar ticker berhenti.[reference:23]
- `Shimmer` menggerakkan `AnimationController` dan melukis `ShaderMaskLayer` (`BlendMode.srcIn`); highlight berukuran 3× child.[reference:24]
