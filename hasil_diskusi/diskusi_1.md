# Hasil Diskusi

## Topik

Perancangan command untuk membuat/memperbarui `SKILLS_INDEX.md` dari seluruh skill di `.agents/skills/**/SKILL.md`, serta aturan mode diskusi.

## Ringkasan Keputusan Sementara

- **Tujuan command**: memindai `.agents/skills/**/SKILL.md` dan menulis indeks ke `SKILLS_INDEX.md` (root).
- **Cakupan data indeks (draft, diperbarui)**: indeks memuat **path skill**, **trigger** ("kapan/untuk apa di-load", **wajib hanya trigger**), dan **status diperbarui** per skill, dikelompokkan per folder/kategori.
- **Format entri (draft, diperbarui)**: heading folder `## <folder>` (mis. `## custom`, `## bawaan`), tiap entri: `1. <path skill>`, baris indentasi `- Trigger : <isi trigger>`, dan baris indentasi `- Status : diperbarui : <tanggal dan waktu>`; urut alfabetis sesuai path.
- **Trigger di indeks**: **wajib ditulis dalam bahasa Indonesia**, meskipun isi/`description` pada `SKILL.md` skill ditulis dalam bahasa Inggris.
- **Status diperbarui**: **wajib ada sebagai field di metadata `SKILL.md`** (usulan nama field: `metadata.diperbarui`) agar dapat diketahui skill sudah terbaru; indeks menampilkan nilai tersebut. **Pemicu/kapan diperbarui**: **setiap isi skill berubah** — cakupan **luas** (setiap perubahan pada file `SKILL.md`, frontmatter dan/atau body) mewajibkan pembaruan `metadata.diperbarui`. **Format waktu baku**: sesuai output perintah `TZ=Asia/Jakarta date` (Asia/Jakarta). **Relasi**: setiap isi skill berubah juga **selalu menaikkan `metadata.versi`** (bump default: **patch `x.y.Z`**, kasus khusus dapat dirinci nanti). **Sumber perubahan**: `metadata.commit-terakhir` **diusulkan diganti/diubah namanya** (mis. `metadata.sumber-terakhir`) agar dapat diisi sumber terakhir — hash commit rujukan atau hasil/perintah eksplisit pengguna — karena tidak selalu sinkron; ketentuan detail pengisian perlu ditetapkan.
- **Deskripsi/trigger**: tidak harus detail; cukup spesifik dan jelas sebagai pemicu pemilihan skill (1 kalimat/frasa kunci). Rincian lengkap tetap di `SKILL.md` yang dirujuk.
- **Batasan sesi (sebelumnya)**: diskusi saja, fokus topik, tanpa mengubah file lain. Arahan terbaru: perbarui `hasil_diskusi.md` setiap selesai reasoning.

## Fakta Repo Terkait

- `SKILLS_INDEX.md` kosong.
- Terdapat 84 `SKILL.md` (kategori terdeteksi: `bawaan`, `custom`). Folder placeholder `.agents/skills/ok` telah dihapus.
- Command existing berada di `.kilo/commands/*.md`.
- Skill standar memiliki frontmatter YAML (`name`, `description`, `metadata.*`) sesuai `.agents/rules/global/aturan_skill.md`. Format `description` saat ini belum seragam (ID/EN, posisi trigger berbeda, kadang implisit/campuran).

## Poin Terbuka (perlu keputusan)

1. **Sumber/mekanisme "Di-load ketika" (trigger-only)**: **Opsi B dipilih (arah)** — ekstrak bagian trigger saja dari `description` untuk isi indeks. **Opsi A** tidak digunakan; **Opsi C** tidak cocok (metadata tidak dikirim saat sesi baru/discovery). **Dikonfirmasi**: trigger di indeks **wajib ditulis dalam bahasa Indonesia** meskipun `description`/isi skill berbahasa Inggris. **Belum final**: definisi & aturan ekstraksi/penormalan trigger yang tegas serta fallback (terkait Poin 5) masih perlu ditetapkan.
2. **Format indeks**: **dikonfirmasi (draft, diperbarui)** — heading folder `## <folder>` (`## custom`, `## bawaan`, `## lainnya` jika ada); tiap entri: `1. <path skill>`, baris indentasi `- Trigger : <isi trigger>`, dan baris indentasi `- Status : diperbarui : <tanggal dan waktu>`; urut alfabetis sesuai path. Label **`Trigger`** (typo diperbaiki). **Format waktu baku status (dikonfirmasi)**: sesuai output perintah `TZ=Asia/Jakarta date` (Asia/Jakarta).
3. **Pengelompokan**: **dikonfirmasi** — per kategori/folder (`custom`, `bawaan`, `lainnya` jika ada).
4. **Perlakuan `.agents/skills/ok` (placeholder)**: **selesai** — folder/skill placeholder telah dihapus (total `SKILL.md` kini 84), tidak diikutkan.
5. **Jika trigger tidak jelas/tidak teridentifikasi**: **belum diputuskan** (pakai teks apa adanya — berisiko melanggar trigger-only — atau beri penanda "perlu dilengkapi trigger" dan/atau laporkan).
6. **Identitas command**: **dikonfirmasi** — `.kilo/commands/perbarui_skills_index.md`.
7. **Mode diskusi** (`.kilo/commands/mode/mode_diskusi.md`): butir ke-4 masih kosong — **belum ditentukan**.
8. **Pembaruan `.agents/rules/global/aturan_skill.md` (dan skill terkait) + migrasi skill existing**: rincian dijelaskan di bawah; **dikonfirmasi (arah)**: info `diperbarui` **wajib ada di metadata `SKILL.md`** (usulan field `metadata.diperbarui`). **Dikonfirmasi**: pemicu/kapan diperbarui = **setiap isi skill berubah** (cakupan luas, frontmatter/body). **Dikonfirmasi**: setiap perubahan juga **menaikkan `metadata.versi`** (bump default **patch `x.y.Z`**). **Dikonfirmasi (arah)**: `metadata.commit-terakhir` **diubah/diganti nama** menjadi field sumber terakhir (usulan `metadata.sumber-terakhir`, dapat berisi commit rujukan atau perintah/hasil eksplisit pengguna; tidak selalu sinkron). **Belum final**: nama/struktur field final, aturan bump kasus khusus, ketentuan pengisian sumber-terakhir, format waktu baku (sudah dikonfirmasi: output `TZ=Asia/Jakarta date`), serta strategi migrasi.

## Usulan Format Isi `SKILLS_INDEX.md` (draft, diperbarui)

- **Fungsi file (ringkas)**: `SKILLS_INDEX.md` adalah indeks bantu untuk menemukan/memilih skill yang relevan berdasarkan **trigger** (kapan/untuk apa skill di-load). Gunakan untuk discovery, lalu **wajib baca/load `SKILL.md`** terkait sebelum mengerjakan. Sumber kebenaran: `.agents/skills/**/SKILL.md` dan `.agents/rules/global`.
- **Struktur**: penjelasan fungsi singkat di awal, lalu dikelompokkan per folder/kategori dengan heading `## <folder>`.
- **Isi per skill**: `path skill`, `trigger` (wajib hanya trigger, **ditulis dalam bahasa Indonesia**), dan **status diperbarui** (wajib bersumber dari metadata `SKILL.md`).
- **Urutan**: alfabetis sesuai path di dalam tiap kelompok (idempotent).
- **Contoh kerangka**:

```markdown
# Skills Index

Indeks bantu untuk memilih skill yang relevan berdasarkan trigger (kapan/untuk apa di-load). Setelah memilih, wajib baca/load `SKILL.md` skill terkait sebelum mengerjakan. Sumber kebenaran: `.agents/skills/**/SKILL.md` dan `.agents/rules/global`.

## custom

1. .agents/skills/custom/gaya/SKILL.md
   - Trigger : Saat mengatur styling warna/tema atau opacity warna di widget Flutter.
   - Status : diperbarui : <tanggal dan waktu>
2. .agents/skills/custom/spacing/SKILL.md
   - Trigger : Saat mengatur jarak/spacing antar elemen UI Flutter.
   - Status : diperbarui : <tanggal dan waktu>

## bawaan

1. .agents/skills/bawaan/dart-run-static-analysis/SKILL.md
   - Trigger : Saat menjalankan analisis statis/lint atau memperbaiki issue dengan `dart fix`.
   - Status : diperbarui : <tanggal dan waktu>
```

- **Catatan (belum final)**: format waktu baku status **dikonfirmasi** sesuai output perintah `TZ=Asia/Jakarta date` (Asia/Jakarta). Label `Trigger` dan heading `## <folder>` sudah dikonfirmasi. Teks trigger diisi hasil ekstraksi/penormalan trigger-only dari `description` ke bahasa Indonesia sesuai aturan yang nanti ditetapkan (Poin 1/5/8). Status: **draft/belum final**.

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
  - **Khusus folder `bawaan` (dikonfirmasi)**: acuan waktu wajib merujuk ke `.config/dart_skills/skills_config.json`. Ambil **satu waktu saja**: `installedAt` dari **baris pertama** (nilai `installedAt` pertama yang muncul secara tekstual dalam file config). `installedAt` (UTC, `Z`) **harus dikonversi ke Asia/Jakarta** terlebih dahulu sebelum dibandingkan dengan waktu/status di indeks atau `metadata.diperbarui` skill bawaan (Asia/Jakarta). Jika waktu acuan tersebut **lebih baru**, maka **wajib perbarui skill-skill di folder `bawaan` saja** (seperti biasa, sesuai aturan pembaruan skill yang berlaku) beserta sinkronisasi indeks.
- **Cara & dokumentasi**: jalankan command pembaruan indeks (usulan `.kilo/commands/perbarui_skills_index.md`) secara rutin sesuai pemicu di atas agar `SKILLS_INDEX.md` dan referensinya di `AGENTS.md` tetap konsisten. Kewajiban/pemicu ini sebaiknya juga dicantumkan atau dirujuk di `AGENTS.md` (dan dijaga oleh command) agar mudah ditemukan.

## Diskusi: Perlu Menambah Rules agar Selalu Me-load Skill Sebenarnya?

- **Kesimpulan**: **Ya, disarankan** menambahkan/mempertegas aturan eksplisit bahwa indeks hanya untuk pemilihan, dan `SKILL.md` yang relevan **wajib dibaca/di-load** sebelum mengerjakan.
- **Alasan**:
  - `SKILLS_INDEX.md` hanya memuat `path` + trigger singkat ("kapan di-load"), bukan isi aturan/workflow/larangan lengkap.
  - Tanpa aturan tegas, indeks bisa disalahgunakan sebagai pengganti skill sebenarnya sehingga melanggar prinsip "dilarang mengerjakan sesuatu tanpa panduan dari sebuah skill atau rules" (AGENTS poin 1–3).
  - Indeks bisa _stale_, sedangkan `SKILL.md` adalah sumber kebenaran.
- **Usulan isi aturan (inti)**:
  - Gunakan `SKILLS_INDEX.md` hanya untuk menemukan/memilih skill yang relevan.
  - Setelah skill terpilih, **wajib load/baca `SKILL.md` pada path terkait** sebelum mulai mengerjakan tugas.
  - Dilarang mengandalkan ringkasan indeks sebagai pengganti isi `SKILL.md` atau aturan di `.agents/rules/global`.
  - Jika indeks tidak sinkron/stale, tetap rujuk ke `.agents/skills/**/SKILL.md` dan jalankan command sinkronisasi indeks.
- **Lokasi aturan**: sebaiknya ditegaskan di `AGENTS.md` (pintu masuk) dan/atau sebagai rule di `.agents/rules/global` agar berlaku konsisten; command indeks juga perlu menjaga referensi/prinsip ini.

## Status Kesiapan

- **Status**: **final**. Diskusi ditandai final sesuai permintaan pengguna; rincian implementasi/pembaruan aturan dan file terkait dikerjakan terpisah mengikuti keputusan yang tercatat.
- **Konfirmasi terbaru**:
  - Poin 2: identitas = path, format entri `1. <path>` + `- Trigger : <trigger>` (typo diperbaiki) + `- Status : diperbarui : <tanggal dan waktu>`, urut alfabetis sesuai path. Heading folder **`## <folder>`** (mis. `## custom`, `## bawaan`).
  - Poin 3: kelompok per folder/kategori.
  - Poin 4: `.agents/skills/ok` dihapus.
  - Poin 6: nama command `.kilo/commands/perbarui_skills_index.md`.
  - **Status diperbarui**: **wajib di metadata `SKILL.md`** (usulan field `metadata.diperbarui`, sumber kebenaran; indeks menampilkan dari metadata). **Pemicu**: setiap isi skill berubah — cakupan **luas** (seluruh `SKILL.md`, frontmatter/body), **setiap perubahan menaikkan `metadata.versi`** (bump default **patch `x.y.Z`**, kasus khusus dapat dirinci). **Sumber perubahan**: `metadata.commit-terakhir` diusulkan diganti nama (mis. `metadata.sumber-terakhir`) untuk mencatat sumber terakhir (commit rujukan atau perintah/hasil eksplisit pengguna); tidak selalu sinkron, ketentuan detail perlu ditetapkan. **Format waktu baku**: sesuai output `TZ=Asia/Jakarta date`.
  - **Trigger di indeks**: **wajib ditulis dalam bahasa Indonesia** meskipun skill/`description` berbahasa Inggris.
- **Arah yang sedang dibahas (belum keputusan final)**: indeks trigger-only, cukup command (bukan skill), `SKILLS_INDEX.md` di-hook ke `AGENTS.md` sebagai indeks bantu (sumber kebenaran tetap `SKILL.md`, wajib di-load), sinkron rutin sesuai pemicu, dan penegasan aturan agar skill sebenarnya selalu di-load.
- **Yang masih perlu diputuskan/dirinci (belum final)**:
  1. **Poin 1 & 5 (trigger, Opsi B)**: definisi trigger tegas dan konvensi/aturan ekstraksi + penormalan dari `description` ke trigger Indonesia yang extractable & deterministik (ID/EN, posisi/pola/penanda, pemisah dari non-trigger). **Fallback** jika trigger tidak jelas/tidak teridentifikasi (mis. penanda "perlu dilengkapi trigger" dan/atau lapor), tanpa melanggar syarat trigger-only.
  2. **Poin 2 (format detail)**: heading `## <folder>` dan label `Trigger` dikonfirmasi; **format waktu baku dikonfirmasi** (`TZ=Asia/Jakarta date`). Catatan: output `date` bisa bergantung locale; konsistensi string waktu aktual mengikuti output perintah tersebut di lingkungan eksekusi.
  3. **Status "diperbarui" di metadata `SKILL.md`**: nama/struktur field final (usulan `metadata.diperbarui`). **Dikonfirmasi**: cakupan "isi skill berubah" **luas** (seluruh `SKILL.md`, frontmatter/body) → `metadata.diperbarui` wajib diperbarui; setiap isi skill berubah juga **selalu menaikkan `metadata.versi`** (bump default **patch `x.y.Z`**, kasus khusus dapat dirinci). **Format waktu baku**: output `TZ=Asia/Jakarta date`. **Sumber perubahan**: `metadata.commit-terakhir` **diusulkan diganti nama** menjadi field sumber terakhir (mis. `metadata.sumber-terakhir`) agar dapat diisi hash commit rujukan atau hasil/perintah eksplisit pengguna; tidak selalu sinkron, **ketentuan detail pengisian belum ditetapkan**. (Nilai di indeks bersumber dari metadata dan dipertahankan per skill saat regenerasi.)
  4. **Poin 8 (aturan & migrasi)**: rincian perubahan `.agents/rules/global/aturan_skill.md` dan penyelarasan `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md` (konvensi trigger, kewajiban field diperbarui, rekonsiliasi §7.1/§8, template/contoh/checklist). **Strategi migrasi** ~84 skill existing: audit, urutan/prioritas per batch, perlakuan khusus `bawaan` (EN/format berbeda), kepatuhan aturan sumber isi/pembaruan skill serta §6.
     - **Khusus `bawaan` — acuan `.config/dart_skills/skills_config.json` (dikonfirmasi)**: ambil **satu** `installedAt` acuan dari **baris pertama** (entri `installedAt` pertama yang muncul) dalam config; **konversi UTC (`Z`) ke Asia/Jakarta** (format baku: output `TZ=Asia/Jakarta date`) sebelum dibandingkan dengan waktu/status di indeks/`metadata.diperbarui`. Jika config lebih baru → **wajib perbarui skill di folder `bawaan` saja** (seperti biasa, sesuai aturan). Cakupan teknis rinci pembaruan masih perlu ditetapkan.
  5. **Poin 7**: isi butir ke-4 `.kilo/commands/mode/mode_diskusi.md`.
  6. **Draf isi command** `.kilo/commands/perbarui_skills_index.md`: langkah kerja final (scan, ekstraksi/penormalan trigger ke ID, baca status dari metadata, tulis indeks, sinkron referensi `AGENTS.md`, validasi/pelaporan, serta cek khusus `bawaan` terhadap `.config/dart_skills/skills_config.json`) setelah poin 1–5,7,8 jelas.
- **Langkah selanjutnya**: bahas satu per satu — rincian makna "isi skill berubah" & relasi dengan `metadata.versi`/`metadata.commit-terakhir`, Poin 1/5, Poin 8, Poin 7. Penentuan final dan draf command ditunda.
- **Catatan**: penentuan final dan penyusunan draf isi command ditunda sampai ada arahan lebih lanjut.

## Diskusi Poin 1 & 8: Opsi B, Pembaruan Aturan, dan Migrasi (Penjelasan)

- **Konteks & syarat tegas**: "Di-load ketika" di `SKILLS_INDEX.md` **wajib hanya trigger** (kondisi/tugas pemicu), bukan cakupan/larangan/workflow/detail teknis. Seleksi skill saat sesi baru/discovery memakai `name` dan `description`; isi `SKILL.md` dibaca setelah skill dipilih. `SKILLS_INDEX.md` hanya indeks bantu (sumber kebenaran: `SKILL.md` + `.agents/rules/global`).
- **Keputusan parsial**: Opsi A gugur (campuran non-trigger); Opsi C tidak cocok (metadata tidak dikirim saat sesi baru/discovery). **Arah: Opsi B** — ekstrak trigger dari `description`.
- **Masalah saat ini**: format `description` belum seragam (ID/EN, posisi trigger berbeda, kadang implisit/campuran), sehingga ekstraksi trigger-only butuh definisi dan konvensi tegas.

### 8.1 Mengapa `.agents/rules/global/aturan_skill.md` (dan skill terkait) perlu diperbarui

- Aturan saat ini (§7.1, §8) mewajibkan `description` "sangat detail" dan mencakup trigger, cakupan, yang dihindari, workflow, referensi, tanpa konvensi segmen trigger yang eksplisit dan dapat diekstrak deterministik.
- Agar Opsi B konsisten dan indeks tetap trigger-only, aturan pembuatan/pembaruan `SKILL.md` harus mendefinisikan dan mewajibkan trigger yang extractable. `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md` (dan referensi terkait) harus diselaraskan dengan aturan yang sama.

### 8.2 Rincian perubahan yang perlu diatur di `aturan_skill.md` (draft)

- **Definisi trigger**: teks yang menyatakan **kondisi/tugas pemicu** kapan skill di-load/digunakan; eksplisit (bukan implisit); spesifik; tidak memuat cakupan, larangan, langkah workflow, versi/package, daftar class/method, atau referensi file.
- **Konvensi format/penempatan di `description` (agar deterministik, trigger-only extractable)** — perlu diputuskan:
  - Penanda/pola pemicu yang diakui (mis. "Gunakan saat/ketika/untuk…" / "Use when/during/for/to…") dan/atau **posisi/struktur tetap** (mis. segmen/kalimat trigger berada di awal `description`).
  - Pemisah jelas antara segmen trigger dan informasi lain (agar command dapat mengambil trigger saja tanpa menyertakan non-trigger).
  - Penanganan bahasa (ID/EN) mengingat skill `custom` dan `bawaan` berbeda; konvensi harus dapat diterapkan/diidentifikasi secara konsisten.
- **Rekonsiliasi §7.1 & §8**: tetap memenuhi kebutuhan seleksi dan informasi wajib (trigger/kapan digunakan, cakupan, yang dihindari, workflow, referensi), namun merumuskan ulang struktur `description` (atau pembagian segmen) sehingga ada bagian **trigger-only** yang jelas untuk ekstraksi indeks tanpa menghapus informasi wajib.
- **Template, contoh, dan checklist**: perbarui §7.3, §8, §10 (template), dan §11 (checklist) agar mencerminkan konvensi trigger baru dan kriteria "trigger extractable".
- **Relasi dengan `SKILLS_INDEX.md`**: tegaskan bahwa indeks hanya memuat trigger dari `description` sesuai konvensi; sumber kebenaran tetap `SKILL.md`.

### 8.3 Penyelarasan skill/dokumen terkait

- `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md`: wajib diselaraskan (definisi, format, template, contoh, checklist, sumber evaluasi) dengan `aturan_skill.md`.
- Referensi format skill (mis. skill acuan di §3) dan panduan relevan lain: ditinjau agar konsisten dengan konvensi trigger.
- Command `.kilo/commands/perbarui_skills_index.md` (saat dibuat): mengimplementasikan aturan ekstraksi + fallback yang diputuskan, serta menjaga referensi `SKILLS_INDEX.md` di `AGENTS.md`.

### 8.4 Strategi migrasi/penanganan skill existing (draft, belum diputuskan)

- **Inventaris saat ini**: ~84 `SKILL.md` (`custom`, `bawaan`), campuran ID/EN, struktur/format `description` beragam; `.agents/skills/ok` sudah tidak ada.
- **Cakupan penerapan**:
  - _Skill baru / yang dibuat atau diperbarui_: wajib mengikuti konvensi trigger baru.
  - _Skill existing yang belum sesuai_: perlu dinormalisasi agar trigger dapat diekstrak dan indeks trigger-only valid.
- **Pendekatan migrasi (opsi untuk diputuskan)**:
  - Audit seluruh `SKILL.md` untuk mengidentifikasi `description` yang trigger-nya eksplisit, implisit, atau tidak extractable.
  - Normalisasi bertahap/prioritas (mis. `custom` lebih dulu, atau per batch) dengan memperbarui segmen trigger di `description` sesuai konvensi baru.
    - **"Per batch"**: mengerjakan normalisasi dalam **kelompok kecil skill yang terdefinisi** per putaran, bukan mengubah semua ~84 `SKILL.md` sekaligus.
    - **Contoh pengelompokan batch (opsi, belum diputuskan)**: per folder/kategori (mis. `custom` dulu, lalu `bawaan`), per jumlah tetap (mis. 10–20 skill per batch), per rentang/urutan alfabetis path, atau per prioritas hasil audit (mis. trigger implisit/tidak extractable didahulukan).
    - **Tujuan**: memudahkan tinjauan dan kontrol, membatasi cakupan perubahan/dampak, memungkinkan verifikasi hasil (ekstraksi trigger/indeks/kepatuhan aturan) tiap batch, serta memberi ruang melapor & mengusulkan perbaikan per §6 sebelum mengubah. Setiap batch tetap mematuhi aturan sumber isi yang berlaku saat memperbarui skill.
  - Patuhi aturan sumber isi skill yang berlaku saat memperbarui (mis. ketentuan riwayat commit pada aturan pembuatan/pembaruan skill) dan §6 (laporkan & usulkan perbaikan, jangan mengubah tanpa arahan).
- **Penanganan skill `bawaan`**: format/bahasa berbeda (EN) dan mungkin mengikuti konvensi/siklus berbeda dari `custom`; perlu keputusan khusus apakah dinormalisasi ke konvensi trigger yang sama, diberi pengecualian terbatas, atau ditangani dengan strategi terpisah (tetap harus memungkinkan indeks trigger-only tanpa menyalin non-trigger).
  - **Acuan waktu untuk `bawaan` (dikonfirmasi)**: ambil **satu** `installedAt` dari **baris pertama** (nilai `installedAt` pertama yang muncul secara tekstual) di `.config/dart_skills/skills_config.json` (UTC, `Z`). **Konversi ke Asia/Jakarta** sebelum dibandingkan dengan waktu/status di indeks/`metadata.diperbarui`. Jika acuan lebih baru → **wajib perbarui skill-skill di folder `bawaan` saja** (seperti biasa, sesuai aturan pembaruan skill: mis. perbarui `metadata.diperbarui`, normalisasi trigger/isi sesuai konvensi, sinkron indeks) dan patuhi aturan sumber isi/pembaruan skill bawaan. Format waktu baku Asia/Jakarta masih perlu ditetapkan.
- **Fallback selama transisi (terkait Poin 5, belum diputuskan)**: jika trigger tidak teridentifikasi andal, command **tidak boleh** menyalin seluruh `description` (melanggar trigger-only). Alternatif: tulis penanda eksplisit (mis. "perlu dilengkapi trigger") dan/atau laporkan skill bermasalah agar diperbaiki.
- **Dampak**: pembaruan aturan dan migrasi memengaruhi banyak file skill; implementasi perubahan aktual dilakukan di luar sesi diskusi ini sesuai arahan dan aturan repo.

- **Status**: penjelasan Poin 8 disampaikan dan didokumentasikan; detail teknis (konvensi trigger, rekonsiliasi §7.1/§8, perlakuan `bawaan`, strategi & urutan migrasi, fallback) menjadi acuan implementasi sesuai keputusan yang tercatat.
- **Klarifikasi lanjutan**: trigger di `SKILL.md` (sumber, dalam `description`) perlu **eksplisit dan cukup jelas/lengkap** dalam mendefinisikan kondisi/tugas pemicu (agar andal untuk indeks trigger-only dan untuk seleksi), tetapi tetap berupa informasi pemicu — bukan mencampur cakupan/larangan/workflow teknis non-trigger. Di `SKILLS_INDEX.md`, teks "Di-load ketika" tetap diringkas menjadi trigger singkat dan spesifik.
- **Klarifikasi mekanisme loading**: pemilihan/loading skill didasarkan pada kecocokan tugas dengan **`name` dan `description`** (frontmatter) yang tersedia; isi lengkap `SKILL.md` dibaca/di-load setelah skill relevan dipilih. Karena itu, kolom "Di-load ketika" di indeks merepresentasikan informasi pemicu yang sama dengan yang dipakai untuk seleksi (bersumber dari trigger dalam `description`).
- **Klarifikasi visibilitas metadata ke model**: pada lingkungan ini, daftar `<available_skills>` yang diberikan ke model untuk discovery berisi `name`, `description`, dan `location` — **tidak mencakup seluruh field `metadata.*`** (mis. `kategori`, `versi`, `commit-terakhir`, `model`, atau usulan `metadata.load-when`). Field metadata tersebut ada di frontmatter `SKILL.md` dan baru terlihat saat file `SKILL.md` dibaca/di-load. Ini berlaku juga pada **sesi baru** (metadata frontmatter tidak dikirim sebagai bagian discovery saat sesi dimulai). Ini menjadi alasan Opsi C tidak cocok sebagai mekanisme pemicu.

## Diskusi: Status per Skill di Indeks

- **Keputusan (parsial)**:
  - **Wajib di metadata `SKILL.md`**: info "diperbarui" wajib ada di frontmatter `SKILL.md` (usulan field `metadata.diperbarui`) sebagai sumber kebenaran agar diketahui skill sudah terbaru. Indeks `SKILLS_INDEX.md` menampilkan nilai ini (indeks tetap turunan/generated).
  - **Pemicu/kapan diperbarui**: **setiap isi skill berubah** (timestamp di `metadata.diperbarui` diperbarui saat isi skill berubah). Rincian cakupan "isi skill" (mis. frontmatter/body/trigger, dan apakah perubahan tertentu dikecualikan) masih perlu dirumuskan agar konsisten.
  - **Zona waktu**: Asia/Jakarta. **Format waktu baku (dikonfirmasi)**: sesuai output perintah `TZ=Asia/Jakarta date`.
  - **Khusus skill `bawaan` (dikonfirmasi)**: acuan waktu **wajib** merujuk ke `.config/dart_skills/skills_config.json`. Ambil **satu waktu saja**: `installedAt` dari **baris pertama** (entri `installedAt` pertama yang muncul). **Konversi UTC (`Z`) ke Asia/Jakarta** (format baku: output `TZ=Asia/Jakarta date`) sebelum dibandingkan dengan waktu/status di indeks atau `metadata.diperbarui` skill bawaan. Jika acuan lebih baru → **wajib perbarui skill-skill di folder `bawaan` saja** (seperti biasa, sesuai aturan) beserta sinkronisasi indeks.
- **Implikasi**:
  - Command `.kilo/commands/perbarui_skills_index.md` membaca `metadata.diperbarui` dari `SKILL.md` dan menampilkannya di indeks; karena bersumber dari `SKILL.md`, nilai per skill **dipertahankan** sesuai metadata (tidak ditulis ulang ke waktu generate) selama `SKILL.md` tidak berubah.
  - Untuk `bawaan`, command mengambil **satu** `installedAt` acuan dari **baris pertama** `.config/dart_skills/skills_config.json`, **mengonversinya ke Asia/Jakarta**, lalu membandingkannya dengan status/waktu di indeks/metadata untuk menentukan kebutuhan pembaruan (hanya folder `bawaan`, dilakukan seperti biasa sesuai aturan).
  - `.agents/rules/global/aturan_skill.md` dan `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md` harus diperbarui (field wajib frontmatter, makna, format waktu baku Asia/Jakarta, pemicu "setiap isi skill berubah", relasi dengan `metadata.versi`/`metadata.commit-terakhir`, template, contoh, checklist) serta strategi migrasi skill existing (~84, termasuk `bawaan`).
- **Belum diputuskan (detail)**:
  - **Nama/struktur field final**: `metadata.diperbarui` (usulan, belum dikunci final) atau nama lain.
  - **Makna "isi skill berubah"**: definisi tepat ruang lingkup perubahan yang mewajibkan pembaruan timestamp (mis. perubahan isi `SKILL.md` termasuk frontmatter/deskripsi trigger/body; dan kebijakan jika hanya metadata tertentu berubah).
  - **Relasi/konsistensi**: hubungan `metadata.diperbarui` dengan `metadata.versi` dan `metadata.commit-terakhir` (apakah selalu sinkron/diubah bersamaan, dan aturannya).
  - **Format waktu baku (Asia/Jakarta)**: **dikonfirmasi** — sesuai output perintah `TZ=Asia/Jakarta date` (contoh referensi saat diskusi: `Thu Nov 12 04:10:59 WIB 2026`). Referensi pola waktu lain di repo: `.config/dart_skills/skills_config.json` field `installedAt` bernilai `2026-11-11T11:49:58.403553Z` (ISO 8601/RFC 3339 UTC, `Z`) — untuk perbandingan dengan acuan bawaan tetap konversi ke Asia/Jakarta ke format baku yang sama.
  - **Fallback (Poin 5)**: status/representasi bila trigger tidak jelas/tidak teridentifikasi (mis. "perlu dilengkapi trigger").
- **Status**: tercakup dalam keputusan final diskusi ini.

## Diskusi: Makna "Isi Skill Berubah" & Relasi Metadata (Status diperbarui)

- **Keputusan (dikonfirmasi, masih ada detail terbuka)**:
  - **Cakupan "isi skill berubah" — luas**: setiap perubahan pada file `SKILL.md` (frontmatter dan/atau body) dianggap "isi skill berubah" → `metadata.diperbarui` **wajib** diperbarui. (Catatan: `metadata.model` opsional diperbarui tiap skill diedit; perubahan nilai `metadata.diperbarui` adalah konsekuensi, bukan pemicu terpisah.)
  - **Relasi dengan `metadata.versi`**: setiap "isi skill berubah" juga **selalu menaikkan `metadata.versi`**. **Aturan bump default (dikonfirmasi)**: **patch (`x.y.Z`)**. **Belum ditetapkan**: rincian/kasus khusus bump (mis. kapan minor/major).
  - **Sumber perubahan (pengganti `metadata.commit-terakhir`, dikonfirmasi arah)**: field rujukan sumber **diubah namanya** (usulan: `metadata.sumber-terakhir`) agar dapat diisi **sumber terakhir** perubahan — mis. hash commit rujukan **atau** hasil/perintah eksplisit pengguna — karena tidak selalu sinkron dengan commit. **Belum ditetapkan**: nama field final, format/nilai yang diizinkan, dan ketentuan kapan/apa yang dicatat (konsistensi dengan aturan sumber isi §5 dan proses pembaruan).
  - **Waktu pencatatan**: nilai `metadata.diperbarui` menggunakan format baku output `TZ=Asia/Jakarta date`; diperbarui saat perubahan `SKILL.md` dilakukan/diselesaikan (selaras pemicu luas di atas). (Untuk `bawaan`, acuan kelayakan pembaruan tetap dibandingkan terhadap `installedAt` baris pertama `.config/dart_skills/skills_config.json` yang dikonversi ke Asia/Jakarta.)
- **Masih terbuka**: nama/struktur field final `metadata.diperbarui` dan `metadata.sumber-terakhir` (usulan), aturan bump semver kasus khusus, dan ketentuan detail pengisian sumber terakhir.

## Catatan

- Diskusi telah ditandai **final**. Draf isi command `.kilo/commands/perbarui_skills_index.md` dan implementasi perubahan aturan/indeks dikerjakan pada tahap selanjutnya sesuai keputusan yang tercatat.
