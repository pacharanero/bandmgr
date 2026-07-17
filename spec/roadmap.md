# Roadmap

This is the active product and engineering backlog. Completed work belongs in Git history and the relevant specification, not in this file.

Legend: [x] done, [~] in progress, [ ] not started.

## Work Session 1 - Security And Tenant Boundaries

- [ ] **R1 - Enforce Pundit verification** across controllers, with explicit, tested exceptions for public endpoints.
- [ ] **R2 - Restrict direct-chat access** so only channel participants can read, send, or react to direct messages.
- [ ] **R3 - Encrypt account integration credentials** and provide a safe migration path for existing values.
- [ ] **R4 - Enable a nonce-based content security policy** for the Rails application.
- [ ] **R5 - Add cross-account and cross-band authorisation regression tests** for every privileged workflow.

## Work Session 2 - Collaboration Workflows

- [ ] **R6 - Complete in-app threaded chat** for band members, building on the existing channels, direct messages, reactions, and browser notifications.
- [ ] **R7 - Add a band task list** with status and assignee.
- [ ] **R8 - Add comments** on tasks, events, and songs.
- [ ] **R9 - Add in-app notification placeholders** for collaborative activity.
- [ ] **R10 - Cover collaboration policies and workflows** with focused tests.

## Work Session 3 - Files And Background Work

- [ ] **R11 - Add attachments** to songs, events, and setlists.
- [ ] **R12 - Provide document listing, permissions, and file size/type validation.**
- [ ] **R13 - Run background jobs in a dedicated production process** when the workload requires it.
- [ ] **R14 - Add recurring reminders and cleanup jobs.**
- [ ] **R15 - Add job failure logging or alerts and job specifications.**

## Work Session 4 - Band Experience

- [ ] **R16 - Establish the application visual system** with intentional Tailwind/DaisyUI theme, typography, and spacing tokens.
- [ ] **R17 - Make key workflows keyboard-accessible** and provide non-drag alternatives for setlist ordering.
- [ ] **R18 - Improve mobile layouts, empty states, and a reusable style guide page.**
- [ ] **R19 - Build the public band website** with About, gallery, booking information, static content, merchandise, and an external-link directory.
- [ ] **R20 - Add equipment inventory and stage-plan management.**

## Work Session 5 - Operations And Self-Hosting

- [ ] **R21 - Add structured production logging and useful log tags.**
- [ ] **R22 - Define error-reporting and minimal metrics integration points.**
- [ ] **R23 - Document production operations** including configuration, upgrades, backup and recovery expectations, and deployment verification.
- [ ] **R24 - Add self-hosted scheduled backups** to local disk or S3-compatible storage.

## Work Session 6 - Quality And Community

- [ ] **R25 - Expand model, controller, and request coverage** for edge cases, validations, and business rules.
- [ ] **R26 - Add system coverage for song management, event scheduling, and setlist creation.**
- [ ] **R27 - Add code coverage reporting** and document testing conventions.
- [ ] **R28 - Add issue and pull-request templates** for public contributions.
- [ ] **R29 - Record durable architecture decisions** using a lightweight ADR format in `docs/adr/`.
- [ ] **R30 - Complete source-file SPDX/REUSE compliance** for code and written content.

## Work Session 7 - Data Portability

- [ ] **R31 - Decide and document the canonical backup exchange format** for band data.
- [ ] **R32 - Export all band data** for backup or transfer.
- [ ] **R33 - Import a band from a validated backup export.**

## Work Session 8 - Beta Hardening

- [ ] **R34 - Run a full regression pass** across the core member workflows.
- [ ] **R35 - Resolve critical defects and performance hotspots.**
- [ ] **R36 - Review the security posture** including CSRF protections and authorisation coverage.
- [ ] **R37 - Publish beta release notes and tag the first beta.**
