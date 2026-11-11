# Hasil Diskusi

## Topik
Perancangan command untuk membuat/memperbarui `SKILLS_INDEX.md` dari seluruh skill di `.agents/skills/**/SKILL.md`, serta aturan mode diskusi.

## Ringkasan Keputusan Sementara
- **Tujuan command**: memindai `.agents/skills/**/SKILL.md` dan menulis indeks ke `SKILLS_INDEX.md` (root).
- **Cakupan data indeks (dikonfirmasi/draft)**: indeks memuat **path skill**, **trigger** ("kapan/untuk apa di-load", **wajib hanya trigger**), dan **usulan status per skill** (`diperbarui : <tanggal dan waktu>`), dikelompokkan per folder/kategori.
- **Format entri (draft, diperbarui usulan)**: `1. <path skill>`, baris indentasi `- Triger : <isi trigger>`, dan baris indentasi `- Status : diperbarui : <tanggal dan waktu>`; urut alfabetis sesuai path.
- **Deskripsi/trigger**: tidak harus detail; cukup spesifik dan jelas sebagai pemicu pemilihan skill (1 kalimat/frasa kunci). Rincian lengkap tetap di `SKILL.md` yang dirujuk.
- **Batasan sesi (sebelumnya)**: diskusi saja, fokus topik, tanpa mengubah file lain. Arahan terbaru: perbarui `hasil_diskusi.md` setiap selesai reasoning.

## Fakta Repo Terkait
- `SKILLS_INDEX.md` kosong.
- Terdapat 84 `SKILL.md` (kategori terdeteksi: `bawaan`, `custom`). Folder placeholder `.agents/skills/ok` telah dihapus.
- Command existing berada di `.kilo/commands/*.md`.
- Skill standar memiliki frontmatter YAML (`name`, `description`, `metadata.*`) sesuai `.agents/rules/global/aturan_skill.md`. Format `description` saat ini belum seragam (ID/EN, posisi trigger berbeda, kadang implisit/campuran).

## Poin Terbuka (perlu keputusan)
1. **Sumber/mekanisme "Di-load ketika" (trigger-only)**: **Opsi B dipilih (arah)** — ekstrak bagian trigger saja dari `description` untuk isi indeks. **Opsi A** tidak digunakan; **Opsi C** tidak cocok (metadata tidak dikirim saat sesi baru/discovery). **Belum final**: definisi & aturan ekstraksi trigger yang tegas serta fallback (terkait Poin 5) masih perlu ditetapkan.
2. **Format indeks**: **dikonfirmasi (draft)** — penjelasan fungsi singkat + pengelompokan per folder; tiap entri: `1. <path skill>` dan baris indentasi `- Triger : <isi trigger>`; urut alfabetis sesuai path. Detail kecil gaya heading/penulisan label dapat dirapikan saat finalisasi.
3. **Pengelompokan**: **dikonfirmasi** — per kategori/folder (`custom`, `bawaan`, `lainnya` jika ada).
4. **Perlakuan `.agents/skills/ok` (placeholder)**: **selesai** — folder/skill placeholder telah dihapus (total `SKILL.md` kini 84), tidak diikutkan.
5. **Jika trigger tidak jelas/tidak teridentifikasi**: **belum diputuskan** (pakai teks apa adanya — berisiko melanggar trigger-only — atau beri penanda "perlu dilengkapi trigger" dan/atau laporkan).
6. **Identitas command**: **dikonfirmasi** — `.kilo/commands/perbarui_skills_index.md`.
7. **Mode diskusi** (`.kilo/commands/mode/mode_diskusi.md`): butir ke-4 masih kosong — **belum ditentukan**.
8. **Pembaruan `.agents/rules/global/aturan_skill.md` (dan skill terkait) + migrasi skill existing**: rincian dijelaskan di bawah; keputusan final isi perubahan & strategi migrasi **belum ditetapkan**.

## Usulan Format Isi `SKILLS_INDEX.md` (draft, dikonfirmasi arah + usulan status)
- **Fungsi file (ringkas)**: `SKILLS_INDEX.md` adalah indeks bantu untuk menemukan/memilih skill yang relevan berdasarkan **trigger** (kapan/untuk apa skill di-load). Gunakan untuk discovery, lalu **wajib baca/load `SKILL.md`** terkait sebelum mengerjakan. Sumber kebenaran: `.agents/skills/**/SKILL.md` dan `.agents/rules/global`.
- **Struktur**: penjelasan fungsi singkat di awal, lalu dikelompokkan per folder/kategori.
- **Isi per skill**: `path skill`, `trigger` (wajib hanya trigger), dan **status diperbarui** (usulan, belum diputuskan).
- **Urutan**: alfabetis sesuai path di dalam tiap kelompok (idempotent).
- **Contoh kerangka**:

```markdown
# Skills Index

Indeks bantu untuk memilih skill yang relevan berdasarkan trigger (kapan/untuk apa di-load). Setelah memilih, wajib baca/load `SKILL.md` skill terkait sebelum mengerjakan. Sumber kebenaran: `.agents/skills/**/SKILL.md` dan `.agents/rules/global`.

# custom
1. .agents/skills/custom/gaya/SKILL.md
   - Triger : Saat mengatur styling warna/tema atau opacity warna di widget Flutter.
   - Status : diperbarui : <tanggal dan waktu>
2. .agents/skills/custom/spacing/SKILL.md
   - Triger : Saat mengatur jarak/spacing antar elemen UI Flutter.
   - Status : diperbarui : <tanggal dan waktu>

# bawaan
1. .agents/skills/bawaan/dart-run-static-analysis/SKILL.md
   - Triger : Saat menjalankan analisis statis/lint atau memperbaiki issue dengan `dart fix`.
   - Status : diperbarui : <tanggal dan waktu>
```

- **Catatan (belum final)**: label penulisan ("Triger"/"Trigger"), level heading folder, format tanggal-waktu status, dan detail pemisah dapat diseragamkan saat finalisasi; teks trigger diisi hasil ekstraksi trigger-only dari `description` sesuai aturan yang nanti ditetapkan (Poin 1/5/8). Status: **draft/belum final**.

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
- **Status**: **belum final** (jangan difinalkan dulu). Arahan dan rancangan yang tercatat masih bersifat sementara/draft dan dapat berubah.
- **Konfirmasi terbaru**: Poin 2 (identitas = path, format `1. <path>` + `- Triger : <trigger>`, urut path abjad), Poin 3 (kelompok per folder), Poin 4 (`.agents/skills/ok` dihapus), Poin 6 (nama command `.kilo/commands/perbarui_skills_index.md`) dikonfirmasi. Fokus saat ini: **status per skill** — usulan baris status di indeks (`diperbarui : <tanggal dan waktu>`, Asia/Jakarta) dan usulan lanjutan bahwa `SKILL.md` wajib memiliki info diperbarui agar diketahui skill terbaru.
- **Arah yang sedang dibahas (belum keputusan final)**: indeks trigger-only, cukup command (bukan skill), `SKILLS_INDEX.md` di-hook ke `AGENTS.md` sebagai indeks bantu (sumber kebenaran tetap `SKILL.md`, wajib di-load), sinkron rutin sesuai pemicu, dan penegasan aturan agar skill sebenarnya selalu di-load.
- **Poin keputusan terbuka**:
  1. **Sumber/mekanisme (Opsi B)**: detail definisi trigger & aturan ekstraksi dari `description` **belum final**.
  2. **Format & cakupan isi**: draft diperbarui dengan usulan baris status per skill — **belum diputuskan** (makna, lokasi field wajib di `SKILL.md` vs hanya indeks, sumber/penentuan, format waktu final, dan perilaku saat regenerasi).
  3. **Pengelompokan**: dikonfirmasi per folder/kategori.
  4. **`.agents/skills/ok`**: selesai (dihapus).
  5. **Fallback jika trigger tidak jelas/tidak teridentifikasi**: **belum diputuskan** (berkaitan dengan makna/status).
  6. **Nama command**: dikonfirmasi.
  7. **Butir ke-4** `.kilo/commands/mode/mode_diskusi.md`: **belum ditentukan**.
  8. **Rincian pembaruan `aturan_skill.md` (dan skill terkait) + strategi migrasi**: dijelaskan; perlu mencakup konvensi trigger, potensi kewajiban field info diperbarui di `SKILL.md`, dan migrasi skill existing — **belum ditetapkan**.
- **Langkah selanjutnya**: tetapkan detail status per skill (Poin 2/8: makna, field wajib di `SKILL.md` atau tidak, format waktu, kapan diperbarui/dipertahankan), lalu Poin 5 & detail Poin 1/8 (aturan ekstraksi, fallback, migrasi), Poin 7, dan perapihan format.
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
  - *Skill baru / yang dibuat atau diperbarui*: wajib mengikuti konvensi trigger baru.
  - *Skill existing yang belum sesuai*: perlu dinormalisasi agar trigger dapat diekstrak dan indeks trigger-only valid.
- **Pendekatan migrasi (opsi untuk diputuskan)**:
  - Audit seluruh `SKILL.md` untuk mengidentifikasi `description` yang trigger-nya eksplisit, implisit, atau tidak extractable.
  - Normalisasi bertahap/prioritas (mis. `custom` lebih dulu, atau per batch) dengan memperbarui segmen trigger di `description` sesuai konvensi baru.
    - **"Per batch"**: mengerjakan normalisasi dalam **kelompok kecil skill yang terdefinisi** per putaran, bukan mengubah semua ~84 `SKILL.md` sekaligus.
    - **Contoh pengelompokan batch (opsi, belum diputuskan)**: per folder/kategori (mis. `custom` dulu, lalu `bawaan`), per jumlah tetap (mis. 10–20 skill per batch), per rentang/urutan alfabetis path, atau per prioritas hasil audit (mis. trigger implisit/tidak extractable didahulukan).
    - **Tujuan**: memudahkan tinjauan dan kontrol, membatasi cakupan perubahan/dampak, memungkinkan verifikasi hasil (ekstraksi trigger/indeks/kepatuhan aturan) tiap batch, serta memberi ruang melapor & mengusulkan perbaikan per §6 sebelum mengubah. Setiap batch tetap mematuhi aturan sumber isi yang berlaku saat memperbarui skill.
  - Patuhi aturan sumber isi skill yang berlaku saat memperbarui (mis. ketentuan riwayat commit pada aturan pembuatan/pembaruan skill) dan §6 (laporkan & usulkan perbaikan, jangan mengubah tanpa arahan).
- **Penanganan skill `bawaan`**: format/bahasa berbeda (EN) dan mungkin mengikuti konvensi/siklus berbeda dari `custom`; perlu keputusan khusus apakah dinormalisasi ke konvensi trigger yang sama, diberi pengecualian terbatas, atau ditangani dengan strategi terpisah (tetap harus memungkinkan indeks trigger-only tanpa menyalin non-trigger).
- **Fallback selama transisi (terkait Poin 5, belum diputuskan)**: jika trigger tidak teridentifikasi andal, command **tidak boleh** menyalin seluruh `description` (melanggar trigger-only). Alternatif: tulis penanda eksplisit (mis. "perlu dilengkapi trigger") dan/atau laporkan skill bermasalah agar diperbaiki.
- **Dampak**: pembaruan aturan dan migrasi memengaruhi banyak file skill; implementasi perubahan aktual dilakukan di luar sesi diskusi ini sesuai arahan dan aturan repo.

- **Status**: penjelasan Poin 8 disampaikan; **detail/keputusan final** (bentuk konvensi trigger, rekonsiliasi §7.1/§8, perlakuan `bawaan`, strategi & urutan migrasi, fallback) **belum ditetapkan**.
- **Klarifikasi lanjutan**: trigger di `SKILL.md` (sumber, dalam `description`) perlu **eksplisit dan cukup jelas/lengkap** dalam mendefinisikan kondisi/tugas pemicu (agar andal untuk indeks trigger-only dan untuk seleksi), tetapi tetap berupa informasi pemicu — bukan mencampur cakupan/larangan/workflow teknis non-trigger. Di `SKILLS_INDEX.md`, teks "Di-load ketika" tetap diringkas menjadi trigger singkat dan spesifik.
- **Klarifikasi mekanisme loading**: pemilihan/loading skill didasarkan pada kecocokan tugas dengan **`name` dan `description`** (frontmatter) yang tersedia; isi lengkap `SKILL.md` dibaca/di-load setelah skill relevan dipilih. Karena itu, kolom "Di-load ketika" di indeks merepresentasikan informasi pemicu yang sama dengan yang dipakai untuk seleksi (bersumber dari trigger dalam `description`).
- **Klarifikasi visibilitas metadata ke model**: pada lingkungan ini, daftar `<available_skills>` yang diberikan ke model untuk discovery berisi `name`, `description`, dan `location` — **tidak mencakup seluruh field `metadata.*`** (mis. `kategori`, `versi`, `commit-terakhir`, `model`, atau usulan `metadata.load-when`). Field metadata tersebut ada di frontmatter `SKILL.md` dan baru terlihat saat file `SKILL.md` dibaca/di-load. Ini berlaku juga pada **sesi baru** (metadata frontmatter tidak dikirim sebagai bagian discovery saat sesi dimulai). Ini menjadi alasan Opsi C tidak cocok sebagai mekanisme pemicu.

## Diskusi: Status per Skill di Indeks
- **Usulan (diperbarui)**: setiap entri skill di `SKILLS_INDEX.md` memiliki baris status `- Status : diperbarui : <tanggal dan waktu>` (contoh usulan: zona waktu Asia/Jakarta, mis. menggunakan perintah seperti `TZ=Asia/Jakarta date` dan/atau `date +"%Z"` untuk penentuan zona/waktu).
- **Kemungkinan manfaat**: memantau progres migrasi/normalisasi trigger per skill (audit → normalisasi per batch, Poin 8) dan mengetahui apakah skill sudah terbaru.
- **Usulan lanjutan (belum diputuskan)**: agar status "terbaru" dapat dipercaya sebagai sumber kebenaran per skill (bukan hanya turunan indeks), **`SKILL.md` wajib memiliki info "diperbarui"** (mis. field di frontmatter, contoh usulan: `metadata.diperbarui` berisi tanggal dan waktu).
  - **Implikasi ke aturan**: `.agents/rules/global/aturan_skill.md` dan `.agents/skills/custom/aturan-pembuatan-skill/SKILL.md` perlu diperbarui — mendefinisikan field (wajib/opsional), makna "diperbarui", format waktu (mis. Asia/Jakarta, format standar), kapan harus diperbarui, serta relasi/konsistensi dengan `metadata.versi` dan `metadata.commit-terakhir`; memperbarui template, contoh, dan checklist.
  - **Implikasi ke command/indeks**: command `.kilo/commands/perbarui_skills_index.md` dapat membaca info diperbarui dari `SKILL.md` dan menampilkannya di `SKILLS_INDEX.md` (indeks tetap turunan; sumber status di `SKILL.md` jika diwajibkan).
  - **Catatan discovery**: field `metadata.*` tidak dikirim saat sesi baru/discovery `<available_skills>`, tetapi dapat dibaca saat `SKILL.md` di-load dan saat command generate indeks; kewajiban info diperbarui tetap relevan untuk kejelasan sumber skill.
  - **Implikasi migrasi**: penambahan field wajib memengaruhi skill existing (~84, `custom`/`bawaan`) dan perlu strategi migrasi/penanganan (audit, normalisasi per batch, kepatuhan §6 dan aturan sumber isi) yang konsisten.
- **Hal yang perlu diputuskan (belum diputuskan)**:
  - **Makna "diperbarui"**: menandakan apa? (mis. trigger/isi skill sudah dinormalisasi/sesuai konvensi & extractable trigger-only; skill telah diperbarui dan merupakan versi terbaru yang berlaku; atau definisi lain). Definisi harus jelas dan konsisten.
  - **Lokasi & kewajiban field**: ditaruh di frontmatter `SKILL.md` (mis. `metadata.diperbarui`) sebagai field wajib, atau hanya ditampilkan di indeks? Jika wajib di `SKILL.md`, aturan frontmatter/template/checklist harus diubah.
  - **Peristiwa yang menetapkan/memperbarui timestamp**: kapan waktu dicatat/diubah per skill? (mis. setiap kali `SKILL.md` diperbarui/dinormalisasi; saat konvensi trigger terpenuhi; atau kondisi lain). Ini penting karena `SKILLS_INDEX.md` digenerate ulang oleh command.
  - **Perilaku saat regenerasi indeks**: karena indeks dihasilkan ulang, timestamp per skill **dipertahankan** dari kondisi sebelumnya selama skill tidak berubah, atau **ditulis ulang** (mis. menjadi waktu generate)? Jika dipertahankan per skill dan bersumber dari `SKILL.md`, command mengambil dari field tersebut (lebih konsisten/idempotent).
  - **Format waktu final**: format output `TZ=Asia/Jakarta date` apa adanya, atau format standar yang ditetapkan (termasuk zona, mis. WIB/`%Z`)? Perlu konsistensi agar mudah dibandingkan.
  - **Keterkaitan dengan Poin 5 (fallback)**: jika trigger tidak jelas/tidak teridentifikasi, statusnya apa (mis. "perlu dilengkapi trigger" tanpa/tanpa tanggal, atau bentuk lain) dan apakah status juga berfungsi sebagai fallback.
- **Status usulan**: **draft/belum diputuskan**.

## Catatan
- Draf isi command belum dibuat; menunggu keputusan poin terbuka.
