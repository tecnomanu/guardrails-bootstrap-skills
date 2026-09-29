---
name: godot-guardrails-bootstrap
description: >
  Bootstrap or improve AI-first engineering guardrails in an existing Godot project.
  Audits scenes, scripts, gameplay architecture, multiplayer authority, tests, runtime,
  performance and project documentation before creating project-specific AGENTS.md
  and engineering guardrails. Supports projects that may or may not use multiplayer.
---

# Godot Guardrails Bootstrap

## Purpose

Install or improve AI-first engineering guardrails in an existing Godot project without changing gameplay behavior.

This skill is reusable across Godot projects. It must adapt to the repository that actually exists.

Possible project characteristics include:

- Godot 4.x
- GDScript and/or C#
- 2D or 3D
- single-player
- multiplayer / ENet / WebSocket / custom networking
- procedural scene construction
- `.tscn` composition
- Resources
- Autoloads
- custom tools/editor scripts
- headless tests
- gameplay tests
- export presets
- desktop/mobile/web targets

Never assume a subsystem exists only because this skill mentions it.

## Invocation context

Optional:

`PROJECT_MODE=personal`
`PROJECT_MODE=company`
`PROJECT_MODE=unknown`

Default: `unknown`.

Technical quality standards are identical. `company`/`unknown` use stricter handling for secrets, infrastructure, builds, distribution and destructive operations.

## Core principle

AI may author most or all code.

Quality is judged by:
- gameplay correctness;
- architecture;
- runtime evidence;
- multiplayer authority when applicable;
- performance;
- maintainability;
- tests;
- human inspectability.

The owner does not need to read every line, but must be able to understand the system map and the risk/verification of meaningful changes.

# PHASE 1 — Audit only

Do not modify files.

Inspect when present:

- `AGENTS.md`
- `README.md`
- product/game design docs
- `project.godot`
- `export_presets.cfg`
- `scenes/**/*.tscn`
- `scripts/**/*.gd`
- `scripts/**/*.cs`
- `tests/`
- `addons/`
- `tools/`
- CI/build/export configuration

## A. Detect the real stack

Report only what exists:

- Godot version
- GDScript/C#
- 2D/3D
- target platforms
- multiplayer yes/no and transport
- Autoloads
- Resources
- addons
- test approach
- export workflow
- runtime tools
- CI

## B. Map runtime/game flow

Explain:

- boot flow
- menu/session flow
- main gameplay flow
- player/input flow
- game-state ownership
- UI/HUD flow
- persistence/save flow if any
- multiplayer authority if any
- important signals/RPCs
- scene-tree ownership

## C. Responsibility audit

Identify major scripts/scenes and their real responsibilities.

Look for actual cohesion problems, not only line count.

## D. Godot-specific risks

Look for evidence of:

- gameplay mixed with presentation
- multiplayer authority mixed with client visuals
- fragile NodePaths / `get_node()` chains
- accidental global state
- overused Autoloads
- Resources where raw dictionaries/strings have become fragile
- hidden lifecycle assumptions
- `_process` / `_physics_process` misuse
- frame-dependent gameplay
- allocations/work in hot loops
- resource loading in hot paths
- direct cross-system calls where signals would clarify ownership
- signal/event systems where direct ownership would be simpler
- `.tscn` vs procedural composition tradeoffs
- duplicated state or sources of truth
- untyped important APIs / RPC payloads
- divergence between offline and multiplayer logic
- long narrative comments (history, incident stories, rejected alternatives inside code) and personal data, local paths or AI-tool metadata in code/docs; report counts and hotspots only, the bootstrap does not rewrite them

Do not force `.tscn`, Resources, signals, composition or patterns without evidence.

## E. Multiplayer audit — only if present

Map:

- authority
- sender/receiver
- trusted/untrusted payloads
- source of truth
- RPCs accepting any peer
- validation
- damage/score/pickup/movement ownership
- desync/reconnect/replay risks

## F. Test/runtime audit

Report:

- what tests protect
- important gaps
- whether tests validate behavior or implementation
- runtime paths that must be manually exercised
- visual/audio/game-feel checks not automatable

## G. Classify docs

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
    SYSTEM_MAP.md
    DECISIONS.md
    TESTING.md
    HISTORY.md
    GUARDRAILS_PROFILE.md
    WORKFLOW.md
```

Do not duplicate good existing docs.

Stop after Phase 1 unless explicitly told to apply.

# PHASE 2 — Install guardrails

Only after explicit approval.

Bootstrap impact must be documentation/guardrails only unless explicitly authorized.

Do not:
- refactor gameplay
- change balance
- change Godot version
- add addons
- change exports
- change multiplayer semantics
- modify scenes/scripts for cleanup

## A. `AGENTS.md`

Preserve existing project-specific truth.

Add an AI-native workflow:

PLAN
→ IMPLEMENT
→ FRESH-CONTEXT REVIEW
→ GAMEPLAY/NETWORK REVIEW when applicable
→ TEST
→ REAL RUNTIME VERIFICATION
→ ARCHITECTURE CHECK when structural
→ OWNER BRIEF

Hard rules:

1. No unrelated refactors inside feature/fix tasks.
2. Search for existing canonical behavior first.
3. Balance SOLID/DRY with KISS/YAGNI and Godot-native composition.
4. Do not create abstractions for speculative reuse.
5. Do not add addons/dependencies casually.
6. Do not weaken tests to obtain green output.
7. Self-review is useful but not independent validation.
8. Meaningful changes require fresh-context review.
9. Bug fixes should add regression coverage when feasible.
10. Parsing/opening the editor is not proof the feature works.
11. Runtime/integration-heavy changes require real execution-path verification.
12. Structural changes require architecture-drift review.
13. Keep gameplay truth out of presentation.
14. Keep multiplayer authority server-side where the design requires it.
15. Do not trust client-provided authoritative outcomes.
16. Prefer signals for decoupled notifications, not as a universal event bus.
17. Prefer reusable scenes for reusable visual/tree compositions when that genuinely helps.
18. Prefer Resource/plain data structures when Node lifecycle is unnecessary.
19. Keep Autoload usage minimal and justified.
20. Keep `_process` / `_physics_process` work intentional and allocation-conscious.
21. Code comments: 1–2 lines, only the non-obvious why. No history, incidents or rejected alternatives in code; put them in `HISTORY.md`/`DECISIONS.md` and reference its anchor (`See HISTORY.md#invite-link`). Details: `references/comments-and-history.md`.
22. No personal data, machine-local paths or AI-tool metadata (model names, agent branches, "generated by") in code, comments, docs, fixtures or commit messages.

## B. `GUARDRAILS_PROFILE.md`

Generate from the actual project:

- Godot version
- language
- targets
- multiplayer
- scene strategy
- Autoloads
- Resources
- tests
- runtime commands
- critical gameplay/network boundaries
- high-risk changes
- required verification gates

## C. `SYSTEM_MAP.md`

Owner-readable 5–10 minute map:

- boot/session/gameplay flow
- scene-tree overview
- major gameplay systems
- UI boundaries
- multiplayer authority if applicable
- state sources of truth
- signals/RPCs
- build/test/runtime flow
- 5–15 key files/scenes

## D. `DECISIONS.md`

Give each entry a stable ID (`D-012`) so a one-line code comment can point to it.

Also create `HISTORY.md` for non-obvious fixes, regressions and workarounds (anchored entries with Rule, Why, Where; reuse an existing equivalent such as `RATIONALE.md`). It is not a changelog: only knowledge the code alone does not show. Format and the comment policy to copy into `AGENTS.md`: `references/comments-and-history.md`.

Durable decisions only.

## E. `TESTING.md`

Document only real project commands and runtime/manual verification paths.

## F. `WORKFLOW.md`

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
At most 5 items.

Do not begin refactors or features as part of the bootstrap.
