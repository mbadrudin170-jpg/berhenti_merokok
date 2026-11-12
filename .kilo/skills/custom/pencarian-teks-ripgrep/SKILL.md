---
name: pencarian-teks-ripgrep
description: Panduan penggunaan ripgrep (`rg`) sebagai alat pencarian teks di dalam file pada proyek Flutter "berhenti_merokok" - kapan digunakan (mencari teks, pemanggilan fungsi, atau pola di dalam file sumber; juga saat tool `rg` gagal dengan `NotFound: ChildProcess.spawn (/home/thefarmercompanyba/.cache/kilo/bin/rg ...)`), apa yang di-cover (preferensi `rg` atas `grep -rn`, verifikasi ketersediaan `rg` dengan `which rg` sebelum memilih alternatif, pembagian tugas dengan `glob` dan `ls`, serta diagnosa dan pemulihan binary `rg` milik Kilo di `~/.cache/kilo/bin/rg`), apa yang harus dihindari (beralih ke `grep` saat `rg` tersedia/berfungsi atau sebelum binary Kilo dipulihkan, memilih alternatif tanpa cek `which rg`, memakai `rg` untuk mencari file berdasarkan nama atau melihat isi folder, menjalankan alias yang menghapus `~/.cache`), langkah kerja (cek `which rg` dan isi `~/.cache/kilo/bin/`, pasang dengan `install_rg`, salin binary sistem ke `~/.cache/kilo/bin/rg`, verifikasi dengan `rg --version`), dan referensi ke `.agents/rules/global/aturan_skill.md` serta skill format `.agents/skills/custom/bug-runtime/SKILL.md`. Jangan digunakan untuk mencari file berdasarkan nama (gunakan `glob`) atau melihat isi satu folder (gunakan `ls`).
metadata:
  kategori: "custom"
  versi: "1.1.0"
  diperbarui: "Thu Nov 12 07:05:03 WIB 2026"
  sumber-terakhir: "perintah pengguna: perbarui skill rg setelah pemulihan binary Kilo (install_rg + salin /usr/bin/rg ke ~/.cache/kilo/bin/rg)"
  model: "openrouter/thinkingmachines/inkling-2-small:free"
---

# Pencarian Teks dengan Ripgrep (rg)

Panduan penggunaan `rg` (ripgrep) sebagai alat utama untuk mencari teks di dalam file di proyek ini. Isi skill disusun dari perintah eksplisit pengguna (implementasi `prd/hasil_diskusi/diskusi_7.md` dan perintah pembaruan setelah sesi diagnosa/pemulihan binary `rg` Kilo pada 2026-11-12), bukan dari riwayat commit.

## Cakupan yang Di-Cover

- Tool: `rg` (ripgrep), `grep -rn` (alternatif terakhir), `which rg`, `glob`, `ls`
- Cakupan: preferensi `rg` atas `grep -rn`, verifikasi ketersediaan `rg`, pembagian tugas dengan `glob` dan `ls`, diagnosa dan pemulihan binary `rg` milik Kilo (`~/.cache/kilo/bin/rg`)

## Aturan

1. Gunakan `rg` untuk mencari teks di dalam file.
2. `grep -rn` hanya boleh digunakan sebagai alternatif ketika `rg` benar-benar gagal atau tidak tersedia.
3. Jika `rg` dilaporkan belum terpasang atau gagal, periksa lokasinya dengan `which rg` melalui perintah shell sebelum memilih alternatif lain.
4. Gunakan `glob` untuk mencari file berdasarkan nama atau pola path.
5. Gunakan `ls` untuk melihat isi satu folder.
6. Gunakan `rg` untuk mencari teks di dalam file; jangan gunakan `glob` atau `ls` untuk tugas tersebut.
7. Jika tool gagal dengan `NotFound: ChildProcess.spawn (/home/thefarmercompanyba/.cache/kilo/bin/rg ...)`, jangan langsung beralih ke `grep`; selesaikan diagnosa dan pemulihan binary Kilo sesuai Steps sebelum memilih alternatif.

## Steps

Diagnosa dan pemulihan binary `rg` milik Kilo (urutan wajib):

1. Periksa ketersediaan `rg` sistem dengan `which rg`; jika exit 1, `rg` sistem belum terpasang.
2. Periksa apakah direktori atau binary Kilo ada: `ls /home/thefarmercompanyba/.cache/kilo/bin/`.
3. Pasang ripgrep sistem dengan alias `install_rg` (setara `sudo apt-get install -y ripgrep`).
4. Buat direktori bin Kilo bila hilang: `mkdir -p /home/thefarmercompanyba/.cache/kilo/bin`.
5. Salin binary sistem ke path bin Kilo: `cp "$(which rg)" /home/thefarmercompanyba/.cache/kilo/bin/rg && chmod 755 /home/thefarmercompanyba/.cache/kilo/bin/rg`.
6. Verifikasi dengan `rg --version` dan `/home/thefarmercompanyba/.cache/kilo/bin/rg --version`, lalu jalankan ulang perintah yang gagal; pastikan output normal.
7. Di lingkungan Cloud Shell yang ephemeral, instalasi apt dan isi `~/.cache` dapat hilang setelah sesi berakhir; bila error `rg` muncul lagi di sesi baru, ulangi Steps 3-6.

## Larangan

- DILARANG menggunakan `grep -rn` ketika `rg` tersedia dan berfungsi.
- DILARANG memilih alternatif ketika `rg` dilaporkan belum terpasang atau gagal tanpa memeriksa lokasinya dengan `which rg` terlebih dahulu.
- DILARANG menggunakan `rg` untuk mencari file berdasarkan nama; gunakan `glob`.
- DILARANG menggunakan `rg` untuk melihat isi satu folder; gunakan `ls`.
- DILARANG menggunakan `grep` hanya karena `ChildProcess.spawn (/home/thefarmercompanyba/.cache/kilo/bin/rg ...)` gagal, tanpa memulihkan binary Kilo atau mengonfirmasi ke pengguna terlebih dahulu.
- DILARANG menjalankan alias `bersih` (`rm -rf ~/.cache ...`) karena menghapus `/home/thefarmercompanyba/.cache/kilo/bin/rg` dan mengembalikan error spawn.
- DILARANG menganggap instalasi `rg` permanen di Cloud Shell; verifikasi `which rg` ulang di setiap sesi baru.
- DILARANG menggunakan `glob` atau `ls` untuk mencari teks di dalam file; gunakan `rg`.

## Contoh Benar

```bash
# Mencari teks di dalam file (alat utama)
rg "namaFungsi" lib/
```

```bash
# Memeriksa ketersediaan rg sebelum memilih alternatif
which rg
```

```bash
# Pembagian tugas yang benar:
# - glob: mencari file berdasarkan nama atau pola path
# - ls: melihat isi satu folder
# - rg: mencari teks di dalam file
```

```bash
# Diagnosa kegagalan spawn rg milik Kilo
which rg
ls /home/thefarmercompanyba/.cache/kilo/bin/
```

```bash
# Pemulihan binary rg milik Kilo setelah rg sistem terpasang
mkdir -p /home/thefarmercompanyba/.cache/kilo/bin
cp "$(which rg)" /home/thefarmercompanyba/.cache/kilo/bin/rg
chmod 755 /home/thefarmercompanyba/.cache/kilo/bin/rg
```

```bash
# Verifikasi setelah pemulihan
/home/thefarmercompanyba/.cache/kilo/bin/rg --version
```

## Contoh Salah

```bash
# Langsung beralih ke grep padahal rg tersedia dan berfungsi
grep -rn "namaFungsi" lib/ # DILARANG
```

```bash
# Memilih alternatif tanpa memeriksa lokasi rg terlebih dahulu
grep -rn "namaFungsi" lib/ # DILARANG: wajib `which rg` dulu
```

```bash
# Langsung beralih ke grep padahal spawn bin Kilo gagal tapi belum dipulihkan
grep -rn "namaFungsi" lib/ # DILARANG: pulihkan ~/.cache/kilo/bin/rg dulu atau konfirmasi ke pengguna
```

```bash
# Menjalankan alias yang menghapus ~/.cache dan mengembalikan error spawn
bersih # DILARANG
```

## Sumber Evaluasi

- File aturan sumber: `.agents/rules/global/aturan_skill.md`
- Perintah eksplisit pengguna: implementasi `prd/hasil_diskusi/diskusi_7.md` (jawaban konfirmasi nama folder `pencarian-teks-ripgrep`, cakupan, dan sumber isi dari perintah eksplisit pengguna)
- Perintah eksplisit pengguna: "perbarui skill rg nya" — diagnosa dan pemulihan binary `rg` Kilo pada 2026-11-12 (`install_rg` = `sudo apt-get install -y ripgrep` v14.1.0 di `/usr/bin/rg`, lalu `mkdir -p ~/.cache/kilo/bin` dan salin `/usr/bin/rg` ke `~/.cache/kilo/bin/rg`; verifikasi `rg --version` dan uji invocation gagal `rg --no-config --json --hidden --no-messages --ignore-case --glob='!**/.git/**' -- memori SKILLS_INDEX.md` → exit 0)
- Skill referensi format non-UI: `.agents/skills/custom/bug-runtime/SKILL.md`
- Catatan: isi skill disusun dari perintah eksplisit pengguna atas pilihan pengguna, bukan dari riwayat commit; tidak ada commit yang memuat panduan penggunaan `rg` yang lengkap untuk dijadikan sumber isi. Pembaruan v1.1.0 disusun dari perintah eksplisit pengguna dan hasil eksplisit sesi diagnosa/pemulihan, bukan dari riwayat commit.
