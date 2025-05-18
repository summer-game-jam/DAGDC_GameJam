extends Entity
class_name Goal

signal goal_hit_by_player

var goal_completed: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !goal_completed and body is Playable_Robot:
		goal_completed = true
		$AnimatedSprite2D.play("on")
		emit_signal("goal_hit_by_player")
		$AudioStreamPlayer2D.play()
		$AudioStreamPlayer2D2.play()
