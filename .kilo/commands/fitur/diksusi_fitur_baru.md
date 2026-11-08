---
agent: code
description: Diskusi fitur baru / pembaruan fitur berdasarkan satu entri di referensi_apk.md — analisis, cek implementasi, contoh kode, dan tulis/perbarui PRD.
---

# Command: Diskusi Fitur Baru / Pembaruan Fitur

## 🎯 Tujuan Command

Command ini dipakai untuk **berdiskusi** mengenai **fitur baru** atau **pembaruan fitur yang sudah ada** berdasarkan **satu entri** dari file `referensi_apk.md`.

Command ini **BUKAN** untuk implementasi kode. Output akhir yang diharapkan hanyalah:

1. Penjelasan tujuan fitur.
2. Daftar file terdampak.
3. Contoh kode singkat (sebagai gambaran).
4. Status implementasi saat ini (sudah / belum / sebagian).
5. File PRD baru atau PRD yang diperbarui di folder `prd`.

---

## ⚠️ Batasan Mutlak (WAJIB DIPATUHI)

- ❌ **DILARANG** mengedit/menulis file selain file PRD terkait di folder `prd/`.
- ❌ **DILARANG** mengubah kode sumber (komponen, service, util, route, config, dsb).
- ❌ **DILARANG** membuat PRD untuk fitur lain yang tidak sedang didiskusikan.
- ❌ **DILARANG** melewati langkah **cek implementasi** — ini wajib dilakukan sebelum menyimpulkan fitur belum ada.
- ❌ **DILARANG** melewati langkah **membaca link APK** pada entri referensi.
- ✅ **BOLEH** membaca file apa pun (read-only) untuk keperluan analisis.
- ✅ **HANYA BOLEH** membuat/memperbarui **satu file PRD** yang berkaitan langsung dengan fitur yang sedang didiskusikan.

---

## 📥 Input yang Diharapkan

User akan memberikan **satu entri** dari `referensi_apk.md` (bisa berupa teks entri, nama fitur, atau nomor baris). Contoh:

> "Ambil entri di baris 42 dari `referensi_apk.md`."

Jika user **belum** menyebutkan entri mana, **tanyakan terlebih dahulu** entri mana yang ingin didiskusikan. Jangan menebak.

---

## 🔄 Alur Kerja (Wajib Berurutan)

### Langkah 1 — Baca & Identifikasi Entri Referensi

1. Baca file `referensi_apk.md` di root project.
2. Temukan entri yang dimaksud user.
3. Catat:
   - **Path file**: `referensi_apk.md`
   - **Nomor baris**: `baris X` (sertakan range jika entri lebih dari 1 baris, contoh: `baris 42-45`)
   - **Link APK** yang tercantum pada entri tersebut.
4. Tampilkan ringkasan entri ke user sebagai konfirmasi pemahaman.

### Langkah 2 — Baca Link APK

1. Buka / akses **link APK** yang ada pada entri referensi untuk melihat **gambaran visual & fungsional** fitur.
2. Ringkas hasil pembacaan: apa yang fitur ini tampilkan, alur UX-nya, elemen UI utama, dan perilaku yang diharapkan.
3. Jika link tidak bisa diakses, **laporkan ke user** dan minta konfirmasi apakah lanjut dengan informasi terbatas.

### Langkah 3 — Cek Implementasi yang Sudah Ada (WAJIB)

Sebelum menyimpulkan fitur ini baru, lakukan pengecekan menyeluruh:

1. **Cari keyword** terkait nama fitur di seluruh codebase (grep/search): nama komponen, nama fungsi, label UI, nama route, dsb.
2. **Periksa struktur folder** yang mungkin relevan (misal `src/components`, `src/pages`, `src/services`, `src/routes`, `src/utils`, `src/hooks`, dst).
3. **Periksa file konfigurasi** (routing, menu, i18n, constants) untuk melihat apakah fitur sudah terdaftar.
4. **Periksa PRD yang sudah ada** di folder `prd/` — kalau sudah ada PRD untuk fitur ini, siapkan untuk **memperbarui**, bukan membuat baru.
5. Simpulkan status:
   - ✅ **Sudah ada** → tunjukkan file & barisnya. Diskusi berfokus pada pembaruan.
   - 🟡 **Sebagian** → tunjukkan bagian mana yang sudah/belum. Diskusi berfokus pada pelengkapan.
   - ❌ **Belum ada** → lanjut sebagai fitur baru.

> Jika status **sudah ada / sebagian**, **jelaskan temuan detail** ke user sebelum lanjut ke langkah berikutnya.

### Langkah 4 — Jelaskan Tujuan Fitur

Susun penjelasan dengan urutan:

1. **Tujuan utama fitur** — untuk apa fitur ini dibuat/diperbarui.
2. **Masalah yang ingin diselesaikan** (problem statement).
3. **Manfaat bagi user** (user value).
4. **Manfaat bagi sistem/bisnis** (jika ada).
5. **Ruang lingkup** — apa yang termasuk & apa yang tidak termasuk dalam fitur ini.

Gunakan bahasa yang jelas, ringkas, dan tidak bertele-tele. Hindari jargon berlebihan.

### Langkah 5 — Daftar File Terdampak

Buat tabel atau bullet list berisi:
| No | Path File / Folder | Peran / Alasan Terdampak | Status (baru / ubah) |

Aturan:

- Kelompokkan berdasarkan jenis (UI, logic, service, route, config, dsb).
- Jika fitur sudah ada sebagian, tandai mana yang akan **dibuat baru** vs **dimodifikasi**.
- Sertakan file PRD terkait di folder `prd/` sebagai salah satu file yang akan ditulis/diperbarui.

### Langkah 6 — Contoh Kode Singkat

Berikan **cuplikan kode singkat** (bukan implementasi penuh) sebagai gambaran:

- Pilih bagian inti yang paling representatif (misal: komponen utama, fungsi handler, atau service call).
- Beri komentar singkat tiap bagian penting.
- Sebutkan asumsi (framework, bahasa, library) jika relevan.
- **JANGAN** menulis contoh kode langsung ke file source — hanya tampil di jawaban diskusi dan di PRD.

### Langkah 7 — Tulis / Perbarui PRD

1. Tentukan nama file PRD:
   - Jika PRD untuk fitur ini **sudah ada** di `prd/` → **perbarui** file tersebut.
   - Jika belum ada → **buat baru** dengan nama slug, contoh: `prd/<nama-fitur-dalam-kebab-case>.md`.
2. File PRD **WAJIB** memuat struktur minimal:

````markdown
# PRD: <Nama Fitur>

## 1. Referensi

- Sumber: `referensi_apk.md`
- Path: `referensi_apk.md`
- Baris: baris <X> (s/d baris <Y> jika lebih dari satu)
- Link APK: <link>

## 2. Status

- Status: <Baru / Pembaruan>
- Implementasi saat ini: <Belum ada / Sebagian / Sudah ada — sebut file>
- Tanggal diskusi: <YYYY-MM-DD>

## 3. Tujuan & Latar Belakang

<penjelasan tujuan fitur, masalah, dan manfaat>

## 4. Ruang Lingkup

- Termasuk: ...
- Tidak termasuk: ...

## 5. Gambaran Fitur (dari Link APK)

<ringkasan hasil pembacaan link APK>

## 6. File Terdampak

| No | Path | Peran | Status |

## 7. Rencana Implementasi (Ringkas)

<langkah-langkah singkat>

## 8. Contoh Kode Singkat

```<bahasa>
// cuplikan representatif
```
````
