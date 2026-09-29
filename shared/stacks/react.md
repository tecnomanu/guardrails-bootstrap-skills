## Stack checks — React (client-rendered)

- **Plan:** route → page → hook (query/mutation) → API module → backend → cache/state → UI. Note which cached data each mutation must invalidate.
- **Implement:** everything in the bundle is public; server data has one client home; one API module per resource, no ad-hoc `fetch` in components; derive state instead of syncing it with effects; effects idempotent and cancel stale work; loading, error and empty states handled.
- **Review:** secrets in `VITE_`/`REACT_APP_` vars; authorization only in guards or hidden buttons; duplicated server state; missing invalidation; request races; unstable list keys; inconsistent API error handling.
- **Security:** XSS via `dangerouslySetInnerHTML`, markdown or `javascript:` URLs; token storage and refresh races; CSRF/CORS with cookie auth; OAuth callback handling; open redirects via `next`/`returnTo`; PII in analytics or error trackers.
- **Runtime proof:** production build served locally; route loaded in a browser; interaction worked; request matched the API contract; login, refresh and logout worked.
- **Release:** env vars need a rebuild; runtime config per environment; SPA fallback and `index.html` cache headers; old chunks for open tabs; source maps; IdP redirect URIs.
