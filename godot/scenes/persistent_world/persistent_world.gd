extends Node2D

var is_playing := false

func _ready() -> void:
	$music_player.volume_db = linear_to_db(globals.DEFAULT_MUSIC_VOLUME)
	$menu_root/main_menu.play_start.connect(play_start)
	$menu_root/game_menu.quit_to_main_menu_signal.connect(return_to_menu)
	$menu_root/game_menu.hide()

func _process(delta: float) -> void:
	if is_playing:
		if Input.is_action_just_pressed("open_game_menu"):
			$menu_root/game_menu.show()

func play_start() -> void:
	is_playing = true

func return_to_menu() -> void:
	is_playing = false
	for level_scene in $current_level_root.get_children():
		$current_level_root.remove_child(level_scene)
		level_scene.queue_free()
	
	$menu_root/main_menu.show()
