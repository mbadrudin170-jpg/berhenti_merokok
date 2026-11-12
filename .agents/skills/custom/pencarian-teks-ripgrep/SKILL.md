---
name: pencarian-teks-ripgrep
description: Panduan penggunaan ripgrep (`rg`) sebagai alat pencarian teks di dalam file pada proyek Flutter "berhenti_merokok" - kapan digunakan (mencari teks, pemanggilan fungsi, atau pola di dalam file sumber), apa yang di-cover (preferensi `rg` atas `grep -rn`, verifikasi ketersediaan `rg` dengan `which rg` sebelum memilih alternatif, serta pembagian tugas dengan `glob` dan `ls`), apa yang harus dihindari (beralih ke `grep` saat `rg` tersedia/berfungsi, memilih alternatif tanpa cek `which rg`, memakai `rg` untuk mencari file berdasarkan nama atau melihat isi folder), langkah kerja (cek ketersediaan dengan `which rg` jika `rg` dilaporkan belum terpasang/gagal, lalu jalankan `rg` pada ruang lingkup yang relevan), dan referensi ke `.agents/rules/global/aturan_skill.md` serta skill format `.agents/skills/custom/bug-runtime/SKILL.md`. Jangan digunakan untuk mencari file berdasarkan nama (gunakan `glob`) atau melihat isi satu folder (gunakan `ls`).
metadata:
  kategori: "custom"
  versi: "1.0.0"
  diperbarui: "Thu Nov 12 07:01:35 WIB 2026"
  sumber-terakhir: "perintah pengguna: implementasi PRD diskusi_7.md"
  model: "openrouter/thinkingmachines/inkling-2-small:free"
---

# Pencarian Teks dengan Ripgrep (rg)

Panduan penggunaan `rg` (ripgrep) sebagai alat utama untuk mencari teks di dalam file di proyek ini. Isi skill disusun dari perintah eksplisit pengguna (implementasi `prd/hasil_diskusi/diskusi_7.md`), bukan dari riwayat commit.

## Cakupan yang Di-Cover

- Tool: `rg` (ripgrep), `grep -rn` (alternatif terakhir), `which rg`, `glob`, `ls`
- Cakupan: preferensi `rg` atas `grep -rn`, verifikasi ketersediaan `rg`, pembagian tugas dengan `glob` dan `ls`

## Aturan

1. Gunakan `rg` untuk mencari teks di dalam file.
2. `grep -rn` hanya boleh digunakan sebagai alternatif ketika `rg` benar-benar gagal atau tidak tersedia.
3. Jika `rg` dilaporkan belum terpasang atau gagal, periksa lokasinya dengan `which rg` melalui perintah shell sebelum memilih alternatif lain.
4. Gunakan `glob` untuk mencari file berdasarkan nama atau pola path.
5. Gunakan `ls` untuk melihat isi satu folder.
6. Gunakan `rg` untuk mencari teks di dalam file; jangan gunakan `glob` atau `ls` untuk tugas tersebut.

## Larangan

- DILARANG menggunakan `grep -rn` ketika `rg` tersedia dan berfungsi.
- DILARANG memilih alternatif ketika `rg` dilaporkan belum terpasang atau gagal tanpa memeriksa lokasinya dengan `which rg` terlebih dahulu.
- DILARANG menggunakan `rg` untuk mencari file berdasarkan nama; gunakan `glob`.
- DILARANG menggunakan `rg` untuk melihat isi satu folder; gunakan `ls`.
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

## Contoh Salah

```bash
# Langsung beralih ke grep padahal rg tersedia dan berfungsi
grep -rn "namaFungsi" lib/ # DILARANG
```

```bash
# Memilih alternatif tanpa memeriksa lokasi rg terlebih dahulu
grep -rn "namaFungsi" lib/ # DILARANG: wajib `which rg` dulu
```

## Sumber Evaluasi

- File aturan sumber: `.agents/rules/global/aturan_skill.md`
- Perintah eksplisit pengguna: implementasi `prd/hasil_diskusi/diskusi_7.md` (jawaban konfirmasi nama folder `pencarian-teks-ripgrep`, cakupan, dan sumber isi dari perintah eksplisit pengguna)
- Skill referensi format non-UI: `.agents/skills/custom/bug-runtime/SKILL.md`
- Catatan: isi skill disusun dari perintah eksplisit pengguna atas pilihan pengguna, bukan dari riwayat commit; tidak ada commit yang memuat panduan penggunaan `rg` yang lengkap untuk dijadikan sumber isi.
