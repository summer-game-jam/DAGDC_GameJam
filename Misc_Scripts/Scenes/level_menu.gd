extends Control
class_name LevelMenu

signal next_level_request
signal main_menu_request

#var current_level: int

func _ready() -> void:
	visible = false

# if level number is needed here
#func set_level_number(level_number) -> void:
	#current_level = level_number
	
#func show_menu(level_number) -> void:
	#set_level_number(level_number)
	#visible = true
	
func show_menu() -> void:
	visible = true

func hide_menu() -> void:
	visible = false

# on next level button press
	# send next level signal to main

# on back to main menu button press
	# send back to main menu signal

func _on_next_level_button_pressed() -> void:
	emit_signal("next_level_request")
	


func _on_main_menu_button_pressed() -> void:
	emit_signal("main_menu_request")
