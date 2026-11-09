// commit: fd6b45afbb4064038b4bc1131aaf6125dae538ec
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:berhenti_merokok/shared/utils/l.dart';

void navigasiBenar(BuildContext context) {
  // BENAR: unawaited DENGAN catchError + L.e
  unawaited(
    Navigator.pushNamed(context, '/lain').catchError((Object e, StackTrace s) {
      L.e('Gagal navigasi: $e $s');
      return null;
    }),
  );
  
  // BENAR: EasyLoading.show DENGAN catchError
  unawaited(
    showLoading().catchError((Object e, StackTrace s) {
      L.e('Gagal menampilkan loading: $e $s');
    }),
  );
  
  // BENAR: EasyLoading.dismiss DENGAN catchError
  unawaited(
    hideLoading().catchError((Object e, StackTrace s) {
      L.e('Gagal menutup loading: $e $s');
    }),
  );
}

Future<void> showLoading() async {}
Future<void> hideLoading() async {}