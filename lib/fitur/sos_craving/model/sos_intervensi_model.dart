import 'package:berhenti_merokok/fitur/sos_craving/enum/hasil_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/fitur/sos_craving/enum/jenis_intervensi_sos_enum.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'sos_intervensi_model.freezed.dart';

@freezed
abstract class SosIntervensiModel with _$SosIntervensiModel {
  const SosIntervensiModel._();

  const factory SosIntervensiModel({
    required String id,
    required JenisIntervensiSos jenisIntervensi,
    String? detail,
    HasilIntervensiSos? hasilIntervensi,
    String? diaryCravingId,
    required DateTime dibuat,
  }) = _SosIntervensiModel;

  /// Membuat [SosIntervensiModel] dari baris database SQLite.
  factory SosIntervensiModel.fromSqflite(Map<String, Object?> row) {
    return SosIntervensiModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      jenisIntervensi:
          ParserUtil.safeParseEnum(
            JenisIntervensiSos.values,
            ParserUtil.parseStringOrNull(row[NamaKolom.jenisIntervensi]),
          ) ??
          JenisIntervensiSos.napas_478,
      detail: ParserUtil.parseStringOrNull(row[NamaKolom.detail]),
      hasilIntervensi: ParserUtil.safeParseEnum(
        HasilIntervensiSos.values,
        ParserUtil.parseStringOrNull(row[NamaKolom.hasilIntervensi]),
      ),
      diaryCravingId: ParserUtil.parseStringOrNull(row[NamaKolom.diaryCravingId]),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
    );
  }

  /// Mengonversi [SosIntervensiModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.jenisIntervensi: jenisIntervensi.name,
      NamaKolom.detail: detail,
      NamaKolom.hasilIntervensi: hasilIntervensi?.name,
      NamaKolom.diaryCravingId: diaryCravingId,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
