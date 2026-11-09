// commit: fd6b45afbb4064038b4bc1131aaf6125dae538ec
import 'dart:async';
import 'package:flutter/material.dart';

void navigasiSalah(BuildContext context) {
  // SALAH: unawaited tanpa catchError
  unawaited(Navigator.pushNamed(context, '/lain'));
  
  // SALAH: EasyLoading tanpa catchError
  unawaited(showLoading());
  unawaited(hideLoading());
}

Future<void> showLoading() async {}
Future<void> hideLoading() async {}