# iOS to Flutter Comparison

This repository hosts a small reference application implemented twice to compare SwiftUI and Flutter approaches side by side.

## Project Overview
- The original SwiftUI version lives under `iosSwiftUITest/Test/`, showcasing multiple interactive samples (forms, gradients, animations, lists, grids) built with native Apple tooling.
- The Flutter rewrite resides in `flutterProject/flutter_conversation_project/` and targets both iOS and Android while preserving feature parity with the SwiftUI source.
- Use the pair to study layout, state management, animation techniques, and component composition across the two ecosystems.

## Getting Started
1. Open `iosSwiftUITest/Test/Test.xcodeproj` in Xcode to explore or run the SwiftUI implementation on iOS simulators.
2. From `flutterProject/flutter_conversation_project/`, install dependencies and launch Flutter:
   ```sh
   flutter pub get
   flutter run -d ios   # or -d android
   ```
3. Compare behaviors, note platform nuances, and iterate on both codebases as needed.

## Notes
- The Flutter project uses Material 3 theming but mirrors SwiftUI layouts and copy for accurate comparisons.
- Keep any new assets in the Flutter app’s `assets/` folder and register them inside `pubspec.yaml`.
- When updating features, reflect changes in both implementations so the comparison stays relevant.
