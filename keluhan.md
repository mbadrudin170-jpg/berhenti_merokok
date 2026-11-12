# Keluhan

Daftar keluhan pengguna untuk dievaluasi. Setiap butir memuat gejala, konteks, dan bukti log.

1. **Gagal mencatat konsumsi rokok (catat cepat) — `table konsumsi_rokok has no column named pemicu`**
   - Tanggal/waktu log: 13 Nov 2026, 04:28
   - Aksi pengguna: menekan tombol catat cepat (`jumlah=1`, `isSlip=false`)
   - Platform: Web (`sqflite_common_ffi_web`), database `/berhenti_merokok.db`
   - Pesan error: `SqfliteFfiException(sqlite_error: 1, SqliteException(1): while preparing statement, table konsumsi_rokok has no column named pemicu, SQL logic error (code 1)`
   - Statement penyebab: `INSERT OR REPLACE INTO konsumsi_rokok (id, tanggal, jumlah, is_slip, catatan, pemicu, dibuat) VALUES (?, ?, ?, ?, NULL, NULL, ?)`
   - Dampak: pengguna tidak dapat menyimpan konsumsi rokok; dicoba berulang dan selalu gagal
   - Gejala penyerta: tidak ada; fitur lain (biodata, alasan berhenti) berjalan normal
   - Penyebab (hasil investigasi 2026-11-13): migrasi v14 (`ALTER TABLE konsumsi_rokok ADD COLUMN pemicu TEXT`) hanya ada di `onUpgrade`, sedangkan `onCreate` tidak menyertakan kolom `pemicu`, sehingga database yang dibuat baru pada versi 14 (termasuk web FFI) tidak memiliki kolom tersebut
   - Tindak lanjut: `_buatTabel` diperbaiki menyertakan `pemicu TEXT`, `_versiDatabase` naik 14 → 15, `onUpgrade` cabang v15 menambahkan kolom bila belum ada (cek `PRAGMA table_info`). Sudah di-commit sebagai `230f0b1` (`fix(sqflite): perbaikan kolom pemicu pada migrasi database ke v15`). Verifikasi statis (2026-11-13): skema instalasi baru (`_buatTabel` v15) dibandingkan tabel per tabel dengan hasil chain `onUpgrade` v1→v15 (biodata, impian, diary_craving, alasan_berhenti, konsumsi_rokok + indeks `idx_konsumsi_tanggal`, sos_intervensi, rencana_darurat) — identik. Verifikasi runtime (menjalankan ulang aplikasi, mencatat konsumsi rokok) masih menunggu pengguna.
