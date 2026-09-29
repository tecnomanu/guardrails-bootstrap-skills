## Stack checks — Astro + React islands

- **Plan:** request → middleware (locals) → `.astro` frontmatter → island props → `client:*` → endpoint/BFF → upstream. Note which routes are prerendered and which run per request.
- **Implement:** island props are public HTML, pass only sanitized fields; never import server-only modules from islands; only `PUBLIC_` env in client code; lightest hydration directive that works; browser APIs, time and randomness only in effects; each island is its own React root.
- **Review:** secrets in props or bundles; hydration mismatches; `client:only` hiding a fixable mismatch; per-request data in module-level state; BFF forwarding arbitrary paths or headers; build-time vs runtime env mixups; legacy URL, storage-key or API-contract breaks.
- **Security:** open proxy / SSRF in endpoints; `security.checkOrigin` and cookie flags; `set:html` with untrusted content; open redirects; tenant resolution by Host; mock switches reachable in production.
- **Runtime proof:** production build + production start; SSR HTML correct; island hydrated and interactive; endpoint request matched the contract.
- **Release:** runtime vs rebuild env vars; adapter/output/prerender changes; cache TTLs across instances; legacy redirects; mock switches off.
