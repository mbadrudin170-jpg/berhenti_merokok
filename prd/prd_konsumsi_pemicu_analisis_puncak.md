# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Draft

**Status Implementasi:** Belum Diimplementasikan

---

## 1. Informasi Produk

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi produk dan memberikan gambaran umum proyek. Informasi ini menjadi identitas utama PRD.

**Aturan pengisian:**

- Isi informasi berdasarkan kondisi dan identitas proyek yang sebenarnya.
- Gunakan nama yang konsisten dengan proyek.
- Tuliskan platform dan versi yang menjadi target pengembangan.
- Bedakan status dokumen dengan status implementasi.
- Jangan mengarang informasi yang belum diketahui.

**Informasi:**

- Nama aplikasi: Berhenti Merokok
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok dengan pelacakan konsumsi, manajemen craving, visualisasi progres, dan fitur pendukung lainnya.
- Platform: Android, iOS, Web, Linux, macOS, Windows
- Versi: 1.0.0+1
- Status pengembangan: Aktif (dalam pengembangan)

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**

- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**
PRD ini bertujuan mendokumentasikan kebutuhan implementasi fitur **B11: Konsumsi — Tambah Field Pemicu & Analisis Puncak** sesuai referensi di `refrensi_apk.md` baris 241-246. Hasil yang diharapkan:
1. Menambahkan kolom `pemicu` (nullable, menggunakan `PemicuEnum` yang sama dengan diary craving) ke tabel `konsumsi_rokok`.
2. Membuat helper murni `PuncakKonsumsiHelper` untuk menghitung: jam konsumsi tertinggi, hari konsumsi tertinggi, dan distribusi pemicu.
3. Menampilkan ringkasan teks analisis puncak pada layar **Konsumsi Rokok** yang sudah ada (`konsumsi_rokok_screen.dart`).
4. Memperbarui form input konsumsi (`form_konsumsi_rokok.dart`) agar pengguna dapat memilih pemicu saat mencatat/keoreksi konsumsi.

## 3. Daftar Fitur

**Konteks penggunaan:**
Digunakan untuk melihat keseluruhan fitur produk dan menentukan tingkat kepentingannya.

**Aturan pengisian:**

- Setiap fitur harus memiliki nama dan deskripsi yang jelas.
- Satu baris mewakili satu fitur yang dapat diidentifikasi secara terpisah.
- Hindari menggabungkan beberapa fitur berbeda dalam satu baris.
- Pastikan fitur mendukung tujuan produk dan masuk dalam ruang lingkup.
- Gunakan prioritas berdasarkan kepentingan kebutuhan produk.

| Fitur | Deskripsi | Prioritas |
| ----- | --------- | ----------- |
| Tambah kolom `pemicu` ke tabel `konsumsi_rokok` | Kolom nullable menggunakan `PemicuEnum` (stres, kopi, alkohol, sosial, bauRokok, emosi, lapar, lelah, lainnya) | Must Have |
| Update model `KonsumsiRokokModel` | Tambahkan field `pemicu` (PemicuEnum?) dengan parsing `safeParseEnum` dan serialisasi ke DB | Must Have |
| Update form input konsumsi | Tambahkan dropdown/selector pemicu menggunakan `PemicuEnum` di `FormKonsumsiRokok` | Must Have |
| Buat `PuncakKonsumsiHelper` | Helper murni untuk: jam puncak, hari puncak, distribusi pemicu (tanpa grafik) | Must Have |
| Tampilkan ringkasan analisis puncak di layar Konsumsi | Section teks di `KonsumsiRokokScreen` menampilkan hasil `PuncakKonsumsiHelper` | Must Have |
| Migrasi database versi 14 | ALTER TABLE `konsumsi_rokok` ADD COLUMN `pemicu` TEXT | Must Have |

## 4. Alur Pengguna

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan interaksi pengguna dengan aplikasi dari awal hingga tujuan tercapai.

**Aturan pengisian:**

- Mulai dari kondisi awal pengguna.
- Jelaskan setiap langkah secara berurutan.
- Sebutkan tindakan pengguna dan respons aplikasi.
- Sertakan percabangan atau kondisi alternatif jika tersedia.
- Jelaskan kondisi akhir yang diharapkan.
- Pastikan alur sesuai dengan persyaratan fitur.
- Jangan memasukkan proses yang tidak didukung oleh kebutuhan produk.

**Isi:**

### Alur 1: Mencatat Konsumsi Baru dengan Pemicu
1. Pengguna membuka layar **Konsumsi Rokok** (FAB +1 atau ketuk "Catat Rokok").
2. Aplikasi menampilkan bottom sheet `FormKonsumsiRokok` dengan field: Jumlah Batang, Tanggal, Switch "Ini slip/relapse?", **dropdown Pemicu (baru)**, Catatan.
3. Pengguna mengisi jumlah, memilih tanggal, memilih pemicu dari dropdown (opsional), dan mengisi catatan (opsional).
4. Pengguna menekan "Simpan".
5. Aplikasi memvalidasi form, menampilkan konfirmasi, lalu menyimpan ke database dengan field `pemicu` terisi.
6. Aplikasi menutup bottom sheet, menampilkan Snackbar "Rokok dicatat (+1)" dengan aksi "Urungkan".
7. Layar **Konsumsi Rokok** refresh, menampilkan entri baru di daftar.

### Alur 2: Mengubah Entri Konsumsi Existing (Tambah/Ubah Pemicu)
1. Pengguna membuka layar **Konsumsi Rokok**, memilih tanggal tertentu (ketuk kartu tanggal).
2. Aplikasi menampilkan bottom sheet `DaftarEntriKonsumsiSheet` dengan daftar entri hari itu.
3. Pengguna menekan ikon edit (pensil) pada salah satu entri.
4. Aplikasi membuka `FormKonsumsiRokok` dengan data terisi, termasuk dropdown Pemicu yang menampilkan nilai lama (jika ada) atau kosong.
5. Pengguna mengubah pemicu dan/atau field lain, lalu menekan "Simpan".
6. Aplikasi memvalidasi, konfirmasi, update database, refresh bottom sheet dan layar utama.

### Alur 3: Melihat Analisis Puncak Konsumsi
1. Pengguna membuka layar **Konsumsi Rokok**.
2. Jika ada data konsumsi, di bagian atas/bawah daftar (sesuai desain) muncul **section ringkasan analisis puncak** berupa teks:
   - "Jam puncak: 19:00–20:00 (rata-rata 3 batang/hari)"
   - "Hari puncak: Minggu (rata-rata 15 batang/minggu)"
   - "Pemicu paling umum: Stres (40%), Kopi (25%), Sosial (15%)"
3. Jika data belum cukup (misal < 7 hari catatan), tampilkan teks: "Data belum cukup untuk analisis puncak. Catat konsumsi minimal 7 hari."
4. Pengguna dapat memahami pola konsumsi dan merencanakan strategi menghindari pemicu.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. **Migrasi Database**: Tambahkan migrasi versi 14 di `sqflite.dart` (_onUpgrade) untuk `ALTER TABLE konsumsi_rokok ADD COLUMN pemicu TEXT`.
2. **Konstanta Kolom**: Tambahkan `static const String pemicu = 'pemicu';` di `nama_kolom.dart` (di section tabel konsumsi_rokok).
3. **Model**: Update `KonsumsiRokokModel`:
   - Tambah field `PemicuEnum? pemicu` di constructor.
   - Di `fromSqflite`: gunakan `ParserUtil.safeParseEnum(PemicuEnum.values, ParserUtil.parseStringOrNull(row[NamaKolom.pemicu]))`.
   - Di `toSqflite`: tambah `NamaKolom.pemicu: pemicu?.name`.
4. **State**: Update `KonsumsiRokokState` jika diperlukan (tidak wajib, helper terpisah).
5. **Notifier**: `KonsumsiRokokNotifier` sudah menggunakan `KonsumsiRokokModel` dari DB, tidak perlu perubahan logika CRUD.
6. **Helper Analisis**: Buat file baru `lib/fitur/konsumsi_rokok/helper/puncak_konsumsi_helper.dart` dengan class `PuncakKonsumsiHelper`:
   - `static Map<int, int> distribusiJam(List<KonsumsiRokokModel> list)` — jumlah per jam (0-23).
   - `static Map<int, int> distribusiHari(List<KonsumsiRokokModel> list)` — jumlah per hari Minggu=0..Sabtu=6.
   - `static Map<PemicuEnum, int> distribusiPemicu(List<KonsumsiRokokModel> list)` — hitung per enum.
   - `static String ringkasanTeks(List<KonsumsiRokokModel> list)` — gabungan teks untuk UI (handle data koseng/kurang).
7. **Form Input**: Update `FormKonsumsiRokok`:
   - Tambah state `PemicuEnum? _pemicu`.
   - Di `initState`: isi dari `widget.konsumsi?.pemicu`.
   - Tambah dropdown/selector pemicu di UI (menggunakan `PemicuEnumExtension.label` dan `icon`).
   - Update `_simpan()`: sertakan `_pemicu` di `KonsumsiRokokModel`.
8. **Layar Utama**: Update `KonsumsiRokokScreen` / `_DaftarKonsumsi`:
   - Di `build` state `data`: hitung ringkasan puncak via `PuncakKonsumsiHelper.ringkasanTeks(state.listKonsumsi)`.
   - Tampilkan sebagai widget (Card/ListTile) di atas daftar atau di bagian bawah.
9. **Code Generation**: Jalankan `dart run build_runner build --delete-conflicting-outputs` untuk generate Freezed.
10. **Verifikasi**: `dart analyze`, test manual alur catat/ubah/lihat analisis.

## 6. File-File Terdampak

**Konteks penggunaan:**
Digunakan untuk mengidentifikasi file proyek yang berkaitan dengan implementasi kebutuhan produk. Bagian ini menjadi gambaran awal cakupan perubahan kode.

**Aturan pengisian:**

- Periksa struktur proyek sebelum menentukan file terdampak.
- Cantumkan lokasi file secara spesifik berdasarkan struktur proyek sebenarnya.
- Tandai apakah file perlu dibuat, diubah, atau dihapus.
- Jelaskan alasan dan tujuan perubahan setiap file.
- Cantumkan hanya file yang memiliki hubungan dengan kebutuhan fitur.
- Jangan mengarang lokasi, nama, atau keberadaan file.
- Jika file belum dapat ditentukan, tandai sebagai belum diketahui dan jangan menebak.
- Perbarui daftar setelah analisis teknis atau implementasi apabila ditemukan file terdampak tambahan.

| Lokasi File | Status Perubahan | Deskripsi Perubahan |
| ----------- | ------------------------- | ------------------- |
| `lib/shared/konstanta/nama_kolom.dart` | Diubah | Tambah konstanta `pemicu = 'pemicu'` di section tabel konsumsi_rokok |
| `lib/shared/db/sqflite/sqflite.dart` | Diubah | Tambah migrasi versi 14: `ALTER TABLE konsumsi_rokok ADD COLUMN pemicu TEXT` di `_onUpgrade` |
| `lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.dart` | Diubah | Tambah field `PemicuEnum? pemicu`, update `fromSqflite` (safeParseEnum) dan `toSqflite` |
| `lib/fitur/konsumsi_rokok/model/konsumsi_rokok_model.freezed.dart` | Diubah (generated) | Regenerate via build_runner |
| `lib/fitur/konsumsi_rokok/screens/form_konsumsi_rokok.dart` | Diubah | Tambah dropdown pemicu (PemicuEnum), state `_pemicu`, update `_simpan()` |
| `lib/fitur/konsumsi_rokok/helper/puncak_konsumsi_helper.dart` | Dibuat | Helper murni baru: distribusi jam/hari/pemicu + ringkasan teks |
| `lib/fitur/konsumsi_rokok/screens/konsumsi_rokok_screen.dart` | Diubah | Tampilkan ringkasan analisis puncak (teks) di atas/bawah daftar |
| `lib/fitur/diary_craving/enum/pemicu_enum.dart` | Tidak diubah | Reuse `PemicuEnum` dan `PemicuEnumExtension` yang sudah ada |

---

**Referensi:** `refrensi_apk.md` baris 241-246 (Fitur B11. Konsumsi — Tambah Field Pemicu & Analisis Puncak)