// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:berhenti_merokok/shared/utils/parser_util.dart';

part 'model_benar.freezed.dart';

// BENAR: abstract class
@freezed
abstract class ModelBenar with _$ModelBenar {
  const ModelBenar._();
  const factory ModelBenar({required String id, required DateTime tanggal}) = _ModelBenar;

  // BENAR: factory fromSqflite dengan ParserUtil
  factory ModelBenar.fromSqflite(Map<String, Object?> row) {
    return ModelBenar(
      id: row['id'] as String,
      tanggal: ParserUtil.parseDateTime(row['tanggal'])?.toLocal() ?? DateTime.now(),
    );
  }

  // BENAR: toSqflite dengan konversi UTC
  Map<String, Object?> toSqflite() {
    return {
      'id': id,
      'tanggal': tanggal.toUtc().toIso8601String(),
    };
  }
}