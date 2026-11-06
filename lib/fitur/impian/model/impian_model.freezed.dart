// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'impian_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImpianModel {

 String get id; String get nama; DateTime get targetTanggal; DateTime get dibuat; double get jumlah;
/// Create a copy of ImpianModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImpianModelCopyWith<ImpianModel> get copyWith => _$ImpianModelCopyWithImpl<ImpianModel>(this as ImpianModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImpianModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImpianModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nama, _this.nama) || other.nama == _this.nama)&&(identical(other.targetTanggal, _this.targetTanggal) || other.targetTanggal == _this.targetTanggal)&&(identical(other.dibuat, _this.dibuat) || other.dibuat == _this.dibuat)&&(identical(other.jumlah, _this.jumlah) || other.jumlah == _this.jumlah));
}


@override
int get hashCode {
  final _this = this as ImpianModel;
  return Object.hash(runtimeType,_this.id,_this.nama,_this.targetTanggal,_this.dibuat,_this.jumlah);
}

@override
String toString() {
  final _this = this as ImpianModel;
  return 'ImpianModel(id: ${_this.id}, nama: ${_this.nama}, targetTanggal: ${_this.targetTanggal}, dibuat: ${_this.dibuat}, jumlah: ${_this.jumlah})';
}


}

/// @nodoc
abstract mixin class $ImpianModelCopyWith<$Res>  {
  factory $ImpianModelCopyWith(ImpianModel value, $Res Function(ImpianModel) _then) = _$ImpianModelCopyWithImpl;
@useResult
$Res call({
 String id, String nama, DateTime targetTanggal, DateTime dibuat, double jumlah
});




}
/// @nodoc
class _$ImpianModelCopyWithImpl<$Res>
    implements $ImpianModelCopyWith<$Res> {
  _$ImpianModelCopyWithImpl(this._self, this._then);

  final ImpianModel _self;
  final $Res Function(ImpianModel) _then;

/// Create a copy of ImpianModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nama = null,Object? targetTanggal = null,Object? dibuat = null,Object? jumlah = null,}) {
  return _then(ImpianModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,targetTanggal: null == targetTanggal ? _self.targetTanggal : targetTanggal // ignore: cast_nullable_to_non_nullable
as DateTime,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,jumlah: null == jumlah ? _self.jumlah : jumlah // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ImpianModel].
extension ImpianModelPatterns on ImpianModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImpianModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImpianModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImpianModel value)  $default,){
final _that = this;
switch (_that) {
case _ImpianModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImpianModel value)?  $default,){
final _that = this;
switch (_that) {
case _ImpianModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nama,  DateTime targetTanggal,  DateTime dibuat,  double jumlah)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImpianModel() when $default != null:
return $default(_that.id,_that.nama,_that.targetTanggal,_that.dibuat,_that.jumlah);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nama,  DateTime targetTanggal,  DateTime dibuat,  double jumlah)  $default,) {final _that = this;
switch (_that) {
case _ImpianModel():
return $default(_that.id,_that.nama,_that.targetTanggal,_that.dibuat,_that.jumlah);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nama,  DateTime targetTanggal,  DateTime dibuat,  double jumlah)?  $default,) {final _that = this;
switch (_that) {
case _ImpianModel() when $default != null:
return $default(_that.id,_that.nama,_that.targetTanggal,_that.dibuat,_that.jumlah);case _:
  return null;

}
}

}

/// @nodoc


class _ImpianModel extends ImpianModel {
  const _ImpianModel({required this.id, required this.nama, required this.targetTanggal, required this.dibuat, required this.jumlah}): super._();
  

@override final  String id;
@override final  String nama;
@override final  DateTime targetTanggal;
@override final  DateTime dibuat;
@override final  double jumlah;

/// Create a copy of ImpianModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImpianModelCopyWith<_ImpianModel> get copyWith => __$ImpianModelCopyWithImpl<_ImpianModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImpianModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.targetTanggal, targetTanggal) || other.targetTanggal == targetTanggal)&&(identical(other.dibuat, dibuat) || other.dibuat == dibuat)&&(identical(other.jumlah, jumlah) || other.jumlah == jumlah));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,nama,targetTanggal,dibuat,jumlah);
}

@override
String toString() {
    return 'ImpianModel(id: $id, nama: $nama, targetTanggal: $targetTanggal, dibuat: $dibuat, jumlah: $jumlah)';
}


}

/// @nodoc
abstract mixin class _$ImpianModelCopyWith<$Res> implements $ImpianModelCopyWith<$Res> {
  factory _$ImpianModelCopyWith(_ImpianModel value, $Res Function(_ImpianModel) _then) = __$ImpianModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String nama, DateTime targetTanggal, DateTime dibuat, double jumlah
});




}
/// @nodoc
class __$ImpianModelCopyWithImpl<$Res>
    implements _$ImpianModelCopyWith<$Res> {
  __$ImpianModelCopyWithImpl(this._self, this._then);

  final _ImpianModel _self;
  final $Res Function(_ImpianModel) _then;

/// Create a copy of ImpianModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nama = null,Object? targetTanggal = null,Object? dibuat = null,Object? jumlah = null,}) {
  return _then(_ImpianModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,targetTanggal: null == targetTanggal ? _self.targetTanggal : targetTanggal // ignore: cast_nullable_to_non_nullable
as DateTime,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,jumlah: null == jumlah ? _self.jumlah : jumlah // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
