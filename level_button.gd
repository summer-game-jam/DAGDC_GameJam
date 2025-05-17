@tool
extends Button
class_name LevelButton

signal level_button_selected(level: int)

@export var level: int

func _ready() -> void:
	set_level(level)

func _on_pressed() -> void:
	emit_signal("level_button_selected", level)

func set_level(new_level: int) -> void:
	level = new_level
	text = str(level)
