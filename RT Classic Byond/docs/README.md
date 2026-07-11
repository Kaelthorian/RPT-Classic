# Documentation index

This is the central navigation page. Documents describe confirmed behavior at
the audited commit; the DME and implementation remain authoritative.

| Need to work on | Read first | Coverage |
| --- | --- | --- |
| Find a system or symbol | [Repository map](REPOSITORY-MAP.md) | Directories, files, symbols, search terms |
| Architecture or startup | [Architecture](ARCHITECTURE.md) | Runtime layers and initialization |
| Includes, inheritance, overrides | [Include and type system](INCLUDE-AND-TYPE-SYSTEM.md) | DME order and distributed DM definitions |
| Build or validation | [Development](DEVELOPMENT.md) | Checks, compiler selection, protected paths |
| Movement or input | [Movement and input](systems/MOVEMENT-AND-INPUT.md) | Macros, held-key state, `Move()` |
| Combat, skills, stats, items | [Gameplay systems](systems/GAMEPLAY-SYSTEMS.md) | Combat pipeline and content type families |
| Saving, world, maps | [Persistence and world](systems/PERSISTENCE-AND-WORLD.md) | Startup, savefiles, periodic work |
| Interface, admin, chat | [UI, admin and communication](systems/UI-ADMIN-COMMUNICATION.md) | DMF/browser UI, permissions, outputs |
| Known defects and risks | [Code review](CODE-REVIEW.md) | Evidence-ranked findings |

## Document purposes

- [ARCHITECTURE.md](ARCHITECTURE.md): read before changing cross-system flows or
  initialization.
- [REPOSITORY-MAP.md](REPOSITORY-MAP.md): use to avoid broad repository scans.
- [INCLUDE-AND-TYPE-SYSTEM.md](INCLUDE-AND-TYPE-SYSTEM.md): read before adding a
  source file or changing a base type/override.
- [DEVELOPMENT.md](DEVELOPMENT.md): use for local setup, verification, and audit
  boundaries.
- [CODE-REVIEW.md](CODE-REVIEW.md): review risks before touching affected code.

No nested `AGENTS.md` files were created: the audit found no directory-specific
rules that differ from the root rules.
