# Technology Stack

**Analysis Date:** 2026-06-23

## Languages

**Primary:**
- Dart 3.x - All application source code (`lib/` directory)

**Secondary:**
- Kotlin/Java - Android platform integration wrapper (`android/` directory)
- Swift/Objective-C - iOS platform integration wrapper (`ios/` directory)

## Runtime

**Environment:**
- Flutter SDK (with Material 3 design enabled)
- Device/Emulator runtimes (Android & iOS)

**Package Manager:**
- pub (Dart/Flutter package manager)
- Lockfile: `pubspec.lock` present

## Frameworks

**Core:**
- Flutter Framework - Cross-platform UI framework

**Testing:**
- flutter_test (Flutter SDK) - Unit and widget testing (configured but no test files found)

**Build/Dev:**
- flutter_launcher_icons 0.14.3 - App launcher icons builder
- flutter_native_splash 2.4.5 - Native splash screen generator
- change_app_package_name 1.4.0 - Package name changer utility

## Key Dependencies

**Critical:**
- flutter_riverpod 2.6.1 - Reactive state management and dependency injection
- go_router 14.8.1 - Declarative routing utility
- firebase_core 3.12.0 - Core Firebase SDK wrapper for initialization
- cloud_firestore 5.6.4 - Cloud Firestore API client (for playlists and trending songs)
- firebase_remote_config 5.4.2 - Firebase Remote Config client (for required version checks)

**Infrastructure:**
- youtube_player_iframe 5.2.1 - YouTube video playback via iframe wrapper
- youtube_explode_dart 2.3.10 - Extracting YouTube metadata (views, duration, details)
- flutter_dotenv 5.2.1 - loading environment variables from `.env`
- shared_preferences 2.5.2 - Local persistence for key-value settings (dark mode, autoplay)

## Configuration

**Environment:**
- Configured via `.env` file (see `.env.template` for keys like `FIREBASE_APPID`, etc.)
- Values loaded at runtime via `dotenv.load(fileName: ".env")`

**Build:**
- `pubspec.yaml` - Dependencies and assets declaration
- `analysis_options.yaml` - Linting and static analysis rules
- `firebase.json` - Firebase CLI settings

## Platform Requirements

**Development:**
- Flutter SDK >=3.0.5 <4.0.0
- Android Studio / VS Code with Dart & Flutter plugins
- Xcode (for iOS builds)

**Production:**
- Android: Min SDK 21, Target SDK 34 (Play Store distribution)
- iOS: iOS 12+ (App Store distribution)

---

*Stack analysis: 2026-06-23*
*Update after major dependency changes*
