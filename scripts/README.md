# Verification scripts

- `check.ps1`: validates required paths, DME includes, duplicate/orphan source, conflict
  markers, protected working-tree changes, and secret patterns.
- `compile.ps1`: runs the structural check, discovers Dream Maker, creates a temporary
  staging copy without real `Data`, and compiles the DME.
- `verify.ps1`: runs structural validation followed by compilation.

Run from the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".\scripts\verify.ps1"
```

These scripts intentionally do not launch a production server or inspect runtime data.
Review them in the actual Windows environment before using them in automated CI.
