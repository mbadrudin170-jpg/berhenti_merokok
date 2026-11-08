---
description: Analisa commit yang sudah masuk terhadap aturan rules dan SDK, lalu perbarui catatan.md dan task.md tanpa mengubah kode dart
agent: code
---

# Cek Perubahan Sekarang

Tugas: menganalisa commit yang **sudah masuk** untuk memastikan sesuai aturan rules & SDK, memperbarui `catatan.md` dan (jika perlu) `task.md`. **JANGAN ubah kode dart dulu** — hanya analisa dan beri saran.

## Langkah kerja

### 1. Baca struktur rules (WAJIB lengkap)

- Baca `docs/struktur_rules.md` terlebih dahulu.
- Lalu baca **SEMUA** file rules yang terdaftar di dalamnya. Jangan ada satu pun file yang terlewat, sekecil apa pun.

### 2. Tentukan target commit

- Baca `catatan.md` di root terlebih dahulu.
- Jika `catatan.md` berisi commit terakhir yang sudah dievaluasi → target = commit **setelah** commit terakhir tersebut.
- Jika `catatan.md` belum ada / kosong → target = **5 commit terakhir**.
- Setelah target ditentukan, **abaikan commit baru** yang masuk setelahnya untuk tugas ini. Commit baru itu akan dievaluasi di tugas berikutnya.

### 3. Baca perubahan commit target

- Lihat diff / file yang berubah pada setiap commit target.
- Fokus utama ke file `.dart`, tapi jangan abaikan file lain yang relevan (config, rule, pubspec, dll).

### 4. Analisa terhadap rules

- Periksa setiap perubahan apakah sesuai dengan seluruh rules yang sudah dibaca di langkah 1.
- Jika ada pelanggaran / ketidaksesuaian → catat beserta saran perbaikan.

### 5. Analisa terhadap SDK (WAJIB, jangan skip)

- Baca source SDK untuk **setiap** kode / widget yang berubah.
- **Wajib baca SDK walaupun itu widget biasa** — paket sering punya konstruktor baru atau konstruktor yang sudah deprecated. Ini penting supaya pengetahuan saya ikut bertambah.
- Verifikasi apakah kode yang berubah masih sesuai dengan API SDK terbaru.
- Jika ada konstruktor / API yang deprecated atau tidak sesuai → beri saran perbaikan.

### 6. Perbarui `catatan.md` (root)

- Simpan info commit terakhir yang dievaluasi (hash + tanggal + ringkasan singkat).
- **Jaga agar tidak membeludak**: simpan hanya ringkasan (misal 10–20 entri terakhir), hapus entri lama jika sudah tidak diperlukan. Tujuannya agar tugas berikutnya tidak perlu baca commit yang sudah dievaluasi.
- Jangan menulis detail panjang di `catatan.md`; detail analisa cukup di output chat.

### 7. Perbarui `task.md` (jika perlu)

- Jika dari analisa ditemukan **tambahan** atau **pembaruan** yang perlu dikerjakan → update `task.md` di root.
- Sesuaikan format penulisan dengan `.agents/rules/global/format_task.md`.

### 8. Ringkasan output

- Tampilkan di chat:
  - Daftar commit yang dianalisa.
  - Pelanggaran rules + saran.
  - Ketidaksesuaian SDK + saran.
  - Perubahan yang dilakukan pada `catatan.md` dan `task.md`.

> Catatan: cukup perbarui isi bagian command ini saja; isi `catatan.md` dijaga tetap ringkas agar tidak menumpuk seiring waktu.
