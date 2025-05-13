extends CharacterBody2D
class_name Playable_Robot

signal bot_out_of_power

var gravity: float = 20 # going down is the positive y direction

var jump_force: float = -650

var max_horizonal_move_speed: float = 500
var horizonal_move_speed: float = 2000

var dead: bool = false

func _ready() -> void:
	$Timer.start()

func _physics_process(delta: float) -> void:
	$Label.text = str($Timer.time_left)
	if is_on_floor():
		if !dead:
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
			velocity.x = 0
	else:
		velocity.y += gravity
	
	move_and_slide()

func _on_timer_timeout() -> void:
	if !dead:
		dead = true
		emit_signal("bot_out_of_power")
	#become physics object instead of char body
	#$CollisionShape2D.call_deferred("set_disabled", true)
	#$StaticBody2D/CollisionShape2D.call_deferred("set_disabled", false)

func _on_node_button_held_limit_reached() -> void:
	$Timer.stop()
	_on_timer_timeout()
