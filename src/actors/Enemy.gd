extends Actor
class_name Enemy

func _ready() -> void:
	# deactivate enemy initially
	set_physics_process(true) 
	# enemy moves left when activated
	_velocity.x = -speed.x
	
func _on_StompArea_body_entered(body: PhysicsBody2D) -> void:
	# double check the event before killing enemy
	if body.global_position.y > get_node("StompArea").global_position.y:
		return
	# we made it here, so lets disable the enemies abilty to kill us
	get_node("CollisionShape2D").disabled = true
	# and release them from opur world
	queue_free()

func _physics_process(delta: float) -> void:
	# reverse enemy when colliding with wall
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
