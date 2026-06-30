# Phase 1: youtube_player_iframe Upgrade — Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-06-24
**Phase:** 1-youtube_player_iframe Upgrade
**Areas discussed:** Migration approach, Layout structure

---

## Migration Approach

| Option | Description | Selected |
|--------|-------------|----------|
| Batch all 5 at once | Update all files in a single pass, then compile-check | ✓ |
| File-by-file with compile checks | Update one file at a time, run flutter analyze between each | |
| API-first then layout | Update shared utilities first, then layout screen last | |

**User's choice:** Batch all 5 at once
**Notes:** Faster approach preferred — user is comfortable with compiler catching issues

| Option | Description | Selected |
|--------|-------------|----------|
| Manual device test | Run on emulator/device, manually test | |
| flutter analyze + manual test | Static analysis first, then manual playback test | ✓ |
| CI-style verification | flutter analyze, flutter test, then manual E2E | |

**User's choice:** flutter analyze + manual test

| Option | Description | Selected |
|--------|-------------|----------|
| Feature branch | Dedicated branch (chore/upgrade-youtube-player-v6) | ✓ |
| Work on current branch | No branching — commit directly | |

**User's choice:** Feature branch

| Option | Description | Selected |
|--------|-------------|----------|
| Consult v6 docs first | Pull package changelog/source before writing code | |
| Compiler-guided migration | Update dependency, let compiler flag breaking changes | ✓ |

**User's choice:** Compiler-guided migration

---

## Layout Structure

| Option | Description | Selected |
|--------|-------------|----------|
| YoutubePlayer replaces scaffold wrapper | Remove YoutubePlayerScaffold, place YoutubePlayer directly in _PlayerScaffoldBody | ✓ |
| Extract VideoPlayer to its own widget | Create dedicated VideoPlayerWidget wrapping YoutubePlayer | |

**User's choice:** YoutubePlayer replaces scaffold wrapper

| Option | Description | Selected |
|--------|-------------|----------|
| Keep existing layout structure | Same portrait/landscape layout with OrientationBuilder | ✓ |
| Simplified layout | Remove OrientationBuilder, rely on v6 internal fullscreen | |

**User's choice:** Keep existing layout structure

| Option | Description | Selected |
|--------|-------------|----------|
| YoutubePlayer inside SafeArea | Wrap in SafeArea for notches/status bars | ✓ |
| YoutubePlayer fills available space | Direct placement in Column without SafeArea | |

**User's choice:** YoutubePlayer inside SafeArea

| Option | Description | Selected |
|--------|-------------|----------|
| Fixed 16:9 aspect ratio | Constrain to 16:9 in portrait | |
| Auto aspect ratio | Let v6 handle via iframe intrinsic dimensions | ✓ |

**User's choice:** Auto aspect ratio

---

## Deferred Ideas

None — discussion stayed within phase scope.
