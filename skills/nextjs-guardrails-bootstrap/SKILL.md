---
name: nextjs-guardrails-bootstrap
description: >
  Bootstrap or improve AI-first engineering guardrails in an existing Next.js project.
  Audits routing model, Server/Client Component boundaries, data access, auth, API/Server Actions,
  caching/revalidation, runtime targets, testing, deployment, SEO, accessibility and performance
  before creating project-specific AGENTS.md and engineering guardrails.
---

# Next.js Guardrails Bootstrap

## Purpose

Install or improve AI-first engineering guardrails in an existing Next.js project without changing product behavior.

This skill is reusable across different Next.js applications and must adapt to the repository that actually exists.

Possible stack elements include:

- App Router or Pages Router
- React Server Components / Client Components
- Server Actions
- Route Handlers / API Routes
- TypeScript
- Tailwind / shadcn/ui / other UI systems
- Auth.js / Clerk / Supabase Auth / custom auth
- OAuth / OIDC / SSO
- Prisma / Drizzle / Supabase / direct SQL / external APIs
- React Query / SWR
- Redis / queues / realtime
- payments / webhooks / object storage
- Vercel / Docker / Node deployment
- Edge Runtime / Node Runtime
- public web / authenticated app / admin / customer portal

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

# Authority order

Before changing anything, determine what already governs the repository.

Use this precedence:

1. Existing `AGENTS.md`
2. Repository-specific engineering/security/architecture rules
3. Existing application behavior and tests
4. Existing architecture/product documentation
5. This bootstrap skill

Do not overwrite useful project-specific rules with generic Next.js advice.

If documentation conflicts with current code or production behavior, flag the conflict instead of silently choosing one.

# PHASE 1 — Audit only

Do not modify files.

Inspect when present:

- `AGENTS.md`
- `README.md`
- `package.json`
- lockfile
- `next.config.*`
- `tsconfig.json`
- ESLint config
- `app/`
- `pages/`
- `src/`
- `components/`
- `lib/`
- `server/`
- `actions/`
- `api/`
- `middleware.*`
- `instrumentation.*`
- `tests/`
- `e2e/`
- CI
- Docker/deploy config
- environment templates
- existing docs

## A. Detect the real stack

Report only what actually exists.

Determine:

- Next.js version
- React version
- TypeScript yes/no
- App Router yes/no
- Pages Router yes/no
- Server Components usage
- Client Components usage
- Server Actions usage
- Route Handlers / API Routes
- Node vs Edge runtime usage
- auth/session solution
- SSO/OAuth/OIDC if present
- database/data-access layer
- cache/storage
- realtime
- queues/background work
- payments
- file/object storage
- frontend data-fetching libraries
- state management
- CSS/UI stack
- tests
- E2E
- lint/typecheck
- CI
- deploy platform/runtime

Never assume Vercel, Prisma, Auth.js, Tailwind or any other common tool exists.

## B. Map product surfaces

Identify actual surfaces such as:

- public marketing website
- authenticated app
- admin panel
- customer/account area
- onboarding
- API
- webhook endpoints
- public share pages
- docs/help center

For each surface record:

| Surface | Entry/routes | Auth | Authorization | Data source | Main side effects |
|---|---|---|---|---|---|

Do not assume all surfaces share the same middleware, session or permissions.

## C. Map rendering/data boundaries

Explain important flows as:

`route → layout/page → server/client boundary → data source → mutation/side effect → response/revalidation`

Identify:

- Server Components
- Client Components
- Server Actions
- Route Handlers
- API Routes
- middleware
- shared layouts/providers
- data-access modules
- external API adapters

## D. Identify current guardrail gaps

Look for actual evidence of:

- unnecessary `"use client"`
- secrets/environment values crossing to the client
- server-only modules imported into Client Components
- duplicated data fetching
- Client Components fetching data that should arrive from the server
- business logic duplicated across Server Actions and API routes
- authorization only in UI/middleware
- IDOR/account/tenant boundary issues
- unsafe Server Actions
- unvalidated form/input handling
- cache/revalidation bugs
- stale data from accidental caching
- accidental dynamic rendering
- accidental route deoptimization
- unsafe redirects/return URLs
- weak webhook validation
- unsafe file uploads
- SSRF from server-side URL fetching
- client/server state duplication
- oversized providers/global client state
- N+1 or repeated queries
- avoidable waterfalls
- excessive browser JS/bundle growth
- unstable effects/hooks
- duplicated canonical business operations
- packages added casually
- accessibility regressions
- SEO metadata gaps
- agents declaring success because build passed without exercising the real route
- long narrative comments (history, incident stories, rejected alternatives inside code) and personal data, local paths or AI-tool metadata in code/docs; report counts and hotspots only, the bootstrap does not rewrite them

Do not manufacture findings to fill a checklist.

## E. Rendering/runtime audit

Determine which important routes are:

- static
- dynamic
- ISR/revalidated
- explicitly forced static/dynamic when configured
- Node Runtime
- Edge Runtime

Flag only real mismatches.

Do not optimize caching without understanding freshness requirements.

## F. Auth/security audit

Detect the real auth model first.

When relevant, inspect:

- authentication source of truth
- authorization location
- role/permission model
- tenant/account isolation
- session/cookie handling
- OAuth/OIDC/SSO callback validation
- redirect allowlists
- CSRF expectations
- Server Action authorization
- API/Route Handler authorization
- webhook signatures
- secrets exposure
- privilege escalation paths

Middleware alone is not sufficient authorization for sensitive operations.

## G. Test/runtime audit

Document only real commands and workflows:

- install
- dev
- build
- lint
- typecheck
- unit/component tests
- integration tests
- E2E/browser tests
- production-like start
- webhook testing
- auth testing
- payment testing
- realtime testing

Mark important gaps explicitly.

## H. Classify documentation

Return:

### KEEP
### ARCHIVE
### UPDATE
### ADD

## I. Proposed target structure

Prefer adapting toward:

```text
AGENTS.md

docs/
  engineering/
    SYSTEM_MAP.md
    DECISIONS.md
    TESTING.md
    HISTORY.md
    GUARDRAILS_PROFILE.md
    WORKFLOW.md
```

Do not duplicate strong existing documentation.

Stop after Phase 1 unless explicitly told to apply.

# PHASE 2 — Install guardrails

Only run after explicit approval.

The bootstrap itself must not change product behavior.

Unless explicitly authorized, Phase 2 may modify only documentation and guardrail configuration.

Do not:

- refactor product code
- add packages
- alter auth
- alter data models
- change caching behavior
- change runtime targets
- change deployment
- change environment variables
- modify APIs/contracts
- modify production data

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
→ TEST + REAL RUNTIME VERIFICATION
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
10. Tests must prove behavior, not merely mirror implementation.
11. Integration-heavy changes require verification through the real execution path when feasible.
12. Structural changes require architecture-drift review.
13. Never expose server secrets to Client Components or browser bundles.
14. Authorization must be enforced at the sensitive operation, not only in UI or middleware.
15. Keep server/client boundaries intentional.
16. Avoid `"use client"` unless the component genuinely needs browser interactivity/state/effects.
17. Do not duplicate canonical business logic across Server Actions, Route Handlers and API routes.
18. Treat cache/revalidation changes as behavioral changes.
19. Do not change Node/Edge runtime casually.
20. Keep bundle/client JS growth intentional and justified.
21. Code comments: 1–2 lines, only the non-obvious why. No history, incidents or rejected alternatives in code; put them in `HISTORY.md`/`DECISIONS.md` and reference its anchor (`See HISTORY.md#invite-link`). Details: `references/comments-and-history.md`.
22. No personal data, machine-local paths or AI-tool metadata (model names, agent branches, "generated by") in code, comments, docs, fixtures or commit messages.

## B. Server / Client Component guardrails

Adapt to the actual router.

When using App Router:

- Default to Server Components when browser-only behavior is unnecessary.
- Use Client Components only for interactivity, browser APIs, local state or effects.
- Do not import server-only modules into Client Components.
- Keep client boundaries as low/small as practical.
- Avoid moving entire layouts/pages client-side for one interactive child.
- Keep sensitive data and secrets server-side.
- Avoid duplicating server-fetched truth into long-lived client state without synchronization semantics.

Do not force RSC patterns onto Pages Router projects.

## C. Data access guardrails

- Establish one canonical location/path for each business operation.
- Keep DB credentials and privileged SDKs server-only.
- Reuse existing data-access modules/adapters.
- Avoid direct DB/API calls scattered through UI components.
- Consider transactions for atomic operations.
- Avoid N+1/repeated queries.
- Parallelize independent server data requests when safe.
- Do not introduce repository/service layers only for pattern compliance.

## D. Server Actions — only if present

For each meaningful Server Action:

- authenticate
- authorize
- validate input
- validate account/tenant ownership
- keep privileged code server-side
- make side effects explicit
- revalidate/redirect intentionally
- handle duplicate submissions/idempotency where relevant
- do not rely on disabled buttons/UI state as protection

Treat Server Actions as externally invocable server entry points.

## E. Route Handlers / API Routes — only if present

- validate auth/authorization independently
- validate input/output shape
- preserve consistent error contracts where the project has one
- validate webhooks/signatures
- apply rate limiting/abuse controls where relevant
- do not expose internal fields/secrets
- keep business behavior canonical rather than reimplemented per transport

## F. Cache / revalidation guardrails

Detect the actual Next.js version and project conventions first.

For changes involving caching/freshness:

- state the intended freshness contract
- identify static/dynamic implications
- identify revalidation/tag/path behavior when used
- prevent user/tenant-specific data from being cached across identities
- avoid adding caching solely for performance folklore
- verify behavior after mutations

Treat caching bugs as correctness/security bugs when user-specific data is involved.

## G. Auth / SSO guardrails — only if relevant

Detect the real provider/model.

Document and preserve:

- authentication source of truth
- session ownership
- account linking
- tenant/account association
- role/permission mapping
- SSO subject/email trust rules
- callback validation
- redirect allowlists
- deprovisioning/session invalidation expectations

Never rewrite auth/SSO as part of unrelated work.

## H. Multi-surface applications

If the project contains multiple surfaces, document them explicitly in `SYSTEM_MAP.md`.

Guard against:

- admin permissions leaking into customer routes
- public routes accidentally importing authenticated data
- shared layouts/providers leaking user data
- shared Server Components exposing fields between surfaces
- duplicate business logic per surface

## I. SEO / metadata guardrails

For public/indexable surfaces when applicable:

- preserve or improve metadata correctness
- canonical URLs
- Open Graph/Twitter metadata
- robots/indexing intent
- structured data only when valid
- sitemap behavior
- redirects/status codes

Do not apply SEO requirements to private/authenticated app surfaces unless relevant.

## J. Accessibility guardrails

For UI changes:

- semantic HTML
- keyboard access
- focus behavior
- accessible names
- form labels/errors
- contrast when design changes
- dialog/menu semantics
- avoid clickable divs when semantic controls exist

Do not report generic accessibility noise unrelated to the change.

## K. Performance guardrails

Only optimize with evidence.

Look for:

- unnecessary client bundles
- large dependencies
- waterfalls
- repeated server queries
- unnecessary re-renders
- image/font misuse
- oversized shared providers
- accidental dynamic rendering
- repeated API requests
- expensive work in middleware

Do not micro-optimize speculative paths.

## L. `GUARDRAILS_PROFILE.md`

Generate a project-specific profile:

```markdown
# Guardrails profile

Project mode: company | personal | unknown

## Detected stack

- Next.js:
- React:
- Router:
- TypeScript:
- Auth:
- SSO:
- Data:
- Cache:
- Realtime:
- Payments:
- Tests:
- E2E:
- CI:
- Deploy:
- Runtime targets:

## Product surfaces

- ...

## Critical boundaries

- server/client:
- auth:
- authorization:
- account/tenant:
- Server Actions:
- API/webhooks:
- payments:
- cache/revalidation:
- external APIs:

## Required verification gates

- ...

## High-risk changes

- ...
```

Keep it concise.

## M. `SYSTEM_MAP.md`

Owner-readable 5–10 minute map.

Include:

- product surfaces
- route/layout structure
- Server/Client boundaries
- main data flows
- auth/authorization
- mutation paths
- cache/revalidation model
- external integrations
- runtime/deployment topology
- 5–15 files/directories worth knowing

## N. `DECISIONS.md`

Give each entry a stable ID (`D-012`) so a one-line code comment can point to it.

Also create `HISTORY.md` for non-obvious fixes, regressions and workarounds (anchored entries with Rule, Why, Where; reuse an existing equivalent such as `RATIONALE.md`). It is not a changelog: only knowledge the code alone does not show. Format and the comment policy to copy into `AGENTS.md`: `references/comments-and-history.md`.

Only durable architectural decisions.

## O. `TESTING.md`

Document only real commands/environments.

Separate when applicable:

- lint
- typecheck
- unit/component
- integration
- browser/E2E
- build
- production-like runtime
- auth
- Server Actions/API
- webhooks
- payments
- SEO/public route checks

Mark gaps explicitly.

# `WORKFLOW.md`

One file for the change workflow. It replaces the old per-step files (`skills/01-plan-change.md` … `08-*.md`).

1. Copy `references/WORKFLOW.template.md` to `docs/engineering/WORKFLOW.md` (or the repo's docs folder) as is. The block between `guardrails-workflow:start` and `guardrails-workflow:end` is fixed and identical across projects: do not reword, trim or extend it.
2. Fill only `## Specifics of this project`: per step, what is different here (canonical homes, surfaces and guards, conventions that change a step). Link `TESTING.md`, `SYSTEM_MAP.md` and conventions docs instead of repeating them. Skip steps with nothing specific; aim for under 60 lines.
3. Link `WORKFLOW.md` from `AGENTS.md`; do not copy its content there.
4. Upgrade: if `WORKFLOW.md` exists with an older marker, replace only the fixed block. If the project still has per-step files, move what is project-specific into Specifics, drop what the fixed block already covers, delete the old files and fix every link to them.

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
