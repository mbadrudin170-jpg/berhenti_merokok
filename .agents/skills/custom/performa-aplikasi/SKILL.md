---
name: performa-aplikasi
description: Aturan performa aplikasi - widget rebuild minimal, const constructor, listview builder, image caching, async gap, memory leak prevention, profilng.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "e6595744b3840998d840e398ca1782e7be7d50b4"
  model: "kilo-auto/free"
---

# Aturan Performa Aplikasi

Skill ini mendokumentasikan aturan performa yang wajib diterapkan di proyek ini.

## 1. Minimal Widget Rebuild

### Aturan
- **WAJIB** gunakan `const` constructor dimana mungkin (widget stateless, immutable data).
- **WAJIB** isolasi widget yang rebuild sering (Timer, Animation) ke widget terpisah (lihat `isolasi-widget-timer`).
- **WAJIB** gunakan `ref.watch(provider.select(...))` untuk hanya rebuild saat field tertentu berubah (lihat `riverpod-pola`).
- **DILARANG** `setState` di widget parent besar untuk update kecil → extract ke child widget.

```dart
// BENAR: const widget stateless
const _EmptyDiaryCraving();

// BENAR: select hanya field yang butuh
final nama = ref.watch(biodataProvider.select((v) => v.valueOrNull?.nama));

// SALAH: watch full provider cuma butuh nama
final biodata = ref.watch(biodataProvider); // Rebuild saat field lain berubah
```

### Referensi
- `isolasi-widget-timer` skill
- `riverpod-pola` skill (select optimization)

## 2. ListView/GridView Builder (Lazy Loading)

### Aturan
- **WAJIB** gunakan `ListView.builder` / `GridView.builder` untuk daftar panjang/dinamis.
- **DILARANG** `ListView(children: [...])` dengan list sudah di-materialize semua.
- Gunakan `itemExtent` / `prototypeItem` untuk performa scroll lebih baik.

```dart
// BENAR: builder lazy
ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) => ItemWidget(item: list[index]),
)

// BENAR: itemExtent untuk fixed height
ListView.builder(
  itemCount: list.length,
  itemExtent: 80,
  itemBuilder: (context, index) => ItemWidget(item: list[index]),
)

// SALAH: children materialized semua
ListView(children: list.map((e) => ItemWidget(item: e)).toList())
```

## 3. Image & Asset Caching

### Aturan
- **WAJIB** gunakan `Image.asset` / `Image.network` dengan `cacheWidth`/`cacheHeight` untuk downsample.
- **DILARANG** load image resolusi besar (mis. 4000px) ke widget kecil (mis. 100px) tanpa downsample.
- Asset image di `pubspec.yaml` `flutter: assets:` → otomatis dikemas & dicache.
- Network image: pakai `cached_network_image` package untuk disk cache.

```dart
// Downsample asset
Image.asset(
  'assets/large_image.png',
  cacheWidth: 200, // Resize di decode
  cacheHeight: 200,
)

// Network dengan cache
CachedNetworkImage(
  imageUrl: url,
  memCacheWidth: 200,
  memCacheHeight: 200,
  placeholder: (_, _) => const CircularProgressIndicator(),
)
```

## 4. Async Gap & Microtask Yielding

### Aturan
- Operasi berat (parse JSON besar, hitung statistik, query DB kompleks) **WAJIB** offload ke `compute()` / `Isolate` atau gunakan `Future.microtask` / `SchedulerBinding.instance.scheduleTask` untuk yield ke event loop.
- **DILARANG** blocking computation di main thread > 16ms (frame drop).

```dart
// Offload ke isolate untuk JSON parse besar
final data = await compute(parseJsonBesar, jsonString);

// Atau yield ke event loop untuk batch processing
for (final item in items) {
  await Future.microtask(() => processItem(item));
  // UI tetap responsif di antara item
}
```

## 5. Memory Leak Prevention

### Aturan
- **WAJIB** `cancel()` Timer/StreamSubscription di `dispose()` (lihat `isolasi-widget-timer`).
- **WAJIB** `dispose()` `AnimationController`, `TextEditingController`, `ScrollController`.
- **WAJIB** cek `mounted` sebelum `setState` di async callback (lihat `isolasi-widget-timer`).
- **WAJIB** `ref.listen` / `ref.listenManual` cleanup di `dispose` kalau pakai manual listen.
- **DILARANG** closure capture `BuildContext` di async gap lama.

```dart
// BENAR: cleanup di dispose
@override
void dispose() {
  _timer?.cancel();
  _controller.dispose();
  _subscription.cancel();
  super.dispose();
}

// BENAR: mounted check
_timer = Timer.periodic(Duration(seconds: 1), (_) {
  if (mounted) setState(() {});
});
```

## 6. Const & Final Optimization

### Aturan
- **WAJIB** `const` untuk widget, list, map, object yang immutable.
- **WAJIB** `final` untuk variable yang tidak di-reassign.
- **WAJIB** `const` di `switch` expression / pattern matching case.

```dart
// BENAR
const _EmptyDiaryCraving();
final textTheme = Theme.of(context).textTheme;
const padding = EdgeInsets.all(16);

// Pattern matching const
switch (status) {
  case Status.loading: return const LoadingView();
  case Status.error: return const ErrorView();
  case Status.success: return SuccessView(data: data);
}
```

## 7. Database Query Optimization

### Aturan
- **WAJIB** `where` + `whereArgs` (parameterized query) - bukan string interpolation.
- **WAJIB** index di kolom yang sering di-query (WHERE, JOIN, ORDER BY).
- **WAJIB** `LIMIT` untuk query yang tidak butuh semua row.
- Gunakan `queryCursor` / `queryIterate` untuk result set besar (streaming).

```dart
// BENAR: parameterized + index + limit
final rows = await db.query(
  NamaTabel.craving,
  where: '${NamaKolom.tanggal} >= ? AND ${NamaKolom.tanggal} <= ?',
  whereArgs: [start.toIso8601String(), end.toIso8601String()],
  orderBy: '${NamaKolom.tanggal} DESC',
  limit: 50,
)
```

### Referensi
- `sqflite-crud-and-transactions` skill

## 8. Build Size Optimization

### Aturan
- **WAJIB** `--split-debug-info` / `--obfuscate` di release build (CI handle).
- **DILARANG** dependency tidak dipakai (cek `dart pub deps --style=compact`).
- **DILARANG** asset image tidak dipakai di `pubspec.yaml`.
- Gunakan `flutter build apk --analyze-size` untuk audit ukuran.

## 9. Profiling & Monitoring

### Aturan
- **WAJIB** test performa di device fisik (low-end) bukan hanya emulator.
- Gunakan `flutter run --profile` + DevTools (Performance, Memory, CPU tabs).
- Target: 60fps (16ms/frame), no jank > 50ms, memory stabil tidak naik terus.
- Log `L.i` untuk marking critical path timing (opsional).

## 10. Larangan Performa

- **DILARANG** `Opacity` widget wrapping subtree besar (gunakan `color.withValues(alpha:)` di child).
- **DILARANG** `ClipRect` / `ClipRRect` tanpa butuh (costly).
- **DILARANG** `Stack` dengan banyak `Positioned` overlapping kompleks (consider `CustomPainter`).
- **DILARANG** `ListView` nested tanpa `shrinkWrap: true` + `physics: NeverScrollableScrollPhysics()`.
- **DILARANG** `setState` di loop / callback cepat tanpa debounce.

## Referensi Aturan Sumber

- `aturan_bersama.md` — Isolasi widget timer, type promotion, async handling
- `isolasi-widget-timer` skill
- `riverpod-pola` skill (select optimization)
- `sqflite-crud-and-transactions` skill
- `withvalues-opacity-warna` skill / `gaya` skill

## Referensi Commit Terkait

- `3b67d309` — Timer isolation, select optimization
- `e659574` — Dashboard multiple provider select
- `02aa6b29` — Lazy IndexedStack di Home