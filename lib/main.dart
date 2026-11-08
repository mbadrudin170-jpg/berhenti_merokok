import 'package:berhenti_merokok/app.dart';
import 'package:berhenti_merokok/shared/db/sqflite/sqflite.dart';
import 'package:berhenti_merokok/shared/notifikasi/notifikasi_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

export 'package:berhenti_merokok/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    databaseFactory = databaseFactoryFfiWeb;
  }
  try {
    await AppDatabase.database;
  } on Exception catch (e, s) {
    p('Gagal inisialisasi database: $e $s');
    rethrow;
  }
  try {
    await NotifikasiService.inisialisasi();
  } on Exception catch (e, s) {
    p('Gagal inisialisasi notifikasi: $e $s');
  }
  runApp(const ProviderScope(child: App()));
}
