// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_intervensi_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SosIntervensiState {

 List<SosIntervensiModel> get listIntervensi; int get jumlahIntervensi; int get jumlahBerhasil;
/// Create a copy of SosIntervensiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SosIntervensiStateCopyWith<SosIntervensiState> get copyWith => _$SosIntervensiStateCopyWithImpl<SosIntervensiState>(this as SosIntervensiState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SosIntervensiState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SosIntervensiState&&const DeepCollectionEquality().equals(other.listIntervensi, _this.listIntervensi)&&(identical(other.jumlahIntervensi, _this.jumlahIntervensi) || other.jumlahIntervensi == _this.jumlahIntervensi)&&(identical(other.jumlahBerhasil, _this.jumlahBerhasil) || other.jumlahBerhasil == _this.jumlahBerhasil));
}


@override
int get hashCode {
  final _this = this as SosIntervensiState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listIntervensi),_this.jumlahIntervensi,_this.jumlahBerhasil);
}

@override
String toString() {
  final _this = this as SosIntervensiState;
  return 'SosIntervensiState(listIntervensi: ${_this.listIntervensi}, jumlahIntervensi: ${_this.jumlahIntervensi}, jumlahBerhasil: ${_this.jumlahBerhasil})';
}


}

/// @nodoc
abstract mixin class $SosIntervensiStateCopyWith<$Res>  {
  factory $SosIntervensiStateCopyWith(SosIntervensiState value, $Res Function(SosIntervensiState) _then) = _$SosIntervensiStateCopyWithImpl;
@useResult
$Res call({
 List<SosIntervensiModel> listIntervensi, int jumlahIntervensi, int jumlahBerhasil
});




}
/// @nodoc
class _$SosIntervensiStateCopyWithImpl<$Res>
    implements $SosIntervensiStateCopyWith<$Res> {
  _$SosIntervensiStateCopyWithImpl(this._self, this._then);

  final SosIntervensiState _self;
  final $Res Function(SosIntervensiState) _then;

/// Create a copy of SosIntervensiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listIntervensi = null,Object? jumlahIntervensi = null,Object? jumlahBerhasil = null,}) {
  return _then(SosIntervensiState(
listIntervensi: null == listIntervensi ? _self.listIntervensi : listIntervensi // ignore: cast_nullable_to_non_nullable
as List<SosIntervensiModel>,jumlahIntervensi: null == jumlahIntervensi ? _self.jumlahIntervensi : jumlahIntervensi // ignore: cast_nullable_to_non_nullable
as int,jumlahBerhasil: null == jumlahBerhasil ? _self.jumlahBerhasil : jumlahBerhasil // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SosIntervensiState].
extension SosIntervensiStatePatterns on SosIntervensiState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SosIntervensiState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SosIntervensiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SosIntervensiState value)  $default,){
final _that = this;
switch (_that) {
case _SosIntervensiState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SosIntervensiState value)?  $default,){
final _that = this;
switch (_that) {
case _SosIntervensiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SosIntervensiModel> listIntervensi,  int jumlahIntervensi,  int jumlahBerhasil)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SosIntervensiState() when $default != null:
return $default(_that.listIntervensi,_that.jumlahIntervensi,_that.jumlahBerhasil);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SosIntervensiModel> listIntervensi,  int jumlahIntervensi,  int jumlahBerhasil)  $default,) {final _that = this;
switch (_that) {
case _SosIntervensiState():
return $default(_that.listIntervensi,_that.jumlahIntervensi,_that.jumlahBerhasil);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SosIntervensiModel> listIntervensi,  int jumlahIntervensi,  int jumlahBerhasil)?  $default,) {final _that = this;
switch (_that) {
case _SosIntervensiState() when $default != null:
return $default(_that.listIntervensi,_that.jumlahIntervensi,_that.jumlahBerhasil);case _:
  return null;

}
}

}

/// @nodoc


class _SosIntervensiState extends SosIntervensiState {
  const _SosIntervensiState({ List<SosIntervensiModel> listIntervensi = const [], this.jumlahIntervensi = 0, this.jumlahBerhasil = 0}): _listIntervensi = listIntervensi,super._();
  

 final  List<SosIntervensiModel> _listIntervensi;
@override@JsonKey() List<SosIntervensiModel> get listIntervensi {
  if (_listIntervensi is EqualUnmodifiableListView) return _listIntervensi;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listIntervensi);
}

@override@JsonKey() final  int jumlahIntervensi;
@override@JsonKey() final  int jumlahBerhasil;

/// Create a copy of SosIntervensiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SosIntervensiStateCopyWith<_SosIntervensiState> get copyWith => __$SosIntervensiStateCopyWithImpl<_SosIntervensiState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SosIntervensiState&&const DeepCollectionEquality().equals(other.listIntervensi, _listIntervensi)&&(identical(other.jumlahIntervensi, jumlahIntervensi) || other.jumlahIntervensi == jumlahIntervensi)&&(identical(other.jumlahBerhasil, jumlahBerhasil) || other.jumlahBerhasil == jumlahBerhasil));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listIntervensi),jumlahIntervensi,jumlahBerhasil);
}

@override
String toString() {
    return 'SosIntervensiState(listIntervensi: $listIntervensi, jumlahIntervensi: $jumlahIntervensi, jumlahBerhasil: $jumlahBerhasil)';
}


}

/// @nodoc
abstract mixin class _$SosIntervensiStateCopyWith<$Res> implements $SosIntervensiStateCopyWith<$Res> {
  factory _$SosIntervensiStateCopyWith(_SosIntervensiState value, $Res Function(_SosIntervensiState) _then) = __$SosIntervensiStateCopyWithImpl;
@override @useResult
$Res call({
 List<SosIntervensiModel> listIntervensi, int jumlahIntervensi, int jumlahBerhasil
});




}
/// @nodoc
class __$SosIntervensiStateCopyWithImpl<$Res>
    implements _$SosIntervensiStateCopyWith<$Res> {
  __$SosIntervensiStateCopyWithImpl(this._self, this._then);

  final _SosIntervensiState _self;
  final $Res Function(_SosIntervensiState) _then;

/// Create a copy of SosIntervensiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listIntervensi = null,Object? jumlahIntervensi = null,Object? jumlahBerhasil = null,}) {
  return _then(_SosIntervensiState(
listIntervensi: null == listIntervensi ? _self._listIntervensi : listIntervensi // ignore: cast_nullable_to_non_nullable
as List<SosIntervensiModel>,jumlahIntervensi: null == jumlahIntervensi ? _self.jumlahIntervensi : jumlahIntervensi // ignore: cast_nullable_to_non_nullable
as int,jumlahBerhasil: null == jumlahBerhasil ? _self.jumlahBerhasil : jumlahBerhasil // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
