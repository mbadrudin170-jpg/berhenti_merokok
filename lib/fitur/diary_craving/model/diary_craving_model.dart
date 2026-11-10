import 'package:berhenti_merokok/fitur/diary_craving/enum/hasil_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/mood_craving_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/fitur/diary_craving/enum/strategi_craving_enum.dart';
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
    int? durasiMenit,
    MoodCravingEnum? mood,
    StrategiCravingEnum? strategi,
    HasilCravingEnum? hasil,
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
      durasiMenit: ParserUtil.parseIntOrNull(row[NamaKolom.durasiMenit]),
      mood: ParserUtil.safeParseEnum(
        MoodCravingEnum.values,
        ParserUtil.parseStringOrNull(row[NamaKolom.mood]),
      ),
      strategi: ParserUtil.safeParseEnum(
        StrategiCravingEnum.values,
        ParserUtil.parseStringOrNull(row[NamaKolom.strategi]),
      ),
      hasil: ParserUtil.safeParseEnum(
        HasilCravingEnum.values,
        ParserUtil.parseStringOrNull(row[NamaKolom.hasil]),
      ),
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
      NamaKolom.durasiMenit: durasiMenit,
      NamaKolom.mood: mood?.name,
      NamaKolom.strategi: strategi?.name,
      NamaKolom.hasil: hasil?.name,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
