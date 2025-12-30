# bandmgr

`bandmgr` is an open-source, self-hostable platform for managing your band.

The application is being built as a Rails 8 + Hotwire stack. See `spec/rails.md` for the baseline architecture.

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

These steps assume the Rails app scaffold is present in the repo (including `bin/setup`).

### 1. Clone

```bash
git clone https://github.com/pacharanero/bandmgr.git
cd bandmgr
```

### 2. Prerequisites

- Ruby 3.3+
- PostgreSQL (or SQLite if you choose that path)

### 3. Install dependencies

```bash
bundle install
```

### 4. Setup the database

```bash
bin/setup
```

### 5. Run the app

```bash
bin/rails server
```

### 6. Tests

```bash
bin/rails test
```

### 7. Importing Songs

Navigate: Home -> Songs -> Import (supports Plain Text / Markdown list / CSV).

### 8. Helpful scripts

From repo root:

- `./s/` will host convenience scripts for common Rails dev tasks.

---

Have an idea that isn't listed? Open an issue and let's chat.
