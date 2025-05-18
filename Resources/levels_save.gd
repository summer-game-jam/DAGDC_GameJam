extends Resource
class_name LevelsSave

@export var levels_completed: int = 0

func increment_levels_completed() -> void:
	levels_completed += 1
