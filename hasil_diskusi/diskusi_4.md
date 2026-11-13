# Hasil Diskusi 4 — Rekomendasi isi MEMORI.md agar berguna lintas sesi

## Status
- Dokumen: Final
- Implementasi: Sudah Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Rekomendasi kelompok informasi yang sebaiknya ada di MEMORI.md agar bermanfaat bagi model AI lintas sesi (stabil vs dinamis), plus poin yang sebaiknya tidak masuk MEMORI.md.

## Latar Belakang
Pengguna bertanya "informasi apa saja yang harus ada di dalam file memori" dengan penekanan bahwa isi MEMORI.md harus berguna untuk model AI walaupun antar sesi. MEMORI.md saat ini memuat banyak informasi (status proyek, struktur, fitur, dependency, provider, enum, file konfigurasi, skills, lokasi hasil diskusi, riwayat diskusi, catatan teknis, aturan, referensi commit, catatan untuk model selanjutnya). Namun belum ada pembagian eksplisit antara informasi yang stabil (wajib lintas sesi) dan informasi yang dinamis (diperbarui tiap sesi), serta belum ada status working tree dan roadmap pekerjaan yang eksplisit. Diskusi ini menghasilkan rekomendasi kelompok informasi agar MEMORI.md fokus pada konteks persisten dan tidak berubah menjadi log sesi.

## Poin Diskusi

### 1. Informasi wajib (stabil, jarang berubah) bagi model AI lintas sesi
- Tanya: Informasi apa yang selalu diperlukan model AI di setiap sesi, terlepas dari sesi mana?
- Kesimpulan: Identitas & status proyek; struktur utama (fitur, dependency, provider, enum); file konfigurasi & penting; skills & rules aktif (sumber kebenaran SKILLS_INDEX.md); catatan teknis penting; aturan yang harus dipelihara; referensi commit.

### 2. Informasi dinamis yang diperbarui tiap sesi
- Tanya: Informasi apa yang berubah tiap sesi dan perlu dicatat di MEMORI.md?
- Kesimpulan: Lokasi hasil diskusi (folder, daftar, nomor tertinggi); riwayat diskusi (tabel topik/status/tindak lanjut); status working tree (file terhapus ter-staged, file sedang diubah); prioritas/roadmap pekerjaan; catatan untuk model selanjutnya (langkah wajib awal sesi).

### 3. Informasi yang sebaiknya tidak masuk MEMORI.md
- Tanya: Apa yang tidak berguna lintas sesi dan sebaiknya tidak masuk MEMORI.md?
- Kesimpulan: Log percakapan, detail implementasi per sesi, isi diskusi mendalam. Informasi tersebut masuk ke `hasil_diskusi/` dan `memori/sesi/`, bukan MEMORI.md.

### 5. Mekanisme agar model AI di sesi baru sudah tahu konteks proyek
- Tanya: Apa saja mekanisme yang membuat model AI di sesi baru langsung tahu konteks proyek?
- Kesimpulan: (1) Baca `MEMORI.md` di awal sesi (wajib via skill `memori-check`) — konteks persisten proyek; (2) Catch-up sync (`memori/sesi/*.md` `Belum Sinkron`) — menyerap perubahan sesi sebelumnya; (3) `SKILLS_INDEX.md` terdaftar di `instructions` (`.kilo/kilo.jsonc`) — indeks skill selalu dikirim penuh tiap sesi; (4) `AGENTS.md` / rules global sebagai kontrak lunak — aturan yang harus dipatuhi; (5) Status working tree & roadmap pekerjaan di `MEMORI.md` (dari R-2) — agar model tahu apa yang sedang dikerjakan/tertunda; (6) Pembagian stabil vs dinamis (dari K-2/K-3) — agar model tahu mana konteks tetap vs yang perlu diperbarui.

### 6. Penanggulangan jika model salah mengartikan memori yang stale
- Tanya: Bagaimana jika sebuah model salah mengartikan MEMORI.md yang stale?
- Kesimpulan: Konsekuensi: keputusan berdasarkan konteks usang (file yang sudah dihapus masih dianggap ada), mengerjakan task yang sudah selesai, mengubah file yang seharusnya tidak diubah, inkonsistensi dengan state aktual. Penanggulangan yang sudah ada: catch-up sync (jaring pengaman, tapi hanya menyerap sesi sebelumnya), verifikasi dengan sumber kebenaran lain (`git status`, `git diff`, `ls`, baca file aktual via Read tool wajib sebelum edit), jangan anggap MEMORI.md sebagai satu-satunya sumber kebenaran (rujuk SKILLS_INDEX.md, aturan, commit), konfirmasi dengan pengguna (tool question) bila ragu, permission deny mutlak untuk operasi berbahaya. Tambahan yang didokumentasikan: aturan "verifikasi sebelum bertindak" — model wajib memverifikasi state aktual sebelum mengambil keputusan berdasarkan MEMORI.md; bila ada konflik antara MEMORI.md dan state aktual, tanyakan ke pengguna, jangan putuskan sendiri.

## Keputusan
- K-1: MEMORI.md sebaiknya memuat informasi yang stabil dan persisten, bukan log sesi, agar berguna lintas sesi.
- K-2: Informasi wajib (stabil) = identitas & status proyek, struktur utama, file konfigurasi & penting, skills & rules aktif, catatan teknis penting, aturan yang harus dipelihara, referensi commit.
- K-3: Informasi dinamis (diperbarui tiap sesi) = lokasi hasil diskusi, riwayat diskusi, status working tree, prioritas/roadmap pekerjaan, catatan untuk model selanjutnya.
- K-4: Informasi yang tidak berguna lintas sesi (log percakapan, detail implementasi per sesi, isi diskusi mendalam) tidak masuk MEMORI.md; masuk ke `hasil_diskusi/` dan `memori/sesi/`.
- K-5: Penambahan status working tree dan roadmap pekerjaan ke MEMORI.md disarankan (dinamis).
- K-6: Tujuan agar model AI di sesi baru sudah tahu konteks proyek dicapai dengan kombinasi mekanisme: baca MEMORI.md awal sesi, catch-up sync, SKILLS_INDEX.md di instructions, AGENTS.md/rules global, status working tree & roadmap di MEMORI.md, pembagian stabil vs dinamis.
- K-7: Jika model salah mengartikan MEMORI.md yang stale, penanggulangan: (1) catch-up sync sebagai jaring pengaman (hanya menyerap sesi sebelumnya); (2) verifikasi dengan sumber kebenaran lain (`git status`, `git diff`, `ls`, baca file aktual) sebelum bertindak; (3) jangan anggap MEMORI.md sebagai satu-satunya sumber kebenaran; (4) konfirmasi dengan pengguna (tool question) bila ragu; (5) permission deny mutlak untuk operasi berbahaya; (6) aturan "verifikasi sebelum bertindak" — model wajib memverifikasi state aktual sebelum mengambil keputusan berdasarkan MEMORI.md, bila ada konflik tanyakan ke pengguna, jangan putuskan sendiri.

## Rekomendasi
- R-1: Pertahankan struktur MEMORI.md yang ada, dengan pembagian eksplisit antara bagian stabil dan dinamis (mis. subjudul atau komentar).
- R-2: Tambahkan bagian "Status Working Tree" dan "Prioritas/Roadmap Pekerjaan" ke MEMORI.md (dinamis, diperbarui tiap sesi).
- R-3: Hindari memasukkan log percakapan/detail implementasi per sesi ke MEMORI.md; arahkan ke `hasil_diskusi/` dan `memori/sesi/`.
- R-4: Jika rekomendasi ini disetujui, buat tindak lanjut untuk menyesuaikan MEMORI.md (implementasi terpisah, menunggu perintah eksplisit pengguna).
- R-5: Pastikan kombinasi mekanisme (baca MEMORI.md awal sesi, catch-up sync, SKILLS_INDEX.md di instructions, AGENTS.md/rules global, status working tree & roadmap di MEMORI.md, pembagian stabil vs dinamis) terdokumentasi di "Catatan untuk Model Selanjutnya" agar model AI sesi baru langsung tahu konteks proyek.
- R-6: Tambahkan aturan "verifikasi sebelum bertindak" ke MEMORI.md (Catatan untuk Model Selanjutnya) dan/atau AGENTS.md: model wajib memverifikasi state aktual (`git status`, `git diff`, `ls`, baca file aktual) sebelum mengambil keputusan berdasarkan MEMORI.md; bila ada konflik antara MEMORI.md dan state aktual, tanyakan ke pengguna, jangan putuskan sendiri. Implementasi menunggu perintah eksplisit pengguna.

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1 | Buat berkas hasil diskusi `diskusi_4.md` (Draft) | `hasil_diskusi/diskusi_4.md` | selesai |
| 2 | Finalisasi status Dokumen setelah disepakati pengguna | `hasil_diskusi/diskusi_4.md` | selesai |
| 3 | (Opsional) Implementasi rekomendasi ke MEMORI.md (tambah status working tree & roadmap, pembagian stabil/dinamis) — menunggu perintah eksplisit pengguna | `MEMORI.md` | selesai (sesi 13: R-1..R-5) |
| 4 | Dokumentasikan mekanisme agar model AI sesi baru tahu konteks (R-5) ke "Catatan untuk Model Selanjutnya" saat implementasi | `MEMORI.md` | selesai (sesi 13) |
| 5 | Dokumentasikan aturan "verifikasi sebelum bertindak" (R-6) ke MEMORI.md dan/atau AGENTS.md — menunggu perintah eksplisit pengguna | `MEMORI.md`, `AGENTS.md` | belum |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_4.md` | Dibuat | Berkas hasil diskusi rekomendasi isi MEMORI.md lintas sesi (Draft) |
| `MEMORI.md` | Diubah | Lokasi Hasil Diskusi & Riwayat Diskusi diperbarui (diskusi_4) |
| `memori/riwayat_perubahan.md` | Diubah | Entri pembuatan diskusi_4 |
| `memori/sesi/sesi_12.md` | Diubah | Catatan sesi diperbarui |
| `memori/sesi/sesi_13.md` | Dibuat/Diubah | Implementasi R-1..R-5 (sesi 13) |
| `MEMORI.md` | Diubah | R-1..R-5 diterapkan: pembagian stabil/dinamis, Status Working Tree, Prioritas/Roadmap, mekanisme sesi baru di Catatan untuk Model Selanjutnya |

## Pertanyaan Terbuka
- Apakah rekomendasi A/B akan diimplementasikan ke MEMORI.md (menambah status working tree & roadmap, pembagian stabil/dinamis)? Menunggu keputusan pengguna.

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Berkas dibuat (Draft) — rekomendasi isi MEMORI.md agar berguna lintas sesi |
| 2026-11-13 | Poin Diskusi 5, K-6, R-5 ditambahkan — mekanisme agar model AI sesi baru tahu konteks proyek |
| 2026-11-13 | Status Dokumen diubah Draft → Final (keputusan & rekomendasi disepakati pengguna) |
| 2026-11-13 | Implementasi R-1..R-5 ke MEMORI.md (sesi 13): pembagian stabil/dinamis di "Catatan untuk Model Selanjutnya" (poin 7-8), bagian "Status Working Tree" dan "Prioritas/Roadmap Pekerjaan" ditambahkan, mekanisme sesi baru didokumentasikan (R-5). Implementasi → Sudah Diimplementasikan. |
| 2026-11-13 | Penambahan Poin Diskusi 6, K-7, R-6: penanggulangan jika model salah mengartikan memori yang stale (konsekuensi + penanggulangan: catch-up sync, verifikasi sumber kebenaran, jangan anggap MEMORI.md satu-satunya sumber, konfirmasi pengguna, permission deny, aturan "verifikasi sebelum bertindak"). Status Dokumen tetap Final. Implementasi R-6 menunggu perintah eksplisit pengguna. |
