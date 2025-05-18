extends Node

@onready var levels_save: LevelsSave = LevelsSave.new()
var save_path: String = "user://save.tres"

func _ready() -> void:
	load_save()

func increment_levels_completed() -> void:
	levels_save.increment_levels_completed()

func verify_save_path(path: String) -> void:
	var dir = DirAccess.open("user://")
	if dir:
		print("verified save path")

func save() -> void:
	print("attempting save")
	verify_save_path(save_path)
	var result = ResourceSaver.save(levels_save, save_path)
	if result != OK:
		print("Failed to save. Error: ", result)
	else:
		print("Save successful!")

func load_save() -> void:
	verify_save_path(save_path)
	if ResourceLoader.exists(save_path):
		levels_save = ResourceLoader.load(save_path).duplicate(true)
		print("levels completed: " + str(levels_save.levels_completed))
