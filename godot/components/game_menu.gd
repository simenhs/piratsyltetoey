extends Container

signal quit_to_main_menu_signal

func quit_to_main_menu() -> void:
	quit_to_main_menu_signal.emit()
	hide()

func quit_game() -> void:
	get_tree().quit()
