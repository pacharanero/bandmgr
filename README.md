# Band Manager Application Specifications

Band Manager is an open-source, self-hostable platform for managing your band.

![screenshot](screenshot.png)

## Mission

Modern bands need a place to store and share important information - things like repertoir, charts, setlists, bookings, and contacts. Almost all bands need a webpage of some kind, and will use some form of social media to promote themselves. Band Manager aims to be a one-stop solution for all of these needs, with a focus on ease of use and flexibility. It is free and will always remain free. Hosted options may be available in the future but there will **never** be a feature in the 'premium' version that is disabled in the self-hosted version.

## Key Features (Initial)

- Manage songs, setlists, gigs, and bands
- Tagging system for songs, setlists, gigs, and bands
- Custom band website with merch store
- Admin interface for all models
- User authentication (login, signup, logout)
- Responsive UI using Semantic UI
- Band member messaging (instant messaging, group chat and email)
- Google Drive linking (docs, sheets)
- Bandcamp integration (merch, music sales)
- SoundCloud integration (audio tracks, playlists)
- Spotify integration (playlists, album links)
- YouTube integration (videos, playlists)
- Calendar integration (gigs, events, reminders)
- Social media integration (Facebook, Twitter, Instagram) for easy cross-promotion
- Equipment inventory management
- Stage layout management
- Custom domain support
- Logo, branding, and theme customization
- External photos and video gallery

> NOTE: Some items below in the Worklist / Roadmap may conceptually overlap with entries in the initial key features list (e.g. tagging, equipment, calendar, stage layout). They are retained to reflect current implementation status vs. future enhancements or more detailed variants.

## Current Early Implementation (App Scaffold)

- Offline-first Drift DB scaffold
- Song List screen with basic import (Plain Text, Markdown, CSV)
- Duplicate detection on (title, artist)
- Initial domain models (Band, Member, Song, Setlist scaffolding)

## Worklist (Active Development)

These are features currently being actively designed or implemented:

- Copy a SetList to a new one
- Drag-and-drop to add Songs to a SetList (bulk add via drag/drop)
- Song search / filter in lists
- Pick list (selector) for `Song.key`
- Tag handling improvements for Songs, SetLists, Gigs, Venues (extended taxonomy, UI polish)
- Sidebar navigation overhaul
- Google Maps embed for Venues
- New Song / Venue / Gig / SetList creation in a modal dialog
- Equipment tracking refinements (link gear to gigs / transport lists)
- Band funds tracking (income, expenses, simple ledger)

## Roadmap (Planned / Nice-to-Have)

Ideas that would be valuable but are not yet scheduled. Community feedback & contributions welcome:

- Performance Mode – step through lyrics & charts in SetList order, synchronized across band members (mobile-friendly)
- Practice Mode – surface songs with least practice or not recently gigged
- Markdown-based Song Editor (inline charts/lyrics instead of only external links)
- Simple public Band Pages: gallery, booking info, static content – optional band website replacement
- Online band booking inquiry form
- Google Calendar integration & availability sync (enhanced beyond current calendar linking)
- Automatically create a YouTube Playlist from a SetList
- Manage recordings via linked SoundCloud account
- Manage Stage Plans and FOH (Front of House) notes (beyond current stage layout basics)
- Automated YouTube / Spotify playlist synchronization from SetLists
- Advanced merch & store analytics dashboard

---

## Development Setup

### 1. Clone

```bash
git clone https://github.com/pacharanero/bandmgr-flutter.git
cd bandmgr-flutter
```

### 2. (Optional) Enable desktop targets

```bash
flutter config --enable-linux-desktop --enable-macos-desktop --enable-windows-desktop
```

### 3. Get dependencies

```bash
cd app
flutter pub get
```

### 4. Generate code (Drift, Freezed, etc.)

```bash
dart run build_runner build --delete-conflicting-outputs
```

Re-run this after any change to tables in:
lib/core/persistence/app_database.dart

### 5. Run the app

Desktop (Linux example):

```bash
flutter run -d linux
```

Web:

```bash
flutter run -d chrome
```

Mobile (attached device/emulator):

```bash
flutter run
```

Alternative (from repo root without cd):

```bash
./s/run -d linux
```

### 6. Hot restart vs clean build

If you see stale artifacts (e.g. missing generated classes):

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

### 7. Tests

```bash
flutter test
```

### 8. Regenerate after schema changes

Any edit to Drift tables:

1. Update app_database.dart
2. Run build:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. Restart the app (hot restart may be insufficient for schema migrations—full restart recommended for now).

### 9. Importing Songs

Navigate: Home -> Songs -> Import (supports Plain Text / Markdown list / CSV).

### 10. Helpful scripts

From repo root:

- ./s/run (runs flutter run inside app/)
- ./s/docker-up (enables + scaffolds Linux desktop if missing, then runs)

### 11. Common issues

- Error: MemberRow / SongRow not found -> run build_runner.
- Error: uuid not found -> ensure flutter pub get was executed inside app/.
- Still seeing Flutter counter page -> confirm you are launching app/lib/main.dart (grep for BandMgrApp).

---

Have an idea that isn't listed? Open an issue and let's chat.

## Technical Stack

- Flutter/Dart
- Drift
- YAML for configuration
