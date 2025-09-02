# AI Coding Agent Instructions for ActivityPub Repository

## Overview
This repository implements a multitenant ActivityPub server for [Ghost](https://ghost.org/), enabling independent websites to publish content directly to the Fediverse. It is built using [Fedify](https://fedify.dev/) and integrates with various Google Cloud services for production deployment.

## Key Components
- **`/src`**: Core application code, organized by domain (e.g., `account`, `post`, `notification`).
- **`/features`**: Cucumber feature files for end-to-end testing.
- **`/jobs`**: Scripts for one-off production tasks.
- **`/migrate`**: Database migration scripts and tools.
- **`/dev`**: Development utilities, including Docker configurations and local emulators.

## Development Workflows
### Setup
- Install dependencies: `yarn install`
- Start the development environment: `yarn dev`
- Fix environment issues: `yarn fix`

### Testing
- Run all tests: `yarn test`
- Run unit tests: `yarn test:unit`
- Run integration tests: `yarn test:integration`
- Run end-to-end tests: `yarn test:cucumber`
- Run a specific test: `yarn test:single path/to/test`

### Database
- Create a migration: `yarn migration 'migration-name'`
- Apply migrations: `yarn migrate`
- Wipe the database: `yarn wipe-db`

## Architectural Patterns
- **Dependency Injection**: Managed via [Awilix](https://github.com/jeffijoe/awilix) for testability.
- **Result Pattern**: Prefer returning results over throwing exceptions.
- **Layered Design**:
  - **Entities**: Contain business logic.
  - **Repositories**: Abstract database operations; accessed only via services.
  - **Services**: Orchestrate business logic and may depend on other services.
  - **Controllers**: Handle HTTP requests and delegate to services.
  - **Views**: Optimize data presentation for clients; may directly query the database but avoid business logic.

## Code Conventions
- **Testing**:
  - Unit and integration test files use `.test.ts` suffix.
  - Co-locate tests with the code they validate.
  - End-to-end tests reside in `features/`.
- **Linting and Formatting**:
  - Run linter: `yarn lint`
  - Run formatter: `yarn fmt`
- **Performance**:
  - Minimize synchronous operations during application boot to optimize for Google Cloud Run.

## External Dependencies
- **Google Cloud Services**:
  - Cloud Run: Production deployment.
  - Cloud SQL: Managed MySQL database.
  - Pub/Sub: Messaging.
  - Cloud Storage: File storage.
- **Local Emulators**:
  - Pub/Sub: Port `8085`.
  - Cloud Storage: Port `4443`.
- **Other Tools**:
  - [Tailscale](https://tailscale.com): Expose local development environment.
  - [Wiremock](https://wiremock.org): API mocking for end-to-end tests.

## Common Practices
- Follow the outlined architecture and testing patterns.
- Ensure new functionality is well-tested, lint-free, and adheres to conventions.
- Optimize for fast test execution (<10 seconds per test).

## Known Quirks
- Tests run in Docker containers, so additional flags passed to `yarn` may not propagate to the test runner.

---

For more details, refer to `AGENTS.md` or the `README.md` file.
