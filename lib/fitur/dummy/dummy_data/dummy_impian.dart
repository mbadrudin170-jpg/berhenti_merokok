// lib/fitur/dummy/dummy_data/dummy_impian.dart

import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';

/// ID dummy untuk data impian.
class ImpianIdDummy {
  /// ID dummy item 1.
  static const String item1 = '00000000-0000-0000-0006-000000000001';

  /// ID dummy item 2.
  static const String item2 = '00000000-0000-0000-0006-000000000002';

  /// ID dummy item 3.
  static const String item3 = '00000000-0000-0000-0006-000000000003';

  /// ID dummy item 4.
  static const String item4 = '00000000-0000-0000-0006-000000000004';

  /// ID dummy item 5.
  static const String item5 = '00000000-0000-0000-0006-000000000005';

  /// ID dummy item 6.
  static const String item6 = '00000000-0000-0000-0006-000000000006';
}

/// Daftar data dummy impian.
final List<ImpianModel> dummyImpian = [
  ImpianModel(
    id: ImpianIdDummy.item1,
    nama: 'Beli ban baru',
    targetTanggal: DateTime.now().add(const Duration(days: 10)),
    dibuat: DateTime.now().subtract(const Duration(days: 5)),
    jumlah: 2000000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item2,
    nama: 'Service AC mobil',
    targetTanggal: DateTime.now().add(const Duration(days: 15)),
    dibuat: DateTime.now().subtract(const Duration(days: 8)),
    jumlah: 1500000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item3,
    nama: 'Ganti knalpot racing',
    targetTanggal: DateTime.now().add(const Duration(days: 20)),
    dibuat: DateTime.now().subtract(const Duration(days: 3)),
    jumlah: 1000000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item4,
    nama: 'Beli helm baru',
    targetTanggal: DateTime.now().add(const Duration(days: 5)),
    dibuat: DateTime.now().subtract(const Duration(days: 6)),
    jumlah: 500000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item5,
    nama: 'Ganti oli gardan',
    targetTanggal: DateTime.now().add(const Duration(days: 12)),
    dibuat: DateTime.now().subtract(const Duration(days: 2)),
    jumlah: 800000.0,
  ),
  ImpianModel(
    id: ImpianIdDummy.item6,
    nama: 'Pasang roof rack',
    targetTanggal: DateTime.now().add(const Duration(days: 25)),
    dibuat: DateTime.now().subtract(const Duration(days: 4)),
    jumlah: 3000000.0,
  ),
];
