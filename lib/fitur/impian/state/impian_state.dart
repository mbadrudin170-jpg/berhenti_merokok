import 'package:berhenti_merokok/fitur/impian/model/impian_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'impian_state.freezed.dart';

@freezed
abstract class ImpianState with _$ImpianState {
  const ImpianState._();

  const factory ImpianState({
    @Default([]) List<ImpianModel> listImpian,
    @Default(0) int jumlahImpian,
    @Default(0) double totalJumlah,
  }) = _ImpianState;
}
