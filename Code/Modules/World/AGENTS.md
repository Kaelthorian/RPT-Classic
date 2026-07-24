# Instructions for `Code/Modules/World`

- `/world/New()` and `Initialize()` define startup order. Preserve the `WorldLoaded`
  guard and avoid starting duplicate loops or loading the same state twice.
- Review production/test-server branches, reboot/shutdown, logs, world status, and all
  spawned initialization work before changing startup.
- Do not change `tick_lag`, `fps`, year speed, caps, spawn coordinates, z-level constants,
  feature flags, or global balance values as incidental cleanup.
- Global lists and runtime files may be partly loaded when a delayed task runs. Handle
  missing synthetic configuration gracefully.
- Test a clean start, repeated initialization attempt, shutdown/reboot path, and missing
  optional synthetic data. Never start against production `Data` during automated tests.
