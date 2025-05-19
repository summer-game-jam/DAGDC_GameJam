extends Camera2D
class_name game_cam

var mode: bool = false
var defalut_spot: Vector2
var center: Node2D
var robot_to_follow: Playable_Robot
var desired_Zoom: float = 0.7

@export var acceleration: float = 8.0
@export var max_speed: float = 10000.0
@export var min_distance: float = 1.0

func _ready() -> void:
	defalut_spot = position

func _process(delta):
	var target_position: Vector2
	if robot_to_follow and center:
		target_position = (robot_to_follow.global_position + center.global_position) * 0.5
	elif center:
		target_position = center.global_position
	
	var offset = target_position - global_position
	var distance = offset.length()
	if distance > min_distance:
		global_position += offset.normalized() * min(distance * acceleration, max_speed) * delta
	
	zoom = zoom.lerp(Vector2(desired_Zoom, desired_Zoom), delta * 5.0)

func reset():
	robot_to_follow = null
	center = null
	mode = false
	position = defalut_spot
	desired_Zoom = 0.7

func set_robot(robot: Playable_Robot):
	robot_to_follow = robot
	desired_Zoom = 1

func soft_reset():
	robot_to_follow = null
	desired_Zoom = 0.7
