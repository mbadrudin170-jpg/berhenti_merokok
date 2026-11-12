// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tema_visual_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TemaVisualNotifier)
final temaVisualProvider = TemaVisualNotifierProvider._();

final class TemaVisualNotifierProvider
    extends $AsyncNotifierProvider<TemaVisualNotifier, TemaVisualImpian> {
  TemaVisualNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'temaVisualProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$temaVisualNotifierHash();

  @$internal
  @override
  TemaVisualNotifier create() => TemaVisualNotifier();
}

String _$temaVisualNotifierHash() =>
    r'da441595ca23cf18329ca489f281ee0b8289b799';

abstract class _$TemaVisualNotifier extends $AsyncNotifier<TemaVisualImpian> {
  FutureOr<TemaVisualImpian> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<TemaVisualImpian>, TemaVisualImpian>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TemaVisualImpian>, TemaVisualImpian>,
              AsyncValue<TemaVisualImpian>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
