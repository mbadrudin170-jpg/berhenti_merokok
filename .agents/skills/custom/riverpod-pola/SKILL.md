---
name: riverpod-pola
description: Pola Riverpod standar - Notifier CRUD keepAlive, provider usage, Consumer/ref.watch/ref.read, family providers, autoDispose, overrides testing.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Pola Riverpod Standar

Skill ini mendokumentasikan pola Riverpod yang wajib diterapkan di proyek ini.

## 1. Notifier Database (CRUD)

### Aturan
- Gunakan `@Riverpod(keepAlive: true)` agar state tidak hilang saat tidak ada listener.
- Method `build()` wajib memanggil `_ambilSemua()` yang mengambil data dari database.
- CRUD update state **setelah** operasi DB berhasil.
- Catch `Exception` dan `rethrow` agar error propagate ke UI.

```dart
@Riverpod(keepAlive: true)
class BiodataNotifier extends _$BiodataNotifier {
  @override
  Future<BiodataModel?> build() => _ambilSemua();

  Future<BiodataModel?> _ambilSemua() async {
    final row = await SqfliteOp.ambilSatu(namaTabel: NamaTabel.biodata);
    return row != null ? BiodataModel.fromSqflite(row) : null;
  }

  Future<void> simpan(BiodataModel model) async {
    await SqfliteOp.sisipkan(namaTabel: NamaTabel.biodata, data: model.toSqflite());
    state = AsyncValue.data(await _ambilSemua());
  }
}
```

### Referensi
- `notifier-crud-database` skill untuk detail lengkap

## 2. Provider Usage: `ref.watch` vs `ref.read`

### Aturan
- **`ref.watch(provider)`** di `build()` widget → rebuild otomatis saat state berubah.
- **`ref.read(provider)`** di event handler / callback → tidak trigger rebuild.
- **JANGAN** `ref.watch` di callback/event handler (memory leak, rebuild tidak perlu).

```dart
// BENAR: watch di build
@override
Widget build(BuildContext context, WidgetRef ref) {
  final biodataAsync = ref.watch(biodataProvider);
  // ...
}

// BENAR: read di callback
onPressed: () {
  final notifier = ref.read(biodataProvider.notifier);
  notifier.simpan(model);
}

// SALAH: watch di callback
onPressed: () {
  final data = ref.watch(biodataProvider); // JANGAN
}
```

## 3. Consumer Widget & `Consumer`

### Aturan
- Gunakan `ConsumerWidget` / `ConsumerStatefulWidget` untuk akses `ref` di `build`.
- Untuk optimasi, bungkus bagian kecil saja dengan `Consumer(builder: (context, ref, _) => ...)`.
- **JANGAN** bungkus seluruh halaman besar dengan `Consumer` jika hanya sedikit butuh `ref`.

```dart
// Baik: ConsumerWidget
class BiodataScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biodataAsync = ref.watch(biodataProvider);
    // ...
  }
}

// Baik: Consumer granular
class _BiodataContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final biodata = ref.watch(biodataProvider.select((v) => v.valueOrNull));
    return Text(biodata?.nama ?? '-');
  }
}
```

## 4. Family Providers (Parameterized)

### Aturan
- Gunakan `.family` untuk provider yang butuh parameter (mis. ID item).
- Parameter harus **immutable** dan **comparable** (primitif, String, record).
- Key family harus stabil untuk caching yang benar.

```dart
@riverpod
Future<ImpianModel?> impianDetail(Ref ref, String impianId) async {
  final row = await SqfliteOp.ambilSatu(
    namaTabel: NamaTabel.impian,
    where: 'id = ?',
    whereArgs: [impianId],
  );
  return row != null ? ImpianModel.fromSqflite(row) : null;
}

// Penggunaan
final impianAsync = ref.watch(impianDetailProvider(impianId));
```

## 5. `autoDispose` untuk Provider Sementara

### Aturan
- Gunakan `@riverpod` + `autoDispose` (atau `@Riverpod(autoDispose: true)`) untuk provider yang **hanya** dibutuhkan saat layar aktif.
- Contoh: form controller, filter sementara, pencarian.
- State otomatis dibuang saat tidak ada listener.

```dart
@Riverpod(autoDispose: true)
class FormCravingController extends _$FormCravingController {
  @override
  FormCravingState build() => const FormCravingState();
  
  void updateTrigger(String t) => state = state.copyWith(trigger: t);
}

// Di widget: ref.watch(formCravingControllerProvider) // auto dispose saat unmount
```

## 6. Provider Overrides untuk Testing

### Aturan
- Gunakan `ProviderScope(overrides: [...], child: ...)` untuk mock provider di test.
- Override dengan `Provider.overrideWithValue` atau `Provider.overrideWithProvider`.

```dart
// Test widget
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      biodataProvider.overrideWithValue(AsyncValue.data(biodataDummy)),
    ],
    child: MaterialApp(home: BiodataScreen()),
  ),
);
```

## 7. `select` untuk Optimasi Rebuild

### Aturan
- Gunakan `ref.watch(provider.select((state) => state.fieldYangDibutuhkan))` agar widget hanya rebuild saat field tertentu berubah.
- Hindari rebuild seluruh widget saat hanya butuh subset state.

```dart
// Hanya rebuild saat nama berubah
final nama = ref.watch(biodataProvider.select((v) => v.valueOrNull?.nama));

// Hanya rebuild saat loading status berubah
final isLoading = ref.watch(biodataProvider.select((v) => v.isLoading));
```

## 8. AsyncValue Pattern di UI

### Aturan
- Tangani `isLoading` → `hasError` → `requireValue` (early return).
- Gunakan `asData?.value` untuk akses opsional tanpa throw.

```dart
final async = ref.watch(provider);
if (async.isLoading) return LoadingView();
if (async.hasError) return ErrorRetry(onRetry: () => ref.refresh(provider));
final data = async.requireValue; // atau async.asData?.value untuk opsional
```

### Referensi
- `penanganan-async-data-kosong`, `penanganan-asyncvalue-berkali` skills

## 9. Larangan

- **DILARANG** `ref.watch` di luar `build` (callback, initState, effect).
- **DILARANG** mutate state langsung (`state = ...`) di luar Notifier class.
- **DILARANG** `ProviderScope` nested di widget (hanya di `main.dart` / `app.dart`).
- **DILARANG** family parameter yang mutable (List, Map, custom object tanpa equality).

## Referensi Aturan Sumber

- `aturan_bersama.md` — Notifier CRUD, keepAlive, build/_ambilSemua, DB via SqfliteOp
- `aturan_khusus.md` — AsyncValue handling, multiple providers
- `notifier-crud-database` skill — detail Notifier CRUD

## Referensi Commit Terkait

- `3b67d309` — BiodataNotifier, AlasanBerhentiNotifier, dll.
- `19f43e5` — BadgeScreen multiple provider handling