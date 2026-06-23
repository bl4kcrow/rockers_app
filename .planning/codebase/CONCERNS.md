# Codebase Concerns

**Analysis Date:** 2026-06-23

## Tech Debt

**Abstract Auth Datasource is Unimplemented:**
- Issue: `AuthDatasource` class is defined in domain layer, but there is no concrete firebase/data implementation.
- File: [auth_datasource.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/domain/datasources/auth_datasource.dart)
- Why: Left as a placeholder for a future authentication implementation phase.
- Impact: Authentication and user accounts are currently non-functional.
- Fix approach: Implement a concrete `FirebaseAuthDatasource` in the data layer using the `firebase_auth` library.

**Duplicate Firebase Configuration Files:**
- Issue: Development and Production Firebase options are hardcoded in two separate files.
- Files: `lib/config/utils/firebase_options_dev.dart` and `lib/config/utils/firebase_options_prod.dart`
- Why: Split configuration setups for development and production environments.
- Impact: Changes to general Firebase project configuration settings require keeping both files in sync manually.
- Fix approach: Integrate a config-builder script or use a single config file that dynamically loads values from `Environment` variables.

## Known Bugs

- No known runtime bugs reported currently.

## Security Considerations

**Exposed Client Credentials:**
- Risk: While the `.env` file is gitignored, loaded environment values are compiled into the final client binary. Attackers can reverse-engineer the APK/IPA to extract dev and prod Firebase API keys.
- Files: [environment.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/config/constants/environment.dart)
- Current mitigation: Relying on Firebase Console API key restrictions (HTTP referrer / IP restrictions).
- Recommendations: Ensure strict Firestore Security Rules are active to prevent unauthorized read/write access. Do not store sensitive secrets in `.env` if they are not meant to be public.

## Performance Bottlenecks

**No Cache Layer for Firestore Queries:**
- Problem: Scrolling through Playlists or Trending views repeatedly calls Firestore databases directly to load items.
- Files: [firestore_playlist_datasource.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/data/datasources/firestore_playlist_datasource.dart), [firestore_trending_datasource.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/data/datasources/firestore_trending_datasource.dart)
- Cause: Simple pagination fetch implementation without local caching (e.g. SQLite, Hive, or Firestore offline persistence configuration).
- Improvement path: Enable Firestore offline persistence or cache query lists locally in SharedPreferences or Hive database tables.

**Resource-heavy YouTube Iframe WebViews:**
- Problem: The embedded YouTube video iframe uses standard platform WebViews, which consume considerable memory and CPU overhead.
- File: [video_playback_screen.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/screens/video_playback_screen.dart)
- Cause: Underlying webview running YouTube scripts.
- Improvement path: Optimize webview settings or configure autoplay flags carefully to reduce background CPU cycles.

## Fragile Areas

**Scraped YouTube Metadata Parsing:**
- Why fragile: The `youtube_explode_dart` client uses internal scraping methods to fetch video views, length, and description.
- File: [video_meta_data_provider.dart](file:///c:/Users/azort/Documents/Programming-Projects/rockers_app/lib/presentation/providers/video_meta_data_provider.dart)
- Common failures: YouTube updates its web page layout or JS signatures, breaking the package's scraper functions and causing metadata loads to fail.
- Safe modification: Wrap the scraper calls in try-catch blocks with defensive fallbacks (returning 0 views/empty duration) to avoid UI crashes. Keep the package updated to the latest version.
- Test coverage: 0% coverage.

## Scaling Limits

**Firestore Free Tier Limitations:**
- Current capacity: Firestore Spark Plan limits read requests to 50,000 per day.
- Limit: With 10 reads per page load, a few hundred daily active users continuously scrolling through lists will hit the daily quotas.
- Symptoms at limit: Firestore operations return quota exhaustion errors, blocking data loading.
- Scaling path: Implement caching to reduce reads, or upgrade database to the Firestore Blaze Plan.

## Dependencies at Risk

**youtube_explode_dart:**
- Risk: High risk of failure due to updates in YouTube's service structures. Unannounced changes by Google can disable the metadata scraper.
- Impact: Video details (views, duration) show up as 0 or fail to render.
- Migration plan: Move metadata storage to Cloud Firestore so the app queries database documents directly instead of scraping YouTube.

## Test Coverage Gaps

**0% Test Coverage:**
- What's not tested: The entire application. There are no unit tests, widget tests, or integration tests implemented.
- Risk: Regressions can go completely unnoticed during feature development, refactoring, or dependency updates.
- Priority: High.
- Difficulty to test: Requires setting up mock databases (using `fake_cloud_firestore`) and mock controllers.

---

*Concerns audit: 2026-06-23*
*Update as issues are fixed or new ones discovered*
