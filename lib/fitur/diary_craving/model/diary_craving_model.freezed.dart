// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_craving_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiaryCravingModel {

 String get id; DateTime get tanggal; PemicuEnum get pemicu; int get intensitas; String? get catatan; int? get durasiMenit; MoodCravingEnum? get mood; StrategiCravingEnum? get strategi; HasilCravingEnum? get hasil; DateTime get dibuat;
/// Create a copy of DiaryCravingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryCravingModelCopyWith<DiaryCravingModel> get copyWith => _$DiaryCravingModelCopyWithImpl<DiaryCravingModel>(this as DiaryCravingModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiaryCravingModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryCravingModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.tanggal, _this.tanggal) || other.tanggal == _this.tanggal)&&(identical(other.pemicu, _this.pemicu) || other.pemicu == _this.pemicu)&&(identical(other.intensitas, _this.intensitas) || other.intensitas == _this.intensitas)&&(identical(other.catatan, _this.catatan) || other.catatan == _this.catatan)&&(identical(other.durasiMenit, _this.durasiMenit) || other.durasiMenit == _this.durasiMenit)&&(identical(other.mood, _this.mood) || other.mood == _this.mood)&&(identical(other.strategi, _this.strategi) || other.strategi == _this.strategi)&&(identical(other.hasil, _this.hasil) || other.hasil == _this.hasil)&&(identical(other.dibuat, _this.dibuat) || other.dibuat == _this.dibuat));
}


@override
int get hashCode {
  final _this = this as DiaryCravingModel;
  return Object.hash(runtimeType,_this.id,_this.tanggal,_this.pemicu,_this.intensitas,_this.catatan,_this.durasiMenit,_this.mood,_this.strategi,_this.hasil,_this.dibuat);
}

@override
String toString() {
  final _this = this as DiaryCravingModel;
  return 'DiaryCravingModel(id: ${_this.id}, tanggal: ${_this.tanggal}, pemicu: ${_this.pemicu}, intensitas: ${_this.intensitas}, catatan: ${_this.catatan}, durasiMenit: ${_this.durasiMenit}, mood: ${_this.mood}, strategi: ${_this.strategi}, hasil: ${_this.hasil}, dibuat: ${_this.dibuat})';
}


}

/// @nodoc
abstract mixin class $DiaryCravingModelCopyWith<$Res>  {
  factory $DiaryCravingModelCopyWith(DiaryCravingModel value, $Res Function(DiaryCravingModel) _then) = _$DiaryCravingModelCopyWithImpl;
@useResult
$Res call({
 String id, DateTime tanggal, PemicuEnum pemicu, int intensitas, String? catatan, int? durasiMenit, MoodCravingEnum? mood, StrategiCravingEnum? strategi, HasilCravingEnum? hasil, DateTime dibuat
});




}
/// @nodoc
class _$DiaryCravingModelCopyWithImpl<$Res>
    implements $DiaryCravingModelCopyWith<$Res> {
  _$DiaryCravingModelCopyWithImpl(this._self, this._then);

  final DiaryCravingModel _self;
  final $Res Function(DiaryCravingModel) _then;

/// Create a copy of DiaryCravingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tanggal = null,Object? pemicu = null,Object? intensitas = null,Object? catatan = freezed,Object? durasiMenit = freezed,Object? mood = freezed,Object? strategi = freezed,Object? hasil = freezed,Object? dibuat = null,}) {
  return _then(DiaryCravingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tanggal: null == tanggal ? _self.tanggal : tanggal // ignore: cast_nullable_to_non_nullable
as DateTime,pemicu: null == pemicu ? _self.pemicu : pemicu // ignore: cast_nullable_to_non_nullable
as PemicuEnum,intensitas: null == intensitas ? _self.intensitas : intensitas // ignore: cast_nullable_to_non_nullable
as int,catatan: freezed == catatan ? _self.catatan : catatan // ignore: cast_nullable_to_non_nullable
as String?,durasiMenit: freezed == durasiMenit ? _self.durasiMenit : durasiMenit // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as MoodCravingEnum?,strategi: freezed == strategi ? _self.strategi : strategi // ignore: cast_nullable_to_non_nullable
as StrategiCravingEnum?,hasil: freezed == hasil ? _self.hasil : hasil // ignore: cast_nullable_to_non_nullable
as HasilCravingEnum?,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DiaryCravingModel].
extension DiaryCravingModelPatterns on DiaryCravingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryCravingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryCravingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryCravingModel value)  $default,){
final _that = this;
switch (_that) {
case _DiaryCravingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryCravingModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryCravingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime tanggal,  PemicuEnum pemicu,  int intensitas,  String? catatan,  int? durasiMenit,  MoodCravingEnum? mood,  StrategiCravingEnum? strategi,  HasilCravingEnum? hasil,  DateTime dibuat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryCravingModel() when $default != null:
return $default(_that.id,_that.tanggal,_that.pemicu,_that.intensitas,_that.catatan,_that.durasiMenit,_that.mood,_that.strategi,_that.hasil,_that.dibuat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime tanggal,  PemicuEnum pemicu,  int intensitas,  String? catatan,  int? durasiMenit,  MoodCravingEnum? mood,  StrategiCravingEnum? strategi,  HasilCravingEnum? hasil,  DateTime dibuat)  $default,) {final _that = this;
switch (_that) {
case _DiaryCravingModel():
return $default(_that.id,_that.tanggal,_that.pemicu,_that.intensitas,_that.catatan,_that.durasiMenit,_that.mood,_that.strategi,_that.hasil,_that.dibuat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime tanggal,  PemicuEnum pemicu,  int intensitas,  String? catatan,  int? durasiMenit,  MoodCravingEnum? mood,  StrategiCravingEnum? strategi,  HasilCravingEnum? hasil,  DateTime dibuat)?  $default,) {final _that = this;
switch (_that) {
case _DiaryCravingModel() when $default != null:
return $default(_that.id,_that.tanggal,_that.pemicu,_that.intensitas,_that.catatan,_that.durasiMenit,_that.mood,_that.strategi,_that.hasil,_that.dibuat);case _:
  return null;

}
}

}

/// @nodoc


class _DiaryCravingModel extends DiaryCravingModel {
  const _DiaryCravingModel({required this.id, required this.tanggal, required this.pemicu, this.intensitas = 3, this.catatan, this.durasiMenit, this.mood, this.strategi, this.hasil, required this.dibuat}): super._();
  

@override final  String id;
@override final  DateTime tanggal;
@override final  PemicuEnum pemicu;
@override@JsonKey() final  int intensitas;
@override final  String? catatan;
@override final  int? durasiMenit;
@override final  MoodCravingEnum? mood;
@override final  StrategiCravingEnum? strategi;
@override final  HasilCravingEnum? hasil;
@override final  DateTime dibuat;

/// Create a copy of DiaryCravingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryCravingModelCopyWith<_DiaryCravingModel> get copyWith => __$DiaryCravingModelCopyWithImpl<_DiaryCravingModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryCravingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.tanggal, tanggal) || other.tanggal == tanggal)&&(identical(other.pemicu, pemicu) || other.pemicu == pemicu)&&(identical(other.intensitas, intensitas) || other.intensitas == intensitas)&&(identical(other.catatan, catatan) || other.catatan == catatan)&&(identical(other.durasiMenit, durasiMenit) || other.durasiMenit == durasiMenit)&&(identical(other.mood, mood) || other.mood == mood)&&(identical(other.strategi, strategi) || other.strategi == strategi)&&(identical(other.hasil, hasil) || other.hasil == hasil)&&(identical(other.dibuat, dibuat) || other.dibuat == dibuat));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,tanggal,pemicu,intensitas,catatan,durasiMenit,mood,strategi,hasil,dibuat);
}

@override
String toString() {
    return 'DiaryCravingModel(id: $id, tanggal: $tanggal, pemicu: $pemicu, intensitas: $intensitas, catatan: $catatan, durasiMenit: $durasiMenit, mood: $mood, strategi: $strategi, hasil: $hasil, dibuat: $dibuat)';
}


}

/// @nodoc
abstract mixin class _$DiaryCravingModelCopyWith<$Res> implements $DiaryCravingModelCopyWith<$Res> {
  factory _$DiaryCravingModelCopyWith(_DiaryCravingModel value, $Res Function(_DiaryCravingModel) _then) = __$DiaryCravingModelCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime tanggal, PemicuEnum pemicu, int intensitas, String? catatan, int? durasiMenit, MoodCravingEnum? mood, StrategiCravingEnum? strategi, HasilCravingEnum? hasil, DateTime dibuat
});




}
/// @nodoc
class __$DiaryCravingModelCopyWithImpl<$Res>
    implements _$DiaryCravingModelCopyWith<$Res> {
  __$DiaryCravingModelCopyWithImpl(this._self, this._then);

  final _DiaryCravingModel _self;
  final $Res Function(_DiaryCravingModel) _then;

/// Create a copy of DiaryCravingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tanggal = null,Object? pemicu = null,Object? intensitas = null,Object? catatan = freezed,Object? durasiMenit = freezed,Object? mood = freezed,Object? strategi = freezed,Object? hasil = freezed,Object? dibuat = null,}) {
  return _then(_DiaryCravingModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,tanggal: null == tanggal ? _self.tanggal : tanggal // ignore: cast_nullable_to_non_nullable
as DateTime,pemicu: null == pemicu ? _self.pemicu : pemicu // ignore: cast_nullable_to_non_nullable
as PemicuEnum,intensitas: null == intensitas ? _self.intensitas : intensitas // ignore: cast_nullable_to_non_nullable
as int,catatan: freezed == catatan ? _self.catatan : catatan // ignore: cast_nullable_to_non_nullable
as String?,durasiMenit: freezed == durasiMenit ? _self.durasiMenit : durasiMenit // ignore: cast_nullable_to_non_nullable
as int?,mood: freezed == mood ? _self.mood : mood // ignore: cast_nullable_to_non_nullable
as MoodCravingEnum?,strategi: freezed == strategi ? _self.strategi : strategi // ignore: cast_nullable_to_non_nullable
as StrategiCravingEnum?,hasil: freezed == hasil ? _self.hasil : hasil // ignore: cast_nullable_to_non_nullable
as HasilCravingEnum?,dibuat: null == dibuat ? _self.dibuat : dibuat // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
