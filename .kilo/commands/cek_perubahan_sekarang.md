---
description: Audit perubahan Git yang belum di-commit terhadap AGENTS.md tanpa mengubah kode
agent: ask
---

# Audit Perubahan Sebelum Commit

## TUJUAN

Saya ingin memastikan seluruh perubahan kode yang belum di-commit sudah sesuai dengan `AGENTS.md` dan aturan proyek yang berlaku.

Tugas Anda adalah melakukan code review terhadap seluruh perubahan yang masih berada di working tree Git, kemudian melaporkan temuan kepada saya.

Jika ditemukan pelanggaran aturan, cukup beritahukan kepada saya beserta bukti dan rekomendasi perbaikannya.

**Saya sendiri yang akan memutuskan apakah perubahan tersebut perlu diedit atau tidak.**

Jangan memperbaiki kode secara otomatis.

## ATURAN UTAMA

1. Audit seluruh perubahan yang belum di-commit, baik perubahan yang sudah di-stage maupun yang belum di-stage.
2. Periksa juga file baru yang belum dilacak Git (untracked files).
3. Bandingkan implementasi dengan `AGENTS.md` dan seluruh aturan tambahan yang berlaku.
4. Periksa konteks kode agar tidak salah menyimpulkan pelanggaran.
5. Laporkan hanya temuan yang mempunyai dasar dan bukti.
6. Jangan mengubah file apa pun.
7. Jangan mengambil keputusan untuk memperbaiki kode tanpa persetujuan saya.

**PRINSIP UTAMA: AUDIT DAN LAPORKAN, BUKAN MEMPERBAIKI.**

---

# TAHAP 1 — MEMBACA ATURAN PROYEK

Sebelum memeriksa perubahan, lakukan langkah berikut:

1. Baca `AGENTS.md` pada root proyek.
2. Identifikasi `AGENTS.md` tambahan pada direktori yang berhubungan dengan file yang berubah.
3. Baca seluruh aturan tambahan yang berlaku untuk file yang sedang diperiksa.
4. Baca dokumentasi atau skill yang secara eksplisit diwajibkan oleh aturan proyek sebelum mengevaluasi implementasi.
5. Pahami aturan yang berlaku sebelum memberikan penilaian.

Ketentuan:

- Jadikan `AGENTS.md` dan aturan turunannya sebagai standar utama evaluasi.
- Jangan membuat standar baru berdasarkan asumsi pribadi.
- Jangan mengabaikan aturan khusus untuk direktori tertentu.
- Jangan menganggap suatu implementasi salah hanya karena Anda lebih menyukai pendekatan lain.
- Jika terdapat aturan yang saling bertentangan, jelaskan konflik tersebut dan jangan mengambil keputusan berdasarkan asumsi.

Jika `AGENTS.md` atau dokumen aturan lainnya juga sedang mengalami perubahan yang belum di-commit:

- Baca versi yang sedang berlaku di working tree.
- Periksa perbedaannya dengan versi yang tersimpan di Git.
- Beritahukan jika perubahan aturan tersebut memengaruhi penilaian kode.
- Jangan diam-diam mengabaikan perbedaan versi aturan.

---

# TAHAP 2 — MENGIDENTIFIKASI PERUBAHAN GIT

Periksa kondisi Git saat ini.

Gunakan perintah baca-saja seperti:

```bash
git status --short --branch --untracked-files=all
git diff --stat
git diff --cached --stat
git diff --name-status
git diff --cached --name-status
```
