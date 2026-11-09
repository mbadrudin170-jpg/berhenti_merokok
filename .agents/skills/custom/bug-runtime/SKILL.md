---
name: bug-runtime
description: Pencegahan bug runtime: type promotion null safety, normalisasi tanggal, penanganan AsyncValue, validasi form, error handling unawaited, validasi platform/izin, custom exception types.
kategori: custom
versi: 1.0.0
commit-terakhir: be04199e5b44537ee1052a3815f5af8518308148
---

# Pencegahan Bug Runtime

Skill ini mendokumentasikan pola pencegahan bug runtime berdasarkan aturan `aturan_bersama.md` dan `aturan_khusus.md`.

## 1. Type Promotion untuk Null Safety (Field Objek)

### Aturan
- Field nullable dari objek model **WAJIB** disalin ke variabel lokal sebelum null-check.
- Gunakan variabel lokal di percabangan `== null` dan pemanggilan fungsi.
- **DILARANG** pakai operator `!` jika type promotion bisa dipakai.

### Contoh
```dart
// BENAR: Copy ke lokal → type promotion works
final tanggalLahir = biodata?.tanggalLahir;
final tanggalMulai = biodata?.tanggalMulaiMerokok;

_buildItem(
  'Tanggal Lahir',
  tanggalLahir == null ? 'Belum dipilih' : FormatTanggal.formatDasar(tanggalLahir),
);

// SALAH: Langsung akses field dengan !
_buildItem(
  'Tanggal Lahir',
  biodata.tanggalLahir == null ? 'Belum dipilih' : FormatTanggal.formatDasar(biodata.tanggalLahir!),
);
```

### Referensi Commit
- `1e7b71e` — `biodata_screen.dart` refactoring

---

## 2. Normalisasi Tanggal untuk Perbandingan Hari

### Aturan
- **WAJIB** normalisasi `DateTime` ke komponen tanggal saja (tahun, bulan, hari) sebelum bandingkan/hitung selisih hari.
- Gunakan `DateTime(tahun, bulan, hari)` untuk buang jam/menit/detik.
- Hasil negatif **WAJIB** diklem ke 0 (hari smoke-free tidak boleh negatif).
- Gunakan `isBefore`/`isAfter` pada nilai dinormalisasi.

### Contoh
```dart
// BENAR: Normalisasi dulu
final hariIniDate = DateTime(hariIni.year, hariIni.month, hariIni.day);
final berhentiDate = DateTime(berhenti.year, berhenti.month, berhenti.day);
final totalHari = hariIniDate.difference(berhentiDate).inDays + 1;
final aman = totalHari < 0 ? 0 : totalHari; // Klamp negatif

// Durasi smoke-free
final durasi = DateTime.now().difference(tanggalBerhenti);
final amanDurasi = durasi.isNegative ? Duration.zero : durasi;

// SALAH: Langsung DateTime.now() (pakai jam/menit/detik)
final totalHari = DateTime.now().difference(tanggalBerhenti).inDays + 1; // Bisa salah 1 hari!
```

### Referensi Commit
- `6fd979fd` — `KalenderSmokeFreeScreen`, `_SelHari`, `_GridKalender`
- `02aa6b29` — `PemulihanKesehatanScreen`, `DashboardScreen`

---

## 3. Penanganan Beberapa AsyncValue di Satu Layar

### Aturan
1. Cek `isLoading` **gabungan** (salah satu loading → loading indicator).
2. Cek `hasError` **terpisah** per provider dengan retry `ref.refresh(provider)`.
3. `requireValue` **hanya setelah** loading & error ditangani.
4. Data tidak lengkap (biodata null, tanggal null) → tampilan terpisah + CTA.

### Contoh
```dart
final biodataAsync = ref.watch(biodataProvider);
final impianAsync = ref.watch(impianProvider);

// 1. Loading gabungan
if (biodataAsync.isLoading || impianAsync.isLoading) {
  return const Scaffold(body: Center(child: CircularProgressIndicator()));
}

// 2. Error terpisah
if (biodataAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(biodataProvider));
}
if (impianAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(impianProvider));
}

// 3. requireValue setelah aman
final biodata = biodataAsync.requireValue;
final impianState = impianAsync.requireValue;

// 4. Data tidak lengkap
if (biodata == null) {
  return const _BiodataBelumDiisi(); // Tampilan terpisah + CTA
}
```

### Referensi Commit
- `19f43e5` — `BadgeScreen` (biodataProvider + impianProvider)

---

## 4. Penanganan State Async & Data Kosong (Early Return Pattern)

### Aturan
1. `isLoading` → loading indicator (early return).
2. `hasError` → error + retry button (early return).
3. `requireValue` → handle empty state & data tidak lengkap (early return).
4. `const SizedBox.shrink()` untuk widget kondisional tersembunyi.
5. Cek `mounted` setelah `await` sebelum akses `context`/`setState`.

### Contoh
```dart
@override
Widget build(BuildContext context) {
  final stateAsync = ref.watch(provider);

  // 1. Loading
  if (stateAsync.isLoading) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  // 2. Error
  if (stateAsync.hasError) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            OutlinedButton(onPressed: () => ref.refresh(provider), child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }

  // 3. Data ready
  final state = stateAsync.requireValue;

  // 4. Empty state
  if (state.list.isEmpty) {
    return const Scaffold(body: _EmptyState());
  }

  // 5. Data tidak lengkap (mis. biodata null)
  if (state.biodata == null) {
    return const _BelumSetupView();
  }

  // 6. Widget kondisional tersembunyi
  return Scaffold(
    body: Column(
      children: [
        if (state.tanggalBerhenti != null) _MilestoneCard(...),
        if (state.tanggalBerhenti == null) const SizedBox.shrink(), // Tersembunyi
        Expanded(child: _Daftar(state.list)),
      ],
    ),
  );
}
```

### Referensi Commit
- `3b67d309` — `DiaryCravingScreen`, `PemulihanKesehatanScreen`
- `02aa6b29` — `DashboardScreen`

---

## 5. Validasi Form Sebelum Penyimpanan

### Aturan
- **WAJIB** `Form` + `GlobalKey<FormState>` membungkus field.
- **WAJIB** `validator` di `TextFormField` validasi aturan bisnis (positif, range, tidak kosong).
- **WAJIB** panggil `validate()` sebelum simpan.
- **DILARANG** `int.tryParse(...) ?? 0` (menyembunyikan input invalid).
- **DILARANG** simpan sebelum validasi lulus.

### Contoh
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: TextFormField(
    controller: _controller,
    keyboardType: TextInputType.number,
    validator: (value) {
      final n = int.tryParse(value?.trim() ?? '');
      if (n == null) return 'Wajib diisi';
      if (n <= 0) return 'Wajib bilangan bulat positif (> 0)';
      return null;
    },
  ),
)

Future<void> _simpan() async {
  if (!(_formKey.currentState?.validate() ?? false)) return; // Early return jika invalid
  
  // Parsing AMAN karena sudah divalidasi
  final value = int.parse(_controller.text.trim());
  await ref.read(provider.notifier).simpan(model);
}
```

### Referensi Commit
- `ceacc6a` — Form biodata mode tapering
- `3b67d309` — Form diary craving

---

## 6. Error Handling pada Future yang Dilepas (unawaited)

### Aturan
- `unawaited(...)` **WAJIB** punya `.catchError(...)` atau `try/catch` yang log error via `L.e`.
- **DILARANG** `unawaited(Nav.to(...))`, `unawaited(EasyLoading.show/dismiss)` tanpa error handling.
- Navigasi & loading **WAJIB** pakai pattern ini.

### Contoh
```dart
// Navigasi
unawaited(
  Nav.to(context, const HalamanLain()).catchError((Object e, StackTrace s) {
    L.e('Gagal navigasi: $e $s');
    return null;
  }),
);

// EasyLoading show
unawaited(
  EasyLoading.show(status: 'Memproses...', maskType: EasyLoadingMaskType.black)
    .catchError((Object e, StackTrace s) => L.e('Gagal loading: $e $s')),
);

// EasyLoading dismiss
unawaited(
  EasyLoading.dismiss().catchError((Object e, StackTrace s) => L.e('Gagal dismiss: $e $s')),
);
```

### Referensi Commit
- `fd6b45a` — `dashboard_screen.dart` Nav.to
- `d80e637` — `form_biodata.dart` EasyLoading + Nav.pushAndRemoveUntil
- `338a021` — Cadangan screen

---

## 7. Validasi Dukungan Platform & Izin Runtime

### Aturan
- Cek dukungan platform **sebelum** pakai API package (versi package matters).
- **DILARANG** tampilkan kontrol fitur yang tidak didukung platform (Web/Linux notifikasi terjadwal).
- Minta izin **pada konteks fitur** (user action), bukan saat startup.
- Cek hasil izin **sebelum** simpan status aktif.
- Pisahkan inisialisasi service dari request izin.
- Tangani `UnsupportedError` eksplisit, bukan cuma `Exception`.

### Contoh
```dart
// Cek platform sebelum tampilkan pengingat
if (kIsWeb) {
  // Jangan tampilkan pengingat terjadwal
  return const SizedBox.shrink();
}

if (defaultTargetPlatform == TargetPlatform.android) {
  final izin = await _mintaIzinAndroid();
  if (!izin) return; // User tolak → jangan lanjut
}

// Inisialisasi service (startup OK)
await _plugin.initialize(...);

// Request izin (saat user aktifkan fitur)
Future<void> _aktifkanPengingat() async {
  if (await _mintaIzin()) {
    await _jadwalkanNotifikasi();
    await _simpanStatusAktif(true);
  }
}

// Tangani UnsupportedError eksplisit
try {
  await _plugin.zonedSchedule(...);
} on UnsupportedError catch (e, s) {
  L.e('Platform tidak support jadwal: $e $s');
  AppToast.peringatan(context, 'Fitur tidak tersedia di platform ini');
} on Exception catch (e, s) {
  L.e('Gagal jadwal: $e $s');
  rethrow;
}
```

### Referensi Commit
- `774431d` — Notifikasi service
- `0cb0e52` — `saran.md` findings

---

## 8. Custom Exception Types untuk Deteksi Error

### Aturan
- Gunakan **class exception khusus** implements `Exception` untuk error yang perlu dideteksi caller.
- Deteksi via `is` (type check), **BUKAN** `e.toString().contains(...)`.
- Class exception **WAJIB** terpisah dengan dokumentasi singkat.

### Contoh
```dart
// Custom exception
class IzinNotifikasiTidakDiberikanException implements Exception {
  const IzinNotifikasiTidakDiberikanException();
  @override String toString() => 'Izin notifikasi tidak diberikan';
}

class BerkasCadanganTidakValidException implements Exception {
  const BerkasCadanganTidakValidException(this.pesan);
  final String pesan;
  @override String toString() => 'Berkas cadangan tidak valid: $pesan';
}

// Melempar
throw const IzinNotifikasiTidakDiberikanException();

// Mendeteksi (caller)
} on Exception catch (e, s) {
  if (e is IzinNotifikasiTidakDiberikanException) {
    // Handle spesifik
    AppToast.peringatan(context, 'Izin notifikasi diperlukan');
    return;
  }
  if (e is BerkasCadanganTidakValidException) {
    AppToast.gagal(context, e.pesan);
    return;
  }
  L.e('Error tidak terduga: $e $s');
  rethrow;
}

// SALAH: String matching (fragile)
final isIzin = e.toString().contains('Izin notifikasi tidak diberikan');
```

### Referensi Commit
- `07fc8df` — `IzinNotifikasiTidakDiberikanException`
- `338a021` — `BerkasCadanganTidakValidException`

---

## 9. Guard Pembagian Nol

### Aturan
- Setiap pembagian **WAJIB** guard `if (pembagi == 0) return 0/false`.
- Di helper murni & ekstensi model.

### Contoh
```dart
// Helper murni
static double rasio(double saldo, double target) {
  if (target <= 0) return 0.0; // Guard
  return (saldo / target).clamp(0.0, 1.0);
}

static bool tercapai(double saldo, double target) {
  if (target <= 0) return false; // Guard
  return saldo >= target;
}

// Ekstensi model
double get uangDihemat {
  if (batangPerBungkus == 0) return 0; // Guard
  return (rokokTidakDiHisap / batangPerBungkus) * hargaRokokPerBungkus;
}
```

### Referensi Commit
- `19f43e5` — `BiodataModelPerhitungan`, `BadgeHelper`
- `c7337d1` — `ImpianProgresHelper`

---

## Larangan Umum

- **DILARANG** `biodata.field!` tanpa copy ke lokal dulu (type promotion).
- **DILARANG** bandingkan tanggal tanpa normalisasi.
- **DILARANG** `requireValue` tanpa cek `isLoading`/`hasError` dulu.
- **DILARANG** simpan form tanpa `validate()`.
- **DILARANG** `int.tryParse(...) ?? 0` untuk input wajib valid.
- **DILARANG** `unawaited()` tanpa `.catchError()`.
- **DILARANG** tampilkan fitur tidak support platform.
- **DILARANG** minta izin di startup tanpa konteks.
- **DILARANG** simpan status aktif tanpa cek hasil izin.
- **DILARANG** `e.toString().contains(...)` untuk deteksi error.
- **DILARANG** pembagian tanpa guard nol.

---

## Referensi Aturan Terkait

- `aturan_bersama.md` — Type Promotion, Import Ordering, Normalisasi Tanggal, Ekstraksi Perhitungan, Validasi Platform, Custom Exception, AsyncValue Handling, Form Validation, Unawaited Error
- `aturan_khusus.md` — Type Promotion Biodata, Normalisasi Tanggal, AsyncValue Handling, Form Validasi Tapering, Notifikasi Platform, Custom Exception Cadangan