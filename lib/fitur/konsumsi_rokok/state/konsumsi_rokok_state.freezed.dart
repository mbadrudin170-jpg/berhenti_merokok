// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'konsumsi_rokok_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KonsumsiRokokState {

 List<KonsumsiRokokModel> get listKonsumsi; int get jumlahTotal; Map<String, int> get ringkasanHarian;
/// Create a copy of KonsumsiRokokState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KonsumsiRokokStateCopyWith<KonsumsiRokokState> get copyWith => _$KonsumsiRokokStateCopyWithImpl<KonsumsiRokokState>(this as KonsumsiRokokState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KonsumsiRokokState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KonsumsiRokokState&&const DeepCollectionEquality().equals(other.listKonsumsi, _this.listKonsumsi)&&(identical(other.jumlahTotal, _this.jumlahTotal) || other.jumlahTotal == _this.jumlahTotal)&&const DeepCollectionEquality().equals(other.ringkasanHarian, _this.ringkasanHarian));
}


@override
int get hashCode {
  final _this = this as KonsumsiRokokState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.listKonsumsi),_this.jumlahTotal,const DeepCollectionEquality().hash(_this.ringkasanHarian));
}

@override
String toString() {
  final _this = this as KonsumsiRokokState;
  return 'KonsumsiRokokState(listKonsumsi: ${_this.listKonsumsi}, jumlahTotal: ${_this.jumlahTotal}, ringkasanHarian: ${_this.ringkasanHarian})';
}


}

/// @nodoc
abstract mixin class $KonsumsiRokokStateCopyWith<$Res>  {
  factory $KonsumsiRokokStateCopyWith(KonsumsiRokokState value, $Res Function(KonsumsiRokokState) _then) = _$KonsumsiRokokStateCopyWithImpl;
@useResult
$Res call({
 List<KonsumsiRokokModel> listKonsumsi, int jumlahTotal, Map<String, int> ringkasanHarian
});




}
/// @nodoc
class _$KonsumsiRokokStateCopyWithImpl<$Res>
    implements $KonsumsiRokokStateCopyWith<$Res> {
  _$KonsumsiRokokStateCopyWithImpl(this._self, this._then);

  final KonsumsiRokokState _self;
  final $Res Function(KonsumsiRokokState) _then;

/// Create a copy of KonsumsiRokokState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listKonsumsi = null,Object? jumlahTotal = null,Object? ringkasanHarian = null,}) {
  return _then(KonsumsiRokokState(
listKonsumsi: null == listKonsumsi ? _self.listKonsumsi : listKonsumsi // ignore: cast_nullable_to_non_nullable
as List<KonsumsiRokokModel>,jumlahTotal: null == jumlahTotal ? _self.jumlahTotal : jumlahTotal // ignore: cast_nullable_to_non_nullable
as int,ringkasanHarian: null == ringkasanHarian ? _self.ringkasanHarian : ringkasanHarian // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [KonsumsiRokokState].
extension KonsumsiRokokStatePatterns on KonsumsiRokokState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KonsumsiRokokState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KonsumsiRokokState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KonsumsiRokokState value)  $default,){
final _that = this;
switch (_that) {
case _KonsumsiRokokState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KonsumsiRokokState value)?  $default,){
final _that = this;
switch (_that) {
case _KonsumsiRokokState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<KonsumsiRokokModel> listKonsumsi,  int jumlahTotal,  Map<String, int> ringkasanHarian)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KonsumsiRokokState() when $default != null:
return $default(_that.listKonsumsi,_that.jumlahTotal,_that.ringkasanHarian);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<KonsumsiRokokModel> listKonsumsi,  int jumlahTotal,  Map<String, int> ringkasanHarian)  $default,) {final _that = this;
switch (_that) {
case _KonsumsiRokokState():
return $default(_that.listKonsumsi,_that.jumlahTotal,_that.ringkasanHarian);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<KonsumsiRokokModel> listKonsumsi,  int jumlahTotal,  Map<String, int> ringkasanHarian)?  $default,) {final _that = this;
switch (_that) {
case _KonsumsiRokokState() when $default != null:
return $default(_that.listKonsumsi,_that.jumlahTotal,_that.ringkasanHarian);case _:
  return null;

}
}

}

/// @nodoc


class _KonsumsiRokokState extends KonsumsiRokokState {
  const _KonsumsiRokokState({ List<KonsumsiRokokModel> listKonsumsi = const [], this.jumlahTotal = 0,  Map<String, int> ringkasanHarian = const {}}): _listKonsumsi = listKonsumsi,_ringkasanHarian = ringkasanHarian,super._();
  

 final  List<KonsumsiRokokModel> _listKonsumsi;
@override@JsonKey() List<KonsumsiRokokModel> get listKonsumsi {
  if (_listKonsumsi is EqualUnmodifiableListView) return _listKonsumsi;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_listKonsumsi);
}

@override@JsonKey() final  int jumlahTotal;
 final  Map<String, int> _ringkasanHarian;
@override@JsonKey() Map<String, int> get ringkasanHarian {
  if (_ringkasanHarian is EqualUnmodifiableMapView) return _ringkasanHarian;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ringkasanHarian);
}


/// Create a copy of KonsumsiRokokState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KonsumsiRokokStateCopyWith<_KonsumsiRokokState> get copyWith => __$KonsumsiRokokStateCopyWithImpl<_KonsumsiRokokState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KonsumsiRokokState&&const DeepCollectionEquality().equals(other.listKonsumsi, _listKonsumsi)&&(identical(other.jumlahTotal, jumlahTotal) || other.jumlahTotal == jumlahTotal)&&const DeepCollectionEquality().equals(other.ringkasanHarian, _ringkasanHarian));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_listKonsumsi),jumlahTotal,const DeepCollectionEquality().hash(_ringkasanHarian));
}

@override
String toString() {
    return 'KonsumsiRokokState(listKonsumsi: $listKonsumsi, jumlahTotal: $jumlahTotal, ringkasanHarian: $ringkasanHarian)';
}


}

/// @nodoc
abstract mixin class _$KonsumsiRokokStateCopyWith<$Res> implements $KonsumsiRokokStateCopyWith<$Res> {
  factory _$KonsumsiRokokStateCopyWith(_KonsumsiRokokState value, $Res Function(_KonsumsiRokokState) _then) = __$KonsumsiRokokStateCopyWithImpl;
@override @useResult
$Res call({
 List<KonsumsiRokokModel> listKonsumsi, int jumlahTotal, Map<String, int> ringkasanHarian
});




}
/// @nodoc
class __$KonsumsiRokokStateCopyWithImpl<$Res>
    implements _$KonsumsiRokokStateCopyWith<$Res> {
  __$KonsumsiRokokStateCopyWithImpl(this._self, this._then);

  final _KonsumsiRokokState _self;
  final $Res Function(_KonsumsiRokokState) _then;

/// Create a copy of KonsumsiRokokState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listKonsumsi = null,Object? jumlahTotal = null,Object? ringkasanHarian = null,}) {
  return _then(_KonsumsiRokokState(
listKonsumsi: null == listKonsumsi ? _self._listKonsumsi : listKonsumsi // ignore: cast_nullable_to_non_nullable
as List<KonsumsiRokokModel>,jumlahTotal: null == jumlahTotal ? _self.jumlahTotal : jumlahTotal // ignore: cast_nullable_to_non_nullable
as int,ringkasanHarian: null == ringkasanHarian ? _self._ringkasanHarian : ringkasanHarian // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
