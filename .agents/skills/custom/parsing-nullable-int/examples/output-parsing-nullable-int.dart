// commit: adc85b57da72eb4c000a29c324db7cdb15d388bc
import 'package:berhenti_merokok/shared/utils/parser_util.dart';

class BiodataModelBenar {
  final int? targetSmokeFreeHari;
  
  BiodataModelBenar({this.targetSmokeFreeHari});
  
  factory BiodataModelBenar.fromSqflite(Map<String, Object?> row) {
    return BiodataModelBenar(
      // BENAR: parseIntOrNull, null tetap null
      targetSmokeFreeHari: ParserUtil.parseIntOrNull(row['target_smoke_free_hari']),
    );
  }
}