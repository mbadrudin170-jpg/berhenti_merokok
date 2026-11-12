# Hasil Diskusi 6 — Pembuatan Skill Penggunaan Tool Question

## Status
- Dokumen: Final
- Implementasi: Sudah Diimplementasikan
- Tanggal: 2026-11-12
- Topik: Pembuatan skill baru untuk panduan penggunaan tool `question` dalam Mode Diskusi

## Latar Belakang

Mode Diskusi mewajibkan model menggunakan tool `question` ketika perlu bertanya, meminta klarifikasi, atau meminta keputusan/input dari pengguna. Namun, belum ada skill terstruktur yang mengatur kapan, bagaimana, dan format apa tool `question` harus digunakan. Ini mengakibatkan risiko konsistensi penulisan pertanyaan, header, dan opsi jawaban bervariasi antar interaksi.

## Poin Diskusi

### 1. Apakah perlu skill terpisah untuk tool `question`?
- Tanya: Apakah penggunaan tool `question` memerlukan skill sendiri, atau cukup diatur dalam Mode Diskusi?
- Kesimpulan: Perlu skill terpisah agar aturan penggunaan tool `question` dapat dipakai lintas interaksi (Mode Diskusi dan lainnya) secara konsisten, tanpa menduplikasi isi `mode_diskusi.md`.

### 2. Apa yang harus di-cover dalam skill `question`?
- Tanya: Trigger, format header (maks 30 karakter), opsi jawaban, aturan `multiple`, dan contoh penggunaan mana yang harus dicakup?
- Kesimpulan: Dicakup trigger (kapan pakai `question`), `header` maks. 30 karakter, struktur opsi `label` (1-5 kata) + `description`, aturan `multiple` vs single-select, opsi `default`, opsi rekomendasi "(Recommended)", larangan catch-all, varian i18n, serta contoh benar/salah.

### 3. Lokasi skill baru
- Tanya: Apakah skill baru ditempatkan di `.agents/skills/custom/` atau `.agents/skills/bawaan/`?
- Kesimpulan: Ditempatkan di `.agents/skills/custom/penggunaan-tool-question/` karena merupakan panduan khusus proyek ini.

## Keputusan

- K-1: Skill `question` dibuat sebagai skill terpisah di `.agents/skills/custom/penggunaan-tool-question/SKILL.md` mengikuti `.agents/rules/global/aturan_skill.md`.
- K-2: Skill mencakup trigger, format `header` (maks. 30 karakter), struktur opsi jawaban (`label` + `description`), aturan `multiple` vs single-select, opsi `default`/rekomendasi, larangan catch-all, varian i18n, serta contoh benar/salah.
- K-3: Sumber isi skill diambil dari riwayat commit relevan (`208e3ec` yang menambahkan §5 `mode_diskusi.md`) dan skema tool `question`, bukan dari working directory/staging/untracked.
- K-4: Skill didaftarkan ke `SKILLS_INDEX.md` dan `MEMORI.md` diperbarui.

## Rekomendasi

- R-1: Buat skill baru di `.agents/skills/custom/penggunaan-tool-question/SKILL.md` mengikuti aturan `.agents/rules/global/aturan_skill.md`.
- R-2: Skill harus mencakup trigger (kapan pakai `question`), format header (max 30 karakter), struktur opsi jawaban, aturan `multiple` vs single-select, dan contoh benar/salah.
- R-3: Sumber isi skill mengikuti riwayat commit yang relevan (tidak diarang dari working directory/staging/untracked).
- R-4: Setelah skill dibuat, daftarkan di `SKILLS_INDEX.md` dan perbarui `MEMORI.md`.

## Tindak Lanjut

| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1 | Buat skill `penggunaan-tool-question` di `.agents/skills/custom/` | `.agents/skills/custom/penggunaan-tool-question/SKILL.md` | sudah |
| 2 | Daftarkan skill baru ke `SKILLS_INDEX.md` | `SKILLS_INDEX.md` | sudah |
| 3 | Perbarui `MEMORI.md` (Skills & Rules Utama yang Diaktifkan) | `MEMORI.md` | sudah |
| 4 | Verifikasi `dart analyze` tidak error setelah penambahan skill | — | sudah |

## File Terdampak

| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `.agents/skills/custom/penggunaan-tool-question/SKILL.md` | Dibuat | Skill baru untuk panduan penggunaan tool `question` |
| `SKILLS_INDEX.md` | Diubah | Tambahkan entri skill baru |
| `MEMORI.md` | Diubah | Perbarui daftar skill aktif |

## Pertanyaan Terbuka

Belum ada.

## Riwayat Perubahan

| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-12 | Buat berkas diskusi 6 (Draft) tentang pembuatan skill tool `question` |
| 2026-11-12 | Status diubah ke `Final`; keputusan K-1..K-4 ditetapkan; tindak lanjut diimplementasikan (skill `penggunaan-tool-question` dibuat, didaftarkan ke `SKILLS_INDEX.md`, `MEMORI.md` diperbarui) |
