extends Node2D
class_name Level

@export var level_name: String
@export var max_robot_limit: int = 3
@export var battery_life: int = 10
var level_number: int

# all levels need a start, a map, and a endpoint
# levels can have puzzle elements (entite
var spawners: Array[Spwaner]
var goal: Goal

signal level_menu_request(level: int)
signal robot_spwan

var robot_generator: Robot_Factory = Robot_Factory.new()

var robots: Array[Playable_Robot] = []

var robot_in_production: bool = true
var is_level_over: bool = false

@onready var camera: game_cam =  get_parent().get_node("game_cam")

func _ready() -> void:
	camera.center = $Node2D
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
		goal.connect("goal_hit_by_player", _on_goal_hit_by_player)
		goal.connect("goal_hit_by_player", request_level_menu)
		goal.connect("goal_hit_by_player", level_over)

	robot_in_production = false

func spwan_robot(spawner: Spwaner):
	if !robot_in_production and !is_level_over:
		print("Spawning Robot")
		var new_robot: Playable_Robot = robot_generator.create_robot()
		robots.push_back(new_robot)
		new_robot.connect("bot_out_of_power", robot_died)
		if robots.size() > max_robot_limit:
			var robot_to_remove: Playable_Robot = robots.pop_front()
			robot_to_remove.queue_free()
		spawner.spwan_robot(new_robot)
		new_robot.set_time(battery_life)
		add_child(new_robot)
		robot_in_production = true
		camera.set_robot(new_robot)
		emit_signal("robot_spwan", new_robot)

func robot_died():
	robot_in_production = false
	camera.soft_reset()

func _on_goal_hit_by_player():
	emit_signal("level_menu_request", level_number)

func request_level_menu():
	emit_signal("level_menu_request")
	
func level_over():
	is_level_over = true
	if robots.size() != 0:
		robots[-1].reached_goal()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("r"):
		if robots.size() > 1:
			var robot_to_remove: Playable_Robot = robots.pop_front()
			robot_to_remove.queue_free()
