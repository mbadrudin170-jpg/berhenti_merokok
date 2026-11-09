// commit: 3b67d3095dacc4e5c7ea78d7eb251809e3e9d981
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_salah.freezed.dart';

// SALAH: class biasa, bukan abstract class
@freezed
class ModelSalah with _$ModelSalah {
  const factory ModelSalah({required String id, required DateTime tanggal}) = _ModelSalah;
}