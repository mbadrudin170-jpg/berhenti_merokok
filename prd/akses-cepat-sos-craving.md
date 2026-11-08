# PRD: Akses Cepat SOS Craving dari Layar Utama

## 1. Referensi

- Sumber: `referensi_apk.md`
- Path: `referensi_apk.md`
- Baris: baris 22-32 (entri "#### 1. Akses Cepat SOS Craving dari Layar Utama"; terkait juga baris 176-188 dan 326-338 pada bagian optimasi/UI)
- Link APK:
  - https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
  - https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking
  - https://flamy.co/

## 2. Status

- Status: Pembaruan (optimasi aksesibilitas fitur yang sudah ada)
- Implementasi saat ini: Sebagian
  - Layar `SosCravingScreen` sudah lengkap (tab Napas 4-7-8, Timer 3 Menit, Distraksi) di `lib/fitur/sos_craving/screens/sos_craving_screen.dart`.
  - Akses cepat sudah ada sebagian: ikon SOS di `AppBar` Dashboard (`lib/fitur/dashboard/screens/dashboard_screen.dart`, baris 88-101) dan entri "SOS Craving" pada `LainnyaScreen` (`lib/lainnya_screen.dart`, baris 28-31).
  - Belum ada kartu SOS yang menonjol pada badan utama Dashboard, sesuai saran referensi.
- Tanggal diskusi: 2026-11-08

## 3. Tujuan & Latar Belakang

### Tujuan utama

Memudahkan pengguna menjangkau bantuan craving (SOS Craving) dalam hitungan detik saat dorongan merokok muncul, langsung dari layar utama aplikasi.

### Masalah yang ingin diselesaikan

Fitur SOS Craving saat ini paling menonjol hanya dapat diakses melalui menu "Lainnya", sehingga membutuhkan beberapa ketukan dari layar utama. Pada momen craving, hambatan akses sekecil apa pun dapat mengurangi efektivitas bantuan. Ikon kecil di `AppBar` Dashboard kurang mencolok untuk kondisi darurat.

### Manfaat bagi pengguna

- Akses satu ketukan ke bantuan craving dari layar utama.
- Mengurangi waktu reaksi saat dorongan merokok muncul.
- Meningkatkan peluang pengguna memilih strategi koping (napas, timer, distraksi) daripada merokok.

### Manfaat bagi sistem

- Tidak membutuhkan dependensi baru.
- Memanfaatkan `SosCravingScreen` yang sudah ada.
- Konsisten dengan pola navigasi proyek (`Nav` dari `core_shared`).

### Ruang lingkup

- Termasuk: penambahan pintasan SOS yang menonjol pada badan utama Dashboard (kartu SOS besar di bagian atas daftar), dengan navigasi ke `SosCravingScreen`, penanganan error navigasi, dan tooltip/label yang jelas.
- Tidak termasuk: tombol aksi mengambang (FAB), perubahan isi/fitur `SosCravingScreen`, penambahan tab navigasi baru, dan integrasi notifikasi.

## 4. Ruang Lingkup

- Termasuk: kartu SOS besar di bagian atas `ListView` Dashboard; navigasi aman dengan `unawaited` + `.catchError`; aksesibilitas (tooltip, label, area sentuh minimal 48x48 dp).
- Tidak termasuk: FAB, perubahan logika SOS Craving, widget beranda, backend/komunitas.

## 5. Gambaran Fitur (dari Link APK)

Berdasarkan deskripsi resmi Google Play Store:

- **Quit Smoking : Tracker & Timer (H2M apps):** menyediakan tombol SOS pada layar utama; saat cravings muncul, pengguna menekan SOS untuk mengakses timer 3 menit, napas 4-7-8, dan analisis pola craving. SOS menjadi pintasan yang mudah dijangkau.
- **QUIT Smoking SOS (ANKO Solutions):** SOS satu ketukan dari layar utama; membuka rencana aksi singkat (napas, mini-games, artikel, AI coach) untuk melewati beberapa menit craving.
- **Flamy:** menyediakan SOS napas/distraksi yang mudah diakses.

Pola UI/UX yang diadopsi: kartu SOS besar/mencolok pada layar utama dengan akses satu ketukan; area sentuh yang cukup; label/ikon yang jelas.

## 6. File Terdampak

| No | Path | Peran | Status |
| -- | ---- | ----- | ------ |
| 1 | `lib/fitur/dashboard/screens/dashboard_screen.dart` | Tambah kartu SOS besar di bagian atas `ListView` Dashboard; navigasi ke `SosCravingScreen` | Ubah |
| 2 | `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Tujuan navigasi; tidak diubah kecuali penyesuaian kecil | Baca/Tidak berubah |
| 3 | `lib/home.dart` | Opsional: tambah destinasi/tab SOS jika dipilih pendekatan tab (di luar ruang lingkup awal) | Opsional |
| 4 | `lib/lainnya_screen.dart` | Pertahankan entri SOS (akses sekunder) atau hapus duplikasi; keputusan saat implementasi | Opsional |
| 5 | `prd/akses-cepat-sos-craving.md` | Dokumen PRD ini | Baru |

## 7. Rencana Implementasi (Ringkas)

1. Pada `DashboardScreen`, tambahkan kartu SOS yang menonjol pada `ListView` (bukan di posisi paling atas; misalnya setelah kartu "Lama berhenti merokok" atau setelah kartu progres), berisi ikon `Icons.sos`, judul "SOS Craving", deskripsi singkat "Butuh bantuan saat craving?", dan tombol/area sentuh yang membuka `SosCravingScreen`.
2. Gunakan pola navigasi proyek: `unawaited(Nav.to(context, const SosCravingScreen()).catchError(...))` dengan pencatatan error melalui `L.e`.
3. Pastikan kartu memiliki label/tooltip yang jelas dan area sentuh minimal 48x48 dp (gunakan `InkWell`/`GestureDetector` pada seluruh kartu atau tombol `ElevatedButton`).
4. Pertahankan penanganan state asynchronous Dashboard (loading/error/data) agar kartu SOS hanya muncul pada kondisi data valid; pada kondisi loading/error, jangan tampilkan kartu (atau tampilkan dengan perilaku yang aman).
5. Pertahankan entri SOS di `LainnyaScreen` sebagai akses sekunder (opsional) untuk kompatibilitas.
6. Jalankan `dart format` pada file yang diubah dan `flutter analyze`; periksa padding tepi layar agar kartu tidak menempel pada batas layar (gunakan `Padding`/`ListView` padding yang sudah ada).

## 8. Contoh Kode Singkat

```dart
// Pada children ListView Dashboard (setelah kartu "Lama berhenti merokok", bukan paling atas):
Card(
  color: Theme.of(context).colorScheme.errorContainer,
  child: InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () => unawaited(
      Nav.to(context, const SosCravingScreen()).catchError((
        Object e,
        StackTrace s,
      ) {
        L.e('Gagal navigasi ke SOS Craving: $e $s');
        return null;
      }),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        children: [
          Icon(
            Icons.sos,
            size: 32,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'SOS Craving',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
                Text(
                  'Butuh bantuan saat craving? Tekan untuk bantuan cepat.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ],
      ),
    ),
  ),
),
```

Asumsi: `SosCravingScreen` sudah di-import di `dashboard_screen.dart`; `Nav` tersedia dari `core_shared`; `L` dari `lib/shared/utils/l.dart`; `dart:async` untuk `unawaited`.
