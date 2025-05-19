extends MarginContainer

@export var text: String

func _ready() -> void:
	$MarginContainer/MarginContainer/MarginContainer/Label.text = text
