# Godot architecture

## Project location and structure

The existing Godot 4 project is at the repository root. This is intentional:
creating `godot/project.godot` would duplicate tracked project configuration.

```text
autoload/          application-wide coordination only
data/definitions/  validated, versioned source data
scenes/boot/       initialization and failure reporting
scenes/main/       temporary migration landing scene
systems/           future domain logic by feature
entities/          future composed actor/item/world-object scenes
world/             future maps, tiles and navigation
ui/                future menus, HUD, windows and components
resources/         future typed Godot Resources
assets/            future audited Godot-ready assets
tests/             future unit, integration and parity fixtures
docs/migration/    decisions, status, risks and roadmap
RT Classic Byond/  untouched behavioral reference
```

Feature directories are documented now and gain code only with an audited
vertical slice. Empty speculative scripts are deliberately avoided.

`RT Classic Byond/.gdignore` prevents Godot from importing the legacy DMI,
audio, font, map and runtime trees. It has no BYOND runtime role and is required
because the existing Godot project root is the parent of the legacy directory.

## Startup flow

`project.godot` starts `scenes/boot/boot.tscn`. Boot verifies the configured
Autoload nodes, asks `DataRegistry` to parse the foundation manifest, resets the
small session state, emits application readiness, and routes to the current test
slice at `world/maps/test_grass_map.tscn`. A failure remains visible in Boot and
is also reported through Godot's error channel.

The test slice builds a 50 by 50 `TileMapLayer` from one Godot-owned grass tile,
places a composed `CharacterBody2D` at its center, constrains it with static
world bounds, and follows it with a camera. WASD and arrow input provide basic
normalized eight-direction movement. This is a navigation harness, not parity
with BYOND movement gates, stat timing, water, flight, skills or interruption
behavior. `scenes/main/main.tscn` remains a temporary foundation status screen.

## Autoload responsibilities

- `GameState`: current run mode, player reference, map identifier and lifecycle
  status. Feature state belongs to feature owners.
- `EventBus`: only cross-cutting application and scene-transition events. Use a
  direct reference or local signal inside one scene/system.
- `SceneRouter`: validates scene resources and serializes scene changes.
- `DataRegistry`: validates and exposes immutable copies of definition records.
  The current manifest contains no gameplay definitions.
- `SaveManager`: minimal versioned Godot JSON interface. It neither reads nor
  converts BYOND savefiles.

## Dependency rules

Domain systems may depend on typed data definitions and narrow interfaces, but
not on UI scenes. UI observes/presents domain state and sends explicit commands.
Entities are composed from components; inheritance is reserved for stable
is-a relationships. World code owns spatial concerns. Persistence serializes
documented data transfer objects, never arbitrary node trees.

Prefer exported references, constructor/setup injection, scene-owned references
and local signals. EventBus is for genuinely unrelated lifetime owners. Avoid
autoload-to-autoload cycles, stringly typed distant `get_node()` calls, absolute
filesystem paths and gameplay decisions in Control scripts.

## Conventions

- Internal names, paths and identifiers are English; migration prose may be
  bilingual when useful.
- GDScript is statically typed where Godot's APIs permit it.
- `snake_case` files/functions/variables, `PascalCase` classes, and `SCREAMING_SNAKE_CASE` constants.
- Definition data carries an explicit schema version and is validated at load.
- A system is added only after its BYOND behavior and dependencies are recorded.
- Tests use synthetic fixtures. Real saves, logs and credentials are excluded.
