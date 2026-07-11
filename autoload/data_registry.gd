extends Node

const FOUNDATION_DATA_PATH := "res://data/definitions/foundation.json"

var _data: Dictionary = {}
var _is_loaded := false


func load_base_data() -> Error:
	if _is_loaded:
		return OK
	if not FileAccess.file_exists(FOUNDATION_DATA_PATH):
		push_error("Foundation data is missing: %s" % FOUNDATION_DATA_PATH)
		return ERR_FILE_NOT_FOUND

	var file := FileAccess.open(FOUNDATION_DATA_PATH, FileAccess.READ)
	if file == null:
		push_error("Foundation data could not be opened: %s" % FOUNDATION_DATA_PATH)
		return FileAccess.get_open_error()

	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if not parsed is Dictionary:
		push_error("Foundation data must contain a JSON object.")
		return ERR_PARSE_ERROR

	var parsed_data: Dictionary = parsed
	if parsed_data.get("schema_version", 0) != 1:
		push_error("Unsupported foundation data schema version.")
		return ERR_INVALID_DATA
	if not parsed_data.get("definitions", {}) is Dictionary:
		push_error("Foundation definitions must be a JSON object.")
		return ERR_INVALID_DATA

	_data = parsed_data.duplicate(true)
	_is_loaded = true
	return OK


func is_loaded() -> bool:
	return _is_loaded


func get_definition(category: StringName, definition_id: StringName) -> Dictionary:
	var definitions: Dictionary = _data.get("definitions", {})
	var category_data: Dictionary = definitions.get(String(category), {})
	var result: Variant = category_data.get(String(definition_id), {})
	return result.duplicate(true) if result is Dictionary else {}


func clear() -> void:
	_data.clear()
	_is_loaded = false
