extends Entity
class_name Lazar_Target



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Lazar:
		print("yes")
	else:
		print("no:\t", area)
