extends CanvasLayer
class_name UI_Controller

signal quit_request
signal next_level_request
signal level_request(level: int)

@onready var title: TitleUI = $title_ui
@onready var level_select: LevelSelect = $LevelSelect
@onready var level_menu: LevelMenu = $LevelMenu

func _ready() -> void:
	title.connect("start_request", _on_start_request)
	title.connect("quit_request", _on_quit_request)
	level_select.connect("level_request", _on_level_request)
	level_select.connect("main_menu_request", _on_main_menu_request)
	level_menu.connect("next_level_request", _on_next_level_request)
	level_menu.connect("main_menu_request", _on_main_menu_request)

func _on_start_request() -> void:
	if level_select:
		title.hide()
		level_menu.hide()
		level_select.show()

func _on_quit_request() -> void:
	emit_signal("quit_request")

func _on_level_request(level: int) -> void:
	emit_signal("level_request", level)
	
func _on_next_level_request() -> void:
	emit_signal("next_level_request")

func _on_main_menu_request() -> void:
	if title:
		level_select.hide()
		level_menu.hide()
		title.show()

func hide_level_menu() -> void:
	level_menu.hide()

func hide_level_select() -> void:
	level_select.hide()
