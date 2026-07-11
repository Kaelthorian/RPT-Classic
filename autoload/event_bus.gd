extends Node

## Cross-cutting application events only. Prefer a direct reference or a local
## signal when the sender and receiver belong to the same scene or system.

signal application_ready
signal application_error(message: String)
signal scene_change_started(scene_path: String)
signal scene_change_finished(scene_path: String)
