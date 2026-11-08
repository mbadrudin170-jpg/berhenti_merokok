// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biodata_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BiodataNotifier)
final biodataProvider = BiodataNotifierProvider._();

final class BiodataNotifierProvider
    extends $AsyncNotifierProvider<BiodataNotifier, BiodataModel?> {
  BiodataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biodataProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biodataNotifierHash();

  @$internal
  @override
  BiodataNotifier create() => BiodataNotifier();
}

String _$biodataNotifierHash() => r'0821afc28680b0106506fa538c6c756698cc915b';

abstract class _$BiodataNotifier extends $AsyncNotifier<BiodataModel?> {
  FutureOr<BiodataModel?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BiodataModel?>, BiodataModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BiodataModel?>, BiodataModel?>,
              AsyncValue<BiodataModel?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
