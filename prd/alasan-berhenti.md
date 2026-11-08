# PRD: Catatan Alasan Berhenti (Reasons Vault)

## 1. Informasi Dokumen

- **Nama fitur:** Catatan Alasan Berhenti (Reasons Vault)
- **Jenis pengembangan:** Pembaruan fitur (penyempurnaan dan peningkatan aksesibilitas fitur "Alasan Berhenti" yang sudah ada)
- **Status implementasi:** Sebagian
- **Status PRD:** Draft
- **Tanggal pembuatan/pembaruan:** 2026-11-08
- **Sumber referensi:** `refrensi_apk.md`

## 2. Tujuan Fitur

Menyediakan tempat terpusat bagi pengguna untuk mencatat alasan personal berhenti merokok, agar alasan tersebut dapat dibaca kembali saat motivasi menurun atau saat craving muncul. Fitur ini bertujuan memperkuat motivasi dan personalisasi pengalaman pengguna tanpa membutuhkan backend.

## 3. Latar Belakang dan Permasalahan

Pengguna saat ini hanya memiliki tempat pencatatan motivasi finansial (impian) dan diary craving. Belum ada tempat khusus untuk menyimpan alasan personal non-finansial (misalnya kesehatan, keluarga, janji kepada diri sendiri) yang dapat dibaca kembali pada momen sulit. Aplikasi referensi menyediakan "personal reasons vault" yang dapat diakses kembali saat craving atau motivasi menurun.

## 4. Target Pengguna

Pengguna aplikasi yang sedang dalam proses berhenti merokok dan membutuhkan penguatan motivasi personal, terutama pada momen craving atau saat motivasi menurun.

## 5. Manfaat Fitur

- **Manfaat utama:** Menyimpan alasan personal berhenti merokok di satu tempat yang mudah diakses.
- **Manfaat tambahan:** Meningkatkan personalisasi pengalaman; memperkuat motivasi saat craving; melengkapi impian finansial dengan motivasi non-finansial.
- **Dampak terhadap pengguna:** Pengguna dapat membaca kembali alasan personal pada momen sulit.
- **Dampak terhadap aplikasi:** Memanfaatkan infrastruktur lokal (SQLite) yang sudah ada; tidak membutuhkan dependensi atau backend baru.

## 6. Referensi Aplikasi

- **Nama aplikasi:** Quit Smoking: Progress Tracker (Inspector Studios); Quitzilla; Quit It
- **Link aplikasi:**
  - https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker
  - https://quitzilla.com/
  - https://www.quit-it-web.com/
- **Screenshot/demonstrasi:** Screenshot resmi tersedia pada halaman Google Play Store (fitur "personal reasons vault", "keep reasons close").
- **Gambaran tampilan:** Daftar alasan singkat yang dapat ditambah/diubah; ditampilkan kembali pada Dashboard atau saat craving.
- **Gambaran cara kerja:** Pengguna mencatat alasan personal; aplikasi menampilkan kembali alasan tersebut pada Dashboard atau saat craving untuk memperkuat motivasi.
- **Informasi yang belum terverifikasi:** Detail visual (posisi, warna, struktur halaman) sebagian besar didasarkan pada deskripsi resmi; alur interaksi detail tidak dapat diverifikasi langsung. Detail implementasi internal aplikasi referensi tidak dapat dipastikan.

## 7. Sumber Referensi Internal

- Nama file: `refrensi_apk.md`
- Path: `refrensi_apk.md`
- Baris: `L48-L58` (entri "#### 3. Catatan Alasan Berhenti (Reasons Vault)")
- Referensi lengkap: `refrensi_apk.md:L48-L58`
- Nama data: Catatan Alasan Berhenti (Reasons Vault)
- Link aplikasi: https://play.google.com/store/apps/details?id=com.inspectorstudios.quitsmokingprogresstracker ; https://quitzilla.com/ ; https://www.quit-it-web.com/

## 8. Kondisi Implementasi Saat Ini

- **Status implementasi:** Sebagian
- **Fungsi yang sudah tersedia:**
  - Model `AlasanBerhentiModel` (id, teks, dibuat) dengan `fromSqflite`/`toSqflite` di `lib/fitur/alasan_berhenti/model/alasan_berhenti_model.dart`.
  - State `AlasanBerhentiState` (listAlasan, jumlahAlasan) di `lib/fitur/alasan_berhenti/state/alasan_berhenti_state.dart`.
  - Notifier `AlasanBerhentiNotifier` (build, _ambilSemua, tambah, ubah, hapus) di `lib/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart`.
  - Layar daftar `AlasanBerhentiScreen` dengan loading/error/empty state, FAB, hapus dengan konfirmasi di `lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart`.
  - Form tambah/ubah `FormAlasanBerhenti` dengan validasi dan konfirmasi simpan di `lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart`.
  - Tabel `alasan_berhenti` pada skema database (v7) di `lib/shared/db/sqflite/sqflite.dart`.
  - Entri "Alasan Berhenti" pada `LainnyaScreen` (`lib/lainnya_screen.dart`, baris 40-43).
- **Fungsi yang belum tersedia:**
  - Penampilan alasan berhenti pada Dashboard (kartu/tautan singkat).
  - Penampilan alasan berhenti pada layar SOS Craving atau saat craving.
  - Penampilan alasan acak/terbaru sebagai penguat motivasi.
- **Bagian yang sudah sesuai:** CRUD lokal (tambah, ubah, hapus), penanganan state asynchronous, empty state, konfirmasi hapus/simpan, konversi UTC, penggunaan `SqfliteOp`.
- **Bagian yang belum sesuai:** Aksesibilitas alasan berhenti dari layar utama/craving belum tersedia; fitur hanya dapat diakses melalui menu "Lainnya".
- **Bukti:** `lib/fitur/alasan_berhenti/...`, `lib/lainnya_screen.dart`, `lib/shared/db/sqflite/sqflite.dart`.

## 9. Ruang Lingkup

- **Termasuk:** Peningkatan aksesibilitas alasan berhenti (misalnya kartu/tautan pada Dashboard dan/atau penampilan singkat pada SOS Craving), dengan memanfaatkan data yang sudah tersedia; penanganan error navigasi; konsistensi dengan tema terang/gelap.
- **Opsional (usulan):** Penyediaan "snippet" atau pilihan cepat (chip) berisi alasan umum yang dapat dipilih pengguna dengan satu ketukan, tanpa wajib mengetik manual. Input manual tetap tersedia sebagai opsional.
- **Tidak termasuk:** Implementasi "daily pledge" (janji harian) yang terpisah (bukan bagian dari entri referensi ini); perubahan skema database; perubahan isi `SosCravingScreen` selain penampilan alasan; widget beranda; backend/sinkronisasi.

## 10. Alur Penggunaan

1. Pengguna membuka layar "Alasan Berhenti" melalui menu "Lainnya" (sudah tersedia).
2. Pengguna menambah/ubah/menghapus alasan (sudah tersedia).
3. (Usulan) Pengguna membuka Dashboard dan melihat kartu/tautan singkat "Alasan Berhenti" atau alasan terbaru.
4. (Usulan) Pengguna menekan kartu/tautan untuk membuka daftar alasan atau menambah alasan baru.
5. (Usulan) Saat craving, pengguna dapat membaca kembali alasan berhenti sebagai penguat motivasi.
6. Jika navigasi gagal, error dicatat melalui `L.e` dan pengguna tetap pada halaman sebelumnya.

## 11. Persyaratan Fungsional

1. Daftar alasan berhenti dapat ditambah, diubah, dan dihapus (sudah tersedia).
2. Setiap alasan memiliki teks dan waktu pembuatan (sudah tersedia).
3. (Usulan) Dashboard menampilkan kartu/tautan "Alasan Berhenti" dengan jumlah alasan atau alasan terbaru, pada kondisi data valid.
4. (Usulan) Kartu/tautan membuka `AlasanBerhentiScreen` dalam satu ketukan.
5. (Usulan) Pada layar SOS Craving, tersedia penampilan singkat alasan berhenti (misalnya satu alasan acak/terbaru) sebagai penguat motivasi, tanpa mengganggu fungsi utama (napas, timer, distraksi).
6. Navigasi menggunakan `Nav.to` dengan penanganan error (`unawaited` + `.catchError`).
7. Empty state tetap informatif dengan CTA menambah alasan (sudah tersedia).
8. (Opsional) Form menyediakan "snippet" atau pilihan cepat (chip) berisi alasan umum yang dapat dipilih dengan satu ketukan; input manual tetap opsional dan dapat digunakan bersama atau sebagai pengganti snippet.
   - Daftar usulan snippet (belum disetujui, dapat disesuaikan pengguna):
     - "Menjaga kesehatan paru-paru dan jantung"
     - "Menghemat uang untuk kebutuhan keluarga"
     - "Memberi contoh baik bagi anak/keluarga"
     - "Menghindari bau rokok dan gigi kuning"
     - "Meningkatkan stamina dan kebugaran"
     - "Menepati janji pada diri sendiri"
     - "Mengurangi risiko penyakit serius"
     - "Hidup lebih lama dan berkualitas"

## 12. Persyaratan Nonfungsional

- **Performa:** Penampilan tambahan tidak boleh menambah beban rendering yang signifikan; gunakan data yang sudah dimuat (provider) tanpa query tambahan yang berat.
- **Keamanan:** Tidak menyimpan data sensitif; data tetap lokal.
- **Keandalan:** Navigasi gagal ditangani tanpa crash; state kosong/error ditangani.
- **Kemudahan penggunaan:** Area sentuh minimal 48x48 dp; label/tooltip jelas; konsisten dengan tema terang/gelap; bahasa formal dan baku.

## 13. File yang Terdampak

### File yang sudah menangani fitur

- `lib/fitur/alasan_berhenti/model/alasan_berhenti_model.dart` — Model alasan berhenti.
- `lib/fitur/alasan_berhenti/state/alasan_berhenti_state.dart` — State daftar alasan.
- `lib/fitur/alasan_berhenti/notifier/alasan_berhenti_notifier.dart` — Notifier CRUD.
- `lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart` — Layar daftar alasan.
- `lib/fitur/alasan_berhenti/screens/form_alasan_berhenti.dart` — Form tambah/ubah alasan.
- `lib/lainnya_screen.dart` — Entri "Alasan Berhenti" (baris 40-43).
- `lib/shared/db/sqflite/sqflite.dart` — Tabel `alasan_berhenti` (v7).
- `lib/shared/konstanta/nama_tabel.dart` — Konstanta tabel.
- `lib/shared/konstanta/nama_kolom.dart` — Konstanta kolom.

### File yang perlu diubah (usulan)

- `lib/fitur/dashboard/screens/dashboard_screen.dart` — Tambah kartu/tautan "Alasan Berhenti" (bukan di posisi paling atas daftar) yang menampilkan jumlah/alasan terbaru; navigasi ke `AlasanBerhentiScreen`.
- `lib/fitur/sos_craving/screens/sos_craving_screen.dart` — Tambah penampilan singkat alasan berhenti (opsional) tanpa mengganggu fungsi utama.
- `lib/fitur/alasan_berhenti/screens/alasan_berhenti_screen.dart` — (Opsional) tampilkan alasan terbaru/acak sebagai penguat motivasi.

### File baru yang mungkin diperlukan

- Tidak ada (menggunakan komponen dan provider yang sudah tersedia).

## 14. Gambaran Teknis

Pendekatan: memanfaatkan `alasanBerhentiProvider` yang sudah ada untuk menampilkan data pada Dashboard/SOS Craving. Tidak perlu query tambahan atau perubahan skema.

### Contoh 1 — Kartu Alasan Berhenti pada Dashboard

**Path:** `lib/fitur/dashboard/screens/dashboard_screen.dart`

```dart
// Pada children ListView Dashboard (bukan paling atas):
Consumer(
  builder: (context, ref, _) {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    final jumlah = alasanAsync.valueOrNull?.jumlahAlasan ?? 0;
    return Card(
      child: InkWell(
        onTap: () => unawaited(
          Nav.to(context, const AlasanBerhentiScreen()).catchError((
            Object e,
            StackTrace s,
          ) {
            L.e('Gagal navigasi ke Alasan Berhenti: $e $s');
            return null;
          }),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 12,
            children: [
              const Icon(CupertinoIcons.heart, size: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Alasan Berhenti',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$jumlah alasan tersimpan',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.chevron_right),
            ],
          ),
        ),
      ),
    );
  },
),
```

**Tujuan:** Menampilkan pintasan alasan berhenti pada layar utama dengan jumlah alasan tersimpan.

**Hubungan:** Menggunakan `alasanBerhentiProvider` (data), `AlasanBerhentiScreen` (tujuan navigasi), `Nav` (navigasi), dan `L` (logging).

### Contoh 2 — Penampilan Singkat Alasan pada SOS Craving

**Path:** `lib/fitur/sos_craving/screens/sos_craving_screen.dart`

```dart
// Pada bagian atas konten SOS (opsional), tanpa mengganggu fungsi utama:
Consumer(
  builder: (context, ref, _) {
    final alasanAsync = ref.watch(alasanBerhentiProvider);
    final alasan = alasanAsync.valueOrNull?.listAlasan;
    if (alasan == null || alasan.isEmpty) {
      return const SizedBox.shrink();
    }
    final terbaru = alasan.first;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          'Ingat alasanmu: ${terbaru.teks}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  },
),
```

**Tujuan:** Menampilkan alasan terbaru sebagai penguat motivasi saat craving.

**Hubungan:** Menggunakan `alasanBerhentiProvider` dan tema aplikasi; tidak mengubah fungsi napas/timer/distraksi.

### Contoh 3 — Navigasi dengan Penanganan Error

**Path:** `lib/fitur/dashboard/screens/dashboard_screen.dart`

```dart
onTap: () => unawaited(
  Nav.to(context, const AlasanBerhentiScreen()).catchError((
    Object e,
    StackTrace s,
  ) {
    L.e('Gagal navigasi ke Alasan Berhenti: $e $s');
    return null;
  }),
),
```

**Tujuan:** Memastikan kegagalan navigasi dicatat dan tidak menjadi unhandled error.

**Hubungan:** Konsisten dengan pola navigasi proyek.

## 15. Kriteria Penerimaan

1. Daftar alasan berhenti dapat ditambah, diubah, dan dihapus (sudah terpenuhi).
2. Konfirmasi hapus dan simpan berfungsi (sudah terpenuhi).
3. Empty state informatif dengan CTA (sudah terpenuhi).
4. (Usulan) Kartu/tautan "Alasan Berhenti" tampil pada Dashboard pada kondisi data valid.
5. (Usulan) Menekan kartu/tautan membuka `AlasanBerhentiScreen` dalam satu ketukan.
6. (Usulan) Navigasi gagal tidak menyebabkan crash dan dicatat melalui `L.e`.
7. (Usulan) Penampilan singkat alasan pada SOS Craving (jika diimplementasikan) tidak mengganggu fungsi utama.
8. `flutter analyze` tidak menemukan error baru (jika implementasi dilakukan).

## 16. Risiko dan Ketergantungan

- **Risiko:** Penempatan kartu pada Dashboard dapat memengaruhi alur visual; perlu penyesuaian padding/spacing. Penampilan alasan pada SOS Craving dapat menambah noise jika tidak dibatasi.
- **Ketergantungan:** Bergantung pada `AlasanBerhentiScreen` dan `alasanBerhentiProvider` yang sudah ada; tidak membutuhkan dependensi baru atau perubahan skema.

## 17. Keputusan dan Hal yang Belum Ditentukan

- **Keputusan yang sudah disetujui:** Fitur CRUD alasan berhenti sudah tersedia lokal (tambah, ubah, hapus). Snippet dan input manual menggunakan kolom/field teks yang sama (`teks`); tidak perlu membedakan sumber input pada model atau skema database. Penandaan snippet yang sudah dipilih cukup dilakukan di UI dengan pencocokan teks (tanpa perubahan model/skema); jika diperlukan penandaan persisten, tambahkan metadata terpisah.
- **Rekomendasi yang belum disetujui:** Penempatan kartu "Alasan Berhenti" pada Dashboard (setelah kartu progres vs setelah kartu milestone); apakah menampilkan alasan pada SOS Craving; apakah menambahkan snippet/pilihan cepat pada form.
- **Asumsi yang belum diverifikasi:** Efektivitas penampilan alasan pada SOS Craving terhadap motivasi pengguna; tampilan pada tema gelap; efektivitas snippet terhadap kecepatan input.
- **Pertanyaan yang memerlukan keputusan pengguna:** Apakah alasan berhenti perlu ditampilkan pada Dashboard dan/atau SOS Craving; format penampilan (jumlah vs alasan terbaru vs alasan acak); apakah snippet/pilihan cepat diperlukan dan daftar alasan umum yang disediakan.

## 18. Riwayat Perubahan PRD

- 2026-11-08: Draft awal dibuat berdasarkan diskusi entri `refrensi_apk.md:L48-L58`.
