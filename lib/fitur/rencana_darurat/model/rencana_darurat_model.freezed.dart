// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rencana_darurat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RencanaDaruratModel {

 String get id; String get jika; String get maka; DateTime get dibuat;
/// Create a copy of RencanaDaruratModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RencanaDaruratModelCopyWith<RencanaDaruratModel> get copyWith => _$RencanaDaruratModelCopyWithImpl<RencanaDaruratModel>(this as RencanaDaruratModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RencanaDaruratModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RencanaDaruratModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.jika, _this.jika) || other.jika == _this.jika)&&(identical(other.maka, _this.maka) || other.maka == _this.maka)&&(identical(other.dibuat, _this.dibuat) || other.dibuat == _this.dibuat));
}


@override
int get hashCode {
  final _this = this as RencanaDaruratModel;
  return Object.hash(runtimeType,_this.id,_this.jika,_this.maka,_this.dibuat);
}

@override
String toString() {
  final _this = this as RencanaDaruratModel;
  return 'RencanaDaruratModel(id: ${_this.id}, jika: ${_this.jika}, maka: ${_this.maka}, dibuat: ${_this.dibuat})';
}


}

/// @nodoc
abstract mixin class $RencanaDaruratModelCopyWith<$Res>  {
  factory $RencanaDaruratModelCopyWith(RencanaDaruratModel value, $Res Function(RencanaDaruratModel) _then) = _$RencanaDaruratModelCopyWithImpl;
@useResult
$Res call({
 String id, String jika, String maka, DateTime dibuat
});




}
/// @nodoc
class _$RencanaDaruratModelCopyWithImpl<$Res>
    implements $RencanaDaruratModelCopyWith<$Res> {
  _$RencanaDaruratModelCopyWithImpl(this._self, this._then);

  final RencanaDaruratModel _self;
  final $Res Function(RencanaDaruratModel) _then;

/// Create a copy of RencanaDaruratModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jika = null,Object? maka = null,Object? dibuat = null,}) {
  return _then(RencanaDaruratModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jika: null == jika ? _self.jika : jika // ignore: cast_nullable_to_non_nullable
as String,maka: null == maka ? _self.maka : maka // ignore: cast_nullable_to_non_nullable
as String,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RencanaDaruratModel].
extension RencanaDaruratModelPatterns on RencanaDaruratModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RencanaDaruratModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RencanaDaruratModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RencanaDaruratModel value)  $default,){
final _that = this;
switch (_that) {
case _RencanaDaruratModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RencanaDaruratModel value)?  $default,){
final _that = this;
switch (_that) {
case _RencanaDaruratModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jika,  String maka,  DateTime dibuat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RencanaDaruratModel() when $default != null:
return $default(_that.id,_that.jika,_that.maka,_that.dibuat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jika,  String maka,  DateTime dibuat)  $default,) {final _that = this;
switch (_that) {
case _RencanaDaruratModel():
return $default(_that.id,_that.jika,_that.maka,_that.dibuat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jika,  String maka,  DateTime dibuat)?  $default,) {final _that = this;
switch (_that) {
case _RencanaDaruratModel() when $default != null:
return $default(_that.id,_that.jika,_that.maka,_that.dibuat);case _:
  return null;

}
}

}

/// @nodoc


class _RencanaDaruratModel extends RencanaDaruratModel {
  const _RencanaDaruratModel({required this.id, required this.jika, required this.maka, required this.dibuat}): super._();
  

@override final  String id;
@override final  String jika;
@override final  String maka;
@override final  DateTime dibuat;

/// Create a copy of RencanaDaruratModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RencanaDaruratModelCopyWith<_RencanaDaruratModel> get copyWith => __$RencanaDaruratModelCopyWithImpl<_RencanaDaruratModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RencanaDaruratModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jika, jika) || other.jika == jika)&&(identical(other.maka, maka) || other.maka == maka)&&(identical(other.dibuat, dibuat) || other.dibuat == dibuat));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,jika,maka,dibuat);
}

@override
String toString() {
    return 'RencanaDaruratModel(id: $id, jika: $jika, maka: $maka, dibuat: $dibuat)';
}


}

/// @nodoc
abstract mixin class _$RencanaDaruratModelCopyWith<$Res> implements $RencanaDaruratModelCopyWith<$Res> {
  factory _$RencanaDaruratModelCopyWith(_RencanaDaruratModel value, $Res Function(_RencanaDaruratModel) _then) = __$RencanaDaruratModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String jika, String maka, DateTime dibuat
});




}
/// @nodoc
class __$RencanaDaruratModelCopyWithImpl<$Res>
    implements _$RencanaDaruratModelCopyWith<$Res> {
  __$RencanaDaruratModelCopyWithImpl(this._self, this._then);

  final _RencanaDaruratModel _self;
  final $Res Function(_RencanaDaruratModel) _then;

/// Create a copy of RencanaDaruratModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jika = null,Object? maka = null,Object? dibuat = null,}) {
  return _then(_RencanaDaruratModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jika: null == jika ? _self.jika : jika // ignore: cast_nullable_to_non_nullable
as String,maka: null == maka ? _self.maka : maka // ignore: cast_nullable_to_non_nullable
as String,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
