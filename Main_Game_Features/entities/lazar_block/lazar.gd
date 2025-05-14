extends Entity
class_name Lazar

## ture = right; false = left
@export var direction: bool = true

func _process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		$Line2D.points[-1] = to_local($RayCast2D.get_collision_point())
		var object_lazar_hit = $RayCast2D.get_collider()
		#print(object_lazar_hit)
		if object_lazar_hit.get_parent() is Lazar_Target:
			object_lazar_hit.get_parent()
	if Input.is_action_pressed("left"):
		position.x -= delta * 100
	if Input.is_action_pressed("right"):
		position.y -= delta * 100

func swap_direction(new_direction: bool) -> void:
	direction = new_direction
