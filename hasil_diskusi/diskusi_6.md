# Hasil Diskusi 6 — Kewajiban pembaruan bagian Pertanyaan Terbuka pada berkas hasil diskusi

## Status
- Dokumen: Final
- Implementasi: Sudah Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Aturan agar `## Pertanyaan Terbuka` pada berkas hasil diskusi selalu diperbarui setiap ada perubahan status/isi; cara menutup pertanyaan terjawab (hapus + jejak di `## Riwayat Perubahan`).

## Latar Belakang
Bagian `## Pertanyaan Terbuka` pada berkas hasil diskusi sering dibiarkan basi: pertanyaan yang sudah terjawab tetap tercantum, sehingga pembaca tidak tahu mana yang masih menunggu keputusan. Pengguna ingin agar bagian ini selalu diperbarui setiap kali status atau isi berkas berubah, dengan cara menutup pertanyaan terjawab (hapus dari daftar) sambil menyisakan jejak di `## Riwayat Perubahan`.

## Poin Diskusi
### 1. Cara menutup pertanyaan terjawab
- Tanya: Bagaimana cara menutup pertanyaan yang sudah terjawab pada `## Pertanyaan Terbuka`?
- Kesimpulan: Hapus dari daftar `## Pertanyaan Terbuka`, lalu catat sebagai jejak di `## Riwayat Perubahan` (mis. "Pertanyaan terbuka ditutup: ...") agar audit tetap ada dan daftar tetap bersih.

### 2. Cakupan penegakan aturan
- Tanya: Seberapa luas penegakan aturan "Pertanyaan Terbuka selalu diperbarui" yang diinginkan?
- Kesimpulan: Menyeluruh — ubah `format_hasil_diskusi.md` (§5, §9, §11) + `mode_diskusi.md` §4 + `kerjakan_hasil_diskusi.md` §9–§10, lalu sinkronkan salinan `AGENTS.md` dan mirror `gpt/`.

## Keputusan
- K-1: Setiap perubahan status atau isi berkas hasil diskusi WAJIB disertai pembaruan bagian `## Pertanyaan Terbuka` bila ada pertanyaan yang terjawab/berubah.
- K-2: Pertanyaan yang sudah terjawab WAJIB dihapus dari daftar `## Pertanyaan Terbuka`, dan dicatat sebagai jejak di `## Riwayat Perubahan` (mis. "Pertanyaan terbuka ditutup: <ringkasan pertanyaan> — <jawaban singkat> (<tanggal>)").
- K-3: Jika tidak ada pertanyaan terbuka, bagian `## Pertanyaan Terbuka` WAJIB berisi `Belum ada`.
- K-4: Aturan ini ditegakkan secara menyeluruh: `format_hasil_diskusi.md`, `mode_diskusi.md` §4, `kerjakan_hasil_diskusi.md` §9–§10, serta salinan `AGENTS.md` dan mirror `gpt/`.
- K-5: Pembaruan `## Pertanyaan Terbuka` wajib tercermin pada `## Riwayat Perubahan` agar jejak audit tetap ada setelah penghapusan.

## Rekomendasi
- R-1: Tambahkan catatan kewajiban pembaruan pada `format_hasil_diskusi.md` §5.2 (isi tiap bagian) untuk `## Pertanyaan Terbuka`.
- R-2: Tambahkan aturan di `format_hasil_diskusi.md` §7 (Bagian yang Belum Dibahas) atau §8 (Pencatatan) tentang kewajiban pembaruan.
- R-3: Tambahkan butir pada `format_hasil_diskusi.md` §11 (Checklist).
- R-4: Tambahkan butir pada `mode_diskusi.md` §4 (Struktur dan Isi File Hasil Diskusi).
- R-5: Tambahkan langkah pada `kerjakan_hasil_diskusi.md` §9–§10 (Tulis hasil yang disetujui / Kriteria selesai).
- R-6: Samakan salinan `AGENTS.md` dan mirror `gpt/` dengan sumber aturan.

## Tindak Lanjut
| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1 | Tambahkan aturan kewajiban pembaruan `## Pertanyaan Terbuka` | `.agents/rules/global/format_hasil_diskusi.md` | selesai |
| 2 | Tambahkan butir pembaruan `## Pertanyaan Terbuka` | `.kilo/commands/mode/mode_diskusi.md` | selesai |
| 3 | Tambahkan langkah pembaruan `## Pertanyaan Terbuka` | `.kilo/commands/kerjakan_hasil_diskusi.md` | selesai |
| 4 | Samakan salinan `AGENTS.md` | `AGENTS.md` | selesai |
| 5 | Samakan mirror `gpt/` | `gpt/` | selesai |

## File Terdampak
| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `hasil_diskusi/diskusi_6.md` | Dibuat | Berkas hasil diskusi ini |
| `.agents/rules/global/format_hasil_diskusi.md` | Diubah | Aturan pembaruan Pertanyaan Terbuka (§5, §7, §9, §11) |
| `.kilo/commands/mode/mode_diskusi.md` | Diubah | Butir pembaruan Pertanyaan Terbuka (§4) |
| `.kilo/commands/kerjakan_hasil_diskusi.md` | Diubah | Langkah pembaruan Pertanyaan Terbuka (§9–§10) |
| `AGENTS.md` | Diubah | Salinan aturan format disamakan |
| `gpt/mode/mode_diskusi.md` | Diubah | Mirror disamakan |
| `gpt/kerjakan_hasil_diskusi.md` | Diubah | Mirror disamakan |

## Pertanyaan Terbuka
Belum ada

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Berkas dibuat (Final) — kewajiban pembaruan `## Pertanyaan Terbuka` |
