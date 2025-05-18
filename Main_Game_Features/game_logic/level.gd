extends Node2D
class_name Level

@export var max_robot_limit: int = 3

# all levels need a start, a map, and a endpoint
# levels can have puzzle elements (entite
var spawners: Array[Spwaner]
var goal: Goal

signal level_menu_request

var robot_generator: Robot_Factory = Robot_Factory.new()

var robots: Array[Playable_Robot] = []

var robot_in_production: bool = true

func _ready() -> void:
	for child in get_children():
		if child is Spwaner:
			spawners.append(child)
			child.connect("create_robot_request", spwan_robot)
		if child is Goal:
			if goal:
				push_error("ERROR: multiple goals! Olny one goal is supported! Please fix!")
			else:
				goal = child
	if spawners.size() == 0:
		push_error("ERROR: no spawner!")
	if !goal:
		push_error("ERROR: no goal!")
	else:
		goal.connect("goal_hit_by_player", request_level_menu)
	robot_in_production = false

func spwan_robot(spawner: Spwaner):
	if !robot_in_production:
		print("Spawning Robot")
		var new_robot: Playable_Robot = robot_generator.create_robot()
		robots.push_back(new_robot)
		new_robot.connect("bot_out_of_power", robot_died)
		if robots.size() > max_robot_limit:
			var robot_to_remove: Playable_Robot = robots.pop_front()
			robot_to_remove.queue_free()
		spawner.spwan_robot(new_robot)
		add_child(new_robot)
		robot_in_production = true

func robot_died():
	robot_in_production = false

func request_level_menu():
	emit_signal("level_menu_request")
