extends CanvasLayer
class_name LevelHUD

func set_level_name(text: String) -> void:
	$CenterContainer/HUD/LevelName.text = text

func set_robots(robots: int) -> void:
	$CenterContainer/HUD/Robots/RobotsLeft.text = str(robots)

func set_battery_life(seconds: int) -> void:
	$CenterContainer/HUD/Battery/BatteryLife.text = str(seconds)
