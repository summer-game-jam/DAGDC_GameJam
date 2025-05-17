extends Node
class_name Left_Click_Listener

@export var max_held_time_requirment: float = 2

var button_held_for: float = 0

signal button_held_limit_reached

func _process(delta: float) -> void:
	if Input.is_action_pressed("right_click"):
		button_held_for += delta
	else:
		button_held_for = 0
	
	if button_held_for >= max_held_time_requirment:
		emit_signal("button_held_limit_reached")
