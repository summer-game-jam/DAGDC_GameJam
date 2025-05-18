extends Node2D
class_name PickUpAbility

var pickup_location_offset:Vector2 = Vector2(-0, -72)

var closest_object: MoveableBody
var picked_up_object: MoveableBody

func _process(delta: float) -> void:
	check_for_input()
	if picked_up_object:
		update_object()

func check_for_objects():
	var temp_object = $RayCast2D.get_collider()
	print(temp_object)
	if temp_object is MoveableBody:
		closest_object = temp_object
	else:
		closest_object = null

func check_for_input():
	if Input.is_action_just_pressed("e") and !get_parent().dead:
		check_for_objects()
		pick_up()

func pick_up():
	if closest_object and !picked_up_object:
		picked_up_object = closest_object
		picked_up_object.disabled = true

func drop():
	if picked_up_object:
		picked_up_object.disabled = false
		picked_up_object = null

func update_object():
	if picked_up_object:
		var collision_shape: CollisionShape2D = picked_up_object.get_node("CollisionShape2D")
		var collision_offset = collision_shape.shape.get_rect().size.y / 2
		picked_up_object.position = global_position + pickup_location_offset - Vector2(0, collision_offset)

func rotate_cast(new_direction: bool):
	if new_direction:
		$RayCast2D.target_position.x = -100
	else:
		$RayCast2D.target_position.x = 100
	#if picked_up_object is 
