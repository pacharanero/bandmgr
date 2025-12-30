## 1. Project Principles

- Boring, readable Rails: explicit service objects, minimal callbacks, little DSL magic.
- Hotwire-first UI: server-rendered HTML with Turbo and Stimulus; add a JS framework only when truly needed.
- 12-factor-ish config: ENV-driven with `.env.example` for self-hosters.
- Composable deployment: app image runs anywhere; DB/mail/storage are swappable.

**Non-goals (initially):** multi-tenant pooled DB, microservices, heavy front-end framework.

## 2. Baseline Tech Choices

**Core**
- Rails 8.x (Ruby 3.3+).
- PostgreSQL for production/hosted; best tooling and expectations.
- Redis optional: Rails 8 runs without Redis via Solid Cache/Queue/Cable. Add Redis only if you already need it.

**Front-end**
- Hotwire (Turbo + Stimulus).
- CSS: `tailwindcss-rails`.
- JS packaging: importmap unless a bundler is clearly required.

**Assets**
- Propshaft (Rails 8 default).

**Auth**
- Start with the Rails 8 auth generator (auditable baseline). If SAML/OIDC or complex flows appear, swap to Devise/Sorcery later; keep the boundary clean.

**Background jobs & scheduling**
- Active Job + Solid Queue by default.
- Recurring work: small scheduler or a worker container that loops rake tasks.

**File uploads**
- Active Storage: MinIO for self-host (portable S3), S3/Backblaze/etc when hosted.

## 3. Domain Model (Band-Manager Friendly)

**Core entities**
- User
- Account (customer/org/workspace; even self-host can default to one)
- Membership (user ↔ account, role)
- Band (belongs to account)
- BandMembership (user ↔ band, role; many users across bands)

**Band-scoped resources**
- Event (gig/rehearsal; datetime, venue, notes)
- Setlist (for an Event; ordered songs)
- Song (shared per account or per band—decide)
- Task (band todo)
- Message/Thread (optional; comments on objects are often enough)
- Document/Attachment (Active Storage)
- Invite (invite user to account/band)

**Permissions**
- Two-level roles: Account (owner/admin/member) and Band (band_admin/member/read_only).
- Keep authorization explicit with a single gem (e.g., Pundit) and policy specs.

## 4. Architecture Conventions (Reduce Magic)

**Folders**
- app/models — lean models (validations, associations, small scopes).
- app/services — business operations (e.g., Bands::Create, Events::Publish).
- app/queries — non-trivial query objects.
- app/policies — authorization (Pundit).
- app/components (optional) — ViewComponent for reusable UI.

**Rules of thumb**
- Avoid “god models”; if a method needs 3+ collaborators, use a service.
- Limit callbacks to invariant bookkeeping.
- Controllers stay thin: load → authorize → service → render.

## 5. Hotwire UI Patterns

**Turbo for:** fast navigation (Drive), form submissions with errors, inline CRUD (Frames), live updates (Streams).

**Stimulus for:** focused behaviors (date pickers, drag/drop ordering, copy invite link, etc.).

**JS budget:** prefer HTML+CSS+Turbo; add small, testable Stimulus controllers; isolate any heavy client state to a single surface (avoid creeping SPA).

Keep the Turbo handbook as the shared reference.

## 6. Self-Hosting (docker-compose)

**Compose targets**
- docker-compose.yml — production-like single node.
- docker-compose.dev.yml — development conveniences (bind mounts, live reload).

**Services**
- web (Rails)
- worker (Solid Queue / Active Job runner)
- db (Postgres)
- minio (optional)
- caddy or traefik (optional TLS/reverse proxy)

**Deliverables**
- .env.example
- bin/setup (creates DB, runs migrations, seeds demo)
- bin/upgrade (backup reminder, migrate, restart)
- docs/self_hosting.md (copy/paste commands)

## 7. Quality Bar: Tests, Lint, Security, CI

**Testing**
- RSpec or Minitest—pick one and stick to it.
- System tests (Playwright or Capybara) for Hotwire UX.
- FactoryBot plus a small demo-band fixture set.

**Static checks**
- RuboCop or StandardRB.
- Brakeman.
- bundler-audit or ruby-audit.

**CI (GitHub Actions)**
- On every PR: bundle install with cache, lint, unit + request specs, system specs (headless), security scans.

## 8. Operational Readiness

**Migrations & releases**
- Release step migrates before restart.
- Prefer additive migrations; backfill via jobs to avoid locks.

**Observability**
- Structured logging (JSON in prod is helpful).
- Health endpoint (/up) and readiness checks.
- Optional error reporting (Sentry/Honeybadger/etc.).

## 9. Repo Hygiene (OSS)

- README.md (purpose, screenshots, quickstart, self-host steps).
- CONTRIBUTING.md (dev setup, branching, PR expectations).
- CODE_OF_CONDUCT.md.
- SECURITY.md (vuln reporting path).
- docs/architecture.md (domain model + key decisions).
- docs/adr/ (short decision records: why Hotwire, why single-tenant, etc.).

## 10. Rails 8 Decisions

**Adopt**
- Rails 8 defaults: Propshaft, Kamal 2, auth generator.
- Solid adapters unless Redis is clearly needed.

**Explicitly decide**
- Postgres vs SQLite for production (SQLite is more viable now, Postgres remains expected for OSS SaaS).
- Song library scope: per-account or per-band.
- Messaging: in-app vs integrations (email/Discord/etc.).

## 11. Current Implementation Notes

**Foundations in place**
- Rails 8 scaffold with Propshaft, importmap, Turbo, Stimulus, Tailwind.
- Auth flow via Rails auth generator (sessions + password reset).
- Pundit policies for Account and Band.

**Core models**
- User, Account, Membership, Band, BandMembership with role enums and validations.
- Seed data creates a demo user/account/band for local development.

**Navigation + shell**
- Responsive header navigation for Bands/Songs/Events/Setlists/Tasks.
- Placeholder index pages for non-implemented sections.

**Band management**
- Band CRUD with account scoping.
- Band member management (add/update/remove) with role enforcement.

**Songs**
- Song library CRUD scoped to account.
- Tagging via account-level tags and polymorphic taggings.
- Search and filters by title/artist/tags.

**Dev stack**
- Local dev compose stack includes Rails web container, Postgres, Redis, and MinIO.
