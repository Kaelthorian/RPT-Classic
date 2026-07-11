# Migration roadmap

Each stage requires an updated system map/status/risk entry and a repeatable
comparison against the BYOND reference before the next dependent stage begins.

1. **Repository audit — in progress.** Confirm active DME sources, runtime flows,
   data boundaries, protected data and asset provenance.
2. **Godot foundation — in progress.** Maintain a runnable Boot/Main path,
   narrow services, validation and project conventions.
3. **Data contracts and test harness.** Specify Resource/DTO schemas and build
   synthetic parity fixtures before converting content.
4. **Minimal map slice.** Select one synthetic or approved small map area and
   establish coordinates, collision, layers and DMI conversion rules.
5. **Minimal player entity.** Compose identity, transform and only the state
   needed by the slice; do not port the full mob variable surface.
6. **Movement and input.** Reproduce cardinal/diagonal intent, gates, facing and
   timing on the minimal map with recorded parity scenarios.
7. **Interaction.** Define targeting and world-object interactions without
   importing combat complexity.
8. **Inventory/item slice.** One representative item and equip/load cycle using
   typed definitions and synthetic persistence.
9. **Combat vertical slice.** One basic attack through hit/damage/KO with
   deterministic calculation tests; then expand formulas deliberately.
10. **Character creation/progression.** Migrate an approved minimal race/stat
    path after player, data, UI and save boundaries are stable.
11. **NPC/navigation slice.** First establish which included BYOND NPC behavior
    is production-relevant; do not treat the unreferenced NPC file as active.
12. **Godot persistence.** Transactional, versioned saves and migration tests.
    Design BYOND save conversion as its own reversible tool and approval gate.
13. **UI/communication.** Replace named DMF control coupling with Godot views and
    a tested chat/channel domain.
14. **Networking/authority prototype.** Specify server authority, replication,
    reconnect, persistence ownership and threat model before selecting transport.
15. **Administration and operations.** Permission matrices, audit logs, bans,
    server lifecycle and external notifications with secrets outside source.
16. **Content and asset migration.** Batch conversion only after each owning
    system has schemas, import validation and provenance decisions.
17. **Equivalence, load and security testing.** Recorded behavior, concurrency,
    failure recovery, save upgrades and operational rehearsal.
18. **Gradual BYOND retirement.** Parallel operation, rollback plan, data cutover
    and explicit operator acceptance before archival.

Movement is the recommended next gameplay slice because it can validate map,
input, timing and player composition without first importing combat or saves.
It must follow a tiny map and player scaffold, not a full content conversion.
