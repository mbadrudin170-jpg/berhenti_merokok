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
  }) = _BiodataModel;

  /// Membuat [BiodataModel] dari baris database SQLite.
  factory BiodataModel.fromSqflite(Map<String, Object?> row) {
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
    };
  }
}
