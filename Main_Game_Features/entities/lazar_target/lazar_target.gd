extends Entity
class_name Lazar_Target

@export var connected_entity: Entity
var connected_device: Power_Node

var play_emit_noise:bool = false

func _ready():
	if !connected_entity:
		push_error("target has no connected Entity!")
		return
	for child in connected_entity.get_children():
		if child is Power_Node:
			connected_device = child
			break
	if !connected_device:
		push_error("target is connected to Entity with no power node!")

func _physics_process(delta: float) -> void:
	check_if_pressed()

func check_if_pressed() -> void:
	if !connected_device:
		push_error("target has no connected Entity!")
		return
	var pressed_down: bool = false
	for child in $Area2D.get_overlapping_areas():
		if child is laser_emit:
			pressed_down = true
			break
	if pressed_down:
		connected_device.toggle_power(true)
		if play_emit_noise:
			$AudioStreamPlayer2D.play()
			play_emit_noise = false
		$AnimatedSprite2D.play("on")
	else:
		connected_device.toggle_power(false)
		$AnimatedSprite2D.play("off")
		play_emit_noise = true
