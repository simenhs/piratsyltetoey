class_name BGMusicController
extends Node

@export var move_zone : Area2D
@export var jump_zone : Area2D
@export var loose_objects : Array[LoosePice]
@export var hold_e_down_zone :Area2D

@onready var audio_stream_player: AudioStreamPlayer
var sync_player : AudioStreamSynchronized

var playing_bg = false
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player = globals.WORLD_ROOT.get_node("music_player")
	sync_player = audio_stream_player.stream
	play_intro()
	move_zone.body_entered.connect(func (_b): play_help_move())
	move_zone.body_exited.connect(func (_b): play_bg())
	jump_zone.body_entered.connect(func (_b): play_help_jump())
	jump_zone.body_exited.connect(func (_b): play_bg())
	hold_e_down_zone.body_entered.connect(func (_b): play_help_throw())
	hold_e_down_zone.body_exited.connect(func (_b): play_bg())
	
	for object in loose_objects: 
		object.player_nearby_enter.connect(play_help_pick_up)
		object.player_nearby_exit.connect( play_bg)
		object.picked_up.connect(play_bg)
		
	#move_zone.area_entered.connect(play_help_move)


func mute_steams():
	for i in sync_player.stream_count:
		sync_player.set_sync_stream_volume(i,-60)
		
func play_bg():
	if game_over:
		return
	mute_steams()
	sync_player.set_sync_stream_volume(0,0)
	playing_bg = true
	
func play_melody1():
	if game_over:
		return
	play_bg()
	sync_player.set_sync_stream_volume(1,0)
	
	
func play_melody2():
	if game_over:
		return
	play_bg()
	sync_player.set_sync_stream_volume(2,0)

func play_melody3():
	if game_over:
		return
	play_bg()
	sync_player.set_sync_stream_volume(3,0)
	
func play_help_jump():
	if game_over:
		return
	play_bg()
	sync_player.set_sync_stream_volume(4,0)
	playing_bg = false
	
func play_help_move():
	if game_over:
		return
		
	play_bg()
	sync_player.set_sync_stream_volume(5,0)
	playing_bg = false
	
func play_help_pick_up():
	if game_over:
		return
	play_bg()
	sync_player.set_sync_stream_volume(6,0)
	playing_bg = false
	
func play_help_throw():
	if game_over:
		return
	play_bg()
	sync_player.set_sync_stream_volume(7,0)
	playing_bg = false

func play_intro():
	if game_over:
		return
	#play_bg()
	audio_stream_player.play(0)
	mute_steams()
	sync_player.set_sync_stream_volume(8,0)
	
func play_outro_lose():
	if game_over:
		return
	audio_stream_player.play(0)
	play_bg()
	playing_bg = false
	sync_player.set_sync_stream_volume(10,0)
	game_over = true
	
	
func play_outro_win():
	if game_over:
		return
	audio_stream_player.play(0)
	play_bg()
	playing_bg = false
	sync_player.set_sync_stream_volume(9,0)
	game_over = true
	
func _on_timer_timeout() -> void:
	if playing_bg:
		if randf() < 0.5:
			var pick = randi_range(0,2)
			match pick:
				1: 
					play_melody1()
				2: 
					play_melody2()
				3: 
					play_melody3()
		else :
			play_bg()
