extends CharacterBody2D

const MOVE_SPEED := 220.0

var _facing := Vector2.DOWN


func _physics_process(_delta: float) -> void:
	var input_direction := _read_direction()
	velocity = input_direction * MOVE_SPEED
	if not input_direction.is_zero_approx() and not input_direction.is_equal_approx(_facing):
		_facing = input_direction
		queue_redraw()
	move_and_slide()


func _read_direction() -> Vector2:
	var horizontal := int(Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT))
	horizontal -= int(Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT))
	var vertical := int(Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_DOWN))
	vertical -= int(Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_UP))
	return Vector2(horizontal, vertical).normalized()


func _draw() -> void:
	draw_circle(Vector2(0.0, 4.0), 13.0, Color("17304f"))
	draw_circle(Vector2(0.0, -7.0), 9.0, Color("f2c49b"))
	draw_circle(Vector2(-3.0, -9.0), 1.5, Color("18202c"))
	draw_circle(Vector2(3.0, -9.0), 1.5, Color("18202c"))
	draw_line(Vector2.ZERO, _facing * 18.0, Color("f7e36d"), 3.0, true)
