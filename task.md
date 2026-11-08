# Kelompok 1

## File terdampak

- [dashboard_screen.dart](lib/fitur/dashboard/screens/dashboard_screen.dart)
- [impian_screen.dart](lib/fitur/impian/screens/impian_screen.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

# Kelompok 2

## File terdampak

- [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- [main.dart](lib/main.dart)
- [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart)
- [notifikasi_service_test.dart](test/notifikasi_service_test.dart)

## Tinggi

## Sedang

#### Task 1

- Status: Selesai
- Masalah: Audit pengujian notifikasi (2026-11-08) menunjukkan file pengujian preferensi `test/notifikasi_service_test.dart` telah tersedia dan lulus (`flutter test test/notifikasi_service_test.dart`: 7 pengujian lulus). Cakupan yang sudah teruji: nilai default aktif/jam/menit, penyimpanan `setAktif` dan `setWaktu`, serta persistensi ke `SharedPreferences`. Namun skenario yang lebih luas (izin diberikan/ditolak, aktivasi/nonaktif pengingat, perubahan waktu, kegagalan penjadwalan dan penyimpanan preferensi, penjadwalan ulang saat aplikasi dibuka, platform yang tidak mendukung notifikasi terjadwal, pemulihan jadwal setelah restart) belum tercakup. `NotifikasiService` menggunakan anggota statis dan bergantung pada plugin platform (`FlutterLocalNotificationsPlugin`) serta `SharedPreferences`, sehingga memerlukan mock/fake pada batas plugin/penyimpanan sebelum dapat diuji secara bermakna. `flutter analyze` bersih (No issues found).
- Solusi: Evaluasi pengujian untuk izin diberikan/ditolak, mengaktifkan/menonaktifkan pengingat, mengubah waktu, kegagalan penjadwalan dan penyimpanan preferensi, penjadwalan ulang saat aplikasi dibuka, platform yang tidak mendukung notifikasi terjadwal, dan pemulihan jadwal setelah perangkat restart. Gunakan mock atau fake pada batas plugin dan penyimpanan. Jangan menyimpulkan seluruh proyek belum memiliki pengujian hanya karena commit ini tidak menyertakan file pengujian.
- Aturan dilanggar: [aturan_testing.md](.agents/rules/global/aturan_testing.md)
- File bermasalah: [notifikasi_service.dart](lib/shared/notifikasi/notifikasi_service.dart), [pengaturan_screen.dart](lib/fitur/pengaturan/screens/pengaturan_screen.dart)
- Prompt: buatkan file test nya

## Rendah

---

# Kelompok 3

## File terdampak

- [home.dart](lib/home.dart)

## Tinggi

Tidak ada temuan.

## Sedang

## Rendah

Tidak ada temuan.

# Kelompok 4

## File terdampak

- [mode_berhenti.dart](lib/fitur/biodata/enum/mode_berhenti.dart)
- [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart)
- [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart)
- [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart)
- [sqflite.dart](lib/shared/db/sqflite/sqflite.dart)
- [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart)

## Tinggi

Tidak ada temuan.

## Sedang

#### Task 1

- Status: Selesai
- Masalah: Pada `biodata_screen.dart` (commit `ceacc6a`), field nullable `tanggalMulaiTapering` dari `BiodataModel` diakses dengan operator `!` setelah pemeriksaan null (`biodata.tanggalMulaiTapering!`) tanpa disalin terlebih dahulu ke variabel lokal, sehingga type promotion tidak berlaku. Aturan type promotion mewajibkan field nullable objek model disalin ke variabel lokal sebelum null-check. Lokasi: `lib/fitur/biodata/screens/biodata_screen.dart` baris 149.
- Solusi: Salin `biodata.tanggalMulaiTapering` ke variabel lokal (mis. `final tanggalMulaiTapering = biodata?.tanggalMulaiTapering;`) bersama variabel lokal lain, lalu gunakan variabel lokal tersebut pada percabangan dan pemanggilan `FormatTanggal.formatDasar(tanggalMulaiTapering)`.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md) (Type Promotion untuk Null Safety (Field Objek)); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md) (Type Promotion untuk Null Safety pada Biodata Screen)
- File bermasalah: [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart#L149)
- Prompt:

## Rendah

#### Task 1

- Status: Selesai
- Masalah: Kode baru fitur tapering (commit `ceacc6a`) pada enum `ModeBerhenti`, field model `BiodataModel`, migrasi skema v6, form biodata, dan layar biodata tidak menambahkan log debug pada variabel/parameter baru, padahal aturan penambahan log mewajibkan pencatatan variabel relevan setelah mendapatkan nilai. Sumber: `lib/fitur/biodata/...` dan `lib/shared/db/sqflite/sqflite.dart`.
- Solusi: Tambahkan log singkat menggunakan `L.*` pada titik yang tidak berfrekuensi tinggi (method helper, perhitungan, initState) untuk variabel baru, tanpa mengubah logika bisnis.
- Aturan dilanggar: [aturan_bersama.md](.agents/rules/global/aturan_bersama.md) (Penambahan Log Debug pada Variabel dan Parameter); [aturan_khusus.md](.agents/rules/proyek/aturan_khusus.md) (Penambahan Log Debug pada Variabel dan Parameter)
- File bermasalah: [mode_berhenti.dart](lib/fitur/biodata/enum/mode_berhenti.dart), [biodata_model.dart](lib/fitur/biodata/model/biodata_model.dart), [biodata_screen.dart](lib/fitur/biodata/screens/biodata_screen.dart), [form_biodata.dart](lib/fitur/biodata/screens/form_biodata.dart), [sqflite.dart](lib/shared/db/sqflite/sqflite.dart), [nama_kolom.dart](lib/shared/konstanta/nama_kolom.dart)
- Prompt:
