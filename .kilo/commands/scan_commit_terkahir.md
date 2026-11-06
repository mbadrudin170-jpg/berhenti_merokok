---
description: Audit 10 commit terakhir terhadap AGENTS.md dan sinkronkan task.md
agent: code
---

# Audit 10 Commit Terakhir

## Tujuan

Lakukan evaluasi terhadap 10 commit terakhir pada branch Git yang sedang aktif untuk memastikan bahwa perubahan kode sudah sesuai dengan seluruh aturan yang berlaku di `AGENTS.md`.

Jika ditemukan pelanggaran aturan yang masih terdapat pada kode saat ini, tambahkan atau perbarui tugas di `task.md`.

Selain itu, periksa seluruh tugas lama di `task.md`. Jika suatu tugas berstatus belum dikerjakan, tetapi implementasinya ternyata sudah selesai, hapus tugas tersebut dari `task.md`.

**Fokus utama:**

1. Mengevaluasi kepatuhan 10 commit terakhir terhadap `AGENTS.md`.
2. Menemukan pelanggaran aturan yang masih tersisa.
3. Menambahkan atau memperbarui tugas untuk pelanggaran yang belum diperbaiki.
4. Menghapus tugas lama yang sebenarnya sudah selesai diimplementasikan.

---

# TAHAP 1 — MEMBACA ATURAN PROYEK

Sebelum melakukan evaluasi, lakukan langkah berikut:

1. Baca `AGENTS.md` yang berlaku pada root proyek.
2. Periksa apakah terdapat `AGENTS.md` tambahan di direktori lain.
3. Baca aturan tambahan yang berlaku untuk file atau direktori yang mengalami perubahan.
4. Baca seluruh dokumen aturan lain yang secara eksplisit dirujuk oleh `AGENTS.md`.
5. Pahami seluruh aturan sebelum mulai mengevaluasi commit.

**Ketentuan:**

- Jadikan `AGENTS.md` dan aturan proyek yang berlaku sebagai standar utama evaluasi.
- Jangan membuat standar atau aturan baru berdasarkan asumsi pribadi.
- Jangan menganggap suatu kode melanggar aturan jika tidak terdapat dasar yang jelas.
- Apabila terdapat aturan yang saling bertentangan dan prioritasnya tidak dapat ditentukan, jangan mengambil keputusan berdasarkan asumsi. Catat konflik tersebut dalam laporan.
- Jangan mengubah isi `AGENTS.md` maupun file aturan lainnya.

# TAHAP 2 — MEMERIKSA 10 COMMIT TERAKHIR

Gunakan Git untuk mendapatkan 10 commit terbaru dari `HEAD` pada branch yang sedang aktif.

Periksa terlebih dahulu:

- Branch yang sedang aktif.
- Jumlah commit yang tersedia.
- Hash setiap commit.
- Pesan commit.
- Tanggal commit.
- Daftar file yang mengalami perubahan.

Contoh perintah:

```bash
git status --short
git branch --show-current
git log -10 --date=short --format="%h | %ad | %s"
```
