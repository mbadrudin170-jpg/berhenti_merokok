/// Suasana hati saat craving menyerang.
enum MoodCravingEnum {
  senang,
  netral,
  sedih,
  cemas,
  marah,
  stres,
}

/// Extension yang menyediakan label untuk [MoodCravingEnum].
extension MoodCravingEnumExtension on MoodCravingEnum {
  String get label {
    switch (this) {
      case MoodCravingEnum.senang:
        return 'Senang';
      case MoodCravingEnum.netral:
        return 'Netral';
      case MoodCravingEnum.sedih:
        return 'Sedih';
      case MoodCravingEnum.cemas:
        return 'Cemas';
      case MoodCravingEnum.marah:
        return 'Marah';
      case MoodCravingEnum.stres:
        return 'Stres';
    }
  }
}
