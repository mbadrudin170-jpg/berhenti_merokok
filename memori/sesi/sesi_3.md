# Sesi 3 — Tanya Jawab: Cek RAM dan CPU Cloud Shell

## Status
- Status Sinkron: Sudah Sinkron
- Tanggal: 2026-11-13
- Topik Sesi: Tanya jawab umum — cara memeriksa RAM dan CPU di Google Cloud Shell

## Catatan Sesi
- Sesi dimulai dengan pertanyaan pengguna: "cara cek ram dan cpu cloud shell".
- `MEMORI.md` sudah dibaca sebelum interaksi; `.kilo/kilo.jsonc` sudah dicek (izin `deny` pada `bash`: `cat *`, `sed *`, `python3 *`; pada `read`: `*.env`, `*.env.*`) — dipatuhi.
- Pertanyaan bersifat umum (tidak mengubah proyek). Tidak ada berkas proyek yang diubah.
- Pertanyaan lanjutan: "sisa CPU berapa" — dijawab dari data `top` yang ditempel pengguna (CPU 92.1% idle, load average 0.40); lalu snapshot baru `top -bn1` dijalankan (CPU 90.5% idle, load 0.14).
- Permintaan lanjutan: tambahkan perintah cek CPU ke `script/bash_aliases.sh`. Pengguna memilih bentuk "satu alias gabungan"; alias `cekcpu` ditambahkan pada section MONITORING (menjalankan `nproc`, `lscpu`, `top -bn1 | head -5`, `uptime`, dan `cat /proc/cpuinfo`). Catatan: `cat` di dalam alias berjalan di shell pengguna, bukan lewat tool `bash` Kilo, sehingga tidak melanggar `deny` `cat *` pada `.kilo/kilo.jsonc`.
- Pengguna menjalankan perintah di terminal Cloud Shell dan menempel hasilnya: `nproc` = 2; `lscpu` = Intel Xeon @ 2.20GHz, 1 core/socket, 2 thread per core (hyperthreading), virtualisasi KVM; `top` = load average 0.40/0.37/0.29, CPU 92.1% idle; memori 7943.5 MiB total, ~4205.1 MiB free, ~2383.4 MiB used, ~1628.7 MiB buff/cache, swap 0, avail ~5560.0 MiB; proses `kilo` memakai ~788 MiB RES (9.7% MEM).

## Berkas Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `memori/sesi/sesi_3.md` | Dibuat | Berkas sesi ketiga |
| `script/bash_aliases.sh` | Diubah | Alias `cekcpu` (gabungan nproc, lscpu, top -bn1, uptime, cat /proc/cpuinfo) ditambahkan pada section MONITORING |

## Sinkronisasi ke MEMORI.md
`MEMORI.md` tidak diubah — perubahan sesi ini (alias `cekcpu` di `script/bash_aliases.sh`) tidak menyentuh state/konfigurasi/keputusan proyek yang dicatat di `MEMORI.md`; alias shell bukan bagian dari daftar berkas penting di `MEMORI.md`. Entri perubahan ditambahkan ke `memori/riwayat_perubahan.md` (2026-11-13). Berkas sesi ditandai `Sudah Sinkron` pada akhir sesi.

- Status Sinkron: Sudah Sinkron
