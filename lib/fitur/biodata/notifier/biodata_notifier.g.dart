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
    extends $NotifierProvider<BiodataNotifier, String> {
  BiodataNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biodataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biodataNotifierHash();

  @$internal
  @override
  BiodataNotifier create() => BiodataNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$biodataNotifierHash() => r'd146a4ff4431d3425957340fc837f9703e5acec4';

abstract class _$BiodataNotifier extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
