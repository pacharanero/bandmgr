# `s/`

`s/` contains the repeatable development, quality, and database workflows for this repository. Run these commands from any directory within the Git checkout.

## `s/dev`

Starts the shared Compose topology: Postgres, Redis, a one-off migration service, the Rails application at `http://localhost:3000`, and the Solid Queue worker.

## `s/seed`

Builds the application image, prepares the local database, and loads demo data.

## `s/test`

Runs the Rails unit and system test suites against the Compose test database.

## `s/lint`

Runs RuboCop.

## `s/scan`

Runs Brakeman, Bundler Audit, and Importmap Audit.

## `s/migrate`

Runs pending migrations against the running development stack.

## `s/reset-db`

Drops, recreates, and migrates the local development database. This permanently removes local development data.

## `s/install-hooks`

Configures this Git checkout to run the tracked pre-commit lint hook.
