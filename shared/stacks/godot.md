## Stack checks — Godot

- **Plan:** scene tree and owner of the behavior; signals and calls involved; which peer is authoritative when multiplayer exists.
- **Implement:** gameplay truth stays out of presentation; signals for decoupled notifications, not as a universal bus; Resources for data without Node lifecycle; Autoloads minimal; no allocations or loading in `_process`/`_physics_process` hot paths.
- **Review (gameplay):** frame-dependent logic; fragile `get_node()` paths; hidden lifecycle assumptions; duplicated state; divergence between offline and multiplayer logic.
- **Review (network, only if multiplayer):** authority server-side where the design requires it; RPCs that accept any peer; client-provided outcomes trusted; desync and reconnect paths.
- **Runtime proof:** opening the editor or parsing is not proof; run the scene or game and exercise the changed path; note what is manual only (feel, audio, visuals).
- **Release:** export presets per target; save-game compatibility; network protocol compatibility between versions.
