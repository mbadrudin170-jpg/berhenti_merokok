/// Mode berhenti merokok: seketika atau bertahap (tapering).
enum ModeBerhenti { seketika, bertahap }

/// Extension yang menyediakan label untuk [ModeBerhenti].
extension ModeBerhentiExtension on ModeBerhenti {
  String get label {
    switch (this) {
      case ModeBerhenti.seketika:
        return 'Seketika';
      case ModeBerhenti.bertahap:
        return 'Bertahap (tapering)';
    }
  }
}
