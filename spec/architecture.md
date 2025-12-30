# Architecture

## Platform

- Rails 8 is the primary stack: a server-rendered web app with Hotwire (Turbo + Stimulus).
- Responsive UI is the primary delivery surface; mobile and desktop share the same web app.
- Data lives in a relational database (Postgres in production; SQLite is a possible dev/prod option).
- DaisyUI is used for component styling and theming.

## Delivery targets

- Modern browsers on desktop and mobile.
- Responsive layouts: compact navigation on small screens, sidebar/navigation rail on larger screens.
- Progressive enhancement via Turbo Frames/Streams for fast interactions.
- Server-side REST API for future mobile app or 3rd-party integrations.

## Local data persistence

- Primary: Postgres (production) with the option to evaluate SQLite for simpler deploys.
- Files and media stored via Active Storage (S3/MinIO/etc.).

## Containerisation

- Self-hosting is encouraged and supported.
- Docker Compose setup for local development and self-hosted production.

## Tagging

- Tags stored in a tags collection.
- Taggings stored as records with (tagId, entityType, entityId) to enable polymorphic tagging of songs, members, events, setlists, equipment.

## Data Model

- All data entities can have Tags to help more advanced searching and organisation.
- Some data entities will have user-definable custom fields.

### Band

- Bands have many: songs, gigs, setlists, and members
- Bands have Equipment
- Bands have a Stage layout
- Bands belong to an Instance Owner (admin)

### Member

- Members belong to a band and can have roles (e.g., admin, editor, viewer)

### Songs

- Songs belong to a band and have attributes like title, artist, album, key, tempo, tags, and external links (e.g., GoogleDocs chart, YouTube)
- Song listing default sort: artist, then title (alphabetical ascending) but this is configurable by user preference
- Configurable sorting (persisted): default Artist ASC then Title ASC
- User can choose primary sort field: artist | title | album | tempo
- Secondary sort automatically falls back to title ASC (except when title primary -> artist ASC)
- Sort order toggle (ASC/DESC)
- Clicking on a song in the list opens the Song Detail view
- Song Detail view shows all song attributes and allows editing
- Songs can be imported from Plain Text, Markdown, or CSV files

## Application flow and layering

- Controllers stay thin: load → authorize → service → render.
- Business logic in explicit service objects and query objects.
- Turbo handles fast navigation and live updates; Stimulus adds focused behaviors.

## Domain model conventions

- Active Record models with clear boundaries and minimal callbacks.
- Entities: Account, User, Membership, Band, BandMembership, Song, Setlist (+ SetlistSongs for ordering), Event (Gig), Equipment, Tag, Tagging.

## Pending architecture decisions

- Postgres vs SQLite for production and self-hosted installs.
- Song library scope: per-account vs per-band.
- Messaging: in-app threads vs lightweight comments and notifications.
