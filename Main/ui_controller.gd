extends CanvasLayer
class_name UI_Controller

signal quit_request
signal next_level_request
signal level_request(level: int)
signal deload_level_request

@onready var title: TitleUI = $title_ui
@onready var level_select: LevelSelect = $LevelSelect
@onready var level_menu: LevelMenu = $LevelMenu

func _on_level_request(level: int) -> void:
	emit_signal("level_request", level)

func show_level_menu() -> void:
	level_menu.show()

func hide_level_menu() -> void:
	level_menu.hide()
	
func show_level_select() -> void:
	level_select.show()

func hide_level_select() -> void:
	level_select.hide()


func _on_level_menu_main_menu_request() -> void:
	emit_signal("deload_level_request")
	if title:
		level_select.hide()
		level_menu.hide()
		title.show()

func _on_level_menu_next_level_request() -> void:
	emit_signal("next_level_request")


func _on_title_ui_quit_request() -> void:
	emit_signal("quit_request")


func _on_title_ui_start_request() -> void:
	if level_select:
		title.hide()
		hide_level_menu()
		show_level_select()


func _on_level_select_main_menu_request() -> void:
	if title:
		hide_level_select()
		title.show()
	
func update_level_select() -> void:
	level_select.update_buttons()
