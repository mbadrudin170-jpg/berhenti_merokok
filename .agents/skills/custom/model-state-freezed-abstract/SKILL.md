---
name: model-state-freezed-abstract
description: Panduan model dan state Freezed menggunakan abstract class - wajib abstract class, factory fromSqflite, method toSqflite, ParserUtil, konversi UTC.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Model dan State Freezed menggunakan `abstract class`

Model/state Freezed wajib `abstract class`, factory `fromSqflite`, method `toSqflite`, parsing via `ParserUtil`, konversi UTC.

## Aturan

1. Model dan state yang dibuat dengan Freezed wajib menggunakan `abstract class`, bukan `class` biasa.
2. Model database wajib menyediakan factory `fromSqflite(Map<String, Object?> row)` dan method `toSqflite()` untuk konversi ke/dari SQLite.
3. Parsing nilai dari database wajib menggunakan `ParserUtil`.
4. Konversi tanggal ke UTC wajib dilakukan di `toSqflite()` (`toUtc().toIso8601String()`), dan konversi ke lokal wajib dilakukan di `fromSqflite()` (`parseDateTime(...)?.toLocal()`).

## Larangan

- Jangan membuat model/state Freezed dengan `class` biasa.
- Jangan melakukan parsing `dynamic` dari database secara langsung tanpa `ParserUtil`.
- Jangan menyimpan waktu lokal seolah-olah UTC.

## Contoh Benar

```dart
@freezed
abstract class DiaryCravingModel with _$DiaryCravingModel {
  const DiaryCravingModel._();
  const factory DiaryCravingModel({...}) = _DiaryCravingModel;

  factory DiaryCravingModel.fromSqflite(Map<String, Object?> row) {...}
  Map<String, Object?> toSqflite() {...}
}
```

## Contoh Salah

```dart
@freezed
class DiaryCravingModel with _$DiaryCravingModel { ... } // class biasa, bukan abstract
```

## Sumber Evaluasi

- Commit: `3b67d3095dacc4e5c7ea78d7eb251809e3e9d981`
- File: `lib/fitur/diary_craving/model/diary_craving_model.dart`, `lib/fitur/diary_craving/state/diary_craving_state.dart`