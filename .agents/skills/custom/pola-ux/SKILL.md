---
name: pola-ux
description: Pola UX standar untuk aplikasi Flutter: dialog konfirmasi destruktif, empty state informatif, kartu motivasi dengan pintasan aksi, perayaan pencapaian dengan toast sekali, validasi form sebelum simpan, dan akses data async opsional aman.
kategori: custom
versi: 1.0.0
commit-terakhir: e6595744b3840998d840e398ca1782e7be7d50b4
---

# Pola UX Standar

Skill ini mendokumentasikan pola UX yang wajib diterapkan pada proyek Flutter ini, berdasarkan implementasi nyata dari riwayat commit. Pola ini dirancang agar dapat digunakan kembali pada proyek Flutter lain.

## 1. Dialog Konfirmasi Destruktif

### Aturan
- **WAJIB** menampilkan dialog konfirmasi sebelum operasi destruktif (hapus data, pemulihan cadangan, reset).
- Gunakan `showOkCancelAlertDialog` dari package `adaptive_dialog`.
- Sertakan `isDestructiveAction: true` untuk tindakan destruktif.
- Pesan wajib menjelaskan **konsekuensi** tindakan (data apa yang terpengaruh, tidak bisa dikembalikan).
- Hanya jalankan operasi jika pengguna menekan OK.

### Contoh Implementasi
```dart
final konfirmasi = await showOkCancelAlertDialog(
  context: context,
  title: 'Hapus Data?',
  message: 'Data yang dihapus tidak dapat dikembalikan. '
      'Apakah Anda yakin ingin menghapus catatan craving ini?',
  okLabel: 'Hapus',
  cancelLabel: 'Batal',
  isDestructiveAction: true,
);
if (konfirmasi != OkCancelResult.ok) return;
```

### Referensi Commit
- `3b67d309` — Konfirmasi simpan diary craving
- `338a021` — Konfirmasi pemulihan cadangan (destruktif)
- `1e7b71e` — Konfirmasi masukkan data dummy (mengganti biodata)

## 2. Empty State Informatif

### Aturan
- **WAJIB** menampilkan empty state ketika daftar data kosong.
- Empty state harus berisi: ikon, judul, deskripsi singkat, dan call-to-action (FAB/tombol).
- Wajib dibungkus `SafeArea` dan memiliki padding tepi layar.
- JANGAN menampilkan layar kosong tanpa informasi atau CTA.

### Contoh Implementasi
```dart
class _EmptyDiaryCraving extends StatelessWidget {
  const _EmptyDiaryCraving();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Icon(CupertinoIcons.book, size: 48),
              Text(
                'Belum ada catatan craving',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Tekan tombol + untuk mencatat craving pertama.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### Referensi Commit
- `3b67d309` — Empty state diary craving

## 3. Kartu Motivasi dan Pintasan Aksi Cepat

### Aturan
- **WAJIB** menggunakan `unawaited(Nav.to(...).catchError(...))` untuk navigasi pintasan.
- Akses data async opsional (jumlah alasan, daftar terbaru) menggunakan `asyncValue.asData?.value ?? fallback`, **BUKAN** `requireValue`.
- Log variabel relevan dengan `L.i`/`L.w` sesuai aturan logging.
- Jika data opsional kosong, kembalikan `const SizedBox.shrink()` dengan `L.w`.

### Contoh Implementasi
```dart
// Akses data opsional aman
final alasanAsync = ref.watch(alasanBerhentiProvider);
final jumlah = alasanAsync.asData?.value.jumlahAlasan ?? 0;
L.i('jumlahAlasan=$jumlah');

// Navigasi pintasan dengan error handling
onTap: () => unawaited(
  Nav.to(context, const SosCravingScreen()).catchError(
    (Object e, StackTrace s) {
      L.e('Gagal navigasi ke SOS Craving: $e $s');
      return null;
    },
  ),
);

// FilterChip dengan logging
L.i('snippet=$snippet, terpilih=$terpilih');
return FilterChip(
  label: Text(snippet),
  selected: terpilih,
  onSelected: (dipilih) {
    L.i('snippet dipilih=$snippet, dipilih=$dipilih');
    setState(() { _teksController.text = dipilih ? snippet : ''; });
  },
);
```

### Referensi Commit
- `e659574` — Kartu SOS Craving dan Alasan Berhenti di dashboard

## 4. Perayaan Pencapaian (Toast Sekali)

### Aturan
- **WAJIB** menampilkan `AppToast.sukses` saat pencapaian baru (impian tercapai, badge didapat).
- **WAJIB** menyimpan penanda pencapaian di `SharedPreferences` (mis. `impian_diraikan`, `badge_diraikan`).
- Penandaan dilakukan dengan `unawaited()` agar tidak memblokir UI.
- JANGAN menampilkan toast perayaan berulang untuk item yang sama.

### Contoh Implementasi
```dart
// Cek dan tandai sudah diraikan
final prefs = await SharedPreferences.getInstance();
final daftar = prefs.getStringList('impian_diraikan') ?? <String>[];
if (!daftar.contains(impian.id)) {
  daftar.add(impian.id);
  unawaited(prefs.setStringList('impian_diraikan', daftar));
  unawaited(
    AppToast.sukses(
      context,
      'Selamat! Impian "${impian.nama}" telah tercapai!',
    ).catchError((e, s) => L.e('Gagal toast: $e $s')),
  );
}
```

### Referensi Commit
- `c7337d1` — Perayaan pencapaian impian dengan SharedPreferences

## 5. Validasi Form Sebelum Penyimpanan

### Aturan
- **WAJIB** membungkus field dengan `Form` + `GlobalKey<FormState>`.
- **WAJIB** memanggil `validate()` sebelum penyimpanan.
- Validator harus memvalidasi aturan bisnis (positif, tidak kosong, range), bukan hanya format.
- JANGAN menggunakan `int.tryParse(...) ?? 0` yang menyembunyikan input tidak valid.
- JANGAN menyimpan sebelum validasi lulus.

### Contoh Implementasi
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: TextFormField(
    controller: _penurunanController,
    keyboardType: TextInputType.number,
    validator: (value) {
      final n = int.tryParse(value ?? '');
      if (n == null || n <= 0) return 'Wajib bilangan bulat positif';
      return null;
    },
  ),
)

Future<void> _simpan() async {
  if (!(_formKey.currentState?.validate() ?? false)) return;
  // lanjutkan penyimpanan
}
```

### Referensi Commit
- `ceacc6a` — Validasi penurunan mingguan mode tapering
- `3b67d309` — Konfirmasi + validasi form diary craving

## 6. Penanganan Beberapa Provider Async di Satu Layar

### Aturan
- Tangani `isLoading` **gabungan** (jika salah satu loading → tampilkan indicator).
- Tangani `hasError` **terpisah** per provider dengan tombol retry `ref.refresh(provider)`.
- Panggil `requireValue` **hanya setelah** loading dan error ditangani.
- Kondisi data tidak lengkap (biodata null, tanggal null) → tampilan terpisah dengan CTA.

### Contoh Implementasi
```dart
final biodataAsync = ref.watch(biodataProvider);
final impianAsync = ref.watch(impianProvider);

if (biodataAsync.isLoading || impianAsync.isLoading) {
  return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
if (biodataAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(biodataProvider));
}
if (impianAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(impianProvider));
}

final biodata = biodataAsync.requireValue;
final impianState = impianAsync.requireValue;

if (biodata == null) {
  return const _BiodataBelumDiisi(); // tampilan terpisah dengan CTA
}
```

### Referensi Commit
- `19f43e5` — BadgeScreen memuat biodataProvider dan impianProvider

## 7. Penanganan State Async dan Data Kosong pada Layar

### Aturan
1. Cek `isLoading` → tampilkan loading indicator.
2. Cek `hasError` → tampilkan error + tombol retry `ref.refresh(provider)`.
3. `requireValue` → tangani data kosong (empty state) dan data tidak lengkap.
4. Gunakan **early return** (guard clause) untuk setiap kondisi.
5. Gunakan `const SizedBox.shrink()` untuk widget kondisional tersembunyi.
6. Cek `mounted` setelah `await` sebelum akses `context`/`setState`.

### Contoh Implementasi
```dart
@override
Widget build(BuildContext context) {
  final dataAsync = ref.watch(provider);

  if (dataAsync.isLoading) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
  if (dataAsync.hasError) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Gagal memuat data'),
            OutlinedButton(
              onPressed: () => ref.refresh(provider),
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }

  final state = dataAsync.requireValue;
  if (state.list.isEmpty) {
    return const Scaffold(body: _EmptyState());
  }
  return Scaffold(body: _Daftar(state.list));
}
```

### Referensi Commit
- `3b67d309` — DiaryCravingScreen, PemulihanKesehatanScreen
- `02aa6b29` — DashboardScreen

---

## Larangan Umum

- **DILARANG** menyimpan data tanpa validasi form.
- **DILARANG** menggunakan `requireValue` pada data opsional/async tanpa cek loading/error.
- **DILARANG** navigasi pintasan tanpa `.catchError()` pada `unawaited()`.
- **DILARANG** toast perayaan tanpa penandaan SharedPreferences.
- **DILARANG** empty state tanpa ikon, judul, deskripsi, dan CTA.
- **DILARANG** konfirmasi destruktif tanpa `isDestructiveAction: true` dan penjelasan konsekuensi.

## Pengecualian

- Jika proyek menggunakan mekanisme validasi lain yang **terbukti** menjalankan seluruh aturan sebelum simpan, `Form` tidak wajib (tetap validasi wajib dijalankan).
- Platform yang tidak mendukung fitur (Web notifikasi terjadwal) → jangan tampilkan kontrol, tangani graceful.

---

## Referensi Aturan Terkait

- `aturan_bersama.md` — Validasi Form, Penanganan AsyncValue, Unawaited Error Handling
- `aturan_khusus.md` — Konfirmasi Simpan, Empty State, Kartu Motivasi, Visualisasi Progres, Perayaan Pencapaian