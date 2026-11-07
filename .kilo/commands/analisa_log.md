---
deskripsi: Menganalisis log debug, pesan error, dan stack trace secara mendalam untuk menemukan akar masalah bug tanpa merubah kode secara langsung
agen pengecekan: kode
---

# Path

.kilo/commands/analisa_log.md

# Tujuan

Menganalisis log debug (`L.i`, `L.w`, `L.e`), stack trace terminal/console, dan diagnosa exception pada proyek Flutter & Dart secara presisi. Command ini bertujuan menemukan _root cause_ dari suatu bug runtime, null-safety violation, atau kesalahan alur logika tanpa berasumsi liar.

# Langkah Kerja

1. **Patuhi Aturan Dasar:**
   - Membaca file `.agents/rules/AGENTS.md` di root proyek dengan teliti dan patuhi seluruh ketentuannya.
   - Wajib memeriksa ketersediaan tools dan daftar izin di file `.kilo/commands/izin_kilo.md` sebelum menjalankan perintah shell/pencarian.

2. **Pengumpulan & Verifikasi Data Log:**
   - Baca output console, terminal, atau file log yang diberikan pengguna.
   - Identifikasi jenis error (misal: Null Check Operator Used on Null, State Error, Bad State, RangeError, TimeoutException, atau SocketException).
   - Ekstrak nama file, baris kode (_line number_), nama kelas, method, getter, serta variabel/parameter yang tercetak pada log `L.e(...)`.

3. **Penelusuran Kode Sumber (`lib/`):**
   - Gunakan tool pencarian teks (`rg`) atau pembaca file untuk memeriksa kode pada baris dan file yang terindikasi pada stack trace.
   - Jika error melibatkan _state management_, telusuri provider/notifier Riverpod terkait.
   - Baca minimal 3–5 file dependen yang terhubung langsung dengan fungsi bermasalah (termasuk model data `ParserUtil`, repository sqflite/supabase, atau UI widget). Wajib membaca file fisik asli, bukan hanya mengandalkan ingatan atau cache.

4. **Analisis Akar Masalah (_Root Cause Analysis_):**
   - Bandingkan alur logika aktual dengan ekspektasi alur kerja aplikasi.
   - Periksa apakah error disebabkan oleh:
     - Penggunaan operator `!` atau casting `as` tanpa guard.
     - Penanganan `async/await` yang tidak memeriksa `if (!mounted) return;` setelah operasi asynchronous.
     - Penggunaan `ref.watch` / `ref.read` Riverpod yang tidak sesuai aturan proyek (misal: memanggil `.value` langsung atau penanganan `.isLoading` / `.hasError` yang terlewat).
     - Gagal parsing tipe data `dynamic` dari database/network.
   - Wajib merujuk pada kode nyata yang ada di file, bukan menebak-nebak.

5. **Pelaporan & Rekomendasi Solusi:**
   - Susun laporan hasil analisis log secara terstruktur dengan format:
     1. Ringkasan Error & Tipe Exception
     2. Lokasi Kejadian (File, Line, Method)
     3. Analisis Akar Masalah (Mengapa Error Terjadi)
     4. Rekomendasi Perbaikan Kode (Sebelum dan Sesudah)
   - Minta konfirmasi dari pengguna sebelum melakukan perubahan pada file kode.

# Larangan

1. **Dilarang Merubah Kode Langsung:** Jangan melakukan edit, write, atau refactoring kode `.dart` selama proses analisis log berlangsung.
2. **Dilarang Berasumsi Liar:** Dilarang menyimpulkan penyebab error tanpa membaca file kode sumber dan dependency terkait.
3. **Dilarang Menggunakan Tool Terminal/Write untuk Edit Kode:** Setelah diizinkan pengguna untuk memperbaiki, perbaikan harus dilakukan menggunakan tool _edit_ presisi (bukan me-rewrite seluruh isi file).
4. **Dilarang Mengedit File Generated:** Dilarang menyentuh atau mengedit file `.g.dart` dan `.freezed.dart`.
5. **Dilarang Mengabaikan Error Handling:** Dilarang menyarankan solusi yang hanya menyembunyikan error (seperti memberikan nilai default sembarangan atau menggunakan `try-catch` kosong tanpa `L.e` log).

# Ketentuan

1. **Bahasa:** Seluruh penjelasan, laporan, dan dokumentasi wajib menggunakan Bahasa Indonesia yang baku, formal, dan profesional.
2. **Kesesuaian Aturan Proyek:** Rekomendasi solusi wajib mengikuti konvensi proyek:
   - Penggunaan nama variabel/fungsi dalam Bahasa Indonesia.
   - Penanganan log menggunakan kelas `L` (`L.e`, `L.w`, `L.i`, `L.s`).
   - Penanganan null safety dengan operator `??` atau `ParserUtil`.
   - Pola asinkronus `async/await` berbasis `Future`.
