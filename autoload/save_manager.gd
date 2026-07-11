extends Node

## Godot-only foundation format. This is not compatible with BYOND savefiles.

const SAVE_DIRECTORY := "user://saves"
const SAVE_PATH := SAVE_DIRECTORY + "/foundation.json"
const FORMAT_VERSION := 1


func save_game(snapshot: Dictionary = {}) -> Error:
	var absolute_directory := ProjectSettings.globalize_path(SAVE_DIRECTORY)
	var directory_error := DirAccess.make_dir_recursive_absolute(absolute_directory)
	if directory_error != OK:
		push_error("Could not create the save directory (error %d)." % directory_error)
		return directory_error

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		var open_error := FileAccess.get_open_error()
		push_error("Could not open the save file (error %d)." % open_error)
		return open_error

	var payload := {
		"format_version": FORMAT_VERSION,
		"snapshot": snapshot,
	}
	file.store_string(JSON.stringify(payload, "\t"))
	return OK


func load_game() -> Dictionary:
	if not has_save():
		return {}
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		push_error("Could not open the save file for reading.")
		return {}
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if not parsed is Dictionary:
		push_error("The save file is not a JSON object.")
		return {}
	var payload: Dictionary = parsed
	if payload.get("format_version", 0) != FORMAT_VERSION:
		push_error("Unsupported save format version.")
		return {}
	var snapshot: Variant = payload.get("snapshot", {})
	return snapshot.duplicate(true) if snapshot is Dictionary else {}


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


func delete_save() -> Error:
	if not has_save():
		return OK
	var directory := DirAccess.open(SAVE_DIRECTORY)
	if directory == null:
		return DirAccess.get_open_error()
	return directory.remove(SAVE_PATH.get_file())
