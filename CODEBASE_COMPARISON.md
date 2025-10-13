# iOS SwiftUI vs Flutter (Cupertino) — Comparison Report

## High-Level Comparison

| Aspect | SwiftUI (iOS) | Flutter (Cupertino styling) |
|--------|---------------|-----------------------------|
| Feature coverage | Same five demos + tips sheet implemented natively. | Mirrors SwiftUI feature-for-feature using Cupertino widgets. |
| Navigation | `NavigationStack`, `NavigationLink`, value-based routing. | `CupertinoApp`, manual `CupertinoPageRoute` pushes. |
| State management | `@State`, `@Environment`, `@Binding`. | `StatefulWidget`, `setState`, widget-local controllers. |
| Layout/UI | Automatic native theming, typography, dynamic colors. | Requires manual theming helpers (`_resolveDynamic`) to match look. |
| Task list edit mode | `EditButton`, `onMove`, `onDelete`. | Custom logic with `ReorderableListView`, drag handles, delete actions. |
| Icons/assets | SF Symbols built-in. | Needs `cupertino_icons` package for proper glyphs. |

## Pros vs Cons

| Codebase | Pros | Cons |
|----------|------|------|
| SwiftUI | Native look & feel "for free"; concise declarative syntax; built-in previews; declarative list editing | iOS-only; Apple API coupling; advanced gestures may require UIKit bridging |
| Flutter | Cross-platform (iOS/Android) with Cupertino styling; explicit layout/animation control; strong localization support; reusable widgets | More boilerplate to replicate native behaviour; manual theming/dynamic color; Cupertino package lacks some built-ins; extra polish needed for native feel |

## Key Technical Differences

| Topic | SwiftUI | Flutter |
|-------|---------|---------|
| State idiom | Declarative data flow (`@State`, `@Binding`) | Imperative updates via `setState` |
| Edit flows | First-class (`EditButton`) | Rebuilt manually with reorderable list and delete controls |
| Theming | System colors/typography automatic | `_resolveDynamic` helper required for dynamic color parity |
| Portability | iOS-only | Shared UI for iOS + Android |

## Developer & AI Agent Perspective

| Perspective | SwiftUI Highlights | Flutter Highlights | Challenges |
|-------------|-------------------|--------------------|------------|
| Human developers | Fast iteration with previews; concise modifiers; native accessibility defaults | Single codebase; explicit control for custom UX; broad widget ecosystem | SwiftUI: platform lock-in, advanced data flow learning curve. Flutter: more boilerplate, manual parity tuning. |
| AI agents / tooling | Stable modifier chains and fewer files ease automated edits | Explicit widget trees/states simplify deterministic changes | SwiftUI: implicit behaviours/property wrappers harder to infer. Flutter: verbose layout/theming needs context awareness. |
| AI agent file workflow preference | Xcode-friendly single target (`ContentView.swift`) with previews; minimal touching of multiple modules | Centralized `lib/main.dart` keeps edits localized; cross-platform runners updated automatically | SwiftUI: previews not executable in headless CI; Cupertino Flutter: larger single file can grow unwieldy without modularization. |

## Agent Maintenance Preference

| Criteria | Preferred Stack | Rationale |
|----------|----------------|-----------|
| Day-to-day edits | **Flutter (Cupertino)** | Most behaviours consolidated in `lib/main.dart`, reducing file hunts; explicit widget trees make automated reasoning predictable; cross-platform builds re-use the same patches. |
| Long-term maintainability | **SwiftUI** for small feature sets; **Flutter** for multi-platform | SwiftUI’s concise syntax keeps diffs small when scope stays focused on iOS. For broader teams or shared releases, Flutter’s single codebase wins despite extra boilerplate. |
| Risk of regression for AI changes | Slightly higher in SwiftUI due to implicit environment/state; manageable in Flutter with explicit props/state. | |
