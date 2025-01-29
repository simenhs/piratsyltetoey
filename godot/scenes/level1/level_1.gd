
class_name Level1
extends Node

signal game_lost
signal game_won

var _game_won = false

@onready var timer_label: Label = %TimerLabel
@onready var timer: Timer = $Timer
@onready var player: Player = %Player
@onready var intro_video_stream_player: VideoStreamPlayer = %IntroVideoStreamPlayer
@onready var win_outro_video_stream_player: VideoStreamPlayer = %WinOutroVideoStreamPlayer
@onready var lost_outro_video_stream_player: VideoStreamPlayer = %LostOutroVideoStreamPlayer
@onready var background_music_controller: BGMusicController = %BackgroundMusic_controller

#@onready var win_label: Label = %WinLabel
#@onready var loos_label: Label = %LoosLabel

func _ready() -> void:
	intro_video_stream_player.done.connect(on_intro_video_done)
	win_outro_video_stream_player.done.connect(on_outro_video_done)
	lost_outro_video_stream_player.done.connect(on_outro_video_done)
	#background_music_controller.play_intro()
	
func _input(event: InputEvent) -> void:
	if event.is_action("quit"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	timer_label.text = str(timer.time_left).pad_decimals(1)
	
	var all_objects_fixed = true
	for h in get_children():
		if h is HomePosition:
			if not h.objective_compleated():
				all_objects_fixed = false
	
	if all_objects_fixed or Input.is_action_just_pressed("cheat_win"):
		
		#globals.transition_to_scene(globals.ROUND_OVER_SCENE_PATH)
		if not _game_won:
			_game_won = true
			globals.game_won = true
			win_outro_video_stream_player.start()
			background_music_controller.play_outro_win()
		
		
	if Input.is_action_just_pressed("cheat_lose"):
		_on_timer_timeout()

	if timer.time_left < 15:
		timer_label.modulate = Color.RED	
	else : 
		timer_label.modulate = Color.WHITE

func _on_timer_timeout() -> void:
	if not _game_won:
		globals.game_won = false
		#globals.transition_to_scene(globals.ROUND_OVER_SCENE_PATH)
		lost_outro_video_stream_player.start()
		background_music_controller.play_outro_lose()
	
func on_intro_video_done():
	timer.start()
	player.start_playing()

func on_outro_video_done():
	globals.transition_to_scene(globals.ROUND_OVER_SCENE_PATH)
