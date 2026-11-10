// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'konsumsi_rokok_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$KonsumsiRokokModel {

 String get id; DateTime get tanggal; int get jumlah; bool get isSlip; String? get catatan; DateTime get dibuat;
/// Create a copy of KonsumsiRokokModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KonsumsiRokokModelCopyWith<KonsumsiRokokModel> get copyWith => _$KonsumsiRokokModelCopyWithImpl<KonsumsiRokokModel>(this as KonsumsiRokokModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as KonsumsiRokokModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KonsumsiRokokModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tanggal, _this.tanggal) || other.tanggal == _this.tanggal)&&(identical(other.jumlah, _this.jumlah) || other.jumlah == _this.jumlah)&&(identical(other.isSlip, _this.isSlip) || other.isSlip == _this.isSlip)&&(identical(other.catatan, _this.catatan) || other.catatan == _this.catatan)&&(identical(other.dibuat, _this.dibuat) || other.dibuat == _this.dibuat));
}


@override
int get hashCode {
  final _this = this as KonsumsiRokokModel;
  return Object.hash(runtimeType,_this.id,_this.tanggal,_this.jumlah,_this.isSlip,_this.catatan,_this.dibuat);
}

@override
String toString() {
  final _this = this as KonsumsiRokokModel;
  return 'KonsumsiRokokModel(id: ${_this.id}, tanggal: ${_this.tanggal}, jumlah: ${_this.jumlah}, isSlip: ${_this.isSlip}, catatan: ${_this.catatan}, dibuat: ${_this.dibuat})';
}


}

/// @nodoc
abstract mixin class $KonsumsiRokokModelCopyWith<$Res>  {
  factory $KonsumsiRokokModelCopyWith(KonsumsiRokokModel value, $Res Function(KonsumsiRokokModel) _then) = _$KonsumsiRokokModelCopyWithImpl;
@useResult
$Res call({
 String id, DateTime tanggal, int jumlah, bool isSlip, String? catatan, DateTime dibuat
});




}
/// @nodoc
class _$KonsumsiRokokModelCopyWithImpl<$Res>
    implements $KonsumsiRokokModelCopyWith<$Res> {
  _$KonsumsiRokokModelCopyWithImpl(this._self, this._then);

  final KonsumsiRokokModel _self;
  final $Res Function(KonsumsiRokokModel) _then;

/// Create a copy of KonsumsiRokokModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tanggal = null,Object? jumlah = null,Object? isSlip = null,Object? catatan = freezed,Object? dibuat = null,}) {
  return _then(KonsumsiRokokModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tanggal: null == tanggal ? _self.tanggal : tanggal // ignore: cast_nullable_to_non_nullable
as DateTime,jumlah: null == jumlah ? _self.jumlah : jumlah // ignore: cast_nullable_to_non_nullable
as int,isSlip: null == isSlip ? _self.isSlip : isSlip // ignore: cast_nullable_to_non_nullable
as bool,catatan: freezed == catatan ? _self.catatan : catatan // ignore: cast_nullable_to_non_nullable
as String?,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [KonsumsiRokokModel].
extension KonsumsiRokokModelPatterns on KonsumsiRokokModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KonsumsiRokokModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KonsumsiRokokModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KonsumsiRokokModel value)  $default,){
final _that = this;
switch (_that) {
case _KonsumsiRokokModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KonsumsiRokokModel value)?  $default,){
final _that = this;
switch (_that) {
case _KonsumsiRokokModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime tanggal,  int jumlah,  bool isSlip,  String? catatan,  DateTime dibuat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KonsumsiRokokModel() when $default != null:
return $default(_that.id,_that.tanggal,_that.jumlah,_that.isSlip,_that.catatan,_that.dibuat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime tanggal,  int jumlah,  bool isSlip,  String? catatan,  DateTime dibuat)  $default,) {final _that = this;
switch (_that) {
case _KonsumsiRokokModel():
return $default(_that.id,_that.tanggal,_that.jumlah,_that.isSlip,_that.catatan,_that.dibuat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime tanggal,  int jumlah,  bool isSlip,  String? catatan,  DateTime dibuat)?  $default,) {final _that = this;
switch (_that) {
case _KonsumsiRokokModel() when $default != null:
return $default(_that.id,_that.tanggal,_that.jumlah,_that.isSlip,_that.catatan,_that.dibuat);case _:
  return null;

}
}

}

/// @nodoc


class _KonsumsiRokokModel extends KonsumsiRokokModel {
  const _KonsumsiRokokModel({required this.id, required this.tanggal, required this.jumlah, this.isSlip = false, this.catatan, required this.dibuat}): super._();
  

@override final  String id;
@override final  DateTime tanggal;
@override final  int jumlah;
@override@JsonKey() final  bool isSlip;
@override final  String? catatan;
@override final  DateTime dibuat;

/// Create a copy of KonsumsiRokokModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KonsumsiRokokModelCopyWith<_KonsumsiRokokModel> get copyWith => __$KonsumsiRokokModelCopyWithImpl<_KonsumsiRokokModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KonsumsiRokokModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tanggal, tanggal) || other.tanggal == tanggal)&&(identical(other.jumlah, jumlah) || other.jumlah == jumlah)&&(identical(other.isSlip, isSlip) || other.isSlip == isSlip)&&(identical(other.catatan, catatan) || other.catatan == catatan)&&(identical(other.dibuat, dibuat) || other.dibuat == dibuat));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tanggal,jumlah,isSlip,catatan,dibuat);
}

@override
String toString() {
    return 'KonsumsiRokokModel(id: $id, tanggal: $tanggal, jumlah: $jumlah, isSlip: $isSlip, catatan: $catatan, dibuat: $dibuat)';
}


}

/// @nodoc
abstract mixin class _$KonsumsiRokokModelCopyWith<$Res> implements $KonsumsiRokokModelCopyWith<$Res> {
  factory _$KonsumsiRokokModelCopyWith(_KonsumsiRokokModel value, $Res Function(_KonsumsiRokokModel) _then) = __$KonsumsiRokokModelCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime tanggal, int jumlah, bool isSlip, String? catatan, DateTime dibuat
});




}
/// @nodoc
class __$KonsumsiRokokModelCopyWithImpl<$Res>
    implements _$KonsumsiRokokModelCopyWith<$Res> {
  __$KonsumsiRokokModelCopyWithImpl(this._self, this._then);

  final _KonsumsiRokokModel _self;
  final $Res Function(_KonsumsiRokokModel) _then;

/// Create a copy of KonsumsiRokokModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tanggal = null,Object? jumlah = null,Object? isSlip = null,Object? catatan = freezed,Object? dibuat = null,}) {
  return _then(_KonsumsiRokokModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tanggal: null == tanggal ? _self.tanggal : tanggal // ignore: cast_nullable_to_non_nullable
as DateTime,jumlah: null == jumlah ? _self.jumlah : jumlah // ignore: cast_nullable_to_non_nullable
as int,isSlip: null == isSlip ? _self.isSlip : isSlip // ignore: cast_nullable_to_non_nullable
as bool,catatan: freezed == catatan ? _self.catatan : catatan // ignore: cast_nullable_to_non_nullable
as String?,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
