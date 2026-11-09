# Analisis Sinkronisasi Skill vs Aturan

## Ringkasan Aturan yang Ditemukan

### Global Rules (17 files)
1. `aturan_skill.md` - Core skill creation/update rules
2. `aturan_bersama.md` - Shared rules (9 topics)
3. `aturan_build.md` - Build restrictions
4. `aturan_global.md` - Global rules overview
5. `aturan_lainnya.md` - General Flutter/Dart dev rules (30 sections)
6. `aturan_notifikasi.md` - Local notification rules (6 sections)
7. `aturan_pemanfaatan_sdk_dan_paket.md` - SDK/package usage (5 sections)
8. `aturan_riverpod.md` - Riverpod rules (11 sections)
9. `aturan_testing.md` - Testing rules (4 sections)
10. `optimasi_boilerplate.md` - Boilerplate optimization (9 sections)
11. `optimasi_bug_runtime.md` - Runtime bug prevention (17 sections)
12. `optimasi_keamanan.md` - Security optimization (4 sections)
13. `optimasi_performa.md` - Performance optimization (2 sections)
14. `optimasi_ui.md` - UI optimization (8 sections)
15. `optimasi_ux.md` - UX optimization (16 sections)
16. `setup_prettier.md` - Prettier setup
17. `model_agent.md` - Model agent info

### Project Rules (2 files)
1. `aturan_proyek.md` - Project rules overview
2. `aturan_khusus.md` - Project-specific rules (21 topics)

## Skill Inventory (36 skills)

| # | Skill | Path | Status |
|---|-------|------|--------|
| 1 | bug-runtime | .agents/skills/custom/bug-runtime/ | Read |
| 2 | ekspor-pemulihan-cadangan | .agents/skills/custom/ekspor-pemulihan-cadangan/ | Read |
| 3 | ekstraksi-perhitungan-turunan | .agents/skills/custom/ekstraksi-perhitungan-turunan/ | Read |
| 4 | empty-state-daftar | .agents/skills/custom/empty-state-daftar/ | Read |
| 5 | exception-khusus-deteksi-error | .agents/skills/custom/exception-khusus-deteksi-error/ | Read |
| 6 | flutter-local-notifications-22-3-3 | .agents/skills/custom/flutter-local-notifications-22-3-3/ | Read |
| 7 | gaya | .agents/skills/custom/gaya/ | Read |
| 8 | import-ordering | .agents/skills/custom/import-ordering/ | Read |
| 9 | isolasi-widget-timer | .agents/skills/custom/isolasi-widget-timer/ | Read |
| 10 | kartu-motivasi-pintasan-dashboard | .agents/skills/custom/kartu-motivasi-pintasan-dashboard/ | Read |
| 11 | konfirmasi-sebelum-simpan | .agents/skills/custom/konfirmasi-sebelum-simpan/ | Read |
| 12 | larangan-backup-task | .agents/skills/custom/larangan-backup-task/ | Read |
| 13 | logging-debug | .agents/skills/custom/logging-debug/ | Read |
| 14 | migrasi-skema-sqlite | .agents/skills/custom/migrasi-skema-sqlite/ | Read |
| 15 | model-state-freezed-abstract | .agents/skills/custom/model-state-freezed-abstract/ | Read |
| 16 | normalisasi-tanggal | .agents/skills/custom/normalisasi-tanggal/ | Read |
| 17 | notifier-crud-database | .agents/skills/custom/notifier-crud-database/ | Read |
| 18 | parsing-nullable-int | .agents/skills/custom/parsing-nullable-int/ | Read |
| 19 | penamaan-konstanta-snake-case | .agents/skills/custom/penamaan-konstanta-snake-case/ | Read |
| 20 | penanganan-async-data-kosong | .agents/skills/custom/penanganan-async-data-kosong/ | Read |
| 21 | penanganan-asyncvalue-berkali | .agents/skills/custom/penanganan-asyncvalue-berkali/ | Read |
| 22 | penanganan-error-unawaited | .agents/skills/custom/penanganan-error-unawaited/ | Read |
| 23 | pola-ui | .agents/skills/custom/pola-ui/ | Read |
| 24 | pola-ux | .agents/skills/custom/pola-ux/ | Read |
| 25 | spacing | .agents/skills/custom/spacing/ | Read |
| 26 | tipografi | .agents/skills/custom/tipografi/ | Read |
| 27 | type-promotion-null-safety | .agents/skills/custom/type-promotion-null-safety/ | Read |
| 28 | validasi-form-sebelum-penyimpanan | .agents/skills/custom/validasi-form-sebelum-penyimpanan/ | Read |
| 29 | validasi-platform-izin | .agents/skills/custom/validasi-platform-izin/ | Read |
| 30 | validasi-tapering | .agents/skills/custom/validasi-tapering/ | Read |
| 31 | visualisasi-progres-impian | .agents/skills/custom/visualisasi-progres-impian/ | Read |
| 32 | widget-custom | .agents/skills/custom/widget-custom/ | Read |
| 33 | withvalues-opacity-warna | .agents/skills/custom/withvalues-opacity-warna/ | Read |
| 34 | zona-waktu-perangkat-pengingat | .agents/skills/custom/zona-waktu-perangkat-pengingat/ | Read |

## Matriks Pemetaan Aturan ke Skill

### A. Aturan yang SUDAH TERCAKUP Penuh oleh Skill

| Aturan | Topik | Skill Terkait | Status |
|--------|-------|---------------|--------|
| aturan_bersama.md #1 | Logging Debug | logging-debug | ✅ Sesuai |
| aturan_bersama.md #2 | Type Promotion Null Safety | type-promotion-null-safety, bug-runtime | ✅ Sesuai (tapi duplikat di bug-runtime) |
| aturan_bersama.md #3 | Import Ordering | import-ordering | ✅ Sesuai |
| aturan_bersama.md #4 | Migrasi Skema SQLite | migrasi-skema-sqlite | ✅ Sesuai |
| aturan_bersama.md #5 | Pola Notifier CRUD | notifier-crud-database | ✅ Sesuai |
| aturan_bersama.md #6 | withValues Opacity | withvalues-opacity-warna, gaya, pola-ui | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #7 | Isolasi Widget Timer | isolasi-widget-timer, pola-ui, widget-custom | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #8 | Normalisasi Tanggal | normalisasi-tanggal, bug-runtime, pola-ui | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #9 | Ekstraksi Perhitungan Turunan | ekstraksi-perhitungan-turunan, bug-runtime | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #10 | Validasi Platform/Izin | validasi-platform-izin, bug-runtime, flutter-local-notifications-22-3-3 | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #11 | Custom Exception Types | exception-khusus-deteksi-error, bug-runtime, ekspor-pemulihan-cadangan | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #12 | Penanganan Beberapa AsyncValue | penanganan-asyncvalue-berkali, bug-runtime, pola-ux | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #13 | Validasi Form | validasi-form-sebelum-penyimpanan, bug-runtime, pola-ux, konfirmasi-sebelum-simpan | ✅ Sesuai (tapi duplikat) |
| aturan_bersama.md #14 | Error Handling Unawaited | penanganan-error-unawaited, bug-runtime, ekspor-pemulihan-cadangan, gaya, kartu-motivasi-pintasan-dashboard, pola-ux | ✅ Sesuai (tapi duplikat) |
| aturan_khusus.md #1 | Logging Debug Biodata | logging-debug | ✅ Sesuai |
| aturan_khusus.md #2 | Biodata untuk Saldo Impian | visualisasi-progres-impian | ✅ Sesuai |
| aturan_khusus.md #3 | Type Promotion Biodata | type-promotion-null-safety | ✅ Sesuai |
| aturan_khusus.md #4 | Penghapusan Biodata Dummy | - | ❌ BELUM ADA SKILL |
| aturan_khusus.md #5 | Konfirmasi Dummy Screen | - | ❌ BELUM ADA SKILL |
| aturan_khusus.md #6 | Migrasi Skema SQLite | migrasi-skema-sqlite | ✅ Sesuai |
| aturan_khusus.md #7 | Pola Notifier CRUD | notifier-crud-database | ✅ Sesuai |
| aturan_khusus.md #8 | Freezed Abstract Class | model-state-freezed-abstract | ✅ Sesuai |
| aturan_khusus.md #9 | Konfirmasi Simpan Form | konfirmasi-sebelum-simpan, pola-ux | ✅ Sesuai (duplikat) |
| aturan_khusus.md #10 | Empty State Daftar | empty-state-daftar, pola-ux, widget-custom | ✅ Sesuai (duplikat) |
| aturan_khusus.md #11 | Penanganan Async Data Kosong | penanganan-async-data-kosong, pola-ux | ✅ Sesuai (duplikat) |
| aturan_khusus.md #12 | Normalisasi Tanggal | normalisasi-tanggal, pola-ui | ✅ Sesuai (duplikat) |
| aturan_khusus.md #13 | Multiple AsyncValue Provider | penanganan-asyncvalue-berkali, pola-ux | ✅ Sesuai (duplikat) |
| aturan_khusus.md #14 | Ekstraksi Perhitungan Turunan | ekstraksi-perhitungan-turunan | ✅ Sesuai |
| aturan_khusus.md #15 | Flutter Local Notifications | flutter-local-notifications-22-3-3 | ✅ Sesuai |
| aturan_khusus.md #16 | Zona Waktu Perangkat | zona-waktu-perangkat-pengingat | ✅ Sesuai |
| aturan_khusus.md #17 | Validasi Tapering | validasi-tapering | ✅ Sesuai |
| aturan_khusus.md #18 | Ekspor/Pemulihan Cadangan | ekspor-pemulihan-cadangan | ✅ Sesuai |
| aturan_khusus.md #19 | Visualisasi Progres Impian | visualisasi-progres-impian, pola-ui, widget-custom | ✅ Sesuai (duplikat) |
| aturan_khusus.md #20 | Kartu Motivasi/Pintasan | kartu-motivasi-pintasan-dashboard, pola-ux | ✅ Sesuai (duplikat) |
| aturan_khusus.md #21 | Larangan Backup Task | larangan-backup-task | ✅ Sesuai |
| aturan_khusus.md #22 | Snake Case Konstanta | penamaan-konstanta-snake-case | ✅ Sesuai |
| aturan_khusus.md #23 | ParseIntOrNull | parsing-nullable-int | ✅ Sesuai |

### B. Aturan Global yang BELUM TERCAKUP oleh Skill

| Aturan | Topik | Section | Skill Diperlukan |
|--------|-------|---------|------------------|
| aturan_riverpod.md | Riverpod Generator | 1 | riverpod-generator |
| aturan_riverpod.md | KeepAlive & Lifecycle | 2 | riverpod-lifecycle |
| aturan_riverpod.md | ref.watch Patterns | 3 | riverpod-watch-patterns |
| aturan_riverpod.md | ref.read Patterns | 4 | riverpod-read-patterns |
| aturan_riverpod.md | ref.listen Patterns | 5 | riverpod-listen-patterns |
| aturan_riverpod.md | ref.listenManual | 6 | riverpod-listen-manual |
| aturan_riverpod.md | ProviderScope | 7 | riverpod-providerscope |
| aturan_riverpod.md | ref.refresh | 8 | riverpod-refresh |
| aturan_riverpod.md | Optimistic Update | 9 | riverpod-optimistic-update |
| aturan_riverpod.md | ref.onDispose | 10 | riverpod-ondispose |
| aturan_riverpod.md | select for Rebuild | 11 | riverpod-select |
| aturan_testing.md | Test Coverage | 1 | testing-coverage |
| aturan_testing.md | Mockito Usage | 2 | testing-mockito |
| aturan_testing.md | Test File Structure | 3 | testing-file-structure |
| aturan_testing.md | Dummy Data Usage | 4 | testing-dummy-data |
| optimasi_keamanan.md | Secure Storage | 1 | keamanan-secure-storage |
| optimasi_keamanan.md | SharedPreferences Restrictions | 2 | keamanan-sharedpreferences |
| optimasi_keamanan.md | Data Protection | 3 | keamanan-data-protection |
| optimasi_keamanan.md | Logout Cleanup | 4 | keamanan-logout-cleanup |
| optimasi_performa.md | Scroll Position & Keys | 1 | performa-scroll-keys |
| optimasi_performa.md | Heavy Work Off UI Thread | 2 | performa-heavy-work-isolate |
| optimasi_ui.md | Design Reference | 1 | (covered by spacing, tipografi, gaya) |
| optimasi_ui.md | Color/Theme Usage | 2 | (covered by gaya) |
| optimasi_ui.md | Text Overflow | 3 | (covered by tipografi) |
| optimasi_ui.md | Row/Column Spacing | 4 | (covered by spacing) |
| optimasi_ui.md | Typography | 5 | (covered by tipografi) |
| optimasi_ui.md | Confirm Dialog | 6 | (covered by adaptive_dialog-dialogs skill) |
| optimasi_ui.md | Heavy Work in Build | 7 | (covered by performa-heavy-work-isolate) |
| optimasi_ui.md | Bottom Sheet | 8 | (covered by pola-ux) |
| optimasi_ux.md | Delete Confirmation | 1 | (covered by pola-ux) |
| optimasi_ux.md | Formal Language | 2 | (not a separate skill needed) |
| optimasi_ux.md | Display Clarity | 3 | (not a separate skill needed) |
| optimasi_ux.md | Button Clarity | 4 | (not a separate skill needed) |
| optimasi_ux.md | Operation Status | 5 | (covered by pola-ux) |
| optimasi_ux.md | System Feedback | 6 | (covered by pola-ux) |
| optimasi_ux.md | Background Process | 7 | (covered by pola-ux) |
| optimasi_ux.md | Rebuild Optimization | 8 | (covered by pola-ux, riverpod-select) |
| optimasi_ux.md | Memory Leak Prevention | 9 | (covered by pola-ui timer isolation) |
| optimasi_ux.md | Screen Padding | 10 | (covered by spacing) |
| optimasi_ux.md | Spacing Consistency | 11 | (covered by spacing) |
| optimasi_ux.md | Loading & Action Lock | 12 | (covered by pola-ux, gaya) |
| optimasi_ux.md | Toast Standardization | 13 | (covered by pola-ux) |
| optimasi_ux.md | SafeArea | 14 | (covered by spacing, empty-state-daftar) |
| optimasi_ux.md | Touch Targets | 15 | (not a separate skill needed) |
| optimasi_ux.md | Modal/Bottom Sheet | 16 | (covered by pola-ux) |
| aturan_notifikasi.md | Notification Library | 1 | (covered by flutter-local-notifications-22-3-3) |
| aturan_notifikasi.md | Notification Scheduling | 2 | (covered by flutter-local-notifications-22-3-3) |
| aturan_notifikasi.md | Payload & Navigation | 3 | notifikasi-payload-navigasi |
| aturan_notifikasi.md | Notification ID Management | 4 | notifikasi-id-management |
| aturan_notifikasi.md | Permission Management | 5 | (covered by flutter-local-notifications-22-3-3, validasi-platform-izin) |
| aturan_notifikasi.md | Notification Icon | 6 | notifikasi-icon |
| aturan_pemanfaatan_sdk_dan_paket.md | Row/Column Spacing | 3.1 | (covered by spacing) |
| aturan_pemanfaatan_sdk_dan_paket.md | Collection sorted | 3.2 | collection-sorted |
| aturan_pemanfaatan_sdk_dan_paket.md | Collection firstWhereOrNull | 3.3 | collection-firstwhereornull |
| aturan_pemanfaatan_sdk_dan_paket.md | Collection maxBy | 3.4 | collection-maxby |
| aturan_pemanfaatan_sdk_dan_paket.md | CachedNetworkImage | 3.5 | cached-network-image |
| aturan_pemanfaatan_sdk_dan_paket.md | UUID | 4.1 | uuid-generation |
| aturan_pemanfaatan_sdk_dan_paket.md | URL Launcher | 4.2 | url-launcher |
| aturan_pemanfaatan_sdk_dan_paket.md | Timezone | 4.3 | timezone-initialization |
| aturan_pemanfaatan_sdk_dan_paket.md | Sqflite FFI | 4.4 | sqflite-ffi-init |
| aturan_pemanfaatan_sdk_dan_paket.md | Adaptive Dialog | 4.5 | adaptive-dialog-dialogs |
| optimasi_boilerplate.md | Freezed State/Model | 1 | (covered by model-state-freezed-abstract) |
| optimasi_boilerplate.md | Package Search | 2 | (process, not skill) |
| optimasi_boilerplate.md | Function Reuse | 3 | (covered by ekstraksi-perhitungan-turunan) |
| optimasi_boilerplate.md | Abstraction Principles | 4 | (not a separate skill) |
| optimasi_boilerplate.md | Built-in Features | 5 | (not a separate skill) |
| optimasi_boilerplate.md | Code Efficiency | 6 | (not a separate skill) |
| optimasi_boilerplate.md | SDK Features | 7 | (not a separate skill) |
| optimasi_boilerplate.md | Folder Structure | 8 | folder-struktur-notifier-provider |
| optimasi_boilerplate.md | Enum Label/Icon | 9 | enum-label-icon-extension |
| aturan_lainnya.md | Priority & Compliance | 1 | (not a separate skill) |
| aturan_lainnya.md | Design Reference | 2 | (covered by optimasi_ui) |
| aturan_lainnya.md | SDK/Dependency Reading | 3 | (process, not skill) |
| aturan_lainnya.md | Code Reading | 4 | (process, not skill) |
| aturan_lainnya.md | Skills Usage | 5 | (process, not skill) |
| aturan_lainnya.md | Dependency Install/Remove | 6 | dependency-management |
| aturan_lainnya.md | Code Editing Procedure | 7 | (process, not skill) |
| aturan_lainnya.md | Implementation Consistency | 8 | (covered by various) |
| aturan_lainnya.md | File/Search Tools | 9 | (process, not skill) |
| aturan_lainnya.md | Naming Conventions | 10 | penamaan-konvensi-indonesia-snakecase |
| aturan_lainnya.md | Documentation | 11 | dokumentasi-dart-doc |
| aturan_lainnya.md | Logging (P vs L) | 12 | (covered by logging-debug) |
| aturan_lainnya.md | Formatting & Analysis | 13 | formatting-analisis |
| aturan_lainnya.md | Git Operations | 14 | git-operations-readonly |
| aturan_lainnya.md | Asset Management | 15 | aset-management |
| aturan_lainnya.md | Fonts (Google Fonts) | 16 | google-fonts-usage |
| aturan_lainnya.md | Splash Screen | 17 | splash-screen-flutter-native-splash |
| aturan_lainnya.md | User Feedback (Toast) | 18 | (covered by pola-ux) |
| aturan_lainnya.md | UUID | 19 | (covered by uuid-generation) |
| aturan_lainnya.md | SharedPreferences | 20 | (covered by keamanan-sharedpreferences) |
| aturan_lainnya.md | Long Lists | 21 | (covered by performa-scroll-keys) |
| aturan_lainnya.md | Navigation (Nav helper) | 22 | navigasi-nav-helper |
| aturan_lainnya.md | Package Imports | 23 | import-package-format |
| aturan_lainnya.md | Date/Time Storage (UTC) | 24 | datetime-utc-storage |
| aturan_lainnya.md | Localization | 25 | lokalisasi-flutter |
| aturan_lainnya.md | Example Folder Usage | 26 | package-example-folder-usage |
| aturan_lainnya.md | Sqflite FFI Init | 27 | (covered by sqflite-ffi-init) |
| aturan_lainnya.md | Kilo Code Tools | 28 | (process, not skill) |
| aturan_lainnya.md | Rules Verification | 29 | (process, not skill) |
| aturan_lainnya.md | Workflow Stages | 30 | (process, not skill) |
| aturan_build.md | Build Restrictions | 1-5 | build-restrictions-ai |

### C. Skill yang Tumpang Tindih / Duplikat

| Skill Utama | Skill Tumpang Tindih | Topik Overlap | Rekomendasi |
|-------------|---------------------|---------------|-------------|
| bug-runtime | type-promotion-null-safety | Type promotion | Hapus dari bug-runtime, rujuk ke type-promotion-null-safety |
| bug-runtime | normalisasi-tanggal | Date normalization | Hapus dari bug-runtime, rujuk ke normalisasi-tanggal |
| bug-runtime | penanganan-asyncvalue-berkali | Multiple AsyncValue | Hapus dari bug-runtime, rujuk ke penanganan-asyncvalue-berkali |
| bug-runtime | penanganan-async-data-kosong | Async data handling | Hapus dari bug-runtime, rujuk ke penanganan-async-data-kosong |
| bug-runtime | validasi-form-sebelum-penyimpanan | Form validation | Hapus dari bug-runtime, rujuk ke validasi-form-sebelum-penyimpanan |
| bug-runtime | penanganan-error-unawaited | Unawaited error | Hapus dari bug-runtime, rujuk ke penanganan-error-unawaited |
| bug-runtime | validasi-platform-izin | Platform validation | Hapus dari bug-runtime, rujuk ke validasi-platform-izin |
| bug-runtime | exception-khusus-deteksi-error | Custom exceptions | Hapus dari bug-runtime, rujuk ke exception-khusus-deteksi-error |
| gaya | withvalues-opacity-warna | withValues opacity | Hapus withvalues-opacity-warna, gabung ke gaya |
| gaya | spacing | Spacing rules | Pisah: gaya untuk warna, spacing untuk jarak |
| pola-ui | isolasi-widget-timer | Timer isolation | Hapus dari pola-ui, rujuk ke isolasi-widget-timer |
| pola-ui | withvalues-opacity-warna | withValues | Hapus dari pola-ui, rujuk ke gaya |
| pola-ui | normalisasi-tanggal | Date normalization | Hapus dari pola-ui, rujuk ke normalisasi-tanggal |
| pola-ui | visualisasi-progres-impian | Progress visual | Hapus dari pola-ui, rujuk ke visualisasi-progres-impian |
| pola-ux | konfirmasi-sebelum-simpan | Confirm before save | Hapus dari pola-ux, rujuk ke konfirmasi-sebelum-simpan |
| pola-ux | empty-state-daftar | Empty state | Hapus dari pola-ux, rujuk ke empty-state-daftar |
| pola-ux | kartu-motivasi-pintasan-dashboard | Motivational cards | Hapus dari pola-ux, rujuk ke kartu-motivasi-pintasan-dashboard |
| pola-ux | visualisasi-progres-impian | Progress visualization | Hapus dari pola-ux, rujuk ke visualisasi-progres-impian |
| pola-ux | validasi-form-sebelum-penyimpanan | Form validation | Hapus dari pola-ux, rujuk ke validasi-form-sebelum-penyimpanan |
| pola-ux | penanganan-asyncvalue-berkali | Multiple AsyncValue | Hapus dari pola-ux, rujuk ke penanganan-asyncvalue-berkali |
| pola-ux | penanganan-async-data-kosong | Async data handling | Hapus dari pola-ux, rujuk ke penanganan-async-data-kosong |
| widget-custom | visualisasi-progres-impian | VisualTabunganImpian | Hapus dari widget-custom, rujuk ke visualisasi-progres-impian |
| widget-custom | isolasi-widget-timer | Timer widgets | Hapus dari widget-custom, rujuk ke isolasi-widget-timer |
| widget-custom | empty-state-daftar | Empty state widgets | Hapus dari widget-custom, rujuk ke empty-state-daftar |

### D. Masalah Frontmatter

| Skill | Masalah |
|-------|---------|
| bug-runtime | `kategori` di level atas, bukan di `metadata`; tidak ada `metadata` wrapper |
| isolasi-widget-timer | `kategori` di level atas, bukan di `metadata`; tidak ada `metadata` wrapper |
| pola-ui | `kategori` di level atas, bukan di `metadata`; tidak ada `metadata` wrapper |
| pola-ux | `model` salah ("models/gemini-3.1-pro-preview"); `kategori` di metadata tapi format berbeda |
| gaya | `kategori` di level atas, bukan di `metadata`; tidak ada `metadata` wrapper |

### E. Masalah Examples File Extension

| Skill | File Bermasalah | Harusnya |
|-------|----------------|----------|
| flutter-local-notifications-22-3-3 | `input-*.md`, `output-*.md` | `.dart` |
| gaya | `input-*.md`, `output-*.md` | `.dart` |
| pola-ui | `input-*.md`, `output-*.md` | `.dart` |
| widget-custom | `input-*.md`, `output-*.md` | `.dart` |
| spacing | `input-*.md`, `output-*.md` | `.dart` |
| tipografi | `input-*.md`, `output-*.md` | `.dart` |

### F. Skill Baru yang Perlu Dibuat (Prioritas Tinggi)

1. **riverpod-generator** - Riverpod generator usage
2. **riverpod-lifecycle** - keepAlive, auto-dispose
3. **riverpod-watch-patterns** - ref.watch patterns
4. **riverpod-read-patterns** - ref.read patterns
5. **riverpod-refresh** - ref.refresh usage
6. **riverpod-optimistic-update** - Optimistic update pattern
7. **riverpod-ondispose** - ref.onDispose cleanup
8. **riverpod-select** - select for rebuild limiting
9. **testing-mockito** - Mockito usage
10. **testing-file-structure** - Test file naming/structure
11. **testing-dummy-data** - Dummy data usage in tests
12. **keamanan-secure-storage** - flutter_secure_storage
13. **keamanan-sharedpreferences** - SharedPreferences restrictions
14. **keamanan-data-protection** - Clipboard/screenshot protection
15. **keamanan-logout-cleanup** - Logout data cleanup
16. **performa-scroll-keys** - Scroll position maintenance, stable keys
17. **performa-heavy-work-isolate** - compute/Isolate for heavy work
18. **notifikasi-payload-navigasi** - Notification payload & navigation
19. **notifikasi-id-management** - Notification ID management
20. **notifikasi-icon** - Notification icon configuration
21. **collection-sorted** - collection package sorted()
22. **collection-firstwhereornull** - collection package firstWhereOrNull()
23. **collection-maxby** - collection package maxBy()
24. **cached-network-image** - CachedNetworkImage usage
25. **uuid-generation** - UUID package usage
26. **url-launcher** - URL launcher patterns
27. **timezone-initialization** - Timezone database initialization
28. **sqflite-ffi-init** - Sqflite FFI initialization
29. **folder-struktur-notifier-provider** - Notifier/provider folder structure
30. **enum-label-icon-extension** - Enum label/icon extensions
31. **dependency-management** - flutter pub add/remove
32. **penamaan-konvensi-indonesia-snakecase** - Indonesian naming, snake_case files
33. **dokumentasi-dart-doc** - Dart doc comments
34. **formatting-analisis** - dart format + flutter analyze
35. **git-operations-readonly** - Git read-only operations
36. **aset-management** - Asset registration in pubspec
37. **google-fonts-usage** - Google Fonts package
38. **splash-screen-flutter-native-splash** - flutter_native_splash
39. **navigasi-nav-helper** - Nav helper usage
40. **import-package-format** - package: imports only
41. **datetime-utc-storage** - UTC date storage
42. **lokalisasi-flutter** - Flutter localization setup
43. **package-example-folder-usage** - Check package example folders
44. **build-restrictions-ai** - AI build restrictions
45. **dummy-helper-bersihkan-biodata** - Dummy helper cleanup (from aturan_khusus.md #4)
46. **dummy-screen-konfirmasi-ganti-biodata** - Dummy screen confirmation (from aturan_khusus.md #5)

## Tindakan yang Direkomendasikan

### Fase 1: Perbaikan Kritis (Wajib)
1. Fix frontmatter format pada 5 skill (bug-runtime, isolasi-widget-timer, pola-ui, pola-ux, gaya)
2. Fix examples file extensions pada 6 skill
3. Hapus duplikasi dari bug-runtime, pola-ui, pola-ux, widget-custom, gaya

### Fase 2: Penghapusan Duplikasi
1. bug-runtime → buat jadi skill indeks/ringkasan yang rujuk ke skill spesifik, HAPUS isi duplikat
2. pola-ui → hapus bagian timer, withValues, normalisasi, visualisasi; rujuk ke skill spesifik
3. pola-ux → hapus bagian confirm, empty state, kartu motivasi, visualisasi, form validation, async handling; rujuk ke skill spesifik
4. widget-custom → hapus bagian VisualTabunganImpian, timer widgets, empty state; rujuk ke skill spesifik
5. gaya → hapus withValues (sudah di withvalues-opacity-warna) atau gabungkan
6. withvalues-opacity-warna → bisa digabung ke gaya atau tetap terpisah tapi direferensikan

### Fase 3: Pembaruan Skill yang Ada
1. Update visualisasi-progres-impian dengan aturan terbaru dari aturan_khusus.md #19
2. Update kartu-motivasi-pintasan-dashboard dengan aturan terbaru
3. Update validasi-tapering dengan aturan terbaru
4. Update ekspor-pemulihan-cadangan dengan aturan terbaru
5. Update flutter-local-notifications-22-3-3 dengan aturan terbaru
6. Update zona-waktu-perangkat-pengingat dengan aturan terbaru
7. Update parsing-nullable-int dengan aturan terbaru
8. Update penamaan-konstanta-snake-case dengan aturan terbaru
9. Update migrasi-skema-sqlite dengan aturan terbaru
10. Update notifier-crud-database dengan aturan terbaru
11. Update model-state-freezed-abstract dengan aturan terbaru
12. Update type-promotion-null-safety dengan aturan terbaru (include import ordering)
13. Update validasi-form-sebelum-penyimpanan dengan aturan terbaru
14. Update konfirmasi-sebelum-simpan dengan aturan terbaru
15. Update empty-state-daftar dengan aturan terbaru
16. Update penanganan-async-data-kosong dengan aturan terbaru
17. Update penanganan-asyncvalue-berkali dengan aturan terbaru
18. Update penanganan-error-unawaited dengan aturan terbaru
19. Update exception-khusus-deteksi-error dengan aturan terbaru
20. Update logging-debug dengan aturan terbaru
21. Update normalisasi-tanggal dengan aturan terbaru
22. Update ekstraksi-perhitungan-turunan dengan aturan terbaru
23. Update import-ordering dengan aturan terbaru
24. Update isolasi-widget-timer dengan aturan terbaru
25. Update larangan-backup-task dengan aturan terbaru
26. Update spacing dengan aturan terbaru
27. Update tipografi dengan aturan terbaru

### Fase 4: Skill Baru untuk Aturan Global
Buat skill untuk aturan yang belum tertutup (prioritaskan Riverpod, Testing, Security, Performance, Notification details, Collection package, URL Launcher, UUID, Timezone, Sqflite FFI, Naming, Documentation, Formatting, Git, Assets, Fonts, Splash, Navigation, DateTime UTC, Localization, Package Examples, Build Restrictions)

### Fase 5: Skill Baru untuk Aturan Khusus Proyek
1. dummy-helper-bersihkan-biodata
2. dummy-screen-konfirmasi-ganti-biodata

### Fase 6: Verifikasi
1. Semua skill punya frontmatter benar
2. Semua skill punya examples/input-*.dart + output-*.dart
3. Semua skill punya referensi commit yang valid
4. Tidak ada duplikasi instruksi
5. git diff --check bersih