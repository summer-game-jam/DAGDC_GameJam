extends CharacterBody2D
class_name Playable_Robot

var gravity: float = 20 # going down is the positive y direction

var jump_force: float = -600

var max_horizonal_move_speed: float = 500
var horizonal_move_speed: float = 2000

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
		else:
			velocity.y = 0
		
		var horizonal_move_unit_vector: float = 0
		if Input.is_action_pressed("left"):
			horizonal_move_unit_vector -= 1
		elif Input.is_action_pressed("right"):
			horizonal_move_unit_vector += 1
		else:
			velocity.x = 0
		velocity.x += delta * horizonal_move_unit_vector * horizonal_move_speed
		velocity.x = clamp(velocity.x, -max_horizonal_move_speed, max_horizonal_move_speed)
		
	else:
		velocity.y += gravity
	
	move_and_slide()
