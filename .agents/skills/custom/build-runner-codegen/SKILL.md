---
name: build-runner-codegen
description: Build runner dan code generation - freezed, riverpod generator, build_runner commands, watch mode, delete-conflicting-outputs, generated files jangan diedit manual.
metadata:
  kategori: "custom"
  versi: "1.0.0"
  commit-terakhir: "3b67d3095dacc4e5c7ea78d7eb251809e3e9d981"
  model: "kilo-auto/free"
---

# Build Runner & Code Generation

Skill ini mendokumentasikan penggunaan `build_runner` untuk code generation (Freezed, Riverpod, JSON serializable, Mockito).

## 1. Kapan Harus Jalankan build_runner

### Wajib jalankan setelah:
- Ubah/tambah model **Freezed** (file `.freezed.dart` / `.g.dart`)
- Ubah/tambah **Riverpod Notifier** (`@riverpod` / `@Riverpod` → `.g.dart`)
- Ubah/tambah **Mockito** `@GenerateMocks`
- Ubah/tambah **JSON Serializable** `@JsonSerializable`
- Pull branch yang ada perubahan generated files

## 2. Command Standar

```bash
# Build sekali (clean rebuild)
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto rebuild saat file berubah) - untuk development
dart run build_runner watch --delete-conflicting-outputs
```

### Flag `--delete-conflicting-outputs`
- **WAJIB** dipakai untuk menghindari error "conflicting outputs" saat file generated sudah ada tapi beda hash.
- Tanpa flag ini, build_runner akan error jika file generated sudah ada dan beda.

## 3. File Generated - JANGAN DIEDIT MANUAL

### Pola nama file generated:
| Source | Generated |
|--------|-----------|
| `model.freezed.dart` | `model.freezed.dart`, `model.g.dart` |
| `@riverpod` class | `provider.g.dart` |
| `@GenerateMocks` | `mocks.mocks.dart` |
| `@JsonSerializable` | `model.g.dart` |

### Aturan
- **DILARANG** edit file `.g.dart` / `.freezed.dart` / `.mocks.dart` manual.
- Perubahan **HANYA** di source (`.dart` biasa), lalu jalankan `build_runner`.
- Jika conflict, hapus file generated lalu `build_runner build --delete-conflicting-outputs`.

## 4. Konfigurasi build.yaml

File `build.yaml` di root project mengatur builder options:

```yaml
targets:
  $default:
    builders:
      freezed:
        options:
          freezed:
            # Opsi freezed
      riverpod_generator:
        options:
          riverpod_generator:
            # Opsi riverpod
```

### Referensi Commit
- `3b67d309` — Freezed models + Riverpod generator setup

## 5. Troubleshooting Umum

### "Conflicting outputs"
```bash
# Hapus generated files lalu rebuild
rm -f lib/**/*.g.dart lib/**/*.freezed.dart test/**/*.mocks.dart
dart run build_runner build --delete-conflicting-outputs
```

### "Invalid constant" / "Constant evaluation error"
- Pastikan Freezed constructor pakai `const` dan field final.
- Cek import cycle (generated file import source yang import generated).

### Riverpod generator not generating
- Pastikan `@riverpod` / `@Riverpod` di class, bukan di method.
- Class harus `extends _$ClassName` (generated).
- Jalankan `build_runner` setelah save file.

### Freezed: "The getter 'valueOrNull' isn't defined"
- Pastikan model pakai `abstract class` dengan Freezed union/sealed.
- `AsyncValue` Riverpod sudah punya `valueOrNull` (bukan Freezed).

## 6. CI/CD Integration

GitHub Actions (`.github/workflows/build-apk.yml`) otomatis jalanin:
```yaml
- name: Generate code
  run: dart run build_runner build --delete-conflicting-outputs
```

Local development: gunakan `watch` mode agar otomatis regenerate.

## 7. Larangan

- **DILARANG** commit file generated tanpa source changes (review diff).
- **DILARANG** edit `.g.dart` / `.freezed.dart` manual.
- **DILARANG** `build_runner` tanpa `--delete-conflicting-outputs` (kecuali clean build pertama).
- **DILARANG** ignore generated files di `.gitignore` (harus di-commit untuk CI).

## Referensi Aturan Sumber

- `aturan_bersama.md` — Generated files never edited by hand, change source + run build_runner
- `model-state-freezed-abstract` skill — Freezed abstract class pattern

## Referensi Commit Terkait

- `3b67d309` — Setup Freezed + Riverpod generator
- `be04199e` — Mockito generate mocks