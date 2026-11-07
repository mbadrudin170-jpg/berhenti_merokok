import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const DashboardState._();

  const factory DashboardState({
    @Default(0) double totalDiHemat,
    @Default(0) double totalBatangDiAbaikan,
  }) = _DashboardState;
}
