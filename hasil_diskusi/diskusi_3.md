# Hasil Diskusi 3 — Mencegah Berulangnya Kesalahan Skema `onCreate`/`onUpgrade` oleh Model AI

## Status
- Dokumen: Final
- Implementasi: Sedang Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Pencegahan agar model AI tidak mengulangi kesalahan perubahan skema database (migrasi `onUpgrade` tanpa memperbarui definisi `CREATE TABLE` di `onCreate`) pada proyek berhenti_merokok

## Latar Belakang

`keluhan.md` butir 1 (log 13 Nov 2026, 04:28, web FFI, database `/berhenti_merokok.db`): pengguna gagal mencatat konsumsi rokok dengan `jumlah=1` (`INSERT OR REPLACE INTO konsumsi_rokok (id, tanggal, jumlah, is_slip, catatan, pemicu, dibuat) VALUES (?, ?, ?, ?, NULL, NULL, ?)`) dengan galat `SqfliteFfiException(sqlite_error: 1 ... table konsumsi_rokok has no column named pemicu ...)`.

Hasil investigasi 2026-11-13: migrasi v14 (`ALTER TABLE konsumsi_rokok ADD COLUMN pemicu TEXT`) hanya ditambahkan di `onUpgrade` (`lib/shared/db/sqflite/sqflite.dart`), sedangkan definisi `CREATE TABLE konsumsi_rokok` di `_buatTabel` (onCreate) tidak diperbarui. Database yang dibuat baru pada versi 14 — termasuk database web FFI — sehingga tidak memiliki kolom `pemicu`.

Tindak lanjut yang sudah dikerjakan (belum di-commit, per `keluhan.md`): `_buatTabel` kini menyertakan `${NamaKolom.pemicu} TEXT`, `_versiDatabase` naik 14 → 15, dan cabang `onUpgrade` v15 menambahkan kolom secara kondisional (`PRAGMA table_info`) agar database versi 14 yang terlanjur dibuat tanpa kolom ikut diperbaiki.

Celah pada skill yang berlaku:

- `.agents/skills/custom/migrasi-skema-sqlite/SKILL.md` aturan 2 hanya mewajibkan `onCreate` membuat **tabel** (agar instalasi baru memiliki skema lengkap) dan aturan 6 mewajibkan `ALTER TABLE ... ADD COLUMN` di `onUpgrade` — tidak ada aturan eksplisit yang mewajibkan perubahan kolom/indeks pada tabel lama dicerminkan di definisi `CREATE TABLE` pada `onCreate`. Contoh "Contoh Benar" pada skill itu pun hanya menunjukkan pembuatan tabel baru.
- `.agents/skills/bawaan/sqflite-open-database/SKILL.md` (bagian "Migration chain with batches") sudah mendokumentasikan pola satu sumber DDL: `onCreate` membangun skema lewat langkah-langkah (`_createV1`, `_upgradeV1ToV2`) yang sama dengan `onUpgrade`, bukan lewat DDL duplikat. Pada proyek ini pola tersebut belum diterapkan di `sqflite.dart`.
- Tidak ada tes/verifikasi skema yang berjalan di `flutter test` untuk menguji `onCreate` menghasilkan skema lengkap.

## Poin Diskusi

### 1. Cakupan diskusi
- Tanya: Apakah diskusi membahas pencegahan kesalahan model AI secara umum, atau khusus kasus skema DB ini?
- Kesimpulan: Hanya kasus skema DB (`onCreate` vs `onUpgrade`).

### 2. Tindak lanjut diskusi
- Tanya: Apa tindak lanjut yang diinginkan?
- Kesimpulan: Dokumentasi diskusi + rekomendasi pembaruan skill (`migrasi-skema-sqlite`); bukan implementasi langsung, bukan paket lengkap (tes/checklist tidak dipilih).

### 3. Arah pembaruan skill `migrasi-skema-sqlite`
- Tanya: Arah apa yang disepakati?
- Kesimpulan: Opsi A + B — (A) aturan eksplisit sinkronisasi `onCreate`; (B) rekomendasi pola satu sumber DDL seperti pada `sqflite-open-database`, tanpa mewajibkan refactor kode pada tahap ini.

### 4. Waktu eksekusi pembaruan skill
- Tanya: Kapan skill diperbarui?
- Kesimpulan: Setelah perbaikan v15 di-commit, sesuai `.agents/rules/global/aturan_skill.md` §5 (isi `SKILL.md` wajib bersumber dari commit yang sudah ada).

### 5. Refactor kode `_buatTabel`
- Tanya: Apakah refactor `_buatTabel` agar memakai satu sumber DDL diajukan sekarang?
- Kesimpulan: Tidak dulu; tidak dijadikan rekomendasi/PRD pada tahap ini.

## Keputusan

- K-1: Cakupan diskusi ini hanya kasus skema database (`onCreate` vs `onUpgrade`); pencegahan kesalahan model AI di luar skema DB tidak dibahas.
- K-2: Diskusi ini hanya menghasilkan dokumentasi dan rekomendasi pembaruan skill; tidak ada perubahan file skill/kode pada tahap ini.
- K-3: Pembaruan `.agents/skills/custom/migrasi-skema-sqlite/SKILL.md` yang disepakati terdiri atas: (A) aturan eksplisit bahwa setiap perubahan kolom/indeks pada tabel yang sudah ada wajib dicerminkan di definisi `CREATE TABLE` pada `onCreate` (onCreate wajib mencerminkan skema versi terkini secara penuh), disertai checklist verifikasi `PRAGMA table_info`; (B) rekomendasi pola satu sumber DDL — `onCreate` membangun skema lewat langkah-langkah yang sama dengan `onUpgrade` sebagaimana pola pada `sqflite-open-database` — sebagai standar baru, tanpa mewajibkan refactor kode pada tahap ini.
- K-4: Pembaruan skill dieksekusi setelah perbaikan v15 di-commit; isi skill diambil dari commit perbaikan (bukan working tree) sesuai `.agents/rules/global/aturan_skill.md` §5.
- K-5: Refactor kode `_buatTabel` (satu sumber DDL) tidak diajukan sebagai rekomendasi atau PRD pada tahap ini; dapat dibahas terpisah di kemudian hari.
- K-6: Berkas hasil diskusi dinamai `diskusi_3.md` karena `diskusi_2.md` ("Pembuatan Prompt untuk Mode Ask dan Debug") sudah ada; `MEMORI.md` belum mencatat `diskusi_2.md` dan dikoreksi pada interaksi ini.

## Rekomendasi

- R-1: Setelah commit perbaikan v15 tersedia, perbarui `.agents/skills/custom/migrasi-skema-sqlite/SKILL.md`: tambahkan aturan A dan rekomendasi B (dengan contoh dari commit perbaikan v15), tambahkan checklist verifikasi `PRAGMA table_info` per tabel setelah perubahan skema, dan perbarui `metadata.diperbarui` serta `metadata.sumber-terakhir` (hash commit) sesuai `aturan_skill.md` §7.1.
- R-2: Perbarui kolom `Status : diperbarui` pada entri skill tersebut di `SKILLS_INDEX.md` bila isi skill berubah (tanpa menambah/menghapus entri).
- R-3: Setelah pembaruan skill, verifikasi bahwa skema database instalasi baru identik dengan hasil chain `onUpgrade` (mis. `PRAGMA table_info` untuk setiap tabel) sebelum `keluhan.md` butir 1 ditandai tuntas; perbarui `MEMORI.md` (bagian status/keluhan dan riwayat perubahan).
- R-4: Pertimbangkan pengujian skema otomatis (mis. via `sqflite_common_ffi`, sesuai skill `sqflite-testing-and-platforms`) sebagai pembahasan terpisah; belum disepakati pada diskusi ini.

## Tindak Lanjut

| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1  | Commit perbaikan skema DB v15 (`_buatTabel` menyertakan `pemicu TEXT`, `_versiDatabase` 14 → 15, cabang `onUpgrade` v15 kondisional `PRAGMA table_info`) | `lib/shared/db/sqflite/sqflite.dart` | selesai (`230f0b1` — `fix(sqflite): perbaikan kolom pemicu pada migrasi database ke v15`) |
| 2  | Setelah commit: perbarui skill `migrasi-skema-sqlite` sesuai R-1 (aturan A + rekomendasi B + checklist `PRAGMA table_info`) | `.agents/skills/custom/migrasi-skema-sqlite/SKILL.md` | selesai (`migrasi-skema-sqlite` v1.2.0 — aturan 12–14 + `## Steps` + contoh bug v14/perbaikan v15; `metadata.sumber-terakhir` = `230f0b1`) |
| 3  | Perbarui `SKILLS_INDEX.md` (tanggal diperbarui entri skill) bila R-1 dijalankan | `SKILLS_INDEX.md` | selesai (entri no. 20, diperbarui Fri Nov 13 2026 04:56:47 WIB) |
| 4  | Verifikasi skema instalasi baru vs chain `onUpgrade`, lalu perbarui `keluhan.md` dan `MEMORI.md` | `keluhan.md`, `MEMORI.md` | selesai sebagian — verifikasi **statis** (DDL per tabel identik) selesai & `keluhan.md` diperbarui; verifikasi runtime (aplikasi berjalan) menunggu pengguna |

## File Terdampak

| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `lib/shared/db/sqflite/sqflite.dart` | Diubah (belum di-commit) | Perbaikan v15: `_buatTabel` menyertakan kolom `pemicu TEXT`; `_versiDatabase` 15; cabang `onUpgrade` v15 menambah kolom hanya bila belum ada (cek `PRAGMA table_info`) |
| `.agents/skills/custom/migrasi-skema-sqlite/SKILL.md` | Akan diubah (R-1) | Tambah aturan sinkronisasi `onCreate` + rekomendasi pola satu sumber DDL + checklist `PRAGMA table_info`; perbarui `metadata.diperbarui` dan `metadata.sumber-terakhir` |
| `SKILLS_INDEX.md` | Akan diubah (R-2) | Perbarui tanggal diperbarui entri skill bila isi skill berubah |
| `MEMORI.md` | Diubah (interaksi ini) | Catat `diskusi_2.md` (belum tercatat) dan `diskusi_3.md`; perbaiki bagian Lokasi/Riwayat Hasil Diskusi dan Riwayat Perubahan |

## Pertanyaan Terbuka

- Apakah pengujian skema otomatis (R-4) akan dibahas terpisah pada diskusi lain? Belum dibahas.
- Perbaikan v15 sudah di-commit sebagai `230f0b1` (`fix(sqflite): perbaikan kolom pemicu pada migrasi database ke v15`); prasyarat R-1..R-3 terpenuhi.

## Riwayat Perubahan

| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Berkas dibuat berdasarkan hasil diskusi: cakupan kasus skema DB saja; tindak lanjut dokumentasi + rekomendasi skill; arah pembaruan skill Opsi A + B; pembaruan skill menunggu commit perbaikan v15; refactor `_buatTabel` tidak diajukan. |
| 2026-11-13 | Perbaikan v15 di-commit sebagai `230f0b1` (`fix(sqflite): perbaikan kolom pemicu pada migrasi database ke v15`); prasyarat R-1..R-3 terpenuhi. Bagian Tindak Lanjut (no. 1) dan Pertanyaan Terbuka disesuaikan. Implementasi R-1..R-3 belum dijalankan. |
| 2026-11-13 | R-1..R-3 dikerjakan: (R-1) `migrasi-skema-sqlite` diperbarui ke v1.2.0 — aturan 12 (sinkronisasi kolom/indeks `onUpgrade` → definisi `CREATE TABLE` di `onCreate`), aturan 13 (verifikasi `PRAGMA table_info` per tabel), aturan 14 (rekomendasi pola satu sumber DDL, tanpa mewajibkan refactor), `## Steps` checklist, contoh bug v14 & perbaikan v15 (`230f0b1`), `metadata.diperbarui`/`metadata.sumber-terakhir` diperbarui; (R-2) `SKILLS_INDEX.md` entri no. 20 diperbarui; (R-3) verifikasi statis DDL per tabel (identik) — `keluhan.md` butir 1 diperbarui, verifikasi runtime menunggu pengguna. Implementasi diubah ke `Sedang Diimplementasikan`. |
