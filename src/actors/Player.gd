extends Actor
class_name Player

func _physics_process(delta: float) -> void:
	var direction: = _get_direction()
	velocity = speed * direction
	velocity = move_and_slide(velocity)
		
		
func _get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)