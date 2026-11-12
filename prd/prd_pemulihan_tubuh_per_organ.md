# PRODUCT REQUIREMENTS DOCUMENT (PRD)

**Status Dokumen:** Final

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
PRD ini bertujuan mendokumentasikan kebutuhan implementasi fitur **C16: Pemulihan Tubuh per Organ** sesuai referensi pada `refrensi_apk.md` baris **980–987**. Hasil yang diharapkan:

1. Mengelompokkan 12 milestone pemulihan kesehatan yang **sudah ada** (`daftarMilestoneKesehatan`) ke dalam **4** sistem organ (jantung, paru, sirkulasi, saraf), tanpa menambah data terbaru di basis data.
2. Menambahkan model data `OrganPemulihan` (label + ikon) serta field `organ` pada `MilestoneKesehatan`.
3. Menyediakan helper murni `ProgresOrganHelper` untuk agregasi status pemulihan per organ (daftar milestone, status, rasio, persentase, milestone berikutnya, ringkasan teks).
4. Menampilkan **kartu ringkasan per organ** di layar `PemulihanKesehatanScreen`, dan halaman detail per organ saat kartu ditekan.
5. Menambahkan teks disclaimer non-medis pada layar pemulihan agar tidak menimbulkan kesan klaim medis.

**Keputusan cakupan (hasil diskusi):**

- Organ yang ditampilkan **4**: jantung, paru, sirkulasi, saraf. `kulit` **dikecualikan** karena 12 milestone yang ada tidak memuat peristiwa pemulihan kulit, dan menambahkannya berarti menambah klaim medis baru tanpa sumber di proyek (bertentangan dengan anjuran "tanpa data baru" pada C16).
- Tampilan memakai **kartu ringkasan per organ + halaman detail terpisah** (`DetailOrganPemulihanScreen`).
- Disclaimer non-medis **ditampilkan**.
- Kartu "Milestone berikutnya" pada Dashboard **tidak diubah**.

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
| Enum `OrganPemulihan` | Nilai `jantung`, `paru`, `sirkulasi`, `saraf` beserta label dan ikon (ekstensi `OrganPemulihanExtension`) | Must Have |
| Field `organ` pada `MilestoneKesehatan` | Setiap milestone dipetakan ke satu `OrganPemulihan` | Must Have |
| Helper `ProgresOrganHelper` | Agregasi daftar milestone per organ: status, rasio, persentase, milestone berikutnya, ringkasan teks | Must Have |
| Kartu ringkasan per organ di layar Pemulihan Kesehatan | Satu kartu per organ (ikon, nama organ, status ringkas, persentase) di atas daftar milestone | Must Have |
| Halaman detail per organ | `DetailOrganPemulihanScreen` menampilkan seluruh milestone organ terpilih + progres | Must Have |
| Disclaimer non-medis | Teks "ilustrasi umum, bukan kondisi medis Anda" pada layar pemulihan | Must Have |

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

### Alur 1: Melihat Ringkasan Pemulihan per Organ

1. Pengguna membuka **Pemulihan Kesehatan** dari menu "Lainnya" atau dari kartu "Milestone berikutnya" di Dashboard.
2. Aplikasi mengecek `biodataProvider`; jika `biodata == null` → tampilkan empty state "Belum ada data biodata" dengan CTA "Isi Biodata"; jika `tanggalMulaiBerhentiMerokok == null` → tampilkan empty state "Belum ada tanggal mulai berhenti".
3. Jika data tersedia, aplikasi menghitung durasi smoke-free dan menampilkan **kartu ringkasan per organ** (jantung, paru, sirkulasi, saraf) di bagian atas.
4. Setiap kartu organ menampilkan ikon organ, nama organ, status ringkas ("Selesai", "Berjalan", "Belum dimulai"), dan persentase progres organ tersebut.
5. Di bawah kartu organ tetap ditampilkan daftar milestone lengkap (urutan kronologis) seperti sebelumnya.
6. Di bagian bawah layar ditampilkan disclaimer: "Ilustrasi umum, bukan kondisi medis Anda."

### Alur 2: Membuka Detail Satu Organ

1. Pengguna menekan salah satu kartu organ.
2. Aplikasi membuka `DetailOrganPemulihanScreen` dengan argumen organ terpilih.
3. Layar detail menampilkan: nama organ + ikon, persentase pemulihan organ, milestone berikutnya + sisa waktu, lalu daftar milestone milik organ tersebut dengan status tercapai/belum.
4. Jika organ belum memiliki milestone yang tercapai, seluruh item berstatus "belum" dengan progres 0%.
5. Pengguna menekan tombol kembali untuk kembali ke layar Pemulihan Kesehatan.

### Alur 3: Kondisi Data Belum Lengkap

1. Pengguna membuka Pemulihan Kesehatan tanpa biodata → empty state + CTA "Isi Biodata".
2. Pengguna menekan CTA → `FormBiodata` dibuka; setelah biodata tersimpan dan tanggal mulai berhenti terisi, layar pemulihan menampilkan kartu organ.
3. Jika durasi smoke-free negatif (tanggal mulai berhenti di masa depan), durasi diperlakukan sebagai nol sehingga seluruh organ berstatus "belum dimulai" tanpa error.

## 5. Steps

**Konteks penggunaan:**
Digunakan untuk menjelaskan urutan langkah-langkah kerja yang harus diikuti dalam mengisi atau menerapkan PRD.

**Aturan pengisian:**

- Buat langkah-langkah yang spesifik dan dapat diikuti.
- Gunakan numbered list untuk mempertahankan urutan.
- Setiap langkah harus tidak ambigu dan dapat dikerjakan.
- Jangan memasukkan langkah yang tidak relevan atau redundan.

**Isi:**

1. **Enum organ** — buat `lib/shared/konstanta/organ_pemulihan.dart`:

```dart
import 'package:flutter/material.dart';

/// Sistem organ yang dipulihkan setelah berhenti merokok.
enum OrganPemulihan { jantung, paru, sirkulasi, saraf }

/// Extension label dan ikon untuk [OrganPemulihan].
extension OrganPemulihanExtension on OrganPemulihan {
  String get label {
    switch (this) {
      case OrganPemulihan.jantung:
        return 'Jantung';
      case OrganPemulihan.paru:
        return 'Paru-paru';
      case OrganPemulihan.sirkulasi:
        return 'Sirkulasi darah';
      case OrganPemulihan.saraf:
        return 'Saraf & indra';
    }
  }

  IconData get icon {
    switch (this) {
      case OrganPemulihan.jantung:
        return Icons.monitor_heart_outlined;
      case OrganPemulihan.paru:
        return Icons.air;
      case OrganPemulihan.sirkulasi:
        return Icons.water_drop_outlined;
      case OrganPemulihan.saraf:
        return Icons.psychology_alt_outlined;
    }
  }
}
```

Ikon memakai `package:flutter/material.dart` (konsisten dengan `PemicuEnumExtension` yang juga memakai `Icons.*`).

2. **Model milestone** — ubah `lib/shared/konstanta/milestone_kesehatan.dart`:
   - Tambah `import 'package:berhenti_merokok/shared/konstanta/organ_pemulihan.dart';`
   - Tambah field `final OrganPemulihan organ;` pada `MilestoneKesehatan` dan parameter constructor `required this.organ`.
   - Isi `organ` pada seluruh 12 entri `daftarMilestoneKesehatan`:

```dart
MilestoneKesehatan(
  target: Duration(minutes: 20),
  judul: '20 Menit',
  deskripsi: 'Tekanan darah dan denyut jantung mulai kembali ke tingkat normal.',
  organ: OrganPemulihan.jantung,
),
```

   Pemetaan yang disepakati (tanpa menambah/mengurangi milestone):

| Milestone | Organ |
| --------- | ----- |
| 20 Menit | jantung |
| 8 Jam | sirkulasi |
| 24 Jam | jantung |
| 48 Jam | saraf |
| 72 Jam | paru |
| 2 Minggu | sirkulasi |
| 3 Bulan | paru |
| 9 Bulan | paru |
| 1 Tahun | jantung |
| 5 Tahun | sirkulasi |
| 10 Tahun | paru |
| 15 Tahun | jantung |

3. **Helper agregasi** — buat `lib/fitur/pemulihan_kesehatan/helper/progres_organ_helper.dart` (helper murni, tanpa `BuildContext`/provider, tanpa dependency baru):
   - `static List<MilestoneKesehatan> milestoneOrgan(OrganPemulihan organ)` — filter `daftarMilestoneKesehatan`.
   - `static double rasioOrgan(Duration durasi, OrganPemulihan organ)` — rasio 0.0–1.0 dari milestone terakhir organ dibanding durasi (reuse `ProgresMilestoneHelper.rasio`, clamp 0–1).
   - `static int persentaseOrgan(Duration durasi, OrganPemulihan organ)` — `rasioOrgan * 100` dibulatkan.
   - `static bool organSelesai(Duration durasi, OrganPemulihan organ)` — `true` bila seluruh milestone organ tercapai.
   - `static MilestoneKesehatan? milestoneBerikutnyaOrgan(Duration durasi, OrganPemulihan organ)` — milestone organ pertama yang belum tercapai.
   - `static String ringkasanStatus(Duration durasi, OrganPemulihan organ)` — `"Selesai"` / `"Berjalan"` / `"Belum dimulai"`.

```dart
static double rasioOrgan(Duration durasi, OrganPemulihan organ) {
  final list = milestoneOrgan(organ);
  if (list.isEmpty) return 0.0;
  final aman = durasi.isNegative ? Duration.zero : durasi;
  return ProgresMilestoneHelper.rasio(aman, list.last.target);
}
```

4. **Kartu ringkasan organ** — pada `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart`:
   - Tambah import `organ_pemulihan.dart` dan `progres_organ_helper.dart`.
   - Di `Column` utama, sisipkan widget baru di atas `Expanded(child: ListView.separated(...))`:

```dart
Widget _buildRingkasanOrgan(BuildContext context, Duration durasi) {
  final textTheme = Theme.of(context).textTheme;
  return SizedBox(
    height: 108,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: OrganPemulihan.values.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final organ = OrganPemulihan.values[index];
        final persen = ProgresOrganHelper.persentaseOrgan(durasi, organ);
        final selesai = ProgresOrganHelper.organSelesai(durasi, organ);
        return SizedBox(
          width: 140,
          child: Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => _bukaDetailOrgan(context, organ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Icon(organ.icon, color: selesai ? Colors.green : null),
                    Text(organ.label, style: textTheme.titleSmall),
                    Text(
                      ProgresOrganHelper.ringkasanStatus(durasi, organ),
                      style: textTheme.bodySmall,
                    ),
                    LinearProgressIndicator(
                      value: persen / 100,
                      minHeight: 6,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest,
                      color: selesai ? Colors.green : null,
                    ),
                    Text('$persen%', style: textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
```

5. **Navigasi detail organ** — tambahkan method pada state layar:

```dart
void _bukaDetailOrgan(BuildContext context, OrganPemulihan organ) {
  unawaited(
    Nav.to(context, DetailOrganPemulihanScreen(organ: organ)).catchError((
      Object e,
      StackTrace s,
    ) {
      L.e('Gagal membuka detail organ $organ: $e $s');
      return null;
    }),
  );
}
```

6. **Halaman detail organ** — buat `lib/fitur/pemulihan_kesehatan/screens/detail_organ_pemulihan_screen.dart`:
   - Terima `final OrganPemulihan organ` sebagai parameter wajib.
   - Ambil durasi smoke-free dari `biodataProvider` dengan penanganan `isLoading`, `hasError`, `biodata == null`, dan `tanggalMulaiBerhentiMerokok == null` seperti pola `PemulihanKesehatanScreen`.
   - Tampilkan header organ (ikon + label + persentase + `LinearProgressIndicator`), kartu "Milestone berikutnya" + sisa waktu, lalu daftar milestone organ.

```dart
class DetailOrganPemulihanScreen extends ConsumerWidget {
  const DetailOrganPemulihanScreen({required this.organ, super.key});

  final OrganPemulihan organ;
  // build: header organ + daftar ProgresOrganHelper.milestoneOrgan(organ)
}
```

7. **Disclaimer** — tambahkan teks di bawah daftar milestone pada `PemulihanKesehatanScreen`:

```dart
Text(
  'Ilustrasi umum, bukan kondisi medis Anda.',
  style: Theme.of(context).textTheme.bodySmall,
  textAlign: TextAlign.center,
),
```

8. **Verifikasi** — jalankan `dart analyze`, lalu uji manual: buka Pemulihan Kesehatan (kartu organ tampil, persentase sesuai durasi), tekan tiap kartu organ (detail terbuka), cek empty state saat biodata kosong, dan cek tampilan pada tema terang/gelap.

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
| ----------- | ---------------- | ------------------- |
| `refrensi_apk.md` (baris 980–987) | Diubah | Isi C16 dipindahkan ke PRD ini, lalu bagian C16 diberi penanda "sudah dibuat PRD" |
| `lib/shared/konstanta/organ_pemulihan.dart` | Dibuat | Enum `OrganPemulihan` + ekstensi label dan ikon |
| `lib/shared/konstanta/milestone_kesehatan.dart` | Diubah | Field `organ` pada `MilestoneKesehatan` + pemetaan 12 entri |
| `lib/fitur/pemulihan_kesehatan/helper/progres_organ_helper.dart` | Dibuat | Helper murni agregasi status pemulihan per organ |
| `lib/fitur/pemulihan_kesehatan/screens/pemulihan_kesehatan_screen.dart` | Diubah | Kartu ringkasan per organ + navigasi detail + disclaimer |
| `lib/fitur/pemulihan_kesehatan/screens/detail_organ_pemulihan_screen.dart` | Dibuat | Halaman detail milestone per organ |

**File yang sengaja tidak terdampak (di luar cakupan PRD ini):**

- `lib/fitur/dashboard/screens/dashboard_screen.dart` — hanya membaca `milestoneBerikutnya()` yang tetap ada; kartu "Milestone berikutnya" tidak diubah.
- `lib/fitur/pemulihan_kesehatan/helper/progres_milestone_helper.dart` — tetap dipakai apa adanya; `ProgresOrganHelper` akan menggunakannya sebagai basis perhitungan rasio.
- `test/progres_milestone_helper_test.dart` — helper lama tidak berubah sehingga test lama tetap valid.
- `lib/lainnya_screen.dart` — menu "Pemulihan Kesehatan" sudah mengarah ke layar yang sama.