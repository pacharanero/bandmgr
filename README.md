# Band Manager Application Specifications

Band Manager is an open-source, self-hostable platform for managing your band.

![screenshot](screenshot.png)

## Mission

Modern bands need a place to store and share important information - things like repertoire, charts, setlists, bookings, and contacts. Almost all bands need a webpage of some kind, and will use some form of social media to promote themselves.

Band Manager aims to be a one-stop solution for all of these needs, with a focus on ease of use and flexibility. It is free and open source, and will always remain free. Hosted options may be available in the future but there will **never** be a feature in the 'premium' version that is disabled in the self-hosted version.

## Key Features

Build a single home for your band and keep everything tight, fast, and organized:

- 🎵 Song library with tags, keys, tempos, and quick search
- 📋 Setlists with easy ordering and duplication
- 📅 Gigs + calendar planning with reminders
- 👥 Band roster, roles, and member messaging
- 🧾 Merch + simple merch store support
- 🎛️ Stage plans and equipment inventory
- 🌐 Band site + branding, themes, and custom domains
- 🔗 Integrations: Google Drive, Spotify, YouTube, SoundCloud, Bandcamp

For the full status list and roadmap, see `spec/features.md`.

---

## Development Setup

### 1. Clone

```bash
git clone https://github.com/pacharanero/bandmgr.git
cd bandmgr
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

### 4. Generate code (build_runner)

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

Any edit to database tables:

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
