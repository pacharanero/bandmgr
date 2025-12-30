## Key Features

A comprehensive Band Management Platform to help bands organise their music, gigs, members, and equipment. Designed to reduce the workload of running a band, allowing musicians to focus on making music.

### Key Features

- Song management: store and organise your band's songs with details like title, artist, album, key, tempo, tags, and external links (e.g., GoogleDocs chart, YouTube).
- Gig scheduling: plan and manage gigs with date, time, venue, setlist, and reminders.
- Setlist creation: build and manage setlists for gigs, associating songs from your repertoire.
- Member management: manage band members with roles and permissions.
- Equipment tracking: keep an inventory of your band's equipment and manage stage layouts.
- Tagging system: use tags to organise songs, gigs, setlists, and members for easier searching and filtering.
- Data import/export: import songs from Plain Text, Markdown, or CSV files; export band data to YAML for backup or transfer.
- Simple band website: gallery, booking info, static content (optional band website replacement)

### User Interface
- Light and dark mode with DaisyUI
- Responsive design for desktop and mobile

### Bands

- Multi-band support within a single instance - an instance of Bandmgr can have many bands
- Manage band members with roles and permissions, and set a 'default' band for each member
- Customizable band settings and preferences - default band
- Branding and theme customization per band
- Custom domain support per band

**Current implementation (MVP)**
- Account setup flow with a default band per account.
- Bands CRUD (name, description) scoped to account.
- Band roles defined (band_admin, member, read_only).
- Band member management UI (add/update/remove) for admins.

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

- Rails 8 scaffold with Hotwire + Tailwind.
- Auth (login, signup, password reset) with account scoping.
- Account + band models with role-based memberships.
- Pundit policies for account/band access.
- Responsive nav shell with placeholder pages for Events, Setlists, Tasks.
- Song library CRUD with tags and search/filtering.

### Import/Export

- Import songs from Plain Text, Markdown, CSV files
- Export band data to YAML for backup or transfer
- Sync to cloud storage providers (Google Drive, Dropbox)

### Band Website

- Simple customizable band website to showcase your band
- Gallery for photos and videos
- Booking information and contact form
- Static content pages (About, Bio, Press Kit)
- Calendar sync for band availability and gigs
- Google Maps embed for Venues We've Played

## Ideas for future features

- Performance Mode: step through lyrics and charts in SetList order, synchronized across band members (mobile-friendly)
- Practice Mode: surface songs with least practice or not recently gigged, or in a random order
- Markdown-based Song Editor (inline charts/lyrics instead of only external links)
- Online store
