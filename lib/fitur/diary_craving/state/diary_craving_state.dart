import 'package:berhenti_merokok/fitur/diary_craving/model/diary_craving_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_craving_state.freezed.dart';

@freezed
abstract class DiaryCravingState with _$DiaryCravingState {
  const DiaryCravingState._();

  const factory DiaryCravingState({
    @Default([]) List<DiaryCravingModel> listCraving,
    @Default(0) int jumlahCraving,
  }) = _DiaryCravingState;
}
