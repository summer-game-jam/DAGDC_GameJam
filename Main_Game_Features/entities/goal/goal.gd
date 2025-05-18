extends Entity
class_name Goal

signal goal_hit_by_player

var goal_completed: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !goal_completed:
		goal_completed = true
		emit_signal("goal_hit_by_player")
