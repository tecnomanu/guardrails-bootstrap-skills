---
name: react-guardrails-bootstrap
description: >
  Bootstrap or improve AI-first engineering guardrails in an existing client-rendered React
  application (Vite, Create React App, Rsbuild, Parcel, webpack; React Router, TanStack Router
  or custom routing). Audits routing and code splitting, component/state boundaries, server state
  (TanStack Query, SWR, RTK Query, hand-written fetch), global state, API client and error model,
  auth token storage and refresh, route guards vs server authorization, build-time env (VITE_,
  REACT_APP_) and what ships in the bundle, forms and validation, i18n, testing, static hosting and
  SPA fallback, accessibility and performance before creating project-specific AGENTS.md and
  engineering guardrails. Not for Next.js or Astro (use their skills) or React Native.
---

# React (SPA) Guardrails Bootstrap

## Purpose

Install or improve AI-first engineering guardrails in an existing client-rendered React application, without changing product behavior.

This skill is reusable across React applications and must adapt to the repository that actually exists.

Possible stack elements include:

- bundlers: Vite, Create React App, Rsbuild/Rspack, Parcel, custom webpack
- routing: React Router (library or data mode), TanStack Router, wouter, custom
- React Router framework mode / Remix with SSR loaders (treat SSR parts with section L)
- server state: TanStack Query, SWR, RTK Query, Apollo/urql, hand-written `fetch`/axios
- client state: Context, Redux Toolkit, Zustand, Jotai, MobX, XState
- forms: React Hook Form, Formik, native forms; validation with Zod, Yup, Valibot
- UI: Tailwind, CSS Modules, styled-components, MUI, Chakra, shadcn/ui, Radix
- auth: JWT in storage, httpOnly cookie session with a backend, OAuth/OIDC PKCE client, Auth0/Clerk/Firebase/Cognito SDKs
- i18n: react-i18next, FormatJS, Lingui
- realtime: WebSocket, SSE, Pusher/Ably, Firebase listeners
- tests: Vitest/Jest, Testing Library, MSW, Playwright/Cypress, Storybook
- deployment: static hosting/CDN (Nginx, S3+CloudFront, Netlify, Vercel static, Firebase Hosting), Docker, embedded in a backend

Never introduce or document a subsystem that does not exist.

## Invocation context

Optional:

`PROJECT_MODE=personal`

or

`PROJECT_MODE=company`

If omitted, use `PROJECT_MODE=unknown`.

When mode is `unknown`, use the stricter behavior for auth, secrets, production data, deployments, dependencies, external integrations and destructive operations.

Technical quality standards are the same in every mode.

# Core principle

AI may author most or all implementation code.

Quality is judged by correctness, architecture, security, runtime evidence, test coverage, performance, accessibility, maintainability and human inspectability.

The owner is not required to read every changed line.

Meaningful changes must remain understandable through a plan, explicit risks, verification evidence, architecture awareness and an owner-facing brief.

A SPA has one hard truth: **everything in the bundle and in the browser is public and user-controlled.** Authorization, validation and business rules the client enforces are UX; the server must enforce them again.

# Authority order

Before changing anything, determine what already governs the repository.

Use this precedence:

1. Existing `AGENTS.md`
2. Repository-specific engineering/security/architecture rules
3. Existing application behavior and tests
4. Existing architecture/product/API contract documentation
5. This bootstrap skill

Do not overwrite useful project-specific rules with generic React advice.

If documentation conflicts with current code or production behavior, flag the conflict instead of silently choosing one. Verify every command, port and env var against config files.

# PHASE 1 — Audit only

Do not modify files.

Inspect when present:

- `AGENTS.md`
- `README.md`
- `package.json` and lockfile
- `vite.config.*` / `craco.config.*` / `rsbuild.config.*` / webpack config
- `tsconfig*.json`
- lint/format config (ESLint, Biome, oxlint, Prettier)
- `index.html`, `public/`
- `src/main.*` / `src/index.*` (root, providers)
- router definition (`src/router*`, `src/routes/`, route files)
- `src/pages/` or `src/features/` or `src/modules/`
- `src/components/`, `src/ui/`
- `src/api/`, `src/services/`, `src/lib/` (HTTP client, interceptors)
- store/state (`src/store/`, contexts, query client setup)
- auth code (guards, token storage, refresh)
- `src/i18n/`, locale files
- `.env*` templates
- tests, MSW handlers, Storybook
- `playwright*.config.*` / `cypress.config.*` / `vitest.config.*`
- CI
- hosting config (`nginx.conf`, `netlify.toml`, `vercel.json`, `firebase.json`, Dockerfile)
- the API contract (OpenAPI, generated clients, backend repo reference)

## A. Detect the real stack

Report only what actually exists.

Determine:

- React version and rendering root (`createRoot`, StrictMode)
- TypeScript yes/no, strictness
- bundler and version
- router and mode; lazy routes / code splitting
- server-state library (or none)
- client-state library (or none)
- API client (fetch wrapper, axios instance, generated client) and error model
- auth solution, where the credential lives, refresh strategy
- env handling: which prefix (`VITE_`, `REACT_APP_`), which values are read at build time, runtime config (`/config.json`, `window.__ENV__`) if any
- forms and validation
- UI kit / CSS approach
- i18n
- realtime
- tests: unit, component, MSW, E2E, visual
- lint/typecheck commands and whether their binaries are installed
- CI
- hosting and SPA fallback (unknown routes → `index.html`), cache headers for `index.html` vs hashed assets

Never assume TanStack Query, Redux, Tailwind or any common tool exists.

## B. Map product surfaces

Identify surfaces such as:

- public / marketing routes inside the SPA
- auth flows (login, signup, reset, OAuth callback)
- authenticated app
- admin / back-office
- onboarding / checkout
- embedded widgets or micro-frontends

For each surface record:

| Surface | Routes | Guard | Server authority | Data source | Main side effects |
|---|---|---|---|---|---|

Do not assume a client route guard means the data behind it is protected.

## C. Map data and state boundaries

Explain important flows as:

`route → page component → hook (query/mutation) → API client → backend → cache/state → UI`

Identify:

- canonical API modules per resource (or scattered `fetch` calls)
- server state vs client state: which data is cached copies of the server and which is truly local
- the same server data duplicated into a global store and a query cache
- cache keys and invalidation after mutations
- optimistic updates and their rollback
- where loading, error and empty states are handled
- global providers and what each one owns
- realtime updates and how they reconcile with cached data
- data persisted in `localStorage`/`sessionStorage`/IndexedDB and its format

## D. Identify current guardrail gaps

Look for actual evidence of:

- secrets or private keys in `VITE_`/`REACT_APP_` vars or source (anything in the bundle is public)
- authorization only in route guards or hidden buttons, with no evidence the API enforces it
- tokens in `localStorage` together with raw HTML injection (`dangerouslySetInnerHTML`, markdown renderers without sanitizing)
- refresh-token races (parallel 401s triggering multiple refreshes, logout loops)
- server data copied into global state and drifting from the cache
- missing invalidation after mutations (stale lists)
- `useEffect` used for derived state or data fetching races (no abort, no ignore flag, out-of-order responses)
- effects that are not idempotent under StrictMode double-invoke
- unstable keys (`index`) on reorderable lists
- giant components mixing fetching, business rules and presentation
- business rules duplicated between client and server with divergent logic
- inconsistent API error handling (swallowed errors, generic toasts, lost validation messages)
- forms without client validation mirroring the server contract, or client validation treated as sufficient
- open redirects via `?next=`/`returnTo` params
- PII or tokens written to logs, analytics or error trackers
- missing SPA fallback or wrong cache headers (stale `index.html` referencing deleted chunks)
- no handling of chunk load failure after deploy
- mock/demo switches (MSW, feature flags) reachable in production builds
- huge bundles: whole icon/date/chart libraries imported, no route-level splitting
- tests that assert implementation details instead of user-visible behavior
- lint/typecheck scripts whose tool is not installed
- agents declaring success because `build` passed without loading the route in a browser
- long narrative comments (history, incident stories, rejected alternatives inside code) and personal data, local paths or AI-tool metadata in code/docs; report counts and hotspots only, the bootstrap does not rewrite them

Do not manufacture findings to fill a checklist.

## E. Auth/security audit

Detect the real auth model first.

When relevant, inspect:

- source of truth for identity (backend session, IdP, BaaS SDK)
- credential location: `localStorage`/`sessionStorage` token vs httpOnly cookie vs in-memory
- consequences: storage tokens → XSS is the main threat, CSRF mostly moot; cookies → CSRF protection and `SameSite` matter, CORS with credentials must be tight
- OAuth/OIDC: PKCE, `state`, redirect URI allowlist, token handling on the callback route
- refresh strategy, single-flight refresh, logout semantics (server revoke, storage clear, cache clear)
- route guards vs API authorization
- role/permission data used for UI only vs trusted anywhere
- redirect targets built from input
- raw HTML sources and sanitization
- third-party scripts with access to the page (analytics, chat widgets)
- Content Security Policy if the host sets one

## F. Test/runtime audit

Document only real commands and workflows:

- install
- dev
- build
- preview of the production build (`vite preview`, static server)
- lint
- typecheck
- unit/component tests
- API mocking (MSW) and whether mocks match the real contract
- E2E against the production build and a real or seeded backend
- visual/Storybook checks

Record:

- which backend each suite needs (mock, local, staging)
- whether E2E runs against `dev` only (misses build-only failures, env inlining, chunking)

Mark important gaps explicitly.

## G. Classify documentation

Return:

### KEEP
### ARCHIVE
### UPDATE
### ADD

## H. Proposed target structure

Prefer adapting toward:

```text
AGENTS.md

docs/
  engineering/
    GUARDRAILS_PROFILE.md
    SYSTEM_MAP.md
    DECISIONS.md
    TESTING.md
    HISTORY.md
    skills/
      01-plan-change.md
      02-implement-change.md
      03-independent-review.md
      04-security-review.md
      05-test-and-runtime.md
      06-architecture-check.md
      07-owner-brief.md
      08-release-check.md
```

Use an existing docs convention if the repository has one. Do not duplicate strong existing documentation; link to it.

Stop after Phase 1 unless explicitly told to apply.

# PHASE 2 — Install guardrails

Only run after explicit approval.

The bootstrap itself must not change product behavior.

Unless explicitly authorized, Phase 2 may modify only documentation and guardrail configuration.

Do not:

- refactor product code
- add packages
- alter auth or token storage
- change routing, code splitting or providers
- change caching/query configuration
- change environment variables or build config
- change hosting/deploy config
- modify API contracts
- modify tests or test configs
- modify production data

Write project docs in the team's language when known; keep this skill's structure.

## A. `AGENTS.md`

If an existing `AGENTS.md` exists, preserve useful project-specific rules and improve it.

If none exists, create one.

Add a compact section:

# AI-native change workflow

For non-trivial changes:

PLAN
→ IMPLEMENT
→ FRESH-CONTEXT REVIEW
→ SECURITY/RISK REVIEW when applicable
→ TEST + REAL RUNTIME VERIFICATION (production build in a browser)
→ ARCHITECTURE CHECK when structural
→ OWNER BRIEF
→ RELEASE CHECK when deploy-sensitive

### Hard rules

1. Never perform unrelated refactors while implementing a task.
2. Search for the canonical existing implementation before creating a new one.
3. Never mechanically apply SOLID/DRY. Balance with KISS/YAGNI and repository conventions.
4. Do not create abstractions for speculative future reuse.
5. Do not add dependencies without concrete value and explicit justification.
6. Do not weaken tests, typechecking, linting, validation, authorization or security controls to obtain green checks.
7. Self-review is useful but not independent validation.
8. Meaningful changes require fresh-context review.
9. Bug fixes should add regression coverage when feasible.
10. Tests must prove user-visible behavior, not mirror implementation.
11. Verify through the real path: production build, real route in a browser, real or contract-faithful API.
12. Structural changes require architecture-drift review.
13. Everything in the bundle is public: no secrets in env vars or source; only public config at build time.
14. Client guards and hidden UI are UX, not security; the API must enforce authorization.
15. Server data has one client home (the query cache or the canonical store), never two.
16. Every mutation states which cached data it invalidates or updates.
17. One canonical API module per resource; no ad-hoc `fetch` in components.
18. Effects are for synchronizing with external systems, not for derived state; they must be idempotent and cancel stale work.
19. No raw HTML from untrusted sources without sanitizing.
20. Redirect targets from URL params must be same-origin or allowlisted.
21. Mock/demo switches must be unreachable in production builds.
22. Never log tokens or PII to the console, analytics or error trackers.
23. Code comments: 1–2 lines, only the non-obvious why. No history, incidents or rejected alternatives in code; put them in `HISTORY.md`/`DECISIONS.md` and reference the stable ID (`See HISTORY.md#h-031`). Details: `references/comments-and-history.md`.
24. No personal data, machine-local paths or AI-tool metadata (model names, agent branches, "generated by") in code, comments, docs, fixtures or commit messages.

## B. Component and state guardrails

Adapt to the real architecture.

- Keep components focused: data hooks fetch, components render, pure functions hold business rules.
- Derive state during render instead of syncing copies with effects.
- Lift state only as far as needed; use context for low-frequency, truly shared values.
- A global store holds client state (UI, session, drafts), not a second copy of server data managed by a query library.
- Stable, meaningful `key`s on lists.
- Follow the Rules of Hooks; keep custom hooks named and scoped by purpose.
- Reuse existing components and design-system primitives before adding variants; avoid abstractions based only on visual coincidence.
- Handle loading, error, empty and stale states explicitly on every data-driven screen.

## C. Data fetching and API guardrails

- One API client instance with shared base URL, auth header, timeout and error normalization.
- One module (or generated client) per resource; components call hooks, hooks call the module.
- Query keys are structured and centralized; mutations invalidate or update them explicitly.
- Hand-written fetching in effects must abort or ignore stale responses.
- Optimistic updates define their rollback.
- Map API errors to a consistent shape; keep field-level validation errors attached to fields.
- MSW/mocks follow the real API contract; update them when the contract changes.
- Do not reimplement server business rules in the client beyond what the UX needs.

## D. Routing guardrails

- Route-level code splitting for large surfaces; handle chunk load failures (retry or reload prompt) after deploys.
- Guards redirect for UX; the page must still behave when the API returns 401/403.
- Keep URL as the source of truth for shareable state (filters, pagination, tabs) when the product expects shareable links.
- Preserve existing public URLs; add redirects when they change.
- `next`/`returnTo` parameters are validated against an allowlist.

## E. Auth guardrails — only if relevant

Detect and document:

- where the credential lives and why
- refresh flow (single-flight; queued requests during refresh)
- 401/403 handling and logout (server revoke if available, clear storage, clear query cache, reset stores)
- OAuth/OIDC client settings (PKCE, redirect URIs)
- role/permission data flow and that the server enforces it
- multi-tab behavior (storage events, broadcast channel) when relevant

Never rewrite auth as part of unrelated work.

## F. Env and configuration guardrails

- Build-time env (`import.meta.env.VITE_*`, `process.env.REACT_APP_*`) is inlined into the bundle and needs a rebuild to change.
- If the same build must run in several environments, use a documented runtime config (e.g. `/config.json`) and never put secrets there.
- Document every variable, its default and whether changing it needs a rebuild.
- Mode switches (mock/live, debug panels) default to the safe production value.

## G. Forms and validation

- Client validation mirrors the server contract for UX; the server stays authoritative.
- Share schemas with the backend only if the project already does so.
- Disable double submit; show server errors next to the fields.
- Do not trust hidden inputs or client-computed totals/prices.

## H. Internationalization — only if present

- No hardcoded user-facing strings outside the i18n system.
- Keys are stable; missing keys fail visibly in dev.
- Dates, numbers and currencies go through locale-aware formatters.

## I. Accessibility guardrails

For UI changes:

- semantic HTML and landmarks
- keyboard access and visible focus
- focus management on route change, dialogs and menus
- accessible names and form labels/errors
- contrast when colors change
- no clickable `div`s when a button or link fits

Do not report generic accessibility noise unrelated to the change.

## J. Performance guardrails

Only optimize with evidence.

Look for:

- bundle growth from new dependencies (check the analyzer when the project has one)
- whole-library imports (icons, lodash, date/chart libraries)
- missing route-level splitting on large surfaces
- request waterfalls that could run in parallel or be prefetched
- unnecessary re-renders proven by profiling, not guessed
- unoptimized images, missing dimensions, LCP images lazy-loaded
- memoization added without evidence (`useMemo`/`useCallback` noise)

Do not micro-optimize speculative paths.

## K. Hosting and release guardrails

- SPA fallback serves `index.html` for app routes and 404 for missing assets.
- `index.html` is not cached long; hashed assets are cached immutable.
- Deploys that delete old chunks break open tabs; keep previous assets or handle chunk errors.
- Source maps: public or private deliberately.
- Security headers/CSP owned by the host are documented.

## L. SSR / framework mode — only if present

If the project uses React Router framework mode, Remix or a custom SSR server:

- loaders/actions run on the server: authorization and validation belong there
- data returned from loaders is serialized to the client: never include secrets or private fields
- no browser APIs, time or randomness during render (hydration mismatches)
- verify with the production server, not only the dev server

If the project is actually Next.js or Astro, stop and recommend the matching skill.

## M. `GUARDRAILS_PROFILE.md`

Generate a project-specific profile:

```markdown
# Guardrails profile

Project mode: company | personal | unknown

## Detected stack

- React:
- Bundler:
- Router / splitting:
- TypeScript:
- Server state:
- Client state:
- API client / contract:
- Auth / token location:
- Env / runtime config:
- Forms / validation:
- UI / CSS:
- i18n:
- Realtime:
- Tests / mocks / E2E:
- Lint / typecheck:
- CI:
- Hosting:

## Product surfaces

- ...

## Critical boundaries

- bundle (public) vs server (private):
- client guards vs API authorization:
- server state home:
- cache invalidation:
- token storage / refresh:
- raw HTML:
- redirects:
- mock/test switches:

## Required verification gates

- ...

## High-risk changes

- ...
```

Keep it concise.

## N. `SYSTEM_MAP.md`

Owner-readable 5–10 minute map.

Include:

- product surfaces and route map
- provider tree and what each provider owns
- main data flows (route → hook → API module → backend)
- server state vs client state homes
- auth model
- mutation paths and invalidation
- realtime if present
- external integrations and third-party scripts
- build and hosting topology
- 5–15 files/directories worth knowing

## O. `DECISIONS.md`

Give each entry a stable ID (`D-012`) so a one-line code comment can point to it.

Only durable architectural decisions (router, state strategy, token location, API client, runtime config, hosting).

Also create `HISTORY.md` for non-obvious fixes, regressions and workarounds (`H-NNN`: symptom, cause, fix, guard). It is not a changelog: only knowledge the code alone does not show. Format and the comment policy to copy into `AGENTS.md`: `references/comments-and-history.md`.

## P. `TESTING.md`

Document only real commands/environments.

Separate when applicable:

- lint
- typecheck
- unit/component
- API mocks and contract fidelity
- E2E against production build
- visual/Storybook
- auth flows
- production-like preview

Mark gaps explicitly.

# Reusable engineering skills

Create under the project's chosen engineering skills directory.

## `01-plan-change.md`

Before editing:

- trace route → component → hook → API module → backend
- identify the canonical module/hook/component to reuse
- identify server state touched and what must be invalidated
- identify client state touched and its home
- identify auth/permission implications and where the server enforces them
- identify env/config implications (rebuild needed?)
- identify URL/contract/storage-format compatibility
- identify a11y and bundle impact when relevant
- state risks
- state verification
- classify architecture impact as NONE / LOCAL / STRUCTURAL

## `02-implement-change.md`

- follow the approved/current plan
- preserve repository conventions
- keep diff scoped
- reuse canonical API modules, hooks and components
- keep server data in its single client home; invalidate explicitly
- handle loading/error/empty states
- avoid unrelated cleanup
- add/update tests (behavior, via Testing Library/E2E)
- avoid casual dependencies; check bundle impact when adding one
- keep comments to 1–2 lines of why; move history to `HISTORY.md`/`DECISIONS.md` with an ID reference
- inspect final diff
- run relevant checks

## `03-independent-review.md`

Fresh context preferred.

Review:

- requirement vs implementation
- secrets or private data reaching the bundle
- authorization relying on the client
- duplicated server state / missing invalidation
- effect misuse, races, StrictMode safety
- API error handling consistency
- raw HTML and redirect safety
- token/refresh changes
- URL and storage compatibility
- a11y regressions
- bundle/performance regressions
- tests that mirror implementation
- unnecessary abstractions
- narrative comments, personal data, local paths or AI-tool metadata introduced by the diff

Classify:

- BLOCKER
- SHOULD FIX
- OPTIONAL

Every material finding requires evidence.

## `04-security-review.md`

Review only relevant attack surfaces:

- secrets in bundle/env/source maps
- client-only authorization
- XSS via `dangerouslySetInnerHTML`, markdown, URL-built `href` (`javascript:`)
- token storage and refresh
- CSRF/CORS with cookie auth
- OAuth/OIDC callback handling
- open redirects
- PII in logs/analytics/error trackers
- third-party scripts
- mock/test switches in production
- dependency risk

## `05-test-and-runtime.md`

Discover real commands first.

Distinguish:

- lint/typecheck/build
- unit/component tests
- production build actually served (preview)
- route actually loaded in a browser
- interaction actually worked
- request actually matched the API contract
- auth path worked (login, refresh, logout)
- mutation worked and the UI refreshed
- error path handled (API down, 401, 403, validation)

Anything not verified is `UNVERIFIED`.

## `06-architecture-check.md`

Compare against:

- `AGENTS.md`
- `GUARDRAILS_PROFILE.md`
- `SYSTEM_MAP.md`
- neighboring implementation

Look for:

- second home for server data
- ad-hoc fetching bypassing the API module
- new global provider/store without need
- business rules moved into components
- auth boundary drift
- new env var that should be runtime config (or vice versa)
- docs becoming false

Do not refactor for aesthetic purity.

## `07-owner-brief.md`

Include:

### What changed

### Flow
`route → component → hook → API → backend → UI`

### Files worth knowing
Maximum 7.

### Risk
LOW / MEDIUM / HIGH.

### Proof
Exact checks and runtime verification.

### Architecture
NONE / LOCAL / STRUCTURAL.

### If it breaks
First place to inspect and rollback/mitigation.

### Human attention
At most 1–3 things worth personally understanding.

## `08-release-check.md`

For deploy-sensitive work.

Review when applicable:

- env vars changed (rebuild required?)
- runtime config per environment
- API compatibility with the deployed backend (both deploy orders)
- SPA fallback and cache headers
- old chunks and open tabs
- mock/debug switches off
- auth/IdP configuration (redirect URIs, allowed origins)
- third-party scripts
- source maps
- observability (error tracker release tagging)
- rollback (previous build artifact)

Return:

- GO
- GO WITH CAUTION
- NO-GO

Never mark GO based only on unit tests or a successful build.

# PHASE 3 — Validate bootstrap

After applying guardrails, return one concise report:

## Created
## Updated
## Archived
## Preserved
## Detected profile
## Runtime impact
Must be `NONE` unless explicitly authorized.
## Resulting workflow
## Human review requested
At most 5 items.

Do not begin product refactors or feature work as part of the bootstrap.
