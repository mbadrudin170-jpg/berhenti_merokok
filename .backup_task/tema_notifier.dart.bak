import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:berhenti_merokok/fitur/tema/enum/tema_enum.dart';
import 'package:berhenti_merokok/shared/helper/shared_keys.dart';

part 'tema_notifier.g.dart';

@Riverpod(keepAlive: true)
class TemaNotifier extends _$TemaNotifier {
  @override
  Future<TemaEnum> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(SharedKeys.tema);
    return TemaEnum.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TemaEnum.sistem,
    );
  }

  Future<void> set([TemaEnum? tema]) async {
    final nilai = tema ?? state.asData?.value ?? TemaEnum.sistem;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.tema, nilai.name);
    state = AsyncValue.data(nilai);
  }
}
