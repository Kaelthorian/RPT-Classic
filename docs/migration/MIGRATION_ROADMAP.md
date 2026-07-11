# Migration roadmap

Each stage requires an updated system map/status/risk entry and a repeatable
comparison against the BYOND reference before the next dependent stage begins.

1. **Repository audit — in progress.** Confirm active DME sources, runtime flows,
   data boundaries, protected data and asset provenance.
2. **Godot foundation — in progress.** Maintain a runnable Boot/Main path,
   narrow services, validation and project conventions.
3. **Data contracts and test harness.** Specify Resource/DTO schemas and build
   synthetic parity fixtures before converting content.
4. **Minimal map slice — test harness created.** The synthetic 50×50 grass map
   establishes coordinates, camera and outer collision. DMI conversion and a
   representative approved BYOND map slice remain pending.
5. **Minimal player entity — test harness created.** A composed visual/collision
   player exists for navigation testing; identity and gameplay state remain
   pending and must not mirror the full mob variable surface.
6. **Movement and input — prototype in progress.** Basic cardinal/diagonal intent
   works with WASD/arrows. BYOND gates, facing parity and timing still require
   recorded comparison scenarios.
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
