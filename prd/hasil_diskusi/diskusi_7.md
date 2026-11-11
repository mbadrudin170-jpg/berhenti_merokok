# Diskusi 7

## Status
Draft

## Topik
Pembuatan skill baru untuk penggunaan `ripgrep` (`rg`) di proyek.

## Ringkasan
- Pengguna ingin membuat skill baru yang membahas penggunaan `ripgrep` sebagai alat pencarian teks/kode.
- Berdasarkan `.agents/rules/global/aturan_skill.md` dan skill `aturan-pembuatan-skill`, skill baru wajib: lokasi `.agents/skills/custom/<nama-skill>/SKILL.md`, nama folder kebab-case bahasa Indonesia deskriptif, front matter YAML lengkap, section wajib (Judul/Intro, Cakupan, Aturan, Larangan, Contoh Benar, Contoh Salah, Sumber Evaluasi), format mengikuti referensi (topik non-UI dapat mengacu `bug-runtime/SKILL.md`).
- **Kendala utama (aturan sumber isi):** isi `SKILL.md` wajib disusun dari riwayat commit yang berkaitan (hanya `git log`, `git show`, `git diff` pada commit). Dilarang mengambil dari working directory/staging/untracked dan dilarang mengarang pola/contoh bila tidak ada commit berkaitan.
- Hasil pemeriksaan riwayat git saat ini: tidak ditemukan commit yang berkaitan dengan `ripgrep`/`rg` (pencarian `git log --grep` dan `-S` tidak menghasilkan commit relevan). Ini berarti pembuatan isi skill tidak bisa langsung dilakukan tanpa arahan pengguna.
- Lingkungan saat ini tidak memiliki binary `rg` terpasang (`rg: command not found`), meski `grep` tool berbasis ripgrep tersedia di agent; ini perlu dipertimbangkan dalam cakupan (CLI `rg` vs alat pencarian yang tersedia).

## Keputusan
- Topik diskusi ditetapkan: pembuatan skill penggunaan `ripgrep`.
- Belum ada keputusan final mengenai: nama folder skill, cakupan detail (CLI `rg` saja atau termasuk praktik pencarian kode umum), dan sumber isi yang akan digunakan.
- Implementasi/pembuatan file `SKILL.md` **ditunda** sampai ada kejelasan sumber isi sesuai aturan (commit berkaitan tersedia atau pengguna memberi arahan eksplisit cara melanjutkan).

## Tindak Lanjut
- Pengguna menentukan **nama folder skill** (kebab-case, bahasa Indonesia, deskriptif). Rekomendasi kandidat: `pencarian-teks-ripgrep`, `penggunaan-ripgrep`, atau `pencarian-kode-dengan-ripgrep`.
- Pengguna menentukan **cakupan** skill, misalnya: pola perintah `rg` dasar, filter file/glob/type, pencarian literal/regex, pencarian multiline/context, praktik aman di repo besar, atau integrasi dengan workflow proyek.
- Pengguna memilih **cara memenuhi aturan sumber isi** (karena belum ada commit berkaitan):
  1. Membuat/menggunakan commit yang relevan terlebih dahulu (mis. menambahkan contoh penggunaan `rg` di skrip/dokumen lalu commit), kemudian menyusun skill dari commit tersebut; atau
  2. Memberi arahan eksplisit untuk menunda pembuatan skill sampai ada commit relevan; atau
  3. Memberi instruksi khusus lain (perlu dicatat: aturan saat ini melarang mengarang isi tanpa commit berkaitan).
- Setelah keputusan di atas jelas, perbarui diskusi ini (ubah Status ke `Final` bila sepakat) lalu lanjutkan pembuatan `.agents/skills/custom/<nama-skill>/SKILL.md` sesuai format dan checklist aturan skill.
