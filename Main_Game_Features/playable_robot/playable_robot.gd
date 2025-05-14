extends CharacterBody2D
class_name Playable_Robot

signal bot_out_of_power

var gravity: float = 1300 # going down is the positive y direction

var jump_force: float = -600
var air_speed_reduction: float = 0.2

var max_horizonal_move_speed: float = 500
var horizonal_move_speed: float = 2000
var push_speed: float = max_horizonal_move_speed / 5

var dead: bool = false

func _ready() -> void:
	$Timer.start()

func _physics_process(delta: float) -> void:
	update_battery()
	move_player(delta)
	move_and_slide()
	if abs(velocity.y) < 100: # shouldn't push if in air
		handle_push_collisions(delta)

func _on_timer_timeout() -> void:
	if !dead:
		dead = true
		emit_signal("bot_out_of_power")

func _on_node_button_held_limit_reached() -> void:
	$Timer.stop()
	_on_timer_timeout()

func update_battery() -> void:
	$Label.text = str($Timer.time_left)

func move_player(delta: float) -> void:
	#Phase 1 read user input (the dead can't input)
	var horizonal_move_unit_vector: float = 0
	var jump: bool = false
	
	if !dead:
		if Input.is_action_pressed("left"):
			horizonal_move_unit_vector -= 1
		elif Input.is_action_pressed("right"):
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
			velocity.x = 0
		else:
			velocity.x += delta * horizonal_move_unit_vector * horizonal_move_speed
			velocity.x = clamp(velocity.x, -max_horizonal_move_speed, max_horizonal_move_speed)
	#can move very slowly; can't jump; can't move bodys
	else:
		velocity.y += gravity * delta
		velocity.x += delta * horizonal_move_unit_vector * horizonal_move_speed * air_speed_reduction
		velocity.x = clamp(velocity.x, -max_horizonal_move_speed, max_horizonal_move_speed)

func handle_push_collisions(delta: float) -> void:
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var other = collision.get_collider()
		if other is CharacterBody2D:
			var normal = collision.get_normal()
			if abs(normal.x) > 0.5:
				other.global_position += -normal * push_speed * delta
