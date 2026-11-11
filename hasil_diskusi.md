# Hasil Diskusi: Pengelompokan Skill Flutter

## Tujuan

Memisahkan skill bawaan Flutter/Dart/sistem dari skill kustom (spesifik proyek berhenti merokok) ke dalam subfolder terpisah di `.agents/skills/`.

## Struktur Folder yang Disepakati

```
.agents/skills/
├── custom/        ← skill spesifik proyek (buatan internal tim)
└── bawaan/        ← skill bawaan Flutter/Dart/sistem (dikumpulkan di satu folder)
```

## Skill yang Masuk ke `bawaan/`

### Dart (bawaan)
1. dart-add-unit-test
2. dart-build-cli-app
3. dart-collect-coverage
4. dart-fix-runtime-errors
5. dart-generate-test-mocks
6. dart-migrate-to-checks-package
7. dart-resolve-package-conflicts
8. dart-run-static-analysis
9. dart-setup-ffi-assets
10. dart-use-doc-examples
11. dart-use-ffigen
12. dart-use-path-package
13. dart-use-pattern-matching
14. dart-use-primary-constructors
15. dart-write-documentation

### Flutter (bawaan)
16. adaptive_dialog-dialogs
17. flutter-add-integration-test
18. flutter-add-widget-preview
19. flutter-add-widget-test
20. flutter-apply-architecture-best-practices
21. flutter-build-responsive-layout
22. flutter-fix-layout-issues
23. flutter-implement-json-serialization
24. flutter-setup-declarative-routing
25. flutter-setup-localization
26. flutter-use-http-package

### Sqflite (bawaan)
27. sqflite-common-ffi-web-options
28. sqflite-common-ffi-web-setup
29. sqflite-crud-and-transactions
30. sqflite-open-database
31. sqflite-testing-and-platforms

### Restart (bawaan)
32. restart-app-integration
33. restart-app-ios-engine-restart

### Built-in Kilo
34. kilo-config

## Skill yang Tetap di `custom/`

Skill spesifik proyek berhenti merokok tetap berada di `.agents/skills/custom/` (misalnya: aturan-pembuatan-skill, bug-runtime, gaya, navigator-routing, riverpod-pola, ekstraksi-perhitungan-turunan, empty-state-daftar, ekspor-pemulihan-cadangan, exception-khusus-deteksi-error, import-ordering, isolasi-widget-timer, kartu-motivasi-pintasan-dashboard, keamanan-aplikasi, konfirmasi-sebelum-simpan, larangan-backup-task, logging-debug, migrasi-skema-sqlite, model-state-freezed-abstract, normalisasi-tanggal, notifier-crud-database, panaman-async-data-kosong, panaman-asyncvalue-berkali, panaman-error-unawaited, penanganan-error-unawaited, penjadwalan-frame-dan-pemantauan-performa-flutter, penamaan-konstanta-snake-case, penamaan-konvensi, penanganan-async-data-kosong, penanganan-asyncvalue-berkali, penanganan-error-unawaited, penjadwalan-frame-dan-pemantauan-performa-flutter, penamaan-konstanta-snake-case, penamaan-konvensi, performa-aplikasi, platform-dispatcher-locale, pola-testing, pola-ui, pola-ux, riset-kompetitor, scaffold-struktur-layar, spacing, text-form-field-validasi, tema-data-color-schema, text-form-field-validasi, tipografi, validasi-form-sebelum-penyimpanan, validasi-platform-izin, validasi-tapering, visualisasi-progres-impian, widget-custom, widget-lifecycle-state, withvalues-opacity-warna, zona-waktu-perangkat-pengingat).

Catatan: beberapa skill mungkin muncul di kedua daftar jika ada versi kustom dan bawaan dengan nama yang sama; perlu difurther verifikasi.

## Langkah Selanjutnya (Setelah Mode Diskusi)

1. Buat folder `.agents/skills/bawaan/`
2. Pindahkan seluruh skill di atas ke folder tersebut
3. Sesuaikan referensi path jika diperlukan
4. Verifikasi `kilo.json` atau konfigurasi lain yang merujuk ke path skill

## Aturan yang Diterapkan

- Tidak ada file yang diubah selama mode diskusi (hanya perencanaan dan diskusi)
- Fokus hanya pada topik pengelompokan skill
- Bahasa Indonesia untuk seluruh komunikasi