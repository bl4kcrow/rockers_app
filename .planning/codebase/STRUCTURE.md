# Codebase Structure

**Analysis Date:** 2026-06-23

## Directory Layout

```
rockers_app/
├── android/                   # Native Android host configuration and runner
├── assets/                    # Static assets used by the app
│   ├── fonts/                 # Custom application fonts (Kollektif, ManoNegra)
│   └── images/                # Asset images and splash screen icons
├── ios/                       # Native iOS host configuration and runner
├── lib/                       # Primary Flutter application code
│   ├── config/                # Global config, router, constants, and themes
│   │   ├── constants/         # Fixed sizes, labels, and environment settings
│   │   ├── routes/            # GoRouter configurations and route paths
│   │   ├── theme/             # Light/dark app theme configurations and colors
│   │   ├── utils/             # App update state and duration formatting helpers
│   │   └── widgets/           # Global core layout widgets (navigation bar)
│   ├── data/                  # Data layer: Models, mappers, datasource/repository implementations
│   │   ├── datasources/       # Concrete network & database query integrations
│   │   ├── mappers/           # Translators between data models and domain entities
│   │   ├── models/            # Serialization blueprints for Firestore data
│   │   └── repositories/      # Repository interface implementations
│   ├── domain/                # Domain layer: Contracts (interfaces) and pure entities
│   │   ├── datasources/       # Abstract contracts defining datasource methods
│   │   ├── entities/          # Pure data models representing business objects
│   │   └── repositories/      # Abstract contracts defining repository methods
│   └── presentation/          # Presentation layer: UI layout and state management
│       ├── providers/         # Riverpod Notifiers and state managers
│       ├── screens/           # Main application screens (Home, Playback)
│       ├── views/             # Tab interface fragments (Trending, Playlists)
│       └── widgets/           # Specialized UI components and view templates
├── web/                       # Web compilation assets and wrapper
├── pubspec.yaml               # Package definition and dependencies list
└── .env                       # Local configurations and secret keys (gitignored)
```

## Directory Purposes

**lib/config/**
- Purpose: Application routing, design tokens (themes, colors, styles), constants, and env configuration.
- Contains: Configuration classes and theme helpers.
- Key files: [app_router.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/config/routes/app_router.dart), [app_theme.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/config/theme/app_theme.dart), [environment.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/config/constants/environment.dart).

**lib/domain/**
- Purpose: Defines pure business definitions and system blueprint abstractions. Completely detached from Flutter and third-party UI packages.
- Contains: Domain entity classes and abstract definitions for repositories.
- Key files: [song.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/entities/song.dart), [playlist.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/entities/playlist.dart).

**lib/data/**
- Purpose: Technical implementations for databases, API networking, and data formatting.
- Contains: Model classes, mappers, datasource implementations, and repository implementations.
- Key files: [firestore_playlist_datasource.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/data/datasources/firestore_playlist_datasource.dart), [playlist_mapper.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/data/mappers/playlist_mapper.dart).

**lib/presentation/**
- Purpose: Interface definitions, widgets, screens, tab views, and UI state notifications.
- Contains: View widgets, screens, and Riverpod provider classes.
- Key files: [video_playback_screen.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/screens/video_playback_screen.dart), [home_screen.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/screens/home_screen.dart), [video_player_provider.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/providers/video_player_provider.dart).

## Key File Locations

**Entry Points:**
- `lib/main.dart` - Application startup entry point using production configurations.
- `lib/main_dev.dart` - Application startup entry point using development configurations.

**Configuration:**
- `pubspec.yaml` - Dependencies, font family assets, and image paths declarations.
- `.env` - Development and production Firebase credential values.

**Core Logic:**
- `lib/domain/entities/` - Defines core structures like Song, Playlist, and Trending.

**Testing:**
- (No test files currently present. Standard folder path `test/` will contain them).

## Naming Conventions

**Files:**
- `snake_case.dart` - Standard for all files (e.g., `home_screen.dart`, `app_router.dart`).

**Directories:**
- `snake_case` - Standard for all directories (e.g., `datasources`, `presentation`).

**Classes and Types:**
- `PascalCase` - Standard for all class declarations (e.g., `VideoPlaybackScreen`, `FirestorePlaylistDatasource`).
- Repository interface names: `<Name>Repository` (e.g., `PlaylistRepository`).
- Repository implementation names: `<Name>RepositoryImpl` (e.g., `PlaylistRepositoryImpl`).
- Provider names: camelCase naming ending with `Provider` suffix (e.g., `videoPlayerProvider`).

## Where to Add New Code

**New Feature or Entity:**
1. Define the domain entity data structure in `lib/domain/entities/`.
2. Define abstract Repository and Datasource interfaces in `lib/domain/repositories/` and `lib/domain/datasources/`.
3. Create the data deserialization model class in `lib/data/models/`.
4. Create a mapper class in `lib/data/mappers/` to map models to entities.
5. Create concrete datasource query classes in `lib/data/datasources/`.
6. Implement the repository contract in `lib/data/repositories/`.
7. Register the repository and datasource via Riverpod providers in `lib/presentation/providers/`.
8. Create presentation views and widgets in `lib/presentation/views/` or `lib/presentation/widgets/`.

**New Screen:**
- Build screen UI in `lib/presentation/screens/`.
- Add router routes to `lib/config/routes/routes.dart` and `lib/config/routes/app_router.dart`.

---

*Structure analysis: 2026-06-23*
*Update when directory structure changes*
