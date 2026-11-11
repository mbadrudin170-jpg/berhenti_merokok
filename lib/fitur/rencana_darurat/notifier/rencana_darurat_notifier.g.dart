// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rencana_darurat_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RencanaDaruratNotifier)
final rencanaDaruratProvider = RencanaDaruratNotifierProvider._();

final class RencanaDaruratNotifierProvider
    extends
        $AsyncNotifierProvider<RencanaDaruratNotifier, RencanaDaruratState> {
  RencanaDaruratNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rencanaDaruratProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rencanaDaruratNotifierHash();

  @$internal
  @override
  RencanaDaruratNotifier create() => RencanaDaruratNotifier();
}

String _$rencanaDaruratNotifierHash() =>
    r'e331847553da1560c541b126c4d07380a00fceb4';

abstract class _$RencanaDaruratNotifier
    extends $AsyncNotifier<RencanaDaruratState> {
  FutureOr<RencanaDaruratState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<RencanaDaruratState>, RencanaDaruratState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RencanaDaruratState>, RencanaDaruratState>,
              AsyncValue<RencanaDaruratState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
