# Roadmap

This roadmap is a living checklist for building the Rails 8 app from scratch. Each stage is a milestone that can be checked off as it is completed; additional stages will be added as the project evolves.

## Stage 1: Repo baseline and governance

- [ ] Finalize documentation baseline (README, architecture, rails stack decisions).
- [ ] Add CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md.
- [ ] Set up issue templates and PR checklist.
- [ ] Define a lightweight ADR format and create `docs/adr/` folder.

## Stage 2: Rails 8 scaffold and tooling

- [ ] Generate Rails 8 app with preferred options (Propshaft, importmap, hotwire).
- [ ] Add RSpec or Minitest and pick one standard.
- [ ] Configure linting and security tooling (RuboCop/Standard, Brakeman, bundler-audit).
- [ ] Add `.env.example` and baseline ENV config.

## Stage 3: Data model core

- [ ] Create models: Account, User, Membership, Band, BandMembership.
- [ ] Define role enums and validations.
- [ ] Add basic seed data for a single account + band.
- [ ] Write model specs for core relationships and validations.

## Stage 4: Authentication and authorization

- [ ] Run Rails auth generator and configure account scoping.
- [ ] Add policy layer (Pundit or equivalent) and base policies.
- [ ] Define access rules for account- and band-scoped actions.
- [ ] Add request specs for auth flows and unauthorized access.

## Stage 5: App layout and navigation shell

- [ ] Build application layout with top-level navigation.
- [ ] Responsive nav: compact for mobile, sidebar for large screens.
- [ ] Create primary routes for Bands, Songs, Events, Setlists, Tasks.
- [ ] Implement flash and error rendering defaults.

## Stage 6: Band management

- [ ] CRUD for Bands with account scoping.
- [ ] Band settings page (name, description, branding placeholders).
- [ ] Band membership management UI.
- [ ] Policies and specs for band access control.

## Stage 7: Song library

- [ ] CRUD for Songs with tagging.
- [ ] Add search and filters (title, artist, tags).
- [ ] Add list sorting and persisted preferences.
- [ ] Import flow (plain text / markdown / CSV).

## Stage 8: Events and calendar

- [ ] CRUD for Events (gigs/rehearsals) with venue and datetime.
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

- [ ] Dockerfile and docker-compose (web, worker, db, minio optional).
- [ ] Add `docker-compose.dev.yml` for local development.
- [ ] bin/setup and bin/upgrade scripts.
- [ ] docs/self_hosting.md with copy/paste instructions.
- [ ] Add health checks (/up) and readiness endpoints.

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
