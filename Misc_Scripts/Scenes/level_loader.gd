extends Node
class_name LevelLoader

signal level_menu_request

var current_loaded_level: PackedScene
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

func load_level(level) -> void:
	if current_level:
		current_level.queue_free()
		
	current_map = directory + "/" + levels[level - 1]
	var progress = []
	ResourceLoader.load_threaded_get_status(current_map, progress)
	if progress[0] == 1:
		current_loaded_level = ResourceLoader.load_threaded_get(current_map)
		current_level = current_loaded_level.instantiate()
		add_child(current_level)
		current_level.connect("level_menu_request", on_level_menu_request)

func unload_level() -> void:
	if current_level:
		current_level.queue_free()

func load_next_level():
	load_level(current_level_number + 1)
	current_level_number += 1

func on_level_menu_request() -> void:
	emit_signal("level_menu_request")
	
