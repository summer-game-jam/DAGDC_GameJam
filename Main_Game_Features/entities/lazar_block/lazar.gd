extends Entity
class_name Lazar

## ture = right; false = left
@export var direction: bool = true

func _process(delta: float) -> void:
	if $RayCast2D.is_colliding():
		$Line2D.points[-1] = $Line2D.to_local($RayCast2D.get_collision_point())
		var object_lazar_hit = $RayCast2D.get_collider()
		#print(object_lazar_hit)
		$Area2D.position = $Line2D.points[-1]
		if object_lazar_hit and object_lazar_hit.get_parent() is Lazar_Target:
			object_lazar_hit.get_parent()

func swap_direction(new_direction: bool) -> void:
	direction = new_direction
	if direction:
		$RayCast2D.target_position.x = -abs($RayCast2D.target_position.x)
	else:
		$RayCast2D.target_position.x = abs($RayCast2D.target_position.x)


func _on_audio_stream_player_2d_finished() -> void:
	$AudioStreamPlayer2D.play()
