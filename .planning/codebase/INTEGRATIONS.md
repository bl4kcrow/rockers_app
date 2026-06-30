# External Integrations

**Analysis Date:** 2026-06-23

## APIs & External Services

**YouTube Services:**
- YouTube Video Streaming & Playback - Play video content in the app
  - SDK/Client: `youtube_player_iframe` package (v5.2.1)
  - Auth: Publicly accessible YouTube content, no auth keys needed
  - Endpoints/Integration: YouTube Iframe Player API embedded in WebView
- YouTube Metadata Retrieval - Retrieve views, duration, and descriptions
  - SDK/Client: `youtube_explode_dart` package (v2.3.10)
  - Auth: Public client (uses internal scraping/queries, no Google API key required)

## Data Storage

**Databases:**
- Cloud Firestore - Primary data store for songs, playlists, and metadata
  - Connection: Initialized using default Firebase options for Dev/Prod environments (`lib/config/utils/firebase_options_dev.dart` & `lib/config/utils/firebase_options_prod.dart`)
  - Client: `cloud_firestore` package (v5.6.4)
  - Collections used:
    - `playlists` - Filtered by `isActive` == true, ordered by `priority` (paginated load limit 10)
    - `trending` - Ordered by `priority` (paginated load limit 10)

**Local Key-Value Caching:**
- Shared Preferences - Stores user settings locally
  - Client: `shared_preferences` package (v2.5.2)
  - Keys used:
    - `sharedAutoplayKey` - Boolean state for whether the player automatically moves to next song
    - `sharedDarkModeKey` - Boolean state for light/dark theme preference

## Authentication & Identity

- No authentication layer implemented in the data layer. An abstract interface `AuthDatasource` exists in `lib/domain/datasources/auth_datasource.dart` but is not yet implemented.

## Environment Configuration

**Development:**
- Required env vars (defined in `.env` based on `.env.template`):
  - `FIREBASE_APPID_DEV`
  - `FIREBASE_ANDROID_APIKEY_DEV`
  - `FIREBASE_IOS_APIKEY_DEV`
  - `FIREBASE_WEB_APIKEY_DEV`
  - `FIREBASE_ANDROID_CLIENT_ID_DEV`
  - `FIREBASE_IOS_CLIENT_ID_DEV`
- Auth configurations are stored in `lib/config/utils/firebase_options_dev.dart`

**Production:**
- Required env vars:
  - `FIREBASE_APPID`
  - `FIREBASE_ANDROID_APIKEY`
  - `FIREBASE_IOS_APIKEY`
  - `FIREBASE_WEB_APIKEY`
  - `FIREBASE_ANDROID_CLIENT_ID`
  - `FIREBASE_IOS_CLIENT_ID`
- Auth configurations are stored in `lib/config/utils/firebase_options_prod.dart`

## App Updates & Store Integrations

**Firebase Remote Config:**
- Used for app update enforcement and check
  - SDK/Client: `firebase_remote_config` package (v5.4.2)
  - Config parameters:
    - `requiredMinimumVersion` (default: '2.2.0')
    - `recommendedMinimumVersion` (default: '2.2.0')

**Play Store / App Store:**
- Google Play Store / Apple App Store - Open store page for app update
  - Client: `url_launcher` package (v6.3.1)
  - App ID: `com.bl4ckcrow.rockers`

---

*Integration audit: 2026-06-23*
*Update when adding/removing external services*
