// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toxin_pelacakan_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToxinPelacakanState {

 List<ToxinModel> get daftarToxin; ToxinStatus get status;
/// Create a copy of ToxinPelacakanState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToxinPelacakanStateCopyWith<ToxinPelacakanState> get copyWith => _$ToxinPelacakanStateCopyWithImpl<ToxinPelacakanState>(this as ToxinPelacakanState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ToxinPelacakanState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToxinPelacakanState&&const DeepCollectionEquality().equals(other.daftarToxin, _this.daftarToxin)&&(identical(other.status, _this.status) || other.status == _this.status));
}


@override
int get hashCode {
  final _this = this as ToxinPelacakanState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.daftarToxin),_this.status);
}

@override
String toString() {
  final _this = this as ToxinPelacakanState;
  return 'ToxinPelacakanState(daftarToxin: ${_this.daftarToxin}, status: ${_this.status})';
}


}

/// @nodoc
abstract mixin class $ToxinPelacakanStateCopyWith<$Res>  {
  factory $ToxinPelacakanStateCopyWith(ToxinPelacakanState value, $Res Function(ToxinPelacakanState) _then) = _$ToxinPelacakanStateCopyWithImpl;
@useResult
$Res call({
 List<ToxinModel> daftarToxin, ToxinStatus status
});




}
/// @nodoc
class _$ToxinPelacakanStateCopyWithImpl<$Res>
    implements $ToxinPelacakanStateCopyWith<$Res> {
  _$ToxinPelacakanStateCopyWithImpl(this._self, this._then);

  final ToxinPelacakanState _self;
  final $Res Function(ToxinPelacakanState) _then;

/// Create a copy of ToxinPelacakanState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? daftarToxin = null,Object? status = null,}) {
  return _then(ToxinPelacakanState(
daftarToxin: null == daftarToxin ? _self.daftarToxin : daftarToxin // ignore: cast_nullable_to_non_nullable
as List<ToxinModel>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ToxinStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ToxinPelacakanState].
extension ToxinPelacakanStatePatterns on ToxinPelacakanState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToxinPelacakanState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToxinPelacakanState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToxinPelacakanState value)  $default,){
final _that = this;
switch (_that) {
case _ToxinPelacakanState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToxinPelacakanState value)?  $default,){
final _that = this;
switch (_that) {
case _ToxinPelacakanState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ToxinModel> daftarToxin,  ToxinStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToxinPelacakanState() when $default != null:
return $default(_that.daftarToxin,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ToxinModel> daftarToxin,  ToxinStatus status)  $default,) {final _that = this;
switch (_that) {
case _ToxinPelacakanState():
return $default(_that.daftarToxin,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ToxinModel> daftarToxin,  ToxinStatus status)?  $default,) {final _that = this;
switch (_that) {
case _ToxinPelacakanState() when $default != null:
return $default(_that.daftarToxin,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _ToxinPelacakanState extends ToxinPelacakanState {
  const _ToxinPelacakanState({ List<ToxinModel> daftarToxin = const [], this.status = ToxinStatus.belumDimuat}): _daftarToxin = daftarToxin,super._();
  

 final  List<ToxinModel> _daftarToxin;
@override@JsonKey() List<ToxinModel> get daftarToxin {
  if (_daftarToxin is EqualUnmodifiableListView) return _daftarToxin;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daftarToxin);
}

@override@JsonKey() final  ToxinStatus status;

/// Create a copy of ToxinPelacakanState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToxinPelacakanStateCopyWith<_ToxinPelacakanState> get copyWith => __$ToxinPelacakanStateCopyWithImpl<_ToxinPelacakanState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToxinPelacakanState&&const DeepCollectionEquality().equals(other.daftarToxin, _daftarToxin)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_daftarToxin),status);
}

@override
String toString() {
    return 'ToxinPelacakanState(daftarToxin: $daftarToxin, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ToxinPelacakanStateCopyWith<$Res> implements $ToxinPelacakanStateCopyWith<$Res> {
  factory _$ToxinPelacakanStateCopyWith(_ToxinPelacakanState value, $Res Function(_ToxinPelacakanState) _then) = __$ToxinPelacakanStateCopyWithImpl;
@override @useResult
$Res call({
 List<ToxinModel> daftarToxin, ToxinStatus status
});




}
/// @nodoc
class __$ToxinPelacakanStateCopyWithImpl<$Res>
    implements _$ToxinPelacakanStateCopyWith<$Res> {
  __$ToxinPelacakanStateCopyWithImpl(this._self, this._then);

  final _ToxinPelacakanState _self;
  final $Res Function(_ToxinPelacakanState) _then;

/// Create a copy of ToxinPelacakanState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? daftarToxin = null,Object? status = null,}) {
  return _then(_ToxinPelacakanState(
daftarToxin: null == daftarToxin ? _self._daftarToxin : daftarToxin // ignore: cast_nullable_to_non_nullable
as List<ToxinModel>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ToxinStatus,
  ));
}


}

// dart format on
