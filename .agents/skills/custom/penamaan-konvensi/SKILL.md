---
name: penamaan-konvensi
description: Konvensi penamaan proyek - identifier Indonesia, snake_case file, camelCase variable, PascalCase class, SCREAMING_SNAKE_CASE const, package: import.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec"
  model: "kilo-auto/free"
---

# Konvensi Penamaan Proyek

Skill ini mendokumentasikan konvensi penamaan yang wajib diterapkan di proyek ini.

## 1. Identifier Bahasa Indonesia

### Aturan
- **WAJIB** gunakan bahasa Indonesia untuk identifier yang didefinisikan aplikasi (variable, method, class, enum, table, column).
- **DILARANG** campur bahasa Indonesia dan Inggris dalam satu identifier.
- Kode dari library eksternal (Flutter, Riverpod, Freezed, dll) tetap pakai konvensi aslinya (English).

```dart
// BENAR: Indonesia untuk app-defined
class BiodataModel { ... }
final int jumlahRokokPerHari;
Future<void> simpanBiodata() async { ... }
enum ModeBerhenti { seketika, bertahap }
const String namaTabel = 'biodata';

// SALAH: Campur bahasa
class BiodataModel { ... }
final int cigarettesPerDay; // English di app-code
Future<void> saveBiodata() async { ... } // English method
```

## 2. File Naming: snake_case

### Aturan
- **WAJIB** nama file `.dart` menggunakan `snake_case`.
- **WAJIB** nama file test: `<nama>_test.dart` (snake_case + suffix `_test`).
- **WAJIB** nama file generated: `<nama>.g.dart`, `<nama>.freezed.dart`, `<nama>.mocks.dart`.

```dart
// BENAR
lib/fitur/biodata/model/biodata_model.dart
lib/fitur/biodata/screens/biodata_screen.dart
lib/fitur/biodata/notifier/biodata_notifier.dart
test/biodata_model_test.dart
test/biodata_screen_test.dart

// SALAH
lib/fitur/biodata/model/biodataModel.dart
lib/fitur/biodata/screens/BiodataScreen.dart
test/BiodataModelTest.dart
```

## 3. Class & Type: PascalCase

### Aturan
- Class, Enum, Mixin, Extension, Typedef: `PascalCase`.
- Generic type parameter: huruf besar tunggal (`T`, `E`, `K`, `V`).

```dart
class BiodataModel { ... }
enum ModeBerhenti { ... }
extension BiodataPerhitungan on BiodataModel { ... }
typedef Callback = void Function(String);
class Repository<T> { ... }
```

## 4. Variable & Function: camelCase

### Aturan
- Local variable, parameter, field, method, function: `camelCase`.
- Boolean variable/field: prefix `is`/`has`/`can`/`should` (camelCase).
- Private (underscore prefix): `_camelCase`.

```dart
final String namaPengguna;
int jumlahRokokPerHari;
bool isLoading;
bool hasError;
String? _errorMessage;

Future<void> simpanData() async { ... }
void _handleTap() { ... }
```

## 5. Constant: SCREAMING_SNAKE_CASE

### Aturan
- Top-level constant, static const class field: `SCREAMING_SNAKE_CASE`.
- Enum values: `lowerCamelCase` (bukan SCREAMING_SNAKE_CASE).

```dart
const String namaTabel = 'biodata';
const int versiDatabase = 8;
static const int maxPanjangNama = 100;

enum Status { loading, success, error } // lowerCamelCase
```

## 6. Database: snake_case (Tabel & Kolom)

### Aturan
- **WAJIB** nama tabel & kolom database: `snake_case` (lowercase + underscore).
- Konstanta `NamaTabel` / `NamaKolom` value harus cocok persis dengan schema SQLite.
- Lihat `penamaan-konstanta-snake-case` skill untuk detail.

```dart
// NamaTabel class
class NamaTabel {
  static const String biodata = 'biodata';
  static const String craving = 'craving_diary';
}

// NamaKolom class
class NamaKolom {
  static const String id = 'id';
  static const String tanggalMulai = 'tanggal_mulai_berhenti';
  static const String jumlahRokok = 'jumlah_rokok_per_hari';
}
```

## 7. Import: package: Only, Alfabetis

### Aturan
- **WAJIB** import pakai `package:` prefix, **DILARANG** relative import (`../`, `./`).
- **WAJIB** urutkan import alfabetis berdasarkan path package lengkap.
- Group: dart:, package: (external), package: (internal/project), lalu export.

```dart
// BENAR: package: + alfabetis
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/shared/utils/l.dart';
```

### Referensi
- `import-ordering` skill untuk detail

## 8. Library & Part Directive

### Aturan
- File Freezed model: `part 'model.freezed.dart';` `part 'model.g.dart';` (di bawah library declaration).
- File Riverpod notifier: `part 'notifier.g.dart';`.
- File Mockito: `part 'mocks.mocks.dart';`.
- **DILARANG** `part of` di file terpisah (keep part di file utama).

```dart
// biodata_model.dart
// coverage:ignore-file (opsional untuk generated)
library;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:berhenti_merokok/shared/utils/parser_util.dart';

part 'biodata_model.freezed.dart';
part 'biodata_model.g.dart';

@freezed
abstract class BiodataModel with _$BiodataModel {
  // ...
}
```

## 9. Asset & Resource Naming

### Aturan
- Asset file (image, font, json): `snake_case` di `assets/`.
- Referensi di `pubspec.yaml` pakai path relatif `assets/...`.

```
assets/
  images/
    icon_app.png
    bg_onboarding.jpg
  fonts/
    poppins_regular.ttf
  data/
    milestones.json
```

## 10. Larangan Penamaan

- **DILARANG** single letter variable (kecuali loop index `i`, `j`, atau generic `T`).
- **DILARANG** abbreviation tidak standar (`btn` → `button`, `ctx` → `context`).
- **DILARANG** Hungarian notation (`strNama`, `intUmur`, `lstItem`).
- **DILARANG** nama file/class yang hanya beda case (`User.dart` vs `user.dart`).

## Referensi Aturan Sumber

- `aturan_bersama.md` — Indonesian identifiers, snake_case files, package: imports, alphabetical
- `penamaan-konstanta-snake-case` skill — DB table/column constants
- `import-ordering` skill — Import sorting
- `model-state-freezed-abstract` skill — Freezed part directives

## Referensi Commit Terkait

- `1e7b71e` — Import ordering enforcement
- `adc85b5` — NamaKolom snake_case constants
- `3b67d309` — Indonesian identifiers throughout