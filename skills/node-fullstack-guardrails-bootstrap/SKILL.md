---
name: node-fullstack-guardrails-bootstrap
description: >
  Bootstrap or improve AI-first engineering guardrails in an existing Node.js,
  JavaScript or TypeScript repository. Detects backend/daemon services, web apps,
  CLI/TUI, MCP servers, workers, docs, mobile/desktop surfaces, APIs, auth, tests,
  build/deploy and runtime boundaries before creating project-specific AGENTS.md
  and engineering guardrails.
---

# Node / JavaScript / TypeScript Fullstack Guardrails Bootstrap

## Purpose

Install or improve AI-first engineering guardrails in an existing Node.js / JavaScript / TypeScript repository without changing product behavior.

This skill is intentionally broad enough for repositories that contain several surfaces at once, for example:

- backend/API
- daemon/service
- web frontend
- CLI
- TUI
- MCP server/client
- workers/background jobs
- desktop app
- mobile app
- docs/static site
- packages/monorepo
- integrations/plugins/adapters

It must detect the real architecture. Never impose a Laravel-style, Clean Architecture, DDD, React-style or other familiar architecture over a coherent repository that already exists.

## Invocation context

Optional:

`PROJECT_MODE=personal`
`PROJECT_MODE=company`
`PROJECT_MODE=unknown`

Default: `unknown`.

`company`/`unknown` are stricter around auth, secrets, infrastructure, deploy, dependencies, production data and irreversible changes.

## Core principle

AI may author most or all implementation code.

The owner may not know every framework/library in the repository.

Therefore the project must preserve:
- clear system boundaries;
- runtime evidence;
- tests;
- dependency discipline;
- architecture visibility;
- security boundaries;
- a concise human model.

# PHASE 1 — Audit only

Do not modify files.

Inspect when present:

- `AGENTS.md`
- `README.md`
- `package.json`
- lockfile
- workspace/monorepo config
- `src/`
- `apps/`
- `packages/`
- `web/`
- `docs/`
- tests
- lint/typecheck config
- build config
- Docker/container config
- CI
- deploy config
- runtime scripts
- MCP/plugin/adapter configuration

## A. Detect the real stack

Report only what exists:

- Node version/runtime
- JavaScript/TypeScript mix
- module system
- package manager
- monorepo yes/no
- web framework(s)
- backend framework(s)
- CLI/TUI
- daemon/service
- MCP
- workers/queues
- database/storage
- auth/SSO
- WebSocket/realtime
- mobile/desktop
- test frameworks
- lint/typecheck/build
- docs system
- CI/deploy

## B. Map product/runtime surfaces

For each actual surface:

| Surface | Entry point | Runtime | Auth | State | Main boundary |
|---|---|---|---|---|---|

Examples:
- daemon
- API
- web
- CLI
- TUI
- MCP
- worker
- docs
- desktop
- mobile

Do not assume all surfaces share state, auth or lifecycle.

## C. Map architecture

Identify:

- core/domain/application logic
- adapters
- surfaces/interfaces
- registries/plugin systems
- state stores
- persistence
- network boundaries
- tool execution
- background execution
- frontend state
- build/runtime boundaries

Describe dependency direction that actually exists.

## D. Guardrail gaps

Look for real evidence of:

- duplicated canonical operations
- circular/wrong-direction imports
- god modules
- hidden side effects
- runtime state leaking across boundaries
- direct provider/framework dependencies inside core logic
- unsafe plugin/tool boundaries
- auth/permission drift
- prompt/tool injection surfaces in agentic systems
- untrusted data crossing privilege boundaries
- duplicated tool execution
- retry/idempotency problems
- stale async state
- unsafe filesystem/command/network handling
- secrets/logging issues
- dependency sprawl
- build/runtime mismatch
- tests that mirror implementation
- agents declaring success without loading/running the changed path
- long narrative comments (history, incident stories, rejected alternatives inside code) and personal data, local paths or AI-tool metadata in code/docs; report counts and hotspots only, the bootstrap does not rewrite them

Do not manufacture findings.

## E. Dependency and extensibility audit

When the repo has adapters/plugins/providers/registries/MCP/tools:

- identify the canonical extension mechanism
- detect bypasses
- identify stable interfaces/contracts
- flag direct imports/calls that break dependency direction
- distinguish mechanically enforced boundaries from convention-only boundaries

## F. Test/runtime audit

Document:

- install
- lint
- typecheck
- unit/integration
- build
- start/dev
- daemon reload/restart
- web runtime
- CLI/TUI runtime
- MCP runtime
- worker runtime
- E2E
- health checks

Only real commands.

## G. Classify docs

### KEEP
### ARCHIVE
### UPDATE
### ADD

## H. Proposed target structure

Prefer:

```text
AGENTS.md

docs/
  engineering/
    HUMAN_MODEL.md
    SYSTEM_MAP.md
    DECISIONS.md
    TESTING.md
    HISTORY.md
    GUARDRAILS_PROFILE.md
    WORKFLOW.md
```

Adapt to the repo.

If the project already has a strong architecture document, do not duplicate it.

Stop after Phase 1 unless explicitly told to apply.

# PHASE 2 — Install guardrails

Only after explicit approval.

Do not change runtime/product behavior.

Do not:
- refactor implementation
- add dependencies
- change APIs/contracts
- change auth
- change persistence/schema
- change build/deploy
- change daemon/process topology
- change plugin/MCP contracts

## A. `AGENTS.md`

Preserve existing project-specific rules.

Add AI-native workflow:

PLAN
→ IMPLEMENT
→ FRESH-CONTEXT REVIEW
→ SECURITY/RISK REVIEW when applicable
→ TEST + REAL RUNTIME VERIFICATION
→ ARCHITECTURE DRIFT CHECK when structural
→ OWNER BRIEF
→ RELEASE CHECK when deploy-sensitive

Hard rules:

1. Existing repository architecture wins over generic patterns.
2. No unrelated refactors inside a task.
3. Search for canonical existing behavior before creating new behavior.
4. Do not mechanically apply SOLID/DRY/patterns.
5. Balance with KISS/YAGNI and native repository conventions.
6. No speculative abstractions.
7. No casual dependency additions.
8. Never weaken lint/types/tests/security to get green.
9. Self-review is not independent validation.
10. Meaningful changes require fresh-context review.
11. Bug fixes should add regression coverage when feasible.
12. Runtime/process changes require real execution-path verification.
13. Structural changes require architecture-drift review.
14. New dependencies must state why platform/existing primitives are insufficient.
15. Preserve observability and explicit failure modes.
16. Do not hide diagnosis behind a large refactor.
17. Treat external/untrusted input as untrusted at every privilege boundary.
18. In agentic/tool systems, model output must not become unchecked authority for side effects.
19. Code comments: 1–2 lines, only the non-obvious why. No history, incidents or rejected alternatives in code; put them in `HISTORY.md`/`DECISIONS.md` and reference its anchor (`See HISTORY.md#invite-link`). Details: `references/comments-and-history.md`.
20. No personal data, machine-local paths or AI-tool metadata (model names, agent branches, "generated by") in code, comments, docs, fixtures or commit messages.

## B. `GUARDRAILS_PROFILE.md`

Generate project-specific profile:

- runtime/language
- package manager
- surfaces
- persistence
- auth
- plugins/adapters/MCP
- workers
- web/realtime
- tests
- build/runtime
- CI/deploy
- critical boundaries
- required gates
- high-risk changes

## C. `HUMAN_MODEL.md`

For owners who do not know all internals.

Keep it concise.

Map:
1. processes that run
2. entry points
3. major layers/modules and dependency direction
4. important flows
5. state/persistence
6. workers/background processes
7. external integrations
8. auth/permissions
9. build/test/deploy/runtime lifecycle
10. 5–15 files/directories worth knowing
11. fragile seams
12. mechanically enforced vs convention-only rules

## D. `SYSTEM_MAP.md`

If `HUMAN_MODEL.md` already sufficiently covers architecture, merge these concepts rather than duplicating docs.

## E. `DECISIONS.md`

Give each entry a stable ID (`D-012`) so a one-line code comment can point to it.

Also create `HISTORY.md` for non-obvious fixes, regressions and workarounds (anchored entries with Rule, Why, Where; reuse an existing equivalent such as `RATIONALE.md`). It is not a changelog: only knowledge the code alone does not show. Format and the comment policy to copy into `AGENTS.md`: `references/comments-and-history.md`.

Durable architectural decisions only.

## F. `TESTING.md`

Only real commands and runtime verification paths.

## G. `WORKFLOW.md`

One file for the change workflow. It replaces the old per-step files (`skills/01-plan-change.md` … `08-*.md`).

1. Copy `references/WORKFLOW.template.md` to `docs/engineering/WORKFLOW.md` (or the repo's docs folder) as is. The block between `guardrails-workflow:start` and `guardrails-workflow:end` is fixed and identical across projects: do not reword, trim or extend it.
2. Fill only `## Specifics of this project`: per step, what is different here (canonical homes, surfaces and guards, conventions that change a step). Link `TESTING.md`, `SYSTEM_MAP.md` and conventions docs instead of repeating them. Skip steps with nothing specific. Terse bullets, but completeness beats length: a project-specific rule, trap, command or heuristic is never dropped to save lines.
3. Link `WORKFLOW.md` from `AGENTS.md`; do not copy its content there.
4. Upgrade: if `WORKFLOW.md` exists with an older marker, replace only the fixed block. If the project still has per-step files: first list every project-specific rule, trap, command and heuristic they contain; each one must land in Specifics or in a doc Specifics links to (only generic advice the fixed block states explicitly may be dropped). Check the list against the result before deleting the old files, keep them recoverable (git history, or an archive folder when the project has no git), and fix every link to them.

# PHASE 3 — Validate bootstrap

Return:

## Created
## Updated
## Archived
## Preserved
## Detected profile
## Runtime impact
Must be `NONE` unless explicitly authorized.
## Resulting workflow
## Human review requested

Do not begin feature/refactor work as part of bootstrap.
