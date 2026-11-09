---
name: import-ordering
description: Panduan mengurutkan import secara alfabetis berdasarkan path package lengkap untuk konsistensi kode.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec"
  model: "kilo-auto/free"
---

# Import Ordering (Urutan Import)

Import wajib diurutkan secara alfabetis berdasarkan path package lengkap.

## Aturan

1. Import wajib diurutkan secara alfabetis berdasarkan path package.
2. Import dari package proyek (`package:berhenti_merokok/...`) wajib diurutkan berdasarkan path lengkap.
3. Jangan mengurutkan import secara sembarangan; ikuti urutan alfabetis.
4. Prinsip ini berlaku untuk seluruh file Dart dalam proyek.
5. Saat memperbaiki urutan import, verifikasi seluruh blok import sudah terurut alfabetis secara penuh, bukan hanya menukar dua baris yang terlihat bermasalah. Satu pasang import yang salah urut tetap melanggar aturan, dan perbaikan parsial harus dianggap belum selesai.

## Contoh Benar

```dart
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

## Contoh Salah

```dart
import 'package:berhenti_merokok/fitur/biodata/screens/form_biodata.dart';
import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
```

## Sumber Evaluasi

- Commit: `1e7b71ed8fd91f0bcd0caafd9b380fcb3a7f73ec`
- File: `lib/fitur/biodata/screens/biodata_screen.dart`