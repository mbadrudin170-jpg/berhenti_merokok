import 'package:berhenti_merokok/fitur/diary_craving/enum/pemicu_enum.dart';
import 'package:berhenti_merokok/shared/konstanta/nama_kolom.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'konsumsi_rokok_model.freezed.dart';

@freezed
abstract class KonsumsiRokokModel with _$KonsumsiRokokModel {
  const KonsumsiRokokModel._();

  const factory KonsumsiRokokModel({
    required String id,
    required DateTime tanggal,
    required int jumlah,
    @Default(false) bool isSlip,
    String? catatan,
    PemicuEnum? pemicu,
    required DateTime dibuat,
  }) = _KonsumsiRokokModel;

  /// Membuat [KonsumsiRokokModel] dari baris database SQLite.
  factory KonsumsiRokokModel.fromSqflite(Map<String, Object?> row) {
    final tanggalValue = ParserUtil.parseDateTime(row[NamaKolom.tanggal]);
    final dibuatValue = ParserUtil.parseDateTime(row[NamaKolom.dibuat]);
    return KonsumsiRokokModel(
      id: ParserUtil.parseString(row[NamaKolom.id]),
      tanggal: (tanggalValue ?? DateTime.now()).toLocal(),
      // jumlah non-nullable di Dart → pakai parseInt dengan defaultValue 1 saat DB null
      jumlah: ParserUtil.parseInt(row[NamaKolom.jumlah], defaultValue: 1),
      // isSlip non-nullable bool di Dart → pakai parseBool dengan defaultValue false saat DB null
      isSlip: ParserUtil.parseBool(row[NamaKolom.isSlip], defaultValue: false),
      catatan: ParserUtil.parseStringOrNull(row[NamaKolom.catatan]),
      pemicu: ParserUtil.safeParseEnum(
        PemicuEnum.values,
        ParserUtil.parseStringOrNull(row[NamaKolom.pemicu]),
      ),
      dibuat: (dibuatValue ?? DateTime.now()).toLocal(),
    );
  }

  /// Mengonversi [KonsumsiRokokModel] menjadi Map untuk disimpan ke SQLite.
  Map<String, Object?> toSqflite() {
    return <String, Object?>{
      NamaKolom.id: id,
      NamaKolom.tanggal: tanggal.toUtc().toIso8601String(),
      NamaKolom.jumlah: jumlah,
      NamaKolom.isSlip: isSlip ? 1 : 0,
      NamaKolom.catatan: catatan,
      NamaKolom.pemicu: pemicu?.name,
      NamaKolom.dibuat: dibuat.toUtc().toIso8601String(),
    };
  }
}
