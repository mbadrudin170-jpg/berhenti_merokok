---
name: memori-check
description: Panduan WAJIB pada SETIAP interaksi apa pun di proyek ini - bukan hanya saat mengerjakan task, tapi juga pertanyaan, diskusi, review, penelusuran, dan perbaikan kode/dokumen. Skill ini mewajibkan membaca `MEMORI.md` di root proyek sebelum interaksi apa pun untuk memperoleh konteks proyek yang konsisten, lalu memperbarui bagian yang relevan di `MEMORI.md` setelah interaksi yang mengubah proyek (kode, dokumen, state). Skill ini sengaja hanya mengatur PROSES (baca konteks -> terapkan -> perbarui bagian relevan) dan TIDAK mengunci nama section tertentu, sehingga tetap valid walau struktur `MEMORI.md` berubah. Jangan dilewati walau interaksi tampak kecil, obrolan biasa, atau tidak menyebut "memori" secara eksplisit.
metadata:
  kategori: "custom"
  versi: "1.3.0"
  diperbarui: "Thu Nov 12 2026 19:12:28 WIB"
  sumber-terakhir: "perintah pengguna: skill jangan mutlak terhadap isi MEMORI.md - ubah ke panduan proses generik"
  model: "kilo/kilo-auto/free"
---

# Memeriksa File MEMORI.md

Setiap kali model (AI) berinteraksi dengan proyek Flutter "berhenti_merokok", **wajib** membaca file `MEMORI.md` di root proyek sebelum interaksi apa pun (bukan hanya task; termasuk pertanyaan, diskusi, review, penelusuran), dan **wajib** memperbarui bagian yang relevan di `MEMORI.md` setelah interaksi yang mengubah proyek (kode, dokumen, state). Skill ini berlaku untuk SEMUA interaksi di proyek ini.

## Cakupan yang Di-Cover

- **File**: `MEMORI.md` di root proyek `/home/thefarmercompanyba/berhenti_merokok/`
- **Objek**: Seluruh isi `MEMORI.md` sebagai konteks hidup proyek (status, konvensi, aturan, catatan teknis, riwayat, dan bagian lain yang ada di dalamnya)
- **Sifat**: `MEMORI.md` adalah dokumen yang **berubah seiring waktu**, bukan kontrak tetap
- **Method**: Membaca dan meringkas isi `MEMORI.md` untuk memperoleh konteks terbaru sebelum interaksi apa pun, lalu memperbarui bagian yang relevan setelah interaksi

## Aturan

1. **Wajib baca `MEMORI.md` terlebih dahulu** sebelum interaksi apa pun di proyek "berhenti_merokok" (task, pertanyaan, diskusi, review, penelusuran).
2. **Pahami konteks dari keseluruhan isi `MEMORI.md`** — termasuk (jika ada) status proyek, struktur, konvensi penamaan, konfigurasi/berkas penting, daftar atau rujukan skill dan aturan, catatan teknis, riwayat, serta bagian lain yang tersedia. Jangan berasumsi hanya ada bagian tertentu.
3. **Terapkan konteks/aturan yang relevan** dari isi `MEMORI.md` pada pekerjaan yang akan dilakukan.
4. **Catat poin-poin penting** dari `MEMORI.md` yang relevan dengan interaksi/task yang akan dikerjakan.
5. **Jangan mulai implementasi** sebelum konteks dari `MEMORI.md` tercerna dan poin-poin relevan tercatat.
6. **Jika ada perubahan** versi/state/isi proyek (kode, dokumen, konfigurasi), **perbarui bagian yang relevan** di `MEMORI.md` setelah interaksi selesai. Tentukan bagian yang relevan berdasarkan isi `MEMORI.md` saat itu, bukan berdasarkan daftar nama bagian yang di-hardcode.
7. **Anggap `MEMORI.md` bisa berubah strukturnya.** Bila bagian yang biasa diperbarui tidak ada, tambahkan bagian yang sesuai kebutuhan; bila ada bagian baru, ikuti strukturnya. Jangan menghapus bagian yang tidak relevan dengan interaksi.
8. **Jika `MEMORI.md` memuat rujukan ke sumber kebenaran lain** (mis. indeks skill atau rules), patuhi rujukan itu dan jangan menggantinya dengan salinan di `MEMORI.md`.

## Larangan

- DILARANG memulai interaksi/task apa pun tanpa membaca `MEMORI.md` terlebih dahulu.
- DILARANG mengabaikan bagian "catatan untuk model selanjutnya" (atau sebutan setara) yang ada di `MEMORI.md`.
- DILARANG menggunakan versi proyek yang sudah usang tanpa dicek di `MEMORI.md`.
- DILARANG mengabaikan aturan/konvensi yang tercantum di `MEMORI.md` setelah membacanya.
- DILARANG mengimplementasikan fitur tanpa memastikan kepatuhan terhadap konvensi yang tercantum di `MEMORI.md`.
- DILARANG menganggap daftar di `MEMORI.md` sebagai daftar lengkap bila `MEMORI.md` sendiri merujuk ke sumber kebenaran lain.
- DILARANG mengubah struktur `MEMORI.md` secara membabi buta hanya karena skill ini menyebut bagian tertentu; skill ini tidak menetapkan struktur `MEMORI.md`.

## Contoh Benar

```markdown
Sebelum memulai interaksi ini, lakukan langkah berikut:

1. Buka file MEMORI.md di root proyek
2. Baca keseluruhan isinya dan pahami konteks proyek yang berlaku saat ini
3. Catat poin-poin yang relevan dengan pekerjaan yang akan dilakukan (mis. konvensi, aturan, catatan penting)
4. Mulai pekerjaan setelah konteks tercerna

Setelah selesai dan bila ada perubahan proyek:
- Perbarui bagian yang relevan di MEMORI.md (mis. status, riwayat, catatan teknis) sesuai kondisi terkini
```

## Contoh Salah

```markdown
// DILARANG: Memulai implementasi tanpa membaca MEMORI.md
// Salah: "Aja langsung aja buat UI-nya, nggak usah baca file2 aneh"

MaterialApp(
  home: Center(child: Text('Contoh Salah')),
); // DILARANG: implementasi tanpa konteks MEMORI.md
```

```markdown
// DILARANG: menganggap skill ini menetapkan bagian tertentu di MEMORI.md
// Salah: "MEMORI.md harus punya bagian X, Y, Z" lalu menghapus/menata ulang bagian lain tanpa alasan dari isi proyek
```

## Sumber Evaluasi

- File: `MEMORI.md` di root proyek `/home/thefarmercompanyba/berhenti_merokok/`
- Commit rujukan: `1823940` (chore(agents): perluas kewajiban pemeriksaan MEMORI.md ke seluruh interaksi proyek), `5e2a55d` (docs(agents): perbarui path hasil diskusi ke prd/hasil_diskusi), `b7f2b05` (docs(memori): lengkapi catatan proyek dan tata ulang arsip diskusi)
- Skill terkait: `aturan-pembuatan-skill`, `validasi-platform-izin`, `gaya`, `penamaan-konvensi`
- Catatan: skill ini dirancang agar **tidak** perlu diperbarui hanya karena isi/struktur `MEMORI.md` berubah.