# bandmgr

`bandmgr` is an open-source, self-hostable platform for managing your band.

## Mission

Modern bands need a place to store and share important information - things like repertoire, charts, setlists, bookings, and contacts. Almost all bands need a webpage of some kind, and will use some form of social media to promote themselves. Currently many bands will find themselves using a hotch-potch of disconnected tools - Google Drive for documents, WhatsApp for messaging, Facebook for events, and perhaps a simple website hosted on a free platform. This creates a lot of work being the 'human middleware' to connect these systems.

Band Manager aims to be a one-stop solution for all of these needs, with a focus on ease of use and flexibility. It is free and open source, and will always remain free to self-host. Reasonably priced hosted options may be available from us in the future but there will **never** be a feature in the 'paid' version that is disabled in the self-hosted version.

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
flutter pub get
```

### 4. Generate code (build_runner)

```bash
dart run build_runner build --delete-conflicting-outputs
```

Re-run this after any change to model serialization or generated code.

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

Alternative:

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

### 8. Regenerate after model changes

Any edit to data models or JSON serialization:

1. Update the relevant model or serializer
2. Run build:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
3. Restart the app (hot restart may be insufficient for data migrations—full restart recommended for now).

### 9. Importing Songs

Navigate: Home -> Songs -> Import (supports Plain Text / Markdown list / CSV).

### 10. Helpful scripts

From repo root:

- ./s/run (runs flutter from the repo root)
- ./s/docker-up (enables + scaffolds Linux desktop if missing, then runs)

### 11. Common issues

- Error: MemberRow / SongRow not found -> run build_runner.
- Error: uuid not found -> ensure flutter pub get was executed at the repo root.
- Still seeing Flutter counter page -> confirm you are launching lib/main.dart (grep for BandMgrApp).

---

Have an idea that isn't listed? Open an issue and let's chat.
