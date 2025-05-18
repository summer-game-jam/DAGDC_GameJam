extends Node2D
class_name RobotGraphics

var audio_death_rattle_played: bool = false

func flip(new_direction: bool):
	$face.flip_h = new_direction
	$battery.flip_h = new_direction

func update_battery(battery_precent:float):
	var battery_meter:int = int(battery_precent * 10)
	if battery_precent < 0.0000000001:
		if !audio_death_rattle_played:
			audio_death_rattle_played = true
			$AudioStreamPlayer2D.play()
		$battery.play("0")
		$face.play("dead")
	elif battery_meter == 0 or battery_meter == 1 or battery_meter == 2:
		$face.play("low")
		$battery.play("20")
	elif battery_meter == 3 or battery_meter == 4:
		$battery.play("40")
	elif battery_meter == 5 or battery_meter == 6:
		$battery.play("60")
	elif battery_meter == 7 or battery_meter == 8:
		$battery.play("80")
	else:
		$battery.play("full")
