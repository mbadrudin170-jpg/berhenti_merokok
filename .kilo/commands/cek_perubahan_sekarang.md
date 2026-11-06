---
description: Audit perubahan kode Dart yang belum di-commit berdasarkan AGENTS.md tanpa mengubah file
agent: ask
---

# Audit Perubahan Kode Dart Sebelum Commit

## 1. TUJUAN

Saya ingin memastikan seluruh perubahan kode Dart yang belum di-commit sudah sesuai dengan `AGENTS.md` dan aturan proyek yang berlaku.

Tugas Anda adalah melakukan pemeriksaan terhadap perubahan kode Dart, menemukan pelanggaran aturan, serta mengidentifikasi potensi bug yang muncul akibat perubahan tersebut.

Jika ditemukan masalah, cukup laporkan kepada saya beserta bukti dan rekomendasi perbaikannya.

**Saya sendiri yang akan memutuskan apakah suatu temuan perlu diperbaiki atau tidak.**

Jangan memperbaiki kode secara otomatis dan jangan mengubah keputusan saya.

## 2. BATASAN RUANG LINGKUP PEMERIKSAAN

**HANYA PERIKSA FILE KODE DART (`.dart`).**

Periksa seluruh perubahan file Dart yang belum di-commit, meliputi:

1. File Dart yang sudah diubah tetapi belum di-stage (unstaged).
2. File Dart yang sudah di-stage tetapi belum di-commit (staged).
3. File Dart baru yang belum dilacak Git (untracked).
4. File Dart yang dihapus atau dipindahkan.
5. File Dart yang mengalami perubahan sebagian, baik staged maupun unstaged.

Jangan memeriksa atau mengevaluasi perubahan pada file selain `.dart`.

Contoh file yang tidak boleh menjadi objek pemeriksaan:

- `pubspec.yaml`
- `pubspec.lock`
- `AGENTS.md`
- File Markdown (`.md`)
- File JSON (`.json`)
- File YAML (`.yaml` atau `.yml`)
- File konfigurasi lainnya.

Pengecualian:

`AGENTS.md`, aturan proyek, dan dokumentasi yang diwajibkan boleh dibaca sebagai referensi untuk memahami standar implementasi. Namun, file-file tersebut bukan objek audit dan jangan memberikan temuan mengenai perubahan di dalamnya.

Jika diperlukan untuk memahami konteks kode Dart, Anda boleh membaca file Dart lain yang tidak mengalami perubahan.

Akan tetapi, temuan harus berkaitan dengan perubahan Dart yang sedang diaudit, bukan masalah lama yang tidak berhubungan.

**Jangan memperluas ruang lingkup pemeriksaan ke bahasa pemrograman atau jenis file lainnya.**

## 3. TAHAP PERTAMA — MEMBACA ATURAN PROYEK

Sebelum memeriksa kode, lakukan langkah berikut:

1. Baca `AGENTS.md` pada root proyek.
2. Identifikasi `AGENTS.md` tambahan yang berlaku pada direktori file Dart yang berubah.
3. Baca aturan tambahan yang secara eksplisit diwajibkan oleh `AGENTS.md`.
4. Baca skill yang diwajibkan oleh aturan proyek sebelum melakukan evaluasi.
5. Pahami ketentuan yang berkaitan dengan implementasi Dart.

Ketentuan:

- Gunakan `AGENTS.md` dan aturan turunannya sebagai standar utama evaluasi.
- Jangan membuat standar baru berdasarkan asumsi pribadi.
- Jangan menganggap suatu pendekatan salah hanya karena Anda lebih menyukai pendekatan lain.
- Jangan mengabaikan aturan khusus yang berlaku pada direktori tertentu.
- Jangan mengubah atau memperbarui dokumen aturan.
- Jika terdapat aturan yang saling bertentangan, jelaskan konflik tersebut dan jangan mengambil keputusan berdasarkan asumsi.

Jika ada perubahan pada dokumen aturan yang belum di-commit, gunakan isi aturan yang berlaku di working tree sebagai referensi audit. Namun, jangan mengevaluasi perubahan dokumen tersebut.

## 4. TAHAP KEDUA — MENGIDENTIFIKASI PERUBAHAN DART

Periksa kondisi Git untuk mengidentifikasi seluruh perubahan Dart.

Gunakan perintah baca-saja berikut:

```bash
git status --short --untracked-files=all
git diff --cached -- '*.dart'
git diff -- '*.dart'
git diff HEAD -- '*.dart'
git ls-files --others --exclude-standard -- '*.dart'
```
