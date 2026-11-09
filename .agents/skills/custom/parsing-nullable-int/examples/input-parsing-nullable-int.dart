// commit: adc85b57da72eb4c000a29c324db7cdb15d388bc
import 'package:berhenti_merokok/shared/utils/parser_util.dart';

class BiodataModelSalah {
  final int? targetSmokeFreeHari;
  
  BiodataModelSalah({this.targetSmokeFreeHari});
  
  factory BiodataModelSalah.fromSqflite(Map<String, Object?> row) {
    return BiodataModelSalah(
      // SALAH: parseInt default 0, null jadi 0, tidak bisa bedakan "belum diatur" vs "diatur ke 0"
      targetSmokeFreeHari: ParserUtil.parseInt(row['target_smoke_free_hari']),
    );
  }
}