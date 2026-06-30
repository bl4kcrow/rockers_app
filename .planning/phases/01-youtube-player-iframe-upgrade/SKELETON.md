# Walking Skeleton — Rockers App

**Phase:** 1
**Generated:** 2026-06-24
**Context:** This is an existing Flutter application (not a new scaffold). This document records the existing architectural decisions that all subsequent phases will build on, following the Walking Skeleton convention for MVP phases.

## Capability Proven End-to-End

A user can browse curated music video playlists, play any video with full YouTube iframe controls, and enjoy continuous autoplay through the playlist. The app persists the user's playlist selection and autoplay preference across sessions.

## Architectural Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Framework | Flutter 3.44+ with Dart 3.12+ | Cross-platform mobile app with single codebase. SDK constraint `>=3.0.5 <4.0.0` but actual lockfile resolves to >=3.44.0. |
| State Management | Riverpod 2.6.1 (`flutter_riverpod`) | Chosen over Provider/Bloc for compile-time safety, testability, and no `BuildContext` dependency for logic. Uses `Provider`, `ConsumerWidget`, `ConsumerStatefulWidget` patterns. |
| Navigation | go_router 14.8.1 | Declarative routing with deep linking support. Replaces imperative Navigator. |
| Video Playback | youtube_player_iframe 5.2.1 → 6.0.2 (this phase) | YouTube video playback via iframe API. Handles player controls, fullscreen, lifecycle. Migration to v6 in progress this phase. |
| YouTube Metadata | youtube_explode_dart 2.3.10 | Fetches video metadata (title, thumbnail, duration) outside the player. Separates data from playback. |
| Backend / Data | Firebase (Cloud Firestore, Remote Config, Firebase Core) | Firestore for playlist data and trending content. Remote Config for feature flags. No custom backend server. |
| Architecture | Clean Architecture (data/domain/presentation layers) | Separation of concerns: `data/` (datasources, repositories), `domain/` (entities), `presentation/` (providers, screens, widgets, views). Barrel export files at each layer. |
| Code Organization | Feature-agnostic by layer | Not feature-folders — files grouped by architectural layer then by type. `presentation/screens/`, `presentation/widgets/`, `presentation/providers/`, etc. |
| Configuration | flutter_dotenv + compile-time constants | `.env` file for secrets (loaded at runtime). `config/` directory for app constants, theme, routes. |
| Persistence | shared_preferences 2.5.2 | Local key-value storage for user preferences (autoplay toggle, last playlist). |
| Sharing | share_plus 10.1.4 | Native share sheet for sharing song URLs. |
| Semantic Labels | Custom `SemanticLabels` constants | Accessibility via explicit semantic labels on icons and interactive elements. |

## Stack Touched in Phase 1

- [x] Project scaffold (Flutter framework, build via `flutter build`, lint via `flutter analyze`) — **existing, unchanged**
- [ ] Routing — at least one real route — **existing, unchanged**
- [x] YouTube player integration — **being upgraded from v5 to v6**
- [x] Video playback UI — **being migrated from YoutubePlayerScaffold to direct YoutubePlayer**
- [x] Build — `flutter analyze` passes with 0 errors — **verified this phase**

## Out of Scope (Deferred to Later Slices)

- Authentication / user accounts (app currently uses Firebase anonymously or no-auth mode)
- Server-side backend (all data from Firebase directly)
- Push notifications
- Offline playback / download
- User-created playlists (curated playlists from Firestore only)
- Search functionality
- Social features (comments, likes)

## Subsequent Slice Plan

Each later phase adds one vertical slice on top of this skeleton without altering its architectural decisions:

- Phase 2: TBD — feature additions or other dependency upgrades
- Phase 3: TBD
