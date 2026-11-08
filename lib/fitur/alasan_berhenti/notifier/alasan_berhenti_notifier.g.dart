// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alasan_berhenti_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AlasanBerhentiNotifier)
final alasanBerhentiProvider = AlasanBerhentiNotifierProvider._();

final class AlasanBerhentiNotifierProvider
    extends
        $AsyncNotifierProvider<AlasanBerhentiNotifier, AlasanBerhentiState> {
  AlasanBerhentiNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'alasanBerhentiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$alasanBerhentiNotifierHash();

  @$internal
  @override
  AlasanBerhentiNotifier create() => AlasanBerhentiNotifier();
}

String _$alasanBerhentiNotifierHash() =>
    r'381a7cb023af2281ced5e39eec9a6c888d5512fb';

abstract class _$AlasanBerhentiNotifier
    extends $AsyncNotifier<AlasanBerhentiState> {
  FutureOr<AlasanBerhentiState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AlasanBerhentiState>, AlasanBerhentiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AlasanBerhentiState>, AlasanBerhentiState>,
              AsyncValue<AlasanBerhentiState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
