# Repository Guidelines

## Project Structure & Module Organization

This project follows **Clean Architecture** with four layers:

- `lib/core/` — Shared utilities, database helpers (`database_helper.dart`), error handling (`exceptions.dart`, `failures.dart`), and dependency injection (`injection_container.dart`).
- `lib/data/` — Data sources (`sources/contract.dart`, `quote_api_data_source.dart`), models (`quote_model.dart`), repository implementations (`quote_repository_impl.dart`), and services (`network_service.dart`, `sync_service.dart`).
- `lib/domain/` — Entities (`quote.dart`, `tag.dart`), repository interfaces (`quote_repository.dart`), and use cases (`show_quotes.dart`, `quote_update.dart`).
- `lib/presentation/` — Cubits (`quote_cubit.dart`, `theme_cubit.dart`), pages (`news_list_page.dart`), widgets (`news_card.dart`), and theme (`app_theme.dart`).

Assets live in `assets/` (e.g., `assets/dialoge_db.json`). Platform-specific code resides in `android/` and `web/`.

## Build, Test, and Development Commands

All commands are run from the project root:

| Command | Description |
|---|---|
| `flutter pub get` | Install dependencies |
| `flutter run` | Run the app (connected device/emulator) |
| `flutter analyze` | Run static analysis (lints) |
| `flutter build apk` | Build an Android APK |
| `flutter build web` | Build for the web |
| `dart run build_runner build` | Generate code (e.g., Drift, ObjectBox) |

## Coding Style & Naming Conventions

- **Indentation**: 2 spaces (Dart default).
- **Linting**: Rules from `package:flutter_lints/flutter.yaml` (configured in `analysis_options.yaml`).
- **Naming**:
  - Files: `snake_case` (e.g., `quote_repository_impl.dart`).
  - Classes/Enums: `PascalCase` (e.g., `QuoteRepositoryImpl`).
  - Variables/Functions/Parameters: `camelCase`.
  - Constants: `lowerCamelCase` (Dart convention).
- Run `flutter analyze` before committing to catch lint violations.

## Testing Guidelines

- **Framework**: `flutter_test` (built-in with Flutter SDK).
- Tests live in the `test/` directory mirroring `lib/` structure.
- Name test files `{feature}_test.dart` (e.g., `quote_repository_test.dart`).
- Run all tests: `flutter test`
- Run a single file: `flutter test test/path/to/file_test.dart`

## Commit & Pull Request Guidelines

- **Commit messages**: Use the imperative mood, capitalize the first word, and keep the subject under 72 characters (e.g., `Add quote sync service`, `Fix network error handling`).
- **Pull requests**: Include a clear description, link any related issues, and mention what was changed and why. For UI changes, attach screenshots or screen recordings.
