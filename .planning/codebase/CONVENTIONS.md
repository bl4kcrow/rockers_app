# Coding Conventions

**Analysis Date:** 2026-06-23

## Naming Patterns

**Files:**
- `snake_case.dart` for all Dart source files (e.g., `app_router.dart`, `home_screen.dart`).
- Other config files follow system defaults (e.g., `pubspec.yaml`, `analysis_options.yaml`).

**Classes and Types:**
- `PascalCase` for all classes, mixins, and extension names (e.g., `VideoPlaybackScreen`, `AutoplayNotifier`).
- Interfaces/abstract definitions: PascalCase (e.g., `AuthDatasource`, `PlaylistRepository`).
- Implementations: PascalCase ending in `Impl` (e.g., `PlaylistRepositoryImpl`).

**Functions and Methods:**
- `camelCase` for all functions and method names (e.g., `initialize()`, `fetchVideoMetaData()`).
- Getters/setters: camelCase.
- Event handlers or callbacks: prefix with descriptive verb or `on` (e.g., `onPopInvokedWithResult`).

**Variables and Constants:**
- `camelCase` for variables, properties, and parameters (e.g., `pageIndex`, `videoPlayer`).
- Private variables and fields: prefix with a single underscore (e.g., `_lastDocumentSnapshot`, `_VideoPlaybackScreenState`).
- Constants: camelCase (e.g., `static const String autoplayLabel` in `AppConstants`).

## Code Style

**Formatting:**
- Dart Formatter (`dart format`) is used to enforce standard styles:
  - 2-space indentation.
  - Semicolons are required at the end of statements.
  - Trailing commas are highly recommended for lists, parameter lists, and arguments to improve formatting readability.
  - Standard maximum line length is 80 characters (default for `dart format`).
  - Single quotes preferred for string literals, unless the string contains single quotes or is a multi-line raw string.

**Linting:**
- Configured via `analysis_options.yaml` in the project root.
- Extends standard `package:flutter_lints/flutter.yaml`.
- Lint rules are enforced at compile time and warning/error levels in the IDE.

## Import Organization

**Order:**
1. Dart SDK imports (e.g., `import 'dart:async';`).
2. Flutter framework imports (e.g., `import 'package:flutter/material.dart';`).
3. External packages/plugins (e.g., `import 'package:flutter_riverpod/flutter_riverpod.dart';`).
4. Project package-relative imports (e.g., `import 'package:rockers_app/config/config.dart';`).
5. Project relative-path imports (e.g., `import '../utils/format_duration.dart';`).

**Grouping:**
- Keep imports clean by using barrel files (e.g., `config.dart`, `data.dart`, `domain.dart`, `presentation.dart`) to export entire directories, avoiding excessive individual imports at the top of files.

## Error Handling

**Patterns:**
- Try-catch blocks are wrapping external calls (such as Firebase query operations or YouTube API scrapes).
- Use of Riverpod's `AsyncValue` to model state (Data, Loading, Error) at the presentation layer.
- Fallback default values are returned in repository catch blocks to prevent crashes if Firestore is offline.
- Early returns are preferred in methods using guard clauses.

```dart
// Example of error catching in async providers
Future<void> fetchVideoMetaData(String videoId) async {
  try {
    final youtubeExplode = YoutubeExplode();
    final videoExplode = await youtubeExplode.videos.get(videoId);
    youtubeExplode.close();
    
    state = AsyncValue.data(VideoMetaData(
      views: videoExplode.engagement.viewCount,
      duration: videoExplode.duration ?? Duration.zero,
      description: videoExplode.description,
    ));
  } catch (error, stackTrace) {
    state = AsyncValue.error(error, stackTrace);
  }
}
```

## UI and Widget Design

**Widget Types:**
- Stateless UI parts: Inherit from `StatelessWidget` or `ConsumerWidget`.
- Stateful UI parts: Inherit from `StatefulWidget` or `ConsumerStatefulWidget`.
- Const Constructors: Apply `const` to all widget instantiation and constructors where possible to optimize Flutter rendering performance.

---

*Convention analysis: 2026-06-23*
*Update when patterns change*
