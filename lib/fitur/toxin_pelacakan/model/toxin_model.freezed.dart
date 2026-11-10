// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toxin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToxinModel {

 String get nama; String get jenisZat; double get faktorPerBatang; String get efekSingkat; String get sumberReferensi; double get kuantitasDiHindari;
/// Create a copy of ToxinModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToxinModelCopyWith<ToxinModel> get copyWith => _$ToxinModelCopyWithImpl<ToxinModel>(this as ToxinModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ToxinModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToxinModel&&(identical(other.nama, _this.nama) || other.nama == _this.nama)&&(identical(other.jenisZat, _this.jenisZat) || other.jenisZat == _this.jenisZat)&&(identical(other.faktorPerBatang, _this.faktorPerBatang) || other.faktorPerBatang == _this.faktorPerBatang)&&(identical(other.efekSingkat, _this.efekSingkat) || other.efekSingkat == _this.efekSingkat)&&(identical(other.sumberReferensi, _this.sumberReferensi) || other.sumberReferensi == _this.sumberReferensi)&&(identical(other.kuantitasDiHindari, _this.kuantitasDiHindari) || other.kuantitasDiHindari == _this.kuantitasDiHindari));
}


@override
int get hashCode {
  final _this = this as ToxinModel;
  return Object.hash(runtimeType,_this.nama,_this.jenisZat,_this.faktorPerBatang,_this.efekSingkat,_this.sumberReferensi,_this.kuantitasDiHindari);
}

@override
String toString() {
  final _this = this as ToxinModel;
  return 'ToxinModel(nama: ${_this.nama}, jenisZat: ${_this.jenisZat}, faktorPerBatang: ${_this.faktorPerBatang}, efekSingkat: ${_this.efekSingkat}, sumberReferensi: ${_this.sumberReferensi}, kuantitasDiHindari: ${_this.kuantitasDiHindari})';
}


}

/// @nodoc
abstract mixin class $ToxinModelCopyWith<$Res>  {
  factory $ToxinModelCopyWith(ToxinModel value, $Res Function(ToxinModel) _then) = _$ToxinModelCopyWithImpl;
@useResult
$Res call({
 String nama, String jenisZat, double faktorPerBatang, String efekSingkat, String sumberReferensi, double kuantitasDiHindari
});




}
/// @nodoc
class _$ToxinModelCopyWithImpl<$Res>
    implements $ToxinModelCopyWith<$Res> {
  _$ToxinModelCopyWithImpl(this._self, this._then);

  final ToxinModel _self;
  final $Res Function(ToxinModel) _then;

/// Create a copy of ToxinModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nama = null,Object? jenisZat = null,Object? faktorPerBatang = null,Object? efekSingkat = null,Object? sumberReferensi = null,Object? kuantitasDiHindari = null,}) {
  return _then(ToxinModel(
nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,jenisZat: null == jenisZat ? _self.jenisZat : jenisZat // ignore: cast_nullable_to_non_nullable
as String,faktorPerBatang: null == faktorPerBatang ? _self.faktorPerBatang : faktorPerBatang // ignore: cast_nullable_to_non_nullable
as double,efekSingkat: null == efekSingkat ? _self.efekSingkat : efekSingkat // ignore: cast_nullable_to_non_nullable
as String,sumberReferensi: null == sumberReferensi ? _self.sumberReferensi : sumberReferensi // ignore: cast_nullable_to_non_nullable
as String,kuantitasDiHindari: null == kuantitasDiHindari ? _self.kuantitasDiHindari : kuantitasDiHindari // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ToxinModel].
extension ToxinModelPatterns on ToxinModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToxinModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToxinModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToxinModel value)  $default,){
final _that = this;
switch (_that) {
case _ToxinModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToxinModel value)?  $default,){
final _that = this;
switch (_that) {
case _ToxinModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nama,  String jenisZat,  double faktorPerBatang,  String efekSingkat,  String sumberReferensi,  double kuantitasDiHindari)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToxinModel() when $default != null:
return $default(_that.nama,_that.jenisZat,_that.faktorPerBatang,_that.efekSingkat,_that.sumberReferensi,_that.kuantitasDiHindari);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nama,  String jenisZat,  double faktorPerBatang,  String efekSingkat,  String sumberReferensi,  double kuantitasDiHindari)  $default,) {final _that = this;
switch (_that) {
case _ToxinModel():
return $default(_that.nama,_that.jenisZat,_that.faktorPerBatang,_that.efekSingkat,_that.sumberReferensi,_that.kuantitasDiHindari);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nama,  String jenisZat,  double faktorPerBatang,  String efekSingkat,  String sumberReferensi,  double kuantitasDiHindari)?  $default,) {final _that = this;
switch (_that) {
case _ToxinModel() when $default != null:
return $default(_that.nama,_that.jenisZat,_that.faktorPerBatang,_that.efekSingkat,_that.sumberReferensi,_that.kuantitasDiHindari);case _:
  return null;

}
}

}

/// @nodoc


class _ToxinModel extends ToxinModel {
  const _ToxinModel({required this.nama, required this.jenisZat, required this.faktorPerBatang, required this.efekSingkat, required this.sumberReferensi, this.kuantitasDiHindari = 0.0}): super._();
  

@override final  String nama;
@override final  String jenisZat;
@override final  double faktorPerBatang;
@override final  String efekSingkat;
@override final  String sumberReferensi;
@override@JsonKey() final  double kuantitasDiHindari;

/// Create a copy of ToxinModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToxinModelCopyWith<_ToxinModel> get copyWith => __$ToxinModelCopyWithImpl<_ToxinModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToxinModel&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.jenisZat, jenisZat) || other.jenisZat == jenisZat)&&(identical(other.faktorPerBatang, faktorPerBatang) || other.faktorPerBatang == faktorPerBatang)&&(identical(other.efekSingkat, efekSingkat) || other.efekSingkat == efekSingkat)&&(identical(other.sumberReferensi, sumberReferensi) || other.sumberReferensi == sumberReferensi)&&(identical(other.kuantitasDiHindari, kuantitasDiHindari) || other.kuantitasDiHindari == kuantitasDiHindari));
}


@override
int get hashCode {
    return Object.hash(runtimeType,nama,jenisZat,faktorPerBatang,efekSingkat,sumberReferensi,kuantitasDiHindari);
}

@override
String toString() {
    return 'ToxinModel(nama: $nama, jenisZat: $jenisZat, faktorPerBatang: $faktorPerBatang, efekSingkat: $efekSingkat, sumberReferensi: $sumberReferensi, kuantitasDiHindari: $kuantitasDiHindari)';
}


}

/// @nodoc
abstract mixin class _$ToxinModelCopyWith<$Res> implements $ToxinModelCopyWith<$Res> {
  factory _$ToxinModelCopyWith(_ToxinModel value, $Res Function(_ToxinModel) _then) = __$ToxinModelCopyWithImpl;
@override @useResult
$Res call({
 String nama, String jenisZat, double faktorPerBatang, String efekSingkat, String sumberReferensi, double kuantitasDiHindari
});




}
/// @nodoc
class __$ToxinModelCopyWithImpl<$Res>
    implements _$ToxinModelCopyWith<$Res> {
  __$ToxinModelCopyWithImpl(this._self, this._then);

  final _ToxinModel _self;
  final $Res Function(_ToxinModel) _then;

/// Create a copy of ToxinModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nama = null,Object? jenisZat = null,Object? faktorPerBatang = null,Object? efekSingkat = null,Object? sumberReferensi = null,Object? kuantitasDiHindari = null,}) {
  return _then(_ToxinModel(
nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,jenisZat: null == jenisZat ? _self.jenisZat : jenisZat // ignore: cast_nullable_to_non_nullable
as String,faktorPerBatang: null == faktorPerBatang ? _self.faktorPerBatang : faktorPerBatang // ignore: cast_nullable_to_non_nullable
as double,efekSingkat: null == efekSingkat ? _self.efekSingkat : efekSingkat // ignore: cast_nullable_to_non_nullable
as String,sumberReferensi: null == sumberReferensi ? _self.sumberReferensi : sumberReferensi // ignore: cast_nullable_to_non_nullable
as String,kuantitasDiHindari: null == kuantitasDiHindari ? _self.kuantitasDiHindari : kuantitasDiHindari // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
