## Stack checks — Node / TypeScript

- **Plan:** entry point (HTTP, CLI, worker, MCP tool, IPC) → module → state/persistence → side effects. Note which process runs the code and whether it must be restarted.
- **Implement:** follow the repo's native extension mechanism (adapters, providers, registries) instead of adding a parallel one; keep dependency direction; explicit failure modes, timeouts and retries.
- **Review:** circular or wrong-direction imports; god modules; runtime state leaking across requests or sessions; duplicated tool execution; stale async state; unsafe filesystem, command or network handling.
- **Security:** command injection; path traversal; SSRF; IPC/WebSocket/MCP boundaries; prompt or tool injection where model output drives side effects; resource exhaustion.
- **Runtime proof:** the running process actually loaded the new code; the changed path actually executed (request, command, tool call) with output as evidence.
- **Release:** process restarts and daemons; published package contents; config and env; data/schema migrations; backward compatibility for clients and plugins.
