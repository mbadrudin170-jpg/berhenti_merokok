# PRD: Analisis Pemicu Diary Craving

## 1. Referensi

- Sumber: `refrensi_apk.md` baris 198-211
- Link aplikasi referensi: https://play.google.com/store/apps/details?id=com.portablepixels.smokefree ; https://play.google.com/store/apps/details?id=com.quititapp ; https://play.google.com/store/apps/details?id=com.herzberg.easyquitsmoking
- Ringkasan gambaran dari referensi: Diary Craving sudah ada (daftar, form, empty state, enum pemicu), namun belum ada analisis pemicu/insight (pie chart/ringkasan pemicu teratas/tren mingguan). Aplikasi pembanding menampilkan ringkasan pemicu untuk membantu mengenali pola.

## 2. Latar Belakang dan Tujuan

Fitur Diary Craving saat ini hanya mencatat daftar craving dan pemicunya. Pengguna kesulitan melihat pola pemicu mana yang paling sering muncul. Tujuannya adalah menambahkan analisis pemicu (ringkasan pemicu teratas, jumlah per pemicu) pada layar Diary Craving untuk membantu pengguna mengenali pola dan merencanakan strategi koping.

## 3. Status Implementasi Saat Ini

BELUM - Hanya pencatatan daftar/form/empty state dan enum pemicu yang ada. Tidak ditemukan analisis/insight pemicu di kode.

Bukti:

- `lib/fitur/diary_craving/screens/diary_craving_screen.dart`
- `lib/fitur/diary_craving/screens/form_diary_craving.dart`
- `lib/fitur/diary_craving/enum/pemicu_enum.dart`
- `lib/fitur/diary_craving/notifier/diary_craving_notifier.dart`
- `lib/fitur/diary_craving/model/diary_craving_model.dart`

## 4. Ruang Lingkup

### Termasuk

- Tambah ringkasan analisis pemicu di layar Diary Craving (pemicu teratas + jumlah)
- Gunakan data dari `DiaryCravingState.listCraving` yang sudah ada
- Tampilkan hanya jika ada data; tetap pertahankan empty state saat kosong
- Ikuti pola UI proyek (tema, textTheme, SafeArea, padding)

### Tidak Termasuk

- Grafik kompleks (pie chart) yang memerlukan dependensi baru
- Tren mingguan/bulanan detail
- Perubahan skema DB/model
- Notifikasi berbasis pola

## 5. User Story

- Sebagai pengguna, saya ingin melihat pemicu mana yang paling sering muncul, agar saya bisa mengenali pola dan menyiapkan strategi koping.
- Sebagai pengguna, saya ingin melihat ringkasan pemicu di layar Diary Craving, agar tidak perlu menghitung manual.

## 6. Alur dan Perilaku

1. Pengguna membuka layar Diary Craving
2. Jika loading → tampilkan indikator loading
3. Jika error → tampilkan pesan error + tombol retry (`ref.refresh(diaryCravingProvider)`)
4. Jika kosong → tampilkan empty state (tetap)
5. Jika ada data → tampilkan ringkasan pemicu teratas (3 pemicu) di atas daftar, langsung terlihat (bukan collapsible). Jika ada pemicu di luar top 3, tampilkan label "Lainnya" + jumlah sisa.
6. Ringkasan hanya berbasis data lokal yang sudah ada

## 7. Kebutuhan Data

Data lokal via `DiaryCravingModel` yang sudah ada (memiliki `pemicu`, `tanggal`, dll). Tidak perlu skema baru.

## 8. File Terdampak

| Path                                                        | Jenis (baru/ubah) | Keterangan                              |
| ----------------------------------------------------------- | ----------------- | --------------------------------------- |
| `lib/fitur/diary_craving/screens/diary_craving_screen.dart` | ubah              | Tambah bagian ringkasan analisis pemicu |

## 9. Contoh Implementasi (ilustrasi)

```dart
// Hitung frekuensi pemicu
final Map<PemicuCravingEnum, int> freq = {};
for (final c in state.listCraving) {
  freq[c.pemicu] = (freq[c.pemicu] ?? 0) + 1;
}
// Urutkan dan tampilkan top N
```

Mengikuti pola `L` untuk logging jika diperlukan, `Nav` tidak diperlukan di bagian ini.

## 10. Kepatuhan terhadap docs/struktur_rules.md

- Mengikuti struktur fitur di `lib/fitur/<fitur>/` (screens/state/notifier/model/enum)
- Menggunakan pola async state (loading/error/data) sesuai aturan
- Menggunakan `theme.textTheme`, `SafeArea`, padding sesuai `optimasi_ui.md`
- Tidak mengubah generated files
- Tidak menambah dependensi baru
- Menggunakan bahasa Indonesia formal untuk UI

## 11. Kriteria Selesai

- [ ] Ringkasan pemicu teratas (3) ditampilkan di atas daftar saat ada data
- [ ] Label "Lainnya" + jumlah sisa ditampilkan jika ada di luar top 3
- [ ] Ringkasan langsung terlihat (tidak collapsible)
- [ ] Empty state tetap berfungsi saat kosong
- [ ] Loading/error state tetap berfungsi
- [ ] Tidak ada crash jika data tidak lengkap
- [ ] UI konsisten dengan tema

## 12. Risiko dan Pertanyaan Terbuka

- [SELESAI] Posisi: Di atas daftar (langsung terlihat)
- [SELESAI] Jumlah top pemicu: 3
- [SELESAI] Tampilkan 'Lainnya' + jumlah sisa: Ya

## 13. Catatan Keputusan Diskusi

| pertanyaan                        | keputusan                          | tanggal    |
| --------------------------------- | ---------------------------------- | ---------- |
| Posisi ringkasan                  | Di atas daftar (langsung terlihat) | 2026-11-08 |
| Jumlah top pemicu                 | 3                                  | 2026-11-08 |
| Tampilkan 'Lainnya' + jumlah sisa | Ya                                 | 2026-11-08 |

Status: FINAL
Terakhir diperbarui: 2026-11-08
