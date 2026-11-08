// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alasan_berhenti_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AlasanBerhentiState {

 List<AlasanBerhentiModel> get listAlasan; int get jumlahAlasan;
/// Create a copy of AlasanBerhentiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlasanBerhentiStateCopyWith<AlasanBerhentiState> get copyWith => _$AlasanBerhentiStateCopyWithImpl<AlasanBerhentiState>(this as AlasanBerhentiState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AlasanBerhentiState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlasanBerhentiState&&const DeepCollectionEquality().equals(other.listAlasan, _this.listAlasan)&&(identical(other.jumlahAlasan, _this.jumlahAlasan) || other.jumlahAlasan == _this.jumlahAlasan));
}


@override
int get hashCode {
  final _this = this as AlasanBerhentiState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listAlasan),_this.jumlahAlasan);
}

@override
String toString() {
  final _this = this as AlasanBerhentiState;
  return 'AlasanBerhentiState(listAlasan: ${_this.listAlasan}, jumlahAlasan: ${_this.jumlahAlasan})';
}


}

/// @nodoc
abstract mixin class $AlasanBerhentiStateCopyWith<$Res>  {
  factory $AlasanBerhentiStateCopyWith(AlasanBerhentiState value, $Res Function(AlasanBerhentiState) _then) = _$AlasanBerhentiStateCopyWithImpl;
@useResult
$Res call({
 List<AlasanBerhentiModel> listAlasan, int jumlahAlasan
});




}
/// @nodoc
class _$AlasanBerhentiStateCopyWithImpl<$Res>
    implements $AlasanBerhentiStateCopyWith<$Res> {
  _$AlasanBerhentiStateCopyWithImpl(this._self, this._then);

  final AlasanBerhentiState _self;
  final $Res Function(AlasanBerhentiState) _then;

/// Create a copy of AlasanBerhentiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listAlasan = null,Object? jumlahAlasan = null,}) {
  return _then(AlasanBerhentiState(
listAlasan: null == listAlasan ? _self.listAlasan : listAlasan // ignore: cast_nullable_to_non_nullable
as List<AlasanBerhentiModel>,jumlahAlasan: null == jumlahAlasan ? _self.jumlahAlasan : jumlahAlasan // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AlasanBerhentiState].
extension AlasanBerhentiStatePatterns on AlasanBerhentiState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlasanBerhentiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlasanBerhentiState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlasanBerhentiState value)  $default,){
final _that = this;
switch (_that) {
case _AlasanBerhentiState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlasanBerhentiState value)?  $default,){
final _that = this;
switch (_that) {
case _AlasanBerhentiState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AlasanBerhentiModel> listAlasan,  int jumlahAlasan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlasanBerhentiState() when $default != null:
return $default(_that.listAlasan,_that.jumlahAlasan);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AlasanBerhentiModel> listAlasan,  int jumlahAlasan)  $default,) {final _that = this;
switch (_that) {
case _AlasanBerhentiState():
return $default(_that.listAlasan,_that.jumlahAlasan);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AlasanBerhentiModel> listAlasan,  int jumlahAlasan)?  $default,) {final _that = this;
switch (_that) {
case _AlasanBerhentiState() when $default != null:
return $default(_that.listAlasan,_that.jumlahAlasan);case _:
  return null;

}
}

}

/// @nodoc


class _AlasanBerhentiState extends AlasanBerhentiState {
  const _AlasanBerhentiState({ List<AlasanBerhentiModel> listAlasan = const [], this.jumlahAlasan = 0}): _listAlasan = listAlasan,super._();
  

 final  List<AlasanBerhentiModel> _listAlasan;
@override@JsonKey() List<AlasanBerhentiModel> get listAlasan {
  if (_listAlasan is EqualUnmodifiableListView) return _listAlasan;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listAlasan);
}

@override@JsonKey() final  int jumlahAlasan;

/// Create a copy of AlasanBerhentiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlasanBerhentiStateCopyWith<_AlasanBerhentiState> get copyWith => __$AlasanBerhentiStateCopyWithImpl<_AlasanBerhentiState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlasanBerhentiState&&const DeepCollectionEquality().equals(other.listAlasan, _listAlasan)&&(identical(other.jumlahAlasan, jumlahAlasan) || other.jumlahAlasan == jumlahAlasan));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listAlasan),jumlahAlasan);
}

@override
String toString() {
    return 'AlasanBerhentiState(listAlasan: $listAlasan, jumlahAlasan: $jumlahAlasan)';
}


}

/// @nodoc
abstract mixin class _$AlasanBerhentiStateCopyWith<$Res> implements $AlasanBerhentiStateCopyWith<$Res> {
  factory _$AlasanBerhentiStateCopyWith(_AlasanBerhentiState value, $Res Function(_AlasanBerhentiState) _then) = __$AlasanBerhentiStateCopyWithImpl;
@override @useResult
$Res call({
 List<AlasanBerhentiModel> listAlasan, int jumlahAlasan
});




}
/// @nodoc
class __$AlasanBerhentiStateCopyWithImpl<$Res>
    implements _$AlasanBerhentiStateCopyWith<$Res> {
  __$AlasanBerhentiStateCopyWithImpl(this._self, this._then);

  final _AlasanBerhentiState _self;
  final $Res Function(_AlasanBerhentiState) _then;

/// Create a copy of AlasanBerhentiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listAlasan = null,Object? jumlahAlasan = null,}) {
  return _then(_AlasanBerhentiState(
listAlasan: null == listAlasan ? _self._listAlasan : listAlasan // ignore: cast_nullable_to_non_nullable
as List<AlasanBerhentiModel>,jumlahAlasan: null == jumlahAlasan ? _self.jumlahAlasan : jumlahAlasan // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
