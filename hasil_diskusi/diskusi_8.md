# Hasil Diskusi 8 — Folder `memori/sesi/` untuk catatan sesi AI sebelum mengubah `MEMORI.md`

## Status
- Dokumen: Final
- Implementasi: Belum Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Pembuatan folder `memori/sesi/` dan berkas `sesi_N.md` bernomor sebagai catatan tiap sesi AI; `MEMORI.md` tidak boleh langsung diubah — AI membuat file sesi baru terlebih dahulu, lalu memperbarui `MEMORI.md` di akhir sesi dengan catatan yang relevan dari sesi tersebut; file sesi memuat status sinkron (sudah/belum)

## Latar Belakang
Pengguna ingin agar AI tidak langsung mengubah isi `MEMORI.md` setiap interaksi, melainkan membuat catatan per sesi terlebih dahulu di dalam folder baru `memori/sesi/`. Catatan sesi memuat status sinkron (sudah/belum); di akhir sesi, model AI memperbarui isi `MEMORI.md` dengan catatan yang relevan dengan sesi tersebut. Saat ini folder `memori/` hanya berisi `memori/riwayat_perubahan.md` (diverifikasi 2026-11-13). Pembahasan dilakukan dalam Mode Diskusi; pengguna memilih "Dokumentasi dulu" (belum mengubah skill `memori-check`, `AGENTS.md`, atau rules) dan meminta hasil didokumentasikan ke `diskusi_8.md`.

## Poin Diskusi
### 1. Tujuan utama folder `memori/sesi/`
- Tanya: Apa tujuan utama folder `memori/sesi/` yang diinginkan?
- Kesimpulan: Untuk catatan tiap sesi, dengan status "sudah sinkron" dan "belum sinkron". Di akhir sesi, model AI memperbarui isi `MEMORI.md` dengan catatan yang relevan dengan sesi tersebut. File sesi menjadi perantara (staging) antara sesi kerja dan `MEMORI.md`, bukan pengganti `MEMORI.md`.

### 2. Format penamaan file
- Tanya: Bagaimana format penamaan file di dalam `memori/sesi/`?
- Kesimpulan: `sesi_N.md` bernomor (contoh `sesi_1.md`, `sesi_2.md`, …). Penomoran mengikuti pola berkas hasil diskusi: nomor tertinggi + 1; gap tidak diisi.

### 3. Isi/struktur file sesi
- Tanya: Apa isi/struktur yang diinginkan dalam setiap file `sesi_N.md`?
- Kesimpulan: Struktur lengkap, memuat sekurang-kurangnya: tanggal, status sinkron (`Belum Sinkron` / `Sudah Sinkron`), topik sesi, catatan perubahan, dan berkas terdampak. Disertai bagian `## Sinkronisasi ke MEMORI.md` (ringkasan apa yang sudah disalin/disesuaikan ke `MEMORI.md` pada akhir sesi) agar status "Sudah Sinkron" dapat diverifikasi.

### 4. Kapan file sesi dibuat dan oleh siapa
- Tanya: Kapan file sesi dibuat dan oleh siapa?
- Kesimpulan: Awal sesi (otomatis) — AI membuat file sesi baru pada awal setiap sesi/interaksi yang dikerjakan di proyek ini, tanpa menunggu diminta.

### 5. Ruang lingkup perubahan saat ini
- Tanya: Apakah perubahan ini sekaligus mengubah skill `memori-check` / `AGENTS.md` / rules, atau hanya membuat foldernya dulu?
- Kesimpulan: Dokumentasi saja dulu — hanya membuat folder `memori/sesi/` dan berkas `sesi_N.md`; skill `memori-check`, `AGENTS.md`, dan rules **belum** diubah. Perubahan aturan (agar AI wajib membuat file sesi di awal sesi dan menandai "Sudah Sinkron" setelah `MEMORI.md` diperbarui) menunggu perintah eksplisit pengguna.

### 6. Hasil yang diharapkan dari diskusi ini
- Tanya: Apa hasil yang diinginkan dari diskusi ini?
- Kesimpulan: Mendokumentasikan diskusi ini ke `hasil_diskusi/diskusi_8.md`; folder `memori/sesi/` dan berkas pertama **belum** dibuat pada tahap ini.

## Keputusan
- K-1: Dibuat folder `memori/sesi/` di root proyek (di dalam `memori/`) sebagai tempat catatan per sesi AI.
- K-2: Nama berkas di dalam folder tersebut: `sesi_N.md` bernomor (`sesi_1.md`, `sesi_2.md`, …); penomoran memakai aturan tertinggi + 1, gap tidak diisi.
- K-3: Setiap file sesi memuat status sinkron dengan dua nilai: `Belum Sinkron` (default saat dibuat) dan `Sudah Sinkron` (setelah `MEMORI.md` diperbarui dengan catatan sesi tersebut pada akhir sesi).
- K-4: Struktur file sesi (struktur lengkap): `## Status` (status sinkron, tanggal, topik sesi), `## Catatan Sesi` (kronologi/poin penting sesi), `## Berkas Terdampak` (tabel lokasi file + status perubahan), dan `## Sinkronisasi ke MEMORI.md` (ringkasan penyesuaian `MEMORI.md` + waktu sinkronisasi).
- K-5: File sesi dibuat oleh AI secara otomatis pada awal sesi (bukan menunggu permintaan pengguna).
- K-6: Alur kerja yang disepakati: awal sesi → AI membuat `sesi_N.md` (status `Belum Sinkron`) → selama sesi, catatan/perubahan dicatat ke file sesi → akhir sesi → AI memperbarui `MEMORI.md` dengan catatan yang relevan dari file sesi → status file sesi diubah menjadi `Sudah Sinkron`.
- K-7: Cakupan saat ini hanya dokumentasi diskusi ke `diskusi_8.md`; pembuatan folder/berkas dan perubahan skill/rules menunggu perintah eksplisit pengguna (alur "Dokumentasi dulu").

## Rekomendasi
- R-1: Setelah perintah eksplisit pengguna, buat folder `memori/sesi/` beserta `sesi_1.md` sebagai berkas pertama (sebaiknya berisi template/contoh struktur K-4, bukan klaim sesi yang belum terjadi).
- R-2: Setelah folder tersedia, pertimbangkan pembaruan skill `memori-check` (dan bila perlu `AGENTS.md` aturan 5/10) agar kewajiban membuat file sesi di awal sesi dan menandai `Sudah Sinkron` di akhir sesi menjadi aturan tertulis — bukan hanya konvensi. Perubahan ini wajib mengikuti `.agents/rules/global/aturan_skill.md` dan menunggu persetujuan pengguna.
- R-3: Struktur `sesi_N.md` yang diusulkan:

  ```markdown
  # Sesi <N> — <topik sesi>

  ## Status
  - Status Sinkron: Belum Sinkron
  - Tanggal: YYYY-MM-DD
  - Topik: <ringkasan topik>

  ## Catatan Sesi
  - <poin penting, keputusan, langkah kerja>

  ## Berkas Terdampak
  | Lokasi File | Status Perubahan | Deskripsi |
  |-------------|------------------|-----------|
  | <file> | Dibuat / Diubah / Dihapus | <deskripsi> |

  ## Sinkronisasi ke MEMORI.md
  - <ringkasan bagian MEMORI.md yang diperbarui berdasarkan catatan sesi ini, atau "Belum disinkronkan">
  ```

- R-4: Tetapkan aturan kebersihan: `sesi_N.md` tidak dihapus otomatis setelah sinkron (berbeda dengan berkas hasil diskusi yang kadang dihapus atas permintaan pengguna); penghapusan hanya atas perintah eksplisit pengguna.
- R-5: Batasi isi `sesi_N.md` pada hal yang relevan dengan sesi (bukan duplikasi penuh `MEMORI.md`); `MEMORI.md` tetap dokumen hidup utama, file sesi hanya sumber bahan sinkronisasi.

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1  | Buat folder `memori/sesi/` dan berkas `sesi_1.md` (template/contoh struktur K-4) atas perintah eksplisit pengguna | `memori/sesi/sesi_1.md` | belum |
| 2  | Sinkronkan alur file sesi ke aturan tertulis: perbarui skill `memori-check` (dan bila perlu `AGENTS.md` aturan 5/10) agar AI wajib membuat `sesi_N.md` di awal sesi dan menandai `Sudah Sinkron` setelah `MEMORI.md` diperbarui di akhir sesi | `.agents/skills/custom/memori-check/SKILL.md`, `AGENTS.md` | belum |
| 3  | Perbarui `MEMORI.md` (Status Proyek, Lokasi/riwayat diskusi, bagian alur kerja sesi bila disepakati) setelah folder `memori/sesi/` dibuat | `MEMORI.md` | belum |
| 4  | Tambahkan entri riwayat perubahan untuk pembuatan folder/berkas sesi bila sudah dieksekusi | `memori/riwayat_perubahan.md` | belum |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_8.md` | Dibuat | Dokumentasi diskusi (berkas ini) |
| `memori/sesi/` | Dibuat (menunggu perintah) | Folder catatan sesi AI |
| `memori/sesi/sesi_1.md` | Dibuat (menunggu perintah) | Berkas sesi pertama / template |
| `.agents/skills/custom/memori-check/SKILL.md` | Diubah (menunggu perintah) | Aturan kewajiban file sesi di awal/akhir sesi |
| `AGENTS.md` | Diubah (menunggu perintah) | Rujukan aturan sesi (bila disepakati) |
| `MEMORI.md` | Diubah | Status Proyek, Lokasi Hasil Diskusi, Riwayat Diskusi |
| `memori/riwayat_perubahan.md` | Diubah | Entri riwayat diskusi_8 |

## Pertanyaan Terbuka
- Apakah setelah `memori/sesi/` dibuat, skill `memori-check` dan `AGENTS.md` langsung diperbarui agar kewajiban file sesi menjadi aturan tertulis, atau dibiarkan sebagai konvensi dulu?
- Apakah `sesi_N.md` boleh dihapus setelah sinkron, atau wajib diarsipkan permanen?
- Apakah nomor `sesi_N.md` direset per proyek (default) atau melanjutkan penomoran lintas proyek?
- Apakah file sesi dibuat untuk SETIAP interaksi (termasuk pertanyaan singkat), atau hanya interaksi yang mengubah proyek/berkas? (K-5 menetapkan "awal sesi otomatis"; cakupan interaksi belum disepakati.)

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Berkas dibuat (Mode Diskusi) — keputusan folder `memori/sesi/`, format `sesi_N.md` bernomor, struktur lengkap, pembuatan otomatis di awal sesi, status sinkron `Belum/Sudah Sinkron`, alur dokumentasi dulu; implementasi menunggu perintah eksplisit pengguna |
