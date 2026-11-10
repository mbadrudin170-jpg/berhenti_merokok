import 'package:freezed_annotation/freezed_annotation.dart';

part 'toxin_model.freezed.dart';

/// Model data untuk satu entri toxin yang dihindari tubuh saat tidak merokok.
///
/// Data ini bersifat referensi statis, tidak disimpan ke SQLite, dan tidak
/// diubah oleh pengguna. Setiap entri mencakup nama toxin, jenis zat, faktor
/// konversi per batang rokok, efek singkat, serta sumber referensi umum
/// (WHO / CDC / AHA / ACS sebagai landasan, bukan klaim medis aplikasi).
@freezed
abstract class ToxinModel with _$ToxinModel {
  const ToxinModel._();

  const factory ToxinModel({
    required String nama,
    required String jenisZat,
    required double faktorPerBatang,
    required String efekSingkat,
    required String sumberReferensi,
    @Default(0.0) double kuantitasDiHindari,
  }) = _ToxinModel;
}
