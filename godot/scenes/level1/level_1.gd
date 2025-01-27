class_name Level1
extends Node

signal game_lost
signal game_won

var _game_won = false

@onready var timer_label: Label = %TimerLabel
@onready var timer: Timer = $Timer
@onready var player: Player = %Player
@onready var video_stream_player: VideoStreamPlayer = %VideoStreamPlayer

#@onready var win_label: Label = %WinLabel
#@onready var loos_label: Label = %LoosLabel

func _ready() -> void:
	video_stream_player.done.connect(on_intro_video_done)
	


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
	
	if all_objects_fixed:
		globals.game_won = true
		globals.transition_to_scene(globals.ROUND_OVER_SCENE_PATH)


func _on_timer_timeout() -> void:
	globals.game_won = false
	globals.transition_to_scene(globals.ROUND_OVER_SCENE_PATH)

func on_intro_video_done():
	timer.start()
	player.start_playing()
