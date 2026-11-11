import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'rencana_darurat_model.freezed.dart';

@freezed
abstract class RencanaDaruratModel with _$RencanaDaruratModel {
  const RencanaDaruratModel._();

  const factory RencanaDaruratModel({
    required String id,
    required String jika,
    required String maka,
    required DateTime dibuat,
  }) = _RencanaDaruratModel;

  /// Membuat [RencanaDaruratModel] dari baris database SQLite.
  factory RencanaDaruratModel.fromSqflite(Map<String, Object?> row) {
    return RencanaDaruratModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      jika: ParserUtil.parseString(row[NamaKolom.jika]),
      maka: ParserUtil.parseString(row[NamaKolom.maka]),
      dibuat:
          ParserUtil.parseDateTime(row[NamaKolom.dibuat])?.toLocal() ??
          DateTime.now(),
    );
  }

  /// Mengonversi [RencanaDaruratModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.jika: jika,
      NamaKolom.maka: maka,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
