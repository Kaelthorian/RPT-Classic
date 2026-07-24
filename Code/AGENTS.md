# Instructions for `Code`

These rules extend the repository root instructions for all Dream Maker source.

- Treat the DME include list as the build graph. Confirm the edited file is included
  exactly once and inspect definitions before and after it when override order matters.
- Search complete type paths, proc/verb names, callers, child types, and `..()` usage.
- Preserve tabs and local style. No broad formatting, spelling cleanup, or path/case
  normalization during behavior work.
- Prefer explicit typed arguments for new reusable procs. Do not mechanically rewrite
  legacy `usr`, `src`, or dynamic-access patterns.
- Review every early return and delayed path for stuck state flags or deleted atoms.
- Do not change balance constants, probabilities, cooldowns, gains, caps, or timing
  unless explicitly requested.
- Avoid new global variables and unrestricted world scans. Use the narrowest owner and
  existing maintained lists when possible.
- Compile every source change and perform focused runtime checks from the verification
  matrix.
