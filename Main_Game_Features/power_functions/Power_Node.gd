extends Node
class_name Power_Node

@export var unpowered_state: bool = false
var is_powered: bool = false

signal on_state
signal off_state

func _ready() -> void:
	update()
	
func toggle_power(new_state: bool):
	is_powered = new_state
	update()

# d  p   final state
# 0, 0 | 0
# 0, 1 | 1
# 1, 0 | 1
# 1 ,1 | 0
func update():
	print(is_powered != unpowered_state)
	if is_powered != unpowered_state:
		emit_signal("off_state")
	else:
		emit_signal("on_state")
