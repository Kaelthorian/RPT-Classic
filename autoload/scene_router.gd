extends Node

var _is_changing_scene := false


func change_scene(scene_path: String) -> Error:
	if _is_changing_scene:
		push_warning("A scene change is already in progress.")
		return ERR_BUSY
	if scene_path.is_empty() or not ResourceLoader.exists(scene_path, "PackedScene"):
		push_error("Scene does not exist: %s" % scene_path)
		return ERR_FILE_NOT_FOUND

	_is_changing_scene = true
	EventBus.scene_change_started.emit(scene_path)
	var change_error := get_tree().change_scene_to_file(scene_path)
	if change_error != OK:
		_is_changing_scene = false
		push_error("Could not change to scene %s (error %d)." % [scene_path, change_error])
		return change_error

	await get_tree().process_frame
	_is_changing_scene = false
	EventBus.scene_change_finished.emit(scene_path)
	return OK


func is_changing_scene() -> bool:
	return _is_changing_scene
