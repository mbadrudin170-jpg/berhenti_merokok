// lib/fitur/dummy/dummy_data/dummy_biodata.dart

import 'package:berhenti_merokok/fitur/biodata/model/biodata_model.dart';

/// ID dummy untuk data biodata.
class BiodataIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0001-000000000001';
}

/// Daftar data dummy biodata.
final List<BiodataModel> dummyBiodata = [
  BiodataModel(
    id: BiodataIdDummy.item1,
    nama: 'Budi Santoso',
    tanggalLahir: DateTime.now().subtract(const Duration(days: 365 * 36)),
    jumlahRokokPerHari: 12,
    hargaRokokPerBungkus: 35000.0,
    tanggalMulaiMerokok: DateTime.now().subtract(
      const Duration(days: 365 * 16),
    ),
    tanggalMulaiBerhentiMerokok: DateTime.now().subtract(
      const Duration(days: 30),
    ),
  ),
];
