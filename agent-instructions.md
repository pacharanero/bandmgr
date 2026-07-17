# Agent Instructions

bandmgr is a self-hostable Rails application for bands to manage shared repertoire, setlists, events, members, and communication. It is a single Rails application, not a collection of microservices.

Read this file before changing the repository.

## Read First

- [README.md](README.md) - product purpose and local setup.
- [spec/README.md](spec/README.md) - specification reading order.
- [spec/architecture.md](spec/architecture.md) - application design constraints.
- [spec/roadmap.md](spec/roadmap.md) - planned work sessions.
- [~/code/house-style/AGENTS.md](~/code/house-style/AGENTS.md) - cross-repository standards.

## Core Invariants

- Scope all account and band data, and authorise access through Pundit before rendering or mutating it.
- Keep secrets out of Git, logs, and browser responses. `.kamal/secrets` is local-only.
- Preserve the Rails layering: controllers load and authorise, service/query objects hold non-trivial business logic, and policies state access rules.
- Keep the Docker development environment and production Kamal configuration working for supported self-hosting.

## Workflow

- `s/dev` - start the local stack.
- `s/seed` - prepare and seed local data.
- `s/test` - run unit and system tests.
- `s/lint` - run RuboCop.
- `s/scan` - run static and dependency security checks.

## Before Every Commit

```sh
s/lint
s/scan
s/test
```

## Approval Required

Ask before publishing a release, deploying, changing credentials or GitHub secrets, deleting branches, force-pushing, or interacting with systems outside this repository.
