extends Actor
class_name Player

func _physics_process(delta: float) -> void:
	var direction: Vector2 = get_direction()
	var jump_done: bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, jump_done)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
		
		
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, jump_done: bool) -> Vector2:
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if jump_done:
		out.y = 0.0
	return out
	