import 'package:berhenti_merokok/fitur/sos_craving/model/sos_intervensi_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_intervensi_state.freezed.dart';

@freezed
abstract class SosIntervensiState with _$SosIntervensiState {
  const SosIntervensiState._();

  const factory SosIntervensiState({
    @Default([]) List<SosIntervensiModel> listIntervensi,
    @Default(0) int jumlahIntervensi,
  }) = _SosIntervensiState;
}
