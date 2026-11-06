// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tema_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TemaNotifier)
final temaProvider = TemaNotifierProvider._();

final class TemaNotifierProvider
    extends $AsyncNotifierProvider<TemaNotifier, TemaEnum> {
  TemaNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'temaProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$temaNotifierHash();

  @$internal
  @override
  TemaNotifier create() => TemaNotifier();
}

String _$temaNotifierHash() => r'6bb757a58340c3035c51e50d00183f6c2fe561ec';

abstract class _$TemaNotifier extends $AsyncNotifier<TemaEnum> {
  FutureOr<TemaEnum> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TemaEnum>, TemaEnum>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TemaEnum>, TemaEnum>,
              AsyncValue<TemaEnum>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
