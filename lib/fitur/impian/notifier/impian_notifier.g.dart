// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'impian_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ImpianNotifier)
final impianProvider = ImpianNotifierProvider._();

final class ImpianNotifierProvider
    extends $AsyncNotifierProvider<ImpianNotifier, ImpianState> {
  ImpianNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'impianProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$impianNotifierHash();

  @$internal
  @override
  ImpianNotifier create() => ImpianNotifier();
}

String _$impianNotifierHash() => r'52fb1ecddc9e3743506b7ec6b553987a70c55903';

abstract class _$ImpianNotifier extends $AsyncNotifier<ImpianState> {
  FutureOr<ImpianState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ImpianState>, ImpianState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ImpianState>, ImpianState>,
              AsyncValue<ImpianState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
