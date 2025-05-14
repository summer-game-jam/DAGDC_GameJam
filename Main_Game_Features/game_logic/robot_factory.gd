extends Node
class_name Robot_Factory

var robot_data: PackedScene = preload("res://Main_Game_Features/playable_robot/playable_robot.tscn")

func create_robot() -> Playable_Robot:
	return robot_data.instantiate()
