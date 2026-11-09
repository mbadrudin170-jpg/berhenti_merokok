// commit: c9f96b2debb9e678513229c5a4a68a062e3a8afc
import 'package:berhenti_merokok/shared/utils/parser_util.dart';

class BiodataModelSalah {
  final int? targetSmokeFreeHari;

  const BiodataModelSalah({this.targetSmokeFreeHari});

  factory BiodataModelSalah.fromSqflite(Map<String, Object?> row) {
    return BiodataModelSalah(
      // SALAH: parseInt menggunakan nilai default 0 ketika data null.
      targetSmokeFreeHari: ParserUtil.parseInt(
        row['target_smoke_free_hari'],
      ),
    );
  }
}
