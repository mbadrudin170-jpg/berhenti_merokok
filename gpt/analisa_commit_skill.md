# TUGAS: Evaluasi Riwayat Commit → Perbarui Skill Custom

## Tujuan
Analisa riwayat commit terbaru di repo ini untuk menemukan code mana yang saya inginkan (pola, struktur, cara pakai paket/SDK). Lalu perbarui atau tambahkan skill custom di `.agents/skills/custom/` agar skill itu bisa saya pakai juga di proyek Flutter saya yang lain.

## Prinsip dasar
- Code yang sudah saya commit dianggap SUDAH BENAR: sesuai paket dan SDK Flutter, dan sudah saya analisa sendiri. Jangan menilai ulang, jangan mengoreksi, jangan menambahkan "perbaikan" dari pengetahuanmu sendiri. Tugasmu hanya mengambil pola dari code itu.
- Baca code dari RIWAYAT COMMIT (`git show`, `git diff`, `git log`), BUKAN dari working directory, staging, atau file untracked.
- Jika dua commit atau lebih mengubah code yang sama, commit TERBARU adalah sumber kebenaran.
- Gunakan git lokal jika tersedia. Jika tidak, gunakan akses GitHub (connector/API) dengan aturan yang sama.
- Jangan checkout ke commit lama, reset, rebase, atau force push.

## LANGKAH 0 — Siapkan branch (WAJIB)
1. Seluruh pekerjaan ini HARUS dilakukan di branch `chatgpt` (sudah saya buat). Pindah ke branch tersebut. Jika branch `chatgpt` tidak ada, hentikan dan beri tahu saya. Jangan membuat branch baru.
2. Jalankan `git fetch origin`. Pastikan branch `chatgpt` memuat commit terbaru dari branch utama (`main`; atau `master` jika itu nama branch utama repo ini) dengan `git merge origin/main`. Merge biasa saja. Jika sudah up to date, lanjut. Jika ada konflik, hentikan dan laporkan ke saya, jangan menyelesaikan konflik sendiri.
3. Mulai dari sini, "HEAD" berarti HEAD branch `chatgpt` setelah langkah ini.

## LANGKAH 1 — Tentukan rentang commit (wajib selesai sebelum menganalisa apa pun)
1. Jalankan `git rev-parse HEAD` dan catat hash lengkapnya. Ini adalah **COMMIT AKHIR**.
   - Kunci hash ini sepanjang tugas. Selalu pakai hash yang dicatat, jangan menjalankan ulang `HEAD`.
   - Jika ada commit baru masuk saat kamu sedang mengevaluasi, ABAIKAN. Itu untuk tugas berikutnya.
2. Buka `catatan.md` di root repo. Isinya banyak catatan, jadi cari HANYA bagian paling bawah yang berjudul `# Evaluasi Skill dari commit`. Abaikan semua isi lainnya.
3. Tentukan **COMMIT AWAL**:
   - Jika bagian itu ada dan berisi hash: commit awal = commit pertama SETELAH hash tersebut (hash itu sendiri tidak dievaluasi ulang). Rentangnya: `git log --reverse --no-merges <hash_di_catatan>..<COMMIT_AKHIR>`
   - Jika `catatan.md` kosong, tidak punya bagian itu, atau tidak ada hash di dalamnya: ambil 5 commit terbaru saja sebagai data awal (`git log -n 5 --no-merges <COMMIT_AKHIR>`). Commit awal = yang tertua dari 5 commit itu. Jika repo punya kurang dari 5 commit, pakai semuanya.
4. Kasus khusus:
   - Hash di catatan sama dengan COMMIT AKHIR (tidak ada commit baru): hentikan tugas, jangan ubah file apa pun, laporkan "tidak ada commit baru".
   - Hash di catatan tidak ditemukan di riwayat (misalnya karena rebase): hentikan dan tanya saya, jangan menebak.
5. Sebelum lanjut, tulis dulu ke saya: COMMIT AWAL, COMMIT AKHIR, jumlah commit, dan daftar singkat (hash pendek + judul commit).

## LANGKAH 2 — Pilih apa yang dievaluasi
- YANG DIEVALUASI: file source code (`.dart`, `pubspec.yaml`, dan file kode/konfigurasi proyek lainnya).
- YANG TIDAK DIJADIKAN BAHAN EVALUASI:
  - semua file `.md` (dokumentasi, PRD, task, catatan.md, aturan, dan file skill itu sendiri)
  - isi folder `.agents/`
  - file hasil generate otomatis (`*.g.dart`, `*.freezed.dart`) dan lock file
- Commit yang hanya mengubah file-file yang diabaikan itu dilewati.
- Evaluasi urut dari commit tertua ke terbaru. Jika ada konflik, yang terbaru menang. Untuk melihat kondisi akhir sebuah file, lihat versinya di COMMIT AKHIR (`git show <COMMIT_AKHIR>:<path>`).

## LANGKAH 3 — Tentukan code yang saya inginkan
- Dari commit tadi, identifikasi pola yang konsisten dan layak jadi acuan di proyek lain: struktur folder/file, penamaan, cara pakai paket dan SDK, pola state management, pola UI, penanganan error, dan sejenisnya.
- Tulis sebagai aturan umum yang bisa dipakai ulang. Ganti nama yang spesifik proyek (nama fitur, tabel, class) menjadi netral.
- Detail yang hanya spesifik untuk satu fitur tidak perlu dijadikan skill.

## LANGKAH 4 — Perbarui skill
1. WAJIB baca penuh `.agents/rules/global/aturan_skill.md` SEBELUM menulis atau mengubah skill apa pun. Ikuti semua yang diatur di sana (penamaan, struktur folder, frontmatter/metadata, examples, gaya penulisan, bahasa, dll). Jika file itu tidak ada atau tidak terbaca, hentikan tugas dan beri tahu saya.
2. Baca semua skill yang sudah ada di `.agents/skills/custom/`.
3. Jika topiknya cocok dengan skill yang sudah ada, perbarui skill itu (jangan buat duplikat). Jika belum ada yang cocok, tambahkan skill baru.
4. Jangan menghapus skill. Jika isi lama bertentangan dengan code di commit terbaru, revisi isinya mengikuti code di commit.
5. Jika `aturan_skill.md` mengharuskan mencatat commit atau versi di metadata skill, isi sesuai aturan itu. Commit yang dicatat adalah COMMIT AKHIR.
6. Isi skill dan examples hanya boleh bersumber dari code di commit yang dievaluasi.

## LANGKAH 5 — Perbarui catatan.md (kerjakan paling terakhir)
- Perbarui bagian `# Evaluasi Skill dari commit` di `catatan.md` (root) agar HANYA mencatat satu commit: COMMIT AKHIR (hash lengkap). Jangan mencatat commit lain yang ikut dievaluasi.
- Jika bagian itu sudah ada: ganti hash lama dengan hash baru, tetap satu bagian saja, jangan ditumpuk. Ikuti format yang sudah ada di bagian itu.
- Jika bagian itu belum ada: tambahkan di akhir file dengan format:

```
# Evaluasi Skill dari commit
<hash lengkap COMMIT AKHIR>
```

- Jangan mengubah, menghapus, atau merapikan catatan lain di file itu.
- Hash COMMIT AKHIR tetap dicatat walaupun ternyata tidak ada skill yang perlu diubah, supaya tugas berikutnya tidak kehilangan arah.

## LANGKAH 6 — Simpan hasil di branch chatgpt
- Commit perubahan (hanya folder skill custom dan `catatan.md`) ke branch `chatgpt`, lalu push ke `origin/chatgpt`.

## BATASAN KERAS
- Hanya boleh mengubah: folder `.agents/skills/custom/` dan `catatan.md` di root. File lain tidak boleh disentuh (merge dari branch utama di Langkah 0 tidak dihitung).
- Semua pekerjaan, commit, dan push HANYA di branch `chatgpt`.
- DILARANG membuat pull request ke `main`, push ke `main`, atau merge apa pun ke `main`.
- DILARANG force push.

## LAPORAN AKHIR (singkat)
1. COMMIT AWAL dan COMMIT AKHIR.
2. Skill yang diperbarui atau ditambah (nama folder + ringkasan perubahan satu baris).
3. Konfirmasi bahwa `catatan.md` sudah berisi hash COMMIT AKHIR.
4. Hash commit hasil kerjamu di branch `chatgpt`, dan konfirmasi bahwa tidak ada pull request yang dibuat.


