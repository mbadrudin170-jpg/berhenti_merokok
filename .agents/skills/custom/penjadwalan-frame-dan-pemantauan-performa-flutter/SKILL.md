---
name: penjadwalan-frame-dan-pemantauan-performa-flutter
description: Panduan penjadwalan frame dan pemantauan performa Flutter menggunakan SchedulerBinding, PlatformDispatcher, Timeline, dan FrameTiming. Digunakan untuk mengatur siklus frame (scheduleFrame, scheduleWarmUpFrame, handleBeginFrame, handleDrawFrame), transient/persistent/post-frame callback, pemantauan performa via addTimingsCallback dan onReportTimings, serta pencatatan timeline via Timeline.timeSync/startSync/finishSync dan Flow.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "belum-ada-commit"
  model: "kilo-auto/free"
---

# Penjadwalan Frame dan Pemantauan Performa Flutter

Skill ini mengatur cara kerja siklus frame Flutter dari lapisan framework (SchedulerBinding) hingga lapisan engine (PlatformDispatcher dan dart:ui), beserta alat pemantauan performa (Timeline, FrameTiming, dan onReportTimings). Tujuannya adalah agar frame dijadwalkan dengan benar, callback dieksekusi pada fase yang tepat, dan metrik performa terpantau tanpa kebocoran resource.

## Cakupan yang Di-Cover

- Package: `package:flutter` (file `lib/src/scheduler/binding.dart`), `dart:developer` (file `developer/timeline.dart`), `dart:ui` (file `ui/platform_dispatcher.dart`)
- Class: `SchedulerBinding`, `PlatformDispatcher`, `Timeline`, `TimelineTask`, `Flow`, `FrameTiming`, `PerformanceModeRequestHandle`
- Enum: `SchedulerPhase`, `FramePhase`, `DartPerformanceMode`
- Properti: `SchedulerBinding.instance`, `SchedulerBinding.lifecycleState`, `SchedulerBinding.framesEnabled`, `SchedulerBinding.hasScheduledFrame`, `SchedulerBinding.schedulerPhase`, `SchedulerBinding.currentFrameTimeStamp`, `SchedulerBinding.currentSystemFrameTimeStamp`, `SchedulerBinding.timeDilation`, `PlatformDispatcher.instance`, `PlatformDispatcher.onBeginFrame`, `PlatformDispatcher.onDrawFrame`, `PlatformDispatcher.onReportTimings`, `FrameTiming.buildDuration`, `FrameTiming.rasterDuration`, `FrameTiming.vsyncOverhead`, `FrameTiming.totalSpan`
- Method: `SchedulerBinding.scheduleFrame()`, `SchedulerBinding.scheduleForcedFrame()`, `SchedulerBinding.scheduleWarmUpFrame()`, `SchedulerBinding.handleBeginFrame()`, `SchedulerBinding.handleDrawFrame()`, `SchedulerBinding.addTimingsCallback()`, `SchedulerBinding.removeTimingsCallback()`, `SchedulerBinding.scheduleTask()`, `SchedulerBinding.scheduleFrameCallback()`, `SchedulerBinding.cancelFrameCallbackWithId()`, `SchedulerBinding.addPersistentFrameCallback()`, `SchedulerBinding.addPostFrameCallback()`, `SchedulerBinding.resetEpoch()`, `SchedulerBinding.endOfFrame`, `SchedulerBinding.ensureVisualUpdate()`, `SchedulerBinding.ensureFrameCallbacksRegistered()`, `PlatformDispatcher.scheduleFrame()`, `PlatformDispatcher.scheduleWarmUpFrame()`, `Timeline.timeSync()`, `Timeline.startSync()`, `Timeline.finishSync()`, `TimelineTask.start()`, `TimelineTask.finish()`, `Flow.begin()`, `Flow.step()`, `Flow.end()`

## Aturan

1. Wajib menggunakan `SchedulerBinding.instance.scheduleFrame()` untuk meminta frame baru, bukan memanggil `PlatformDispatcher.scheduleFrame()` secara langsung kecuali dalam kasus khusus yang memang memerlukan akses ke platform dispatcher.
2. Gunakan `SchedulerBinding.scheduleWarmUpFrame()` hanya saat aplikasi startup atau setelah hot reload / `allowFirstFrame`; jangan digunakan untuk render frame rutin karena mengunci dispatch event hingga frame selesai.
3. `scheduleForcedFrame()` hanya dipakai jika frame harus dipaksa meskipun frame tidak seharusnya dijadwalkan (layar mati); hindari dalam operasi normal karena berdampak pada penggunaan baterai.
4. Fase frame (`SchedulerPhase`) harus dipahami: `scheduleFrame()` tidak berpengaruh saat fasa `transientCallbacks`, `midFrameMicrotasks`, atau `persistentCallbacks`; hanya berfungsi pada `idle` dan `postFrameCallbacks`.
5. Transient frame callback (`scheduleFrameCallback`) dieksekusi pada fase `transientCallbacks` (awal frame); persistent callback (`addPersistentFrameCallback`) dieksekusi pada fase `persistentCallbacks`; post-frame callback (`addPostFrameCallback`) dieksekusi setelah rendering selesai.
6. Persistent dan post-frame callback tidak dapat dibatalkan setelah terdaftar; pastikan pendaftaran hanya dilakukan sekali untuk menghindari duplikasi eksekusi per frame.
7. Wajib memanggil `SchedulerBinding.addTimingsCallback()` (lebih disarankan) daripada `PlatformDispatcher.onReportTimings` secara langsung karena mendukung banyak callback secara independen.
8. Setiap `Timeline.startSync()` harus selalu diiringi `Timeline.finishSync()` dalam blok `finally` untuk mencegah uneven calls; gunakan `Timeline.timeSync()` untuk pemanggilan sinkron sederhana.
9. Objek `Flow` digunakan untuk menggambarkan alur antar Timeline slice dengan `id` yang sama; gunakan `Flow.begin()`, `Flow.step(id)`, dan `Flow.end(id)` berpasangan.
10. `resetEpoch()` dipanggil otomatis saat mengubah `timeDilation`; jangan dipanggil secara manual kecuali ada perubahan non-monotonik pada stempel waktu yang memerlukan penyesuaian basis epoch.
11. `PerformanceModeRequestHandle` harus dipanggil `.dispose()` saat tidak lagi diperlukan; semua request yang terdaftar harus dibuang untuk menghindari kebocoran performance mode.

## Larangan

- DILARANG memanggil `PlatformDispatcher.scheduleFrame()` langsung di luar kasus khusus; gunakan `SchedulerBinding.instance.scheduleFrame()`.
- DILARANG menggunakan `scheduleWarmUpFrame()` untuk render frame rutin (hanya startup / hot reload / allowFirstFrame).
- DILARANG menjalankan tugas berat (lebih dari ~1 ms) di dalam transient callback karena akan menunda frame reguler.
- DILARANG membatalkan persistent atau post-frame callback setelah terdaftar (tidak ada API unregister).
- DILARANG meninggalkan `Timeline.startSync()` tanpa pasangan `finishSync()`.
- DILARANG menggunakan `Flow` dengan `id` yang tidak terkoordinasi antar slice yang ingin dihubungkan.
- DILARANG meminta `DartPerformanceMode` tanpa membuang `PerformanceModeRequestHandle` saat selesai.
- DILARANG mengabaikan error pada `Future` yang dilepas (`unawaited`) dari navigasi atau operasi async terkait frame; wajib `.catchError()` dengan `L.e`.

## Contoh Benar

```dart
import 'package:flutter/scheduler.dart';
import 'dart:developer' show Timeline, Flow;
import 'package:flutter/foundation.dart' show kReleaseMode;

class FrameCoordinator {
  /// Meminta frame visual pada saat yang tepat sesuai fase scheduler.
  void ensureVisualUpdate() {
    SchedulerBinding.instance.ensureVisualUpdate();
  }

  /// Meminta frame baru secara aman.
  void scheduleFrame() {
    SchedulerBinding.instance.scheduleFrame();
  }

  /// Mendaftarkan callback untuk pengukuran performa frame.
  void registrasiTimings() {
    SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
      for (final t in timings) {
        if (!kReleaseMode) {
          // Terpantau hanya di debug/profile
        }
      }
    });
  }

  /// Menghentikan pemantauan performa.
  void batalkanTimings(void callback(List<FrameTiming>)) {
    SchedulerBinding.instance.removeTimingsCallback(callback);
  }

  /// Menjalankan tugas lintas-frame dengan pencatatan timeline dan flow.
  Future<void> jalankanTugasPrioritasTinggi(Future<void> Function() task) async {
    final flow = Flow.begin();
    await SchedulerBinding.instance.scheduleTask(
      () {
        return Timeline.timeSync('TugasPrioritas', () async {
          await task();
        }, flow: Flow.step(flow.id));
      },
      Priority.animation,
      debugLabel: 'TugasPrioritas',
      flow: flow,
    );
    // flow.id digunakan untuk sinkronisasi flow dengan Timeline berikutnya
  }

  /// Menjeda eksekusi hingga akhir frame saat ini.
  Future<void> tungguAkhirFrame() async {
    await SchedulerBinding.instance.endOfFrame;
  }

  /// Meminta frame paksa saat layar akan kembali menyala (rotasi).
  void paksaFrameSaidara() {
    SchedulerBinding.instance.scheduleForcedFrame();
  }
}
```

## Contoh Salah

```dart
// DILARANG: memanggil platform dispatcher langsung
PlatformDispatcher.instance.scheduleFrame();

// BENAR:
SchedulerBinding.instance.scheduleFrame();

// DILARANG: warm-up frame untuk render rutin
SchedulerBinding.instance.scheduleWarmUpFrame();

// BENAR: hanya startup / hot reload / allowFirstFrame

// DILARANG: tugas berat di transient callback
SchedulerBinding.instance.scheduleFrameCallback((_) {
  hitungPerhitunganBerat(); // menunda frame
});

// BENAR: pindahkan tugas berat ke scheduleTask dengan prioritas rendah

// DILARANG: Timeline tanpa finishSync
Timeline.startSync('Nama');
doSomething();
// lupa finishSync

// BENAR:
Timeline.startSync('Nama');
try {
  doSomething();
} finally {
  Timeline.finishSync();
}

// DILARANG: performance mode request tidak dibuang
final handle = SchedulerBinding.instance.requestPerformanceMode(DartPerformanceMode.latency);
// lupa handle.dispose()

// BENAR:
final handle = SchedulerBinding.instance.requestPerformanceMode(DartPerformanceMode.latency);
// ...
handle.dispose();
```

## Sumber Evaluasi

- File: `lib/src/scheduler/binding.dart` (class `SchedulerBinding`, enum `SchedulerPhase`, `defaultSchedulingStrategy`)
- File: `dart:developer` / `developer/timeline.dart` (class `Timeline`, `TimelineTask`, `Flow`)
- File: `dart:ui` / `ui/platform_dispatcher.dart` (class `PlatformDispatcher`, `FrameTiming`, enum `FramePhase`, `DartPerformanceMode`)
- Class terkait: `SchedulerBinding`, `PlatformDispatcher`, `Timeline`, `TimelineTask`, `Flow`, `FrameTiming`, `PerformanceModeRequestHandle`
- Commit rujukan: `belum-ada-commit` (topik berasal dari SDK Flutter, tidak ada commit proyek terkait)
