# DAFTAR SEMUA FILE MODEL

Dikumpulkan pada: 2026-11-06 14:27:11

---

## 📄 File: lib/fitur/impian/model/impian_model.dart

**Jumlah baris:** 89

```dart
// lib/fitur/impian/model/impian_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'impian_model.freezed.dart';

/// Model data impian (target transaksi) untuk suatu kendaraan.
@freezed
abstract class ImpianModel with _$ImpianModel {
  const ImpianModel._();

  /// Membuat instance [ImpianModel] dengan data lengkap.
  const factory ImpianModel({
    required String id,
    required String idKendaraan,
    required String deskripsi,
    required double jumlah,
    required DateTime tanggalDibuat,
    required DateTime diperbarui,
    DateTime? tanggalTarget,
    DateTime? diarsipkan,
  }) = _ImpianModel;

  // ==================== Supabase ====================

  /// Membuat [ImpianModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory ImpianModel.fromSupabase(Map<String, dynamic> map) {
    return ImpianModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
      jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
      tanggalDibuat:
          ParserUtil.parseDateTime(map[NamaKolom.tanggalDibuat]) ??
          DateTime.now(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      tanggalTarget: ParserUtil.parseDateTime(map[NamaKolom.tanggalTarget]),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggalDibuat: tanggalDibuat.toIso8601String(),
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.tanggalTarget: tanggalTarget?.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  // ==================== Sqflite ====================

  /// Membuat [ImpianModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory ImpianModel.fromSqflite(Map<String, dynamic> map) {
    return ImpianModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
      jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
      tanggalDibuat:
          ParserUtil.parseDateTime(map[NamaKolom.tanggalDibuat]) ??
          DateTime.now(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      tanggalTarget: ParserUtil.parseDateTime(map[NamaKolom.tanggalTarget]),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggalDibuat: tanggalDibuat.toIso8601String(),
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.tanggalTarget: tanggalTarget?.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/bahan_bakar/model/bahan_bakar_model.dart

**Jumlah baris:** 116

```dart
// lib/fitur/bahan_bakar/model/bahan_bakar_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'bahan_bakar_model.freezed.dart';

/// Model data pengisian bahan bakar kendaraan.
@freezed
abstract class BahanBakarModel with _$BahanBakarModel {
  const BahanBakarModel._();

  /// Membuat instance [BahanBakarModel] dengan data pengisian bahan bakar.
  const factory BahanBakarModel({
    /// ID unik data bahan bakar.
    required String id,

    /// ID kendaraan yang terkait.
    required String idKendaraan,

    /// Tanggal pengisian bahan bakar.
    required DateTime tanggal,

    /// Nilai kilometer kendaraan saat pengisian.
    required double km,

    /// Jumlah liter bahan bakar yang diisi.
    required double liter,

    /// Harga per liter bahan bakar.
    required double hargaPerLiter,

    /// Total biaya pengisian bahan bakar.
    required double total,

    /// Catatan tambahan, boleh null.
    String? catatan,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,

    /// Tanggal diarsipkan, boleh null.
    DateTime? diarsipkan,
  }) = _BahanBakarModel;

  // ==================== Supabase ====================

  /// Membuat [BahanBakarModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory BahanBakarModel.fromSupabase(Map<String, dynamic> map) {
    return BahanBakarModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      tanggal:
          ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
      km: ParserUtil.parseDouble(map[NamaKolom.km]),
      liter: ParserUtil.parseDouble(map[NamaKolom.liter]),
      hargaPerLiter: ParserUtil.parseDouble(map[NamaKolom.hargaPerLiter]),
      total: ParserUtil.parseDouble(map[NamaKolom.total]),
      catatan: map[NamaKolom.catatan]?.toString(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.liter: liter,
    NamaKolom.hargaPerLiter: hargaPerLiter,
    NamaKolom.total: total,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  // ==================== Sqflite ====================

  /// Membuat [BahanBakarModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory BahanBakarModel.fromSqflite(Map<String, dynamic> map) {
    return BahanBakarModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      tanggal:
          ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
      km: ParserUtil.parseDouble(map[NamaKolom.km]),
      liter: ParserUtil.parseDouble(map[NamaKolom.liter]),
      hargaPerLiter: ParserUtil.parseDouble(map[NamaKolom.hargaPerLiter]),
      total: ParserUtil.parseDouble(map[NamaKolom.total]),
      catatan: map[NamaKolom.catatan]?.toString(),
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.liter: liter,
    NamaKolom.hargaPerLiter: hargaPerLiter,
    NamaKolom.total: total,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/transaksi/model/kategori_transaksi_model.dart

**Jumlah baris:** 66

```dart
// lib/fitur/transaksi/model/kategori_transaksi_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kategori_transaksi_model.freezed.dart';
part 'kategori_transaksi_model.g.dart';

/// Model data kategori transaksi (berlaku untuk transaksi pemasukan/pengeluaran).
@freezed
abstract class KategoriTransaksiModel with _$KategoriTransaksiModel {
  const KategoriTransaksiModel._();

  /// Membuat instance [KategoriTransaksiModel] dengan data lengkap.
  const factory KategoriTransaksiModel({
    @JsonKey(name: NamaKolom.id, defaultValue: '') required String id,
    @JsonKey(name: NamaKolom.nama, defaultValue: '') required String nama,
    @JsonKey(
      name: NamaKolom.tipeTransaksi,
      fromJson: _tipeFromJson,
      toJson: _tipeToJson,
    )
    required TipeTransaksiEnum tipe,
    @JsonKey(name: NamaKolom.ikon) String? ikon,
    @JsonKey(name: NamaKolom.warna) String? warna,
    @JsonKey(
      name: NamaKolom.diperbarui,
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson,
    )
    required DateTime diperbarui,
    @JsonKey(
      name: NamaKolom.diarsipkan,
      fromJson: _dateTimeOrNullFromJson,
      toJson: _dateTimeToJson,
    )
    DateTime? diarsipkan,
  }) = _KategoriTransaksiModel;

  /// Membuat [KategoriTransaksiModel] dari JSON/Map (Supabase & Sqflite).
  factory KategoriTransaksiModel.fromJson(Map<String, dynamic> json) =>
      _$KategoriTransaksiModelFromJson(json);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke DB.
  @override
  Map<String, dynamic> toJson() =>
      _$KategoriTransaksiModelToJson(this as _KategoriTransaksiModel);
}

// ==================== Helper konversi ====================

TipeTransaksiEnum _tipeFromJson(Object? value) =>
    ParserUtil.safeParseEnum(TipeTransaksiEnum.values, value?.toString()) ??
    TipeTransaksiEnum.pemasukan;

String _tipeToJson(TipeTransaksiEnum value) => value.name;

DateTime _dateTimeFromJson(Object? value) =>
    ParserUtil.parseDateTime(value) ?? DateTime.now();

DateTime? _dateTimeOrNullFromJson(Object? value) =>
    ParserUtil.parseDateTime(value);

String? _dateTimeToJson(DateTime? value) => value?.toIso8601String();
```

---

## 📄 File: lib/fitur/transaksi/model/transaksi_model.dart

**Jumlah baris:** 111

```dart
// lib/fitur/transaksi/model/transaksi_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/transaksi/enum/tipe_transaksi_enum.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'transaksi_model.freezed.dart';

/// Model data transaksi (pemasukan/pengeluaran).
@freezed
abstract class TransaksiModel with _$TransaksiModel {
  const TransaksiModel._();

  /// Membuat instance [TransaksiModel] dengan data lengkap.
  const factory TransaksiModel({
    required String id,
    required String idKendaraan,
    required String deskripsi,
    required double jumlah,
    required DateTime tanggal,
    required TipeTransaksiEnum tipeTransaksi,
    String? idKategoriTransaksi,
    String? pathStruk,
    required DateTime diperbarui,
    DateTime? diarsipkan,
    String? riwayatJadwalServiceId,
  }) = _TransaksiModel;

  // ==================== Supabase ====================

  /// Membuat [TransaksiModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory TransaksiModel.fromSupabase(
    Map<String, dynamic> map,
  ) => TransaksiModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
    deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
    jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
    tanggal: ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
    tipeTransaksi:
        ParserUtil.safeParseEnum(
          TipeTransaksiEnum.values,
          map[NamaKolom.tipeTransaksi]?.toString(),
        ) ??
        TipeTransaksiEnum.pemasukan,
    idKategoriTransaksi: map[NamaKolom.idKategoriTransaksi]?.toString(),
    pathStruk: map[NamaKolom.pathStruk]?.toString(),
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    riwayatJadwalServiceId: map[NamaKolom.riwayatJadwalServiceId]?.toString(),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.tipeTransaksi: tipeTransaksi.name,
    NamaKolom.idKategoriTransaksi: idKategoriTransaksi,
    NamaKolom.pathStruk: pathStruk,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
    NamaKolom.riwayatJadwalServiceId: riwayatJadwalServiceId,
  };

  // ==================== Sqflite ====================

  /// Membuat [TransaksiModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory TransaksiModel.fromSqflite(
    Map<String, dynamic> map,
  ) => TransaksiModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
    deskripsi: map[NamaKolom.deskripsi]?.toString() ?? '',
    jumlah: ParserUtil.parseDouble(map[NamaKolom.jumlah]),
    tanggal: ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
    tipeTransaksi:
        ParserUtil.safeParseEnum(
          TipeTransaksiEnum.values,
          map[NamaKolom.tipeTransaksi]?.toString(),
        ) ??
        TipeTransaksiEnum.pemasukan,
    idKategoriTransaksi: map[NamaKolom.idKategoriTransaksi]?.toString(),
    pathStruk: map[NamaKolom.pathStruk]?.toString(),
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    riwayatJadwalServiceId: map[NamaKolom.riwayatJadwalServiceId]?.toString(),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.deskripsi: deskripsi,
    NamaKolom.jumlah: jumlah,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.tipeTransaksi: tipeTransaksi.name,
    NamaKolom.idKategoriTransaksi: idKategoriTransaksi,
    NamaKolom.pathStruk: pathStruk,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
    NamaKolom.riwayatJadwalServiceId: riwayatJadwalServiceId,
  };
}
```

---

## 📄 File: lib/fitur/pengingat/model/pengingat_model.dart

**Jumlah baris:** 88

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/pengingat/enum/kategori_pengingat.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'pengingat_model.freezed.dart';

/// Halaman tujuan pengingat.
enum PageTujuan {
  /// Halaman kendaraan.
  kendaraanPage,
}

/// Model pengingat pentru pajak dan jadwal service.
@freezed
abstract class PengingatModel with _$PengingatModel {
  const PengingatModel._();

  /// Buat instance [PengingatModel].
  const factory PengingatModel({
    /// ID unik pengingat.
    required String id,

    /// ID kendaraan terkait.
    required String idKendaraan,

    /// Pesan pengingat.
    required String pesan,

    /// Tanggal dan waktu menampilkan pengingat.
    required DateTime tanggalTampil,

    /// Kategori pengingat.
    required KategoriPengingat kategoriPengingat,

    /// Halaman tujuan.
    required PageTujuan pageTujuan,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,
  }) = _PengingatModel;

  /// Membuat [PengingatModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory PengingatModel.fromSqflite(Map<String, dynamic> map) {
    try {
      return PengingatModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        pesan: map[NamaKolom.pesan]?.toString() ?? '',
        tanggalTampil:
            ParserUtil.parseDateTime(map[NamaKolom.tanggalTampil]) ??
            DateTime.now(),
        // Menggunakan safeParseEnum agar tidak melempar ArgumentError saat
        // nilai enum tidak valid, dengan fallback ke nilai default.
        kategoriPengingat:
            ParserUtil.safeParseEnum(
              KategoriPengingat.values,
              map[NamaKolom.kategoriPengingat]?.toString(),
            ) ??
            KategoriPengingat.pajak,
        pageTujuan:
            ParserUtil.safeParseEnum(
              PageTujuan.values,
              map[NamaKolom.pageTujuan]?.toString(),
            ) ??
            PageTujuan.kendaraanPage,
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
      );
    } catch (e, s) {
      L.e('Gagal parse PengingatModel dari Sqflite: $e $s');
      rethrow;
    }
  }

  /// Mengubah [PengingatModel] menjadi Map untuk Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.pesan: pesan,
    NamaKolom.tanggalTampil: tanggalTampil.toIso8601String(),
    NamaKolom.kategoriPengingat: kategoriPengingat.name,
    NamaKolom.pageTujuan: pageTujuan.name,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/kendaraan/model/kendaraan_model.dart

**Jumlah baris:** 89

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'kendaraan_model.freezed.dart';

/// Model data kendaraan pengguna.
@freezed
abstract class KendaraanModel with _$KendaraanModel {
  const KendaraanModel._();

  /// Membuat instance [KendaraanModel] dengan data lengkap.
  const factory KendaraanModel({
    required String id,
    required String nama,
    required String merk,
    String? platNomor,
    String? pathGambar,
    String? tahunKeluar,
    String? model,
    String? jenis,
    required DateTime diperbarui,
    DateTime? diarsipkan,
  }) = _KendaraanModel;

  /// Membuat [KendaraanModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KendaraanModel.fromSupabase(Map<String, dynamic> map) =>
      KendaraanModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        merk: map[NamaKolom.merk]?.toString() ?? '',
        platNomor: map[NamaKolom.platNomor]?.toString(),
        pathGambar: map[NamaKolom.pathGambar]?.toString(),
        tahunKeluar: map[NamaKolom.tahunKeluar]?.toString(),
        model: map[NamaKolom.model]?.toString(),
        jenis: map[NamaKolom.jenis]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.merk: merk,
    NamaKolom.platNomor: platNomor,
    NamaKolom.pathGambar: pathGambar,
    NamaKolom.tahunKeluar: tahunKeluar,
    NamaKolom.model: model,
    NamaKolom.jenis: jenis,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Membuat [KendaraanModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KendaraanModel.fromSqflite(Map<String, dynamic> map) =>
      KendaraanModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        merk: map[NamaKolom.merk]?.toString() ?? '',
        platNomor: map[NamaKolom.platNomor]?.toString(),
        pathGambar: map[NamaKolom.pathGambar]?.toString(),
        tahunKeluar: map[NamaKolom.tahunKeluar]?.toString(),
        model: map[NamaKolom.model]?.toString(),
        jenis: map[NamaKolom.jenis]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.merk: merk,
    NamaKolom.platNomor: platNomor,
    NamaKolom.pathGambar: pathGambar,
    NamaKolom.tahunKeluar: tahunKeluar,
    NamaKolom.model: model,
    NamaKolom.jenis: jenis,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/kendaraan/model/pajak_model.dart

**Jumlah baris:** 67

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'pajak_model.freezed.dart';

/// Model data pajak kendaraan.
@freezed
abstract class PajakModel with _$PajakModel {
  const PajakModel._();

  /// Membuat instance [PajakModel] dengan data lengkap.
  const factory PajakModel({
    required String id,
    required String nama,
    required DateTime tanggal,
    required double biaya,
    required String idKendaraan,
  }) = _PajakModel;

  // ==================== Supabase ====================

  /// Membuat [PajakModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory PajakModel.fromSupabase(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => _keMap();

  // ==================== Sqflite ====================

  /// Membuat [PajakModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory PajakModel.fromSqflite(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => _keMap();

  // ==================== Konversi internal ====================

  /// Satu metode konversi dari Map (Supabase/Sqflite) ke [PajakModel].
  // Bungkus parsing dalam try/catch agar kegagalan parsing tercatat (L.e) dan tidak crash diam-diam.
  static PajakModel _dariMap(Map<String, dynamic> map) {
    try {
      return PajakModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        tanggal:
            ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
        biaya: ParserUtil.parseDouble(map[NamaKolom.biaya]),
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      );
    } on Exception catch (e, s) {
      L.e('Gagal parse PajakModel: $e $s');
      rethrow;
    }
  }

  /// Satu metode konversi dari instance ke Map (Supabase/Sqflite).
  Map<String, dynamic> _keMap() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.biaya: biaya,
    NamaKolom.idKendaraan: idKendaraan,
  };
}
```

---

## 📄 File: lib/fitur/jadwal_service/model/jadwal_service_komponen_model.dart

**Jumlah baris:** 47

```dart
// lib/fitur/jadwal_service/model/jadwal_service_komponen_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'jadwal_service_komponen_model.freezed.dart';

/// Model data komponen yang terikat dengan jadwal service.
@freezed
abstract class JadwalServiceKomponenModel with _$JadwalServiceKomponenModel {
  const JadwalServiceKomponenModel._();

  /// Membuat instance [JadwalServiceKomponenModel] dengan data lengkap.
  const factory JadwalServiceKomponenModel({
    required String id,
    required String jadwalServiceId,
    required String komponenId,
    required String idKendaraan,
    required DateTime diperbarui,
    DateTime? diarsipkan,
  }) = _JadwalServiceKomponenModel;

  /// Membuat [JadwalServiceKomponenModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory JadwalServiceKomponenModel.fromSqflite(Map<String, dynamic> map) =>
      JadwalServiceKomponenModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        jadwalServiceId: map[NamaKolom.jadwalServiceId]?.toString() ?? '',
        komponenId: map[NamaKolom.komponenId]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.jadwalServiceId: jadwalServiceId,
    NamaKolom.komponenId: komponenId,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart

**Jumlah baris:** 122

```dart
// lib/fitur/jadwal_service/model/riwayat_jadwal_service_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'riwayat_jadwal_service_model.freezed.dart';

/// Model data riwayat service kendaraan (catatan service yang sudah dilakukan).
@freezed
abstract class RiwayatJadwalServiceModel with _$RiwayatJadwalServiceModel {
  const RiwayatJadwalServiceModel._();

  /// Membuat instance [RiwayatJadwalServiceModel] dengan data lengkap.
  const factory RiwayatJadwalServiceModel({
    /// ID unik data riwayat service.
    required String id,

    /// ID jadwal service yang menjadi acuan riwayat ini.
    required String jadwalServiceId,

    /// ID kendaraan yang serviced.
    required String idKendaraan,

    /// Nama service pada saat riwayat dicatat (snapshot nama jadwal service).
    required String nama,

    /// Tanggal service dilakukan.
    required DateTime tanggalService,

    /// Kilometer kendaraan pada saat service dilakukan.
    required double km,

    /// Total biaya service yang dicatat.
    required double biaya,

    /// Catatan tambahan service, boleh null.
    String? catatan,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,

    /// Tanggal diarsipkan, boleh null.
    DateTime? diarsipkan,
  }) = _RiwayatJadwalServiceModel;

  // ==================== Supabase ====================

  /// Membuat [RiwayatJadwalServiceModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory RiwayatJadwalServiceModel.fromSupabase(Map<String, dynamic> map) =>
      RiwayatJadwalServiceModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        jadwalServiceId: map[NamaKolom.jadwalServiceId]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        tanggalService:
            ParserUtil.parseDateTime(map[NamaKolom.tanggalService]) ??
            DateTime.now(),
        km: ParserUtil.parseDouble(map[NamaKolom.km]),
        biaya: ParserUtil.parseDouble(map[NamaKolom.biaya]),
        catatan: map[NamaKolom.catatan]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.jadwalServiceId: jadwalServiceId,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.nama: nama,
    NamaKolom.tanggalService: tanggalService.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.biaya: biaya,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  // ==================== Sqflite ====================

  /// Membuat [RiwayatJadwalServiceModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory RiwayatJadwalServiceModel.fromSqflite(Map<String, dynamic> map) =>
      RiwayatJadwalServiceModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        jadwalServiceId: map[NamaKolom.jadwalServiceId]?.toString() ?? '',
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        nama: map[NamaKolom.nama]?.toString() ?? '',
        tanggalService:
            ParserUtil.parseDateTime(map[NamaKolom.tanggalService]) ??
            DateTime.now(),
        km: ParserUtil.parseDouble(map[NamaKolom.km]),
        biaya: ParserUtil.parseDouble(map[NamaKolom.biaya]),
        catatan: map[NamaKolom.catatan]?.toString(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.jadwalServiceId: jadwalServiceId,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.nama: nama,
    NamaKolom.tanggalService: tanggalService.toIso8601String(),
    NamaKolom.km: km,
    NamaKolom.biaya: biaya,
    NamaKolom.catatan: catatan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Jumlah hari sejak service dilakukan (tidak negatif meski tanggal mendatang).
  int get hariSejakService =>
      DateTime.now().difference(tanggalService).inDays.clamp(0, 99999);
}
```

---

## 📄 File: lib/fitur/jadwal_service/model/jadwal_service_model.dart

**Jumlah baris:** 88

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'jadwal_service_model.freezed.dart';

/// Model data jadwal service kendaraan.
@freezed
abstract class JadwalServiceModel with _$JadwalServiceModel {
  const JadwalServiceModel._();

  /// Membuat instance [JadwalServiceModel] dengan data lengkap.
  const factory JadwalServiceModel({
    required String id,
    required String nama,
    required double bulan,
    required double km,
    required double kmTerakhirService,
    required DateTime tanggalTerakhirService,
    required String idKendaraan,
    required DateTime diperbarui,
    DateTime? diarsipkan,
  }) = _JadwalServiceModel;

  /// Membuat [JadwalServiceModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory JadwalServiceModel.fromSupabase(
    Map<String, dynamic> map,
  ) => JadwalServiceModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    nama: map[NamaKolom.nama]?.toString() ?? '',
    bulan: ParserUtil.parseDouble(map[NamaKolom.bulan]),
    km: ParserUtil.parseDouble(map[NamaKolom.km]),
    kmTerakhirService: ParserUtil.parseDouble(map[NamaKolom.kmTerakhirService]),
    tanggalTerakhirService:
        ParserUtil.parseDateTime(map[NamaKolom.tanggalTerakhirService]) ??
        DateTime.now(),
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '', // 🆕
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.bulan: bulan,
    NamaKolom.km: km,
    NamaKolom.kmTerakhirService: kmTerakhirService,
    NamaKolom.tanggalTerakhirService: tanggalTerakhirService.toIso8601String(),
    NamaKolom.idKendaraan: idKendaraan, // 🆕
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Membuat [JadwalServiceModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory JadwalServiceModel.fromSqflite(
    Map<String, dynamic> map,
  ) => JadwalServiceModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    nama: map[NamaKolom.nama]?.toString() ?? '',
    bulan: ParserUtil.parseDouble(map[NamaKolom.bulan]),
    km: ParserUtil.parseDouble(map[NamaKolom.km]),
    kmTerakhirService: ParserUtil.parseDouble(map[NamaKolom.kmTerakhirService]),
    tanggalTerakhirService:
        ParserUtil.parseDateTime(map[NamaKolom.tanggalTerakhirService]) ??
        DateTime.now(),
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '', // 🆕
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.bulan: bulan,
    NamaKolom.km: km,
    NamaKolom.kmTerakhirService: kmTerakhirService,
    NamaKolom.tanggalTerakhirService: tanggalTerakhirService.toIso8601String(),
    NamaKolom.idKendaraan: idKendaraan, // 🆕
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/km/model/km_model.dart

**Jumlah baris:** 85

```dart
// lib/fitur/km/model/km_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'km_model.freezed.dart';

/// Model data kilometer (pengukuran jarak tempuh) kendaraan.
@freezed
abstract class KmModel with _$KmModel {
  const KmModel._();

  /// Buat instance KmModel dengan data kilometer.
  const factory KmModel({
    /// ID unik data kilometer.
    required String id,

    /// Nilai kilometer kendaraan.
    required double km,

    /// ID kendaraan yang terkait.
    required String idKendaraan,

    /// Tanggal pencatatan kilometer.
    required DateTime tanggal,

    /// Waktu data terakhir diperbarui.
    required DateTime diperbarui,

    /// Tanggal diarsipkan, boleh null.
    DateTime? diarsipkan,
  }) = _KmModel;

  /// ============================================================ KONVERSI DARI / KE SUPABASE ============================================================

  /// Membuat [KmModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KmModel.fromSupabase(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => _keMap();

  /// ============================================================ KONVERSI DARI / KE SQLITE ============================================================

  /// Membuat [KmModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KmModel.fromSqflite(Map<String, dynamic> map) => _dariMap(map);

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => _keMap();

  // ==================== Konversi internal ====================

  /// Satu metode konversi dari Map (Supabase/Sqflite) ke [KmModel].
  // Bungkus parsing dalam try/catch; berikan default 0.0 jika km null/tidak valid (L.w dicatat oleh ParserUtil).
  static KmModel _dariMap(Map<String, dynamic> map) {
    try {
      return KmModel(
        id: map[NamaKolom.id]?.toString() ?? '',
        km: ParserUtil.parseDouble(map[NamaKolom.km]),
        idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
        tanggal:
            ParserUtil.parseDateTime(map[NamaKolom.tanggal]) ?? DateTime.now(),
        diperbarui:
            ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ??
            DateTime.now(),
        diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
      );
    } on Exception catch (e, s) {
      L.e('Gagal parse KmModel: $e $s');
      rethrow;
    }
  }

  /// Satu metode konversi dari instance ke Map (Supabase/Sqflite).
  Map<String, dynamic> _keMap() => {
    NamaKolom.id: id,
    NamaKolom.km: km,
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.tanggal: tanggal.toIso8601String(),
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };
}
```

---

## 📄 File: lib/fitur/kunci_aplikasi/model/kunci_aplikasi_model.dart

**Jumlah baris:** 19

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/kunci_aplikasi/enum/metode_kunci_enum.dart';

part 'kunci_aplikasi_model.freezed.dart';

/// Model preferensi kunci aplikasi.
@freezed
abstract class KunciAplikasiModel with _$KunciAplikasiModel {
  const KunciAplikasiModel._();

  /// Membuat instance [KunciAplikasiModel].
  const factory KunciAplikasiModel({
    @Default(false) bool aktif,
    @Default(MetodeKunci.pin) MetodeKunci metode,
    @Default(1) int durasiAutoLockMenit,
    String? pinHash,
    String? salt,
  }) = _KunciAplikasiModel;
}
```

---

## 📄 File: lib/fitur/komponen/model/komponen_model.dart

**Jumlah baris:** 115

```dart
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myapp/fitur/komponen/model/link_toko_model.dart';
import 'package:myapp/shared/konstanta/nama_kolom.dart';
import 'package:share_global_saya/core_shared.dart';

part 'komponen_model.freezed.dart';

/// Model data komponen kendaraan (misal: oli, filter, rem).
@freezed
abstract class KomponenModel with _$KomponenModel {
  const KomponenModel._();

  /// Membuat instance [KomponenModel] dengan data lengkap.
  const factory KomponenModel({
    /// ID unik komponen.
    required String id,

    /// Nama komponen.
    required String nama,

    /// Harga komponen.
    required double harga,

    /// Daftar tautan toko.
    @Default([]) List<LinkTokoModel> linkToko,

    /// ID kendaraan yang memiliki komponen ini.
    required String idKendaraan,

    /// Waktu terakhir diperbarui.
    required DateTime diperbarui,

    /// Waktu diarsipkan, null jika belum diarsipkan.
    DateTime? diarsipkan,
  }) = _KomponenModel;

  /// Membuat [KomponenModel] dari data Supabase [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KomponenModel.fromSupabase(Map<String, dynamic> map) {
    return KomponenModel(
      id: map[NamaKolom.id]?.toString() ?? '',
      nama: map[NamaKolom.nama]?.toString() ?? '',
      harga: ParserUtil.parseDouble(map[NamaKolom.harga]),
      linkToko: _parseLinkTokoSupabase(map[NamaKolom.linkToko]),
      idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
      diperbarui:
          ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
      diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
    );
  }

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Supabase.
  Map<String, dynamic> toSupabase() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.harga: harga,
    NamaKolom.linkToko: linkToko.map((link) => link.toJson()).toList(),
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// Membuat [KomponenModel] dari data Sqflite [map].
  // Menggunakan ?.toString() agar parsing string aman dari nilai null/non-String tanpa operator as (AGENTS.md poin 1).
  factory KomponenModel.fromSqflite(Map<String, dynamic> map) => KomponenModel(
    id: map[NamaKolom.id]?.toString() ?? '',
    nama: map[NamaKolom.nama]?.toString() ?? '',
    harga: ParserUtil.parseDouble(map[NamaKolom.harga]),
    linkToko: LinkTokoModel.parseListFrom(map[NamaKolom.linkToko]?.toString()),
    idKendaraan: map[NamaKolom.idKendaraan]?.toString() ?? '',
    diperbarui:
        ParserUtil.parseDateTime(map[NamaKolom.diperbarui]) ?? DateTime.now(),
    diarsipkan: ParserUtil.parseDateTime(map[NamaKolom.diarsipkan]),
  );

  /// Mengonversi instance ini menjadi Map untuk disimpan ke Sqflite.
  Map<String, dynamic> toSqflite() => {
    NamaKolom.id: id,
    NamaKolom.nama: nama,
    NamaKolom.harga: harga,
    NamaKolom.linkToko: jsonEncode(
      linkToko.map((link) => link.toJson()).toList(),
    ),
    NamaKolom.idKendaraan: idKendaraan,
    NamaKolom.diperbarui: diperbarui.toIso8601String(),
    NamaKolom.diarsipkan: diarsipkan?.toIso8601String(),
  };

  /// 🆕 Metode utilitas statis untuk mengurai linkToko dari data Supabase.
  // ubah parameter dynamic → Object? agar pengecekan tipe aman (optimasi_bug_runtime poin 2)
  static List<LinkTokoModel> _parseLinkTokoSupabase(Object? value) {
    if (value == null) {
      return [];
    }

    if (value is List) {
      try {
        // Tambahkan guard untuk tipe Map<String, dynamic> yang benar sebelum pemetaan
        return value
            .whereType<Map<String, dynamic>>()
            .map(LinkTokoModel.fromJson)
            .toList();
      } catch (e) {
        L.w('Gagal mengurai linkToko dari Supabase: $e');
        return [];
      }
    } else if (value is String && value.isNotEmpty) {
      return LinkTokoModel.parseListFrom(value);
    }

    return [];
  }
}
```

---

## 📄 File: lib/fitur/komponen/model/link_toko_model.dart

**Jumlah baris:** 44

```dart
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_global_saya/core_shared.dart';

part 'link_toko_model.freezed.dart';
part 'link_toko_model.g.dart';

/// Tautan toko untuk membeli komponen kendaraan.
@freezed
abstract class LinkTokoModel with _$LinkTokoModel {
  const LinkTokoModel._();

  /// Membuat [LinkTokoModel].
  const factory LinkTokoModel({
    /// Nama toko.
    required String namaToko,

    /// URL toko.
    required String url,
  }) = _LinkTokoModel;

  /// Membuat [LinkTokoModel] dari JSON.
  factory LinkTokoModel.fromJson(Map<String, dynamic> json) =>
      _$LinkTokoModelFromJson(json);

  /// Mengurai JSON menjadi [LinkTokoModel]; list kosong jika gagal.
  static List<LinkTokoModel> parseListFrom(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! List) return [];
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(LinkTokoModel.fromJson)
          .toList();
    } catch (e, s) {
      L.e('Gagal mengurai linkToko dari JSON: $e $s');
      return [];
    }
  }
}
```

---


## 📊 STATISTIK

- **Total file model:** 14
- **Total baris kode:** 1146
- **File output:** docs/model.md
