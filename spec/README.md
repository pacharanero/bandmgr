# `spec/`

`spec/` contains specifications and documentation for the Band Manager project, including architecture decisions, feature specifications, and prompt instructions for LLMs contributing code.

## LLM prompt guidance

This project keeps lightweight, persistent guidance for LLM contributors:

- Read the relevant parts of the codebase to understand context.
- Understand the problem and the specific feature being implemented.
- Ask questions if necessary.
- Write code that is clean, well-structured, and follows best practices.
- Document files when the purpose is not obvious.
- Add concise comments for non-obvious functions or objects.
- Write tests for new features and bug fixes.
- Ensure code is efficient and handles edge cases.
- Always check that imports are declared when needed.
- Follow the coding style and conventions used in the existing codebase.
- As decisions are made, add them to `spec/` as necessary.
- Repetitive developer operations (build, migrate, run) should be automated with scripts in `s/`.

## Data storage notes

- Treat the database as the source of truth.
- Use JSON files only for fixtures, exports, or local tooling data.
- Prefer atomic writes (write to a temp file, then rename) when generating JSON artifacts.
