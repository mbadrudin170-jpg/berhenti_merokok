# Hasil Diskusi 1 — Penyebab Skill Spesifik Tidak Termuat Otomatis dan Strategi Routing

## Status
- Dokumen: Draft
- Implementasi: Sedang Diimplementasikan (R-2 sebagian: pendaftaran `SKILLS_INDEX.md` ke `instructions`)
- Tanggal: 2026-11-12
- Topik: Analisis penyebab skill spesifik tidak dimuat pada pekerjaan spesifik, serta rekomendasi perbaikan routing skill.

## Latar Belakang
Pengguna mengemukakan bahwa pada saat pekerjaan bersifat spesifik, skill spesifik yang relevan tidak termuat. Pertanyaan yang diajukan: mengapa hal tersebut terjadi. Diskusi ini menelusuri mekanisme pemuatan skill Kilo, konfigurasi global `~/.config/kilo/kilo.jsonc`, isi `SKILLS_INDEX.md`, serta struktur deskripsi pada berkas `SKILL.md`.

Konteks pemeriksaan:
- Jumlah berkas `SKILL.md` di `.agents/skills`: 87 (54 `custom` + 33 `bawaan`).
- `available_skills` menampilkan 88 entri (87 skill proyek + `kilo-config` bawaan Kilo).
- `SKILLS_INDEX.md` memuat 87 entri dengan baris `Trigger`.
- Folder `hasil_diskusi/` pada saat diskusi berlangsung kosong (komitmen `037ffa4` menghapus `diskusi_6.md`), sehingga berkas ini menjadi `diskusi_1.md`.

## Poin Diskusi

### 1. Mekanisme pemuatan skill bersifat *pull*
- Tanya: Apakah isi `SKILL.md` otomatis masuk konteks?
- Kesimpulan: Tidak. Yang masuk system prompt hanya `name` + `description` pada daftar `available_skills`. Isi `SKILL.md` hanya masuk bila agen memanggil tool `skill`. Tidak ada mekanisme yang memaksa pemanggilan tersebut, sehingga kewajiban "load skill relevan" pada `AGENTS.md` hanya bersifat instruksi lunak.

### 2. Sumber discovery yang diwajibkan tidak masuk konteks
- Tanya: Mengapa `SKILLS_INDEX.md` tidak membantu routing?
- Kesimpulan: `instructions` pada `kilo.jsonc` hanya memuat `AGENTS.md` dan empat berkas rules (`aturan_skill.md`, `format_PRD.md`, `format_hasil_diskusi.md`, `format_task.md`). `SKILLS_INDEX.md` tidak terdaftar, sehingga tidak pernah otomatis masuk konteks dan bergantung pada inisiatif agen untuk membacanya.

### 3. Indeks skill belum dapat dipakai sebagai peta routing
- Tanya: Apakah isi `SKILLS_INDEX.md` cukup untuk memilih skill?
- Kesimpulan: Belum. Dari 87 entri, 55 entri memuat literal `Trigger : perlu dilengkapi trigger`. Ketiadaan kata kunci trigger membuat indeks tidak dapat dipakai untuk memetakan tugas ke skill.

### 4. Skill bertipe indeks menyembunyikan nama skill anak
- Tanya: Mengapa skill seperti `bug-runtime`, `pola-ui`, `pola-ux`, dan `widget-custom` tidak mengarahkan ke skill spesifik?
- Kesimpulan: Deskripsi skill indeks menyebut topik (mis. "type promotion null safety", "normalisasi tanggal") tanpa menyebut nama skill anak (`type-promotion-null-safety`, `normalisasi-tanggal`). Akibatnya routing membutuhkan dua tahap (muat skill indeks, lalu muat skill anak) dan tahap kedua sering terlewat.

### 5. Beban konteks dan gaya penulisan deskripsi
- Tanya: Apakah jumlah dan gaya deskripsi memengaruhi ketepatan pemilihan skill?
- Kesimpulan: Ya. Total ± 34,5 KB hanya untuk lima baris awal tiap `SKILL.md` (± 8–9k token) sebelum isi dibaca. Deskripsi ditulis sebagai paragraf naratif, bukan kata kunci trigger di posisi awal, sehingga pencocokan oleh model menjadi longgar.

### 6. Tidak ada penegakan pada level izin
- Tanya: Dapatkah konfigurasi memaksa pemuatan skill?
- Kesimpulan: Tidak. `permission` pada `kilo.jsonc` tidak memuat kunci `skill`, dan skema `permission.skill` hanya mendukung `allow`, `ask`, dan `deny` — tidak tersedia mode "wajib dimuat". Penegakan hanya dapat dilakukan melalui instruksi.

### 7. Command dan mode tidak memetakan tugas ke skill
- Tanya: Apakah `mode_diskusi.md` menyebutkan skill yang wajib dimuat?
- Kesimpulan: Tidak. `mode_diskusi.md` hanya mengatur tujuan diskusi, format berkas hasil, dan penggunaan tool `question`. Ketiadaan peta tugas ke skill membuat agen mengandalkan tebakan.

### 8. Temuan sampingan: `skills.paths` tidak valid
- Tanya: Apakah konfigurasi `skills.paths` menunjuk lokasi yang benar?
- Kesimpulan: Tidak. `kilo.jsonc` global menunjuk `/home/thefarmercompanyba/berhenti_merokok/.agents/skills/{custom,bawaan}` yang tidak ada pada host ini. Penemuan skill tetap berjalan (87 skill terdaftar dengan path benar di `/home/muhamadbadrudin1000/berhenti_merokok/.agents/skills`), sehingga temuan ini bukan penyebab langsung, namun menandakan konfigurasi tidak sinkron.

### 9. Retrieval semantik nonaktif
- Tanya: Adakah pencarian semantik untuk menemukan skill berdasarkan isi?
- Kesimpulan: Tidak. `indexing.enabled` bernilai `false` dan `codebase_search` bernilai `false`, sehingga tidak ada retrieval berbasis isi.

### 10. Status pengiriman berkas `instructions`
- Tanya: Apakah berkas yang terdaftar pada `instructions` selalu dikirim sistem kepada agen?
- Kesimpulan: Ya, selalu, dan **isinya dikirim penuh**, bukan hanya nama berkas. Berkas pada `instructions` dibaca lalu disuntikkan ke system prompt pada setiap sesi tanpa mempertimbangkan relevansi. Tanda pengenalnya berupa blok berformat `Instructions from: <path lengkap>` yang diikuti isi berkas secara verbatim (bukan tautan, bukan placeholder, bukan panggilan tool). Bukti: system prompt sesi ini memuat tepat lima blok `Instructions from:` yang berkorespondensi dengan lima entri `instructions`, dengan total ± 30,6 KB (`AGENTS.md` 4.158 B, `aturan_skill.md` 12.343 B, `format_PRD.md` 4.161 B, `format_hasil_diskusi.md` 8.342 B, `format_task.md` 1.657 B); kalimat pembuka `format_task.md` dan butir-butir `format_hasil_diskusi.md` hadir utuh di konteks. Sebaliknya, skill hanya dikirim sebagai `name` + `description`, dan command/mode hanya dikirim saat dipanggil.

## Keputusan
- K-1: `SKILLS_INDEX.md` didaftarkan pada `instructions` di `~/.config/kilo/kilo.jsonc` tanpa menghapus lima entri yang sudah ada, sehingga indeks skill selalu dikirim sebagai isi penuh pada setiap sesi di proyek ini.
- K-2: Pendaftaran memakai pola relatif (`"SKILLS_INDEX.md"`), mengikuti pola entri yang sudah ada (`.agents/rules/global/*.md`), yang terbukti diselesaikan terhadap direktori kerja proyek; proyek lain yang tidak memiliki berkas tersebut tidak terpengaruh.
- K-3: Pendaftaran dilakukan lebih dahulu (R-2), sedangkan pelengkapan 55 trigger kosong (R-1) menyusul; hal ini disepakati karena pengguna memilih penerapan langsung.
- K-4: Biaya tambahan ± 15,3 KB (± 4k token) per sesi diterima sebagai konsekuensi dari K-1.

## Rekomendasi
- R-1: Lengkapi 55 trigger kosong pada `SKILLS_INDEX.md` dengan kata kunci pencarian dan path berkas yang biasa disentuh (mis. `lib/fitur/diary_craving/**`).
- R-2: Daftarkan `SKILLS_INDEX.md` pada `instructions` di `kilo.jsonc`, atau sediakan tabel routing ringkas (satu baris per skill) pada `AGENTS.md`. Karena berkas `instructions` selalu dikirim penuh setiap sesi (lihat poin 10), disarankan memakai berkas routing ringkas (± 3–4 KB) alih-alih `SKILLS_INDEX.md` penuh (± 15 KB).
- R-3: Sebutkan nama skill anak secara eksplisit pada deskripsi skill indeks (`bug-runtime`, `pola-ui`, `pola-ux`, `widget-custom`) agar routing cukup satu tahap.
- R-4: Tambahkan daftar "skill wajib per jenis pekerjaan" pada `AGENTS.md` dan pada setiap command/mode (termasuk `mode_diskusi.md`).
- R-5: Pangkas deskripsi `SKILL.md` menjadi kata kunci trigger di posisi awal dengan batas ± 300 karakter.
- R-6: Perbaiki atau hapus `skills.paths` yang menunjuk lokasi `/home/thefarmercompanyba/...` agar sinkron dengan workspace aktif.

Prioritas termurah dengan dampak tertinggi: R-1, R-2, dan R-3.

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1 | Menunggu jawaban pengguna atas pertanyaan lanjutan (langkah dan cakupan perbaikan) | `hasil_diskusi/diskusi_1.md` | selesai |
| 2 | Menaikkan status dokumen dari `Draft` menjadi `Final` setelah keputusan diterima | `hasil_diskusi/diskusi_1.md` | belum |
| 3 | Mengerjakan R-1 (lengkapi trigger kosong) | `SKILLS_INDEX.md` | belum |
| 4 | Mengerjakan R-2 (routing index/instruksi): daftarkan `SKILLS_INDEX.md` ke `instructions` | `~/.config/kilo/kilo.jsonc` | selesai |
| 5 | Mengerjakan R-3 (sebut nama skill anak) | `.agents/skills/custom/{bug-runtime,pola-ui,pola-ux,widget-custom}/SKILL.md` | belum |
| 6 | Mengerjakan R-4 (peta tugas ke skill) | `AGENTS.md`, `.kilo/commands/mode/mode_diskusi.md` | belum |
| 7 | Mengerjakan R-5 (pemangkasan deskripsi) | `.agents/skills/**/SKILL.md` | belum |
| 8 | Mengerjakan R-6 (perbaiki `skills.paths`) | `~/.config/kilo/kilo.jsonc` | belum |
| 9 | Verifikasi pada sesi baru bahwa `SKILLS_INDEX.md` muncul sebagai blok `Instructions from:` | `~/.config/kilo/kilo.jsonc` | belum |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_1.md` | Dibuat | Berkas hasil diskusi ini (Draft). |
| `SKILLS_INDEX.md` | Belum ditentukan (kandidat Diubah) | Kandidat pelengkapan 55 trigger kosong (R-1). |
| `~/.config/kilo/kilo.jsonc` | Diubah | Penambahan `"SKILLS_INDEX.md"` pada `instructions` (K-1); `skills.paths` masih menunggu R-6. |
| `AGENTS.md` | Belum ditentukan (kandidat Diubah) | Kandidat tabel routing dan peta skill wajib per pekerjaan (R-2, R-4). |
| `.agents/skills/custom/bug-runtime/SKILL.md` | Belum ditentukan (kandidat Diubah) | Kandidat penyebutan nama skill anak pada deskripsi (R-3). |
| `.agents/skills/custom/pola-ui/SKILL.md` | Belum ditentukan (kandidat Diubah) | Kandidat penyebutan nama skill anak pada deskripsi (R-3). |
| `.agents/skills/custom/pola-ux/SKILL.md` | Belum ditentukan (kandidat Diubah) | Kandidat penyebutan nama skill anak pada deskripsi (R-3). |
| `.agents/skills/custom/widget-custom/SKILL.md` | Belum ditentukan (kandidat Diubah) | Kandidat penyebutan nama skill anak pada deskripsi (R-3). |
| `.kilo/commands/mode/mode_diskusi.md` | Belum ditentukan (kandidat Diubah) | Kandidat penambahan daftar skill wajib untuk pekerjaan diskusi (R-4). |
| `.agents/skills/**/SKILL.md` | Belum ditentukan (kandidat Diubah) | Kandidat pemangkasan deskripsi (R-5). |

## Pertanyaan Terbuka
- Apakah perbaikan dilakukan bertahap (dokumentasi lebih dahulu, lalu perbaikan) atau langsung pada penyebab utama?
- Apakah cakupan perbaikan mencakup R-6 (`skills.paths`) dan R-5 (pemangkasan deskripsi)?
- Apakah `SKILLS_INDEX.md` yang penuh dipertahankan, atau diganti dengan berkas routing ringkas yang lebih hemat token? (keputusan K-1 memilih versi penuh; evaluasi ulang setelah R-1)
- Apakah perubahan isi berkas `instructions` di tengah sesi langsung berlaku, atau memerlukan sesi/reload baru? (belum diverifikasi)

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-12 | Dibuat `hasil_diskusi/diskusi_1.md` (Draft) berisi analisis sembilan penyebab skill spesifik tidak termuat serta rekomendasi R-1 sampai R-6. |
| 2026-11-12 | Ditambahkan poin diskusi 10 mengenai status pengiriman berkas `instructions` (selalu dikirim penuh setiap sesi), R-2 disesuaikan agar memakai berkas routing ringkas, dan dua pertanyaan terbuka diperbarui. |
| 2026-11-12 | Penerapan K-1: `"SKILLS_INDEX.md"` ditambahkan ke `instructions` pada `~/.config/kilo/kilo.jsonc` (validasi konfigurasi berhasil). Status berubah menjadi `Sedang Diimplementasikan`; ditambahkan K-1..K-4, tindak lanjut 4 ditandai selesai, dan tindak lanjut 9 (verifikasi pada sesi baru) ditambahkan. |