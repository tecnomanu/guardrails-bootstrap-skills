<!-- guardrails-workflow:start v2.1 godot -->
<!-- Fixed block. Do not edit; replace it whole to upgrade. Project notes go below the end marker. -->

# Change workflow

For non-trivial changes. A typo or a one-line fix skips to step 5.

PLAN → IMPLEMENT → INDEPENDENT REVIEW → SECURITY/RISK REVIEW (when relevant)
→ TEST + RUNTIME PROOF → ARCHITECTURE CHECK (when structural) → OWNER BRIEF
→ RELEASE CHECK (when deploy-sensitive)

## 1. Plan

Do not edit yet.

- Trace the current behavior through the real execution path.
- Name the exact files and modules you will touch.
- Find the canonical existing operation, constant, pattern or component and reuse it.
- List writes and side effects (persistence, jobs, mail, events, external calls).
- Name the auth, authorization and tenant/account boundaries involved.
- State risks and how you will verify.
- Classify architecture impact: NONE / LOCAL / STRUCTURAL.

## 2. Implement

- Follow the plan; if reality contradicts it, update the plan first.
- Match repository conventions and neighboring code.
- Keep the diff scoped: no unrelated refactors or cleanup.
- Add or update tests; a bug fix gets a regression test when feasible.
- No casual dependencies; justify any new one.
- Preserve logs, metrics and error reporting; never log secrets or personal data.
- Comments: 1–2 lines of *why*. Longer reasons go to the project's long-why
  file (`HISTORY.md` or its equivalent, e.g. `RATIONALE.md`) or `DECISIONS.md`,
  and the comment points to the anchor.
- Review your own final diff before calling it done.

## 3. Independent review

Fresh context when possible. Self-review does not count.

- Requirement vs implementation.
- Duplicated business logic or a second source of truth.
- Wrong auth/authorization assumptions, tenant or account leaks.
- Tests that mirror implementation instead of proving behavior.
- Unnecessary abstractions.
- Narrative comments, personal data, local paths or AI-tool metadata in the diff.
- The stack checks below.

Classify each finding BLOCKER / SHOULD FIX / OPTIONAL, with concrete evidence.
Do not return generic checklist noise.

## 4. Security / risk review

Only the attack surfaces the change touches: auth vs authorization, isolation,
input validation, injection (SQL, HTML, command, prompt), SSRF, redirects,
uploads, webhooks, secrets, rate limits, payments, dependency risk, plus the
stack checks below.

## 5. Test + runtime proof

Use the real commands from `TESTING.md`. Report each level separately:

1. builds / parses / typechecks
2. static checks and lint
3. unit and feature tests (which, how many passed)
4. the real path exercised (browser, process, worker, device) with evidence
5. integrations touched (queue, realtime, external API, payments)

Anything not verified is written as `UNVERIFIED`. A green build is not proof
that the feature works.

## 6. Architecture check

Compare against `AGENTS.md`, `GUARDRAILS_PROFILE.md`, `SYSTEM_MAP.md` and the
neighboring code. Look for a second implementation of one operation, a wrong
layer, new global state, hidden side effects, boundary drift and docs that
became false. Do not refactor for aesthetic purity.

## 7. Owner brief

For a technical owner who will not read the whole diff:

- **What changed**
- **Flow:** entry → operation → persistence/side effect → response
- **Files worth knowing:** at most 7
- **Risk:** LOW / MEDIUM / HIGH
- **Proof:** exact checks and runtime verification done
- **Architecture:** NONE / LOCAL / STRUCTURAL
- **If it breaks:** where to look first, how to roll back
- **Human attention:** at most 3 things worth checking personally

## 8. Release check

Only for deploy-sensitive work. Review what applies: schema/data migrations,
environment variables, build output, workers and schedulers, caches, auth/IdP
config, webhooks, external services, feature flags, observability, rollback
sequence. Return GO / GO WITH CAUTION / NO-GO. Never GO on unit tests alone.

When something breaks in production: find the failing boundary, collect
evidence first, rank hypotheses, apply the safest mitigation, and fix
permanently only after the cause is proven.

## Stack checks — Godot

- **Plan:** scene tree and owner of the behavior; signals and calls involved; which peer is authoritative when multiplayer exists.
- **Implement:** gameplay truth stays out of presentation; signals for decoupled notifications, not as a universal bus; Resources for data without Node lifecycle; Autoloads minimal; no allocations or loading in `_process`/`_physics_process` hot paths.
- **Review (gameplay):** frame-dependent logic; fragile `get_node()` paths; hidden lifecycle assumptions; duplicated state; divergence between offline and multiplayer logic.
- **Review (network, only if multiplayer):** authority server-side where the design requires it; RPCs that accept any peer; client-provided outcomes trusted; desync and reconnect paths.
- **Runtime proof:** opening the editor or parsing is not proof; run the scene or game and exercise the changed path; note what is manual only (feel, audio, visuals).
- **Release:** export presets per target; save-game compatibility; network protocol compatibility between versions.

<!-- guardrails-workflow:end -->

## Specifics of this project

<!-- Only what differs from the fixed block above, per step. Link to TESTING.md, SYSTEM_MAP.md and CONVENTIONS instead of repeating them. Keep it short. -->
