# Testing Patterns

**Analysis Date:** 2026-06-23

## Test Framework

**Runner:**
- `flutter_test` (built-in Flutter SDK test package, built on top of the Dart `test` package).
- Configured in `pubspec.yaml` under `dev_dependencies`.

**Assertion Library:**
- Flutter built-in assertion framework.
- Common matchers: `expect(value, expected)`, `throwsA(isA<Exception>())`, `findsOneWidget`, `findsNothing`, `findsNWidgets(n)`.

**Run Commands:**
```bash
flutter test                              # Run all tests
flutter test test/path_to_file_test.dart  # Run a single test file
flutter test --coverage                  # Generate coverage lcov report
```

## Test File Organization

**Location:**
- Test files must live in the `test/` directory at the project root.
- The folder structure in the `test/` directory should mirror the `lib/` directory structure.

**Naming:**
- All test files must end with the `_test.dart` suffix (e.g., `playlist_mapper_test.dart`).

**Structure:**
```
rockers_app/
├── lib/
│   ├── data/
│   │   └── mappers/
│   │       └── playlist_mapper.dart
│   └── domain/
│       └── entities/
│           └── song.dart
└── test/ (Currently empty)
    ├── data/
    │   └── mappers/
    │       └── playlist_mapper_test.dart
    └── domain/
        └── entities/
            └── song_test.dart
```

## Test Structure

**Suite Organization:**
```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlaylistMapper', () {
    setUp(() {
      // Shared setup before each test
    });

    tearDown(() {
      // Shared cleanup after each test
    });

    test('should map firestore model to domain entity', () {
      // arrange
      final rawModel = ...;

      // act
      final entity = PlaylistMapper.firestoreToEntity(rawModel);

      // assert
      expect(entity.id, equals(rawModel.id));
    });
  });
}
```

## Mocking

**Framework:**
- Recommendation: Use `mocktail` or `mockito` for mocking dependencies.
- To mock Riverpod provider values: Override them in the `ProviderScope` (for Widget/Screen tests) or inside a `ProviderContainer` (for Unit tests).

```dart
// Example of overriding a repository provider in widget testing
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      playlistRepositoryProvider.overrideWithValue(MockPlaylistRepository()),
    ],
    child: const MainApp(),
  ),
);
```

## Coverage

- Coverage reports are generated in LCOV format.
- Output location: `coverage/lcov.info`.
- Use HTML generation tools (like `genhtml` from the `lcov` package) to view visual coverage results:
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
# Open coverage/html/index.html in a browser
```

## Test Types

**Unit Tests:**
- Test pure Dart logic (mappers, entities, utility formatters).
- Mock all external datasources and API classes.

**Widget Tests:**
- Test individual UI elements and layout responsiveness.
- Use `WidgetTester` to pump the widget tree, trigger gestures (`tap`, `drag`), and verify elements on-screen.

**Integration/E2E Tests:**
- Uses the `integration_test` package to run tests on a real physical device or emulator.
- Test suites are located in `integration_test/` directory.

---

*Testing analysis: 2026-06-23*
*Update when test patterns change*
