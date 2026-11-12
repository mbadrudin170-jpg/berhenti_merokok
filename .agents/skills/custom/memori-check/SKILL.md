---
name: memori-check
description: Panduan WAJIB pada SETIAP interaksi apa pun di proyek ini - bukan hanya saat mengerjakan task, tapi juga pertanyaan, diskusi, review, penelusuran, dan perbaikan kode/dokumen. Skill ini mewajibkan membaca MEMORI.md di root proyek sebelum interaksi apa pun untuk mendapatkan konteks proyek yang konsisten (Status Proyek, Provider/Riverpod Key, Enum Utama, File Konfigurasi & Penting, Skills & Rules Utama, Aturan yang Harus Dipelihara), lalu memperbarui isi MEMORI.md setelah interaksi yang mengubah proyek (kode, dokumen, state). Jangan dilewati walau interaksi tampak kecil, obrolan biasa, atau tidak menyebut "memori" secara eksplisit.
metadata:
  kategori: "custom"
  versi: "1.2.0"
  diperbarui: "Thu Nov 12 2026 06:59:20 WIB"
  sumber-terakhir: "perintah pengguna: perluas trigger memori-check ke SEMUA interaksi di proyek ini (bukan hanya task)"
  model: "openrouter/thinkingmachines/inkling-2-small:free"
---

# Memeriksa File MEMORI.md

Setiap kali model (AI) berinteraksi dengan proyek Flutter "berhenti_merokok", **wajib** membaca file `MEMORI.md` di root proyek sebelum interaksi apa pun (bukan hanya task; termasuk pertanyaan, diskusi, review, penelusuran), dan **wajib** memperbarui isi file `MEMORI.md` setelah interaksi yang mengubah proyek (kode, dokumen, state). Skill ini berlaku untuk SEMUA interaksi di proyek ini.

## Cakupan yang Di-Cover

- **File**: `MEMORI.md` di root proyek `/home/thefarmercompanyba/berhenti_merokok/`
- **Class/Struktur**: Section `Status Proyek`, `Provider/Riverpod Key`, `Enum Utama`, `File Konfigurasi & Penting`, `Skills & Rules Utama yang Diaktifkan`, `Aturan yang Harus Dipelihara`
- **Package**: `memori` (bukan package eksternal, tapi file konteks internal proyek)
- **Method**: Membaca dan meringkas isi MEMORI.md untuk memperoleh konteks terbaru sebelum interaksi apa pun

## Aturan

1. **Wajib baca MEMORI.md terlebih dahulu** sebelum interaksi apa pun di proyek "berhenti_merokok" (task, pertanyaan, diskusi, review, penelusuran)
2. Periksa section **"Status Proyek"** untuk versi dan state terkini
3. Periksa section **"Provider/Riverpod Key"** untuk key yang digunakan saat ini
4. Periksa section **"Skills & Rules Utama yang Diaktifkan"** untuk memastikan skills yang digunakan sesuai aturan proyek
5. Periksa section **"Aturan yang Harus Dipelihara"** untuk konvensi coding yang harus ditaati
6. Catat poin-poin penting dari MEMORI.md yang relevan dengan interaksi/task yang akan dikerjakan
7. **Jangan mulai implementasi** sebelum telah meringkas poin-poin dari MEMORI.md yang relevan
8. Jika ada perubahan versi/state/isi proyek (kode, dokumen, konfigurasi), segera **perbarui MEMORI.md** setelah interaksi selesai

## Larangan

- DILARANG memulai interaksi/task apa pun tanpa membaca MEMORI.md terlebih dahulu
- DILARANG mengabaikan section "Catatan untuk Model Selanjutnya" di MEMORI.md
- DILARANG menggunakan versi proyek yang sudah usang tanpa dicek di MEMORI.md
- DILARANG mengabaikan aturan di section "Aturan yang Harus Dipelihara" setelah baca MEMORI.md
- DILARANG mengimplementasikan fitur tanpa memastikan kepatuhan terhadap conventions di MEMORI.md

## Contoh Benar

```markdown
Sebelum memulai task ini, SELALU lakukan langkah berikut:

1. Buka file MEMORI.md di root proyek
2. Baca section "Status Proyek" untuk versi terbaru
3. Baca section "Provider/Riverpod Key" untuk key yang digunakan
4. Baca section "Aturan yang Harus Dipelihara" untuk konvensi coding
5. Catat poin-poin penting yang relevan dengan task

Lalu lanjutkan implementasi setelah semua poin tercatat.
```

## Contoh Salah

```markdown
// DILARANG: Memulai implementasi tanpa membaca MEMORI.md
// Salah: "Aja langsung aja buat UI-nya, nggak usah baca file2 aneh"

MaterialApp(
  home: Center(child: Text('Contoh Salah')),
); // DILARANG: implementasi tanpa konteks MEMORI.md
```

## Sumber Evaluasi

- File: `MEMORI.md` di root proyek `/home/thefarmercompanyba/berhenti_merokok/`
- Commit rujukan: Diskusi terakhir mengenai pembaruan file MEMORI.md (diskusi_6.md)
- Skill terkait: `aturan-pembuatan-skill`, `validasi-platform-izin`, `gaya`, `penamaan-konvensi`
- Referensi diskusi: `hasil_diskusi/diskusi_6.md` - Keputusan tentang pembaruan MEMORI.md
