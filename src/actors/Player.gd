extends Actor
class_name Player

export var stomp_impulse: float = 1000.0

func _ready() -> void:
	pass # todo

func _on_EnemyArea_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)
	
func _on_EnemyArea_body_entered(body):
	# enemy killed me, comment below for immortality
	queue_free()

func _physics_process(delta: float) -> void:
	var direction: Vector2 = calculate_direction()
	var jump_done: bool = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, jump_done)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
		
		
func calculate_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
func calculate_move_velocity(linear_velocity: Vector2, direction: Vector2, speed: Vector2, jump_done: bool) -> Vector2:
	var rtn = linear_velocity
	rtn.x = speed.x * direction.x
	rtn.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		rtn.y = speed.y * direction.y
	if jump_done:
		rtn.y = 0.0
	return rtn
	
func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var rtn: = linear_velocity
	rtn.y = -impulse
	return rtn
