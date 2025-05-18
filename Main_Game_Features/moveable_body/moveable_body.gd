extends CharacterBody2D
class_name MoveableBody

var push_speed: float = 10000 #accerlatoin
#var max_push_speed: float = 500 #speed limit
var gravity: float = 1300 # going down is the positive y direction

var push_cooldown:bool = false #can't be pushed twice per frame
var disabled: bool = false

func _physics_process(delta: float) -> void:
	if disabled:
		return
	push_cooldown = false
	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
	move_and_slide()
	handle_push_collisions(delta)

func handle_push_collisions(delta: float) -> void:
	var was_char_collision = false
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_body = collision.get_collider()
		if collision_body is MoveableBody or (collision_body is Playable_Robot and collision_body.dead):
			var normal = collision.get_normal()
			if abs(normal.x) > 0.5:
				#collision_body.global_position += -normal * push_speed * delta
				collision_body.push_block(-normal.x * push_speed * delta)
				was_char_collision = true
	if !was_char_collision:
		if (self is Playable_Robot and !self.dead):
			return
		velocity.x *= 0.9

func push_block(push_force: float) -> void:
	print(push_force)
	#stops weird back and forth feedback loop (one directional push)
	if !push_cooldown:
		velocity.x += push_force
		#velocity.x = clamp(velocity.x, -max_push_speed, max_push_speed)
		push_cooldown = true
	
