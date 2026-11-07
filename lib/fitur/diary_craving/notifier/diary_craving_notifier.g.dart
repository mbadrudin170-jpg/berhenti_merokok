// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_craving_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DiaryCravingNotifier)
final diaryCravingProvider = DiaryCravingNotifierProvider._();

final class DiaryCravingNotifierProvider
    extends $AsyncNotifierProvider<DiaryCravingNotifier, DiaryCravingState> {
  DiaryCravingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'diaryCravingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$diaryCravingNotifierHash();

  @$internal
  @override
  DiaryCravingNotifier create() => DiaryCravingNotifier();
}

String _$diaryCravingNotifierHash() =>
    r'948055ed735be99f190c74dbc018877a80a57340';

abstract class _$DiaryCravingNotifier
    extends $AsyncNotifier<DiaryCravingState> {
  FutureOr<DiaryCravingState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<DiaryCravingState>, DiaryCravingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DiaryCravingState>, DiaryCravingState>,
              AsyncValue<DiaryCravingState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
