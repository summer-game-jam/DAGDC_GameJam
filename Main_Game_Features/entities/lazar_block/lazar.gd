extends Entity
class_name Lazar

## ture = right; false = left
@export var direction: bool = true

func _process(delta: float) -> void:
	$Line2D.points[-1] = $RayCast2D.target_position

func swap_direction(new_direction: bool) -> void:
	direction = new_direction
