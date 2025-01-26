extends Container

func quit_to_main_menu() -> void:
	globals.return_to_main_menu()
	hide()

func quit_game() -> void:
	get_tree().quit()
