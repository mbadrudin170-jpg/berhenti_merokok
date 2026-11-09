# Berhenti Merokok

Flutter app (Android-first, offline-first) for smoking-cessation tracking: biodata, smoke-free progress, reason-to-quit notes, dreams/goals, craving diary, health recovery milestones, badges, SOS craving, kalender smoke-free, daily local notifications.





## Commands

- Install: `flutter pub get`
- Analyze: `flutter analyze` (must be clean; no new warnings/errors)
- Format: `dart format <file>` (only changed Dart files)
- Codegen (Freezed/Riverpod): `dart run build_runner build --delete-conflicting-outputs` (after touching `.g.dart`/`.freezed.dart` sources)
- Tests: `flutter test` (no Android emulator; web only — web pass ≠ Android proof)
- Build APK: GitHub Actions only (`.github/workflows/build-apk.yml`); never run `flutter build apk` locally

## Architecture

- Single package. Entrypoints: `lib/main.dart` (DB + notifications init) → `lib/app.dart` (ProviderScope, MaterialApp, onboarding routing) → `lib/home.dart` (main tabs, lazy `IndexedStack`).
- Feature modules under `lib/fitur/<fitur>/` (model, enum, screens, state, notifier, helper/provider).
- Shared infra: `lib/shared/db/sqflite/`, `lib/shared/notifikasi/`, `lib/shared/konstanta/`, `lib/shared/utils/l.dart`.
- External sibling dependency `share_global_saya` (path `../share_global_saya`; cloned in CI via PAT). Provides `core_shared` (`Nav`, `AppToast`, `ParserUtil`, `FormatUang`, `FormatTanggal`, `L`, etc.).

## Key conventions (non-obvious)

- Logging: use `L` from `lib/shared/utils/l.dart` (`L.i/w/e/s`), never `print`/`debugPrint`. Before `L.init()` (in `lib/app.dart`), use `p` from `core_shared`.
- Navigation: use `Nav` from `core_shared`, never `Navigator.push/pop` directly.
- Imports: `package:` only, no relative imports; sort alphabetically by full path.
- Naming: Indonesian for app-defined identifiers; snake_case files.
- DB access: use `SqfliteOp`; never `openDatabase` directly in notifiers. Notifiers use `@Riverpod(keepAlive: true)` and `_ambilSemua()`.
- Freezed models/state use `abstract class`, not `class`.
- DB rows ↔ model via `fromSqflite`/`toSqflite`; parse `dynamic` via `ParserUtil`; store datetimes UTC, display local.
- DB schema changes: bump `_versiDatabase` (currently 8), update both `onCreate` and `onUpgrade` (`if (oldVersion < N)`); table/column names as constants in `NamaTabel`/`NamaKolom`.
- Generated files (`.g.dart`, `.freezed.dart`) are never edited by hand; change source + run build_runner.
- Tests live flat in `test/` (e.g. `test/notifikasi_service_test.dart`, `test/progres_milestone_helper_test.dart`); use mockito and dummy data from `lib/fitur/*/dummy_data/`. File name follows the feature/helper being tested, not a fixed `_state_test.dart` suffix.

## Gotchas

- `kIsWeb` → sqflite uses `databaseFactoryFfiWeb`; do not force FFI desktop factory on mobile.
- Notification scheduling unsupported on Web/Linux/Windows; handle `UnsupportedError` explicitly.
- `DateTime.now()` includes time; normalize to date-only before day math; clamp negative day counts to 0.
- Derived calculations (`hariBerhenti`/`rokokTidakDiHisap`/`uangDihemat`/`targetRokokHariIni`) live once in `BiodataModelPerhitungan` extension; consume getters, don't recompute inline.
- Impian "saldo terkumpul" comes from biodata (money saved), not `ImpianState.totalJumlah`; handle biodata loading/error → 0.
- Type promotion: copy nullable model fields to locals before null-checks; avoid `!`.
- Form validation must actually run (`Form` + `GlobalKey<FormState>` + `validate()`) before save; no `?? 0` masking invalid numeric input.
- Async screens: check `isLoading` then `hasError` before `requireValue`; early-return each state.
- Widget timers (`Timer.periodic`) must be isolated in small `StatefulWidget`s and cancelled in `dispose`.
- `AppToast` / `EasyLoading` / `Nav.to` called with `unawaited()` must include `.catchError(...)` logging via `L.e`.
- Do not call `AppToast` / `FToast().showToast` directly inside `build()` (throws `setState during build`); defer to `WidgetsBinding.instance.addPostFrameCallback`.

## Pre-flight (do this before any non-trivial change)

1. Read `.agents/rules/proyek/aturan_proyek.md` — it overrides `.agents/rules/global/` on conflict.
2. Check the sibling dep `share_global_saya` (path `../share_global_saya`) for `Nav`, `AppToast`, `ParserUtil`, `FormatTanggal`, `L` signatures before assuming APIs.
3. Confirm the current DB schema version in `lib/shared/db/sqflite/sqflite.dart` (`_versiDatabase`, currently **8**) before any schema change.
4. `flutter pub get` first — `share_global_saya` is a path dependency and must resolve.

## Codegen trigger rule

Run `dart run build_runner build --delete-conflicting-outputs` **whenever you touch a `.freezed.dart` or `.g.dart` source** (Freezed models/state, Riverpod providers/notifiers), not just when you notice a missing file. Editing generated files by hand is forbidden.

## Test reality

- `flutter test` runs on **web only** — no Android emulator locally. A green web run is **not** Android proof.
- Tests are flat under `test/`, named after the feature/helper (e.g. `test/notifikasi_service_test.dart`, `test/progres_milestone_helper_test.dart`), use `mockito`, and pull dummy data from `lib/fitur/*/dummy_data/`.
- `test/widget_test.dart` is a smoke test that builds `App` and looks for the text `'Home'` — it will fail on first run until onboarding/biodata state resolves; do not treat it as a regression oracle.

## Rules

Detailed rules live in `.agents/rules/global/` and `.agents/rules/proyek/` (registered in `~/.config/kilo/kilo.jsonc` `instructions`). Read those before non-trivial work; `aturan_proyek.md` overrides globals on conflict.

## Non-obvious wiring

- **Theme comes from `material_ui`, not Flutter's `ThemeData`.** `lib/app.dart` builds `mui.ThemeData.from(colorScheme: mui.ColorScheme.fromSeed(...))` and wraps the `MaterialApp` in `mui.Theme`. It also registers a custom `_MaterialUiLocalizationsDelegate` so `adaptive_dialog` gets a non-null `MaterialLocalizations` for locale `id` (the `material_ui` default only supports `en`). Don't replace this with plain `ThemeData` or `GlobalMaterialLocalizations` alone.
- **Logger split at `L.init()`.** `L.init(ref.container)` runs in `lib/app.dart` `initState()`. Code that executes before that (e.g. `lib/main.dart` DB/notification init) must use `p` from `core_shared`, not `L.*`.
- **`home` is wrapped in `PengelolaOverlayLogDebug`.** The root widget in `app.dart` is `PengelolaOverlayLogDebug(child: home)`, not `Scaffold` directly. Don't assume the widget tree starts at the tab `Scaffold`.
- **Onboarding is data-driven, not a separate route.** `app.dart` watches `biodataProvider`; loading → spinner, error → retry button, empty → `FormBiodata(buatPertama: true)`, present → `Home()`. There is no named `/onboarding` route to navigate to.
- **`share_global_saya` is a path dependency (`../share_global_saya`), cloned in CI via PAT.** `flutter pub get` must resolve it before anything else. `core_shared` exports `Nav`, `AppToast`, `ParserUtil`, `FormatUang`, `FormatTanggal`, `L`, `P`, `InputTeks`, etc.
- **`material_ui` and `uuid` are transitive deps used directly** (not declared in `pubspec.yaml`). Don't remove them; don't add a replacement for either.
