# Hasil Diskusi

## Topik
Perancangan command untuk membuat/memperbarui `SKILLS_INDEX.md` dari seluruh skill di `.agents/skills/**/SKILL.md`, serta aturan mode diskusi.

## Ringkasan Keputusan Sementara
- **Tujuan command**: memindai `.agents/skills/**/SKILL.md` dan menulis indeks ke `SKILLS_INDEX.md` (root).
- **Cakupan data indeks (keinginan pengguna)**: hanya `path` skill dan keterangan kapan/untuk apa skill di-load.
- **Deskripsi/trigger**: tidak harus detail; cukup spesifik dan jelas sebagai pemicu pemilihan skill (1 kalimat/frasa kunci). Rincian lengkap tetap di `SKILL.md` yang dirujuk.
- **Batasan sesi (sebelumnya)**: diskusi saja, fokus topik, tanpa mengubah file lain. Arahan terbaru: perbarui `hasil_diskusi.md` setiap selesai reasoning.

## Fakta Repo Terkait
- `SKILLS_INDEX.md` kosong.
- Terdapat 85 `SKILL.md` (kategori terdeteksi: `bawaan`, `custom`, dan folder `ok`).
- Command existing berada di `.kilo/commands/*.md`.
- Skill standar memiliki frontmatter YAML (`name`, `description`, `metadata.*`) sesuai `.agents/rules/global/aturan_skill.md`.
- `.agents/skills/ok/SKILL.md` terindikasi placeholder.

## Poin Terbuka (perlu keputusan)
1. **Sumber "di-load ketika"**: (A) seluruh `description` frontmatter, (B) ekstrak bagian trigger saja, atau (C) konvensi/field khusus (mis. `metadata.load-when`).
2. **Format indeks**: tabel 2 kolom (`Path`, `Di-load ketika`) per kategori (lihat usulan format di bawah) atau alternatif daftar bullet.
3. **Pengelompokan**: per kategori/folder (`custom`/`bawaan`/lainnya) — **direkomendasikan**; atau daftar flat.
4. **Skill placeholder/non-standar** (`.agents/skills/ok`): diikutkan atau dikecualikan.
5. **Jika trigger tidak jelas**: pakai `description` apa adanya atau beri penanda perlu dilengkapi.
6. **Identitas command**: usulan nama `.kilo/commands/perbarui_skills_index.md`.
7. **Mode diskusi** (`.kilo/commands/mode/mode_diskusi.md`): butir ke-4 masih kosong — perlu ditentukan isinya.

## Usulan Format Isi `SKILLS_INDEX.md`
- **Struktur**: judul + catatan singkat penggunaan, lalu dikelompokkan per kategori/folder dengan subjudul `## <kategori>`.
- **Isi per skill**: hanya 2 kolom — `Path` dan `Di-load ketika` (trigger singkat, spesifik; bukan deskripsi detail).
- **Urutan**: kategori direkomendasikan `custom`, `bawaan`, lalu kategori lain jika ada; di dalam tiap kategori urut alfabetis berdasarkan path (agar idempotent).
- **Contoh kerangka**:

```markdown
# Skills Index

Indeks skill proyek. Gunakan untuk memilih skill yang relevan, lalu baca/load `SKILL.md` pada path terkait sebelum mengerjakan. Sumber kebenaran: `.agents/skills/**/SKILL.md` dan `.agents/rules/global`.

## custom

| Path | Di-load ketika |
| --- | --- |
| `.agents/skills/custom/gaya/SKILL.md` | Saat mengatur styling warna/tema atau opacity warna di widget Flutter. |

## bawaan

| Path | Di-load ketika |
| --- | --- |
| `.agents/skills/bawaan/dart-run-static-analysis/SKILL.md` | Saat menjalankan analisis statis/lint atau memperbaiki issue dengan `dart fix`. |
```

- **Catatan**:
  - Kategori/folder tambahan (mis. `ok`) mengikuti keputusan poin 4 (diikutkan sebagai kelompok terpisah atau dikecualikan).
  - Teks `Di-load ketika` diisi sesuai keputusan poin 1 & 5 (trigger hasil ekstraksi/ringkasan, bukan detail teknis).

## Keputusan: Perlu Skill untuk Meringkas Skill Index?
- **Keputusan**: **Cukup command**, tidak perlu membuat skill khusus untuk meringkas/menghasilkan `SKILLS_INDEX.md`.
- **Alasan**:
  - Pembuatan indeks adalah tugas pemeliharaan repo yang deterministik (scan `SKILL.md`, ambil `path` + trigger, tulis ke `SKILLS_INDEX.md`) sehingga cukup didefinisikan sebagai command (mis. `.kilo/commands/perbarui_skills_index.md`) dengan langkah dan aturan ringkas yang jelas.
  - **Skill** di repo ini ditujukan sebagai panduan/workflow reusable lintas konteks; overhead pembuatan/pemeliharaannya tidak sepadan untuk kebutuhan indeks lokal ini.
- **Pengecualian (jika nanti relevan)**: dapat dipertimbangkan bila kriteria peringkasan trigger menjadi aturan editorial kompleks yang perlu dipakai berulang lintas konteks/proyek.

## Diskusi: Apakah `SKILLS_INDEX.md` Perlu Di-hook ke `AGENTS.md`?
- **Kesimpulan**: **Disarankan ya**, sebagai referensi/pintu masuk cepat untuk memilih skill, **bukan** pengganti sumber aturan utama.
- **Alasan mendukung**:
  - Membantu memenuhi aturan "cari skill yang sesuai" (AGENTS poin 1) dengan peta ringkas (`path` + kapan di-load) tanpa harus memindai seluruh 85 `SKILL.md`.
  - Menjadikan indeks mudah ditemukan karena `AGENTS.md` adalah instruksi awal yang dibaca.
- **Hal yang harus dijaga jika di-hook**:
  - **Sumber kebenaran tetap `SKILL.md`** di `.agents/skills/**` (dan aturan di `.agents/rules/global`); `SKILLS_INDEX.md` hanya indeks bantu untuk discovery/pemilihan.
  - Instruksi di `AGENTS.md` sebaiknya menyatakan: gunakan indeks untuk memilih skill yang relevan, lalu **load/baca `SKILL.md`** terkait sebelum mengerjakan.
  - **Risiko stale**: karena `SKILLS_INDEX.md` dihasilkan (command), perlu disiplin menjalankan command sinkronisasi saat skill berubah agar tidak menyesatkan.
  - Perlu kejelasan relasi dengan poin 5 `AGENTS.md` (daftar folder wajib dibaca): indeks dapat melengkapi, bukan menghapus kewajiban merujuk ke folder/skill yang relevan.
- **Implikasi ke command & AGENTS.md**: ya, **perlu ditambahkan ke command dan dirujuk/dicantumkan di `AGENTS.md`** (usulan command: `.kilo/commands/perbarui_skills_index.md`). Command memindai skill, menulis `SKILLS_INDEX.md`, dan memastikan referensi indeks di `AGENTS.md` terjaga. `AGENTS.md` juga sebaiknya mencantumkan kewajiban/pemicu sinkronisasi rutin (jalankan command indeks saat skill/trigger berubah atau indeks stale) agar aturan ini mudah ditemukan, dengan tetap menjaga prinsip: indeks bantu, `SKILL.md` sumber kebenaran.
- **Catatan implementasi (nanti, di luar diskusi ini)**: pembaruan `AGENTS.md` dan pembuatan command baru dilakukan saat implementasi; saat ini tidak ada file selain `hasil_diskusi.md` yang diubah.

## Keputusan: Sinkronisasi Rutin
- **Ya, `SKILLS_INDEX.md` harus disinkronkan secara rutin** karena isinya bersifat turunan/generated dari `.agents/skills/**/SKILL.md`.
- **Pemicu (kapan command indeks dijalankan)**:
  - Setiap ada **penambahan, perubahan, penghapusan, atau pemindahan** `SKILL.md` di `.agents/skills/**`.
  - Setiap ada **perubahan pada sumber teks "Di-load ketika"** (mis. `description`/trigger di frontmatter atau sumber lain yang disepakati) yang memengaruhi isi indeks.
  - Saat indeks **diragukan tidak mutakhir/stale** (mis. isi `SKILLS_INDEX.md` tidak selaras dengan skill yang ada).
- **Cara & dokumentasi**: jalankan command pembaruan indeks (usulan `.kilo/commands/perbarui_skills_index.md`) secara rutin sesuai pemicu di atas agar `SKILLS_INDEX.md` dan referensinya di `AGENTS.md` tetap konsisten. Kewajiban/pemicu ini sebaiknya juga dicantumkan atau dirujuk di `AGENTS.md` (dan dijaga oleh command) agar mudah ditemukan.

## Diskusi: Perlu Menambah Rules agar Selalu Me-load Skill Sebenarnya?
- **Kesimpulan**: **Ya, disarankan** menambahkan/mempertegas aturan eksplisit bahwa indeks hanya untuk pemilihan, dan `SKILL.md` yang relevan **wajib dibaca/di-load** sebelum mengerjakan.
- **Alasan**:
  - `SKILLS_INDEX.md` hanya memuat `path` + trigger singkat ("kapan di-load"), bukan isi aturan/workflow/larangan lengkap.
  - Tanpa aturan tegas, indeks bisa disalahgunakan sebagai pengganti skill sebenarnya sehingga melanggar prinsip "dilarang mengerjakan sesuatu tanpa panduan dari sebuah skill atau rules" (AGENTS poin 1–3).
  - Indeks bisa *stale*, sedangkan `SKILL.md` adalah sumber kebenaran.
- **Usulan isi aturan (inti)**:
  - Gunakan `SKILLS_INDEX.md` hanya untuk menemukan/memilih skill yang relevan.
  - Setelah skill terpilih, **wajib load/baca `SKILL.md` pada path terkait** sebelum mulai mengerjakan tugas.
  - Dilarang mengandalkan ringkasan indeks sebagai pengganti isi `SKILL.md` atau aturan di `.agents/rules/global`.
  - Jika indeks tidak sinkron/stale, tetap rujuk ke `.agents/skills/**/SKILL.md` dan jalankan command sinkronisasi indeks.
- **Lokasi aturan**: sebaiknya ditegaskan di `AGENTS.md` (pintu masuk) dan/atau sebagai rule di `.agents/rules/global` agar berlaku konsisten; command indeks juga perlu menjaga referensi/prinsip ini.

## Status Kesiapan
- **Arah besar**: sudah cukup matang/final — indeks hanya `Path` + "Di-load ketika" (trigger singkat), cukup command (bukan skill), `SKILLS_INDEX.md` di-hook ke `AGENTS.md` sebagai indeks bantu (sumber kebenaran tetap `SKILL.md`), wajib rutin sinkron sesuai pemicu, dan perlu penegasan aturan agar skill sebenarnya selalu di-load.
- **Belum final untuk implementasi command**: masih ada poin keputusan terbuka yang memengaruhi perilaku/isi command dan hasil indeks:
  1. **Sumber "Di-load ketika"** (A/B/C) — belum diputuskan.
  2. **Format final** (tabel vs bullet) — usulan tabel 2 kolom, perlu konfirmasi.
  3. **Pengelompokan** (per kategori vs flat) — direkomendasikan per kategori, perlu konfirmasi.
  4. **Perlakuan `.agents/skills/ok` (placeholder)** — ikut/dikecualikan belum diputuskan.
  5. **Jika trigger tidak jelas** (pakai deskripsi apa adanya vs penanda) — belum diputuskan.
  6. **Nama command** — `.kilo/commands/perbarui_skills_index.md` masih usulan.
- **Rekomendasi agar final**: putuskan poin 1–6 (terutama 1, 4, 5), lalu draf isi command bisa disusun.

## Catatan
- Draf isi command belum dibuat; menunggu keputusan poin terbuka.
