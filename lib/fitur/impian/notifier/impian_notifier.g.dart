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

String _$impianNotifierHash() => r'effd4c0e49aba1730435d514f08be3fd98081ac6';

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
