## Stack checks — Next.js

- **Plan:** route → Server/Client boundary → Server Action / Route Handler → data layer → revalidation. Note the runtime (Node or Edge) and the cache behavior of every route touched.
- **Implement:** `"use client"` only for real interactivity; pass the minimum serializable props to Client Components; one canonical data/mutation path shared by Server Actions and API routes; cache and revalidation changes are behavior changes.
- **Review:** secrets or private fields reaching the client; auth checked only in middleware or UI; Server Actions without authorization; wrong or missing revalidation; stale state; Edge-incompatible APIs; bundle growth; SEO metadata regressions.
- **Security:** Server Actions and Route Handlers as public endpoints; IDOR; SSRF from fetch URLs; open redirects; cache leaks between users or tenants.
- **Runtime proof:** `next build` plus the production server; the route loaded; the mutation worked and the UI revalidated; auth path worked.
- **Release:** env vars (build vs runtime); Node/Edge runtime; ISR/cache implications; redirects; image/CDN config.
