extends MoveableBody
class_name Playable_Robot

signal bot_out_of_power

var max_time = 10

var jump_force: float = -600
var air_speed_reduction: float = 0.2

var max_horizonal_move_speed: float = 500
var horizonal_move_speed: float = 2000

var dead: bool = false

func _ready() -> void:
	$Timer.wait_time = max_time
	$Timer.start()

func _physics_process(delta: float) -> void:
	update_battery()
	if disabled:
		return
	move_player(delta)
	move_and_slide()
	if abs(velocity.y) < 100: # shouldn't push if in air
		handle_push_collisions(delta)

func _on_timer_timeout() -> void:
	if !dead:
		dead = true
		$pick_up_ability.drop()
		emit_signal("bot_out_of_power")

func _on_node_button_held_limit_reached() -> void:
	$Timer.stop()
	_on_timer_timeout()

#replace me
func update_battery() -> void:
	$Label.text = str($Timer.time_left)
	$robot_graphics.update_battery($Timer.time_left / $Timer.wait_time)

func move_player(delta: float) -> void:
	#Phase 1 read user input (the dead can't input)
	var horizonal_move_unit_vector: float = 0
	var jump: bool = false
	
	if !dead:
		if Input.is_action_pressed("left"):
			face_direction(true)
			horizonal_move_unit_vector -= 1
		elif Input.is_action_pressed("right"):
			face_direction(false)
			horizonal_move_unit_vector += 1
		if Input.is_action_just_pressed("jump"):
			jump = true
	
	#Phase 2; apply
	#can move freely; can jump; can move bodys
	if is_on_floor():
		if jump:
			velocity.y = jump_force
		else:
			velocity.y = 0
		if horizonal_move_unit_vector == 0:
			velocity.x *= 0.9
		else:
			velocity.x += delta * horizonal_move_unit_vector * horizonal_move_speed
			velocity.x = clamp(velocity.x, -max_horizonal_move_speed, max_horizonal_move_speed)
	#can move very slowly; can't jump; can't move bodys
	else:
		velocity.y += gravity * delta
		velocity.x += delta * horizonal_move_unit_vector * horizonal_move_speed * air_speed_reduction
		velocity.x = clamp(velocity.x, -max_horizonal_move_speed, max_horizonal_move_speed)

# true = face left
# right = face right
func face_direction(new_direction: bool):
	$robot_graphics.flip(new_direction)
	$pick_up_ability.rotate_cast(new_direction)

func reached_goal():
	$Timer.stop()
	$robot_graphics.reached_goal()
	dead = true
