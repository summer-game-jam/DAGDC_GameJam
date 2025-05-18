extends Node
class_name Main_Scene

# This is the captian of the ship
# Main will not do any "game logic work"
# Main will delegate game tasks to nodes/scenes you create
# Each node/scene should only concern its own feature. indepedent of all other elements
# node/scene should be built in a captain to ensign sort of command sturcture.
# main is captain, main will receive signals from the nodes under it and then give them commands
# This pattern of control ought to be copied down top level down

@onready var ui_controller: UI_Controller = $UIController
@onready var level_loader: LevelLoader = $LevelLoader
	
func _on_quit_request() -> void:
	get_tree().quit()

func _ready():
	$Music.play_happy()

func _on_next_level_request() -> void:
	ui_controller.hide_level_menu()
	level_loader.load_next_level()

func _on_level_request(level: int) -> void:
	ui_controller.hide_level_select()
	level_loader.load_level(level)
	ui_controller.in_level = true

func _on_level_loader_level_menu_request(level: int) -> void:
	ui_controller.show_level_menu()
	if level > SaveManager.levels_save.levels_completed:
		SaveManager.increment_levels_completed()
		SaveManager.save()
		ui_controller.update_level_select()

func _on_ui_controller_deload_level_request() -> void:
	level_loader.deload_level()

func _on_ui_controller_reset_request() -> void:
	var level_number = level_loader.deload_level()
	level_loader.load_level(level_number)
