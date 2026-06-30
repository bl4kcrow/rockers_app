# Architecture

**Analysis Date:** 2026-06-23

## Pattern Overview

**Overall:** Clean Architecture in Flutter with Riverpod State Management

**Key Characteristics:**
- **Strict Separation of Concerns:** Divided into `config`, `domain`, `data`, and `presentation` layers.
- **Unidirectional Data Flow:** UI triggers actions on state providers -> providers call repositories -> repositories fetch from datasources -> domain entities returned up -> UI updates.
- **State Management:** Declarative, reactive UI using Flutter Riverpod (Notifiers and AsyncNotifiers).
- **Decoupled Data Source:** Firestore database logic is abstracted behind repository interfaces, facilitating mock implementations.

## Layers

**Config Layer (`lib/config/`):**
- Purpose: Application routing, design tokens (themes/styles), constants, and env configuration.
- Contains: `app_router.dart`, `app_colors.dart`, `app_theme.dart`, `environment.dart`, `app_constants.dart`.
- Depends on: None.
- Used by: All layers (mainly `presentation` and entry points).

**Domain Layer (`lib/domain/`):**
- Purpose: Core enterprise/business logic, entities, and repository contracts.
- Contains:
  - Entities (e.g., [Song](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/entities/song.dart), [Playlist](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/entities/playlist.dart)).
  - Abstract contracts (e.g., [PlaylistRepository](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/repositories/playlist_repository.dart), [PlaylistDatasource](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/datasources/playlist_datasource.dart)).
- Depends on: None (strictly decoupled from Flutter and framework dependencies).
- Used by: `data` layer (implements contracts) and `presentation` layer (reads entities).

**Data Layer (`lib/data/`):**
- Purpose: Technical data access implementations.
- Contains:
  - Models: Specialized JSON/Firestore serialization mappings (e.g., `firestore_playlist_model.dart`).
  - Mappers: Maps data models to pure domain entities (e.g., `playlist_mapper.dart`).
  - Datasources: Queries external APIs/databases (e.g., [FirestorePlaylistDatasource](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/data/datasources/firestore_playlist_datasource.dart)).
  - Repositories: Implements the domain contracts using the datasources (e.g., `playlist_repository_impl.dart`).
- Depends on: `domain` layer.
- Used by: `presentation` layer (via Riverpod providers).

**Presentation Layer (`lib/presentation/`):**
- Purpose: User Interface widgets, views, screens, and view-state management.
- Contains:
  - Screens: Full-screen container pages (e.g., [HomeScreen](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/screens/home_screen.dart)).
  - Views: Screen contents corresponding to tabs (e.g., [TrendingView](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/views/trending_view.dart)).
  - Widgets: Reusable visual elements (e.g., [VideoCard](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/widgets/video_card.dart)).
  - Providers: State managers that drive the UI (e.g., [AutoplayProvider](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/providers/autoplay_provider.dart), [VideoPlayerProvider](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/providers/video_player_provider.dart)).
- Depends on: `domain` layer (entities/repos) and `config` layer.
- Used by: The framework to render the screen.

## Data Flow

**Typical Flow (Fetching Trending Songs):**
1. [TrendingView](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/views/trending_view.dart) watches `trendingProvider`.
2. `trendingProvider` reads `trendingRepositoryProvider` and calls `initialLoad()`.
3. `TrendingRepositoryImpl` calls `FirestoreTrendingDatasource.initialLoad()`.
4. `FirestoreTrendingDatasource` fetches document snapshots from Cloud Firestore `trending` collection.
5. Snapshots are parsed into `FirestoreTrendingModel`, then mapped to `Trending` (domain entity) via `TrendingMapper`.
6. Repositories return the list of `Trending` domain entities to the provider.
7. `trendingProvider` updates its state, causing [TrendingView](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/views/trending_view.dart) to rebuild and render the list.

**State Management:**
- Autoplay, theme selection, and current active song are managed reactively via Riverpod StateProviders and Notifiers.
- Asynchronous data loads (version check, playlists, trending songs, and YouTube video metadata) are managed via Riverpod `AsyncNotifier` and `FutureProvider`.

## Key Abstractions

**Repository Implementation:**
- Purpose: Provide clean data fetching APIs while masking data origin details (Firestore vs mock).
- Examples: `lib/data/repositories/playlist_repository_impl.dart`.
- Pattern: Repository Pattern.

**Mapper:**
- Purpose: Map external database structures (Firestore map objects) to business entity models.
- Examples: `lib/data/mappers/playlist_mapper.dart`.
- Pattern: Data Mapper.

**AsyncNotifier:**
- Purpose: Handle async operations and keep state loaded, loading, or errored.
- Examples: `lib/presentation/providers/app_versioning_provider.dart`, `lib/presentation/providers/trending_provider.dart`.
- Pattern: State Notifier.

## Entry Points

**Production Entry:**
- Location: [lib/main.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/main.dart)
- Triggers: Flutter app launching in release mode.
- Responsibilities: Pre-initializes WidgetsBinding, loads `.env` variables, initializes production Firebase instance, overrides `sharedPreferencesProvider` with instance, and runs `MainApp`.

**Development Entry:**
- Location: [lib/main_dev.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/main_dev.dart)
- Triggers: Flutter app launching in development mode.
- Responsibilities: Pre-initializes WidgetsBinding, loads `.env`, initializes dev Firebase instance, and runs `MainApp` with dev title.

## Error Handling

**Strategy:** Exception catching at datasource and repository boundaries, converting them into empty lists or passing error states up to Riverpod `AsyncValue.error` which is visually handled in the UI with error cards or fallback messages.

**Patterns:**
- Try/catch blocks around Firestore and YouTube requests.
- Riverpod's `AsyncValue` pattern `when(data: ..., error: ..., loading: ...)` is extensively used in views to display loading indicators or generic error screens.

## Cross-Cutting Concerns

**Environment Configuration:**
- Managed through the `Environment` class and `.env` files. Ensures separate API keys and app identifiers are used for dev and production.

**Persistence:**
- Shared Preferences stores key-value pairs (`sharedDarkModeKey`, `sharedAutoplayKey`) locally so users preserve their preferences between sessions.

---

*Architecture analysis: 2026-06-23*
*Update when major patterns change*
