extends Node
class_name LevelLoader

signal level_menu_request

var current_level: Level
var current_level_number: int

var current_map: String
var directory: String = "res://Main_Game_Features/Map/levels/debugLevels"
var levels: Array[String] = []

func _ready() -> void:
	var current_dir: DirAccess = DirAccess.open(directory)
	if current_dir:
		var files = current_dir.get_files()
		for file in files:
			levels.append(file)
	levels.sort()
	print(levels)
	current_level_number = 1

func load_level(level: int) -> void:
	if current_level:
		print("deloading level " + str(current_level_number))
		current_level.queue_free()
		
	current_map = directory + "/" + levels[level - 1]
	print(current_map)
	var progress = []
	ResourceLoader.load_threaded_get_status(current_map, progress)
	print(progress[0])
	if progress[0] == 1:
		print("loading level " + str(level))
		current_level = ResourceLoader.load_threaded_get(current_map).instantiate()
		add_child(current_level)
		current_level.connect("level_menu_request", on_level_menu_request)
		current_level_number = level

func unload_level() -> void:
	if current_level:
		current_level.queue_free()

func load_next_level():
	load_level(current_level_number + 1)

func on_level_menu_request() -> void:
	emit_signal("level_menu_request")
	
