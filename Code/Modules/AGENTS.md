# Instructions for `Code/Modules`

- Select the owning module before editing; avoid placing cross-cutting logic in an
  unrelated system merely because it has a convenient global.
- Modules often share global lists, startup hooks, timers, UI controls, saves, and logs.
  Search initialization, shutdown, reboot, and recurring-loop references.
- Any new loop must have an explicit cadence, termination/liveness behavior, and bounded
  work. Do not duplicate an existing startup loop.
- Preserve test-server versus production behavior and feature toggles.
- Library changes require all-caller review; admin, save, world, health, and communication
  changes require subsystem-specific nested instructions.
- Never inspect real runtime data to understand a module.
