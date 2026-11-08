# PRD: Akses Cepat SOS Craving dari Layar Utama

## 1. Informasi Dokumen

- **Nama fitur:** Akses Cepat SOS Craving dari Layar Utama
- **Jenis pengembangan:** Pembaruan fitur (optimasi aksesibilitas fitur SOS Craving yang sudah ada)
- **Status implementasi:** Sebagian
- **Status PRD:** Draft
- **Tanggal pembuatan/pembaruan:** 2026-11-08
- **Sumber referensi:** `refrensi_apk.md`

## 2. Tujuan Fitur

Memudahkan pengguna menjangkau bantuan craving (SOS Craving) dalam hitungan detik saat dorongan merokok muncul, langsung dari layar utama aplikasi, tanpa harus membuka menu "Lainnya".

## 3. Latar Belakang dan Permasalahan

Fitur SOS Craving sudah tersedia dengan tab Napas 4-7-8, Timer 3 Menit, dan Distraksi. Namun akses utamanya berada di menu "Lainnya", sehingga membutuhkan beberapa ketukan dari layar utama. Pada momen craving, hambatan akses sekecil apa pun dapat mengurangi efektivitas bantuan. Ikon kecil di `AppBar` Dashboard kurang mencolok untuk kondisi darurat. Referensi aplikasi kompetitor menempatkan SOS sebagai tombol besar/mencolok pada layar utama dengan akses satu ketukan.

## 4. Target Pengguna

Pengguna aplikasi yang sedang dalam proses berhenti merokok dan membutuhkan bantuan cepat saat craving muncul.

## 5. Manfaat Fitur

- **Manfaat utama:** Akses satu ketukan ke bantuan craving dari layar utama, mengurangi waktu reaksi saat dorongan merokok muncul.
- **Manfaat tambahan:** Meningkatkan peluang pengguna memilih strategi koping (napas, timer, distraksi) daripada merokok; meningkatkan visibilitas fitur SOS.
- **Dampak terhadap pengguna:** Pengalaman lebih responsif pada momen kritis.
- **Dampak terhadap aplikasi:** Memanfaatkan `SosCravingScreen` yang sudah ada; tidak membutuhkan dependensi baru.

## 6. Referensi Aplikasi

- **Nama aplikasi:** Quit Smoking : Tracker & Timer (H2M apps); QUIT Smoking SOS (ANKO Solutions); Flamy
- **Link aplikasi:**
  - https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke
  - https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking
  - https://flamy.co/
- **Screenshot/demonstrasi:** Screenshot resmi tersedia pada halaman Google Play Store (tombol SOS pada layar utama).
- **Gambaran tampilan:** Tombol SOS besar dan mencolok pada layar utama; akses satu ketukan.
- **Gambaran cara kerja:** Saat cravings muncul, pengguna menekan SOS untuk mengakses timer 3 menit, napas 4-7-8, dan analisis pola craving (H2M); atau rencana aksi singkat napas/mini-games/artikel/AI coach (ANKO).
- **Informasi yang belum terverifikasi:** Detail visual (posisi tombol, warna, struktur halaman) sebagian besar didasarkan pada deskripsi resmi; alur interaksi detail tidak dapat diverifikasi langsung.

## 7. Sumber Referensi Internal

- Nama file: `refrensi_apk.md`
- Path: `refrensi_apk.md`
- Baris: `L22-L32` (entri "#### 1. Akses Cepat SOS Craving dari Layar Utama"; terkait juga `L176-L188` dan `L326-L338`)
- Referensi lengkap: `refrensi_apk.md:L22-L32`
- Nama data: Akses Cepat SOS Craving dari Layar Utama
- Link aplikasi: https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://play.google.com/store/apps/details?id=com.quitapp.quitsmoking ; https://flamy.co/

## 8. Kondisi Implementasi Saat Ini

- **Status implementasi:** Sebagian
- **Fungsi yang sudah tersedia:**
  - Layar `SosCravingScreen` lengkap (tab Napas 4-7-8, Timer 3 Menit, Distraksi) di `lib/fitur/sos_craving/screens/sos_craving_screen.dart`.
  - Akses cepat sebagian: ikon SOS di `AppBar` Dashboard (`lib/fitur/dashboard/screens/dashboard_screen.dart`, baris 88-101).
  - Entri "SOS Craving" pada `LainnyaScreen` (`lib/lainnya_screen.dart`, baris 28-31).
- **Fungsi yang belum tersedia:**
  - Kartu SOS yang menonjol pada badan utama Dashboard (bukan FAB, bukan posisi paling atas daftar).
- **Bagian yang sudah sesuai:** SOS screen dan navigasi dasar.
- **Bagian yang belum sesuai:** Aksesibilitas SOS dari layar utama belum mencolok; ikon kecil di AppBar kurang menonjol untuk kondisi darurat.
- **Bukti:** `lib/fitur/dashboard/screens/dashboard_screen.dart`, `lib/fitur/sos_craving/screens/sos_craving_screen.dart`, `lib/lainnya_screen.dart`.

## 9. Ruang Lingkup

- **Termasuk:** Penambahan kartu SOS yang menonjol pada Dashboard (bukan di posisi paling atas daftar), dengan navigasi ke `SosCravingScreen`, penanganan error navigasi, dan tooltip/label yang jelas.
- **Tidak termasuk:** Tombol aksi mengambang (FAB), perubahan isi/fitur `SosCravingScreen`, penambahan tab navigasi baru, widget beranda, dan integrasi notifikasi.

## 10. Alur Penggunaan

1. Pengguna membuka Dashboard (layar utama).
2. Pengguna melihat kartu SOS yang menonjol (bukan di posisi paling atas daftar; misalnya setelah kartu "Lama berhenti merokok" atau setelah kartu progres).
3. Pengguna menekan kartu SOS.
4. Aplikasi menavigasi ke `SosCravingScreen`.
5. Pengguna memilih strategi koping (napas, timer, distraksi).
6. Jika navigasi gagal, error dicatat melalui `L.e` dan pengguna tetap di Dashboard.

## 11. Persyaratan Fungsional

1. Dashboard menampilkan kartu SOS yang menonjol dengan ikon `Icons.sos`, judul "SOS Craving", dan deskripsi singkat.
2. Menekan kartu SOS membuka `SosCravingScreen` dalam satu ketukan.
3. Navigasi menggunakan `Nav.to` dengan penanganan error (`unawaited` + `.catchError`).
4. Kartu SOS tidak ditempatkan di posisi paling atas daftar.
5. Kartu SOS hanya muncul pada kondisi data Dashboard valid (bukan loading/error).
6. Entri SOS di `LainnyaScreen` tetap tersedia sebagai akses sekunder (opsional).

## 12. Persyaratan Nonfungsional

- **Performa:** Tidak menambah beban rendering yang signifikan (kartu statis, tanpa timer).
- **Keamanan:** Tidak menyimpan data sensitif.
- **Keandalan:** Navigasi gagal ditangani tanpa crash.
- **Kemudahan penggunaan:** Area sentuh minimal 48x48 dp; label/tooltip jelas; konsisten dengan tema terang/gelap.

## 13. File yang Terdampak

### File yang sudah menangani fitur

- `lib/fitur/dashboard/screens/dashboard_screen.dart` — Dashboard dengan ikon SOS di AppBar (baris 88-101).
- `lib/fitur/sos_craving/screens/sos_craving_screen.dart` — Layar SOS Craving (tujuan navigasi).
- `lib/lainnya_screen.dart` — Entri SOS Craving (baris 28-31).

### File yang perlu diubah

- `lib/fitur/dashboard/screens/dashboard_screen.dart` — Tambah kartu SOS yang menonjol (bukan di posisi paling atas daftar); navigasi ke `SosCravingScreen`.

### File baru yang mungkin diperlukan

- Tidak ada (menggunakan komponen yang sudah tersedia).

## 14. Gambaran Teknis

Pendekatan: tambahkan `Card` dengan `InkWell` pada `ListView` Dashboard (setelah kartu "Lama berhenti merokok" atau setelah kartu progres), dengan navigasi aman.

### Contoh 1 — Kartu SOS pada Dashboard

**Path:** `lib/fitur/dashboard/screens/dashboard_screen.dart`

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

**Tujuan:** Menampilkan pintasan SOS yang menonjol dan mudah dijangkau pada layar utama tanpa FAB.

**Hubungan:** Menggunakan `SosCravingScreen` (tujuan navigasi), `Nav` (navigasi), dan `L` (logging).

### Contoh 2 — Navigasi dengan Penanganan Error

**Path:** `lib/fitur/dashboard/screens/dashboard_screen.dart`

```dart
onTap: () => unawaited(
  Nav.to(context, const SosCravingScreen()).catchError((
    Object e,
    StackTrace s,
  ) {
    L.e('Gagal navigasi ke SOS Craving: $e $s');
    return null;
  }),
),
```

**Tujuan:** Memastikan kegagalan navigasi dicatat dan tidak menjadi unhandled error.

**Hubungan:** Konsisten dengan pola navigasi proyek.

## 15. Kriteria Penerimaan

1. Kartu SOS tampil pada Dashboard pada kondisi data valid.
2. Kartu SOS tidak berada di posisi paling atas daftar.
3. Menekan kartu SOS membuka `SosCravingScreen` dalam satu ketukan.
4. Navigasi gagal tidak menyebabkan crash dan dicatat melalui `L.e`.
5. Kartu SOS memiliki label/tooltip dan area sentuh minimal 48x48 dp.
6. Tampilan konsisten pada tema terang dan gelap.
7. `flutter analyze` tidak menemukan error baru.

## 16. Risiko dan Ketergantungan

- **Risiko:** Penempatan kartu dapat memengaruhi alur visual Dashboard; perlu penyesuaian padding/spacing.
- **Ketergantungan:** Bergantung pada `SosCravingScreen` yang sudah ada; tidak membutuhkan dependensi baru.

## 17. Keputusan dan Hal yang Belum Ditentukan

- **Keputusan yang sudah disetujui:** Tidak menggunakan FAB; menggunakan kartu SOS; tidak di posisi paling atas daftar.
- **Rekomendasi yang belum disetujui:** Penempatan pasti kartu SOS (setelah kartu "Lama berhenti merokok" vs setelah kartu progres); keputusan pengguna diperlukan.
- **Asumsi yang belum diverifikasi:** Efektivitas visual kartu SOS pada tema gelap.
- **Pertanyaan yang memerlukan keputusan pengguna:** Penempatan pasti kartu SOS pada Dashboard.

## 18. Riwayat Perubahan PRD

- 2026-11-08: Draft awal dibuat berdasarkan diskusi entri `refrensi_apk.md:L22-L32`.
- 2026-11-08: Diperbarui: tidak menggunakan FAB, menggunakan kartu SOS.
- 2026-11-08: Diperbarui: kartu SOS tidak ditempatkan di posisi paling atas daftar.
- 2026-11-08: Diperbarui: struktur PRD dilengkapi sesuai format command.
