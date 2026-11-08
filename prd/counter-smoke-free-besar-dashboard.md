# PRD: Counter Smoke-Free Besar pada Dashboard

Status: FINAL
Terakhir diperbarui: 2026-11-08

## 1. Referensi
- Sumber: `refrensi_apk.md` baris 279–291 (entri "#### 2. Counter Smoke-Free Besar pada Dashboard", bagian C. Rekomendasi UI, UX, dan Layout, Prioritas Sedang)
- Link aplikasi referensi: https://play.google.com/store/apps/details?id=com.EAGINsoftware.dejaloYa ; https://play.google.com/store/apps/details?id=com.lastcig.app ; https://quittracker.app/
- Ringkasan gambaran dari referensi: Aplikasi kompetitor (QuitNow, LastCig, Quit Tracker) menampilkan counter smoke-free berupa angka besar (hari/jam) di bagian atas layar, sehingga informasi utama terlihat segera saat aplikasi dibuka. Kondisi pada proyek: Dashboard menampilkan metrik dalam kartu, termasuk "Lama berhenti merokok" di kartu pertama, tetapi counter besar belum menonjol. Saran: Tampilkan counter smoke-free (hari, jam) dengan ukuran besar di bagian atas Dashboard.

## 2. Latar Belakang dan Tujuan
Pengguna saat ini membuka aplikasi untuk melihat progres smoke-free, tetapi counter durasi berhenti ada di dalam kartu pertama dengan ukuran teks standar dan belum sepenuhnya menonjol. Tujuan fitur ini adalah menambahkan counter smoke-free (hari dan jam) dengan ukuran besar di bagian atas Dashboard agar progres utama terlihat segera dan meningkatkan motivasi pengguna, tanpa mengubah logika perhitungan yang sudah ada.

## 3. Status Implementasi Saat Ini
SEBAGIAN ada.
Bukti:
- `lib/fitur/dashboard/screens/dashboard_screen.dart:L116-L142` — Kartu pertama "Lama berhenti merokok" menampilkan durasi melalui widget `_DurasiBerhenti` (baris 688–724) yang menampilkan hari/jam/menit/detik dengan `headlineMedium`, dan tanggal mulai melalui `FormatTanggal.formatDasar`.
- `lib/fitur/dashboard/screens/dashboard_screen.dart:L159-L200` — Kartu "Target Smoke-Free" menampilkan target dan progres hari.
- Perhitungan durasi menggunakan `biodata.hariBerhenti` dari ekstensi `BiodataModelPerhitungan` (tidak ada duplikasi inline).

Belum ada: counter smoke-free dengan ukuran besar yang menonjol di bagian atas layar, terpisah atau menggantikan penampilan durasi saat ini.

## 4. Ruang Lingkup
### Termasuk
- Tambah counter smoke-free besar (hari + jam) di bagian atas Dashboard, sebagai tambahan terpisah di atas kartu "Lama berhenti merokok" existing (tidak mengubah kartu existing).
- Counter menampilkan nilai dari `biodata.hariBerhenti` (hari) dan selisih jam (dihasilkan dari `DateTime.now()` dan `tanggalMulaiBerhentiMerokok`, dengan normalisasi tanggal dan klamping negatif ke 0 sesuai aturan proyek).
- Counter tetap terlihat saat `tanggalBerhenti` null dengan nilai "0 hari 0 jam".
- Ikuti pola UI proyek: `Theme.of(context).textTheme`, `SafeArea`, padding tepi layar via parent, bahasa Indonesia formal, logging `L` pada titik non-frekuensi tinggi.
- Tidak ada perubahan skema database, tidak ada dependensi baru, tidak ada perubahan notifier/model.

### Tidak Termasuk
- Mengubah logika perhitungan `hariBerhenti` yang sudah ada (pakai getter dari ekstensi).
- Menambahkan grafik/chart atau dependensi baru.
- Mengubah kartu "Lama berhenti merokok" existing (counter besar adalah tambahan terpisah di atasnya).
- Counter layar beranda/home widget (ruang lingkup fitur lain).

## 5. User Story
- Sebagai pengguna, saya ingin melihat counter smoke-free (hari dan jam) dengan ukuran besar di bagian atas Dashboard, agar saya tahu progres utama segera saat membuka aplikasi.
- Sebagai pengguna yang belum menetapkan tanggal berhenti, saya ingin diberi informasi bahwa counter akan tersedia setelah tanggal berhenti diatur.

## 6. Alur dan Perilaku
1. Pengguna membuka Dashboard.
2. Sistem memuat biodata (`biodataProvider`).
3. Jika loading → tampilkan indikator loading (perilaku existing, tidak berubah).
4. Jika error → tampilkan pesan error + tombol retry (`ref.refresh(biodataProvider)`) (perilaku existing, tidak berubah).
5. Jika biodata null → tampilkan halaman biodata kosong dengan CTA isi biodata (perilaku existing, tidak berubah).
6. Jika data lengkap:
   - Tampilkan counter besar (hari + jam) sebagai tambahan terpisah di bagian atas ListView, sebelum kartu pertama ("Lama berhenti merokok"). Kartu existing tidak diubah.
   - Jika `tanggalBerhenti` null → counter menampilkan "0 hari 0 jam" dan tidak menghalangi tampilan kartu lain.
   - Jika `tanggalBerhenti` tidak null → counter menampilkan `hariBerhenti` hari dan sisa jam dari selisih waktu (dinormalisasi, clamp >= 0).
7. Counter diperbarui melalui widget terisolasi (StatefulWidget dengan Timer per detik, dibatalkan di dispose) agar tidak memicu rebuild seluruh halaman.

## 7. Kebutuhan Data
| Data | Sumber | Kolom / Atribut | Aturan akses |
|---|---|---|---|
| Hari berhenti | `biodataProvider` / `BiodataModel` + `BiodataModelPerhitungan` | `hariBerhenti`, `tanggalMulaiBerhentiMerokok` | Baca-only via provider; tidak ada penulisan |
| Selisih jam | `DateTime.now()` vs `tanggalMulaiBerhentiMerokok` (dinormalisasi) | hitungan murni di widget terisolasi | Tidak disimpan DB |

Perhitungan turunan (`hariBerhenti`) wajib menggunakan getter dari ekstensi `BiodataModelPerhitungan`, tidak duplikasi inline.

## 8. File Terdampak
| Path | Jenis (baru/ubah) | Keterangan |
|---|---|---|
| `lib/fitur/dashboard/screens/dashboard_screen.dart` | ubah | Tambah widget counter smoke-free besar di bagian atas ListView (sebelum kartu pertama), gunakan widget terisolasi dengan Timer per detik. |
| `prd/counter-smoke-free-besar-dashboard.md` | baru | Dokumen PRD ini. |
| `refrensi_apk.md` | ubah (penanda saja) | Penanda "✅ PRD dibuat: prd/counter-smoke-free-besar-dashboard.md" pada entri baris 279–291. |

Catatan bentrok: tidak ada file di tabel ini yang tumpang tindih dengan PRD lain di `prd/` (dicek terhadap analisis-pemicu-diary-craving, optimasi-notifikasi-pengingat-harian, optimasi-pemulihan-kesehatan-milestone, pelacakan-toxin-yang-dihindari). `dashboard_screen.dart` tidak disentuh PRD lain.

## 9. Contoh Implementasi (ilustrasi)
```dart
// Widget terisolasi untuk counter besar (hanya widget ini rebuild per detik).
class _CounterSmokeFreeBesar extends StatefulWidget {
  const _CounterSmokeFreeBesar({required this.hariBerhenti, required this.jamSisa});
  final int hariBerhenti;
  final int jamSisa;

  @override
  State<_CounterSmokeFreeBesar> createState() => _CounterSmokeFreeBesarState();
}

class _CounterSmokeFreeBesarState extends State<_CounterSmokeFreeBesar> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${widget.hariBerhenti} hari ${widget.jamSisa} jam',
      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
```

```dart
// Konsumsi di DashboardScreen (bagian atas ListView, sebelum kartu pertama).
final hariBerhenti = biodata.hariBerhenti;
final jamSisa = ...; // selisih jam dari tanggalMulaiBerhentiMerokok, dinormalisasi, clamp >= 0
L.i('hariBerhenti=$hariBerhenti, jamSisa=$jamSisa');
// Tampilkan _CounterSmokeFreeBesar(hariBerhenti: hariBerhenti, jamSisa: jamSisa)
```

Catatan: potongan di atas hanya ilustrasi pendekatan; bukan perubahan pada file kode.

## 10. Kepatuhan terhadap docs/struktur_rules.md
- Struktur modul di `lib/fitur/dashboard/screens/` sesuai `docs/struktur_rules.md`.
- Tidak mengubah file generated (`.g.dart`, `.freezed.dart`).
- Tidak menambah dependensi baru (data dari `biodataProvider` yang sudah ada).
- Perhitungan turunan (`hariBerhenti`) menggunakan ekstensi `BiodataModelPerhitungan`, tidak duplikasi inline (aturan ekstraksi perhitungan turunan).
- Normalisasi tanggal + klamping negatif ke 0 sesuai aturan normalisasi tanggal.
- Widget timer diisolasi ke `StatefulWidget` terpisah, `Timer` dibatalkan di `dispose`, `mounted` dicek sebelum `setState` (aturan isolasi timer).
- Logging `L.i/w/e` (bukan `print`), hindari log di `build()` (aturan logging).
- Navigasi tidak diperlukan di bagian ini (`Nav` tidak dipakai untuk counter itu sendiri).
- `SafeArea`, padding tepi layar via parent, tema `textTheme`/`colorScheme` (optimasi_ui / optimasi_ux).
- Bahasa Indonesia formal untuk UI (optimasi_ux).
- Tidak ada build APK; build dilakukan pengguna via GitHub Actions (aturan_build).

## 11. Kriteria Selesai
- [ ] Counter smoke-free besar (hari + jam) ditampilkan di bagian atas Dashboard, sebelum kartu pertama.
- [ ] Counter menggunakan `biodata.hariBerhenti` dari ekstensi `BiodataModelPerhitungan` (tidak duplikasi inline).
- [ ] Counter tetap berfungsi (placeholder/nilai 0) saat `tanggalBerhenti` null.
- [ ] Nilai durasi negatif diklam ke 0 (tidak menampilkan nilai negatif).
- [ ] Widget counter diisolasi (StatefulWidget terpisah), Timer dibatalkan di `dispose`, `mounted` dicek sebelum `setState`.
- [ ] UI: `SafeArea`, padding tepi layar via parent, tema terang/gelap, bahasa Indonesia formal.
- [ ] Loading/error/biodata-null state existing tidak regresi.
- [ ] Tidak ada file `.dart`, `pubspec.yaml`, atau konfigurasi yang diubah (hanya file PRD dan penanda referensi).
- [ ] File terdampak tidak tumpang tindih dengan PRD lain di `prd/`.

## 12. Risiko dan Pertanyaan Terbuka
- Semua keputusan sudah final (lihat bagian 13). Tidak ada pertanyaan terbuka yang menghambat finalisasi.
- Risiko baterai/UX: Timer per detik pada widget terisolasi hanya membangun ulang widget counter, bukan seluruh halaman, sehingga dampak performa minimal. `Timer` dibatalkan di `dispose` dan `mounted` dicek sebelum `setState`.

## 13. Catatan Keputusan Diskusi
| pertanyaan | keputusan | tanggal |
|---|---|---|
| Isi counter | Hari + jam ('X hari Y jam') | 2026-11-08 |
| Posisi counter | Tambahan terpisah di bagian atas ListView, sebelum kartu 'Lama berhenti merokok' existing (kartu existing tidak diubah) | 2026-11-08 |
| Tampilan saat tanggalBerhenti null | Tetap terlihat dengan nilai '0 hari 0 jam' | 2026-11-08 |
| Ukuran teks counter | `displayMedium` dengan `fontWeight: FontWeight.bold` (lebih besar dari teks kartu existing agar menonjol) | 2026-11-08 |
