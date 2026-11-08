import 'package:share_global_saya/core_shared.dart';

/// Mode berhenti merokok: seketika atau bertahap (tapering).
enum ModeBerhenti { seketika, bertahap }

/// Extension yang menyediakan label untuk [ModeBerhenti].
extension ModeBerhentiExtension on ModeBerhenti {
  String get label {
    L.i('mode=$this');
    switch (this) {
      case ModeBerhenti.seketika:
        return 'Seketika';
      case ModeBerhenti.bertahap:
        return 'Bertahap (tapering)';
    }
  }
}
