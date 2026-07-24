# Instructions for `Code/Modules/SaveSystem`

- `Data/Saves` is prohibited test input. Use temporary synthetic savefiles only.
- Treat serialized mob/item type paths and variable names as a public schema.
- Read character, item, turf, map, world, backup, disconnect, and reboot save paths
  before changing shared persistence behavior.
- Any schema change requires a `SAVEFILE_VERSION` decision and explicit, idempotent,
  version-gated migration logic.
- Test current version, at least one older synthetic version, missing/null fields,
  repeated load/save, backup, interruption, and invalid coordinates.
- Do not write a save before validating the target path and actor. Avoid partial updates
  that leave the main and backup states inconsistent.
- Never log or report serialized player content.
