extends Entity
class_name Lazar

## ture = right; false = left
@export var direction: bool = true

func _process(delta: float) -> void:
	if $MoveableBody/RayCast2D.is_colliding():
		$MoveableBody/Line2D.points[-1] = $MoveableBody/Line2D.to_local($MoveableBody/RayCast2D.get_collision_point())
		var object_lazar_hit = $MoveableBody/RayCast2D.get_collider()
		#print(object_lazar_hit)
		if object_lazar_hit.get_parent() is Lazar_Target:
			object_lazar_hit.get_parent()

func swap_direction(new_direction: bool) -> void:
	direction = new_direction
