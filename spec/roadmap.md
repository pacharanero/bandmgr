# Roadmap

This roadmap is a living checklist for building the Rails 8 app from scratch. Each stage is a milestone that can be checked off as it is completed; additional stages will be added as the project evolves.

## Rails 8 scaffold and tooling

- [x] Finalize documentation baseline (README, architecture, rails stack decisions).
- [x] Generate Rails 8 app with preferred options (Propshaft, importmap, hotwire).
- [x] Add RSpec or Minitest and pick one standard.
- [x] Configure linting and security tooling (RuboCop/Standard, Brakeman, bundler-audit).
- [x] Add `.env.example` and baseline ENV config.

## Data model core

- [x] Create models: Account, User, Membership, Band, BandMembership.
- [x] Define role enums and validations.
- [x] Add basic seed data for a single account + band.
- [x] Write model specs for core relationships and validations.

## Authentication and authorization

- [x] Run Rails auth generator and configure account scoping.
- [x] Add policy layer (Pundit or equivalent) and base policies.
- [x] Define access rules for account- and band-scoped actions.
- [x] Add request specs for auth flows and unauthorized access.

## App layout and navigation shell

- [x] Build application layout with left sidebar navigation.
- [x] Responsive nav: compact for mobile, sidebar for large screens.
- [x] Create primary routes for Bands, Songs, Events, Setlists, Tasks.
- [x] Implement flash and error rendering defaults.

## Band management

- [x] CRUD for Bands with account scoping.
- [x] Band settings page (name, description, branding placeholders).
- [x] Band membership management UI.
- [x] Invite band members via email with acceptance flow.
- [x] Set default band per account membership.
- [x] Policies and specs for band access control.

## Song library

- [x] CRUD for Songs with tagging.
- [x] Add search and filters (title, artist, tags).
- [x] Add list sorting and persisted preferences.
- [x] Import flow (plain text / markdown / CSV).

## Events and calendar

- [x] CRUD for Events (gigs/rehearsals) with venue and datetime.
- [x] Basic list view for events.
- [x] Basic calendar view.
- [x] Event detail page with notes.
- [x] Event attachments.
- [x] Add reminders placeholder (future jobs/notifications).
- [x] Google Calendar integration: creates configurable 'subscribable' URL calendars - private calendar for band members, public calendar for fans.

## Setlists

- [x] Data model for Setlists, SetlistSongs, and EventSetlists.
- [x] CRUD for Setlists and SetlistSongs ordering.
- [x] Drag-and-drop ordering via Stimulus.
- [x] Add songs to setlists from song list, song detail, and setlist views.
- [x] Import setlists from YouTube or Spotify playlists.
- [x] Create a Duplicate Setlist from existing.
- [x] Export Setlist to PDF
- [x] Print Setlist.
- [x] Bulk Setlist operations - all existing operations should be applicable in bulk
- [ ] Link Setlist to Event

## Band Chat

- [ ] In-app threaded chat for band members
- [ ] Default channels (General Chat, Gigs, Equipment)
- [ ] Direct messages between band members
- [ ] Basic message reactions (likes)
- [ ] Browser notifications
- [ ] Chat nav in Sidebar

## Tasks

- [ ] Band task list with status and assignee.
- [ ] Simple comments on tasks/events/songs.
- [ ] Notification placeholders (in-app only).
- [ ] Policies and basic tests.

## Files and documents

- [x] Enable Active Storage and configure local disk
- [ ] Attachments on Songs, Events, and Setlists.
- [ ] Document listing and permissions.
- [ ] Basic file size/type validation.

## Self-hosting and deployment

- [x] Dockerfile and docker-compose (web, worker, db).
- [x] Add `docker-compose.dev.yml` for local development.
- [x] s/dev script to start local dev stack.
- [x] s/seed script to prepare and seed the database.
- [x] Self hosting instructions in README.md
- [x] Add health checks (/up) and readiness endpoints.

## Background jobs and scheduling

- [x] Configure Solid Queue adapter, queues, and schemas.
- [ ] Add job runner container or supervisor process.
- [ ] Add recurring jobs (reminders, cleanup).
- [ ] Add job failure alerts or logging.
- [ ] Write job specs.

## Observability and ops readiness

- [ ] Structured logging config and log tags.
- [ ] Error reporting hook (Sentry/Honeybadger) placeholder.
- [ ] Add metrics hooks (minimal, optional).
- [ ] Document operational expectations in README.

## UI polish and accessibility

- [ ] Tailwind + DaisyUI theme selection, typography, spacing scale.
- [x] Basic dark mode toggle.
- [ ] Ensure keyboard navigation for key flows.
- [ ] Improve mobile layouts and empty states.
- [ ] Add a basic style guide page.

## Contribution and community setup

- [ ] Add CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md.
- [ ] Set up issue templates and PR checklist.
- [ ] Define a lightweight ADR format and create `docs/adr/` folder.

## Testing and CI

- [ ] Add unit tests for all models and controllers, covering edge cases, validations.
- [ ] Use testing to assure authorisation rules - users cannot access data outside their bands, and similar testing of logic boundaries.
- [ ] Add system tests for key user flows (song management, gig scheduling, setlist creation).
- [ ] Configure GitHub Actions for linting, tests, and security scans on PRs
- [ ] Add code coverage reporting.
- [ ] Document testing conventions in CONTRIBUTING.md.
- [ ] Set up periodic dependency update checks (Dependabot or similar).

## Beta hardening

- [ ] Full regression pass on core flows.
- [ ] Fix critical bugs and performance hotspots.
- [ ] Review security posture (CSRF, authorization coverage).
- [ ] Tag a beta release and publish notes.

## Import, Export and Backup

- [ ] Export all of a band's data to JSON for backup or transfer.
- [ ] Import a band's data from JSON export.
- [ ] Scheduled backups for self-hosted instances (to local disk or S3-compatible).
