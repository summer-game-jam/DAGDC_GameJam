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

func open_level_menu():
	level_menu.show_menu()
	
func load_next_level():
	level_loader.load_next_level()
	level_menu.hide_menu()

func back_to_menu():
	pass
	#level_menu.hide_menu()
