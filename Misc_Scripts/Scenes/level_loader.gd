extends Node
class_name LevelLoader

signal level_menu_request(level: int)

var current_level: Level
var current_level_number: int

var current_map: String
var directory: String = "res://Main_Game_Features/Map/levels/productionLevels"
var levels: Array[String] = []
var loading_level: bool = false

func _ready() -> void:
	var current_dir: DirAccess = DirAccess.open(directory)
	if current_dir:
		var files = current_dir.get_files()
		for file in files:
			if file.ends_with(".remap"):
				file = file.replace(".remap", "")
			levels.append(file)
	levels.sort()
	print(levels)
	current_level_number = 1

func _process(delta: float) -> void:
	if loading_level:
		var progress = []
		ResourceLoader.load_threaded_get_status(current_map, progress)
		print(progress[0])
		if progress[0] == 1:
			current_level = ResourceLoader.load_threaded_get(current_map).instantiate()
			add_child(current_level)
			current_level.connect("level_menu_request", on_level_menu_request)
			current_level.level_number = current_level_number
			$LevelHUD.set_level_name(current_level.level_name)
			$LevelHUD.set_robots(current_level.max_robot_limit)
			$LevelHUD.set_battery_life(10)
			$LevelHUD.visible = true
			loading_level = false

func load_level(level: int) -> void:
	$game_cam.reset()
	if current_level:
		print("deloading level " + str(current_level_number))
		# come back to this -> eric
		current_level.queue_free()
		
	if level <= len(levels):
		current_map = directory + "/" + levels[level - 1]
		print(current_map)
		ResourceLoader.load_threaded_request(current_map)
		current_level_number = level
		loading_level = true


func deload_level() -> int:
	$game_cam.reset()
	if current_level:
		$LevelHUD.visible = false
		current_level.queue_free()
	return current_level_number

func load_next_level():
	load_level(current_level_number + 1)

func on_level_menu_request(level: int) -> void:
	emit_signal("level_menu_request", level)
	
