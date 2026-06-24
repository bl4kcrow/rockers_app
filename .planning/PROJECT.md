# Rockers App

## What This Is

A Flutter music app that streams YouTube videos through an inline player, organized into playlists with trending content discovery. Users browse playlists, watch music videos, and navigate between songs with autoplay.

## Core Value

Users can play music videos from curated playlists with continuous autoplay and minimal friction.

## Requirements

### Validated

- ✓ YouTube video playback with inline player — existing
- ✓ Play/pause/next/previous controls — existing
- ✓ Autoplay (continuous playback through playlist) — existing
- ✓ Firestore-backed playlist management — existing
- ✓ Trending songs view with position tracking — existing
- ✓ Video metadata display (views, duration) — existing
- ✓ Dark/light theme with persistence — existing
- ✓ GoRouter navigation — existing
- ✓ Firebase Remote Config for version gating — existing

### Active

- [ ] **DEP-01**: Upgrade youtube_player_iframe from 5.2.1 to 6.0.2
- [ ] **DEP-02**: Migrate YoutubePlayerScaffold to direct YoutubePlayer usage
- [ ] **DEP-03**: Verify fullscreen behavior works correctly post-migration
- [ ] **DEP-04**: Verify app compiles and runs without regressions

### Out of Scope

- Feature additions or UI changes — purely a dependency upgrade
- Android/iOS platform configuration changes — unless required by the upgrade
- Other dependency bumps — only youtube_player_iframe targeted

## Context

The app uses Clean Architecture (domain/data/presentation layers) with Riverpod state management. The youtube_player_iframe package is used across 5 files for video playback, thumbnail generation, video ID parsing, and custom controls. The upgrade from 5.x to 6.x removes `YoutubePlayerScaffold` (replaced by direct `YoutubePlayer` usage) and handles fullscreen internally.

## Constraints

- **Flutter SDK**: Must remain compatible with current Flutter version — v6 requires Flutter >=3.38.0 / Dart ^3.10.0
- **Stability**: The app must compile and all playback functionality must work after migration
- **Scope**: Only youtube_player_iframe is being upgraded — no other dependency changes

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Upgrade to 6.0.2 specifically | Latest patch for maximum stability | — Pending |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):
1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):
1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---
*Last updated: 2026-06-24 after initialization*
