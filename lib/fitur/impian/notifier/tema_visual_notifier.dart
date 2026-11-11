import 'package:berhenti_merokok/fitur/impian/enum/tema_visual_impian.dart';
import 'package:berhenti_merokok/shared/helper/shared_keys.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tema_visual_notifier.g.dart';

// State hanya menyimpan satu nilai enum TemaVisualImpian, sehingga tidak
// memerlukan state Freezed tersendiri, konsisten dengan TemaNotifier.
@Riverpod(keepAlive: true)
class TemaVisualNotifier extends _$TemaVisualNotifier {
  @override
  Future<TemaVisualImpian> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(SharedKeys.temaVisualImpian);
    return TemaVisualImpian.values.firstWhere(
      (e) => e.name == value,
      // Tema tidak valid/tidak tersimpan → tema default pertama.
      orElse: () => TemaVisualImpian.toples,
    );
  }

  Future<void> set([TemaVisualImpian? tema]) async {
    final nilai = tema ?? state.asData?.value ?? TemaVisualImpian.toples;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.temaVisualImpian, nilai.name);
    state = AsyncValue.data(nilai);
  }
}
