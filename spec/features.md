## Key Features

- Song duration tracked in minutes/seconds; singer can be selected from band members or entered as free text.

### Key Features

- Song management: store and organise your band's songs with details like title, artist, key, tempo, tags, timings, and external links (e.g., GoogleDocs chart, YouTube); import from plain text, markdown, or CSV.
- Gig scheduling: plan and manage gigs with date, time, venue, setlist, and reminders; embed venue location with Google Maps.
- Setlist creation: build and manage setlists for gigs, associating songs from your repertoire with drag-and-drop (including bulk add from song search/filter results).
- Member management: manage band members with roles and permissions.
- Equipment tracking: keep an inventory of your band's equipment and manage stage layouts.
- Tagging system: use tags to organise songs, gigs, setlists, venues, and members for easier searching and filtering.
- Data import/export: import songs from Plain Text, Markdown, or CSV files; export band data to YAML for backup or transfer.
- Simple band website: gallery, booking info, static content (optional band website replacement)

### Tagging

- Tags live in a tags collection; taggings use polymorphic records (tag_id, taggable_type, taggable_id) so songs, members, events, setlists, and equipment can all be tagged.
- Tags power advanced search and filtering across entities; some entities may expose user-defined custom fields alongside tags.

### User Interface
- Light and dark mode with DaisyUI
- Responsive design for desktop and mobile
- Sidebar navigation for fast access to repertoire, gigs, and settings
- Creation flows for song/venue/gig/setlist run in modal dialogs to avoid context switching

### Bands

- Multi-band support within a single instance - an instance of Bandmgr can have many bands
- Manage band members with roles and permissions, and set a 'default' band for each member
- Customizable band settings and preferences - default band
- Bands own songs, gigs/events, setlists, members, equipment, and a stage layout
- Bands have an instance owner/admin
- Branding and theme customization per band
- Custom domain support per band

### Gigs

- Schedule and manage gigs with date, time, venue, and setlist
- Venue management with address, contact info, and notes
- Gig reminders and notifications
- Gig history and statistics
- Recurring gigs support
- Calendar integration - sync with Google Calendar and send invites to band members

### Repertoire and Setlists

- Manage the songs in your repertoire
- Create and manage setlists and associate them with gigs
- use tags to add additional organisation
- Drag-and-drop to add songs to setlists; bulk add via multi-select from search/filter results
- Custom band website with merch store
- Admin interface for all models
- User authentication (login, signup, logout)
- Automated YouTube and Spotify playlist synchronization from SetLists

### Communications

- Band member messaging (private instant messaging, group chat)
- Mini-forum for band discussions without having to resort to WhatsApp
- Google Drive linking (docs, sheets)

### Integrations

- Bandcamp integration (merch, music sales)
- SoundCloud integration (audio tracks, playlists) - Manage recordings via linked SoundCloud account
- Spotify integration (playlists, album links)
- YouTube integration (videos, music, playlists) - Automatically create a YouTube Playlist from a band SetList so you can listen through the set before a gig
- Calendar integration (gigs, events, reminders)
- Social media integration (Facebook, Twitter, Instagram) for easy cross-promotion

### Band Management

- Equipment inventory management (link gear to gigs / transport lists)
- Stage layout management - Stage Plans and FOH notes
- Custom domain support
- Logo, branding, and theme customization
- External photos and video gallery
- Electrical safety (PAT testing in UK) records and reminders
- Band funds tracking (income, expenses, simple ledger)

## Implementation status (so far)

- Responsive nav shell with placeholder pages for Events, Setlists, Tasks.
- Song library CRUD with tags, search/filtering, sorting, and import (plain text/markdown/CSV).
- Events CRUD with gig/rehearsal types and notes.
- Setlist data model and associations (setlists, setlist songs, event links) with placeholder UI.

### Import/Export

- Import songs from Plain Text, Markdown, CSV files
- Export band data to YAML for backup or transfer
- Sync to cloud storage providers (Google Drive, Dropbox)

### Band Website

- Simple customizable band website to showcase your band
- Gallery for photos and videos
- Booking information and contact form
- Online band booking inquiry form
- Static content pages (About, Bio, Press Kit)
- Calendar sync for band availability and gigs
- Google Maps embed for Venues We've Played

## Ideas for future features

- Performance Mode: step through lyrics and charts in SetList order, displaying the right view on each band member's mobile device and staying in sync
- Practice Mode: surface songs with least practice or not recently gigged, or in a random order
- Markdown-based Song Editor (inline charts/lyrics instead of only external links)
- Online store

## Entities
Human-readable overview of the main data entities and their relationships.

### Account
- Account (customer/org/workspace; even self-host can default to one)
- Accounts can have many Bands
- Accounts needs at least one Admin

### Band
- Bands belong to an Account
- Users can belong to many Bands
- A Band can be set as the default Band for a User

### User

- Membership (user ↔ account, role)
- Band (belongs to account)
- BandMembership (user ↔ band, role; many users across bands)

### Song
- Songs belong to a Band
- Songs can be organised into Setlists
- Default song listing sort: artist ASC then title ASC; users can configure primary sort (artist | title | album | tempo) with sensible secondary fallback
- Song detail view opens from list click and exposes full attributes for viewing/editing
- Song imports support Plain Text, Markdown, or CSV

### Setlist
- A Setlist belongs to a Band
- A Setlist has many Songs
- Setlists have an order of Songs
- 

### Event
- An Event is a Gig, Rehearsal, or other band-related occurrence.
- A Setlist can be associated with an Event.

**Band-scoped resources**
- Song (shared per account or per band—decide)
- Task (band todo)
- Message/Thread (optional; comments on objects are often enough)
- Invite (invite user to account/band)

