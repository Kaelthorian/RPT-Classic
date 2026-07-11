extends Control

@onready var data_status_label: Label = %DataStatusLabel
@onready var save_status_label: Label = %SaveStatusLabel
@onready var scene_status_label: Label = %SceneStatusLabel


func _ready() -> void:
	data_status_label.text = "Base data: %s" % ("loaded" if DataRegistry.is_loaded() else "not loaded")
	save_status_label.text = "Foundation save: %s" % ("present" if SaveManager.has_save() else "none")
	scene_status_label.text = "Scene: %s" % get_tree().current_scene.scene_file_path
	print("RPT Classic Godot foundation reached Main; base_data_loaded=%s" % DataRegistry.is_loaded())
