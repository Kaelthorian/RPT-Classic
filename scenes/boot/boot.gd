extends Node

const MAIN_SCENE := "res://scenes/main/main.tscn"


func _ready() -> void:
	call_deferred("_initialize_application")


func _initialize_application() -> void:
	var service_error := _validate_services()
	if service_error != OK:
		_fail("Required global services are unavailable.")
		return

	var data_error := DataRegistry.load_base_data()
	if data_error != OK:
		_fail("Base data failed to load (error %d)." % data_error)
		return

	GameState.reset_session()
	EventBus.application_ready.emit()
	var scene_error: Error = await SceneRouter.change_scene(MAIN_SCENE)
	if scene_error != OK:
		_fail("Main scene failed to open (error %d)." % scene_error)


func _validate_services() -> Error:
	var required_services := [GameState, EventBus, DataRegistry, SaveManager, SceneRouter]
	for service: Node in required_services:
		if service == null or not service.is_inside_tree():
			return ERR_UNCONFIGURED
	return OK


func _fail(message: String) -> void:
	GameState.mark_error()
	EventBus.application_error.emit(message)
	push_error(message)
	var error_label := Label.new()
	error_label.text = "RPT Classic could not start.\n%s" % message
	error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	error_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	error_label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(error_label)
