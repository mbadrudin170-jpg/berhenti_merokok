import 'package:berhenti_merokok/fitur/toxin_pelacakan/model/toxin_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'toxin_pelacakan_state.freezed.dart';

/// Status muat data toxin pelacakan.
enum ToxinStatus { belumDimuat, dimuat, error }

/// State hasil perhitungan daftar toxin yang dihindari.
///
/// Tidak ada notifier terpisah untuk state ini; state hanya menampung
/// hasil perhitungan dari [ToxinHitungHelper] yang dikonsumsi langsung di layar.
@freezed
abstract class ToxinPelacakanState with _$ToxinPelacakanState {
  const ToxinPelacakanState._();

  const factory ToxinPelacakanState({
    @Default([]) List<ToxinModel> daftarToxin,
    @Default(ToxinStatus.belumDimuat) ToxinStatus status,
  }) = _ToxinPelacakanState;
}
