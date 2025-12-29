## Key Features (Initial)

- Manage songs, setlists, gigs, and bands
- Tagging system for songs, setlists, gigs, and bands
- Custom band website with merch store
- Admin interface for all models
- User authentication (login, signup, logout)
- Responsive UI using Semantic UI
- Band member messaging (instant messaging, group chat and email)
- Google Drive linking (docs, sheets)
- Bandcamp integration (merch, music sales)
- SoundCloud integration (audio tracks, playlists)
- Spotify integration (playlists, album links)
- YouTube integration (videos, playlists)
- Calendar integration (gigs, events, reminders)
- Social media integration (Facebook, Twitter, Instagram) for easy cross-promotion
- Equipment inventory management
- Stage layout management
- Custom domain support
- Logo, branding, and theme customization
- External photos and video gallery

## Current Early Implementation (App Scaffold)

- Offline-first Drift DB scaffold
- Song List screen with basic import (Plain Text, Markdown, CSV)
- Duplicate detection on (title, artist)
- Initial domain models (Band, Member, Song, Setlist scaffolding)

## Worklist (Active Development)

These are features currently being actively designed or implemented:

- Copy a SetList to a new one
- Drag-and-drop to add Songs to a SetList (bulk add via drag/drop)
- Song search / filter in lists
- Pick list (selector) for `Song.key`
- Tag handling improvements for Songs, SetLists, Gigs, Venues (extended taxonomy, UI polish)
- Sidebar navigation overhaul
- Google Maps embed for Venues
- New Song / Venue / Gig / SetList creation in a modal dialog
- Equipment tracking refinements (link gear to gigs / transport lists)
- Band funds tracking (income, expenses, simple ledger)

## Roadmap (Planned / Nice-to-Have)

Ideas that would be valuable but are not yet scheduled. Community feedback & contributions welcome:

- Performance Mode: step through lyrics and charts in SetList order, synchronized across band members (mobile-friendly)
- Practice Mode: surface songs with least practice or not recently gigged
- Markdown-based Song Editor (inline charts/lyrics instead of only external links)
- Simple public Band Pages: gallery, booking info, static content (optional band website replacement)
- Online band booking inquiry form
- Google Calendar integration and availability sync (enhanced beyond current calendar linking)
- Automatically create a YouTube Playlist from a SetList
- Manage recordings via linked SoundCloud account
- Manage Stage Plans and FOH notes (beyond current stage layout basics)
- Automated YouTube and Spotify playlist synchronization from SetLists
- Advanced merch and store analytics dashboard

## Feature: Song List and Import

- Import supports:
  - Plain Text: "Title - Artist" per line (artist optional)
  - Markdown: bullet/numbered list lines parsed same pattern
  - CSV: header with at least 'title' (optional 'artist')
- Duplicate detection: (bandId, title, artist/null) uniqueness heuristic
- Future: extended columns (album, key, tempo) for CSV; tag assignment during import; file picker
