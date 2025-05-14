extends Entity
class_name Lazar

## ture = right; false = left
@export var direction: bool = true

func _process(delta: float) -> void:
	print(self)
	if $RayCast2D.is_colliding():
		var object_lazar_hit = instance_from_id($RayCast2D.get_collider_rid().get_id())
		print(object_lazar_hit)
		if object_lazar_hit is Lazar_Target:
			print("YES!!")
	if Input.is_action_pressed("left"):
		position.y -= delta * 100

func swap_direction(new_direction: bool) -> void:
	direction = new_direction
