extends Node2D
class_name Level

signal level_menu_request

#THIS VARAIBLE TO BE REMOVED IN FAVOR FOR A LEVEL MANAGER
@export var levelID: int = 1

@export var max_robot_limit: int = 3

# all levels need a start, a map, and a endpoint
# levels can have puzzle elements (entite
var spawner: Spwaner
var goal: Goal

var robot_generator: Robot_Factory = Robot_Factory.new()

var robots: Array[Playable_Robot] = []

func _ready() -> void:
	for child in get_children():
		if child is Spwaner:
			if spawner:
				push_error("ERROR: multiple spanwers! Only one spanwer is supported! Please fix!")
			else:
				spawner = child
		if child is Goal:
			if goal:
				push_error("ERROR: multiple goals! Olny one goal is supported! Please fix!")
			else:
				goal = child
	if !spawner:
		push_error("ERROR: no spawner!")
	if !goal:
		push_error("ERROR: no goal!")
	else:
		goal.connect("goal_hit_by_player", request_level_menu)
	spwan_robot()

func spwan_robot():
	if spawner:
		print("Spawning Robot")
		var new_robot: Playable_Robot = robot_generator.create_robot()
		robots.push_back(new_robot)
		new_robot.connect("bot_out_of_power", spwan_robot)
		if robots.size() > max_robot_limit:
			var robot_to_remove: Playable_Robot = robots.pop_front()
			robot_to_remove.queue_free()
		spawner.spwan_robot(new_robot)
		add_child(new_robot)
	else:
		push_error("ERROR: no spwaner to spwan robot!")

func request_level_menu():
	emit_signal("level_menu_request")
