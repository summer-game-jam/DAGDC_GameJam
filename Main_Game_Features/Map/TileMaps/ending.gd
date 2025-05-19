extends Node

var death_robot: Playable_Robot

var pass1 = false
var pass2 = false
var pass3 = false
var pass4 = false
var pass5 = false

func _on__robot_spwan(robot: Playable_Robot) -> void:
	var timer: Timer = robot.get_node("Timer")
	timer.stop()
	robot.get_node("Node").queue_free()
	death_robot = robot
	death_robot.cutsence_battery = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !pass1 and body is Playable_Robot:
		pass1 = true
		death_robot.update_value = 0.8


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if !pass2 and body is Playable_Robot:
		pass2 = true
		death_robot.update_value = 0.6


func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if !pass3 and body is Playable_Robot:
		pass3 = true
		death_robot.update_value = 0.4
		death_robot.max_horizonal_move_speed *= 0.5

func _on_area_2d_4_body_entered(body: Node2D) -> void:
	if !pass4 and body is Playable_Robot:
		pass4 = true
		death_robot.update_value = 0.2
		death_robot.max_horizonal_move_speed *= 0.5

func _on_area_2d_6_body_entered(body: Node2D) -> void:
	if !pass5 and body is Playable_Robot:
		pass5 = true
		death_robot.update_value = 0
		death_robot.dead = true
		$Timer.start()

func _on_timer_timeout() -> void:
	get_parent().get_node("Terminal2/MarginContainer/MarginContainer/MarginContainer/Label").text = "ERROR! ERROR! ERROR! MAIN FUSE REPAIR TIMEOUT! SUNSHINE PROTOCOL TIMEOUT! RESENDING PROTOCOL REQUEST! CAUSE OF ERROR: UNKNOWN! RESTART! RESTART! ERROR! EMERGENCY DESTORY ALL FUSES! ERROR! ERROR! RESEND! RETRY! ERROR!"
	get_parent().get_parent().get_parent().get_node("Music").play_sad()
