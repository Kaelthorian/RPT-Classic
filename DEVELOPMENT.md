# Development and verification

## Supported environment

The project is a Windows BYOND/Dream Maker codebase. Required tools:

- Git.
- PowerShell 5.1 or newer.
- BYOND with `dm.exe` or `DreamMaker.exe`.
- Ripgrep (`rg`) for efficient code search.

The complete Codex package includes safe verification scripts. Set
`BYOND_DM_PATH` to the full compiler path when automatic discovery fails.

## Before editing

```powershell
git status --short
rg -n --glob '*.dm' 'RelevantType|RelevantProc|RelevantVar' Code
rg -n '#include .*RelevantFile' 'Roleplay Tenkaichi.dme'
```

Read the full local type/proc context and applicable nested `AGENTS.md` files. Check
for later definitions and callers before making a plan.

## Adding a source file

1. Put the file in the owning subsystem, not a generic dumping directory.
2. Use tabs and match surrounding naming/style.
3. Add one `#include` to `Roleplay Tenkaichi.dme`.
4. Place the include after required foundations and before code that depends on it.
5. Do not reorder the existing include block for aesthetics.
6. Run structural verification and compilation.

## Official commands

Structural repository validation:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check.ps1"
```

Strict audit of unreferenced `.dm` files and secret patterns:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check.ps1" -Strict -StrictSecrets
```

Safe staged compilation:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\compile.ps1"
```

Complete verification:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"
```

Specify a compiler explicitly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1" `
  -CompilerPath "C:\Program Files\BYOND\bin\dm.exe"
```

The compile script creates a temporary staging copy, excludes real `Data`, local
tools, logs, and generated output, then invokes Dream Maker with full paths.

## Manual fallback

When the scripts are unavailable, run a direct compiler check only in a disposable
copy or after confirming generated outputs cannot overwrite meaningful files:

```powershell
& "C:\Program Files\BYOND\bin\dm.exe" -full_paths ".\Roleplay Tenkaichi.dme"
```

A missing compiler is not a successful verification. Report
`Compilation could not be executed`.

## Required review after editing

```powershell
git diff --check
git status --short
git diff --stat
git diff -- 'path/to/changed/file.dm' 'Roleplay Tenkaichi.dme'
```

Read the complete final diff. Confirm no generated output, `Data`, map, icon, audio,
font, DMF, secret, or unrelated file was modified.

## Manual behavioral testing

Compilation proves syntax and resource resolution, not gameplay correctness. Select
checks from `docs/codex/VERIFICATION_MATRIX.md`. At minimum:

- Reproduce the old behavior before the patch when practical.
- Exercise success, rejection, cancellation, disconnect/deletion, and repeated-use paths.
- Check state flags after every early return and delayed callback.
- Verify messages, logs, UI state, persistence, and side effects.
- Use synthetic players/savefiles and a test server configuration.
- Never send real Discord requests or operate on production data.

## Final report format

Use the template in `docs/codex/CHANGE_REPORT_TEMPLATE.md`. Distinguish clearly among:

- What source inspection established.
- What compilation established.
- What runtime testing established.
- What remains untested or uncertain.
