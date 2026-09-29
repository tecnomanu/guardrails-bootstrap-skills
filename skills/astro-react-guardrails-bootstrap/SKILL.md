---
name: astro-react-guardrails-bootstrap
description: >
  Bootstrap or improve AI-first engineering guardrails in an existing Astro project with React islands.
  Audits output mode (server/static/hybrid), adapter, prerender flags, .astro pages vs React islands,
  client:* hydration boundaries, middleware and Astro.locals, API endpoints and BFF/proxy patterns,
  runtime vs build-time env (astro:env, process.env, import.meta.env, PUBLIC_), per-request data
  fetching and caching, multi-tenant resolution by Host, session/auth, testing against a production
  build, SEO, accessibility, performance and legacy-migration parity before creating
  project-specific AGENTS.md and engineering guardrails.
---

# Astro + React Islands Guardrails Bootstrap

## Purpose

Install or improve AI-first engineering guardrails in an existing Astro project that uses React islands, without changing product behavior.

This skill is reusable across different Astro applications and must adapt to the repository that actually exists.

Possible stack elements include:

- Astro `output: 'server'` (SSR), `output: 'static'`, or static with on-demand routes (`export const prerender = false`)
- adapters: `@astrojs/node` (standalone/middleware), `@astrojs/vercel`, `@astrojs/netlify`, `@astrojs/cloudflare`, others
- `.astro` pages, layouts and components
- React islands via `@astrojs/react` (`client:load`, `client:idle`, `client:visible`, `client:media`, `client:only`)
- other framework islands (Preact, Svelte, Vue, Solid) in the same project
- `src/middleware.ts`, `Astro.locals`, `Astro.cookies`, `Astro.redirect`, `Astro.rewrite`
- API endpoints (`src/pages/**/*.ts` exporting `APIRoute` handlers)
- Astro Actions (`src/actions/`)
- content collections / `astro:content`
- `astro:env` schema, `process.env`, `import.meta.env`, `PUBLIC_` variables
- sessions (`Astro.session`), cookies, JWT in `localStorage`, external auth providers
- backend-for-frontend (BFF) proxies to an external API (Laravel, Rails, Django, Node, etc.)
- multi-tenant resolution by Host header
- Tailwind / other CSS / UI kits
- `astro:assets` / `<Image />` / fonts
- nanostores or other cross-island state
- Playwright / Vitest / Testing Library / `astro check`
- Docker / Node server / serverless / edge deployment
- migrations from a legacy app (Angular, PHP, jQuery, SPA) that must keep contracts compatible

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
3. Existing application behavior and tests (including parity suites against a legacy app)
4. Existing architecture/product/contract documentation
5. This bootstrap skill

Do not overwrite useful project-specific rules with generic Astro advice.

If documentation conflicts with current code or production behavior, flag the conflict instead of silently choosing one. Stale READMEs are common in migration projects: verify every command, port and env var against config files.

# PHASE 1 — Audit only

Do not modify files.

Inspect when present:

- `AGENTS.md`
- `README.md`
- `package.json`
- lockfile
- `astro.config.*`
- `tsconfig.json`
- lint config (ESLint, oxlint, Biome)
- `src/pages/`
- `src/pages/api/` (or any `.ts`/`.js` endpoint under `src/pages/`)
- `src/layouts/`
- `src/components/`
- `src/islands/` or wherever React roots live
- `src/lib/`, `src/server/`, `src/utils/`
- `src/middleware.ts` (or `src/middleware/`)
- `src/actions/`
- `src/content/` / `content.config.*`
- `src/env.d.ts` (`App.Locals`)
- `public/`
- fixtures / mocks
- `playwright*.config.*`, `vitest.config.*`
- `e2e/`, `tests/`, parity suites
- CI
- Docker/deploy config
- environment templates (`.env.example`)
- existing docs (API contracts, migration notes)
- the legacy app being replaced, when the repo is a migration

## A. Detect the real stack

Report only what actually exists.

Determine:

- Astro version
- React version (and any other island frameworks)
- TypeScript yes/no, strictness
- `output` mode (`server` / `static`) and routes with `export const prerender`
- adapter and its mode (e.g. `@astrojs/node` `standalone` vs `middleware`)
- middleware presence and responsibilities
- `App.Locals` shape
- API endpoints and what they do (own logic vs proxy)
- Astro Actions usage
- content collections usage
- env handling: `astro:env` schema, `process.env` at runtime, `import.meta.env` at build time, `PUBLIC_` variables
- auth/session solution and where the token/session lives
- data sources (own DB, external API, CMS, fixtures)
- server-side caching (in-memory maps, CDN headers, KV)
- cross-island state (nanostores, storage events, URL)
- CSS/UI stack
- image/font strategy
- tests: unit, component, E2E, contract, parity
- lint/typecheck commands and whether their binaries are actually installed
- CI
- deploy platform/runtime (Node server, serverless, edge)

Never assume Vercel, Tailwind, `astro:env`, Actions or any other common tool exists.

## B. Map product surfaces

Identify actual surfaces such as:

- public marketing / landing pages
- authenticated client area
- admin
- onboarding / checkout
- BFF / API endpoints
- webhook endpoints
- per-tenant or per-host variants
- docs / blog / content collections

For each surface record:

| Surface | Routes | Render (SSR/prerender/client:only) | Auth | Data source | Main side effects |
|---|---|---|---|---|---|

Do not assume all surfaces share the same middleware behavior, session or permissions.

## C. Map rendering / hydration / data boundaries

Explain important flows as:

`request → middleware (locals) → .astro page frontmatter → props → island (client:*) → browser fetch → endpoint/BFF → upstream → response`

Identify:

- which pages are prerendered vs on-demand
- what the frontmatter fetches per request
- which islands exist, which directive each uses and why
- what is serialized as island props (everything passed is public HTML)
- where each island's React root and providers live (each island is an independent React root; context does not cross islands)
- what runs only in the browser (`localStorage`, `window`, `document`, timers)
- endpoints and their upstreams
- server-only modules (env, secrets, DB clients, fixtures that must not ship)
- module-level mutable state on the server (shared across requests)

## D. Identify current guardrail gaps

Look for actual evidence of:

- secrets or private fields serialized into island props or inlined HTML
- server-only modules imported from island code (ends up in the client bundle)
- non-`PUBLIC_` values read through `import.meta.env` in client code, or runtime values baked at build time
- islands hydrated with `client:load` when `client:idle`/`client:visible` or no hydration would do
- whole pages as one large island for a small interactive part
- `client:only` used to paper over a hydration mismatch instead of fixing it
- hydration mismatches: `Date`, `Math.random`, locale formatting, `window`/`localStorage` read during render
- React context expected to be shared across islands
- module-level mutable state on the server holding per-request or per-tenant data
- per-host/per-tenant caches keyed by untrusted input without bounds
- missing error page when the upstream fails (blank pages, 500 with stack)
- BFF forwarding arbitrary paths/methods/headers (open proxy, SSRF)
- BFF without timeouts or with unbounded bodies
- cookies/credentials forwarded upstream unintentionally
- `security.checkOrigin` disabled, or cookie-based auth without CSRF protection
- open redirects via `Astro.redirect` with user input
- raw HTML injection (`set:html`, `dangerouslySetInnerHTML`) with untrusted content
- test-only / mock-only switches (query params, cookies) reachable in production mode
- auth checks only in the island (UI) and not at the endpoint/upstream
- duplicated business rules between islands, endpoints and upstream
- legacy compatibility contracts (URLs, query/matrix params, storage keys, API payloads) broken silently
- stale docs (commands, ports, env names)
- lint/typecheck scripts whose tool is not installed
- agents declaring success because `astro build` passed without exercising the real route
- long narrative comments (history, incident stories, rejected alternatives inside code) and personal data, local paths or AI-tool metadata in code/docs; report counts and hotspots only, the bootstrap does not rewrite them

Do not manufacture findings to fill a checklist.

## E. Rendering/runtime audit

Determine which important routes are:

- prerendered at build
- on-demand (SSR) per request
- rendered only in the browser (`client:only`)
- redirects / rewrites in middleware or frontmatter

And which runtime they run on (Node server, serverless function, edge).

Flag only real mismatches, e.g. per-request data on a prerendered page, Node APIs (`Buffer`, `fs`) used on an edge adapter, or a route prerendered while depending on the Host header.

Do not change output mode, prerender flags or adapter without understanding freshness and tenancy requirements.

## F. Auth/security audit

Detect the real auth model first.

When relevant, inspect:

- authentication source of truth (upstream API, Astro session, provider)
- where credentials live: `localStorage` JWT vs httpOnly cookie vs server session
- consequences: `localStorage` JWT → no SSR of authenticated data, XSS is the main threat, CSRF is mostly moot; cookies → SSR possible, CSRF and `security.checkOrigin` matter
- authorization location (must be at the endpoint or upstream, never only in the island)
- tenant isolation (Host → tenant resolution, overrides, cache keys)
- BFF allowlists, header forwarding, IP forwarding, timeouts, error shape
- redirect targets built from input
- raw HTML sources (admin-authored scripts/rich text vs user input)
- secrets exposure in props, inline scripts and client bundles
- mock/demo/test switches reachable in production

Middleware alone is not sufficient authorization for sensitive operations.

## G. Test/runtime audit

Document only real commands and workflows:

- install
- dev
- build
- production-like start (e.g. `node dist/server/entry.mjs` for `@astrojs/node` standalone)
- lint
- typecheck (`astro check`)
- unit/component tests
- E2E against the production build
- contract tests (e.g. Playwright `page.route` on the BFF asserting exact requests)
- mock/demo mode
- parity suites against a legacy app
- auth / payment / webhook testing

Notes to verify and record:

- recent Astro versions refuse to start a second `astro dev` server for the same project; suites that spawn `astro dev` collide with a developer's running dev server, and `reuseExistingServer` may silently reuse a server started with different env
- prefer E2E against `astro build` + production start: it catches SSR-only and build-only failures `astro dev` hides
- which env each suite needs (mock vs live, local API, DB container)

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
  guardrails/
    GUARDRAILS_PROFILE.md
    SYSTEM_MAP.md
    DECISIONS.md
    TESTING.md
    HISTORY.md
    WORKFLOW.md
```

Use `docs/engineering/` instead if the repository already has that convention. Do not duplicate strong existing documentation; link to it.

Stop after Phase 1 unless explicitly told to apply.

# PHASE 2 — Install guardrails

Only run after explicit approval.

The bootstrap itself must not change product behavior.

Unless explicitly authorized, Phase 2 may modify only documentation and guardrail configuration.

Do not:

- refactor product code
- add packages
- alter auth
- change output mode, prerender flags or adapter
- change hydration directives
- change caching behavior
- change deployment
- change environment variables
- modify endpoints/contracts
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
→ TEST + REAL RUNTIME VERIFICATION (production build)
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
11. Verify through the real execution path: production build + real route, not only `astro build`.
12. Structural changes require architecture-drift review.
13. Everything passed as island props is public. Never pass secrets or private fields; sanitize server data first.
14. Server-only modules (env, secrets, upstream clients, fixtures) must never be imported from island code.
15. Only `PUBLIC_` values may be read in client code; runtime config is read on the server.
16. Pick the lightest hydration directive that works; justify `client:load` and `client:only`.
17. No browser APIs, time or randomness during render of hydrated islands; use effects.
18. Each island is its own React root: do not assume shared React context or state across islands.
19. No per-request or per-tenant data in module-level server state.
20. Authorization is enforced at the endpoint/upstream, never only in the island or middleware.
21. Endpoints/BFF: explicit allowlist, explicit header forwarding, timeouts, no secrets to the browser.
22. Treat caching, output mode, prerender and adapter changes as behavioral changes.
23. Mock/demo/test switches must be unreachable in production mode.
24. In migrations, legacy URLs, params, storage keys and API contracts are contracts; document every intentional deviation.
25. Code comments: 1–2 lines, only the non-obvious why. No history, incidents or rejected alternatives in code; put them in `HISTORY.md`/`DECISIONS.md` and reference its anchor (`See HISTORY.md#invite-link`). Details: `references/comments-and-history.md`.
26. No personal data, machine-local paths or AI-tool metadata (model names, agent branches, "generated by") in code, comments, docs, fixtures or commit messages.

## B. Rendering and hydration guardrails

Adapt to the real output mode.

- `.astro` pages/layouts render on the server (or at build); keep static markup there.
- Hydrate only what needs interactivity; keep islands small and low in the tree.
- Directive choice:
  - no directive: static HTML only, zero JS
  - `client:visible` / `client:idle`: below the fold or non-urgent
  - `client:load`: above-the-fold interactivity needed immediately
  - `client:only="react"`: the island genuinely cannot render on the server (e.g. depends on a token in `localStorage`); accept that it has no SSR HTML, SEO or first paint
- Props must be serializable (no functions, class instances, `Map`/`Set` unless supported, circular data); they are embedded in the HTML.
- Hydration safety: read `window`, `localStorage`, `sessionStorage`, `document`, `Date.now()`, `Math.random()` and locale-dependent formatting in effects or event handlers, not during render.
- Each island is an independent React root: providers must wrap every island that needs them; cross-island communication goes through URL, storage events, custom events or a store (e.g. nanostores), deliberately.
- Follow React hooks rules; keep effects idempotent (StrictMode in dev may double-invoke).
- Never move a whole page to `client:only` to avoid a mismatch that can be fixed.

## C. Middleware, locals and request context

- Keep middleware small: routing compat, request context (tenant, session), redirects.
- Declare everything in `App.Locals` (`src/env.d.ts`) with types.
- Skip middleware work for assets and endpoints that do not need it.
- Middleware errors must degrade to a controlled response (error page), never a blank page or stack trace.
- `Astro.redirect` targets must be same-origin or allowlisted; preserve query strings deliberately.
- Keep expensive upstream calls out of middleware unless cached and bounded.

## D. Data fetching guardrails

- Frontmatter fetches run per request on on-demand routes: parallelize independent calls, set timeouts, handle failure explicitly.
- Establish one canonical module per upstream operation; do not scatter `fetch` calls across pages and islands.
- Decide explicitly whether data is fetched on the server (frontmatter, props) or in the browser (island → endpoint); do not fetch the same truth in both.
- Sanitize upstream payloads before they become props.
- Mock/fixture adapters must keep the same contract as the live adapter.

## E. Endpoints / BFF — only if present

For each endpoint under `src/pages/`:

- explicit method + path allowlist when proxying
- explicit header forwarding (e.g. `authorization`, `content-type`); never forward cookies or hop-by-hop headers by accident
- set/overwrite forwarding headers (`X-Forwarded-For`) rather than trust the client's
- timeouts on every upstream call; controlled error shape on failure
- `Cache-Control: no-store` for user-specific responses
- body size and content-type expectations
- no upstream URL built from user input (SSRF)
- validate auth/authorization at the endpoint or rely explicitly on the upstream doing it; document which
- keep business rules in the upstream or one canonical place, not reimplemented per transport

## F. Env and configuration guardrails

- Distinguish build-time (`import.meta.env`, inlined at build) from runtime (`process.env`, `astro:env` server vars) configuration.
- Only `PUBLIC_` variables may reach the browser; prefer passing specific public values as props.
- Secrets live only in server modules.
- Document every variable, its default, and whether changing it requires a rebuild or only a restart.
- Mode switches (mock/live, dev overrides) must default to the safe production value.

## G. Cache guardrails

For changes involving caching/freshness:

- state the intended freshness contract
- key caches by the real tenant/host identity, normalized, and bound their size
- never cache user-specific responses in shared caches
- remember in-memory caches are per process/instance and reset on deploy
- set HTTP cache headers intentionally on SSR pages and endpoints
- verify behavior after upstream changes

Treat caching bugs as correctness/security bugs when user- or tenant-specific data is involved.

## H. Session / auth guardrails — only if relevant

Detect and document:

- where the credential lives (`localStorage` JWT, httpOnly cookie, `Astro.session`)
- consequences for SSR (authenticated content can only be server-rendered with cookies/sessions)
- CSRF posture: cookie auth requires `security.checkOrigin` (or equivalent) and SameSite; bearer tokens from storage do not use ambient credentials
- XSS posture: tokens in `localStorage` are readable by any injected script; treat raw HTML injection accordingly
- 401 handling and logout semantics
- storage keys shared with other apps on the same domain

Never rewrite auth as part of unrelated work.

## I. Multi-tenant / multi-surface applications

If the project resolves tenants by Host or serves multiple surfaces, document them in `SYSTEM_MAP.md`.

Guard against:

- tenant resolution overridable by query/cookie outside dev/mock
- one tenant's data cached or rendered for another host
- tenant configuration fields (payment settings, quotas) leaking into props
- admin-authored HTML/scripts from one tenant affecting another
- shared layouts leaking user data

## J. SEO / metadata guardrails

For public/indexable surfaces when applicable:

- `<title>`, description, canonical, Open Graph/Twitter emitted from SSR (not from islands)
- `lang` attribute
- robots/indexing intent per host/tenant
- redirects with correct status codes (301 vs 302)
- sitemap only if intended
- `client:only` pages have no SSR content: acceptable only for private surfaces

Do not apply SEO requirements to private/authenticated surfaces unless relevant.

## K. Accessibility guardrails

For UI changes:

- semantic HTML
- keyboard access
- focus management in dialogs/menus
- accessible names
- form labels/errors
- contrast when design or tenant colors change
- `<noscript>` or fallback for `client:only` surfaces when relevant
- avoid clickable divs when semantic controls exist

Do not report generic accessibility noise unrelated to the change.

## L. Performance guardrails

Only optimize with evidence.

Look for:

- oversized islands and heavy dependencies inside them
- `client:load` where lazier directives work
- duplicated libraries across islands
- icon libraries imported wholesale
- unoptimized images (`astro:assets` when applicable), missing dimensions, LCP images lazy-loaded
- render-blocking fonts/stylesheets
- sequential upstream calls in frontmatter/middleware
- missing caching of expensive per-host lookups
- third-party scripts injected in `<head>`

Do not micro-optimize speculative paths.

## M. Legacy migration guardrails — only if migrating

- Keep public URLs, query params and legacy URL formats (e.g. Angular matrix params `;k=v`) working, via redirects when needed.
- Keep browser storage keys and value formats compatible while both apps coexist on the same domain.
- Keep API contracts byte-compatible with the legacy client unless the backend changes too.
- Record every intentional behavior change (bug fixes included) in a contract/decisions doc.
- Keep a parity suite running the same scenarios against legacy and new app when feasible.
- Do not remove legacy behavior because "nobody uses it" without evidence.

## N. `GUARDRAILS_PROFILE.md`

Generate a project-specific profile:

```markdown
# Guardrails profile

Project mode: company | personal | unknown

## Detected stack

- Astro:
- Output / adapter:
- Prerendered routes:
- React / islands:
- TypeScript:
- Middleware / locals:
- Endpoints / BFF:
- Env:
- Auth / session:
- Data / upstream:
- Cache:
- Tenancy:
- Tests:
- E2E / contract / parity:
- Lint / typecheck:
- CI:
- Deploy:

## Product surfaces

- ...

## Critical boundaries

- server/island (props):
- hydration:
- env / secrets:
- middleware / tenant:
- auth / authorization:
- endpoints / BFF:
- cache:
- raw HTML:
- mock/test switches:
- legacy compatibility:

## Required verification gates

- ...

## High-risk changes

- ...
```

Keep it concise.

## O. `SYSTEM_MAP.md`

Owner-readable 5–10 minute map.

Include:

- product surfaces
- route → page → island map with directives
- middleware responsibilities and locals
- main data flows (server frontmatter and browser → BFF)
- auth/session model
- mutation paths
- cache model
- external integrations
- runtime/deployment topology
- 5–15 files/directories worth knowing

## P. `DECISIONS.md`

Give each entry a stable ID (`D-012`) so a one-line code comment can point to it.

Also create `HISTORY.md` for non-obvious fixes, regressions and workarounds (anchored entries with Rule, Why, Where; reuse an existing equivalent such as `RATIONALE.md`). It is not a changelog: only knowledge the code alone does not show. Format and the comment policy to copy into `AGENTS.md`: `references/comments-and-history.md`.

Only durable architectural decisions (output mode, adapter, BFF, token location, tenancy model, compatibility commitments, intentional deviations from legacy).

## Q. `TESTING.md`

Document only real commands/environments.

Separate when applicable:

- lint
- typecheck
- unit/component
- E2E against production build
- contract (BFF request shapes)
- parity vs legacy
- production-like runtime
- mock vs live
- auth / payments / webhooks
- SEO/public route checks

Mark gaps explicitly.

# `WORKFLOW.md`

One file for the change workflow. It replaces the old per-step files (`skills/01-plan-change.md` … `08-*.md`).

1. Copy `references/WORKFLOW.template.md` to `docs/engineering/WORKFLOW.md` (or the repo's docs folder) as is. The block between `guardrails-workflow:start` and `guardrails-workflow:end` is fixed and identical across projects: do not reword, trim or extend it.
2. Fill only `## Specifics of this project`: per step, what is different here (canonical homes, surfaces and guards, conventions that change a step). Link `TESTING.md`, `SYSTEM_MAP.md` and conventions docs instead of repeating them. Skip steps with nothing specific. Terse bullets, but completeness beats length: a project-specific rule, trap, command or heuristic is never dropped to save lines.
3. Link `WORKFLOW.md` from `AGENTS.md`; do not copy its content there.
4. Upgrade: if `WORKFLOW.md` exists with an older marker, replace only the fixed block. If the project still has per-step files: first list every project-specific rule, trap, command and heuristic they contain; each one must land in Specifics or in a doc Specifics links to (only generic advice the fixed block states explicitly may be dropped). Check the list against the result before deleting the old files, keep them recoverable (git history, or an archive folder when the project has no git), and fix every link to them.

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
