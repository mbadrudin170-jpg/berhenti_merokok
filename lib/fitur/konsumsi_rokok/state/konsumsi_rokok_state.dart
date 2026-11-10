import 'package:berhenti_merokok/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'konsumsi_rokok_state.freezed.dart';

@freezed
abstract class KonsumsiRokokState with _$KonsumsiRokokState {
  const KonsumsiRokokState._();

  const factory KonsumsiRokokState({
    @Default([]) List<KonsumsiRokokModel> listKonsumsi,
    @Default(0) int jumlahTotal,
    @Default({}) Map<String, int> ringkasanHarian,
  }) = _KonsumsiRokokState;
}
