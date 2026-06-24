# Phase 1: youtube_player_iframe Upgrade — Context

**Gathered:** 2026-06-24
**Status:** Ready for planning

<domain>
## Phase Boundary

Upgrade youtube_player_iframe from 5.2.1 to 6.0.2 across all 5 files that use it. Migrate API usage from v5 patterns (YoutubePlayerScaffold, manual fullscreen management) to v6 equivalents (direct YoutubePlayer usage, internal fullscreen handling). No feature additions, UI changes, or other dependency bumps.

</domain>

<decisions>
## Implementation Decisions

### Migration Approach
- **D-01:** Batch — update all 5 files in a single pass, then compile-check (not file-by-file)
- **D-02:** Compiler-guided — update the dependency and let the compiler flag breaking changes, rather than consulting v6 docs beforehand
- **D-03:** Verify via `flutter analyze` passing + manual playback test on device/emulator
- **D-04:** Work on a dedicated feature branch (`chore/upgrade-youtube-player-v6`)

### Layout Structure
- **D-05:** Remove `YoutubePlayerScaffold` entirely — replace with direct `YoutubePlayer` widget in the widget tree
- **D-06:** Keep existing layout structure (portrait: video + controls + metadata + playlist; landscape: video only) using `OrientationBuilder` as before
- **D-07:** Wrap `YoutubePlayer` in `SafeArea`
- **D-08:** Use auto aspect ratio (let v6 handle it via iframe intrinsic dimensions)

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Project Requirements
- `.planning/ROADMAP.md` §Phase 1 — Goal, success criteria, and requirement mappings
- `.planning/REQUIREMENTS.md` — DEP-01 through DEP-07 traceability
- `.planning/PROJECT.md` — Constraints (Flutter compat, scope) and project context

### Codebase Architecture
- `.planning/codebase/STACK.md` — Current dependency versions and tech stack
- `.planning/codebase/INTEGRATIONS.md` — YouTube playback integration details
- `.planning/codebase/ARCHITECTURE.md` — Clean Architecture patterns, layer structure

### Files to Migrate
- `lib/presentation/screens/video_playback_screen.dart` — Main playback screen with `YoutubePlayerScaffold`
- `lib/presentation/providers/video_player_provider.dart` — `YoutubePlayerController` creation and controls
- `lib/presentation/widgets/video_controls.dart` — Play/pause UI with `YoutubeValueBuilder`
- `lib/presentation/widgets/thumbnail_image.dart` — Thumbnail via `getThumbnail`
- `lib/domain/entities/song.dart` — URL-to-ID conversion via `convertUrlToId`

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- `VideoControls` widget — play/pause/skip controls, uses `YoutubeValueBuilder` for reactive state (check v6 compatibility)
- `ThumbnailImage` widget — thumbnail display via `getThumbnail` static method
- `VideoPlayerNotifier` — controller wrapper with play/pause/next/previous/fullScreen methods
- `_PlayerScaffoldBody` — portrait/landscape layout with orientation builder

### Established Patterns
- Clean Architecture with Riverpod state management
- `YoutubePlayerController` created eagerly in provider with `YoutubePlayerParams`
- Autoplay handled via Riverpod provider + stream subscription on controller events
- `ConsumerStatefulWidget` for playback screen lifecycle management

### Integration Points
- `pubspec.yaml` — Dependency constraint to update (`^5.2.1` → `^6.0.2`)
- 5 files import `youtube_player_iframe` — all need migration attention
- v6 requires Flutter >=3.38.0 / Dart ^3.10.0

</code_context>

<specifics>
## Specific Ideas

No specific references or examples provided — open to standard approaches for the migration.

</specifics>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope.

</deferred>

---

*Phase: 1-youtube_player_iframe Upgrade*
*Context gathered: 2026-06-24*
