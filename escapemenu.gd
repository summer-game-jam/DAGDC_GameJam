extends Control

signal reset_request
signal quit_request

func _on_reset_button_pressed() -> void:
	emit_signal("reset_request")

func _on_quit_button_pressed() -> void:
	emit_signal("quit_request")
