# PRD — SOS: Penghitung "Craving Berhasil Dilalui" + Catatan Substitusi Personal

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
- Nama aplikasi: berhenti_merokok
- Deskripsi produk: Aplikasi Flutter untuk membantu pengguna berhenti merokok
- Platform: Flutter (Android, iOS, Web, Desktop)
- Versi: 1.0.0+1
- Status pengembangan: Sedang Diimplementasikan

## 2. Tujuan PRD

**Konteks penggunaan:**
Digunakan untuk menentukan hasil yang ingin dicapai dari dokumen PRD ini. Tujuan harus berhubungan langsung dengan kebutuhan dokumen.

**Aturan pengisian:**
- Tuliskan hasil yang diharapkan dari PRD.
- Pastikan setiap tujuan memiliki hubungan dengan kebutuhan dokumen PRD.
- Gunakan tujuan yang jelas dan dapat dievaluasi.
- Jangan memasukkan tujuan yang berada di luar ruang lingkup PRD.

**Isi:**
Menambahkan umpan balik positif langsung di layar SOS Craving berupa penghitung "craving berhasil dilalui: N" serta catatan substitusi personal opsional pada catatan intervensi SOS, untuk memperkuat _self-efficacy_ pengguna saat melewati craving. Sumber kebutuhan: `refrensi_apk.md` baris 796–801 (bagian B14, Prioritas Rendah; isi bagian tersebut dipindahkan ke PRD ini pada 2026-11-13 — bagian B14 kini hanya memuat penanda status PRD):

> ##### B14. SOS — Penghitung "Craving Berhasil Dilalui" + Catatan Substitusi Personal
>
> - **Tujuan:** umpan balik positif langsung di layar SOS; memperkuat _self-efficacy_ pengguna saat melewati craving.
> - **Referensi:** [FreeAir Coach](https://play.google.com/store/apps/details?id=com.freeaircoach.app.twa) (SOS: satu pertanyaan kontekstual → aksi _grounding_ 60 detik + substitusi personal + pengingat "how many cravings you've already beaten") · [Quit Smoking - Counter App](https://apps.apple.com/bh/app/quit-smoking-counter/id6746945120) (one-tap log craving + timer 5 menit + quick actions: minum air / tulis catatan; craving hari ini & 7 hari terakhir).
> - **Saran:** hasil intervensi SOS sudah tersimpan di tabel `sos_intervensi`; tampilkan hitungan "craving berhasil dilalui: N" pada layar SOS; tambahkan field substitusi opsional pada catatan intervensi.
> - **Prioritas:** Rendah.

Baris rujukan lain: `refrensi_apk.md` baris 1420 (tabel item #21: "SOS: penghitung craving berhasil dilalui + catatan substitusi (B14)").

## 3. Daftar Fitur

**Konteks penggunaan:**
Digunakan untuk melihat keseluruhan fitur produk dan menentukan tingkat kepentingannya.

**Aturan pengisian:**
- Setiap fitur harus memiliki nama dan deskripsi yang jelas.
- Satu baris mewakili satu fitur yang dapat diidentifikasi secara terpisah.
- Hindari menggabungkan beberapa fitur berbeda dalam satu baris.
- Pastikan fitur mendukung tujuan produk dan masuk dalam ruang lingkup.
- Gunakan prioritas berdasarkan kepentingan kebutuhan produk.

| Fitur | Deskripsi | Prioritas   |
| ----- | --------- | ----------- |
| Penghitung "Craving Berhasil Dilalui" di layar SOS | Menampilkan jumlah total sepanjang waktu intervensi SOS dengan `hasil_intervensi = berkurang`, dihitung dari tabel `sos_intervensi` (bukan counter ephemeral seperti `distraksi_view.dart` baris 18); ditampilkan sebagai kartu sendiri di atas grid teknik (di bawah `KartuRencanaDarurat`) | Could Have  |
| Field substitusi personal opsional pada catatan intervensi SOS | Menambah kolom `substitusi` (nullable) pada tabel `sos_intervensi` (migrasi v15→v16) + input opsional pada bottom sheet hasil intervensi (`sheet_hasil_intervensi.dart`); substitusi hanya tersimpan, tidak ditampilkan kembali di layar mana pun | Could Have  |

Prioritas sesuai B14 pada `refrensi_apk.md`: **Rendah**. Kedua sub-fitur dikerjakan sekaligus dalam satu PRD dan satu migrasi.

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
1. Pengguna membuka layar SOS Craving (`SosCravingScreen`).
2. Layar menampilkan pengingat alasan berhenti, kartu rencana darurat, lalu kartu penghitung "Craving berhasil dilalui: N" (N = jumlah total sepanjang waktu baris `sos_intervensi` dengan `hasil_intervensi = berkurang`), tepat di atas grid teknik.
3. Pengguna memilih salah satu teknik (Napas 4-7-8, Timer Craving, Box Breathing, Napas 90 Detik, Grounding 5-4-3-2-1, Distraksi, Urge Surfing).
4. Setelah intervensi selesai, bottom sheet "Apakah dorongan merokok berkurang?" (`SheetHasilIntervensi`) ditampilkan, dengan tambahan input opsional "Substitusi personal" (teks bebas, boleh dikosongkan).
5. Pengguna memilih Berkurang / Tetap / Belum selesai / Lewati; hasil + substitusi (bila diisi) tersimpan ke tabel `sos_intervensi` (kolom `hasil_intervensi`, kolom `substitusi`).
6. Penghitung pada layar SOS bertambah bila hasil yang dipilih adalah Berkurang.
7. Kondisi alternatif: bila pengguna menekan Lewati, intervensi tetap tersimpan dengan `hasil_intervensi` null dan substitusi (bila diisi) tetap tersimpan; penghitung tidak bertambah.
8. Kondisi akhir: pengguna melihat penghitung yang akurat dan, pada catatan intervensi, substitusi personal yang pernah ia catat.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**
- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**
1. Naikkan `_versiDatabase` di `lib/shared/db/sqflite/sqflite.dart` (saat ini `15`, baris 24) menjadi `16`; tambahkan cabang `if (oldVersion < 16)` di `_onUpgrade` dengan `ALTER TABLE sos_intervensi ADD COLUMN substitusi TEXT`; cerminkan kolom `substitusi` pada `CREATE TABLE` di `_buatTabel` (onCreate) agar instalasi baru juga memilikinya.
2. Tambah konstanta kolom `substitusi` (`'substitusi'`) pada `lib/shared/konstanta/nama_kolom.dart` di blok "Kolom tabel sos_intervensi" (setelah baris 102).
3. Tambah field `String? substitusi` pada `SosIntervensiModel` (`lib/fitur/sos_craving/model/sos_intervensi_model.dart`) + `fromSqflite`/`toSqflite`; jalankan `build_runner` untuk memperbarui `sos_intervensi_model.freezed.dart` (JANGAN edit file generated).
4. Implementasikan kriteria "berhasil dilalui" = `hasil_intervensi == HasilIntervensiSos.berkurang` di `SosIntervensiNotifier`/`SosIntervensiState`: hitung `jumlahBerhasil` dari `listIntervensi` (total sepanjang waktu) dan paparkan pada state.
5. Tambah input opsional "Substitusi personal" pada `SheetHasilIntervensi` (`lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart`) dan teruskan nilainya ke `sosIntervensiProvider.notifier.simpan(..., substitusi: ...)`.
6. Tampilkan penghitung "Craving berhasil dilalui: N" pada `SosCravingScreen` (`lib/fitur/sos_craving/screens/sos_craving_screen.dart`, mis. di atas `GridView` teknik atau di bawah `KartuRencanaDarurat`).
7. Perbarui `test/skema_migrasi_test.dart`: kolom wajib `sos_intervensi` (baris 55–62) + uji migrasi `v15 → v16`.
8. Verifikasi: `dart format`, `dart analyze`, `flutter test`.

**Potongan contoh kode singkat:**

Model (`sos_intervensi_model.dart`):

```dart
const factory SosIntervensiModel({
  required String id,
  required JenisIntervensiSos jenisIntervensi,
  String? detail,
  HasilIntervensiSos? hasilIntervensi,
  String? diaryCravingId,
  String? substitusi, // baru
  required DateTime dibuat,
}) = _SosIntervensiModel;
```

Migrasi (`sqflite.dart`):

```dart
if (oldVersion < 16) {
  await db.execute(
    'ALTER TABLE ${NamaTabel.sosIntervensi} '
    'ADD COLUMN ${NamaKolom.substitusi} TEXT',
  );
}
```

State (`sos_intervensi_state.dart`):

```dart
const factory SosIntervensiState({
  @Default([]) List<SosIntervensiModel> listIntervensi,
  @Default(0) int jumlahIntervensi,
  @Default(0) int jumlahBerhasil, // baru
}) = _SosIntervensiState;
```

Hitung di notifier (`sos_intervensi_notifier.dart`):

```dart
// Kriteria "berhasil dilalui" = hasil == berkurang (keputusan diskusi 2026-11-13).
final berhasil = daftar
    .where((e) => e.hasilIntervensi == HasilIntervensiSos.berkurang)
    .length;
return SosIntervensiState(
  listIntervensi: daftar,
  jumlahIntervensi: daftar.length,
  jumlahBerhasil: berhasil,
);
```

Input substitusi di sheet (`sheet_hasil_intervensi.dart`):

```dart
TextFormField(
  controller: _substitusiController,
  decoration: const InputDecoration(
    labelText: 'Substitusi personal (opsional)',
    hintText: 'mis. minum air, jalan sebentar',
  ),
),
```

Tampilan penghitung (`sos_craving_screen.dart`):

```dart
final jumlahBerhasil =
    ref.watch(sosIntervensiProvider).asData?.value.jumlahBerhasil ?? 0;
Text('Craving berhasil dilalui: $jumlahBerhasil');
```

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

| Lokasi File | Status Perubahan          | Deskripsi Perubahan |
| ----------- | ------------------------- | ------------------- |
| `lib/shared/db/sqflite/sqflite.dart` | Diubah | `_versiDatabase` 15→16; `_buatTabel` tambah kolom `substitusi` pada `CREATE TABLE sos_intervensi` (baris 115–123); `_onUpgrade` tambah cabang `oldVersion < 16` (`ALTER TABLE ADD COLUMN substitusi`) |
| `lib/shared/konstanta/nama_kolom.dart` | Diubah | Tambah `static const String substitusi = 'substitusi';` pada blok "Kolom tabel sos_intervensi" (setelah baris 102) |
| `lib/fitur/sos_craving/model/sos_intervensi_model.dart` | Diubah | Tambah field `String? substitusi` + `fromSqflite`/`toSqflite`; jalankan `build_runner` |
| `lib/fitur/sos_craving/state/sos_intervensi_state.dart` | Diubah | Tambah `jumlahBerhasil` (atau hitung di UI dari `listIntervensi`); jalankan `build_runner` |
| `lib/fitur/sos_craving/notifier/sos_intervensi_notifier.dart` | Diubah | `simpan(...)` terima `substitusi`; hitung `jumlahBerhasil`; state setelah `simpan`/`_ambilSemua` menyertakan penghitung baru |
| `lib/fitur/sos_craving/widgets/sheet_hasil_intervensi.dart` | Diubah | Tambah input opsional "Substitusi personal"; teruskan ke `simpan(...)` |
| `lib/fitur/sos_craving/screens/sos_craving_screen.dart` | Diubah | Tampilkan "Craving berhasil dilalui: N" pada menu SOS |
| `test/skema_migrasi_test.dart` | Diubah | Kolom wajib `sos_intervensi` (baris 55–62) + uji migrasi v15→v16 |
| `refrensi_apk.md` | Diubah | B14 (baris 796–801) ditandai sudah dibuatkan PRD-nya (`prd/prd_sos_craving_berhasil_dilalui.md`) |

**Keputusan Diskusi (2026-11-13):**

1. Kriteria "craving berhasil dilalui" = `hasil_intervensi == berkurang` (tanpa enum baru).
2. Substitusi personal disimpan pada kolom `substitusi` baru (migrasi v15→v16), bukan memakai kolom `detail`.
3. Penghitung ditampilkan sebagai kartu sendiri di atas grid teknik (di bawah `KartuRencanaDarurat`).
4. Substitusi hanya tersimpan; tidak ditampilkan kembali di layar mana pun (belum ada layar riwayat SOS).
5. Penghitung menghitung total sepanjang waktu.
6. Kedua sub-fitur dikerjakan sekaligus dalam satu PRD; prioritas tetap Rendah (B14).
