// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'konsumsi_rokok_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(KonsumsiRokokNotifier)
final konsumsiRokokProvider = KonsumsiRokokNotifierProvider._();

final class KonsumsiRokokNotifierProvider
    extends $AsyncNotifierProvider<KonsumsiRokokNotifier, KonsumsiRokokState> {
  KonsumsiRokokNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'konsumsiRokokProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$konsumsiRokokNotifierHash();

  @$internal
  @override
  KonsumsiRokokNotifier create() => KonsumsiRokokNotifier();
}

String _$konsumsiRokokNotifierHash() =>
    r'92f3aaa3127bc80c4d771da14b71c1ebc5bacfa7';

abstract class _$KonsumsiRokokNotifier
    extends $AsyncNotifier<KonsumsiRokokState> {
  FutureOr<KonsumsiRokokState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<KonsumsiRokokState>, KonsumsiRokokState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KonsumsiRokokState>, KonsumsiRokokState>,
              AsyncValue<KonsumsiRokokState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
