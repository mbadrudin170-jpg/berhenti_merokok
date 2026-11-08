import 'package:berhenti_merokok/fitur/alasan_berhenti/model/alasan_berhenti_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'alasan_berhenti_state.freezed.dart';

@freezed
abstract class AlasanBerhentiState with _$AlasanBerhentiState {
  const AlasanBerhentiState._();

  const factory AlasanBerhentiState({
    @Default([]) List<AlasanBerhentiModel> listAlasan,
    @Default(0) int jumlahAlasan,
  }) = _AlasanBerhentiState;
}
