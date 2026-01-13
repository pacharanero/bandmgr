# Architecture

## Platform

- Rails 8 is the primary stack: a server-rendered web app with Hotwire (Turbo + Stimulus).
- Responsive UI is the primary delivery surface; mobile and desktop share the same web app.
- Postgres in development and production.
- DaisyUI is used for component styling and theming.

## Delivery targets

- Modern browsers on desktop and mobile.
- Responsive layouts: compact navigation on small screens, sidebar/navigation rail on larger screens.
- Progressive enhancement via Turbo Frames/Streams for fast interactions.
- Server-side REST API for future mobile app or 3rd-party integrations.

## Local data persistence

- Primary: Postgres (production) with the option to evaluate SQLite for simpler deploys.
- Files and media stored via Active Storage to local disk.

## Containerisation

- Self-hosting is encouraged and supported.
- Docker Compose setup for local development and self-hosted production.

## Application flow and layering

- Controllers stay thin: load → authorize → service → render.
- Business logic in explicit service objects and query objects.
- Turbo handles fast navigation and live updates; Stimulus adds focused behaviors.

## Domain model conventions

- Active Record models with clear boundaries and minimal callbacks.
- Entities: Account, User, Membership, Band, BandMembership, Song, Setlist (+ SetlistSongs for ordering), Event (Gig), Equipment, Tag, Tagging.

## Pending architecture decisions

- Postgres for production and self-hosted installs.
- Messaging: in-app threads vs lightweight comments and notifications.
