# Berhenti Merokok

Flutter app (Android-first, offline-first) for smoking-cessation tracking: biodata, smoke-free progress, reason-to-quit notes, dreams/goals, craving diary, health recovery milestones, badges, SOS craving, kalender smoke-free, daily local notifications.

## Commands

- Install: `flutter pub get`
- Analyze: `flutter analyze`
- Format: `dart format <file>` (only changed Dart files)
- Codegen (Freezed/Riverpod): `dart run build_runner build --delete-conflicting-outputs`
- Tests: `flutter test` (no Android emulator available; web server only — do not treat web pass as Android proof)
- Build APK: GitHub Actions only (`.github/workflows/build-apk.yml`); never run `flutter build apk` locally

## Architecture

- Single package. Entrypoints: `lib/main.dart` (DB + notifications init) → `lib/app.dart` (ProviderScope, MaterialApp, onboarding routing).
- Feature modules under `lib/fitur/<fitur>/` (model, enum, screens, state, notifier, helper/provider).
- Shared infra: `lib/shared/db/sqflite/`, `lib/shared/notifikasi/`, `lib/shared/konstanta/`, `lib/shared/utils/l.dart`.
- External sibling dependency `share_global_saya` (path `../share_global_saya`); cloned in CI via PAT. Provides `core_shared` (Nav helper, AppToast, etc.).

## Key conventions (non-obvious)

- Logging: use `L` from `lib/shared/utils/l.dart` (`L.i/w/e/s`), never `print`/`debugPrint`. Before `L.init()` (in `lib/app.dart`), use `p` from `core_shared`.
- Navigation: use `Nav` from `core_shared`, never `Navigator.push/pop` directly.
- Imports: `package:` only, no relative imports; sort alphabetically by full path.
- Naming: Indonesian for app-defined identifiers; snake_case files.
- DB access: use `SqfliteOp`; never `openDatabase` directly in notifiers. Notifiers use `@Riverpod(keepAlive: true)` and `_ambilSemua()`.
- Freezed models/state use `abstract class`, not `class`.
- DB rows ↔ model via `fromSqflite`/`toSqflite`; parse `dynamic` via `ParserUtil`; store datetimes UTC, display local.
- DB schema changes: bump `_versiDatabase` (currently 7), update both `onCreate` and `onUpgrade` (`if (oldVersion < N)`); table/column names as constants in `NamaTabel`/`NamaKolom`.
- Generated files (`.g.dart`, `.freezed.dart`) are never edited by hand; change source + run build_runner.
- Tests live flat in `test/*_state_test.dart`; use mockito and dummy data from `lib/fitur/*/dummy_data/`.

## Gotchas

- `kIsWeb` → sqflite uses `databaseFactoryFfiWeb`; do not force FFI desktop factory on mobile.
- Notification scheduling unsupported on Web/Linux/Windows; handle `UnsupportedError` explicitly.
- `DateTime.now()` includes time; normalize to date-only before day math; clamp negative day counts to 0.
- Derived calculations (hariBerhenti/rokokTidakDiHisap/uangDihemat/targetRokokHariIni) live once in `BiodataModelPerhitungan` extension; consume getters, don't recompute inline.
- Impian "saldo terkumpul" comes from biodata (money saved), not `ImpianState.totalJumlah`; handle biodata loading/error → 0.
- Type promotion: copy nullable model fields to locals before null-checks; avoid `!`.
- Form validation must actually run (`Form` + `GlobalKey<FormState>` + `validate()`) before save; no `?? 0` masking invalid numeric input.
- Async screens: check `isLoading` then `hasError` before `requireValue`; early-return each state.
- Widget timers (`Timer.periodic`) must be isolated in small StatefulWidgets and cancelled in `dispose`.

## Rules

Detailed rules live in `.agents/rules/global/` and `.agents/rules/proyek/` (registered in `~/.config/kilo/kilo.jsonc` `instructions`). Read those before non-trivial work; `aturan_proyek.md` overrides globals on conflict.
