extends Node
class_name Music

func play_happy():
	stop_all()
	$AudioStreamPlayer2D.play()

func play_sad():
	stop_all()
	$AudioStreamPlayer2D2.play()

func stop_all():
	$AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D2.stop()

func _on_audio_stream_player_2d_finished() -> void:
	play_happy()

func _on_audio_stream_player_2d_2_finished() -> void:
	play_sad()
