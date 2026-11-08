// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biodata_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BiodataModel {

 String get id; String get nama; DateTime? get tanggalLahir; int get jumlahRokokPerHari; double get hargaRokokPerBungkus; double get batangPerBungkus; DateTime? get tanggalMulaiMerokok; DateTime? get tanggalMulaiBerhentiMerokok; ModeBerhenti get modeBerhenti; int get penurunanPerMinggu; DateTime? get tanggalMulaiTapering; int? get targetSmokeFreeHari;
/// Create a copy of BiodataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiodataModelCopyWith<BiodataModel> get copyWith => _$BiodataModelCopyWithImpl<BiodataModel>(this as BiodataModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BiodataModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiodataModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nama, _this.nama) || other.nama == _this.nama)&&(identical(other.tanggalLahir, _this.tanggalLahir) || other.tanggalLahir == _this.tanggalLahir)&&(identical(other.jumlahRokokPerHari, _this.jumlahRokokPerHari) || other.jumlahRokokPerHari == _this.jumlahRokokPerHari)&&(identical(other.hargaRokokPerBungkus, _this.hargaRokokPerBungkus) || other.hargaRokokPerBungkus == _this.hargaRokokPerBungkus)&&(identical(other.batangPerBungkus, _this.batangPerBungkus) || other.batangPerBungkus == _this.batangPerBungkus)&&(identical(other.tanggalMulaiMerokok, _this.tanggalMulaiMerokok) || other.tanggalMulaiMerokok == _this.tanggalMulaiMerokok)&&(identical(other.tanggalMulaiBerhentiMerokok, _this.tanggalMulaiBerhentiMerokok) || other.tanggalMulaiBerhentiMerokok == _this.tanggalMulaiBerhentiMerokok)&&(identical(other.modeBerhenti, _this.modeBerhenti) || other.modeBerhenti == _this.modeBerhenti)&&(identical(other.penurunanPerMinggu, _this.penurunanPerMinggu) || other.penurunanPerMinggu == _this.penurunanPerMinggu)&&(identical(other.tanggalMulaiTapering, _this.tanggalMulaiTapering) || other.tanggalMulaiTapering == _this.tanggalMulaiTapering)&&(identical(other.targetSmokeFreeHari, _this.targetSmokeFreeHari) || other.targetSmokeFreeHari == _this.targetSmokeFreeHari));
}


@override
int get hashCode {
  final _this = this as BiodataModel;
  return Object.hash(runtimeType,_this.id,_this.nama,_this.tanggalLahir,_this.jumlahRokokPerHari,_this.hargaRokokPerBungkus,_this.batangPerBungkus,_this.tanggalMulaiMerokok,_this.tanggalMulaiBerhentiMerokok,_this.modeBerhenti,_this.penurunanPerMinggu,_this.tanggalMulaiTapering,_this.targetSmokeFreeHari);
}

@override
String toString() {
  final _this = this as BiodataModel;
  return 'BiodataModel(id: ${_this.id}, nama: ${_this.nama}, tanggalLahir: ${_this.tanggalLahir}, jumlahRokokPerHari: ${_this.jumlahRokokPerHari}, hargaRokokPerBungkus: ${_this.hargaRokokPerBungkus}, batangPerBungkus: ${_this.batangPerBungkus}, tanggalMulaiMerokok: ${_this.tanggalMulaiMerokok}, tanggalMulaiBerhentiMerokok: ${_this.tanggalMulaiBerhentiMerokok}, modeBerhenti: ${_this.modeBerhenti}, penurunanPerMinggu: ${_this.penurunanPerMinggu}, tanggalMulaiTapering: ${_this.tanggalMulaiTapering}, targetSmokeFreeHari: ${_this.targetSmokeFreeHari})';
}


}

/// @nodoc
abstract mixin class $BiodataModelCopyWith<$Res>  {
  factory $BiodataModelCopyWith(BiodataModel value, $Res Function(BiodataModel) _then) = _$BiodataModelCopyWithImpl;
@useResult
$Res call({
 String id, String nama, DateTime? tanggalLahir, int jumlahRokokPerHari, double hargaRokokPerBungkus, double batangPerBungkus, DateTime? tanggalMulaiMerokok, DateTime? tanggalMulaiBerhentiMerokok, ModeBerhenti modeBerhenti, int penurunanPerMinggu, DateTime? tanggalMulaiTapering, int? targetSmokeFreeHari
});




}
/// @nodoc
class _$BiodataModelCopyWithImpl<$Res>
    implements $BiodataModelCopyWith<$Res> {
  _$BiodataModelCopyWithImpl(this._self, this._then);

  final BiodataModel _self;
  final $Res Function(BiodataModel) _then;

/// Create a copy of BiodataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nama = null,Object? tanggalLahir = freezed,Object? jumlahRokokPerHari = null,Object? hargaRokokPerBungkus = null,Object? batangPerBungkus = null,Object? tanggalMulaiMerokok = freezed,Object? tanggalMulaiBerhentiMerokok = freezed,Object? modeBerhenti = null,Object? penurunanPerMinggu = null,Object? tanggalMulaiTapering = freezed,Object? targetSmokeFreeHari = freezed,}) {
  return _then(BiodataModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,tanggalLahir: freezed == tanggalLahir ? _self.tanggalLahir : tanggalLahir // ignore: cast_nullable_to_non_nullable
as DateTime?,jumlahRokokPerHari: null == jumlahRokokPerHari ? _self.jumlahRokokPerHari : jumlahRokokPerHari // ignore: cast_nullable_to_non_nullable
as int,hargaRokokPerBungkus: null == hargaRokokPerBungkus ? _self.hargaRokokPerBungkus : hargaRokokPerBungkus // ignore: cast_nullable_to_non_nullable
as double,batangPerBungkus: null == batangPerBungkus ? _self.batangPerBungkus : batangPerBungkus // ignore: cast_nullable_to_non_nullable
as double,tanggalMulaiMerokok: freezed == tanggalMulaiMerokok ? _self.tanggalMulaiMerokok : tanggalMulaiMerokok // ignore: cast_nullable_to_non_nullable
as DateTime?,tanggalMulaiBerhentiMerokok: freezed == tanggalMulaiBerhentiMerokok ? _self.tanggalMulaiBerhentiMerokok : tanggalMulaiBerhentiMerokok // ignore: cast_nullable_to_non_nullable
as DateTime?,modeBerhenti: null == modeBerhenti ? _self.modeBerhenti : modeBerhenti // ignore: cast_nullable_to_non_nullable
as ModeBerhenti,penurunanPerMinggu: null == penurunanPerMinggu ? _self.penurunanPerMinggu : penurunanPerMinggu // ignore: cast_nullable_to_non_nullable
as int,tanggalMulaiTapering: freezed == tanggalMulaiTapering ? _self.tanggalMulaiTapering : tanggalMulaiTapering // ignore: cast_nullable_to_non_nullable
as DateTime?,targetSmokeFreeHari: freezed == targetSmokeFreeHari ? _self.targetSmokeFreeHari : targetSmokeFreeHari // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BiodataModel].
extension BiodataModelPatterns on BiodataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiodataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiodataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiodataModel value)  $default,){
final _that = this;
switch (_that) {
case _BiodataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiodataModel value)?  $default,){
final _that = this;
switch (_that) {
case _BiodataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nama,  DateTime? tanggalLahir,  int jumlahRokokPerHari,  double hargaRokokPerBungkus,  double batangPerBungkus,  DateTime? tanggalMulaiMerokok,  DateTime? tanggalMulaiBerhentiMerokok,  ModeBerhenti modeBerhenti,  int penurunanPerMinggu,  DateTime? tanggalMulaiTapering,  int? targetSmokeFreeHari)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiodataModel() when $default != null:
return $default(_that.id,_that.nama,_that.tanggalLahir,_that.jumlahRokokPerHari,_that.hargaRokokPerBungkus,_that.batangPerBungkus,_that.tanggalMulaiMerokok,_that.tanggalMulaiBerhentiMerokok,_that.modeBerhenti,_that.penurunanPerMinggu,_that.tanggalMulaiTapering,_that.targetSmokeFreeHari);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nama,  DateTime? tanggalLahir,  int jumlahRokokPerHari,  double hargaRokokPerBungkus,  double batangPerBungkus,  DateTime? tanggalMulaiMerokok,  DateTime? tanggalMulaiBerhentiMerokok,  ModeBerhenti modeBerhenti,  int penurunanPerMinggu,  DateTime? tanggalMulaiTapering,  int? targetSmokeFreeHari)  $default,) {final _that = this;
switch (_that) {
case _BiodataModel():
return $default(_that.id,_that.nama,_that.tanggalLahir,_that.jumlahRokokPerHari,_that.hargaRokokPerBungkus,_that.batangPerBungkus,_that.tanggalMulaiMerokok,_that.tanggalMulaiBerhentiMerokok,_that.modeBerhenti,_that.penurunanPerMinggu,_that.tanggalMulaiTapering,_that.targetSmokeFreeHari);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nama,  DateTime? tanggalLahir,  int jumlahRokokPerHari,  double hargaRokokPerBungkus,  double batangPerBungkus,  DateTime? tanggalMulaiMerokok,  DateTime? tanggalMulaiBerhentiMerokok,  ModeBerhenti modeBerhenti,  int penurunanPerMinggu,  DateTime? tanggalMulaiTapering,  int? targetSmokeFreeHari)?  $default,) {final _that = this;
switch (_that) {
case _BiodataModel() when $default != null:
return $default(_that.id,_that.nama,_that.tanggalLahir,_that.jumlahRokokPerHari,_that.hargaRokokPerBungkus,_that.batangPerBungkus,_that.tanggalMulaiMerokok,_that.tanggalMulaiBerhentiMerokok,_that.modeBerhenti,_that.penurunanPerMinggu,_that.tanggalMulaiTapering,_that.targetSmokeFreeHari);case _:
  return null;

}
}

}

/// @nodoc


class _BiodataModel extends BiodataModel {
  const _BiodataModel({required this.id, required this.nama, this.tanggalLahir, this.jumlahRokokPerHari = 10, this.hargaRokokPerBungkus = 0.0, this.batangPerBungkus = 20.0, this.tanggalMulaiMerokok, this.tanggalMulaiBerhentiMerokok, this.modeBerhenti = ModeBerhenti.seketika, this.penurunanPerMinggu = 0, this.tanggalMulaiTapering, this.targetSmokeFreeHari}): super._();
  

@override final  String id;
@override final  String nama;
@override final  DateTime? tanggalLahir;
@override@JsonKey() final  int jumlahRokokPerHari;
@override@JsonKey() final  double hargaRokokPerBungkus;
@override@JsonKey() final  double batangPerBungkus;
@override final  DateTime? tanggalMulaiMerokok;
@override final  DateTime? tanggalMulaiBerhentiMerokok;
@override@JsonKey() final  ModeBerhenti modeBerhenti;
@override@JsonKey() final  int penurunanPerMinggu;
@override final  DateTime? tanggalMulaiTapering;
@override final  int? targetSmokeFreeHari;

/// Create a copy of BiodataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiodataModelCopyWith<_BiodataModel> get copyWith => __$BiodataModelCopyWithImpl<_BiodataModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiodataModel&&(identical(other.id, id) || other.id == id)&&(identical(other.nama, nama) || other.nama == nama)&&(identical(other.tanggalLahir, tanggalLahir) || other.tanggalLahir == tanggalLahir)&&(identical(other.jumlahRokokPerHari, jumlahRokokPerHari) || other.jumlahRokokPerHari == jumlahRokokPerHari)&&(identical(other.hargaRokokPerBungkus, hargaRokokPerBungkus) || other.hargaRokokPerBungkus == hargaRokokPerBungkus)&&(identical(other.batangPerBungkus, batangPerBungkus) || other.batangPerBungkus == batangPerBungkus)&&(identical(other.tanggalMulaiMerokok, tanggalMulaiMerokok) || other.tanggalMulaiMerokok == tanggalMulaiMerokok)&&(identical(other.tanggalMulaiBerhentiMerokok, tanggalMulaiBerhentiMerokok) || other.tanggalMulaiBerhentiMerokok == tanggalMulaiBerhentiMerokok)&&(identical(other.modeBerhenti, modeBerhenti) || other.modeBerhenti == modeBerhenti)&&(identical(other.penurunanPerMinggu, penurunanPerMinggu) || other.penurunanPerMinggu == penurunanPerMinggu)&&(identical(other.tanggalMulaiTapering, tanggalMulaiTapering) || other.tanggalMulaiTapering == tanggalMulaiTapering)&&(identical(other.targetSmokeFreeHari, targetSmokeFreeHari) || other.targetSmokeFreeHari == targetSmokeFreeHari));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,nama,tanggalLahir,jumlahRokokPerHari,hargaRokokPerBungkus,batangPerBungkus,tanggalMulaiMerokok,tanggalMulaiBerhentiMerokok,modeBerhenti,penurunanPerMinggu,tanggalMulaiTapering,targetSmokeFreeHari);
}

@override
String toString() {
    return 'BiodataModel(id: $id, nama: $nama, tanggalLahir: $tanggalLahir, jumlahRokokPerHari: $jumlahRokokPerHari, hargaRokokPerBungkus: $hargaRokokPerBungkus, batangPerBungkus: $batangPerBungkus, tanggalMulaiMerokok: $tanggalMulaiMerokok, tanggalMulaiBerhentiMerokok: $tanggalMulaiBerhentiMerokok, modeBerhenti: $modeBerhenti, penurunanPerMinggu: $penurunanPerMinggu, tanggalMulaiTapering: $tanggalMulaiTapering, targetSmokeFreeHari: $targetSmokeFreeHari)';
}


}

/// @nodoc
abstract mixin class _$BiodataModelCopyWith<$Res> implements $BiodataModelCopyWith<$Res> {
  factory _$BiodataModelCopyWith(_BiodataModel value, $Res Function(_BiodataModel) _then) = __$BiodataModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String nama, DateTime? tanggalLahir, int jumlahRokokPerHari, double hargaRokokPerBungkus, double batangPerBungkus, DateTime? tanggalMulaiMerokok, DateTime? tanggalMulaiBerhentiMerokok, ModeBerhenti modeBerhenti, int penurunanPerMinggu, DateTime? tanggalMulaiTapering, int? targetSmokeFreeHari
});




}
/// @nodoc
class __$BiodataModelCopyWithImpl<$Res>
    implements _$BiodataModelCopyWith<$Res> {
  __$BiodataModelCopyWithImpl(this._self, this._then);

  final _BiodataModel _self;
  final $Res Function(_BiodataModel) _then;

/// Create a copy of BiodataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nama = null,Object? tanggalLahir = freezed,Object? jumlahRokokPerHari = null,Object? hargaRokokPerBungkus = null,Object? batangPerBungkus = null,Object? tanggalMulaiMerokok = freezed,Object? tanggalMulaiBerhentiMerokok = freezed,Object? modeBerhenti = null,Object? penurunanPerMinggu = null,Object? tanggalMulaiTapering = freezed,Object? targetSmokeFreeHari = freezed,}) {
  return _then(_BiodataModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nama: null == nama ? _self.nama : nama // ignore: cast_nullable_to_non_nullable
as String,tanggalLahir: freezed == tanggalLahir ? _self.tanggalLahir : tanggalLahir // ignore: cast_nullable_to_non_nullable
as DateTime?,jumlahRokokPerHari: null == jumlahRokokPerHari ? _self.jumlahRokokPerHari : jumlahRokokPerHari // ignore: cast_nullable_to_non_nullable
as int,hargaRokokPerBungkus: null == hargaRokokPerBungkus ? _self.hargaRokokPerBungkus : hargaRokokPerBungkus // ignore: cast_nullable_to_non_nullable
as double,batangPerBungkus: null == batangPerBungkus ? _self.batangPerBungkus : batangPerBungkus // ignore: cast_nullable_to_non_nullable
as double,tanggalMulaiMerokok: freezed == tanggalMulaiMerokok ? _self.tanggalMulaiMerokok : tanggalMulaiMerokok // ignore: cast_nullable_to_non_nullable
as DateTime?,tanggalMulaiBerhentiMerokok: freezed == tanggalMulaiBerhentiMerokok ? _self.tanggalMulaiBerhentiMerokok : tanggalMulaiBerhentiMerokok // ignore: cast_nullable_to_non_nullable
as DateTime?,modeBerhenti: null == modeBerhenti ? _self.modeBerhenti : modeBerhenti // ignore: cast_nullable_to_non_nullable
as ModeBerhenti,penurunanPerMinggu: null == penurunanPerMinggu ? _self.penurunanPerMinggu : penurunanPerMinggu // ignore: cast_nullable_to_non_nullable
as int,tanggalMulaiTapering: freezed == tanggalMulaiTapering ? _self.tanggalMulaiTapering : tanggalMulaiTapering // ignore: cast_nullable_to_non_nullable
as DateTime?,targetSmokeFreeHari: freezed == targetSmokeFreeHari ? _self.targetSmokeFreeHari : targetSmokeFreeHari // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
