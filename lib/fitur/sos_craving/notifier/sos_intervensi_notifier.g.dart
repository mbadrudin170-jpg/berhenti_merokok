// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_intervensi_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SosIntervensiNotifier)
final sosIntervensiProvider = SosIntervensiNotifierProvider._();

final class SosIntervensiNotifierProvider
    extends $AsyncNotifierProvider<SosIntervensiNotifier, SosIntervensiState> {
  SosIntervensiNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sosIntervensiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sosIntervensiNotifierHash();

  @$internal
  @override
  SosIntervensiNotifier create() => SosIntervensiNotifier();
}

String _$sosIntervensiNotifierHash() =>
    r'3fb68a24710f1800b0f7a562f18d3e4da3b12c20';

abstract class _$SosIntervensiNotifier
    extends $AsyncNotifier<SosIntervensiState> {
  FutureOr<SosIntervensiState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<SosIntervensiState>, SosIntervensiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SosIntervensiState>, SosIntervensiState>,
              AsyncValue<SosIntervensiState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
