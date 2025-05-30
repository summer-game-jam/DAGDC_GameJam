extends Control
class_name LevelSelect

signal level_request(level: int)
signal main_menu_request

var directory: String = "res://Main_Game_Features/Map/levels/productionLevels"
var LevelButtonScene: PackedScene = preload("res://Main/menu_ui/controller/level_button.tscn")

@onready var grid_container: GridContainer = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	hide()
	load_level_buttons()
	
func load_level_buttons() -> void:
	var levels = []
	var current_dir: DirAccess = DirAccess.open(directory)
	if current_dir:
		var files = current_dir.get_files()
		for file in files:
			levels.append(file)
	levels.sort()
	
	var current_level_number: int = 1
	for level in levels:
		var button: LevelButton = LevelButtonScene.instantiate()
		button.set_level(current_level_number)
		grid_container.add_child(button)
		button.connect("level_button_selected", _on_level_button_selected)
		if current_level_number > SaveManager.levels_save.levels_completed + 1:
				button.disabled = true
		current_level_number += 1

func update_buttons() -> void:
	for button in grid_container.get_children():
		if button.level <= SaveManager.levels_save.levels_completed + 1:
			button.disabled = false
		else:
			break
	
func _on_level_button_selected(level: int) -> void:
	emit_signal("level_request", level)

func _on_back_button_pressed() -> void:
	emit_signal("main_menu_request")
