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

For the full status list and roadmap, see `spec/features.md` and `spec/roadmap.md`.

---

## Current MVP Status

- Account creation + sign in/out flow.
- Band CRUD (name, description) scoped to account.
- Band member management with role updates.
- Song library CRUD with tags, search, and filtering.
- Placeholder screens for Events, Setlists, Tasks.

## Development Setup

These steps assume the Rails app scaffold is present in the repo (including `bin/setup`).

### 1. Clone

```bash
git clone https://github.com/pacharanero/bandmgr.git
cd bandmgr
```

### 2. Prerequisites

- Ruby 3.3+ (Rails 8 supported)
- PostgreSQL 14+ (or SQLite if you choose that path later)

Optional but recommended:

- Node.js (for tooling that might be added later)

### 3. Install dependencies

```bash
bundle install
```

### 4. Configure environment

Copy the example env file and update values if needed:

```bash
cp .env.example .env
```

### 5. Start dependencies with Docker

If you want a containerized dev stack (Rails + Postgres + Redis + MinIO):

```bash
docker compose -f docker-compose.dev.yml up --build web
```

Or use the convenience script (starts dependencies, prepares the DB, opens the browser, and runs the web container):

```bash
./s/dev
```

The web container bind-mounts the repo for live code reload and runs `bundle install` on startup to keep gems in sync.

### 6. Setup the database

```bash
bin/setup
```

This seeds a demo account and user for local development:

- Email: `demo@example.com`
- Password: `password`

### 7. Run the app

In one terminal:

```bash
bin/dev
```

If you have watchman installed, Tailwind will use it automatically. If not, the dev Procfile disables it to avoid startup failures.

Visit `http://localhost:3000`.

If you prefer running without foreman:

```bash
bin/rails server
```

Sign in with the demo user or create a new login at `/registration`.

### 8. Tests

```bash
bin/rails test
```

System tests:

```bash
bin/rails test:system
```

### 9. Lint and security checks

```bash
bin/rubocop
bin/brakeman
bundle exec bundler-audit check --update
```

---

Have an idea that isn't listed? Open an issue and let's chat.
