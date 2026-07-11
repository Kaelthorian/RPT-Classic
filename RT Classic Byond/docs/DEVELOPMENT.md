# Development and verification

## Toolchain

`Roleplay Tenkaichi.dme` is compiled by Dream Maker. `scripts/compile.ps1`
selects `dm.exe` from the repository-local external tool, `BYOND_DM_PATH`,
`PATH`, registry entries, or standard install directories. It stages a mirror
under the system temporary directory and excludes `.git`, `.codex`,
`.local-tools`, `Data`, and generated/runtime extensions.

## Commands

```powershell
# Required source/project verification
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"

# Documentation/diff hygiene
git diff --check
git status --short
```

`scripts/check.ps1` verifies required paths, include existence/casing and
duplicates, conflict markers, and protected-path changes. Its default mode
warns about unreferenced sources; `-Strict` turns each orphan into an error and
is intended for audits, not routine validation.

## Interpreting results

A passing structural check is not a successful compile. Record one of the exact
states required by `AGENTS.md`. At the 2026-07-11 baseline, structural checking
passed (674 includes, 732 `.dm` files, 77 unreferenced); the selected compiler
was `.local-tools/BYOND/bin/dm.exe`, but it produced no diagnostic and did not
return within the external ten-minute limit (exit 124 from the runner).

## Runtime and protected data

Do not inspect player saves or treat `.local-tools/BYOND/` as project code.
`Data/`, maps, `RT.dmf`, resources, databases, logs, and generated `.dmb`/`.rsc`
outputs are protected unless a task explicitly authorizes them. Source evidence
for data paths may be read; the underlying runtime files must not be opened.
