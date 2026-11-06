// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'impian_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImpianState {

 List<ImpianModel> get listImpian; int get jumlahImpian; double get totalJumlah;
/// Create a copy of ImpianState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImpianStateCopyWith<ImpianState> get copyWith => _$ImpianStateCopyWithImpl<ImpianState>(this as ImpianState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImpianState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImpianState&&const DeepCollectionEquality().equals(other.listImpian, _this.listImpian)&&(identical(other.jumlahImpian, _this.jumlahImpian) || other.jumlahImpian == _this.jumlahImpian)&&(identical(other.totalJumlah, _this.totalJumlah) || other.totalJumlah == _this.totalJumlah));
}


@override
int get hashCode {
  final _this = this as ImpianState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listImpian),_this.jumlahImpian,_this.totalJumlah);
}

@override
String toString() {
  final _this = this as ImpianState;
  return 'ImpianState(listImpian: ${_this.listImpian}, jumlahImpian: ${_this.jumlahImpian}, totalJumlah: ${_this.totalJumlah})';
}


}

/// @nodoc
abstract mixin class $ImpianStateCopyWith<$Res>  {
  factory $ImpianStateCopyWith(ImpianState value, $Res Function(ImpianState) _then) = _$ImpianStateCopyWithImpl;
@useResult
$Res call({
 List<ImpianModel> listImpian, int jumlahImpian, double totalJumlah
});




}
/// @nodoc
class _$ImpianStateCopyWithImpl<$Res>
    implements $ImpianStateCopyWith<$Res> {
  _$ImpianStateCopyWithImpl(this._self, this._then);

  final ImpianState _self;
  final $Res Function(ImpianState) _then;

/// Create a copy of ImpianState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listImpian = null,Object? jumlahImpian = null,Object? totalJumlah = null,}) {
  return _then(ImpianState(
listImpian: null == listImpian ? _self.listImpian : listImpian // ignore: cast_nullable_to_non_nullable
as List<ImpianModel>,jumlahImpian: null == jumlahImpian ? _self.jumlahImpian : jumlahImpian // ignore: cast_nullable_to_non_nullable
as int,totalJumlah: null == totalJumlah ? _self.totalJumlah : totalJumlah // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ImpianState].
extension ImpianStatePatterns on ImpianState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImpianState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImpianState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImpianState value)  $default,){
final _that = this;
switch (_that) {
case _ImpianState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImpianState value)?  $default,){
final _that = this;
switch (_that) {
case _ImpianState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ImpianModel> listImpian,  int jumlahImpian,  double totalJumlah)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImpianState() when $default != null:
return $default(_that.listImpian,_that.jumlahImpian,_that.totalJumlah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ImpianModel> listImpian,  int jumlahImpian,  double totalJumlah)  $default,) {final _that = this;
switch (_that) {
case _ImpianState():
return $default(_that.listImpian,_that.jumlahImpian,_that.totalJumlah);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ImpianModel> listImpian,  int jumlahImpian,  double totalJumlah)?  $default,) {final _that = this;
switch (_that) {
case _ImpianState() when $default != null:
return $default(_that.listImpian,_that.jumlahImpian,_that.totalJumlah);case _:
  return null;

}
}

}

/// @nodoc


class _ImpianState extends ImpianState {
  const _ImpianState({ List<ImpianModel> listImpian = const [], this.jumlahImpian = 0, this.totalJumlah = 0}): _listImpian = listImpian,super._();
  

 final  List<ImpianModel> _listImpian;
@override@JsonKey() List<ImpianModel> get listImpian {
  if (_listImpian is EqualUnmodifiableListView) return _listImpian;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listImpian);
}

@override@JsonKey() final  int jumlahImpian;
@override@JsonKey() final  double totalJumlah;

/// Create a copy of ImpianState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImpianStateCopyWith<_ImpianState> get copyWith => __$ImpianStateCopyWithImpl<_ImpianState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImpianState&&const DeepCollectionEquality().equals(other.listImpian, _listImpian)&&(identical(other.jumlahImpian, jumlahImpian) || other.jumlahImpian == jumlahImpian)&&(identical(other.totalJumlah, totalJumlah) || other.totalJumlah == totalJumlah));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listImpian),jumlahImpian,totalJumlah);
}

@override
String toString() {
    return 'ImpianState(listImpian: $listImpian, jumlahImpian: $jumlahImpian, totalJumlah: $totalJumlah)';
}


}

/// @nodoc
abstract mixin class _$ImpianStateCopyWith<$Res> implements $ImpianStateCopyWith<$Res> {
  factory _$ImpianStateCopyWith(_ImpianState value, $Res Function(_ImpianState) _then) = __$ImpianStateCopyWithImpl;
@override @useResult
$Res call({
 List<ImpianModel> listImpian, int jumlahImpian, double totalJumlah
});




}
/// @nodoc
class __$ImpianStateCopyWithImpl<$Res>
    implements _$ImpianStateCopyWith<$Res> {
  __$ImpianStateCopyWithImpl(this._self, this._then);

  final _ImpianState _self;
  final $Res Function(_ImpianState) _then;

/// Create a copy of ImpianState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listImpian = null,Object? jumlahImpian = null,Object? totalJumlah = null,}) {
  return _then(_ImpianState(
listImpian: null == listImpian ? _self._listImpian : listImpian // ignore: cast_nullable_to_non_nullable
as List<ImpianModel>,jumlahImpian: null == jumlahImpian ? _self.jumlahImpian : jumlahImpian // ignore: cast_nullable_to_non_nullable
as int,totalJumlah: null == totalJumlah ? _self.totalJumlah : totalJumlah // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
