# Hasil Diskusi 2 — Pembuatan Prompt untuk Mode Ask dan Debug

## Status
- Dokumen: Final
- Implementasi: Belum Diimplementasikan
- Tanggal: 2026-11-13
- Topik: Pembuatan berkas prompt kustom untuk agent `ask` dan `debug` pada konfigurasi Kilo proyek, beserta wiring ke `.kilo/kilo.jsonc`

## Latar Belakang

Konfigurasi Kilo proyek (`.kilo/kilo.jsonc`) saat ini mendefinisikan enam agent (`code`, `ask`, `plan`, `debug`, `orchestrator`, `compaction`). Dua di antaranya belum memiliki prompt kustom yang setara dengan `code`:

- `agent.ask` — hanya berisi `model: kilo/kilo-auto/free` dan `variant: max`; tanpa `prompt`. Perilaku mengandalkan prompt bawaan Kilo (asisten teknis read-only).
- `agent.debug` — `model: kilo/kilo-auto/free` dengan `prompt` inline singkat: `"kamu harus mengatasi masalah ini, agar mengikuti file dependensi nya supaya ketemu solusinya"`.

Sebagai perbandingan, `agent.code` sudah memakai berkas prompt `.kilo/prompts/code.md` yang dirujuk lewat `prompt: "{file:./prompts/code.md}"` (diterapkan 2026-11-12). Pengguna ingin pola yang sama diterapkan pada `ask` dan `debug` agar keduanya memiliki prompt proyek yang terstruktur, portabel (ikut ter-clone bersama repo), dan konsisten gaya penulisannya dengan `code.md`.

Referensi agent bawaan Kilo (dokumentasi kilo.ai/docs):

- `ask` — asisten teknis read-only: alat baca (`read`, `glob`, `grep`, `list`), bash read-only, tanpa modifikasi berkas; ideal untuk menjelaskan kode dan investigasi proyek.
- `debug` — pemecah masalah sistematis: akses penuh; ideal untuk telusur bug dan diagnostik.
- `ask` pada proyek ini juga sudah dibatasi oleh `permission` proyek, tetapi pembatasan permission tidak menggantikan arahan gaya/perilaku pada prompt.

## Poin Diskusi

### 1. Cakupan pekerjaan
- Tanya: Apa yang termasuk dalam cakupan pembuatan prompt ask dan debug?
- Kesimpulan: Membuat dua berkas baru di `.kilo/prompts/` (`ask.md` dan `debug.md`) lalu wiring `agent.ask` dan `agent.debug` pada `.kilo/kilo.jsonc` memakai `{file:./prompts/ask.md}` dan `{file:./prompts/debug.md}`.

### 2. Basis isi `ask.md`
- Tanya: Basis apa yang diinginkan untuk isi prompt ask?
- Kesimpulan: Adaptasi `code.md` untuk konteks read-only — peran asisten tanya-jawab proyek, cara kerja (baca `MEMORI.md`/`AGENTS.md`, muat skill relevan, bahasa Indonesia baku, jawab berbasis konteks), larangan (edit/hapus file, perintah yang mengubah repo, mengarang), serta arahan ke mode `code`/`debug` bila pengguna memerlukan perubahan.

### 3. Basis isi `debug.md`
- Tanya: Basis apa yang diinginkan untuk isi prompt debug?
- Kesimpulan: Memperkuat teks prompt inline yang sudah ada (mempertahankan inti makna "ikuti file dependensi untuk menemukan akar masalah") menjadi struktur seperti `code.md`: peran, cara kerja, verifikasi, dan larangan.

### 4. Kelengkapan struktur `ask.md`
- Tanya: Seberapa lengkap struktur ask.md?
- Kesimpulan: Lengkap seperti `code.md` (Peran, Cara Kerja, Larangan).

### 5. Kelengkapan struktur `debug.md`
- Tanya: Seberapa lengkap struktur debug.md?
- Kesimpulan: Terstruktur seperti `code.md` plus teks inline lama sebagai inti "Cara Kerja".

### 6. Model dan variant agent
- Tanya: Apakah model/variant `ask` dan `debug` ikut diubah?
- Kesimpulan: Tetap. `ask` = `kilo/kilo-auto/free` variant `max`; `debug` = `kilo/kilo-auto/free` tanpa variant. Hanya wiring `prompt` yang diubah.

## Keputusan

- K-1: Dibuat dua berkas prompt baru: `.kilo/prompts/ask.md` dan `.kilo/prompts/debug.md`.
- K-2: `.kilo/kilo.jsonc` mengubah `agent.ask` menjadi `"prompt": "{file:./prompts/ask.md}"` (model/variant tetap) dan `agent.debug` menjadi `"prompt": "{file:./prompts/debug.md}"` (model tetap, `prompt` inline lama dihapus).
- K-3: Isi `ask.md` = adaptasi read-only dari `code.md`; isi `debug.md` = gabungan struktur `code.md` dengan inti teks inline lama (dinormalkan bahasanya).
- K-4: Model dan variant `ask`/`debug` tidak diubah.
- K-5: Mode Diskusi hanya mendokumentasikan keputusan; implementasi menunggu perintah pengguna (mis. lewat `.kilo/commands/kerjakan_hasil_diskusi.md`).

Draft isi berkas yang disepakati:

`.kilo/prompts/ask.md`:

````markdown
# Peran

Kamu asisten teknis read-only untuk proyek "berhenti_merokok". Tugasmu menjawab pertanyaan, menjelaskan kode, dan menginvestigasi proyek tanpa mengubah berkas.

# Cara Kerja

1. Baca `MEMORI.md` dan `AGENTS.md` sebelum menjawab.
2. Muat skill relevan melalui tool `skill` bila jawaban memerlukan panduan proyek.
3. Jawab ringkas dan berbasis konteks proyek serta file yang dibaca; sebutkan path file bila mengutip.
4. Gunakan bahasa Indonesia baku.
5. Bila pengguna memerlukan perubahan kode/dokumen, nyatakan bahwa itu di luar mode ini dan arahkan ke mode `code` atau `debug`.

# Larangan

- Mengubah, membuat, atau menghapus file apa pun.
- Menjalankan perintah yang mengubah state repository atau sistem.
- Mengarang informasi; nyatakan tidak diketahui bila data tidak tersedia.
````

`.kilo/prompts/debug.md`:

````markdown
# Peran

Kamu engineer Flutter senior yang menangani masalah/bug pada proyek "berhenti_merokok" secara sistematis.

# Cara Kerja

1. Baca `MEMORI.md` dan `AGENTS.md` sebelum bertindak, lalu muat skill relevan melalui tool `skill`.
2. Pahami gejala, lalu ikuti file dependensi (import, pemanggilan, konfigurasi) untuk menemukan akar penyebab, bukan sekadar menambal gejala.
3. Reproduksi/isolasi masalah, susun hipotesis, verifikasi bertahap, perbaiki secara minimal dan terarah.
4. Gunakan bahasa Indonesia baku untuk respons, dokumen, dan komentar kode.
5. Verifikasi sebelum melapor selesai: `dart format`, `dart analyze`, dan `flutter test` bila relevan.
6. Jangan mengedit berkas hasil generate (`*.g.dart`, `*.freezed.dart`, `*.mocks.dart`); ubah sumbernya lalu jalankan `build_runner`.

# Larangan

- Menjalankan operasi destruktif (hapus paksa, `reset --hard`, `push --force`) tanpa konfirmasi pengguna.
- Mengubah cakupan pekerjaan tanpa persetujuan pengguna.
- Mengarang informasi; nyatakan tidak diketahui bila data tidak tersedia.
````

Wiring `.kilo/kilo.jsonc` (bagian `agent`):

```jsonc
"ask": {
  "model": "kilo/kilo-auto/free",
  "variant": "max",
  "prompt": "{file:./prompts/ask.md}"
},
"debug": {
  "model": "kilo/kilo-auto/free",
  "prompt": "{file:./prompts/debug.md}"
},
```

## Rekomendasi

- R-1: Setelah implementasi, validasi config Kilo (mis. `kilo debug config` / `kilo debug agent ask` dan `kilo debug agent debug`) untuk memastikan prompt berkas termuat.
- R-2: Pertahankan pola `{file:./prompts/<nama>.md}` untuk prompt agent lain di masa depan agar selaras dengan `agent.code`.
- R-3: Normalisasi bahasa teks inline debug lama (`"dependensi nya"` → kalimat baku) dilakukan pada `debug.md`; makna tidak diubah.
- R-4: Prompt `ask.md` bersifat instruksi perilaku/gaya; batasan read-only tetap ditegakkan oleh `permission` proyek, bukan oleh prompt. Keduanya saling melengkapi dan tidak saling menggantikan.

## Tindak Lanjut

| No | Tindakan | File Terdampak | Status |
|----|----------|----------------|--------|
| 1  | Buat `.kilo/prompts/ask.md` sesuai draft di atas | `.kilo/prompts/ask.md` | belum |
| 2  | Buat `.kilo/prompts/debug.md` sesuai draft di atas | `.kilo/prompts/debug.md` | belum |
| 3  | Wiring `agent.ask` dan `agent.debug` di `.kilo/kilo.jsonc` (ganti `prompt` inline debug dengan `{file:./prompts/debug.md}`) | `.kilo/kilo.jsonc` | belum |
| 4  | Validasi config Kilo (`kilo debug config` / `kilo debug agent ask` / `kilo debug agent debug`) | — | belum |
| 5  | Perbarui `MEMORI.md` setelah implementasi | `MEMORI.md` | belum |

## File Terdampak

| Lokasi File | Status Perubahan | Deskripsi |
|-------------|------------------|-----------|
| `.kilo/prompts/ask.md` | Dibuat | Prompt kustom agent `ask` (adaptasi read-only dari `code.md`) |
| `.kilo/prompts/debug.md` | Dibuat | Prompt kustom agent `debug` (struktur `code.md` + inti teks inline lama) |
| `.kilo/kilo.jsonc` | Diubah | Wiring `prompt: "{file:./prompts/ask.md}"` (ask) dan `"{file:./prompts/debug.md}"` (debug); model/variant tetap |

## Pertanyaan Terbuka
- Belum ada

## Riwayat Perubahan
| Tanggal | Perubahan |
|---------|-----------|
| 2026-11-13 | Berkas diskusi dibuat berdasarkan keputusan pengguna: cakupan 2 berkas + wiring, `ask.md` adaptasi read-only dari `code.md`, `debug.md` memperkuat teks inline lama, model/variant tetap, implementasi ditunda menunggu perintah pengguna. |
