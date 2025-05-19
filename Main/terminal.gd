extends MarginContainer

@export var text: String

func _ready() -> void:
	$ColorRect2/MarginContainer/ColorRect/MarginContainer/ColorRect/RichTextLabel.text = text
