extends Entity
class_name Door

var door_opened: bool = false

@export var defalut_state: bool = false

func _ready() -> void:
	$Power_Node.unpowered_state = defalut_state
	$Power_Node.update()

func open_door() -> void:
	if !door_opened:
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("open")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		door_opened = true

func close_door() -> void:
	if door_opened:
		$AudioStreamPlayer2D.play()
		$AnimatedSprite2D.play("close")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		door_opened = false
