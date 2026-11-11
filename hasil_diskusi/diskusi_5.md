## Status
Final

## Topik
Apakah perlu membuat command baru untuk mengerjakan hasil dari diskusi.

## Ringkasan
- Hasil diskusi disimpan di `hasil_diskusi/diskusi_N.md` dengan struktur `Status`, `Topik`, `Ringkasan`, `Keputusan`, `Tindak Lanjut` (mengacu `.kilo/commands/mode/mode_diskusi.md`).
- Command eksekusi yang relevan: `.kilo/commands/kerjakan.md`, `.kilo/commands/kerjakan_task.md`, `.kilo/commands/prd/kerjakan_prd.md`.
- Gap: `Tindak Lanjut` diskusi bersifat naratif dan belum terpetakan ke format kerja terstruktur (`task.md` sesuai `.agents/rules/global/format_task.md` atau PRD), sehingga diperlukan jembatan yang lebih spesifik.

## Keputusan
- **Disepakati** membuat command baru `.kilo/commands/kerjakan_hasil_diskusi.md` sebagai perintah spesifik untuk menindaklanjuti hasil diskusi.
- **Input**: file sumber `hasil_diskusi/diskusi_N.md` wajib dipilih/ditentukan oleh pengguna.
- **Konteks wajib dibaca terlebih dahulu**: hanya `AGENTS.md` (root) dan patuhi aturannya; file diskusi sumber dibaca setelahnya untuk validasi status, lalu konteks lain (mis. `.agents/rules/global/format_task.md`, `.agents/rules/global/format_PRD.md`, dll.) dibaca sesuai kebutuhan agar hasil patuh aturan proyek.
- **Validasi status**: jika file diskusi berstatus `Draft`, **jangan dikerjakan walaupun ditunjuk oleh pengguna**; proses dihentikan dan pengguna diminta mengubah status menjadi `Final` (atau `Batal`) terlebih dahulu. Hanya diskusi berstatus `Final` yang boleh ditindaklanjuti.
- Perilaku utama: mengekstrak keputusan/tindak lanjut, memetakan ke draf terstruktur `task.md` (atau rekomendasi PRD bila cakupan besar), **meminta konfirmasi sebelum menulis**, dan **tidak mengubah kode implementasi** dalam command ini.
- Keluaran yang disetujui menjadi masukan eksekusi melalui `kerjakan_task.md` atau alur PRD.

## Tindak Lanjut
- Command `.kilo/commands/kerjakan_hasil_diskusi.md` telah dibuat.
- Penggunaan: jalankan command tersebut dengan menyebutkan `diskusi_N.md` sumber (atau biarkan memilih diskusi `Final` terbaru) untuk menghasilkan draf task/PRD terstruktur.
- Tindak lanjut opsional (di luar diskusi ini): pertimbangkan sinkronisasi/salinan command ke lokasi lain bila diperlukan oleh alur proyek (`.clinerules/workflows/commands`, `gpt/`, dsb.).
