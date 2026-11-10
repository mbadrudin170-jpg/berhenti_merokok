import 'dart:async';

import 'package:berhenti_merokok/home.dart';
import 'package:berhenti_merokok/shared/helper/shared_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:share_global_saya/core_shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Exception khusus ketika izin notifikasi tidak diberikan oleh sistem.
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override
  String toString() => 'Izin notifikasi tidak diberikan';
}

/// Layanan notifikasi lokal untuk pengingat harian aplikasi.
class NotifikasiService {
  NotifikasiService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// ID notifikasi pengingat harian.
  static const int _idPengingatHarian = 1001;

  /// ID notifikasi uji coba (terpisah dari pengingat utama).
  static const int _idUjiCoba = 1002;

  /// ID notifikasi check-in pagi (terpisah dari pengingat harian).
  static const int _idCheckinPagi = 1003;

  /// ID notifikasi pengingat pola craving (terpisah dari pengingat harian).
  static const int _idPolaCraving = 1004;

  /// GlobalKey navigator untuk navigasi saat notifikasi ditekan.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Inisialisasi plugin notifikasi dan zona waktu.
  static Future<void> inisialisasi() async {
    L.i('NotifikasiService inisialisasi');
    // Bungkus inisialisasi database zona waktu dalam try/catch agar
    // kegagalan (termasuk Error/ArgumentError) tercatat dan tidak
    // menjadi unhandled error.
    try {
      tz.initializeTimeZones();
    } on Error catch (e, s) {
      L.e('Gagal inisialisasi zona waktu: $e $s');
    } on Exception catch (e, s) {
      L.e('Gagal inisialisasi zona waktu: $e $s');
    }
    // Deteksi zona waktu perangkat (WIB/WITA/WIT/dll.) agar pengingat
    // mengikuti waktu lokal pengguna. Package timezone tidak otomatis
    // mendeteksi zona waktu perangkat, sehingga gunakan flutter_timezone.
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      final identifier = info.identifier;
      L.i('zonaWaktuPerangkat=$identifier');
      // Validasi hasil sebelum penggunaan: identifier tidak boleh kosong.
      if (identifier.isEmpty) {
        throw ArgumentError('Identifier zona waktu kosong');
      }
      try {
        tz.setLocalLocation(tz.getLocation(identifier));
      } on Error catch (e, s) {
        L.w(
          'Identifier zona waktu tidak ditemukan di database tz, fallback Asia/Jakarta: $e $s',
        );
        try {
          tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
        } on Error catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        } on Exception catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        }
      } on Exception catch (e, s) {
        L.w(
          'Identifier zona waktu tidak ditemukan di database tz, fallback Asia/Jakarta: $e $s',
        );
        try {
          tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
        } on Error catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        } on Exception catch (e2, s2) {
          L.w('Gagal set lokasi zona waktu fallback: $e2 $s2');
        }
      }
    } on Error catch (e, s) {
      L.w(
        'Gagal mendeteksi zona waktu perangkat, fallback Asia/Jakarta: $e $s',
      );
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } on Error catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      } on Exception catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      }
    } on Exception catch (e, s) {
      L.w(
        'Gagal mendeteksi zona waktu perangkat, fallback Asia/Jakarta: $e $s',
      );
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
      } on Error catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      } on Exception catch (e2, s2) {
        L.w('Gagal set lokasi zona waktu: $e2 $s2');
      }
    }

    const android = AndroidInitializationSettings('ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );
    const settings = InitializationSettings(
      android: android,
      iOS: darwin,
      macOS: darwin,
    );

    try {
      await _plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: _onTapNotifikasi,
      );
      L.s('Plugin notifikasi berhasil diinisialisasi');
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung inisialisasi notifikasi: $e $s');
    } on Exception catch (e, s) {
      L.e('Gagal inisialisasi plugin notifikasi: $e $s');
      rethrow;
    }
  }

  static void _onTapNotifikasi(NotificationResponse response) {
    L.i('payload=${response.payload}');
    _navigasiDariPayload(response.payload);
  }

  /// Navigasi berdasarkan payload notifikasi (foreground/background).
  static void _navigasiDariPayload(String? payload, {int percobaan = 0}) {
    final navigator = navigatorKey.currentState;
    if (navigator == null) {
      if (percobaan < 3) {
        L.w('navigator null saat navigasi notifikasi, coba lagi');
        Future.delayed(const Duration(milliseconds: 100), () {
          _navigasiDariPayload(payload, percobaan: percobaan + 1);
        });
      } else {
        L.w('navigator null saat navigasi notifikasi, batalkan');
      }
      return;
    }

    String? kategori;
    String? id;
    if (payload != null) {
      for (final part in payload.split('&')) {
        final kv = part.split('=');
        if (kv.length == 2) {
          if (kv[0] == 'kategori') kategori = kv[1];
          if (kv[0] == 'id') id = kv[1];
        }
      }
    }
    L.i('kategori=$kategori, id=$id');

    final context = navigator.context;
    if (kategori == 'pengingat_harian' ||
        kategori == 'checkin_pagi' ||
        kategori == 'pola_craving') {
      unawaited(
        Nav.pushAndRemoveUntil(context, const Home()).catchError((
          Object e,
          StackTrace s,
        ) {
          L.e('Gagal navigasi dari notifikasi: $e $s');
          return null;
        }),
      );
    } else {
      L.w('kategori notifikasi tidak dikenal: $kategori');
    }
  }

  /// Menangani kondisi aplikasi diluncurkan dari keadaan terminated
  /// melalui notifikasi.
  static void cekNotifikasiSaatBuka() {
    // Platform yang tidak mendukung notifikasi terjadwal/launch details.
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      L.w('platform tidak mendukung cek notifikasi saat buka');
      return;
    }
    unawaited(
      Future(() async {
        try {
          final details = await _plugin.getNotificationAppLaunchDetails();
          if (details?.didNotificationLaunchApp ?? false) {
            final payload = details?.notificationResponse?.payload;
            if (payload != null && payload.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _navigasiDariPayload(payload);
              });
            }
          }
        } on UnsupportedError catch (e, s) {
          L.e('Platform tidak mendukung cek notifikasi saat buka: $e $s');
        } on Exception catch (e, s) {
          L.e('Gagal cek notifikasi saat buka: $e $s');
        }
      }).catchError((Object e, StackTrace s) {
        L.e('Gagal cek notifikasi saat buka: $e $s');
      }),
    );
  }

  /// Meminta izin notifikasi sesuai platform.
  /// Mengembalikan true jika izin diberikan.
  static Future<bool> mintaIzin() async {
    if (kIsWeb) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      final granted = await _plugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return granted ?? false;
    }
    return true;
  }

  /// Menjadwalkan pengingat harian pada jam dan menit tertentu.
  static Future<void> jadwalkanPengingatHarian({
    required int jam,
    required int menit,
  }) async {
    L.i('jam=$jam, menit=$menit');
    // Platform yang tidak mendukung notifikasi terjadwal (Web, Linux, Windows).
    // macOS didukung plugin flutter_local_notifications v22.3.3 via zonedSchedule.
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      L.w('platform tidak mendukung penjadwalan terjadwal');
      throw UnsupportedError('Platform tidak mendukung notifikasi terjadwal');
    }
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      jam,
      menit,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'pengingat_harian',
        'Pengingat Harian',
        channelDescription: 'Pengingat harian berhenti merokok',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );

    try {
      await _plugin.zonedSchedule(
        id: _idPengingatHarian,
        scheduledDate: scheduled,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: 'Berhenti Merokok',
        body: 'Jaga semangat! Cek progres smoke-free Anda hari ini.',
        payload: 'kategori=pengingat_harian&id=$_idPengingatHarian',
        matchDateTimeComponents: DateTimeComponents.time,
      );
      // Periksa izin sebelum menyimpan status aktif.
      final izinDiberikan = await _periksaIzinSistem();
      if (!izinDiberikan) {
        L.w('izin notifikasi tidak diberikan, batalkan penjadwalan');
        await _plugin.cancel(id: _idPengingatHarian);
        await setAktif(false);
        throw const IzinNotifikasiTidakDiberikanException();
      }
      // Simpan nilai lama untuk rollback bila penyimpanan gagal.
      final aktifLama = await aktif();
      final jamLama = await NotifikasiService.jam();
      final menitLama = await NotifikasiService.menit();
      // Urutan: setWaktu terlebih dahulu, lalu setAktif, agar status
      // aktif tidak tersimpan tanpa waktu yang sesuai. Bungkus keduanya
      // dengan rollback saat gagal agar preferensi tetap konsisten.
      try {
        await setWaktu(jam, menit);
        await setAktif(true);
      } on Exception catch (e, s) {
        L.e('Gagal menyimpan preferensi pengingat, rollback: $e $s');
        try {
          await setWaktu(jamLama, menitLama);
          await setAktif(aktifLama);
        } on Exception catch (e2, s2) {
          L.e('Gagal rollback preferensi pengingat: $e2 $s2');
        }
        // Batalkan jadwal sistem agar konsisten dengan preferensi.
        try {
          await _plugin.cancel(id: _idPengingatHarian);
        } on Exception catch (e2, s2) {
          L.e('Gagal membatalkan jadwal saat rollback: $e2 $s2');
        }
        rethrow;
      }
      L.s('Pengingat harian dijadwalkan jam=$jam:$menit');
    } on Exception catch (e, s) {
      L.e('Gagal menjadwalkan pengingat harian: $e $s');
      rethrow;
    }
  }

  /// Membatalkan pengingat harian.
  static Future<void> batalkanPengingatHarian() async {
    try {
      await _plugin.cancel(id: _idPengingatHarian);
      await setAktif(false);
      L.s('Pengingat harian dibatalkan');
    } on Exception catch (e, s) {
      L.e('Gagal membatalkan pengingat harian: $e $s');
      rethrow;
    }
  }

  /// Menjadwalkan check-in pagi pada jam dan menit tertentu.
  static Future<void> jadwalkanCheckinPagi({
    required int jam,
    required int menit,
  }) async {
    L.i('checkinPagi jam=$jam, menit=$menit');
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      L.w('platform tidak mendukung penjadwalan terjadwal');
      throw UnsupportedError('Platform tidak mendukung notifikasi terjadwal');
    }
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      jam,
      menit,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'checkin_pagi',
        'Check-in Pagi',
        channelDescription: 'Check-in pagi smoke-free',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );

    try {
      await _plugin.zonedSchedule(
        id: _idCheckinPagi,
        scheduledDate: scheduled,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: 'Check-in Pagi',
        body: 'Selamat pagi! Jaga komitmen smoke-free Anda hari ini.',
        payload: 'kategori=checkin_pagi&id=$_idCheckinPagi',
        matchDateTimeComponents: DateTimeComponents.time,
      );
      final izinDiberikan = await _periksaIzinSistem();
      if (!izinDiberikan) {
        L.w('izin notifikasi tidak diberikan, batalkan check-in pagi');
        await _plugin.cancel(id: _idCheckinPagi);
        await setAktifCheckinPagi(false);
        throw const IzinNotifikasiTidakDiberikanException();
      }
      final aktifLama = await aktifCheckinPagi();
      final jamLama = await jamCheckinPagi();
      final menitLama = await menitCheckinPagi();
      try {
        await setWaktuCheckinPagi(jam, menit);
        await setAktifCheckinPagi(true);
      } on Exception catch (e, s) {
        L.e('Gagal menyimpan preferensi check-in pagi, rollback: $e $s');
        try {
          await setWaktuCheckinPagi(jamLama, menitLama);
          await setAktifCheckinPagi(aktifLama);
        } on Exception catch (e2, s2) {
          L.e('Gagal rollback preferensi check-in pagi: $e2 $s2');
        }
        try {
          await _plugin.cancel(id: _idCheckinPagi);
        } on Exception catch (e2, s2) {
          L.e('Gagal membatalkan jadwal check-in pagi saat rollback: $e2 $s2');
        }
        rethrow;
      }
      L.s('Check-in pagi dijadwalkan jam=$jam:$menit');
    } on Exception catch (e, s) {
      L.e('Gagal menjadwalkan check-in pagi: $e $s');
      rethrow;
    }
  }

  /// Membatalkan check-in pagi.
  static Future<void> batalkanCheckinPagi() async {
    try {
      await _plugin.cancel(id: _idCheckinPagi);
      await setAktifCheckinPagi(false);
      L.s('Check-in pagi dibatalkan');
    } on Exception catch (e, s) {
      L.e('Gagal membatalkan check-in pagi: $e $s');
      rethrow;
    }
  }

  /// Menjadwalkan pengingat pola craving pada jam tertentu.
  static Future<void> jadwalkanPolaCraving(int jam) async {
    L.i('polaCraving jam=$jam');
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      L.w('platform tidak mendukung penjadwalan terjadwal');
      throw UnsupportedError('Platform tidak mendukung notifikasi terjadwal');
    }
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      jam,
      0,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'pola_craving',
        'Pengingat Pola Craving',
        channelDescription: 'Pengingat berbasis pola jam craving',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );

    try {
      await _plugin.zonedSchedule(
        id: _idPolaCraving,
        scheduledDate: scheduled,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        title: 'Pengingat Pola Craving',
        body: 'Ini biasanya jam Anda mengalami craving. Tetap semangat!',
        payload: 'kategori=pola_craving&id=$_idPolaCraving',
        matchDateTimeComponents: DateTimeComponents.time,
      );
      final izinDiberikan = await _periksaIzinSistem();
      if (!izinDiberikan) {
        L.w('izin notifikasi tidak diberikan, batalkan pola craving');
        await _plugin.cancel(id: _idPolaCraving);
        await setAktifPolaCraving(false);
        throw const IzinNotifikasiTidakDiberikanException();
      }
      final aktifLama = await aktifPolaCraving();
      try {
        await setAktifPolaCraving(true);
      } on Exception catch (e, s) {
        L.e('Gagal menyimpan preferensi pola craving, rollback: $e $s');
        try {
          await setAktifPolaCraving(aktifLama);
        } on Exception catch (e2, s2) {
          L.e('Gagal rollback preferensi pola craving: $e2 $s2');
        }
        try {
          await _plugin.cancel(id: _idPolaCraving);
        } on Exception catch (e2, s2) {
          L.e('Gagal membatalkan jadwal pola craving saat rollback: $e2 $s2');
        }
        rethrow;
      }
      L.s('Pengingat pola craving dijadwalkan jam=$jam:00');
    } on Exception catch (e, s) {
      L.e('Gagal menjadwalkan pola craving: $e $s');
      rethrow;
    }
  }

  /// Membatalkan pengingat pola craving.
  static Future<void> batalkanPolaCraving() async {
    try {
      await _plugin.cancel(id: _idPolaCraving);
      await setAktifPolaCraving(false);
      L.s('Pengingat pola craving dibatalkan');
    } on Exception catch (e, s) {
      L.e('Gagal membatalkan pola craving: $e $s');
      rethrow;
    }
  }

  /// Menampilkan notifikasi langsung (untuk uji coba).
  static Future<void> tampilkanSekarang() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'pengingat_harian',
        'Pengingat Harian',
        channelDescription: 'Pengingat harian berhenti merokok',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: 'ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
    try {
      await _plugin.show(
        id: _idUjiCoba,
        title: 'Berhenti Merokok',
        body: 'Jaga semangat! Cek progres smoke-free Anda hari ini.',
        notificationDetails: details,
        payload: 'kategori=pengingat_harian&id=$_idUjiCoba',
      );
      L.s('Notifikasi langsung ditampilkan');
    } on Exception catch (e, s) {
      L.e('Gagal menampilkan notifikasi: $e $s');
      rethrow;
    }
  }

  // --- Preferensi SharedPreferences ---

  static Future<bool> aktif() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedKeys.notifikasiHarian) ?? false;
  }

  static Future<void> setAktif(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedKeys.notifikasiHarian, value);
  }

  static Future<int> jam() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedKeys.notifikasiJam) ?? 8;
  }

  static Future<int> menit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedKeys.notifikasiMenit) ?? 0;
  }

  static Future<void> setWaktu(int jam, int menit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SharedKeys.notifikasiJam, jam);
    await prefs.setInt(SharedKeys.notifikasiMenit, menit);
  }

  // --- Preferensi Check-in Pagi ---

  static Future<bool> aktifCheckinPagi() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedKeys.notifikasiCheckinPagi) ?? false;
  }

  static Future<void> setAktifCheckinPagi(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedKeys.notifikasiCheckinPagi, value);
  }

  static Future<int> jamCheckinPagi() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedKeys.notifikasiCheckinPagiJam) ?? 7;
  }

  static Future<int> menitCheckinPagi() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(SharedKeys.notifikasiCheckinPagiMenit) ?? 0;
  }

  static Future<void> setWaktuCheckinPagi(int jam, int menit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(SharedKeys.notifikasiCheckinPagiJam, jam);
    await prefs.setInt(SharedKeys.notifikasiCheckinPagiMenit, menit);
  }

  // --- Preferensi Pola Craving ---

  static Future<bool> aktifPolaCraving() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(SharedKeys.notifikasiPolaCraving) ?? false;
  }

  static Future<void> setAktifPolaCraving(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedKeys.notifikasiPolaCraving, value);
  }

  /// Jadwalkan ulang pengingat jika aktif (dipanggil saat app start).
  static Future<void> jadwalkanUlangJikaAktif() async {
    try {
      // Pengingat harian existing.
      final isAktif = await aktif();
      L.i('pengingatHarian isAktif=$isAktif');
      if (isAktif) {
        final izinDiberikan = await _periksaIzinSistem();
        if (!izinDiberikan) {
          L.w('izin notifikasi tidak diberikan, nonaktifkan pengingat harian');
          await setAktif(false);
        } else {
          final j = await jam();
          final m = await menit();
          await jadwalkanPengingatHarian(jam: j, menit: m);
        }
      }

      // Check-in pagi.
      final isCheckinPagiAktif = await aktifCheckinPagi();
      L.i('checkinPagi isAktif=$isCheckinPagiAktif');
      if (isCheckinPagiAktif) {
        final izinDiberikan = await _periksaIzinSistem();
        if (!izinDiberikan) {
          L.w('izin notifikasi tidak diberikan, nonaktifkan check-in pagi');
          await setAktifCheckinPagi(false);
        } else {
          final j = await jamCheckinPagi();
          final m = await menitCheckinPagi();
          await jadwalkanCheckinPagi(jam: j, menit: m);
        }
      }
    } on Exception catch (e, s) {
      L.e('Gagal menjadwalkan ulang pengingat harian/check-in pagi: $e $s');
    } on UnsupportedError catch (e, s) {
      L.e('Platform tidak mendukung penjadwalan ulang: $e $s');
    }
  }

  /// Memeriksa status izin notifikasi pada sistem tanpa meminta.
  static Future<bool> _periksaIzinSistem() async {
    if (kIsWeb) {
      // Web tidak mendukung pengecekan izin tanpa prompt; anggap tersedia.
      return true;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final impl = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      final enabled = await impl?.areNotificationsEnabled();
      return enabled ?? false;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final impl = _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >();
      final settings = await impl?.checkPermissions();
      return settings?.isEnabled ?? false;
    }
    return true;
  }
}
