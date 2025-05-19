extends Node

var pressed: bool = false

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !pressed and event.is_action("left_click"):
		get_parent().get_parent().get_parent().get_node("Music").stop_all()
		$AudioStreamPlayer2D.play()
		$AnimationPlayer.play("no_head?")
		pressed = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AudioStreamPlayer2D.stop()
	$Timer.start()

func _on_timer_timeout() -> void:
	var fresh_robot:Playable_Robot = get_parent().robot_generator.create_robot()
	fresh_robot.position = $Node2D.position
	add_child(fresh_robot)
