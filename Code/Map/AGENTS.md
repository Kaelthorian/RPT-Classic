# Instructions for `Code/Map`

- Included `.dmm` files are protected world content. Do not hand-edit, reformat, or
  regenerate them unless the task explicitly targets a map and the resulting diff is
  reviewed with a map-aware tool.
- Separate map/build-system code changes from map-content changes.
- Preserve turf/object type paths, density, layer, coordinates, z-level assumptions,
  resource paths, and save/load compatibility.
- Validate placement bounds, collision, deletion, upgrades, world-save/map-save behavior,
  and a disposable test map.
- A large unexplained `.dmm` diff is a failure condition.
