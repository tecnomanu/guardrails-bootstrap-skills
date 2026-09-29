---
name: laravel-guardrails-bootstrap
description: >
  Bootstrap or improve AI-first engineering guardrails in an existing
  Laravel project. Audits the real stack, architecture, auth, Inertia,
  queues, Horizon, Reverb, SSO, tests and deployment before creating
  project-specific AGENTS.md and engineering guardrails.
---

# Skill: Bootstrap AI Guardrails for Existing Laravel Project

## Purpose

Install or improve AI-first engineering guardrails in an existing Laravel project without changing product behavior.

This skill is intentionally generic and reusable across different Laravel applications.

It must adapt to the repository that actually exists. Do not assume that every project uses the same architecture, packages, authentication model, deployment process, or product surfaces.

Possible stack elements include, but are not limited to:

- Laravel
- Inertia
- React or Vue
- Horizon / queues
- Redis
- Reverb / broadcasting
- Sanctum
- SSO / OAuth / OIDC / SAML
- admin panels
- public websites
- authenticated webapps
- customer/account panels
- APIs
- scheduled jobs
- webhooks
- external integrations

Some projects may not use several of these. Never introduce or document a subsystem that does not exist.

# Invocation context

The owner may provide one of these modes:

`PROJECT_MODE=company`

or

`PROJECT_MODE=personal`

If no mode is provided, use:

`PROJECT_MODE=unknown`

When mode is `unknown`, use the stricter behavior for security, auth, data, production, infrastructure and destructive operations.

The technical quality standard is the same in every mode.

`company` mode adds stricter change-control expectations around credentials/secrets, authentication/SSO, authorization, production data, infrastructure, dependencies, deployment, external integrations and irreversible operations.

Do not invent corporate processes that are not present in the repository.

# Core principle

AI may author most or all implementation code.

Quality is judged by architecture, correctness, security, verification, maintainability, runtime evidence and human inspectability.

The owner is not required to read every changed line.

For meaningful changes, the agent must make the system understandable through a plan, explicit risks, verification evidence, architecture awareness and an owner-facing brief.

# Authority order

Before changing anything, determine what documentation already governs the repository.

Use this precedence:

1. Existing `AGENTS.md`
2. Repository-specific engineering/security/architecture rules
3. Existing application behavior and tests
4. Existing architecture/product documentation
5. This bootstrap skill

Do not overwrite useful project-specific knowledge with generic Laravel rules.

If existing documentation conflicts with current code or production behavior, flag the conflict instead of silently choosing one.

# PHASE 1 — Audit only

Do not modify files.

Inspect at minimum, when present:

- `AGENTS.md`
- `README.md`
- `composer.json`
- `package.json`
- `routes/`
- `app/`
- `resources/js/`
- `tests/`
- `config/`
- `bootstrap/`
- `database/migrations/`
- deployment/container files
- CI configuration
- existing docs
- queue/broadcast/auth configuration
- relevant frontend config

## A. Detect the real stack

Report only what is actually present.

Determine:

- Laravel version
- PHP version
- Inertia yes/no
- React/Vue/other
- TypeScript yes/no
- Redis yes/no
- Horizon yes/no
- queues yes/no and drivers
- Reverb yes/no
- broadcasting yes/no and implementation
- Sanctum/session/API auth
- SSO/OAuth/OIDC/SAML/custom identity integration
- database
- test framework
- static analysis
- formatter/linter
- frontend tests/build/typecheck
- scheduler
- webhooks
- external integrations
- container/deploy strategy
- CI
- branch/PR conventions if present

Never assume a component from this list exists.

## B. Map product surfaces

Identify the actual application surfaces.

Examples:

- public marketing website
- public webapp
- authenticated application
- admin panel
- customer/account portal
- API
- webhook endpoints
- background workers
- realtime clients
- internal tools

For each surface explain:

- entry point/routes
- authentication boundary
- authorization boundary
- primary controllers/actions/services
- data source
- important side effects

Do not assume all surfaces share the same auth or middleware.

## C. Map architecture

Explain the repository's current architecture before recommending changes.

Identify:

- controllers
- Form Requests
- Actions
- Services
- domain/application classes
- models
- repositories if they genuinely exist
- Policies/Gates
- Resources/Data objects
- Jobs
- Commands
- Events/Listeners
- Notifications
- frontend page/component boundaries
- API clients
- shared utilities
- integrations/adapters

Look for canonical paths already used by the project.

## D. Identify current guardrail gaps

Look for actual risks such as:

- business logic in controllers
- duplicated business operations
- inconsistent validation
- authorization in the wrong layer
- tenant/account boundary mistakes
- direct model writes bypassing canonical actions
- hidden side effects
- unsafe queue retry behavior
- non-idempotent jobs
- weak webhook validation
- SSO/account-linking risks
- secrets in logs/config
- N+1 queries
- unbounded queries
- fragile migrations
- frontend duplicated server truth
- polling where realtime already exists
- broadcast data leakage
- packages added casually
- unrelated refactors mixed with features
- tests that mirror implementation instead of behavior
- agents reporting success without runtime evidence
- long narrative comments (history, incident stories, rejected alternatives inside code) and personal data, local paths or AI-tool metadata in code/docs; report counts and hotspots only, the bootstrap does not rewrite them

Do not manufacture findings to fill a checklist.

## E. Classify historical documentation

Return:

### KEEP
Current product/engineering truth.

### ARCHIVE
Historical build plans, migration waves, old agent roles, obsolete ownership maps, stale specs.

### UPDATE
Useful current docs containing obsolete references.

### ADD
Missing guardrails/docs needed for AI-first development.

## F. Propose target structure

Prefer something like:

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

Adapt this to existing repository conventions.

Do not create duplicate architecture documents if a good one already exists.

Stop after Phase 1 unless explicitly told to apply.

# PHASE 2 — Install guardrails

Only run after explicit approval.

The bootstrap itself must not change product behavior.

Unless explicitly authorized, Phase 2 may modify only documentation and guardrail configuration.

Do not:
- refactor application code;
- add packages;
- change migrations;
- modify `.env`;
- alter auth;
- alter queues;
- alter broadcasting;
- alter deployment;
- change runtime behavior.

## A. `AGENTS.md`

If an existing `AGENTS.md` exists, preserve project-specific rules and improve it.

If none exists, create one.

It must describe the actual project, not a generic Laravel tutorial.

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
6. Do not weaken tests, typing, static analysis, validation, authorization or security controls to obtain green checks.
7. The implementer may self-review, but self-review is not independent validation.
8. Meaningful changes require a fresh-context review before completion.
9. Bug fixes should add regression coverage when feasible.
10. Tests must prove behavior, not merely repeat implementation.
11. Integration-heavy changes require verification through the real execution path when feasible.
12. Structural changes require architecture-drift review.
13. Never expose secrets or real credentials in code, prompts, logs, docs or tests.
14. Never make destructive production/data operations without explicit authorization.
15. Keep diffs scoped and explain any unavoidable cross-module change.
16. Code comments: 1–2 lines, only the non-obvious why. No history, incidents or rejected alternatives in code; put them in `HISTORY.md`/`DECISIONS.md` and reference its anchor (`See HISTORY.md#invite-link`). Details: `references/comments-and-history.md`.
17. No personal data, machine-local paths or AI-tool metadata (model names, agent branches, "generated by") in code, comments, docs, fixtures or commit messages.

## B. Laravel architecture guardrails

Adapt these to the existing architecture. Do not force a pattern that the project does not use.

### HTTP

- Controllers coordinate HTTP concerns and delegate business behavior.
- Prefer Form Requests for meaningful validation/authorization when consistent with the project.
- Do not hide business logic inside controllers.
- Do not confuse authentication with authorization.

### Business operations

- One business operation should have one canonical implementation.
- Reuse existing Actions/Services/domain operations instead of duplicating them.
- Do not create generic Service classes as dumping grounds.
- Use transactions around true atomic operations.
- Keep external side effects explicit.

### Persistence

- Watch for N+1 queries.
- Avoid unbounded loads.
- Use eager loading deliberately.
- Treat migrations as production operations.
- Consider locks, indexes, defaults, backfills, rollout order and rollback.

### Queues / Horizon — only if present

When queues exist:

- retryable jobs should be idempotent where repeated execution can duplicate side effects;
- define retry/backoff/timeout semantics where relevant;
- terminal failures must remain observable;
- external API calls need explicit failure/retry behavior;
- avoid stale mutable payload assumptions.

Do not document Horizon-specific behavior if Horizon is not installed.

### Reverb / broadcasting — only if present

When realtime/broadcasting exists:

- authorize private/presence channels;
- do not broadcast data the subscriber is not allowed to access;
- keep business truth outside client events;
- consider database commit ordering;
- avoid polling that duplicates an established realtime path unless explicitly justified.

Do not introduce Reverb merely because this skill mentions it.

### Inertia — only if present

- Server authorization remains authoritative.
- Avoid duplicate requests for data already delivered as page props.
- Keep shared/global props small.
- Avoid leaking internal/secret fields into page props.
- Keep expensive optional data lazy/deferred where appropriate and supported.
- Do not create a parallel API surface without need.

### Frontend

- Keep server truth authoritative for business state.
- Keep client state local unless genuinely shared.
- Treat loading/error/empty/stale states explicitly.
- Reuse existing components and APIs before creating new variants.
- Avoid abstractions based only on visual coincidence.

## C. Authentication / SSO guardrails — only when relevant

First detect the real auth model.

Possible cases:
- Laravel sessions
- Sanctum
- OAuth
- OIDC
- SAML
- Socialite
- custom SSO
- multiple auth surfaces/providers

When SSO/federated identity exists, document and enforce:

- identity provider vs local account source of truth;
- account linking rules;
- email/subject identifier trust;
- callback validation;
- state/nonce/PKCE where applicable;
- redirect allowlists;
- role/permission mapping;
- deprovisioning/session invalidation expectations;
- tenant/account association;
- privilege escalation boundaries.

Never rewrite or simplify SSO as part of unrelated work.

When no SSO exists, do not create SSO-specific documentation.

## D. Multi-surface applications

If the project has multiple surfaces such as admin, public web, public webapp or customer/account portal, document them explicitly in `SYSTEM_MAP.md`.

For each surface record:

| Surface | Routes/entry | Auth | Authorization | Main data path |
|---|---|---|---|---|

Do not assume a permission valid in one surface is valid in another.

Explicitly guard against:
- admin authorization leaking into customer routes;
- customer session assumptions leaking into public surfaces;
- shared Inertia props exposing data across surfaces;
- duplicated business operations implemented independently per surface.

## E. `docs/engineering/GUARDRAILS_PROFILE.md`

Create a small project-specific profile generated from the audit.

Example structure:

```markdown
# Guardrails profile

Project mode: company | personal | unknown

## Detected stack

- Laravel:
- Inertia:
- Frontend:
- Queue:
- Horizon:
- Realtime/Reverb:
- Auth:
- SSO:
- Database:
- Tests:
- Static analysis:
- CI:
- Deploy:

## Product surfaces

- ...

## Critical boundaries

- auth:
- authorization:
- tenant/account:
- payments:
- SSO:
- webhooks:
- external APIs:
- queues:
- realtime:

## Required verification gates

- ...

## High-risk changes

- ...
```

This file lets the generic workflow adapt to each project without maintaining separate bootstrap skills.

Keep it concise.

## F. `SYSTEM_MAP.md`

Create or improve one owner-readable architecture map.

It should explain:

- product surfaces;
- main request/data flows;
- auth/authorization;
- main domain boundaries;
- queues if present;
- realtime if present;
- SSO if present;
- external integrations;
- source-of-truth boundaries;
- production/runtime topology;
- 5–15 files/directories worth knowing.

A technical owner should be able to reread it in roughly 5–10 minutes.

## G. `DECISIONS.md`

Give each entry a stable ID (`D-012`) so a one-line code comment can point to it.

Also create `HISTORY.md` for non-obvious fixes, regressions and workarounds (anchored entries with Rule, Why, Where; reuse an existing equivalent such as `RATIONALE.md`). It is not a changelog: only knowledge the code alone does not show. Format and the comment policy to copy into `AGENTS.md`: `references/comments-and-history.md`.

Create only if an equivalent current ADR/decision log does not already exist.

Template:

## D-NNN — YYYY-MM-DD — Decision title

**Context:**  
**Decision:**  
**Why:**  
**Do not change casually:**  
**Revisit when:**  

Only durable architectural decisions belong here.

Do not turn it into a changelog.

## H. `TESTING.md`

Document only real commands and environments already present in the repository.

Separate:
- backend tests
- frontend tests
- typecheck
- static analysis
- formatter/linter
- browser/E2E
- queue verification
- realtime verification
- SSO verification
- webhooks
- external integrations
- production-like runtime checks

Mark gaps explicitly.

Never invent tooling.

# `WORKFLOW.md`

One file for the change workflow. It replaces the old per-step files (`skills/01-plan-change.md` … `08-*.md`).

1. Copy `references/WORKFLOW.template.md` to `docs/engineering/WORKFLOW.md` (or the repo's docs folder) as is. The block between `guardrails-workflow:start` and `guardrails-workflow:end` is fixed and identical across projects: do not reword, trim or extend it.
2. Fill only `## Specifics of this project`: per step, what is different here (canonical homes, surfaces and guards, conventions that change a step). Link `TESTING.md`, `SYSTEM_MAP.md` and conventions docs instead of repeating them. Skip steps with nothing specific. Terse bullets, but completeness beats length: a project-specific rule, trap, command or heuristic is never dropped to save lines.
3. Link `WORKFLOW.md` from `AGENTS.md`; do not copy its content there.
4. Upgrade: if `WORKFLOW.md` exists with an older marker, replace only the fixed block. If the project still has per-step files: first list every project-specific rule, trap, command and heuristic they contain; each one must land in Specifics or in a doc Specifics links to (only generic advice the fixed block states explicitly may be dropped). Check the list against the result before deleting the old files, keep them recoverable (git history, or an archive folder when the project has no git), and fix every link to them.

# PHASE 3 — Validate bootstrap

After applying guardrails, return one concise report:

## Created
Files added.

## Updated
Existing guardrail/docs files changed.

## Archived
Historical instructions removed from the active path.

## Preserved
Important project-specific rules retained.

## Detected profile
Stack, surfaces and critical boundaries.

## Runtime impact
Must be `NONE` unless explicitly authorized otherwise.

## Resulting workflow

PLAN
→ IMPLEMENT
→ FRESH REVIEW
→ SECURITY/RISK when applicable
→ TEST + RUNTIME
→ ARCHITECTURE CHECK when structural
→ OWNER BRIEF
→ RELEASE CHECK when deploy-sensitive

## Human review requested

At most 5 items worth checking before merging the guardrail-only change.

Do not begin product refactors or feature work as part of the bootstrap.
