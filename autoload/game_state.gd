extends Node

## Small cross-scene session state. Gameplay systems must own their own state.

enum RunMode {
	DEVELOPMENT,
	CLIENT,
	SERVER,
}

enum SessionStatus {
	BOOTING,
	READY,
	RUNNING,
	STOPPED,
	ERROR,
}

var run_mode: RunMode = RunMode.DEVELOPMENT
var current_player: Node = null
var current_map_id: StringName = &""
var session_status: SessionStatus = SessionStatus.BOOTING


func reset_session() -> void:
	current_player = null
	current_map_id = &""
	session_status = SessionStatus.READY


func mark_error() -> void:
	session_status = SessionStatus.ERROR
