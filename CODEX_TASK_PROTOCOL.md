# Codex task protocol

Use this protocol for every non-trivial code task.

## 1. Normalize the request

Write observable acceptance criteria without expanding scope. Separate:

- Required behavior.
- Explicit non-goals.
- Compatibility requirements.
- Data/security constraints.
- Verification evidence required.

Do not silently convert a bug fix into a refactor or balance pass.

## 2. Establish repository state

```powershell
git status --short
```

Record pre-existing changes. Never overwrite or revert them. Do not use destructive
Git commands.

## 3. Locate ownership

Read root and nearest nested `AGENTS.md`. Use `docs/codex/SYSTEM_INDEX.md` to choose
the owning subsystem. Search the exact type/proc/variable and its DME include.

## 4. Build an evidence map

Before editing, identify:

- Entry points and callers.
- Parent/child types and overrides.
- State variables and flags.
- Delayed callbacks and deletion/disconnect paths.
- Save/version effects.
- UI control IDs and messages.
- Admin/log/network effects.
- Existing parallel implementation paths.

## 5. Patch narrowly

Prefer one coherent vertical change. Preserve legacy naming and formatting. Do not
introduce abstractions that are used only once unless they remove a concrete defect.
Do not alter constants or probabilities without explicit approval.

## 6. Verify progressively

1. Inspect the edited block.
2. Run structural checks.
3. Compile with Dream Maker.
4. Run focused runtime/manual scenarios.
5. Review the entire diff and repository status.

Stop and report honestly when a required tool is unavailable. Do not substitute
confidence or visual inspection for compilation.

## 7. Final response

Include:

- Summary of behavior changed.
- Files changed and why.
- Verification status using the exact status vocabulary from `AGENTS.md`.
- Commands/tests run.
- Unverified conditions or risks.
- No secret values, internal save contents, or irrelevant repository data.
