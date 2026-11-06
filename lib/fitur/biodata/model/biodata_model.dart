import 'package:freezed_annotation/freezed_annotation.dart';

part 'biodata_model.freezed.dart';

@freezed
abstract class BiodataModel with _$BiodataModel {
  const BiodataModel._();

  const factory BiodataModel({
    required String id,
    required String nama,
    DateTime? tanggalLahir,
    int? jumlahRokokPerHari,
    double? hargaRokokPerBungkus,
    DateTime? tanggalMulaiMerokok,
  }) = _BiodataModel;
}
