@tool
extends Button
class_name level_button

signal level_button_selected(level: int)

var level:int = -1

func _ready() -> void:
	set_level(level)

func _on_pressed() -> void:
	emit_signal("level_button_selected", level)

func set_level(new_level: int) -> void:
	level = new_level
	text = str(level)
