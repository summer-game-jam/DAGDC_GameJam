extends Node
class_name Main_Scene

# This is the captian of the ship
# Main will not do any "game logic work"
# Main will delegate game tasks to nodes/scenes you create
# Each node/scene should only concern its own feature. indepedent of all other elements
# node/scene should be built in a captain to ensign sort of command sturcture.
# main is captain, main will receive signals from the nodes under it and then give them commands
# This pattern of control ought to be copied down top level down

var level_loader: LevelLoader
var level_menu: LevelMenu
var title_ui: TitleUI

func _ready() -> void:
	title_ui = preload("res://Main/menu_ui/title_ui.tscn").instantiate()
	level_loader = preload("res://Main/level_loader/level_loader.tscn").instantiate()
	level_menu = preload("res://Main/menu_ui/level_menu.tscn").instantiate()
	
	level_loader.connect("level_menu_request", open_level_menu)
	level_menu.connect("next_level_request", load_next_level)
	level_menu.connect("main_menu_request", back_to_menu)

func open_level_menu():
	level_menu.show_menu()
	
func load_next_level():
	level_loader.load_next_level()
	level_menu.hide_menu()

func back_to_menu():
	pass
	#level_menu.hide_menu()
