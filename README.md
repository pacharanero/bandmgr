# bandmgr

`bandmgr` is an open-source, self-hostable platform for managing a band's repertoire, setlists, events, members, and shared information. It is not a hosted-service-only product or an enterprise upsell.

The application is being built as a Rails 8 + Hotwire stack. See [the architecture specification](spec/architecture.md) for the baseline design.

## Mission

Bands need a place to store and share important information - things like repertoire, charts, setlists, bookings, and contacts. Bands need a website of some kind, and will probably use some form of social media to promote themselves. Currently many bands will find themselves using a hotch-potch of disconnected tools - maybe Google Drive for documents, WhatsApp for messaging, Facebook for promotion and events, and perhaps a simple website hosted on a free platform. This creates a lot of work being the 'human middleware' to connect these systems.

Band Manager aims to be a one-stop solution for all of these needs, with a focus on ease of use and flexibility. It is free and open source, and will always remain free to self-host. Reasonably priced hosted options may be available from us in the future but there will **never** be a feature in the 'paid' version that is disabled in the self-hosted version. No 'Enterprise' version. As Jeeff Attwood once said about Discourse (although I can't find the quote) "there's only *one* version - the awesome version".

## Key Features

Build a single home for your band and keep everything organised:

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
- Song library CRUD with tags, search, filtering, sorting, and import.
- Event CRUD for gigs and rehearsals.
- Placeholder screens for Setlists, Tasks.

## Development

### Quickstart

1. Clone: `git clone https://github.com/pacharanero/bandmgr.git && cd bandmgr`
2. Seed the database: `./s/seed` (starts db/redis if needed, prepares the DB, seeds demo data)
3. Run the dev stack: `./s/dev`

What `./s/dev` does:
- Starts Postgres and Redis via Docker Compose.
- Builds/starts the Rails web container with live code reload and bind-mounts `storage/` for uploads.
- Waits for the stack and opens `http://localhost:3000`.

Default demo credentials (seeded by `./s/seed`):
- Email: `development@bandmgr.band`
- Password: `password`

Other tasks
- Tests: `s/test`
- Lint: `s/lint`
- Security scans: `s/scan`

Have an idea that isn't listed? Open an issue and let's chat.

## Deployment

Production deployments use Kamal and the configuration in `config/deploy.yml`. Keep `.kamal/secrets` local and supply `KAMAL_REGISTRY_PASSWORD` and `RAILS_MASTER_KEY` from a password manager or the environment. CI additionally requires a reviewed `DEPLOY_KNOWN_HOSTS` secret containing the SSH host key, rather than discovering it during deployment.

## Licence

The application code is licensed under [AGPL-3.0-or-later](LICENSE). Written project content is licensed under CC-BY-SA-4.0. This project is not available for proprietary subsumption.
