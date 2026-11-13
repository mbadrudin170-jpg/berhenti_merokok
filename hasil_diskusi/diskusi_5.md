# Hasil Diskusi 5 — Restrukturisasi MEMORI.md ke subfolder memori/

## Status
- Dokumen: Draft
- Implementasi: Belum Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Ide memindahkan sebagian isi MEMORI.md ke subfolder baru di memori/ agar MEMORI.md lebih ringan, dengan rujukan eksplisit dan pencegahan memori stale.

## Latar Belakang
Pengguna mengusulkan pembuatan folder baru di `memori/` untuk memindahkan (mengeluarkan) sebagian isi `MEMORI.md` ke subfolder baru, agar `MEMORI.md` lebih ringan. Ide ini muncul setelah diskusi_4 (rekomendasi isi MEMORI.md lintas sesi) dan diskusi tentang memori stale. Pola serupa sudah ada: riwayat perubahan dipindah ke `memori/riwayat_perubahan.md`; hasil diskusi di `hasil_diskusi/`. Diskusi ini mengevaluasi keuntungan, risiko, dan rekomendasi minimal penerapan.

## Poin Diskusi

### 1. Keuntungan restrukturisasi ke subfolder
- Tanya: Apa keuntungan memindahkan sebagian isi MEMORI.md ke subfolder memori/?
- Kesimpulan: MEMORI.md lebih ringan dan fokus pada ringkasan + rujukan; pola sudah ada (riwayat perubahan, hasil diskusi); detail panjang (struktur fitur, enum, file konfigurasi, catatan teknis) bisa dipindah, MEMORI.md cukup rujukan 'baca file X untuk detail'.

### 2. Risiko restrukturisasi ke subfolder
- Tanya: Apa risiko memindahkan sebagian isi MEMORI.md ke subfolder?
- Kesimpulan: Model AI harus tahu membaca subfolder; jika tidak terdaftar di instructions atau rujukan tidak jelas, konteks hilang (memori stale lebih parah). Fragmentasi: lebih banyak file yang harus disinkronkan tiap sesi. Skill memori-check wajib membaca MEMORI.md; jika MEMORI.md hanya rujukan, model mungkin tidak membaca detail.

### 3. Rekomendasi minimal penerapan
- Tanya: Jika dilakukan, bagaimana penerapan minimal yang aman?
- Kesimpulan: (1) Buat subfolder `memori/arsip/` (atau `memori/detail/`) dengan file tematik: `status_proyek.md`, `struktur_fitur.md`, `file_konfigurasi.md`, `catatan_teknis.md`, `aturan.md`. (2) MEMORI.md tetap berisi ringkasan + rujukan eksplisit 'baca memori/arsip/X.md untuk detail' pada setiap bagian yang dipindah. (3) Tambahkan subfolder ke instructions (`.kilo/kilo.jsonc`) atau pastikan skill memori-check memuatnya, agar model selalu membaca. (4) Pertahankan "Status Working Tree" & "Prioritas/Roadmap Pekerjaan" di MEMORI.md (dinamis, sering berubah) — jangan dipindah. (5) Sinkronisasi: setiap sesi yang mengubah detail wajib memperbarui file subfolder, bukan hanya MEMORI.md.

### 4. File mana yang dipindah vs tetap di MEMORI.md
- Tanya: File/informasi mana yang dipindah ke subfolder, dan mana yang tetap di MEMORI.md?
- Kesimpulan: Dipindah (stabil, panjang, jarang berubah): struktur utama (layar/fitur, dependency, provider, enum), file konfigurasi & penting, catatan teknis penting, aturan yang harus dipelihara, referensi commit. Tetap di MEMORI.md (ringkasan + rujukan): identitas & status proyek, lokasi hasil diskusi, riwayat diskusi, status working tree, prioritas/roadmap pekerjaan, catatan untuk model selanjutnya, lokasi subfolder. Rujukan eksplisit wajib pada setiap bagian yang dipindah.

### 5. Sinkronisasi dan pencegahan memori stale pada subfolder
- Tanya: Bagaimana mencegah memori stale pada subfolder?
- Kesimpulan: Rujukan eksplisit di MEMORI.md (path + nama file) agar model tahu membaca; tambahkan subfolder ke instructions atau skill memori-check; setiap sesi yang mengubah detail memperbarui file subfolder dan mencatat di memori/sesi/; catch-up sync tetap berlaku; bila konflik antara MEMORI.md dan subfolder, tanyakan ke pengguna.

## Keputusan
- K-1: Ide restrukturisasi MEMORI.md ke subfolder memori/ layak dievaluasi, dengan rekomendasi minimal penerapan (subfolder `memori/arsip/`, rujukan eksplisit, tambah ke instructions/skill, pertahankan bagian dinamis di MEMORI.md, sinkronisasi wajib).
- K-2: File yang dipindah = detail stabil dan panjang (struktur utama, file konfigurasi, catatan teknis, aturan, referensi commit); yang tetap di MEMORI.md = ringkasan + rujukan + bagian dinamis (status working tree, roadmap, lokasi hasil diskusi, riwayat diskusi, catatan untuk model selanjutnya).
- K-3: Subfolder yang disarankan = `memori/arsip/` (nama dapat disesuaikan pengguna) dengan file tematik.
- K-4: Rujukan eksplisit di MEMORI.md wajib pada setiap bagian yang dipindah (path + nama file) agar model AI membaca subfolder.
- K-5: Tambahkan subfolder ke instructions (`.kilo/kilo.jsonc`) atau skill memori-check agar model selalu membaca; tanpa ini, konteks hilang.
- K-6: Pertahankan "Status Working Tree" & "Prioritas/Roadmap Pekerjaan" di MEMORI.md (dinamis) — jangan dipindah.
- K-7: Sinkronisasi: setiap sesi yang mengubah detail wajib memperbarui file subfolder dan mencatat di memori/sesi/; catch-up sync tetap berlaku; konflik antara MEMORI.md dan subfolder → tanyakan ke pengguna.

## Rekomendasi
- R-1: Buat subfolder `memori/arsip/` dengan file tematik (`status_proyek.md`, `struktur_fitur.md`, `file_konfigurasi.md`, `catatan_teknis.md`, `aturan.md`) — nama dapat disesuaikan pengguna.
- R-2: Pindahkan detail stabil dan panjang dari MEMORI.md ke file subfolder; MEMORI.md tetap berisi ringkasan + rujukan eksplisit.
- R-3: Tambahkan subfolder ke instructions (`.kilo/kilo.jsonc`) atau skill memori-check agar model selalu membaca.
- R-4: Pertahankan bagian dinamis (status working tree, roadmap, lokasi hasil diskusi, riwayat diskusi, catatan untuk model selanjutnya) di MEMORI.md.
- R-5: Setiap sesi yang mengubah detail memperbarui file subfolder dan mencatat di memori/sesi/; konflik → tanyakan ke pengguna.
- R-6: Implementasi restrukturisasi menunggu perintah eksplisit pengguna (alur "Dokumentasi dulu").

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1 | Buat berkas hasil diskusi `diskusi_5.md` (Draft) | `hasil_diskusi/diskusi_5.md` | selesai |
| 2 | Finalisasi status Dokumen setelah disepakati pengguna | `hasil_diskusi/diskusi_5.md` | belum |
| 3 | (Opsional) Implementasi restrukturisasi (buat subfolder, pindah detail, rujukan eksplisit, tambah ke instructions/skill, sinkronisasi) — menunggu perintah eksplisit pengguna | `memori/`, `MEMORI.md`, `.kilo/kilo.jsonc` | belum |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_5.md` | Dibuat | Berkas hasil diskusi restrukturisasi MEMORI.md ke subfolder memori/ (Draft) |
| `MEMORI.md` | Diubah | Lokasi Hasil Diskusi & Riwayat Diskusi diperbarui (diskusi_5) |
| `memori/riwayat_perubahan.md` | Diubah | Entri pembuatan diskusi_5 |
| `memori/sesi/sesi_15.md` | Dibuat/Diubah | Catatan sesi diperbarui |

## Pertanyaan Terbuka
- Apakah ide restrukturisasi (subfolder `memori/arsip/`) akan diimplementasikan? Menunggu keputusan pengguna.
- Nama subfolder dan daftar file tematik final menunggu konfirmasi pengguna.

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Berkas dibuat (Draft) — restrukturisasi MEMORI.md ke subfolder memori/ |
