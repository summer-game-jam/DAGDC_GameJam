extends MarginContainer

@export_multiline var text: String

func _ready() -> void:
	$MarginContainer/MarginContainer/MarginContainer/Label.text = text
