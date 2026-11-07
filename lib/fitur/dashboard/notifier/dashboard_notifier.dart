import 'package:berhenti_merokok/fitur/biodata/notifier/biodata_notifier.dart';
import 'package:berhenti_merokok/fitur/dashboard/state/dashboard_state.dart';
import 'package:berhenti_merokok/fitur/impian/notifier/impian_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardState> build() async {
    return await _muatData();
  }

  Future<DashboardState> _muatData() async {
    await ref.watch(biodataProvider.future);
    await ref.watch(impianProvider.future);
    return DashboardState();
  }
}
