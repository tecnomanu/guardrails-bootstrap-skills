<!-- guardrails-workflow:start v2.1 react -->
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

## Stack checks — React (client-rendered)

- **Plan:** route → page → hook (query/mutation) → API module → backend → cache/state → UI. Note which cached data each mutation must invalidate.
- **Implement:** everything in the bundle is public; server data has one client home; one API module per resource, no ad-hoc `fetch` in components; derive state instead of syncing it with effects; effects idempotent and cancel stale work; loading, error and empty states handled.
- **Review:** secrets in `VITE_`/`REACT_APP_` vars; authorization only in guards or hidden buttons; duplicated server state; missing invalidation; request races; unstable list keys; inconsistent API error handling.
- **Security:** XSS via `dangerouslySetInnerHTML`, markdown or `javascript:` URLs; token storage and refresh races; CSRF/CORS with cookie auth; OAuth callback handling; open redirects via `next`/`returnTo`; PII in analytics or error trackers.
- **Runtime proof:** production build served locally; route loaded in a browser; interaction worked; request matched the API contract; login, refresh and logout worked.
- **Release:** env vars need a rebuild; runtime config per environment; SPA fallback and `index.html` cache headers; old chunks for open tabs; source maps; IdP redirect URIs.

<!-- guardrails-workflow:end -->

## Specifics of this project

<!-- Only what differs from the fixed block above, per step. Link to TESTING.md, SYSTEM_MAP.md and CONVENTIONS instead of repeating them. Keep it short. -->
