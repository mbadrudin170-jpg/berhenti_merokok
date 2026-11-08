# PRD: Pelacakan Toxin yang Dihindari

Status: DRAFT
Terakhir diperbarui: 2026-11-08

## 1. Referensi
- Sumber: `refrensi_apk.md` baris 86–96 (entri "#### 7. Pelacakan Toxin yang Dihindari", bagian A. Rekomendasi Fitur Baru, Prioritas Rendah)
- Link aplikasi referensi: https://play.google.com/store/apps/details?id=com.lastcig.app
- Ringkasan gambaran dari referensi: LastCig (VictorExplore) menampilkan "TOXIN TRACKING" — daftar zat yang dihindari oleh tubuh karena tidak merokok dan zat yang masih dikonsumsi jika pengguna merokok, dengan catatan "Real data, not scare tactics". Data diperoleh dari WHO, CDC, AHA, dan ACS. Semua data tersimpan secara lokal di perangkat (100% private, tanpa akun). Fitur ini menjadi bagian dari analisis kesehatan yang lebih luas (recovery body systems, milestone, money saved, life regained). Tidak ada detail visual (posisi, warna, daftar zat spesifik) yang dapat diverifikasi dari halaman Play Store.

## 2. Latar Belakang dan Tujuan
Pengguna aplikasi Berhenti Merokok saat ini hanya melihat jumlah rokok tidak dihisap dan uang yang dihemat. Belum ada informasi mengenai zat berbahaya (mis. tar, nikotin, karbon monoksida) yang dihindari tubuh seiring bertambahnya hari smoke-free. Tujuan fitur ini adalah membuat progres kesehatan menjadi lebih konkret dan memotivasi dengan menampilkan daftar toxin yang dihindari, dengan data lokal dan tidak menghakimi (no guilt), selaras dengan nuansa referensi LastCig.

## 3. Status Implementasi Saat Ini
BELUM. Tidak ditemukan implementasi pelacakan toxin di `lib/` (pemeriksaan kata kunci `toxin`, `zat berbahaya`, `karbon monoksida`, `nikotin` tidak menemukan fitur ini; hanya ada penyebutan karbon monoksida pada deskripsi milestone kesehatan di `lib/shared/konstanta/milestone_kesehatan.dart:26`, bukan fitus pelacakan toxin terpisah). Tidak ada PRD lain yang mencakup fitur ini.

## 4. Ruang Lingkup
### Termasuk
- Layar baru (tidak mengubah layar existing) yang menampilkan daftar toxin yang dihindari berdasarkan jumlah rokok tidak dihisap dari biodata.
- Perhitungan murni (helper tanpa `BuildContext`/provider) yang menghasilkan daftar toxin + kuantitas yang dihindari, dengan guard pembagian/nol dan nilai valid.
- Tampilan kondisi kosong (belum ada biodata / belum berhenti / rokok tidak dihisap = 0) dengan informasi dan call-to-action yang jelas.
- Bahasa Indonesia formal, tema aplikasi, `SafeArea`, padding tepi layar via parent, `ValueKey` stabil jika ada daftar.
- Logging `L` pada titik non-frekuensi tinggi (helper, inisialisasi layar).

### Tidak Termasuk
- Penyimpanan data toxin baru ke SQLite (tidak ada migrasi DB, tidak ada tabel baru).
- Input pengguna untuk menambah/mengubah daftar toxin.
- Grafik/chart (bukan ruang lingkup; hanya daftar teks/ikon).
- Data toxin yang diambil dari jaringan/API (seluruh data statis/lokal).
- Integrasi dengan notifikasi, badge, kalender, dashboard, atau fitur lain.
- Klaim medis/kesehatan tanpa sumber yang disepakati (data difaktorkan sebagai perkiraan/contoh illustratif, dengan catatan sumber).

## 5. User Story
- Sebagai pengguna yang berhenti merokok, saya ingin melihat daftar zat berbahaya yang telah saya hindari, agar saya tahu manfaat kesehatan konkret dari tidak merokok.
- Sebagai pengguna baru yang belum memiliki biodata, saya ingin diberi informasi bahwa data toxin akan tersedia setelah saya mengisi biodata dan menetapkan tanggal berhenti.

## 6. Alur dan Perilaku
1. Pengguna membuka layar Pelacakan Toxin melalui entri baru di Menu Lainnya (`lainnya_screen.dart`).
2. Sistem memuat biodata (`biodataProvider`).
   - Jika loading → tampilkan indikator loading.
   - Jika error → tampilkan pesan error + tombol retry (`ref.refresh(biodataProvider)`).
   - Jika biodata null → tampilkan empty state + call-to-action isi biodata.
   - Jika `tanggalMulaiBerhentiMerokok` null → tampilkan informasi bahwa tanggal berhenti belum ditetapkan + call-to-action.
3. Jika data lengkap:
   - Hitung `rokokTidakDiHisap` dari `BiodataModelPerhitungan` (sumber terpusat, tidak duplikasi inline).
   - Jika `rokokTidakDiHisap` = 0 → tampilkan empty state "Belum ada rokok yang dihindari" + call-to-action.
   - Jika > 0 → tampilkan daftar toxin yang dihindari (nama, jenis, kuantitas terhindari, catatan singkat), setiap item dengan `ValueKey` stabil.
4. Kondisi data tidak lengkap (biodata null) ditangani sebagai tampilan tersendiri, bukan crash.
5. Tidak ada `requireValue` sebelum `isLoading` dan `hasError` ditangani.

## 7. Kebutuhan Data
| Data | Sumber | Kolom / Atribut | Aturan akses |
|---|---|---|---|
| Biodata (rokok tidak dihisap, tanggal mulai berhenti) | `biodataProvider` / `BiodataModel` + `BiodataModelPerhitungan` | `jumlahRokokPerHari`, `hariBerhenti`, `rokokTidakDiHisap`, `tanggalMulaiBerhentiMerokok` | Baca-only via provider; tidak ada penulisan |
| Daftar toxin (referensi statis) | Helper murni baru (`lib/fitur/toxin_pelacakan/helper/`) | nama toxin, jenis zat, faktor per batang, efek singkat, sumber referensi | Statis, tidak disimpan DB |

Perhitungan kuantitas toxin yang dihindari = `rokokTidakDiHisap` × faktor per batang (helper murni, guard jika `rokokTidakDiHisap` = 0).

## 8. File Terdampak
| Path | Jenis (baru/ubah) | Keterangan |
|---|---|---|
| `lib/fitur/toxin_pelacakan/model/toxin_model.dart` | baru | Model Freezed `abstract class` untuk satu entri toxin (nama, jenis, faktor, efek, sumber) |
| `lib/fitur/toxin_pelacakan/state/toxin_pelacakan_state.dart` | baru | State Freezed `abstract class` (daftar toxin hasil perhitungan, status) |
| `lib/fitur/toxin_pelacakan/helper/toxin_hitung_helper.dart` | baru | Helper murni (konstruktor privat, metode statis) — perhitungan kuantitas toxin, guard nol, tanpa `BuildContext`/provider |
| `lib/fitur/toxin_pelacakan/screens/toxin_pelacakan_screen.dart` | baru | Layar daftar toxin, penanganan loading/error/kosong, navigasi CTA biodata |
| `lib/lainnya_screen.dart` | ubah | Entri navigasi baru ke layar Pelacakan Toxin di Menu Lainnya |
| `prd/pelacakan-toxin-yang-dihindari.md` | baru | Dokumen PRD ini |
| `refrensi_apk.md` | ubah (penanda saja) | Penanda "✅ PRD dibuat: prd/pelacakan-toxin-yang-dihindari.md" pada entri baris 86–96 |

## 9. Contoh Implementasi (ilustrasi)
```dart
// Helper murni tanpa BuildContext/provider (contoh ilustrasi, bukan file utuh).
class ToxinHitungHelper {
  const ToxinHitungHelper._();
  static List<ToxinItem> hitung(int rokokTidakDiHisap) {
    if (rokokTidakDiHisap <= 0) return const [];
    return daftarReferensi.toxin.map((t) {
      return t.salin(kuantitasDiHindari: t.faktorPerBatang * rokokTidakDiHisap);
    }).toList();
  }
}

// Penggunaan di layar (contoh ilustrasi).
final biodataAsync = ref.watch(biodataProvider);
if (biodataAsync.isLoading) {
  return const Center(child: CircularProgressIndicator());
}
if (biodataAsync.hasError) {
  return _ErrorRetry(onRetry: () => ref.refresh(biodataProvider));
}
final biodata = biodataAsync.requireValue;
final daftarToxin = ToxinHitungHelper.hitung(biodata.rokokTidakDiHisap);
```
Catatan: potongan di atas hanya ilustrasi pendekatan helper murni dan konsumsi getter `rokokTidakDiHisap` dari ekstensi `BiodataModelPerhitungan`; tidak merupakan perubahan pada file kode.

## 10. Kepatuhan terhadap docs/struktur_rules.md
- Struktur modul di `lib/fitur/<fitur>/` (model, state, screens, helper, notifier) sesuai `docs/struktur_rules.md`.
- Freezed `abstract class` untuk model dan state (boilerplate aturan optimasi).
- Helper murni tanpa `BuildContext`/provider (ekstraksi perhitungan turunan).
- Guard pembagian/nol pada perhitungan kuantitas toxin.
- Logging `L.i/w/e` (bukan `print`), hindari log di `build()`.
- Navigasi via `Nav` dari `core_shared`, bukan `Navigator` langsung.
- `SafeArea`, padding tepi layar di parent, `ValueKey` stabil, tema `textTheme`/`colorScheme` (optimasi_ui / optimasi_ux).
- Bahasa Indonesia formal untuk UI (optimasi_ux).
- Tidak mengubah file generated (`.g.dart`, `.freezed.dart`).
- Tidak menambah dependensi baru (data statis lokal).
- Tidak ada build APK; build dilakukan pengguna via GitHub Actions (aturan_build).

## 11. Kriteria Selesai
- [ ] Layar Pelacakan Toxin baru dapat dibuka tanpa crash.
- [ ] Loading ditampilkan saat biodata masih memuat; error + retry saat gagal.
- [ ] Biodata null / tanggal berhenti null → empty state informatif + CTA.
- [ ] `rokokTidakDiHisap` = 0 → empty state "belum ada rokok yang dihindari".
- [ ] Daftar toxin ditampilkan dengan kuantitas yang dihitung dari `biodata.rokokTidakDiHisap` (sumber `BiodataModelPerhitungan`, tidak duplikasi inline).
- [ ] Setiap item daftar memiliki `ValueKey` stabil.
- [ ] UI: `SafeArea`, padding tepi layar via parent, tema terang/gelap, bahasa Indonesia formal.
- [ ] Tidak ada file `.dart`, `pubspec.yaml`, atau konfigurasi yang diubah (hanya file PRD dan penanda referensi).
- [ ] File terdampak tidak tumpang tindih dengan PRD lain di `prd/`.

## 12. Risiko dan Pertanyaan Terbuka
- Daftar toxin spesifik dan faktor konversi per batang: ditetapkan sebagai daftar ilustratif di helper dengan catatan sumber (WHO/CDC/AHA/ACS sebagai landasan referensi umum, bukan klaim medis aplikasi); perlu verifikasi saat implementasi agar tidak menjadi klaim kesehatan yang tidak terbukti.
- Tidak ada notifier terpisah: cukup helper murni + `biodataProvider` langsung di layar karena tidak ada penyimpanan toxin baru (disetujui dalam diskusi).

## 13. Catatan Keputusan Diskusi
| pertanyaan | keputusan | tanggal |
|---|---|---|
| Lokasi tampilan | Layar baru terpisah (`toxin_pelacakan_screen.dart`), tidak mengubah layar existing | 2026-11-08 |
| Navigasi masuk | Entri baru di Menu Lainnya (`lainnya_screen.dart`) | 2026-11-08 |
| Sumber data toxin | Daftar statis di `toxin_hitung_helper.dart`, tanpa DB baru, tanpa input pengguna, ditandai perkiraan ilustratif | 2026-11-08 |
