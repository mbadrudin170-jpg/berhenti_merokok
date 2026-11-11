// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rencana_darurat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RencanaDaruratState {

 List<RencanaDaruratModel> get listRencana; int get jumlahRencana;
/// Create a copy of RencanaDaruratState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RencanaDaruratStateCopyWith<RencanaDaruratState> get copyWith => _$RencanaDaruratStateCopyWithImpl<RencanaDaruratState>(this as RencanaDaruratState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RencanaDaruratState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RencanaDaruratState&&const DeepCollectionEquality().equals(other.listRencana, _this.listRencana)&&(identical(other.jumlahRencana, _this.jumlahRencana) || other.jumlahRencana == _this.jumlahRencana));
}


@override
int get hashCode {
  final _this = this as RencanaDaruratState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listRencana),_this.jumlahRencana);
}

@override
String toString() {
  final _this = this as RencanaDaruratState;
  return 'RencanaDaruratState(listRencana: ${_this.listRencana}, jumlahRencana: ${_this.jumlahRencana})';
}


}

/// @nodoc
abstract mixin class $RencanaDaruratStateCopyWith<$Res>  {
  factory $RencanaDaruratStateCopyWith(RencanaDaruratState value, $Res Function(RencanaDaruratState) _then) = _$RencanaDaruratStateCopyWithImpl;
@useResult
$Res call({
 List<RencanaDaruratModel> listRencana, int jumlahRencana
});




}
/// @nodoc
class _$RencanaDaruratStateCopyWithImpl<$Res>
    implements $RencanaDaruratStateCopyWith<$Res> {
  _$RencanaDaruratStateCopyWithImpl(this._self, this._then);

  final RencanaDaruratState _self;
  final $Res Function(RencanaDaruratState) _then;

/// Create a copy of RencanaDaruratState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listRencana = null,Object? jumlahRencana = null,}) {
  return _then(RencanaDaruratState(
listRencana: null == listRencana ? _self.listRencana : listRencana // ignore: cast_nullable_to_non_nullable
as List<RencanaDaruratModel>,jumlahRencana: null == jumlahRencana ? _self.jumlahRencana : jumlahRencana // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RencanaDaruratState].
extension RencanaDaruratStatePatterns on RencanaDaruratState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RencanaDaruratState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RencanaDaruratState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RencanaDaruratState value)  $default,){
final _that = this;
switch (_that) {
case _RencanaDaruratState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RencanaDaruratState value)?  $default,){
final _that = this;
switch (_that) {
case _RencanaDaruratState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RencanaDaruratModel> listRencana,  int jumlahRencana)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RencanaDaruratState() when $default != null:
return $default(_that.listRencana,_that.jumlahRencana);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RencanaDaruratModel> listRencana,  int jumlahRencana)  $default,) {final _that = this;
switch (_that) {
case _RencanaDaruratState():
return $default(_that.listRencana,_that.jumlahRencana);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RencanaDaruratModel> listRencana,  int jumlahRencana)?  $default,) {final _that = this;
switch (_that) {
case _RencanaDaruratState() when $default != null:
return $default(_that.listRencana,_that.jumlahRencana);case _:
  return null;

}
}

}

/// @nodoc


class _RencanaDaruratState extends RencanaDaruratState {
  const _RencanaDaruratState({ List<RencanaDaruratModel> listRencana = const [], this.jumlahRencana = 0}): _listRencana = listRencana,super._();
  

 final  List<RencanaDaruratModel> _listRencana;
@override@JsonKey() List<RencanaDaruratModel> get listRencana {
  if (_listRencana is EqualUnmodifiableListView) return _listRencana;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listRencana);
}

@override@JsonKey() final  int jumlahRencana;

/// Create a copy of RencanaDaruratState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RencanaDaruratStateCopyWith<_RencanaDaruratState> get copyWith => __$RencanaDaruratStateCopyWithImpl<_RencanaDaruratState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RencanaDaruratState&&const DeepCollectionEquality().equals(other.listRencana, _listRencana)&&(identical(other.jumlahRencana, jumlahRencana) || other.jumlahRencana == jumlahRencana));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listRencana),jumlahRencana);
}

@override
String toString() {
    return 'RencanaDaruratState(listRencana: $listRencana, jumlahRencana: $jumlahRencana)';
}


}

/// @nodoc
abstract mixin class _$RencanaDaruratStateCopyWith<$Res> implements $RencanaDaruratStateCopyWith<$Res> {
  factory _$RencanaDaruratStateCopyWith(_RencanaDaruratState value, $Res Function(_RencanaDaruratState) _then) = __$RencanaDaruratStateCopyWithImpl;
@override @useResult
$Res call({
 List<RencanaDaruratModel> listRencana, int jumlahRencana
});




}
/// @nodoc
class __$RencanaDaruratStateCopyWithImpl<$Res>
    implements _$RencanaDaruratStateCopyWith<$Res> {
  __$RencanaDaruratStateCopyWithImpl(this._self, this._then);

  final _RencanaDaruratState _self;
  final $Res Function(_RencanaDaruratState) _then;

/// Create a copy of RencanaDaruratState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listRencana = null,Object? jumlahRencana = null,}) {
  return _then(_RencanaDaruratState(
listRencana: null == listRencana ? _self._listRencana : listRencana // ignore: cast_nullable_to_non_nullable
as List<RencanaDaruratModel>,jumlahRencana: null == jumlahRencana ? _self.jumlahRencana : jumlahRencana // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
