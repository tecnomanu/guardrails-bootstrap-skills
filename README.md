# guardrails-bootstrap-skills

Agent skills that install **engineering guardrails for AI-written code** into an
existing repository: an `AGENTS.md`, a short set of engineering docs and a
plan → implement → review → verify → brief workflow, adapted to the stack the
repo actually uses.

They work with any agent that reads `SKILL.md` skills (Claude Code, Cursor,
Codex and others).

## Skills

| Skill | Use it for |
|---|---|
| `project-guardrails-bootstrap` | Start here. Detects the stack and picks one of the skills below. |
| `laravel-guardrails-bootstrap` | Laravel (Blade, Inertia, queues, Horizon, Reverb, SSO). |
| `nextjs-guardrails-bootstrap` | Next.js (App/Pages Router, Server Actions, caching). |
| `astro-react-guardrails-bootstrap` | Astro with React islands, SSR/BFF. |
| `react-guardrails-bootstrap` | Client-rendered React apps (Vite, CRA, React Router, TanStack). |
| `node-fullstack-guardrails-bootstrap` | Node/TS services, CLIs, MCP servers, monorepos. |
| `godot-guardrails-bootstrap` | Godot games, with or without multiplayer. |

## How they work

Every skill runs in three phases and never changes product behavior:

1. **Audit** (read-only): real stack, surfaces, boundaries and risks. Stops here.
2. **Install** (after you approve): `AGENTS.md` plus `GUARDRAILS_PROFILE.md`,
   `SYSTEM_MAP.md`, `DECISIONS.md`, `HISTORY.md`, `TESTING.md` and `WORKFLOW.md`.
3. **Report**: what was created, kept and archived, and what to check by hand.

`WORKFLOW.md` (plan, implement, review, security, test, architecture, owner
brief, release) has a fixed block that is identical in every project, plus a
short *Specifics of this project* section. Upgrading means replacing the fixed
block; the agent never rewrites it, so it does not drift or grow.

Pass `PROJECT_MODE=company` or `PROJECT_MODE=personal` to set how strict
change control should be. Unknown defaults to strict.

## Short comments, history in docs

Agents asked to keep code "understandable" tend to write paragraph-long comments
full of history: how a bug was found, what the old version did, which idea was
rejected. The installed rules keep comments to 1–2 lines of *why* and move the
rest to `HISTORY.md` / `DECISIONS.md`, referenced by a stable anchor:

```php
// Invite links never share the resume route. See HISTORY.md#invite-link
```

They also forbid personal data, machine-local paths and AI-tool metadata in
code, docs and commits. Full policy: [`shared/comments-and-history.md`](shared/comments-and-history.md).

## Install

With the [`skills`](https://github.com/vercel-labs/skills) CLI:

```bash
npx skills add tecnomanu/guardrails-bootstrap-skills
```

Or copy the folders you want:

```bash
git clone https://github.com/tecnomanu/guardrails-bootstrap-skills
cp -R guardrails-bootstrap-skills/skills/* ~/.claude/skills/
```

Then ask your agent: *"Run project-guardrails-bootstrap on this repo."*

## Contributing

Edit `shared/` (common rules, workflow core, per-stack checks) and run
`scripts/sync-shared.sh` to rebuild each skill's `references/`. Bump
`shared/WORKFLOW_VERSION` when the fixed workflow block changes. A new stack gets its own
`skills/<stack>-guardrails-bootstrap/` and a routing entry in
`project-guardrails-bootstrap`.

MIT license.
