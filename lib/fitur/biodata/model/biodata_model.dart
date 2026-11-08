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
    if (!sedangTapering) return jumlahRokokPerHari;
    final mulai = tanggalMulaiTapering ?? DateTime.now();
    final sekarang = DateTime.now();
    final mulaiDate = DateTime(mulai.year, mulai.month, mulai.day);
    final sekarangDate = DateTime(sekarang.year, sekarang.month, sekarang.day);
    final hariBerlalu = sekarangDate.difference(mulaiDate).inDays;
    final mingguBerlalu = hariBerlalu < 0 ? 0 : hariBerlalu ~/ 7;
    final penurunan = penurunanPerMinggu * mingguBerlalu;
    final target = jumlahRokokPerHari - penurunan;
    if (target < 0) return 0;
    if (target > jumlahRokokPerHari) return jumlahRokokPerHari;
    return target;
  }
}
