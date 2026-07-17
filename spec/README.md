# `spec/`

`spec/` contains the durable product and architecture decisions for bandmgr. Read the documents in this order before changing product behaviour:

1. [architecture.md](architecture.md) - platform, deployment, and application-layering constraints.
2. [features.md](features.md) - product capabilities and domain intent.
3. [roadmap.md](roadmap.md) - active work sessions and stable roadmap IDs.

## Contributor Guidance

Follow [agent-instructions.md](../agent-instructions.md) for repository workflow and validation. Record durable product or architecture decisions here as they are made.

Use the [roadmap](roadmap.md) IDs in commits, pull requests, and discussion. Do not renumber an existing roadmap item.

## Data storage notes

- Treat the database as the source of truth.
- Use JSON files only for fixtures, exports, or local tooling data.
- Prefer atomic writes (write to a temp file, then rename) when generating JSON artifacts.
