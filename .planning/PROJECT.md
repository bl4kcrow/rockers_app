# Rockers App

## What This Is

A Flutter music app that streams YouTube videos through an inline player, organized into playlists with trending content discovery. Users browse playlists, watch music videos, and navigate between songs with autoplay. youtube_player_iframe upgraded from 5.2.1 to 6.0.2 with full compatibility verified.

## Core Value

Users can play music videos from curated playlists with continuous autoplay and minimal friction.

## Current State

**Shipped:** v1.0 — youtube_player_iframe Upgrade (2026-06-24)
**Phases:** 1 completed
**Plans:** 1 completed
**Files:** 9 modified (+761/-26)
**Tech stack:** Flutter, youtube_player_iframe ^6.0.2

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
- ✓ **DEP-01**: Upgrade youtube_player_iframe from 5.2.1 to 6.0.2 — v1.0
- ✓ **DEP-02**: Migrate YoutubePlayerScaffold to direct YoutubePlayer usage — v1.0
- ✓ **DEP-03**: Remove deprecated fullscreen options — v1.0
- ✓ **DEP-04**: Verify controller params v6-compatible — v1.0
- ✓ **DEP-05**: Verify value builder, thumbnails, ID conversion, fullscreen toggle — v1.0
- ✓ **DEP-06**: flutter analyze passes with 0 issues — v1.0
- ✓ **DEP-07**: Video playback, controls, autoplay, fullscreen verified on device — v1.0

### Active

*None — next milestone requirements not yet defined.*

### Out of Scope

- Feature additions or UI changes — purely a dependency upgrade
- Android/iOS platform configuration changes — unless required by the upgrade
- Other dependency bumps — only youtube_player_iframe targeted

## Context

The app uses Clean Architecture (domain/data/presentation layers) with Riverpod state management. The youtube_player_iframe package was upgraded from 5.x to 6.x, removing `YoutubePlayerScaffold` (replaced by direct `YoutubePlayer` usage) and handling fullscreen internally via OverlayPortal. All 5 consuming files verified v6-compatible.

## Constraints

- **Flutter SDK**: Must remain compatible with current Flutter version — v6 requires Flutter >=3.38.0 / Dart ^3.10.0
- **Stability**: The app must compile and all playback functionality must work after migration
- **Scope**: Only youtube_player_iframe is being upgraded — no other dependency changes

## Key Decisions

| Decision | Rationale | Outcome |
|----------|-----------|---------|
| Upgrade to 6.0.2 specifically | Latest patch for maximum stability | ✓ Applied Phase 1 |
| Batch update all 5 files in a single pass | Compiler-guided approach catches all issues at once (D-01) | ✓ Applied Phase 1 |
| Remove YoutubePlayerScaffold entirely | v6 uses direct YoutubePlayer widget (D-05) | ✓ Applied Phase 1 |
| Keep existing layout structure with OrientationBuilder | Preserve portrait/landscape split (D-06) | ✓ Applied Phase 1 |
| Wrap YoutubePlayer in SafeArea | Prevent notch/clipping issues (D-07) | ✓ Applied Phase 1 |
| Auto aspect ratio for YoutubePlayer | v6 handles it via iframe intrinsic dimensions (D-08) | ✓ Applied Phase 1 |

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

*Last updated: 2026-06-29 after v1.0 milestone*
