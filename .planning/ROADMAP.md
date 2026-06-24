# Roadmap: Rockers App

**Created:** 2026-06-24

## Phase Overview

| Phase | Name | Status | Plans | Progress |
|-------|------|--------|-------|----------|
| 1 | youtube_player_iframe Upgrade | ○ | 0/0 | 0% |

---

### Phase 1: youtube_player_iframe Upgrade
**Goal:** Upgrade youtube_player_iframe from 5.2.1 to 6.0.2 with full code migration and verify app stability
**Mode:** mvp
**Success Criteria**:
1. pubspec.yaml updated to `^6.0.2` and `flutter pub get` succeeds
2. All `YoutubePlayerScaffold` references migrated to direct `YoutubePlayer` usage
3. Deprecated options removed, fullscreen behavior verified
4. `flutter analyze` passes with 0 errors
5. Video playback, controls, autoplay, and fullscreen work correctly

**Requirements mapped**:
- DEP-01 → Plan 1
- DEP-02 → Plan 1
- DEP-03 → Plan 1
- DEP-04 → Plan 1
- DEP-05 → Plan 1
- DEP-06 → Plan 1
- DEP-07 → Plan 1

---

*Roadmap created: 2026-06-24*
*Next action: /gsd-plan-phase 1*
