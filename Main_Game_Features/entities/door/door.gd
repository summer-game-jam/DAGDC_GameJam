extends Entity
class_name Door

var door_opened: bool = false

func open_door() -> void:
	$Sprite2D.modulate.a = 0.2
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	door_opened = true

func close_door() -> void:
	$Sprite2D.modulate.a = 1
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	door_opened = false
