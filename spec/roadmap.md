# Roadmap

This is the active product and engineering backlog. Completed work belongs in Git history and the relevant specification, not in this file.

Legend: [x] done, [~] in progress, [ ] not started.

## Work Session 1 - Security And Tenant Boundaries

- [~] **R5 - Expand cross-account and cross-band authorisation regression coverage** to every privileged workflow.

## Work Session 2 - Collaboration Workflows

- [x] **R6 - Complete in-app threaded chat** for band members, building on the existing channels, direct messages, reactions, and browser notifications.
- [x] **R7 - Add a band task list** with status and assignee.
- [x] **R8 - Add comments** on tasks, events, and songs.
- [x] **R9 - Add in-app notification placeholders** for collaborative activity.
- [x] **R10 - Cover collaboration policies and workflows** with focused tests.

## Work Session 3 - Files And Background Work

- [x] **R11 - Add attachments** to songs, events, and setlists.
- [x] **R12 - Provide document listing, permissions, and file size/type validation.**
- [x] **R13 - Run background jobs in a dedicated production process** when the workload requires it.
- [x] **R14 - Add recurring reminders and cleanup jobs.**
- [x] **R15 - Add job failure logging or alerts and job specifications.**

## Work Session 4 - Band Experience

- [x] **R16 - Establish the application visual system** with intentional Tailwind/DaisyUI theme, typography, and spacing tokens.
- [x] **R17 - Make key workflows keyboard-accessible** and provide non-drag alternatives for setlist ordering.
- [x] **R18 - Improve mobile layouts, empty states, and a reusable style guide page.**
- [x] **R19 - Build the public band website** with About, gallery, booking information, static content, merchandise, and an external-link directory.
- [ ] **R20 - Add equipment inventory and stage-plan management.**

## Work Session 5 - API And CLI

- [ ] **R52 - Add a versioned REST API** (`/api/v1/`) covering all band, member, song, setlist, event, task, comment, attachment, and notification resources.
- [ ] **R53 - Add user-managed API keys** with optional band scoping and operation limits (read/write/delete), never exceeding the owner's GUI permissions.
- [ ] **R54 - Build `bmgr` CLI** wrapping the API for scripted and LLM-driven automation (mirroring `sct`/`dsc` patterns: subcommands, JSON output, shell completions).
- [ ] **R55 - Document the API** with OpenAPI/Swagger and example curl/bmgr recipes for common workflows.

## Work Session 6 - Operations And Self-Hosting

- [ ] **R21 - Add structured production logging and useful log tags.**
- [ ] **R22 - Define error-reporting and minimal metrics integration points.**
- [ ] **R23 - Document production operations** including configuration, upgrades, backup and recovery expectations, and deployment verification.
- [ ] **R24 - Add self-hosted scheduled backups** to local disk or S3-compatible storage.
- [ ] **R38 - Replace deploy-time SSH host discovery** with a reviewed, managed host-key trust policy.

## Work Session 6 - Quality And Community

- [ ] **R25 - Expand model, controller, and request coverage** for edge cases, validations, and business rules.
- [ ] **R26 - Add system coverage for song management, event scheduling, and setlist creation.**
- [ ] **R27 - Add code coverage reporting** and document testing conventions.
- [ ] **R28 - Add issue and pull-request templates** for public contributions.
- [ ] **R29 - Record durable architecture decisions** using a lightweight ADR format in `docs/adr/`.
- [ ] **R30 - Complete source-file SPDX/REUSE compliance** for code and written content.

## Work Session 7 - Data Portability

- [ ] **R31 - Define versioned Markdown interchange schemas** and a manifest for portable band-data bundles.
- [ ] **R32 - Export all band data** as a portable Markdown bundle for backup or transfer.
- [ ] **R33 - Import a band from a validated, previewed backup bundle.**
- [ ] **R51 - Add lossless setlist Markdown import and export** with stable identifiers, ordered entries, notes, and explicit handling for unresolved song references.

## Work Session 8 - Beta Hardening

- [ ] **R34 - Run a full regression pass** across the core member workflows.
- [ ] **R35 - Resolve critical defects and performance hotspots.**
- [ ] **R36 - Review the security posture** including CSRF protections and authorisation coverage.
- [ ] **R37 - Publish beta release notes and tag the first beta.**

## Work Session 9 - Band Assistant

- [ ] **R39 - Define the assistant trust boundary** including supported providers, key ownership, consent, provider data-retention expectations, usage limits, and an account owner's ability to disable the feature.
- [ ] **R40 - Add encrypted bring-your-own-key provider configuration** for OpenRouter, OpenAI, Anthropic, and approved self-hosted providers.
- [ ] **R41 - Build an authorisation-aware band knowledge corpus** from the data a member is permitted to access, with retrieval that cannot cross account, band, or private-chat boundaries.
- [ ] **R42 - Add a conversational assistant** that answers band-member questions with source citations and deep links to the relevant bandmgr record or view.
- [ ] **R43 - Protect the assistant against prompt injection and unsafe actions** by treating retrieved content as untrusted, limiting tools to approved read-only operations, and requiring explicit human confirmation for consequential changes.
- [ ] **R44 - Create evaluation fixtures and audit evidence** for answer accuracy, source attribution, and access-control boundaries.

## Work Session 10 - Performance Mode

- [ ] **R45 - Define the performance session model** around a gig, its setlist, members' device roles, a session leader, and reconnect/resynchronisation behaviour.
- [ ] **R46 - Build a shared live performance view** that keeps charts, lyrics, and the current setlist position synchronised across participating devices through Action Cable.
- [ ] **R47 - Provide resilient manual controls** for next/previous song, direct song selection, local catch-up after disconnects, and an accessible non-touch workflow.
- [ ] **R48 - Model MIDI cues per song and setlist position** for lighting, effects, guitar processors, and other supported equipment.
- [ ] **R49 - Add guarded MIDI output** with explicit device selection, enable/disable controls, a dry-run preview, and clear failure feedback.
- [ ] **R50 - Test performance mode in rehearsal** with multiple devices, unreliable network conditions, chart changes, and connected MIDI equipment.
