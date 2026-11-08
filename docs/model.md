# DAFTAR SEMUA FILE MODEL

Dikumpulkan pada: 2026-11-08 17:06:23

---

## 📄 File: lib/fitur/impian/model/impian_model.dart

**Jumlah baris:** 44

```dart
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'impian_model.freezed.dart';

@freezed
abstract class ImpianModel with _$ImpianModel {
  const ImpianModel._();

  const factory ImpianModel({
    required String id,
    required String nama,
    required DateTime targetTanggal,
    required DateTime dibuat,
    required double jumlah,
  }) = _ImpianModel;

  /// Membuat [ImpianModel] dari baris database SQLite.
  factory ImpianModel.fromSqflite(Map<String, Object?> row) {
    return ImpianModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      nama: ParserUtil.parseString(row[NamaKolom.nama]),
      targetTanggal:
          ParserUtil.parseDateTime(row[NamaKolom.targetTanggal])?.toLocal() ??
          DateTime.now(),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
      jumlah: ParserUtil.parseDouble(row[NamaKolom.jumlah]),
    );
  }

  /// Mengonversi [ImpianModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.nama: nama,
      NamaKolom.targetTanggal: targetTanggal.toUtc().toIso8601String(),
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
      NamaKolom.jumlah: jumlah,
    };
  }
}
```

---

## 📄 File: lib/fitur/diary_craving/model/diary_craving_model.dart

**Jumlah baris:** 56

```dart
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'diary_craving_model.freezed.dart';

@freezed
abstract class DiaryCravingModel with _$DiaryCravingModel {
  const DiaryCravingModel._();

  const factory DiaryCravingModel({
    required String id,
    required DateTime tanggal,
    required PemicuEnum pemicu,
    @Default(3) int intensitas,
    String? catatan,
    required DateTime dibuat,
  }) = _DiaryCravingModel;

  /// Membuat [DiaryCravingModel] dari baris database SQLite.
  factory DiaryCravingModel.fromSqflite(Map<String, Object?> row) {
    return DiaryCravingModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      tanggal:
          ParserUtil.parseDateTime(row[NamaKolom.tanggal])?.toLocal() ??
          DateTime.now(),
      pemicu:
          ParserUtil.safeParseEnum(
            PemicuEnum.values,
            ParserUtil.parseStringOrNull(row[NamaKolom.pemicu]),
          ) ??
          PemicuEnum.lainnya,
      intensitas: ParserUtil.parseInt(
        row[NamaKolom.intensitas],
        defaultValue: 3,
      ),
      catatan: ParserUtil.parseStringOrNull(row[NamaKolom.catatan]),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
    );
  }

  /// Mengonversi [DiaryCravingModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.tanggal: tanggal.toUtc().toIso8601String(),
      NamaKolom.pemicu: pemicu.name,
      NamaKolom.intensitas: intensitas,
      NamaKolom.catatan: catatan,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
```

---

## 📄 File: lib/fitur/biodata/model/biodata_model.dart

**Jumlah baris:** 142

```dart
import 'package:berhenti_merokok/fitur/biodata/enum/mode_berhenti.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'biodata_model.freezed.dart';

@freezed
abstract class BiodataModel with _$BiodataModel {
  const BiodataModel._();

  const factory BiodataModel({
    required String id,
    required String nama,
    DateTime? tanggalLahir,
    @Default(10) int jumlahRokokPerHari,
    @Default(0.0) double hargaRokokPerBungkus,
    @Default(20.0) double batangPerBungkus,
    DateTime? tanggalMulaiMerokok,
    DateTime? tanggalMulaiBerhentiMerokok,
    @Default(ModeBerhenti.seketika) ModeBerhenti modeBerhenti,
    @Default(0) int penurunanPerMinggu,
    DateTime? tanggalMulaiTapering,
  }) = _BiodataModel;

  /// Membuat [BiodataModel] dari baris database SQLite.
  factory BiodataModel.fromSqflite(Map<String, Object?> row) {
    L.i('row=$row');
    return BiodataModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      nama: ParserUtil.parseString(row[NamaKolom.nama]),
      tanggalLahir: ParserUtil.parseDateTime(row[NamaKolom.tanggalLahir])
          ?.toLocal(),
      jumlahRokokPerHari: ParserUtil.parseInt(
        row[NamaKolom.jumlahRokokPerHari],
        defaultValue: 10,
      ),
      hargaRokokPerBungkus: ParserUtil.parseDouble(
        row[NamaKolom.hargaRokokPerBungkus],
      ),
      batangPerBungkus: ParserUtil.parseDouble(
        row[NamaKolom.batangPerBungkus],
        defaultValue: 20.0,
      ),
      tanggalMulaiMerokok: ParserUtil.parseDateTime(
        row[NamaKolom.tanggalMulaiMerokok],
      )?.toLocal(),
      tanggalMulaiBerhentiMerokok: ParserUtil.parseDateTime(
        row[NamaKolom.tanggalMulaiBerhentiMerokok],
      )?.toLocal(),
      modeBerhenti:
          ParserUtil.safeParseEnum(
            ModeBerhenti.values,
            ParserUtil.parseString(row[NamaKolom.modeBerhenti]),
          ) ??
          ModeBerhenti.seketika,
      penurunanPerMinggu: ParserUtil.parseInt(
        row[NamaKolom.penurunanPerMinggu],
      ),
      tanggalMulaiTapering: ParserUtil.parseDateTime(
        row[NamaKolom.tanggalMulaiTapering],
      )?.toLocal(),
    );
  }

  /// Mengonversi [BiodataModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.nama: nama,
      NamaKolom.tanggalLahir: tanggalLahir?.toUtc().toIso8601String(),
      NamaKolom.jumlahRokokPerHari: jumlahRokokPerHari,
      NamaKolom.hargaRokokPerBungkus: hargaRokokPerBungkus,
      NamaKolom.batangPerBungkus: batangPerBungkus,
      NamaKolom.tanggalMulaiMerokok: tanggalMulaiMerokok
          ?.toUtc()
          .toIso8601String(),
      NamaKolom.tanggalMulaiBerhentiMerokok: tanggalMulaiBerhentiMerokok
          ?.toUtc()
          .toIso8601String(),
      NamaKolom.modeBerhenti: modeBerhenti.name,
      NamaKolom.penurunanPerMinggu: penurunanPerMinggu,
      NamaKolom.tanggalMulaiTapering: tanggalMulaiTapering
          ?.toUtc()
          .toIso8601String(),
    };
  }
}

/// Ekstensi perhitungan turunan dari [BiodataModel] agar logika `hariBerhenti`, `rokokTidakDiHisap`, dan `uangDihemat` hanya ditulis sekali dan konsisten di seluruh halaman (dashboard, impian, badge).
extension BiodataModelPerhitungan on BiodataModel {
  /// Hari smoke-free, dinormalisasi agar tidak terpengaruh komponen waktu.
  int get hariBerhenti {
    final tanggalBerhenti = tanggalMulaiBerhentiMerokok;
    if (tanggalBerhenti == null) return 0;
    final sekarang = DateTime.now();
    final hariIniDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final tanggalBerhentiDate = DateTime(
      tanggalBerhenti.year,
      tanggalBerhenti.month,
      tanggalBerhenti.day,
    );
    final hari = hariIniDate.difference(tanggalBerhentiDate).inDays;
    return hari < 0 ? 0 : hari;
  }

  /// Jumlah rokok yang tidak dihisap selama periode smoke-free.
  int get rokokTidakDiHisap => jumlahRokokPerHari * hariBerhenti;

  /// Uang yang dihemat dari tidak merokok.
  double get uangDihemat {
    if (batangPerBungkus == 0) return 0;
    return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
  }

  /// Apakah pengguna menggunakan mode berhenti bertahap (tapering).
  bool get sedangTapering => modeBerhenti == ModeBerhenti.bertahap;

  /// Target jumlah rokok per hari saat ini untuk mode tapering.
  ///
  /// Dihitung dari [jumlahRokokPerHari] dikurangi penurunan kumulatif
  /// berdasarkan minggu yang telah berlalu sejak [tanggalMulaiTapering].
  int get targetRokokHariIni {
    L.i('sedangTapering=$sedangTapering');
    if (!sedangTapering) return jumlahRokokPerHari;
    final mulai = tanggalMulaiTapering ?? DateTime.now();
    final sekarang = DateTime.now();
    final mulaiDate = DateTime(mulai.year, mulai.month, mulai.day);
    final sekarangDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final hariBerlalu = sekarangDate.difference(mulaiDate).inDays;
    final mingguBerlalu = hariBerlalu < 0 ? 0 : hariBerlalu ~/ 7;
    final penurunan = penurunanPerMinggu * mingguBerlalu;
    final target = jumlahRokokPerHari - penurunan;
    L.i(
      'mulai=$mulai, hariBerlalu=$hariBerlalu, mingguBerlalu=$mingguBerlalu, '
      'penurunan=$penurunan, target=$target',
    );
    if (target < 0) return 0;
    if (target > jumlahRokokPerHari) return jumlahRokokPerHari;
    return target;
  }
}
```

---


## 📊 STATISTIK

- **Total file model:** 3
- **Total baris kode:** 242
- **File output:** docs/model.md
