# Hasil Diskusi 6 — Pembuatan Skill Penggunaan Tool Question

## Status
- Dokumen: Draft
- Implementasi: Belum Diimplementasikan
- Tanggal: 2026-11-12
- Topik: Pembuatan skill baru untuk panduan penggunaan tool `question` dalam Mode Diskusi

## Latar Belakang

Mode Diskusi mewajibkan model menggunakan tool `question` ketika perlu bertanya, meminta klarifikasi, atau meminta keputusan/input dari pengguna. Namun, belum ada skill terstruktur yang mengatur kapan, bagaimana, dan format apa tool `question` harus digunakan. Ini mengakibatkan risiko konsistensi penulisan pertanyaan, header, dan opsi jawaban bervariasi antar interaksi.

## Poin Diskusi

### 1. Apakah perlu skill terpisah untuk tool `question`?
- Tanya: Apakah penggunaan tool `question` memerlukan skill sendiri, atau cukup diatur dalam Mode Diskusi?
- Kesimpulan: Belum diputuskan. Perlu evaluasi apakah cukup dengan aturan dalam Mode Diskusi atau memerlukan skill terstruktur di `.agents/skills/`.

### 2. Apa yang harus di-cover dalam skill `question`?
- Tanya: Trigger, format header (maks 30 karakter), opsi jawaban, aturan `multiple`, dan contoh penggunaan mana yang harus dicakup?
- Kesimpulan: Belum dibahas.

### 3. Lokasi skill baru
- Tanya: Apakah skill baru ditempatkan di `.agents/skills/custom/` atau `.agents/skills/bawaan/`?
- Kesimpulan: Belum dibahas. Asumsi awal: `custom/` karena merupakan panduan proyek spesifik.

## Keputusan

Belum ada keputusan final (dokumen masih Draft).

## Rekomendasi

- R-1: Buat skill baru di `.agents/skills/custom/penggunaan-tool-question/SKILL.md` mengikuti aturan `.agents/rules/global/aturan_skill.md`.
- R-2: Skill harus mencakup trigger (kapan pakai `question`), format header (max 30 karakter), struktur opsi jawaban, aturan `multiple` vs single-select, dan contoh benar/salah.
- R-3: Sumber isi skill mengikuti riwayat commit yang relevan (tidak diarang dari working directory/staging/untracked).
- R-4: Setelah skill dibuat, daftarkan di `SKILLS_INDEX.md` dan perbarui `MEMORI.md`.

## Tindak Lanjut

| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1 | Buat skill `penggunaan-tool-question` di `.agents/skills/custom/` | `.agents/skills/custom/penggunaan-tool-question/SKILL.md` | belum |
| 2 | Daftarkan skill baru ke `SKILLS_INDEX.md` | `SKILLS_INDEX.md` | belum |
| 3 | Perbarui `MEMORI.md` (Skills & Rules Utama yang Diaktifkan) | `MEMORI.md` | belum |
| 4 | Verifikasi `dart analyze` tidak error setelah penambahan skill | — | belum |

## File Terdampak

| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `.agents/skills/custom/penggunaan-tool-question/SKILL.md` | Dibuat | Skill baru untuk panduan penggunaan tool `question` |
| `SKILLS_INDEX.md` | Diubah | Tambahkan entri skill baru |
| `MEMORI.md` | Diubah | Perbarui daftar skill aktif |

## Pertanyaan Terbuka

- Apakah skill `question` cukup diatur dalam Mode Diskusi atau memerlukan file `SKILL.md` terpisah?
- Apakah pengguna menyetujui lokasi `.agents/skills/custom/penggunaan-tool-question/`?

## Riwayat Perubahan

| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-12 | Buat berkas diskusi 6 (Draft) tentang pembuatan skill tool `question` |
