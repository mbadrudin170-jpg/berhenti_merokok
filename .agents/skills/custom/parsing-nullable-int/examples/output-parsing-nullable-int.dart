// commit: c9f96b2debb9e678513229c5a4a68a062e3a8afc
import 'package:berhenti_merokok/shared/utils/parser_util.dart';

class BiodataModelBenar {
  final int? targetSmokeFreeHari;

  const BiodataModelBenar({this.targetSmokeFreeHari});

  factory BiodataModelBenar.fromSqflite(Map<String, Object?> row) {
    return BiodataModelBenar(
      // BENAR: parseIntOrNull mempertahankan nilai null dari database.
      targetSmokeFreeHari: ParserUtil.parseIntOrNull(
        row['target_smoke_free_hari'],
      ),
    );
  }
}
