# Requirements: Rockers App

**Defined:** 2026-06-24
**Core Value:** Users can play music videos from curated playlists with continuous autoplay and minimal friction

## v1 Requirements

### youtube_player_iframe Upgrade

- [ ] **DEP-01**: Update youtube_player_iframe constraint from `^5.2.1` to `^6.0.2` in pubspec.yaml
- [ ] **DEP-02**: Migrate `YoutubePlayerScaffold` usage in `video_playback_screen.dart` to direct `YoutubePlayer` widget
- [ ] **DEP-03**: Remove `autoFullScreen`, `defaultOrientations`, and `setFullScreenListener` (fullscreen handled internally in v6)
- [ ] **DEP-04**: Verify `YoutubePlayerController` creation and params are compatible with v6 API
- [ ] **DEP-05**: Verify `YoutubeValueBuilder`, `YoutubePlayerController.getThumbnail`, `convertUrlToId`, and `toggleFullScreen` still work
- [ ] **DEP-06**: Verify app compiles with `flutter analyze` passing
- [ ] **DEP-07**: Verify video playback, controls, autoplay, and fullscreen work correctly

## v2 Requirements

None — this is a focused dependency upgrade.

## Out of Scope

| Feature | Reason |
|---------|--------|
| Feature additions or UI changes | Purely a dependency upgrade |
| Other dependency bumps | Only youtube_player_iframe targeted |
| Platform config changes | Unless directly required by the upgrade |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| DEP-01 | Phase 1 | Pending |
| DEP-02 | Phase 1 | Pending |
| DEP-03 | Phase 1 | Pending |
| DEP-04 | Phase 1 | Pending |
| DEP-05 | Phase 1 | Pending |
| DEP-06 | Phase 1 | Pending |
| DEP-07 | Phase 1 | Pending |

**Coverage:**
- v1 requirements: 7 total
- Mapped to phases: 7
- Unmapped: 0 ✓

---
*Requirements defined: 2026-06-24*
*Last updated: 2026-06-24 after initial definition*
