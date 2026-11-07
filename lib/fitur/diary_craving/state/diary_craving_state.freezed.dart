// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_craving_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiaryCravingState {

 List<DiaryCravingModel> get listCraving; int get jumlahCraving;
/// Create a copy of DiaryCravingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryCravingStateCopyWith<DiaryCravingState> get copyWith => _$DiaryCravingStateCopyWithImpl<DiaryCravingState>(this as DiaryCravingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiaryCravingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryCravingState&&const DeepCollectionEquality().equals(other.listCraving, _this.listCraving)&&(identical(other.jumlahCraving, _this.jumlahCraving) || other.jumlahCraving == _this.jumlahCraving));
}


@override
int get hashCode {
  final _this = this as DiaryCravingState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listCraving),_this.jumlahCraving);
}

@override
String toString() {
  final _this = this as DiaryCravingState;
  return 'DiaryCravingState(listCraving: ${_this.listCraving}, jumlahCraving: ${_this.jumlahCraving})';
}


}

/// @nodoc
abstract mixin class $DiaryCravingStateCopyWith<$Res>  {
  factory $DiaryCravingStateCopyWith(DiaryCravingState value, $Res Function(DiaryCravingState) _then) = _$DiaryCravingStateCopyWithImpl;
@useResult
$Res call({
 List<DiaryCravingModel> listCraving, int jumlahCraving
});




}
/// @nodoc
class _$DiaryCravingStateCopyWithImpl<$Res>
    implements $DiaryCravingStateCopyWith<$Res> {
  _$DiaryCravingStateCopyWithImpl(this._self, this._then);

  final DiaryCravingState _self;
  final $Res Function(DiaryCravingState) _then;

/// Create a copy of DiaryCravingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listCraving = null,Object? jumlahCraving = null,}) {
  return _then(DiaryCravingState(
listCraving: null == listCraving ? _self.listCraving : listCraving // ignore: cast_nullable_to_non_nullable
as List<DiaryCravingModel>,jumlahCraving: null == jumlahCraving ? _self.jumlahCraving : jumlahCraving // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaryCravingState].
extension DiaryCravingStatePatterns on DiaryCravingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryCravingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryCravingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryCravingState value)  $default,){
final _that = this;
switch (_that) {
case _DiaryCravingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryCravingState value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryCravingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DiaryCravingModel> listCraving,  int jumlahCraving)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryCravingState() when $default != null:
return $default(_that.listCraving,_that.jumlahCraving);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DiaryCravingModel> listCraving,  int jumlahCraving)  $default,) {final _that = this;
switch (_that) {
case _DiaryCravingState():
return $default(_that.listCraving,_that.jumlahCraving);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DiaryCravingModel> listCraving,  int jumlahCraving)?  $default,) {final _that = this;
switch (_that) {
case _DiaryCravingState() when $default != null:
return $default(_that.listCraving,_that.jumlahCraving);case _:
  return null;

}
}

}

/// @nodoc


class _DiaryCravingState extends DiaryCravingState {
  const _DiaryCravingState({ List<DiaryCravingModel> listCraving = const [], this.jumlahCraving = 0}): _listCraving = listCraving,super._();
  

 final  List<DiaryCravingModel> _listCraving;
@override@JsonKey() List<DiaryCravingModel> get listCraving {
  if (_listCraving is EqualUnmodifiableListView) return _listCraving;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listCraving);
}

@override@JsonKey() final  int jumlahCraving;

/// Create a copy of DiaryCravingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryCravingStateCopyWith<_DiaryCravingState> get copyWith => __$DiaryCravingStateCopyWithImpl<_DiaryCravingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryCravingState&&const DeepCollectionEquality().equals(other.listCraving, _listCraving)&&(identical(other.jumlahCraving, jumlahCraving) || other.jumlahCraving == jumlahCraving));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listCraving),jumlahCraving);
}

@override
String toString() {
    return 'DiaryCravingState(listCraving: $listCraving, jumlahCraving: $jumlahCraving)';
}


}

/// @nodoc
abstract mixin class _$DiaryCravingStateCopyWith<$Res> implements $DiaryCravingStateCopyWith<$Res> {
  factory _$DiaryCravingStateCopyWith(_DiaryCravingState value, $Res Function(_DiaryCravingState) _then) = __$DiaryCravingStateCopyWithImpl;
@override @useResult
$Res call({
 List<DiaryCravingModel> listCraving, int jumlahCraving
});




}
/// @nodoc
class __$DiaryCravingStateCopyWithImpl<$Res>
    implements _$DiaryCravingStateCopyWith<$Res> {
  __$DiaryCravingStateCopyWithImpl(this._self, this._then);

  final _DiaryCravingState _self;
  final $Res Function(_DiaryCravingState) _then;

/// Create a copy of DiaryCravingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listCraving = null,Object? jumlahCraving = null,}) {
  return _then(_DiaryCravingState(
listCraving: null == listCraving ? _self._listCraving : listCraving // ignore: cast_nullable_to_non_nullable
as List<DiaryCravingModel>,jumlahCraving: null == jumlahCraving ? _self.jumlahCraving : jumlahCraving // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
