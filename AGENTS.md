# Repository Guidelines

## Project Structure & Module Organization
- Flutter source lives in `flutterProject/flutter_conversation_project/`; primary UI logic is in `lib/main.dart`, with platform runners under `android/` and `ios/`.
- Place new Flutter tests in `flutterProject/flutter_conversation_project/test/` using mirrored directory names from `lib/` (e.g., `lib/features/tasks/` → `test/features/tasks/`).
- The legacy SwiftUI reference remains in `iosSwiftUITest/Test/`. Use it only for parity checks; no new development should land there.
- Store shared design assets in `flutterProject/flutter_conversation_project/assets/` and register paths in `pubspec.yaml`.

## Build, Test, and Development Commands
- `flutter pub get` — install or update Dart dependencies defined in `pubspec.yaml`.
- `flutter run -d <device>` — launch the Flutter app on iOS (`ios`), Android (`android`), or desktop simulators.
- `flutter analyze` — static analysis; fix every reported issue before opening a PR.
- `flutter test` — execute automated unit/widget tests in the `test/` tree.

## Coding Style & Naming Conventions
- Use Dart’s default formatting (`dart format .` or rely on `flutter format`); commit only formatted code.
- Follow Material 3 widgets and theming already established in `lib/main.dart`; prefer composition over deep inheritance.
- Name classes and enums in `UpperCamelCase`, functions and local variables in `lowerCamelCase`, files in `snake_case.dart`.
- Keep widget build methods concise; extract helpers into private widgets or functions when they exceed ~80 lines.

## Testing Guidelines
- Write widget tests with `testWidgets` for every interactive screen; mock platform channels with `MethodChannel` test bindings when needed.
- Naming: align test file names with the source file (`samples_home_page_test.dart` for `samples_home_page.dart`).
- Aim for meaningful assertions (UI state, navigation, animations); avoid snapshot-only tests.
- Run `flutter test --coverage` before merging major features and ensure coverage does not regress.

## Commit & Pull Request Guidelines
- Use concise, imperative commit messages (`Add task list swipe handling`). Group related changes in a single commit when practical.
- PRs must include: problem summary, implementation notes, testing evidence (`flutter analyze`, `flutter test`), and screenshots for UI updates.
- Reference related issues with `Fixes #ID` when applicable, and call out follow-up work in a checklist or bullet list.
