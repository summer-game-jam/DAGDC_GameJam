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

func _ready() -> void:
	ui_controller.connect("quit_request", _on_quit_request)
	ui_controller.connect("next_level_request", _on_next_level_request)
	ui_controller.connect("level_request", _on_level_request)
	
func _on_quit_request() -> void:
	get_tree().quit()

func _on_next_level_request() -> void:
	ui_controller.hide_level_menu()
	level_loader.load_next_level()

func _on_level_request(level: int) -> void:
	#ui_controller.hide_level_select()
	level_loader.load_level(level)
