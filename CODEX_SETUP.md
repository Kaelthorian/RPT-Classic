# Installing the Codex guidance package

Copy the package contents into the repository root while preserving every relative
path. Existing source files do not need to be moved.

## Recommended package

Use `RPT-Classic-Codex-Complete.zip`. It contains:

- Root and nested `AGENTS.md` files.
- Architecture, development, security, risk, and task documentation.
- `.ignore` to keep default Codex/ripgrep searches away from large binary/runtime data.
- `.editorconfig` for conservative DM tab handling.
- `.gitignore` additions for local compiler output and sensitive runtime artifacts.
- `scripts/check.ps1`, `scripts/compile.ps1`, and `scripts/verify.ps1`.

The markdown-only package is useful when only documentation may be added, but it is
not equivalent: markdown cannot prevent accidental broad searches or compile code.

## Expected file placement

```text
RPT-Classic/
  AGENTS.md
  README.md
  ARCHITECTURE.md
  DEVELOPMENT.md
  SECURITY.md
  KNOWN_RISKS.md
  CODEX_TASK_PROTOCOL.md
  Code/
    AGENTS.md
    Items/AGENTS.md
    Map/AGENTS.md
    Mob/AGENTS.md
    Modules/AGENTS.md
    Modules/Admin/AGENTS.md
    Modules/Discord/AGENTS.md
    Modules/SaveSystem/AGENTS.md
    Modules/World/AGENTS.md
    Skills/AGENTS.md
  Data/AGENTS.md
  Icons/AGENTS.md
  assets/AGENTS.md
  docs/codex/*.md
  scripts/*.ps1
```

## First validation after installation

```powershell
git status --short
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\check.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"
```

The scripts are designed for Windows PowerShell. They were generated from static
repository analysis; verify them in the actual Windows checkout before treating them
as CI-grade infrastructure.

## Suggested first Codex task

Ask Codex to perform a read-only repository audit:

```text
Read AGENTS.md and all relevant nested instructions. Do not modify files. Run the
structural check, identify the compiler selected by scripts/compile.ps1, and report
only: repository status, structural errors/warnings, compilation result, exposed
secret locations without printing values, and the five highest-risk code areas.
```
