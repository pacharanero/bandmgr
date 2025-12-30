# Roadmap

This roadmap is a living checklist for building the Rails 8 app from scratch. Each stage is a milestone that can be checked off as it is completed; additional stages will be added as the project evolves.

## Stage 1: Repo baseline and governance

- [x] Finalize documentation baseline (README, architecture, rails stack decisions).
- [ ] Add CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md.
- [ ] Set up issue templates and PR checklist.
- [ ] Define a lightweight ADR format and create `docs/adr/` folder.

## Stage 2: Rails 8 scaffold and tooling

- [x] Generate Rails 8 app with preferred options (Propshaft, importmap, hotwire).
- [x] Add RSpec or Minitest and pick one standard.
- [x] Configure linting and security tooling (RuboCop/Standard, Brakeman, bundler-audit).
- [x] Add `.env.example` and baseline ENV config.

## Stage 3: Data model core

- [x] Create models: Account, User, Membership, Band, BandMembership.
- [x] Define role enums and validations.
- [x] Add basic seed data for a single account + band.
- [x] Write model specs for core relationships and validations.

## Stage 4: Authentication and authorization

- [x] Run Rails auth generator and configure account scoping.
- [x] Add policy layer (Pundit or equivalent) and base policies.
- [x] Define access rules for account- and band-scoped actions.
- [x] Add request specs for auth flows and unauthorized access.

## Stage 5: App layout and navigation shell

- [x] Build application layout with top-level navigation.
- [x] Responsive nav: compact for mobile, sidebar for large screens.
- [x] Create primary routes for Bands, Songs, Events, Setlists, Tasks.
- [x] Implement flash and error rendering defaults.

## Stage 6: Band management

- [x] CRUD for Bands with account scoping.
- [x] Band settings page (name, description, branding placeholders).
- [x] Band membership management UI.
- [x] Policies and specs for band access control.

## Stage 7: Song library

- [x] CRUD for Songs with tagging.
- [x] Add search and filters (title, artist, tags).
- [x] Add list sorting and persisted preferences.
- [ ] Import flow (plain text / markdown / CSV).

## Stage 8: Events and calendar

- [x] CRUD for Events (gigs/rehearsals) with venue and datetime.
- [ ] Basic calendar/list views.
- [ ] Event detail page with notes and attachments.
- [ ] Add reminders placeholder (future jobs/notifications).

## Stage 9: Setlists

- [ ] CRUD for Setlists and SetlistSongs ordering.
- [ ] Drag-and-drop ordering via Stimulus.
- [ ] Duplicate setlist from existing.
- [ ] Export to printable view.

## Stage 10: Tasks and lightweight messaging

- [ ] Band task list with status and assignee.
- [ ] Simple comments on tasks/events/songs.
- [ ] Notification placeholders (in-app only).
- [ ] Policies and basic tests.

## Stage 11: Files and documents

- [ ] Enable Active Storage and configure local + S3/MinIO.
- [ ] Attachments on Songs, Events, and Setlists.
- [ ] Document listing and permissions.
- [ ] Basic file size/type validation.

## Stage 12: Self-hosting and deployment

- [x] Dockerfile and docker-compose (web, worker, db, minio optional).
- [x] Add `docker-compose.dev.yml` for local development.
- [x] bin/setup and bin/upgrade scripts.
- [ ] docs/self_hosting.md with copy/paste instructions.
- [x] Add health checks (/up) and readiness endpoints.

## Stage 13: Background jobs and scheduling

- [ ] Configure Solid Queue and job runner container.
- [ ] Add recurring jobs (reminders, cleanup).
- [ ] Add job failure alerts or logging.
- [ ] Write job specs.

## Stage 14: Observability and ops readiness

- [ ] Structured logging config and log tags.
- [ ] Error reporting hook (Sentry/Honeybadger) placeholder.
- [ ] Add metrics hooks (minimal, optional).
- [ ] Document operational expectations in README.

## Stage 15: UI polish and accessibility

- [ ] Tailwind + DaisyUI theme selection, typography, spacing scale.
- [ ] Ensure keyboard navigation for key flows.
- [ ] Improve mobile layouts and empty states.
- [ ] Add a basic style guide page.

## Stage 16: Beta hardening

- [ ] Full regression pass on core flows.
- [ ] Fix critical bugs and performance hotspots.
- [ ] Review security posture (CSRF, authorization coverage).
- [ ] Tag a beta release and publish notes.
