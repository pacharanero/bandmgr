# Bandmgr Flutter app

## Platform

- Flutter has been chosen as it is a modern framework with good support, which can be used to build mobile apps, desktop apps, and web apps from a single codebase.
- Offline-first design is a primary feature, allowing full functionality without an internet connection.
- Data is stored locally-first using Drift (SQLite), with later option to sync data to a backend server.
- The app will sync data with a backend server when an internet connection is available.

## General Development Practices

- Helper scripts are placed in the `s/` directory (e.g., `build`, `up`, `down`, `migrate`)
- Persistent documentation of new features and requirements is maintained in this file

## Flutter targets

- The application targets all Flutter deployment types: mobile (iOS, Android), desktop (Windows, macOS, Linux), and web.
- On mobile, it supports both portrait and landscape orientations.
- On small screen devices, a bottom navigation bar is used; on larger screens, a sidebar is employed.
- On web, it adapts to different screen sizes and orientations using responsive design principles.

## Local data persistence

- Primary: Drift (SQLite). (Earlier note about YAML: treat as optional import/export format, not live store.)

## Tagging

- Tags stored in Tags table.
- Taggings join table (tagId, entityType, entityId) enables polymorphic tagging of songs, members, events, setlists, equipment.

## Data Model

- All data entities can have Tags to help more advanced searching and organisation

### Instance

- An instance of Bandmgr can have many bands

### Band

- Bands have many: songs, gigs, setlists, and members
- Bands have Equipment
- Bands have a Stage layout
- Bands belong to an Owner (admin)

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
