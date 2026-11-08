import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'alasan_berhenti_model.freezed.dart';

@freezed
abstract class AlasanBerhentiModel with _$AlasanBerhentiModel {
  const AlasanBerhentiModel._();

  const factory AlasanBerhentiModel({
    required String id,
    required String teks,
    required DateTime dibuat,
  }) = _AlasanBerhentiModel;

  /// Membuat [AlasanBerhentiModel] dari baris database SQLite.
  factory AlasanBerhentiModel.fromSqflite(Map<String, Object?> row) {
    return AlasanBerhentiModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      teks: ParserUtil.parseString(row[NamaKolom.teks]),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
    );
  }

  /// Mengonversi [AlasanBerhentiModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.teks: teks,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
