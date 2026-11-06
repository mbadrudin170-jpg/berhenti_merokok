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
    extends $AsyncNotifierProvider<ImpianNotifier, List<ImpianModel>> {
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

String _$impianNotifierHash() => r'1544e6276b4c16dac9e05ea1bd024cbb91674e90';

abstract class _$ImpianNotifier extends $AsyncNotifier<List<ImpianModel>> {
  FutureOr<List<ImpianModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ImpianModel>>, List<ImpianModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ImpianModel>>, List<ImpianModel>>,
              AsyncValue<List<ImpianModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
