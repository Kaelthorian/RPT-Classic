# Instructions for `Code/Modules/Admin`

- Treat every verb/proc as privileged until proven otherwise. Identify the exact rank,
  permission, target, and caller checks before editing.
- Never widen access, bypass confirmation, weaken audit logs, or expose a server-control
  proc to a normal player path during maintenance work.
- Validate both authorization directions: the lowest permitted rank succeeds and the
  highest non-permitted rank fails.
- Guard null/deleted/disconnected targets and indirect calls where `usr` may be wrong.
- Player/save deletion, bans, wipes, reboot/shutdown, live patching, and mass actions are
  destructive. Do not execute them in tests; use stubs or synthetic isolated data.
- Preserve or improve safe logging without including secrets or private save contents.
