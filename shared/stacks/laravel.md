## Stack checks — Laravel

- **Plan:** route → middleware → Form Request → controller → Action/Service → model → job/event/broadcast. Note the guard of each surface; a permission on one surface does not hold on another.
- **Implement:** controllers stay thin; one canonical Action/Service per business operation; transactions only around truly atomic work; eager-load deliberately; migrations are production operations (locks, defaults, backfills, rollback).
- **Review:** N+1 and unbounded queries; mass assignment; authorization in the wrong layer; queued jobs that are not idempotent under retry; broadcasts leaking data to a channel; Inertia shared props exposing internal fields; duplicate requests for data already sent as props.
- **Security:** IDOR through route-model binding; SSO/OAuth account linking, state/nonce, redirect allowlists; webhook signatures; CSRF; file uploads; secrets in logs.
- **Runtime proof:** feature test through the HTTP layer; the page actually rendered; the job actually ran on a worker and its side effect exists; the realtime event reached a subscribed client.
- **Release:** migration order and mixed-version compatibility; `queue:restart`/Horizon; scheduler; config/route/view caches; Reverb; frontend assets built; new env vars present.
