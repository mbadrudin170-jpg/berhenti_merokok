# PRD: Optimasi Notifikasi (Pengingat Harian)

Status: FINAL
Terakhir diperbarui: 2026-11-08

## 1. Referensi
- Sumber: `refrensi_apk.md` baris 198-211
- Link aplikasi referensi: https://play.google.com/store/apps/details?id=com.h2m.util.quitsmoke ; https://www.quit-it-web.com/ ; https://stopsmokingapp.com/quit-smoking-daily-motivation-app
- Ringkasan gambaran dari referensi: Notifikasi harian terjadwal sudah tersedia (toggle, pemilih waktu, uji coba, penjadwalan ulang saat aplikasi dibuka). Peluang optimasi: (1) pengingat berbasis pola craving pengguna (berdasarkan diary craving) dan (2) check-in pagi. Aplikasi pembanding menampilkan morning check-in, pengingat pada jam craving tinggi, dan rencana notifikasi kustom. Keputusan: PRD mencakup keduanya (check-in pagi + pengingat pola craving) dengan kontrol terpisah; check-in pagi sebagai jadwal terpisah dengan waktu dapat diubah (default 07:00); pengingat pola craving menjadwalkan 1 jam teratas dengan minimum data dan fallback jelas; tap notifikasi membuka Home/Dashboard.

## 2. Latar Belakang dan Tujuan
Pengingat harian saat ini dikirim pada satu waktu tetap yang dipilih pengguna. Waktu tersebut belum menyesuaikan pola craving aktual pengguna dan belum menyediakan momen check-in pagi yang terstruktur. Tujuannya adalah meningkatkan relevansi notifikasi dengan menambahkan check-in pagi (jadwal terpisah, waktu dapat diubah) dan pengingat yang mempertimbangkan jam craving tertinggi dari Diary Craving (1 jam teratas, dengan fallback jika data belum cukup), sehingga pengguna mendapat dukungan pada waktu yang lebih tepat.

## 3. Status Implementasi Saat Ini
SEBAGIAN. Pengingat harian dasar sudah ada; pengingat berbasis pola craving dan check-in pagi belum ada.

Bukti:
- `lib/shared/notifikasi/notifikasi_service.dart:L1-L458` — inisialisasi plugin/zona waktu, izin, `jadwalkanPengingatHarian` (satu jadwal harian, `matchDateTimeComponents: DateTimeComponents.time`), `batalkanPengingatHarian`, `tampilkanSekarang`, preferensi via `SharedPreferences`, `jadwalkanUlangJikaAktif`, navigasi payload `pengingat_harian`.
- `lib/shared/helper/shared_keys.dart:L11-L18` — kunci `notifikasiHarian`, `notifikasiJam`, `notifikasiMenit`.
- `lib/fitur/pengaturan/screens/pengaturan_screen.dart:L22-L395` — UI toggle pengingat harian, pemilih waktu, uji coba notifikasi; platform Web/Linux/Windows disembunyikan.
- `lib/fitur/diary_craving/notifier/diary_craving_notifier.dart` — menyediakan data `listCraving` (tanggal/waktu, pemicu, intensitas) yang menjadi sumber pola jam craving (baca-only via provider/helper saat implementasi).

## 4. Ruang Lingkup
### Termasuk
- Check-in pagi: notifikasi harian terpisah dengan kontrol aktif/nonaktif sendiri, waktu dapat diubah, default 07:00. ID, payload, dan kategori notifikasi berbeda dari pengingat harian existing. Tap membuka Home/Dashboard.
- Pengingat pola craving: opsi terpisah untuk mengaktifkan pengingat pada 1 jam lokal paling sering dari Diary Craving. Aktif dijadwalkan hanya jika data cukup (minimum 3 entri diary craving); jika data kurang, tampilkan informasi jelas dan jangan jadwalkan otomatis. Dihitung ulang saat opsi diaktifkan dan saat aplikasi dibuka jika opsi aktif. Tap membuka Home/Dashboard.
- Pengingat harian existing tetap dipertahankan, perilakunya tidak diubah.
- UI pengaturan di `PengaturanScreen` untuk mengelola opsi baru (mengikuti pola loading/izin/error/rollback yang sudah ada).
- Penyimpanan preferensi lokal (`SharedPreferences`/`SharedKeys`) untuk status dan waktu opsi baru.
- Penjadwalan ulang saat aplikasi dibuka agar semua pengingat aktif yang memiliki izin tetap konsisten.
- Penanganan platform yang tidak mendukung penjadwalan terjadwal (Web/Linux/Windows) tetap konsisten dengan implementasi saat ini.

### Tidak Termasuk
- Notifikasi push dari server/backend.
- Analisis/visualisasi tren craving di UI Diary Craving (itu ruang lingkup PRD `analisis-pemicu-diary-craving.md`).
- Perubahan skema database SQLite / migrasi tabel.
- Widget layar beranda, AI coach, atau personalisasi berbasis cloud.
- Penambahan dependensi baru kecuali terbukti diperlukan dan disetujui.
- Menyalin teks/UX aplikasi referensi secara harfiah.

## 5. User Story
- Sebagai pengguna, saya ingin menerima check-in pagi, agar saya bisa memulai hari dengan komitmen smoke-free.
- Sebagai pengguna, saya ingin menerima pengingat pada jam yang sering saya mengalami craving, agar dukungan datang pada waktu yang lebih relevan.
- Sebagai pengguna, saya ingin mengaktifkan/menonaktifkan dan mengatur opsi notifikasi baru, agar notifikasi tetap sesuai preferensi saya.

## 6. Alur dan Perilaku
1. Pengguna membuka Pengaturan → bagian Notifikasi.
2. Sistem memuat preferensi notifikasi (pola existing: loading, error handling).
3. Pengguna melihat opsi terpisah: pengingat harian (existing), check-in pagi (baru), pengingat pola craving (baru).
4. **Check-in pagi:** jika pengguna mengaktifkan, sistem meminta izin jika perlu, menjadwalkan notifikasi harian pada waktu check-in pagi (default 07:00, dapat diubah), menyimpan preferensi; jika izin/penjadwalan gagal, state di-rollback dan toast error ditampilkan. Jika dinonaktifkan, jadwal dibatalkan dan preferensi diperbarui konsisten.
5. **Pengingat pola craving:** jika pengguna mengaktifkan, sistem membaca data Diary Craving (baca-only) dan menghitung 1 jam lokal paling sering. Jika entri < 3, simpan preferensi tetap aktif, tampilkan informasi "data craving belum cukup" dan jangan jadwalkan otomatis. Jika entri >= 3, sistem menjadwalkan 1 notifikasi harian pada jam teratas. Dihitung ulang saat opsi diaktifkan dan saat aplikasi dibuka jika opsi aktif (saat data sudah cukup, jadwal dibuat).
6. Saat aplikasi dibuka: mekanisme penjadwalan ulang memeriksa izin dan menjadwalkan ulang semua pengingat yang aktif (pengingat harian, check-in pagi, pola craving bila memenuhi syarat data/izin).
7. Saat notifikasi ditekan: payload dinavigasi ke Home/Dashboard (kategori dapat dibedakan secara internal; tujuan UI tetap Home/Dashboard).
8. Kondisi khusus: platform tidak didukung → bagian pengingat terjadwal disembunyikan (pola existing); izin dicabut → preferensi/jadwal dinonaktifkan konsisten; kegagalan penyimpanan/jadwal → rollback.

## 7. Kebutuhan Data
| Data | Sumber | Kunci/atribut (rencana) | Aturan akses |
|---|---|---|---|
| Status/waktu pengingat harian existing | `SharedPreferences` | `SharedKeys.notifikasiHarian/Jam/Menit` | Tetap; kompatibel mundur |
| Status/waktu check-in pagi | `SharedPreferences` | `SharedKeys` baru (mis. `notifikasiCheckinPagi`, `notifikasiCheckinPagiJam`, `notifikasiCheckinPagiMenit`) | Lokal; tidak sensitif |
| Status pengingat pola craving | `SharedPreferences` | `SharedKeys` baru (mis. `notifikasiPolaCraving`) | Lokal |
| Pola jam craving | data lokal Diary Craving | jam lokal dari `DiaryCravingModel.tanggal` | Baca-only; perhitungan murni/helper; tidak menulis DB |

Tidak ada tabel SQLite baru dan tidak ada migrasi skema.

## 8. File Terdampak
| Path | Jenis (baru/ubah) | Keterangan |
|---|---|---|
| `lib/shared/notifikasi/notifikasi_service.dart` | ubah | Tambah ID/kategori/jadwal untuk check-in pagi dan pengingat pola craving; method jadwal/batal/penjadwalan ulang; penanganan izin/rollback/payload; payload baru tetap navigasi ke Home/Dashboard. |
| `lib/shared/helper/shared_keys.dart` | ubah | Tambah kunci preferensi untuk check-in pagi (status/jam/menit) dan pengingat pola craving (status). |
| `lib/fitur/pengaturan/screens/pengaturan_screen.dart` | ubah | Tambah UI pengaturan check-in pagi (toggle + waktu, default 07:00) dan pengingat pola craving (toggle + info/fallback data belum cukup); pola async/izin/loading/toast/rollback. |
| `lib/fitur/diary_craving/helper/pola_craving_helper.dart` | baru | Helper murni untuk menghitung 1 jam craving teratas dari daftar diary; minimum data 3 entri; tanpa `BuildContext`/provider; guard data kosong. File baru; tidak bentrok dengan PRD `analisis-pemicu-diary-craving.md` (PRD tersebut hanya mengubah `lib/fitur/diary_craving/screens/diary_craving_screen.dart`). |
| `prd/optimasi-notifikasi-pengingat-harian.md` | baru/ubah | Dokumen PRD ini. |
| `refrensi_apk.md` | ubah (penanda saja) | Penanda "✅ PRD dibuat: prd/optimasi-notifikasi-pengingat-harian.md" pada entri baris 198-211. |

Catatan bentrok: tidak ada file di tabel ini yang tumpang tindih dengan PRD lain di `prd/` (dicek terhadap analisis-pemicu-diary-craving, optimasi-dashboard-ringkasan-progres, optimasi-pemulihan-kesehatan-milestone, pelacakan-toxin-yang-dihindari). `PengaturanScreen` dan `NotifikasiService` saat ini tidak disentuh PRD lain.

## 9. Contoh Implementasi (ilustrasi)
```dart
// Ilustrasi ID/payload terpisah (bukan perubahan file kode).
static const int _idCheckinPagi = 1003;
static const int _idPolaCraving = 1004;

static Future<void> jadwalkanCheckinPagi({
  required int jam,
  required int menit,
}) async {
  L.i('checkinPagi jam=$jam, menit=$menit');
  // cek platform, minta/cek izin, zonedSchedule + DateTimeComponents.time,
  // payload kategori=checkin_pagi&id=..., simpan preferensi dengan rollback.
}
```

```dart
// Ilustrasi helper murni pola craving.
class PolaCravingHelper {
  const PolaCravingHelper._();
  static const int minimumEntri = 3;

  /// Mengembalikan jam lokal (0-23) teratas, atau null jika data < minimum.
  static int? jamTeratas(List<DiaryCravingModel> daftar) {
    L.i('daftar.length=${daftar.length}');
    if (daftar.length < minimumEntri) return null;
    // hitung frekuensi per jam lokal, urutkan desc, ambil top 1.
    return 20; // contoh
  }
}
```

## 10. Kepatuhan terhadap docs/struktur_rules.md
- PRD mengikuti struktur folder/konvensi proyek: shared untuk notifikasi/kunci, helper murni di bawah `lib/fitur/*/helper/` jika dibuat.
- Logging wajib `L` (bukan `print`/`debugPrint`), hindari log berulang di `build()`; log titik eksekusi relevan.
- Navigasi menggunakan `Nav` dari `core_shared` jika ada navigasi baru; tap notifikasi existing/payload baru menavigasi ke Home/Dashboard.
- Penjadwalan notifikasi mengikuti aturan proyek: `flutter_local_notifications` v22.3.3, `timezone`/`tz`, payload `kategori`+`id`, ID numerik unik stabil, cek izin sebelum aktif, rollback preferensi/jadwal saat gagal, `UnsupportedError` untuk platform tidak didukung, `unawaited` Future dengan `.catchError` + `L.e`.
- Izin diminta saat pengguna mengaktifkan fitur (bukan saat app start).
- `SharedPreferences` hanya untuk preferensi non-sensitif; kunci terpusat di `SharedKeys`.
- UI: bahasa Indonesia formal, `SafeArea`/padding parent, tema `textTheme`/`colorScheme`, toast via `AppToast`, loading via `EasyLoading` dengan `catchError` pada `unawaited`.
- Tidak ada perubahan file `.dart`/`pubspec.yaml`/konfigurasi pada sesi PRD ini; contoh kode hanya ilustrasi dalam dokumen.

## 11. Kriteria Selesai
- [ ] Check-in pagi: jadwal terpisah (ID/kategori/payload berbeda), toggle terpisah, waktu dapat diubah, default 07:00, tap membuka Home/Dashboard.
- [ ] Pengingat pola craving: toggle terpisah, 1 jam teratas dari Diary Craving, minimum 3 entri, fallback "data belum cukup" tanpa jadwal otomatis, dihitung ulang saat diaktifkan dan saat app dibuka jika aktif, tap membuka Home/Dashboard.
- [ ] Pengingat harian existing tetap berfungsi dengan perilaku lama.
- [ ] Preferensi dan ID notifikasi baru unik, stabil, dan tidak menimpa jadwal existing.
- [ ] Izin diperiksa sebelum status aktif disimpan; rollback preferensi/jadwal konsisten saat gagal.
- [ ] Penjadwalan ulang saat app start mencakup semua pengingat aktif yang memenuhi syarat dan memiliki izin.
- [ ] Platform tidak didukung tetap ditangani tanpa crash.
- [ ] Tidak ada file `.dart`/`pubspec.yaml`/konfigurasi yang diubah pada sesi PRD ini; hanya PRD dan penanda `refrensi_apk.md`.

## 12. Risiko dan Pertanyaan Terbuka
- Risiko baterai/UX: terlalu banyak notifikasi dapat mengganggu pengguna; mitigasi: kontrol terpisah dan hanya 1 jadwal pola craving.
- Risiko data kosong/berubah: pola jam dapat bergeser; mitigasi: preferensi tetap aktif saat data belum cukup, perhitungan ulang saat aktivasi dan saat app dibuka.
- Risiko izin dicabut: mitigasi mengikuti pola existing (periksa izin, batalkan jadwal sistem, nonaktifkan preferensi konsisten).
- Referensi Play Store memberikan gambaran fitur, bukan spesifikasi teknis perilaku notifikasi pada app ini.

## 13. Catatan Keputusan Diskusi
| pertanyaan | keputusan | tanggal |
|---|---|---|
| Ruang lingkup optimasi notifikasi (refrensi_apk.md:L198-L211) | Keduanya: check-in pagi + pengingat pola craving, dengan kontrol terpisah; pengingat harian existing tetap dipertahankan | 2026-11-08 |
| Perilaku check-in pagi | Jadwal terpisah, waktu dapat diubah; default 07:00; ID/payload/kategori berbeda; tidak mengubah pengingat harian existing | 2026-11-08 |
| Pengingat pola craving | 1 jam lokal teratas; minimum 3 entri; jika data kurang tampilkan info dan jangan jadwalkan otomatis; dihitung ulang saat opsi diaktifkan dan saat app dibuka jika aktif | 2026-11-08 |
| Navigasi tap notifikasi | Ke Home/Dashboard (konsisten dengan existing) | 2026-11-08 |
| Toggle pola craving saat data < 3 entri | Toggle/preferensi tetap aktif, tunggu data; saat app dibuka/aktivasi berikutnya dan data sudah >=3, sistem menjadwalkan | 2026-11-08 |
| Path helper pola craving | `lib/fitur/diary_craving/helper/pola_craving_helper.dart` (file baru, dekat data diary, aman dari bentrok PRD lain) | 2026-11-08 |
