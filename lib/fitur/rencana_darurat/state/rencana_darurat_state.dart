import 'package:berhenti_merokok/fitur/rencana_darurat/model/rencana_darurat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rencana_darurat_state.freezed.dart';

@freezed
abstract class RencanaDaruratState with _$RencanaDaruratState {
  const RencanaDaruratState._();

  const factory RencanaDaruratState({
    @Default([]) List<RencanaDaruratModel> listRencana,
    @Default(0) int jumlahRencana,
  }) = _RencanaDaruratState;
}
