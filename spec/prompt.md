# Prompt

This document forms persistent prompt instructions for LLMs writing code in this project.

- Read the whole codebase to understand context
- Understand the problem and the specific feature being implemented
- Ask questions if necessary
- Write code that is clean, well-structured, and follows best practices
- Every file should have documentation explaining what it does
- Every function or object should have a comment explaining its purpose
- Write tests for new features and bug fixes
- Ensure code is efficient and handles edge cases
- Always check that imports are declared when needed
- Follow the coding style and conventions used in the existing codebase
- As decisions are made, add them to this prompt, or the spec files in `spec/`, as necessary
- Repetitive developer operations (build, migrate, run) should be automated with scripts in `s/`

## Architectural Conventions (Updated for Drift Offline Store)

- Offline-first: Drift (SQLite) is the source of truth; remote sync layer to be added later.
- YAML mention in early docs superseded by Drift for runtime; YAML can be export/import format.
- Local DB file path: application documents directory /bandmgr.db
- Data layer: drift tables -> DAOs -> repositories -> Riverpod providers -> UI.
- Tagging: generic Tag + Taggings join table (entityType, entityId) for flexible tagging.
- Entities: Instance (implicit / config), Band, Member, Song, Setlist(+SetlistSongs for ordering), Event (Gig), Equipment, Tag, Tagging.
- Immutability in domain models; mapping layer between Drift data classes and domain.
- Repositories expose Streams for reactive UI updates.
- Testing: each new table needs a DAO test + repository test.

## Pending (Next Iteration)

- Sync protocol design (conflict resolution, tombstones).
- Authentication & multi-instance separation (namespace strategy).
- Responsive UI (bottom nav vs sidebar) implementation.

## Pending Clarifications

- Auth method? Initially no auth needed.
- Offline requirements?
- Primary features + prioritization?
- Multi-band per user?
- Hosting backend?

(Answer these so we can continue deeper.)

## Feature: Song List & Import

- Import supports:
  - Plain Text: "Title - Artist" per line (artist optional)
  - Markdown: bullet/numbered list lines parsed same pattern
  - CSV: header with at least 'title' (optional 'artist')
- Duplicate detection: (bandId, title, artist/null) uniqueness heuristic
- Future: extended columns (album, key, tempo) for CSV; tag assignment during import; file picker.

## Drift Companion Usage

- When using `*Companion.insert`, provide only required fields.
- For optional/nullable or defaulted columns, either omit them (preferred) or wrap values with `Value(...)`.
- Example:
  `await into(songs).insert(SongsCompanion.insert(id: someId, bandId: bandId, title: 'Name'));`
  Not: `externalJson: '{}'` (wrong) – use `externalJson: const Value('{}')` if you must override default.
