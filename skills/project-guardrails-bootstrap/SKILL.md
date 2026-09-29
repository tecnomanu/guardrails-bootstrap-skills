---
name: project-guardrails-bootstrap
description: >
  Analyze an existing repository, detect its primary stack and architecture profile,
  and choose the most appropriate specialized guardrails bootstrap skill.
  Supports Laravel, Next.js, Astro + React islands, client-rendered React (SPA), Godot, and complex Node/JavaScript/TypeScript projects.
---

# Project Guardrails Bootstrap

## Purpose

This is a meta-skill.

It does not directly install a fixed set of guardrails.
It first analyzes the repository, detects the real project type,
and then selects the most appropriate specialized bootstrap skill.

Supported target skills:

- `laravel-guardrails-bootstrap`
- `nextjs-guardrails-bootstrap`
- `astro-react-guardrails-bootstrap`
- `react-guardrails-bootstrap`
- `godot-guardrails-bootstrap`
- `node-fullstack-guardrails-bootstrap`

If none fits well enough, say so explicitly and recommend:
- the closest fallback; or
- creating a new specialized bootstrap skill.

---

## Core principle

- Do not guess the stack from the repo name.
- Detect the real repository from evidence.
- Do not apply guardrails before classification.
- Always analyze first.

---

## Invocation context

Optional:

`PROJECT_MODE=personal`  
`PROJECT_MODE=company`  
`PROJECT_MODE=unknown`

Default: `unknown`.

If `unknown`, prefer stricter behavior for security, auth, infrastructure,
production data, destructive operations and deployment-sensitive work.

---

# PHASE 1 — Detect and recommend only

Do not modify files.

Inspect the repository root and enough structure to classify the project.

## A. Collect evidence

Inspect when present:

- `AGENTS.md`
- `README.md`
- `package.json`
- `composer.json`
- `project.godot`
- `next.config.*`
- `astro.config.*`
- `vite.config.*` / `craco.config.*` / `rsbuild.config.*`
- `artisan`
- `app/`
- `routes/`
- `resources/js/`
- `src/`
- `apps/`
- `packages/`
- `pages/`
- `scenes/`
- `scripts/`
- `tests/`
- `docs/`
- lockfiles
- Docker / CI / deploy files

## B. Detect the primary project type

Use actual signals.

### Choose `laravel-guardrails-bootstrap` when evidence strongly indicates Laravel, such as:
- `artisan`
- `composer.json` with `laravel/framework`
- `app/Http/`
- `routes/web.php`, `routes/api.php`
- Blade and/or Inertia structure
- optional Horizon / Reverb / Sanctum / SSO

### Choose `nextjs-guardrails-bootstrap` when evidence strongly indicates Next.js, such as:
- `next.config.*`
- `package.json` with `next`
- `app/` and/or `pages/`
- React components tied to Next runtime
- optional App Router / Pages Router / Server Actions

### Choose `astro-react-guardrails-bootstrap` when evidence strongly indicates Astro, such as:
- `astro.config.*`
- `package.json` with `astro` (usually plus `@astrojs/react` and an adapter like `@astrojs/node`)
- `src/pages/*.astro`, `src/layouts/*.astro`
- React components hydrated with `client:*` directives
- optional `src/middleware.ts`, `src/pages/api/*.ts` endpoints/BFF, `output: 'server'`

### Choose `react-guardrails-bootstrap` when evidence strongly indicates a client-rendered React app, such as:
- `package.json` with `react` and `react-dom`, but no `next` or `astro`
- a bundler config (`vite.config.*`, `craco.config.*`, `rsbuild.config.*`, webpack) and `index.html`
- `src/main.*` / `src/index.*` calling `createRoot`
- client routing (React Router, TanStack Router) and an external API
- optional React Router framework mode / Remix SSR

### Choose `godot-guardrails-bootstrap` when evidence strongly indicates Godot, such as:
- `project.godot`
- `.tscn`
- `.gd` or `.cs`
- `scenes/`, `scripts/`, `addons/`

### Choose `node-fullstack-guardrails-bootstrap` when evidence indicates a broader JS/TS repository, such as:
- `package.json`
- daemon/service/backend
- web frontend that is not primarily a plain Next.js app
- CLI/TUI
- MCP
- workers
- monorepo surfaces
- plugin/provider/adapter systems
- docs + runtime code mixed in one repo

## C. If the repository is mixed

If the repository contains more than one ecosystem, decide the **primary** skill based on:

1. the main runtime/system being developed;
2. the repository root architecture;
3. the dominant source of engineering risk.

Then list secondary concerns.

Examples:

- Laravel app with embedded Next shell  
  → primary: `laravel-guardrails-bootstrap`

- Monorepo with `apps/web` Next.js and `apps/api` Node service  
  → primary: `node-fullstack-guardrails-bootstrap`

- Laravel API plus a separate Vite React SPA in `frontend/`  
  → primary: the surface the owner works on most; mention the other as secondary

- Godot game plus a tiny web landing page  
  → primary: `godot-guardrails-bootstrap`

## D. Output required

Return exactly these sections:

### Detected profile
Short description of the repo and why.

### Primary recommended skill
One of:
- `laravel-guardrails-bootstrap`
- `nextjs-guardrails-bootstrap`
- `astro-react-guardrails-bootstrap`
- `react-guardrails-bootstrap`
- `godot-guardrails-bootstrap`
- `node-fullstack-guardrails-bootstrap`

### Why this skill
Concrete repository evidence.

### Secondary concerns
Optional. Example: SSO, Reverb, Horizon, multi-surface app, MCP, monorepo, multiplayer, etc.

### Suggested invocation
Provide the exact message the owner should send next.

### Confidence
HIGH / MEDIUM / LOW

Do not apply any bootstrap yet.

Stop after Phase 1 unless explicitly told to continue.

---

# PHASE 2 — Apply the selected bootstrap

Only after explicit approval.

If the appropriate specialized bootstrap skill is available, use it.

If it is not available, say which one is missing and stop.

When applying:
- preserve the specialized skill as authoritative for the bootstrap logic;
- pass along the detected context;
- keep `PROJECT_MODE`;
- run only that skill’s normal workflow.

Default recommendation:
1. apply the selected skill’s Phase 1 first if it has not been run yet;
2. after approval, apply that skill’s Phase 2.

If the owner explicitly asks for direct application after classification, do this flow:

### Step 1
Run this meta-skill Phase 1 classification.

### Step 2
Immediately invoke the selected specialized bootstrap and execute only its Phase 1.

### Step 3
Return the audit/recommendation.

Do not silently jump to documentation changes unless explicitly authorized.

---

# PHASE 3 — Final response format after direct application

If the owner explicitly asked you to classify and immediately start the target bootstrap, return:

### Detected profile
### Selected skill
### Why
### Specialized bootstrap status
- not started
- Phase 1 completed
- Phase 2 completed

### Next action for the owner

---

# Hard rules

1. Never guess based on repo name alone.
2. Never install generic guardrails before stack detection.
3. Never choose Next.js, Astro or React if the repo is actually a broader Node platform with that web app as only one surface.
4. Never choose Node fullstack when the repo is clearly just a normal Laravel or Godot project.
5. If confidence is LOW, say so.
6. If the repository does not fit current supported skills well, say so explicitly.
7. Do not refactor or add docs during classification.
8. Preserve project-specific rules and docs when the specialized bootstrap later runs.
9. Keep this meta-skill small: it routes, it does not replace the target skills.
