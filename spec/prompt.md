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
- See `spec/architecture.md` for architectural decisions and open questions.

## Drift Companion Usage

- When using `*Companion.insert`, provide only required fields.
- For optional/nullable or defaulted columns, either omit them (preferred) or wrap values with `Value(...)`.
- Example:
  `await into(songs).insert(SongsCompanion.insert(id: someId, bandId: bandId, title: 'Name'));`
  Not: `externalJson: '{}'` (wrong) – use `externalJson: const Value('{}')` if you must override default.
