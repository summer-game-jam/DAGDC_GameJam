extends Entity
class_name Press_Down_Button

@export var connected_entity: Entity
var connected_device: Power_Node

func _ready():
	if !connected_entity:
		push_error("Button has no connected Entity!")
		return
	for child in connected_entity.get_children():
		if child is Power_Node:
			connected_device = child
			break
	if !connected_device:
		push_error("Button is connected to Entity with no power node!")

func _physics_process(delta: float) -> void:
	check_if_pressed()

func check_if_pressed() -> void:
	if !connected_device:
		push_error("Button has no connected Entity!")
		return
	var pressed_down: bool = false
	for child in $Area2D.get_overlapping_bodies():
		if child is Playable_Robot:
			pressed_down = true
			break
	if pressed_down:
		connected_device.toggle_power(true)
	else:
		connected_device.toggle_power(false)
