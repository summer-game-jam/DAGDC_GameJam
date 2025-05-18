extends Control
class_name LevelMenu

signal next_level_request
signal main_menu_request

#var current_level: int

func _ready() -> void:
	hide()

func _on_next_level_button_pressed() -> void:
	emit_signal("next_level_request")
	
func _on_main_menu_button_pressed() -> void:
	emit_signal("main_menu_request")
