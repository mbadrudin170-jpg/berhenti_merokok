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

### 11. Pendaftaran `MEMORI.md` ke `instructions`
- Tanya: Apakah `MEMORI.md` juga sebaiknya didaftarkan ke `instructions` seperti `SKILLS_INDEX.md`?
- Kesimpulan: Tidak disarankan. `instructions` menyuntikkan snapshot saat sesi dimulai, sedangkan `MEMORI.md` adalah dokumen hidup yang berubah setiap interaksi. Bukti: `MEMORI.md` berubah dari 23.029 B menjadi 28.428 B di tengah sesi ini karena ada pihak lain (sesi `riset_kompetitor`) yang menulis bersamaan. Snapshot usang di prompt lebih berbahaya daripada tidak ada salinan, karena agen cenderung mempercayai salinan tersebut dan tidak sadar isinya sudah usang — memperburuk risiko yang didokumentasikan pada diskusi no. 2. Biaya bila didaftarkan: total `instructions` naik menjadi ± 74,4 KB (± 19k token) per sesi. `AGENTS.md` poin 5 sudah mewajibkan pembacaan `MEMORI.md` via tool, yang menjamin kesegaran isi.

### 12. Faktor yang membuat model mematuhi aturan
- Tanya: Apa yang membuat model AI selalu mematuhi aturan?
- Kesimpulan: Tidak ada jaminan kepatuhan mutlak. Kepatuhan bersifat probabilistik dan hanya sebagian lapisan bersifat penegakan keras. Lapisan lunak: isi system prompt (`instructions`, `AGENTS.md`), skema tool, dan deskripsi skill. Lapisan keras: `permission` pada `kilo.jsonc` (`allow`/`ask`/`deny`) yang dieksekusi harness, validasi konfigurasi Kilo, linter/test, dan git hook. Bukti penegakan keras pada sesi ini: percobaan `sed -n ...` ditolak harness dengan `{"permission":"bash","pattern":"sed *","action":"deny","source":"global"}` sebelum perintah berjalan. Faktor yang memengaruhi tingkat kepatuhan: kekuatan model (model free lebih labil), posisi instruksi, kekonkretan aturan, jumlah aturan (dilusi), dan keberadaan umpan balik deterministik.

### 13. Perbaikan `agent.code.prompt` pada `kilo.jsonc`
- Tanya: Apakah prompt `"kamu adalah pekerja saya"` perlu diperbaiki?
- Kesimpulan: Secara isi, ya — prompt tersebut tidak memuat peran, standar kerja, Kewajiban verifikasi, maupun larangan apa pun, sehingga tidak menambah kepatuhan. Berdasarkan dokumentasi resmi Kilo, `prompt` pada `agent` adalah opsi sah ("Custom system prompt. In JSON, can use `{file:./path}` syntax"), dan saat menimpa agent bawaan hanya field yang ditentukan yang ditimpa — jadi secara skema `"kamu adalah pekerja saya"` seharusnya berlaku sebagai system prompt agent `code`. Namun pada sesi berjalan, persona system prompt yang aktif adalah persona bawaan Kilo (bahasa Inggris), bukan `"kamu adalah pekerja saya"`. Yang mempersulit diagnosis: `permission` dari berkas `kilo.jsonc` yang sama **jelas berlaku** (contoh `sed *` ditolak harness dengan `source: global`), sehingga berkas config memang dimuat; hanya override `agent.code.prompt` yang tidak tampak. Tidak ditemukan `kilo.json`/`.kilo/kilo.json` di workspace, tidak ada `.kilo/agent/*.md` maupun `~/.kilo/`, dan tidak ada `~/.config/kilo/AGENTS.md`, sehingga tidak ada sumber yang menimpa `agent.code` selain berkas global tersebut. Perlu diverifikasi apakah override prompt untuk agent bawaan benar-benar diterapkan pada versi Kilo yang dipakai, atau apakah sesi berjalan memakai klien/preset berbeda.

### 14. Portabilitas prompt antar akun cloud shell
- Tanya: Di mana prompt sebaiknya dititipkan mengingat pengguna berpindah-pindah akun cloud shell?
- Kesimpulan: Berkas prompt **wajib berada di dalam repository proyek**, bukan di `~/.config/kilo/`. Alasan: (a) direktori home berbeda antar akun (contoh nyata: `/home/thefarmercompanyba/berhenti_merokok` vs `/home/muhamadbadrudin1000/berhenti_merokok`), sehingga path absolut pada config global selalu rusak; (b) isi repo ikut terbawa saat berpindah akun. Dengan `{file:./prompts/code.md}` pada `kilo.json` proyek, path diresolusi relatif terhadap berkas config di root repo, sehingga tetap benar di akun mana pun. Temuan turunan: `skills.paths` pada `kilo.jsonc` global (R-6) sebaiknya **dihapus**, bukan sekadar diperbaiki path-nya, karena penemuan skill sudah otomatis dari `.agents/skills` di dalam repo.

### 15. Akun Google berbeda membuat config global tidak persisten
- Tanya: Apa konsekuensi nyata dari berpindah-pindah akun cloud shell?
- Kesimpulan: Setiap akun Google memiliki home cloud shell tersendiri, sehingga `~/.config/kilo/kilo.jsonc` **tidak ikut berpindah**. Artinya `instructions`, `permission`, `agent.*.prompt`, dan `skills.paths` semuanya hilang saat ganti akun dan harus dipulihkan manual. Temuan pendukung: (a) `skills.paths` masih menunjuk `/home/thefarmercompanyba/berhenti_merokok/...` — yaitu home akun lama, membuktikan config global memang tidak portabel; (b) sudah ada salinan config di dalam repo pada `docs/kilo/kilo_global.txt` yang **identik** dengan config aktif (perintah `diff` menghasilkan "IDENTIK", 4.606 B), sehingga mekanisme pemulihan manual sudah tersedia; (c) `prompts/code.md` yang baru dibuat berada di repo, tetapi bila diwire dari config global `{file:./prompts/code.md}` akan diresolusi ke `~/.config/kilo/prompts/code.md` yang tidak ada — sehingga perlu diputuskan apakah prompt diwire via config global (dengan berkas ikut dipulihkan) atau via `kilo.json` proyek.

### 16. Penempatan berkas pada `/home/muhamadbadrudin1000/`
- Tanya: Apakah berkas dapat ditaruh pada `/home/muhamadbadrudin1000/` agar tetap tersedia?
- Kesimpulan: Tidak menyelesaikan masalah. `/home/muhamadbadrudin1000/` adalah `$HOME` itu sendiri (hasil `ls /home` hanya memuat satu direktori pengguna), sehingga penempatannya setara dengan `~/.config/kilo/` — tetap berada pada home per akun Google dan tetap hilang saat berpindah akun. Tidak ditemukan `/workspaces` maupun `/workspace` pada lingkungan ini, sehingga tidak ada lokasi bersama lintas akun. Satu-satunya artefak yang ikut berpindah adalah repository Git, sehingga berkas konfigurasi kanonis harus berada di dalam repo dan dipulihkan dengan skrip.

### 17. Repository konfigurasi terpisah untuk portabilitas
- Tanya: Apakah perlu membuat repository tersendiri untuk konfigurasi Kilo?
- Kesimpulan: Ya, repository terpisah adalah solusi yang tepat. Lingkungan ini memiliki `git` dan `gh`, remote proyek saat ini adalah `https://github.com/mbadrudin170-jpg/berhenti_merokok.git`, dan `kilo.jsonc` tidak memuat rahasia (tidak ada API key/token/password), sehingga repository publik dapat di-clone tanpa autentikasi tambahan di akun baru. Struktur yang diusulkan: `kilo.jsonc`, `prompts/code.md`, `bootstrap.sh`, dan `README.md`. Alternatif menaruh konfigurasi di `docs/kilo/` pada repo proyek tetap mungkin, namun kurang tepat bila bekerja di beberapa proyek Flutter dan bergantung pada status privat/publik repo proyek.

### 18. Lokasi penyimpanan hasil clone repository konfigurasi
- Tanya: Di mana hasil clone repository konfigurasi disimpan?
- Kesimpulan: Hasil clone bersifat sementara dan boleh diletakkan di mana saja dalam `$HOME` (mis. `~/kilo-dotfiles`); yang awet adalah repository di GitHub, bukan klona lokal. Karena `kilo.jsonc` hanya 4.606 B, clone tidak diperlukan — konfigurasi dapat diunduh langsung dengan `curl` dari `raw.githubusercontent.com` ke `~/.config/kilo/kilo.jsonc` dan `~/.config/kilo/prompts/code.md`. `~/.config/kilo/` tetap harus ada karena Kilo hanya membaca konfigurasi dari home.

### 19. Penyimpanan konfigurasi pada `.kilo/kilo.json`
- Tanya: Apakah konfigurasi dapat disimpan di `.kilo/` proyek?
- Kesimpulan: Ya, `.kilo/kilo.json` (atau `.kilo/kilo.jsonc`) adalah lokasi config tingkat proyek yang sah, dimuat setelah config global dengan prioritas lebih tinggi, dan **ikut ter-clone bersama repo** sehingga tidak perlu restore manual saat berpindah akun cloud shell. Folder `.kilo/` sudah dipakai proyek ini (`.kilo/commands/`). Perlu diperhatikan: (a) `{file:./prompts/code.md}` diresolusi relatif terhadap lokasi config, sehingga berkas prompt harus berada di `.kilo/prompts/code.md`; (b) array `instructions` pada config proyek kemungkinan menggantikan daftar global, sehingga keenam entri ditulis ulang agar tidak ada yang hilang; (c) `KILO_DISABLE_PROJECT_CONFIG` akan mengabaikan seluruh config proyek; (d) config proyek hanya berlaku untuk proyek ini, sedangkan kebutuhan lintas proyek tetap memerlukan repository dotfiles.

## Keputusan
- K-1: `SKILLS_INDEX.md` didaftarkan pada `instructions` di `~/.config/kilo/kilo.jsonc` tanpa menghapus lima entri yang sudah ada, sehingga indeks skill selalu dikirim sebagai isi penuh pada setiap sesi di proyek ini.
- K-2: Pendaftaran memakai pola relatif (`"SKILLS_INDEX.md"`), mengikuti pola entri yang sudah ada (`.agents/rules/global/*.md`), yang terbukti diselesaikan terhadap direktori kerja proyek; proyek lain yang tidak memiliki berkas tersebut tidak terpengaruh.
- K-3: Pendaftaran dilakukan lebih dahulu (R-2), sedangkan pelengkapan 55 trigger kosong (R-1) menyusul; hal ini disepakati karena pengguna memilih penerapan langsung.
- K-4: Biaya tambahan ± 15,3 KB (± 4k token) per sesi diterima sebagai konsekuensi dari K-1.
- K-5: `MEMORI.md` **tidak** didaftarkan ke `instructions`. Alasannya: `instructions` hanya menyuntikkan snapshot saat sesi dimulai, sedangkan `MEMORI.md` berubah setiap interaksi (terbukti 23.029 B → 28.428 B di tengah sesi ini akibat penulisan bersamaan oleh pihak lain). Pembacaan via tool dipertahankan agar isinya selalu segar, sesuai `AGENTS.md` poin 5.
- K-6: Prompt agent dititipkan pada berkas di dalam repository (`prompts/code.md`), bukan pada `~/.config/kilo/prompts/`, karena pengguna berpindah-pindah akun cloud shell sehingga path absolut pada config global tidak portabel.
- K-7: Pembuatan berkas prompt dilakukan lebih dahulu; wiring ke konfigurasi (`kilo.json` proyek) ditunda sampai keberlakuan `agent.code.prompt` diverifikasi melalui `/status` atau Settings → Agent Behaviour (R-14).
- K-8: Pemulihan konfigurasi Kilo setelah berpindah akun cloud shell mengikuti mekanisme yang sudah ada, yaitu menyalin salinan repo `docs/kilo/kilo_global.txt` ke `~/.config/kilo/kilo.jsonc`. Salinan repo diperlakukan sebagai sumber kebenaran yang harus disinkronkan setiap kali config global diubah.
- K-9: `skills.paths` pada config global terbukti berisi path home akun lama (`/home/thefarmercompanyba/...`), sehingga dikonfirmasi harus dihapus (R-6), bukan diperbaiki.
- K-10: Berkas tidak dapat dititipkan pada `/home/<pengguna>/` sebagai solusi portabilitas, karena lokasi tersebut adalah `$HOME` per akun Google yang hilang saat berpindah akun.
- K-11: Bila konfigurasi diperlukan lintas proyek, gunakan repository tersendiri (dotfiles) yang dapat di-clone di setiap akun baru; untuk proyek ini, `docs/kilo/kilo_global.txt` dicadangkan sebagai salinan config global.
- K-12: Untuk kebutuhan proyek ini, konfigurasi dititipkan pada `.kilo/kilo.json` di dalam repo (bukan `~/.config/kilo/`), karena lokasi tersebut ikut ter-clone, tidak perlu restore manual, dan tidak hilang saat berpindah akun Google.

## Rekomendasi
- R-1: Lengkapi 55 trigger kosong pada `SKILLS_INDEX.md` dengan kata kunci pencarian dan path berkas yang biasa disentuh (mis. `lib/fitur/diary_craving/**`).
- R-2: Daftarkan `SKILLS_INDEX.md` pada `instructions` di `kilo.jsonc`, atau sediakan tabel routing ringkas (satu baris per skill) pada `AGENTS.md`. Karena berkas `instructions` selalu dikirim penuh setiap sesi (lihat poin 10), disarankan memakai berkas routing ringkas (± 3–4 KB) alih-alih `SKILLS_INDEX.md` penuh (± 15 KB).
- R-3: Sebutkan nama skill anak secara eksplisit pada deskripsi skill indeks (`bug-runtime`, `pola-ui`, `pola-ux`, `widget-custom`) agar routing cukup satu tahap.
- R-4: Tambahkan daftar "skill wajib per jenis pekerjaan" pada `AGENTS.md` dan pada setiap command/mode (termasuk `mode_diskusi.md`).
- R-5: Pangkas deskripsi `SKILL.md` menjadi kata kunci trigger di posisi awal dengan batas ± 300 karakter.
- R-6: Hapus `skills.paths` yang menunjuk lokasi `/home/thefarmercompanyba/...` pada `kilo.jsonc` global (bukan sekadar memperbaiki path), karena penemuan skill sudah otomatis dari `.agents/skills` di dalam repo dan path absolut tidak portabel antar akun cloud shell.
- R-7: Jangan daftarkan `MEMORI.md` utuh ke `instructions`; pertahankan pembacaan via tool (K-5).
- R-8: Bila di masa depan diperlukan konteks proyek yang selalu hadir, buat berkas ringkas dan stabil (mis. `STATUS_PROYEK.md`, ± 2–3 KB: nama, versi, status implementasi, konvensi inti, path penting) lalu daftarkan berkas tersebut — bukan `MEMORI.md` penuh.
- R-9: Bila kebijakan K-5 diubah dan `MEMORI.md` tetap didaftarkan, wajib menambahkan kewajiban membaca ulang `MEMORI.md` dari disk sebelum mengubah proyek, disertai peringatan bahwa isi yang terinjeksi adalah snapshot.
- R-10: Pindahkan aturan penting dari prosa ke `permission` `deny`/`ask` pada `kilo.jsonc`, mis. larangan edit berkas generated (`*.g.dart`, `*.freezed.dart`, `*.mocks.dart`) dan larangan `git push --force`.
- R-11: Jadikan pemeriksaan deterministik sebagai gerbang wajib: `dart format --output=none --set-exit-if-changed`, `dart analyze`, `flutter test`.
- R-12: Kurangi jumlah butir pada `AGENTS.md` agar aturan penting tidak terdilusi; hapus aturan yang jarang relevan alih-alih menambah terus.
- R-13: Untuk kewajiban yang tidak dapat ditegakkan secara teknis (mis. memuat skill tertentu sebelum bekerja), pindahkan ke checklist eksplisit pada command/mode per jenis pekerjaan dan verifikasi setelah aksi.
- R-14: Verifikasi keberlakuan `agent.code.prompt` dan `agent.code.model` pada sesi aktif sebelum memperbaiki prompt. Langkah: (1) jalankan `/status` untuk melihat agent dan model aktif; (2) buka Settings → Agent Behaviour → Agents → `code` dan periksa nilai field `prompt`; (3) bila kosong/tidak sesuai, periksa apakah sesi berjalan memakai klien atau preset konfigurasi lain. Bila terbukti tidak berlaku, perbaiki sumber konfigurasi yang benar terlebih dahulu.
- R-15: Bila `agent.code.prompt` memang berlaku, ganti `"kamu adalah pekerja saya"` dengan prompt ringkas (± 40–60 kata) yang memuat peran, kewajiban membaca `MEMORI.md`, kewajiban memuat skill relevan, bahasa Indonesia baku, kewajiban verifikasi (`dart analyze`/`dart format`), larangan mengedit berkas generated, dan larangan mengarang. Untuk prompt panjang, gunakan sintaksis `{file:./prompts/code.md}` agar isi JSON tetap ringkas; hindari menduplikasi isi `AGENTS.md`.
- R-16: Titipkan prompt pada berkas di dalam repo dan wire melalui `kilo.json` proyek, bukan `kilo.jsonc` global, agar portabel antar akun cloud shell. Bentuk konfigurasi yang disarankan (belum diterapkan):

```json
{
  "$schema": "https://app.kilo.ai/config.json",
  "agent": {
    "code": {
      "prompt": "{file:./prompts/code.md}"
    }
  }
}
```

- R-17: Setelah wiring, tambahkan `prompts/code.md` ke `instructions` **tidak diperlukan**; prompt agent sudah masuk system prompt melalui mekanisme `agent.*.prompt`.
- R-18: Buat `script/restore_kilo_config.sh` yang menyalin `docs/kilo/kilo_global.txt` ke `~/.config/kilo/kilo.jsonc` (dengan `mkdir -p ~/.config/kilo`), sehingga pemulihan setelah berpindah akun cukup satu perintah.
- R-19: Tambahkan alias sinkronisasi (mis. `kilo_sync`) yang menyalin arah sebaliknya (`~/.config/kilo/kilo.jsonc` → `docs/kilo/kilo_global.txt`) agar salinan repo tidak tertinggal setiap kali config global diubah.
- R-20: Karena `{file:./prompts/code.md}` pada config global akan diresolusi ke `~/.config/kilo/`, sediakan salinan `prompts/code.md` juga di `~/.config/kilo/prompts/` dan sertakan pemulihannya pada R-18; alternatifnya wire melalui `kilo.json` proyek agar tidak perlu dipulihkan.
- R-21: Bila ingin otomatisasi penuh tanpa restore manual, buat skrip bootstrap di repo (mis. `script/bootstrap_cloud_shell.sh`) yang dipanggil sekali setelah `git clone` di akun baru: menyalin config kanonis ke `~/.config/kilo/`, menyiapkan direktori, dan memasang dependensi.
- R-22: Struktur repository konfigurasi terpisah: `kilo.jsonc` (kanonis), `prompts/code.md`, `bootstrap.sh` (menyalin `kilo.jsonc` → `~/.config/kilo/kilo.jsonc` dan `prompts/code.md` → `~/.config/kilo/prompts/code.md`), serta `README.md` berisi tiga langkah pemakaian di akun baru.
- R-23: Alur pemakaian di akun baru: `git clone <repo-config>`, jalankan `bash bootstrap.sh`, lalu buka proyek. Bila repo proyek privat, siapkan autentikasi git terlebih dahulu.
- R-24: Untuk `kilo.jsonc` berukuran kecil (± 4,6 KB), lebih ringkas memakai unduhan langsung `curl -fsSL <raw-url>` ke `~/.config/kilo/kilo.jsonc` dan `~/.config/kilo/prompts/code.md` daripada clone; clone hanya dianjurkan bila riwayat versi config ingin dilacak.
- R-25: Buat `.kilo/kilo.json` berisi enam entri `instructions` (diulang penuh, bukan hanya tambahan) dan `agent.code.prompt` = `{file:./prompts/code.md}`; pindahkan berkas prompt ke `.kilo/prompts/code.md` agar resolusi path benar.
- R-26: Simpan `.kilo/kilo.json` di repo (jangan masukkan ke `.gitignore`), pertahankan `docs/kilo/kilo_global.txt` sebagai cadangan global, dan dokumentasikan bahwa `KILO_DISABLE_PROJECT_CONFIG` harus tetap tidak diset.

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
| 10 | Memastikan `MEMORI.md` tetap dibaca via tool pada setiap interaksi (K-5), tidak didaftarkan ke `instructions` | `AGENTS.md` | selesai |
| 11 | Evaluasi pembuatan `STATUS_PROYEK.md` ringkas bila konteks selalu-hadir diperlukan (R-8) | belum ditentukan | belum |
| 12 | Verifikasi keberlakuan `agent.code.prompt` melalui `/status` atau Settings → Agent Behaviour (R-14) | `~/.config/kilo/kilo.jsonc` | belum |
| 13 | Wire prompt ke `kilo.json` proyek dengan `{file:./prompts/code.md}` setelah verifikasi (R-16) | `kilo.json` (baru), `prompts/code.md` | belum |
| 14 | Hapus `skills.paths` pada `kilo.jsonc` global (R-6) | `~/.config/kilo/kilo.jsonc` | belum |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_1.md` | Dibuat | Berkas hasil diskusi ini (Draft). |
| `prompts/code.md` | Dibuat | Prompt agent `code` versi berkas (K-6); belum diwire ke konfigurasi (K-7). |
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
- Apakah R-8 (`STATUS_PROYEK.md` ringkas) akan dibuat, atau pembacaan `MEMORI.md` via tool dinilai sudah cukup?

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-12 | Dibuat `hasil_diskusi/diskusi_1.md` (Draft) berisi analisis sembilan penyebab skill spesifik tidak termuat serta rekomendasi R-1 sampai R-6. |
| 2026-11-12 | Ditambahkan poin diskusi 10 mengenai status pengiriman berkas `instructions` (selalu dikirim penuh setiap sesi), R-2 disesuaikan agar memakai berkas routing ringkas, dan dua pertanyaan terbuka diperbarui. |
| 2026-11-12 | Penerapan K-1: `"SKILLS_INDEX.md"` ditambahkan ke `instructions` pada `~/.config/kilo/kilo.jsonc` (validasi konfigurasi berhasil). Status berubah menjadi `Sedang Diimplementasikan`; ditambahkan K-1..K-4, tindak lanjut 4 ditandai selesai, dan tindak lanjut 9 (verifikasi pada sesi baru) ditambahkan. |
| 2026-11-12 | Ditambahkan poin diskusi 11 dan K-5: `MEMORI.md` tidak didaftarkan ke `instructions` (snapshot usang vs dokumen hidup), ditambah R-7..R-9 dan tindak lanjut 10–11. |
| 2026-11-12 | Ditambahkan poin diskusi 12 tentang faktor kepatuhan model (lapisan lunak vs penegakan keras, bukti `sed *` ditolak harness) serta R-10..R-13. |
| 2026-11-12 | Ditambahkan poin diskusi 13 tentang perbaikan `agent.code.prompt`, temuan bahwa prompt/persona dan model sesi berjalan tampak tidak sesuai `kilo.jsonc`, serta R-14..R-15. |
| 2026-11-12 | Poin 13 dan R-14 diperjelas berdasarkan dokumentasi resmi Kilo: `prompt` adalah opsi sah pada `agent` (mendukung `{file:./path}`), dan `permission` dari `kilo.jsonc` yang sama terbukti aktif (`sed *` ditolak), sehingga ketidaktampakan override persona menjadi temuan yang perlu diverifikasi melalui `/status` atau Settings → Agent Behaviour. |
| 2026-11-12 | Ditambahkan poin 14, K-6, K-7, R-6 direvisi (hapus `skills.paths`), serta R-16..R-17. Dibuat berkas `prompts/code.md` (belum diwire ke konfigurasi). |
| 2026-11-12 | Ditambahkan poin 15 dan K-8, K-9: akun Google berbeda membuat `~/.config/kilo/kilo.jsonc` tidak persisten; `docs/kilo/kilo_global.txt` terbukti identik dengan config aktif; `skills.paths` terbukti berisi home akun lama. Ditambahkan R-18..R-20 (skrip pemulihan, alias sinkronisasi, penempatan berkas prompt). |
| 2026-11-12 | Ditambahkan poin 16, K-10, dan R-21: `/home/muhamadbadrudin1000/` adalah `$HOME` per akun (hanya satu direktori pengguna pada `/home`), sehingga bukan lokasi portabel; tidak ada `/workspaces` atau `/workspace`. |
| 2026-11-12 | Ditambahkan poin 17, K-11, R-22, R-23: repository konfigurasi terpisah (dotfiles) sebagai solusi portabilitas; terverifikasi `git` dan `gh` tersedia, remote proyek `mbadrudin170-jpg/berhenti_merokok`, dan `kilo.jsonc` tidak memuat rahasia. |
| 2026-11-12 | Ditambahkan poin 18 dan R-24: hasil clone bersifat sementara; alternatif unduh langsung via `curl` dari `raw.githubusercontent.com` tanpa clone. |
| 2026-11-12 | Ditambahkan poin 19, K-12, R-25, R-26: `.kilo/kilo.json` sebagai lokasi config tingkat proyek yang ikut ter-clone dan tidak perlu restore manual; catatan resolusi `{file:...}`, penggantian array `instructions`, `KILO_DISABLE_PROJECT_CONFIG`, dan cakupan hanya satu proyek. |