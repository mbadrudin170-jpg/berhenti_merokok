# Hasil Diskusi 5 — Aturan penghapusan kelompok tanpa task pada task.md

## Status
- Dokumen: Final
- Implementasi: Sudah Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Penambahan aturan agar kelompok tanpa task di `task.md` wajib dihapus, ditempatkan pada `.kilo/commands/kerjakan_task.md`

## Latar Belakang
Pengguna meminta agar isi berkas `task.md`: bila sebuah kelompok tidak memiliki task, kelompok tersebut dihapus. Permintaan awal ditangkap sebagai penambahan aturan pada `.agents/rules/global/format_task.md`, namun pengguna kemudian mengarahkan targetnya secara spesifik ke `.kilo/commands/kerjakan_task.md` dengan pesan "tambahkan disini aturannya" beserta isi berkas perintah tersebut (berkas aktif saat pesan dikirim).

Kondisi `task.md` saat ini: memuat Kelompok 1–32; tidak satu pun memuat `#### Task N` di bawah `## Tinggi`/`## Sedang`/`## Rendah` — isinya hanya heading kosong atau `Tidak ada temuan.`.

## Poin Diskusi
### 1. Target berkas aturan
- Tanya: Di mana aturan "kelompok tanpa task dihapus" ditambahkan?
- Kesimpulan: `.kilo/commands/kerjakan_task.md` (instruksi untuk agen yang menjalankan perintah implementasi task), bukan `.agents/rules/global/format_task.md`. Mirror `gpt/kerjakan_task.md` ikut disamakan.

### 2. Definisi "tidak ada task"
- Tanya: Apa yang dianggap kelompok tanpa task?
- Kesimpulan: Kelompok yang tidak memuat satu pun `#### Task N` di bawah `## Tinggi`, `## Sedang`, atau `## Rendah` — termasuk kelompok yang hanya berisi `Tidak ada temuan.` atau heading kosong.

### 3. Waktu penerapan
- Tanya: Kapan penghapusan kelompok tanpa task dilakukan?
- Kesimpulan: Setiap kali `task.md` diedit (termasuk saat menandai task `selesai` atau `dilewati`), agen wajib memeriksa seluruh kelompok dan menghapus yang kosong.

### 4. Nasib task.md saat ini
- Tanya: Apakah Kelompok 1–32 yang kosong akan dihapus sekarang?
- Kesimpulan: Belum dihapus pada sesi ini (di luar cakupan eksplisit "tambahkan disini aturannya"); penghapusan terjadi otomatis saat `task.md` berikutnya diedit sesuai aturan baru, atau menunggu permintaan eksplisit pengguna (lihat Tindak Lanjut No. 4).

## Keputusan
- K-1: Aturan ditambahkan sebagai butir 12 di `.kilo/commands/kerjakan_task.md`: `kelompok kosong : setiap kali file task.md diedit (termasuk saat menandai task \`selesai\` atau \`dilewati\`), periksa seluruh kelompok; jika sebuah kelompok tidak memuat satu pun \`#### Task N\` di bawah \`## Tinggi\`, \`## Sedang\`, atau \`## Rendah\` — termasuk kelompok yang hanya berisi \`Tidak ada temuan.\` atau heading kosong — maka kelompok tersebut wajib dihapus dari task.md.`
- K-2: Mirror `gpt/kerjakan_task.md` disamakan; `diff -q` bersih (identik dengan `.kilo/commands/kerjakan_task.md`).
- K-3: `.agents/rules/global/format_task.md` dan `task.md` tidak diubah pada sesi ini (di luar cakupan eksplisit permintaan pengguna).
- K-4: Cadangan isi berkas sebelum penyuntingan disimpan di `.backup_task/kerjakan_task.md.bak` sesuai konvensi rule 8 pada berkas yang sama.

## Rekomendasi
- R-1: Jalankan pembersihan `task.md` (hapus seluruh Kelompok 1–32 yang kosong) pada sesi terpisah, atau biarkan berjalan otomatis saat `kerjakan_task` berikutnya mengedit `task.md`.
- R-2: Pertimbangkan penambahan aturan senada pada `.agents/rules/global/format_task.md` bila aturan ini juga ingin berlaku bagi penulis `task.md` di luar perintah `kerjakan_task` (di luar cakupan sesi ini; memerlukan keputusan pengguna).

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1  | Tambah butir 12 aturan kelompok kosong di `kerjakan_task.md` | `.kilo/commands/kerjakan_task.md` | selesai |
| 2  | Samakan mirror `gpt/kerjakan_task.md` | `gpt/kerjakan_task.md` | selesai |
| 3  | Buat cadangan sebelum edit | `.backup_task/kerjakan_task.md.bak` | selesai |
| 4  | Keputusan pembersihan `task.md` (Kelompok 1–32 kosong) | `task.md` | belum (perlu keputusan pengguna) |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `.kilo/commands/kerjakan_task.md` | Diubah | Tambah butir 12 "kelompok kosong" |
| `gpt/kerjakan_task.md` | Diubah | Mirror identik dengan `.kilo/commands/kerjakan_task.md` |
| `.backup_task/kerjakan_task.md.bak` | Dibuat | Cadangan isi berkas sebelum penyuntingan |
| `hasil_diskusi/diskusi_5.md` | Dibuat | Dokumentasi hasil diskusi ini |
| `MEMORI.md` | Diubah | Lokasi & riwayat diskusi, riwayat perubahan, catatan kondisi folder `hasil_diskusi/` |

## Pertanyaan Terbuka
- Penomoran berkas ini memakai `diskusi_5.md` mengikuti catatan `MEMORI.md` ("diskusi berikutnya = diskusi_5.md"). Secara literal `.agents/rules/global/format_hasil_diskusi.md` §4.3 (nomor tertinggi yang ada di folder `hasil_diskusi/` = 3, +1 = `diskusi_4.md`) menghasilkan nomor berbeda; berkas `diskusi_4.md` sebelumnya sudah dihapus oleh commit `b1d5a45`. Mohon koreksi bila pengguna menginginkan penomoran mengikuti aturan literal.
- Apakah Kelompok 1–32 di `task.md` yang sejak awal kosong akan dihapus sekarang, atau dibiarkan menunggu penyuntingan `task.md` berikutnya?

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Dokumen dibuat; butir 12 diterapkan di `.kilo/commands/kerjakan_task.md` dan mirror `gpt/` disamakan |
