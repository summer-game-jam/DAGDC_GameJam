extends Entity
class_name Spwaner

signal create_robot_request(emitter: Spwaner)

# doesn't logicaly create a robot, instead acts as a natural way of adding a robot actor to the stage
# animation code here
func spwan_robot(robot: Playable_Robot):
	robot.global_position = global_position
	$AudioStreamPlayer2D.play()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action("left_click"):
		emit_signal("create_robot_request", self)
