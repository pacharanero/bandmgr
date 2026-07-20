# Persistence And Portability

## Decision

Postgres is bandmgr's operational source of truth. Markdown is a first-class format for portable exports, imports, document-like authored content, and assistant retrieval representations. The application will not use a filesystem tree of Markdown files as its primary persistence layer.

## Why Postgres Remains Authoritative

Bandmgr is a collaborative application with account and band isolation, member roles, private conversations, live performance sessions, attachments, reminders, and background jobs. These workflows need transactions, efficient relational queries, authorisation at read and write time, durable indexes, concurrent-edit handling, and predictable backup and recovery. Rails and Postgres provide those capabilities directly.

Treating files as primary persistence would move those responsibilities into custom filesystem, locking, indexing, synchronisation, and permission code. That would duplicate the hard parts of a database while weakening the Rails model.

## Markdown Boundaries

Markdown is appropriate where a person, a version-control workflow, or another tool benefits from reading and editing the representation directly.

- Setlists are the first lossless import/export target.
- Band backup and transfer uses a bundle with a manifest and one portable representation per entity, rather than a single monolithic document.
- Song charts, lyrics, technical riders, and performance notes may be Markdown-authored assets where that improves the member workflow.
- Markdown exports are stable input to human review, Git workflows, and authorised assistant retrieval.

Markdown export does not grant access to data. The application always enforces account, band, and member permissions before generating or importing a file.

## Portable File Contract

Every portable entity file has YAML frontmatter with at least a schema version, stable entity identifier, entity type, and owning band identifier. References use stable identifiers, not names alone. The body is human-readable Markdown and preserves the ordered or document-like information that matters for the entity.

```markdown
---
schema_version: 1
type: setlist
id: "setlist_01..."
band_id: "band_01..."
title: "13 August gig"
event_id: "event_01..."
---

1. Song title - Artist
2. Another song - Artist
```

The exact schema is defined and tested before an importer is released. Generated files are written atomically. A bundle manifest records its schema version, export time, source instance identity, and included files.

## Import Rules

Imports are previewed, validated mutations, never blind overwrites. The importer resolves references by stable identifier first, identifies ambiguous name matches, reports additions, removals, conflicts, and unresolved references, and applies changes only after a permitted member confirms the plan. Imports create an activity record and preserve enough provenance to diagnose a later problem.

## Assistant Corpus

The assistant does not read raw database files or bypass application permissions. It retrieves an authorised representation of records the requesting member can access and cites those records in its answer. Deep links take the member back to the relevant bandmgr view. Retrieved text is untrusted input to the model, not executable instruction.

## Non-Goals

- A Markdown filesystem as the primary database for mutable collaborative state.
- Implicit file watching that silently overwrites database records.
- Name-only imports that can silently connect a setlist entry to the wrong song.
- Assistant access to another account, band, or private conversation through an export or retrieval index.
