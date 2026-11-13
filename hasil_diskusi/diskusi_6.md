# Hasil Diskusi 6 — Pembuatan skill prosedur konfigurasi Kilo proyek

## Status
- Dokumen: Final
- Implementasi: Belum Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Pembuatan skill custom `konfigurasi-kilo-proyek` berisi prosedur & larangan konfigurasi Kilo khusus proyek (bukan snapshot isi config)

## Latar Belakang
Pengguna bertanya tentang skill yang berkaitan dengan konfigurasi Kilo. Hasil penelusuran: satu-satunya skill yang membahas konfigurasi Kilo adalah `kilo-config` — skill bawaan (builtin) Kilo, bukan project-local, tidak terdaftar di `SKILLS_INDEX.md`, dan tidak memiliki berkas `SKILL.md` yang tersimpan di disk proyek (pencarian `find` di `~/.config/kilo`, `~/.kilo`, `~/.cache/kilo`, dan seluruh filesystem tidak menemukan berkasnya; isinya hanya tersedia melalui tool `skill`). `SKILLS_INDEX.md` (87 entri, seluruhnya project-local) tidak memuat skill khusus Kilo; penyebutan "kilo" pada skill custom hanya bersifat insidental.

Pengguna kemudian bertanya bagaimana kalau membuat skill baru untuk config Kilo. Melalui tool `question`, pengguna memilih arah "Buat skill prosedur proyek", nama `konfigurasi-kilo-proyek`, dan alur "Dokumentasi diskusi dulu (Recommended)". Berkas ini adalah dokumentasi diskusi tersebut; pembuatan skill menunggu perintah eksplisit pengguna.

## Poin Diskusi
### 1. Skill yang membahas Kilo saat ini
- Tanya: Skill mana di proyek ini yang mengenai config Kilo?
- Kesimpulan: `kilo-config` (builtin Kilo, lokasi `builtin` pada `available_skills`) — mencakup config paths, `kilo.json` fields, commands, agents, skills, permissions, MCPs, providers, TUI settings, serta Agent Manager (setup/run scripts, workflows, state). Tidak ada skill project-local yang membahas Kilo secara khusus.

### 2. Keperluan skill baru
- Tanya: Apakah perlu skill baru untuk config Kilo?
- Kesimpulan: Perlu, tetapi dibatasi pada prosedur & larangan yang spesifik proyek. Menyalin isi `.kilo/kilo.jsonc` ke dalam skill tidak disarankan (risiko usang; duplikasi dengan skill bawaan `kilo-config` dan with `MEMORI.md` bagian `File Konfigurasi & Penting`).

### 3. Nama dan kategori skill
- Tanya: Nama apa yang dipakai untuk skill baru?
- Kesimpulan: `konfigurasi-kilo-proyek` (kebab-case, bahasa Indonesia, tidak mengesankan skill bawaan Kilo), kategori `custom`, lokasi `.agents/skills/custom/konfigurasi-kilo-proyek/SKILL.md`.

### 4. Alur pembuatan
- Tanya: Dokumentasi diskusi dulu atau langsung buat skillnya?
- Kesimpulan: Dokumentasi diskusi dulu (berkas ini). Pembuatan skill dilakukan pada sesi terpisah atas perintah eksplisit pengguna.

### 5. Garis besar isi skill
- Tanya: Isi skillnya apa saja?
- Kesimpulan (garis besar, belum final; detail disepakati saat pembuatan): sumber kebenaran konfigurasi adalah `.kilo/kilo.jsonc` proyek (AGENTS.md aturan 11); wajib baca `permission` sebelum menjalankan `bash`; deny yang bersifat mutlak (`cat *`, `sed *`, `python3 *`, serta `read` untuk `*.env`/`*.env.*`); config Kilo tervalidasi otomatis oleh harness saat diedit; konfigurasi global `~/.config/kilo/kilo.jsonc` nyaris kosong (hanya `$schema`); arsip `docs/kilo/kilo_global.txt` sudah usang dan tidak boleh dijadikan rujukan; setelah mengubah config wajib perbarui `MEMORI.md`; config tidak boleh di-commit tanpa perintah pengguna.

### 6. Sumber isi skill (aturan pembuatan skill)
- Tanya: Darimana isi skill disusun?
- Kesimpulan: Dari riwayat commit yang menyentuh `.kilo/kilo.jsonc` dan `.kilo/prompts/` (mis. `3bb9ebb`, `50ee3c7`, `afd2064`, `6ec9cce`, `944bb73`, `7e0a4ef`, `26362be`), sesuai `.agents/rules/global/aturan_skill.md` §5. Isi bersifat prosedural, bukan snapshot config.

## Keputusan
- K-1: Skill baru bernama `konfigurasi-kilo-proyek`, kategori `custom`, berisi prosedur & larangan konfigurasi Kilo khusus proyek — bukan snapshot isi `.kilo/kilo.jsonc`.
- K-2: Lokasi skill `.agents/skills/custom/konfigurasi-kilo-proyek/SKILL.md`; skill wajib mengikuti format `.agents/rules/global/aturan_skill.md` (front matter lengkap, `description` diawali `Trigger:` bahasa Indonesia, section wajib, isi merujuk riwayat commit).
- K-3: Skill tidak dibuat pada sesi ini; pembuatannya menunggu perintah eksplisit pengguna.
- K-4: Setelah skill dibuat: daftarkan ke `SKILLS_INDEX.md` via `.kilo/commands/perbarui_skills_index.md`, lalu perbarui `MEMORI.md` (jumlah skill, lokasi & riwayat diskusi, riwayat perubahan).
- K-5: Skill bawaan `kilo-config` tidak diubah dan tidak disalin mentah ke skill baru; untuk konfigurasi Kilo generik, rujukan tetap ke skill bawaan tersebut.

## Rekomendasi
- R-1: Batasi isi skill pada prosedur & larangan yang spesifik proyek; hindari menyalin nilai config (model, daftar permission) agar skill tidak cepat usang.
- R-2: Cantumkan rujukan eksplisit di dalam skill ke `.kilo/kilo.jsonc`, `AGENTS.md` aturan 11, dan `docs/kilo/kilo_global.txt` sebagai arsip usang.
- R-3: Putuskan terpisah dua temuan pada config proyek: `external_directory` menunjuk path usang `/home/mbadrudin170/...` dan `kilo_memory_recall` bernilai `allow` penuh — keduanya belum diputuskan pengguna dan di luar cakupan skill bila pengguna tidak menghendaki.
- R-4: Saat pembuatan, verifikasi `git log -- .kilo/kilo.jsonc .kilo/prompts/` untuk memilih commit terbaru yang relevan sebagai sumber isi.

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1  | Buat `.agents/skills/custom/konfigurasi-kilo-proyek/SKILL.md` (isi detail disepakati saat eksekusi) | `.agents/skills/custom/konfigurasi-kilo-proyek/SKILL.md` | belum (menunggu perintah pengguna) |
| 2  | Daftarkan skill ke `SKILLS_INDEX.md` via `.kilo/commands/perbarui_skills_index.md` | `SKILLS_INDEX.md` | belum |
| 3  | Perbarui `MEMORI.md` (jumlah skill, lokasi & riwayat diskusi, riwayat perubahan) | `MEMORI.md` | belum |
| 4  | Keputusan temuan `external_directory` usang & `kilo_memory_recall` allow | `.kilo/kilo.jsonc` | belum (perlu keputusan pengguna) |
| 5  | Catat perubahan pada `memori/riwayat_perubahan.md` | `memori/riwayat_perubahan.md` | selesai (sesi ini) |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_6.md` | Dibuat | Dokumentasi hasil diskusi ini |
| `.agents/skills/custom/konfigurasi-kilo-proyek/SKILL.md` | Dibuat (nanti) | Skill prosedur config Kilo proyek; menunggu perintah pengguna |
| `SKILLS_INDEX.md` | Diubah (nanti) | Registrasi skill baru; menunggu pembuatan skill |
| `MEMORI.md` | Diubah | Lokasi & riwayat diskusi, riwayat perubahan, catatan nomor tertinggi |
| `memori/riwayat_perubahan.md` | Diubah | Entri riwayat diskusi ini |

## Pertanyaan Terbuka
- Detail isi skill (daftar prosedur/larangan final, termasuk apakah `metadata.model` dicantumkan) belum disepakati; disepakati pada sesi pembuatan sesuai `aturan_skill.md` §7.
- Apakah temuan `external_directory` (`/home/mbadrudin170/...`) dan `kilo_memory_recall: "*": "allow"` akan diperbaiki? Menunggu keputusan pengguna.

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Dokumen dibuat; keputusan arah skill prosedur, nama, kategori, dan alur dokumentasi-dulu disepakati via tool `question` |
