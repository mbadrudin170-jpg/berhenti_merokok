// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_intervensi_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SosIntervensiModel {

 String get id; JenisIntervensiSos get jenisIntervensi; String? get detail; HasilIntervensiSos? get hasilIntervensi; String? get diaryCravingId; String? get substitusi; DateTime get dibuat;
/// Create a copy of SosIntervensiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SosIntervensiModelCopyWith<SosIntervensiModel> get copyWith => _$SosIntervensiModelCopyWithImpl<SosIntervensiModel>(this as SosIntervensiModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SosIntervensiModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SosIntervensiModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.jenisIntervensi, _this.jenisIntervensi) || other.jenisIntervensi == _this.jenisIntervensi)&&(identical(other.detail, _this.detail) || other.detail == _this.detail)&&(identical(other.hasilIntervensi, _this.hasilIntervensi) || other.hasilIntervensi == _this.hasilIntervensi)&&(identical(other.diaryCravingId, _this.diaryCravingId) || other.diaryCravingId == _this.diaryCravingId)&&(identical(other.substitusi, _this.substitusi) || other.substitusi == _this.substitusi)&&(identical(other.dibuat, _this.dibuat) || other.dibuat == _this.dibuat));
}


@override
int get hashCode {
  final _this = this as SosIntervensiModel;
  return Object.hash(runtimeType,_this.id,_this.jenisIntervensi,_this.detail,_this.hasilIntervensi,_this.diaryCravingId,_this.substitusi,_this.dibuat);
}

@override
String toString() {
  final _this = this as SosIntervensiModel;
  return 'SosIntervensiModel(id: ${_this.id}, jenisIntervensi: ${_this.jenisIntervensi}, detail: ${_this.detail}, hasilIntervensi: ${_this.hasilIntervensi}, diaryCravingId: ${_this.diaryCravingId}, substitusi: ${_this.substitusi}, dibuat: ${_this.dibuat})';
}


}

/// @nodoc
abstract mixin class $SosIntervensiModelCopyWith<$Res>  {
  factory $SosIntervensiModelCopyWith(SosIntervensiModel value, $Res Function(SosIntervensiModel) _then) = _$SosIntervensiModelCopyWithImpl;
@useResult
$Res call({
 String id, JenisIntervensiSos jenisIntervensi, String? detail, HasilIntervensiSos? hasilIntervensi, String? diaryCravingId, String? substitusi, DateTime dibuat
});




}
/// @nodoc
class _$SosIntervensiModelCopyWithImpl<$Res>
    implements $SosIntervensiModelCopyWith<$Res> {
  _$SosIntervensiModelCopyWithImpl(this._self, this._then);

  final SosIntervensiModel _self;
  final $Res Function(SosIntervensiModel) _then;

/// Create a copy of SosIntervensiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jenisIntervensi = null,Object? detail = freezed,Object? hasilIntervensi = freezed,Object? diaryCravingId = freezed,Object? substitusi = freezed,Object? dibuat = null,}) {
  return _then(SosIntervensiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jenisIntervensi: null == jenisIntervensi ? _self.jenisIntervensi : jenisIntervensi // ignore: cast_nullable_to_non_nullable
as JenisIntervensiSos,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,hasilIntervensi: freezed == hasilIntervensi ? _self.hasilIntervensi : hasilIntervensi // ignore: cast_nullable_to_non_nullable
as HasilIntervensiSos?,diaryCravingId: freezed == diaryCravingId ? _self.diaryCravingId : diaryCravingId // ignore: cast_nullable_to_non_nullable
as String?,substitusi: freezed == substitusi ? _self.substitusi : substitusi // ignore: cast_nullable_to_non_nullable
as String?,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SosIntervensiModel].
extension SosIntervensiModelPatterns on SosIntervensiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SosIntervensiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SosIntervensiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SosIntervensiModel value)  $default,){
final _that = this;
switch (_that) {
case _SosIntervensiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SosIntervensiModel value)?  $default,){
final _that = this;
switch (_that) {
case _SosIntervensiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  JenisIntervensiSos jenisIntervensi,  String? detail,  HasilIntervensiSos? hasilIntervensi,  String? diaryCravingId,  String? substitusi,  DateTime dibuat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SosIntervensiModel() when $default != null:
return $default(_that.id,_that.jenisIntervensi,_that.detail,_that.hasilIntervensi,_that.diaryCravingId,_that.substitusi,_that.dibuat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  JenisIntervensiSos jenisIntervensi,  String? detail,  HasilIntervensiSos? hasilIntervensi,  String? diaryCravingId,  String? substitusi,  DateTime dibuat)  $default,) {final _that = this;
switch (_that) {
case _SosIntervensiModel():
return $default(_that.id,_that.jenisIntervensi,_that.detail,_that.hasilIntervensi,_that.diaryCravingId,_that.substitusi,_that.dibuat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  JenisIntervensiSos jenisIntervensi,  String? detail,  HasilIntervensiSos? hasilIntervensi,  String? diaryCravingId,  String? substitusi,  DateTime dibuat)?  $default,) {final _that = this;
switch (_that) {
case _SosIntervensiModel() when $default != null:
return $default(_that.id,_that.jenisIntervensi,_that.detail,_that.hasilIntervensi,_that.diaryCravingId,_that.substitusi,_that.dibuat);case _:
  return null;

}
}

}

/// @nodoc


class _SosIntervensiModel extends SosIntervensiModel {
  const _SosIntervensiModel({required this.id, required this.jenisIntervensi, this.detail, this.hasilIntervensi, this.diaryCravingId, this.substitusi, required this.dibuat}): super._();
  

@override final  String id;
@override final  JenisIntervensiSos jenisIntervensi;
@override final  String? detail;
@override final  HasilIntervensiSos? hasilIntervensi;
@override final  String? diaryCravingId;
@override final  String? substitusi;
@override final  DateTime dibuat;

/// Create a copy of SosIntervensiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SosIntervensiModelCopyWith<_SosIntervensiModel> get copyWith => __$SosIntervensiModelCopyWithImpl<_SosIntervensiModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SosIntervensiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jenisIntervensi, jenisIntervensi) || other.jenisIntervensi == jenisIntervensi)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.hasilIntervensi, hasilIntervensi) || other.hasilIntervensi == hasilIntervensi)&&(identical(other.diaryCravingId, diaryCravingId) || other.diaryCravingId == diaryCravingId)&&(identical(other.substitusi, substitusi) || other.substitusi == substitusi)&&(identical(other.dibuat, dibuat) || other.dibuat == dibuat));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,jenisIntervensi,detail,hasilIntervensi,diaryCravingId,substitusi,dibuat);
}

@override
String toString() {
    return 'SosIntervensiModel(id: $id, jenisIntervensi: $jenisIntervensi, detail: $detail, hasilIntervensi: $hasilIntervensi, diaryCravingId: $diaryCravingId, substitusi: $substitusi, dibuat: $dibuat)';
}


}

/// @nodoc
abstract mixin class _$SosIntervensiModelCopyWith<$Res> implements $SosIntervensiModelCopyWith<$Res> {
  factory _$SosIntervensiModelCopyWith(_SosIntervensiModel value, $Res Function(_SosIntervensiModel) _then) = __$SosIntervensiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, JenisIntervensiSos jenisIntervensi, String? detail, HasilIntervensiSos? hasilIntervensi, String? diaryCravingId, String? substitusi, DateTime dibuat
});




}
/// @nodoc
class __$SosIntervensiModelCopyWithImpl<$Res>
    implements _$SosIntervensiModelCopyWith<$Res> {
  __$SosIntervensiModelCopyWithImpl(this._self, this._then);

  final _SosIntervensiModel _self;
  final $Res Function(_SosIntervensiModel) _then;

/// Create a copy of SosIntervensiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jenisIntervensi = null,Object? detail = freezed,Object? hasilIntervensi = freezed,Object? diaryCravingId = freezed,Object? substitusi = freezed,Object? dibuat = null,}) {
  return _then(_SosIntervensiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jenisIntervensi: null == jenisIntervensi ? _self.jenisIntervensi : jenisIntervensi // ignore: cast_nullable_to_non_nullable
as JenisIntervensiSos,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,hasilIntervensi: freezed == hasilIntervensi ? _self.hasilIntervensi : hasilIntervensi // ignore: cast_nullable_to_non_nullable
as HasilIntervensiSos?,diaryCravingId: freezed == diaryCravingId ? _self.diaryCravingId : diaryCravingId // ignore: cast_nullable_to_non_nullable
as String?,substitusi: freezed == substitusi ? _self.substitusi : substitusi // ignore: cast_nullable_to_non_nullable
as String?,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
