extends Container

func _ready() -> void:
	set_process(false)

func play_pressed() -> void:
	globals.transition_to_scene(globals.TRANSITION_TO_GAMEPLAY_SCENE_PATH)
	hide()

func quit_pressed() -> void:
	get_tree().quit()
