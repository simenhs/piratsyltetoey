extends Node2D

var is_playing := false

func _ready() -> void:
	$music_player.volume_db = linear_to_db(globals.DEFAULT_MUSIC_VOLUME)
	$menu_root/game_menu.hide()
	
	globals.transition_to_level_started.connect(handle_level_transition_start)
	globals.transition_to_level_complete.connect(handle_level_transition)

func _process(delta: float) -> void:
	if is_playing:
		if Input.is_action_just_pressed("open_game_menu"):
			$menu_root/game_menu.show()

func handle_level_transition_start() -> void:
	if globals.current_scene == globals.LEVEL_1_PATH:
		is_playing = false

func handle_level_transition() -> void:
	if globals.current_scene == globals.LEVEL_1_PATH:
		play_start()
	else:
		is_playing = false

func play_start() -> void:
	is_playing = true

func return_to_menu() -> void:
	is_playing = false
	for level_scene in $current_level_root.get_children():
		$current_level_root.remove_child(level_scene)
		level_scene.queue_free()
		globals.current_scene = ""
	
	$menu_root/main_menu.show()
