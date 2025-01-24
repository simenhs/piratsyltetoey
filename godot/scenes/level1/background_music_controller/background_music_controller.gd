extends Node

@export var move_zone : Area2D
@export var jump_zone : Area2D
@export var loose_objects : Array[LoosePice]

@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
var sync_player : AudioStreamSynchronized



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sync_player = audio_stream_player.stream
	play_help_move()
	move_zone.body_exited.connect(func (b): play_bg())
	jump_zone.body_entered.connect(func (b): play_help_jump())
	jump_zone.body_exited.connect(func (b): play_bg())
	
	for object in loose_objects: 
		object.player_nearby_enter.connect(play_help_pick_up)
		object.player_nearby_exit.connect( play_bg)
		object.picked_up.connect(play_help_throw)
		
	#move_zone.area_entered.connect(play_help_move)

func mute_steams():
	for i in sync_player.stream_count:
		sync_player.set_sync_stream_volume(i,-60)
		
func play_bg():
	mute_steams()
	sync_player.set_sync_stream_volume(0,0)
	
func play_melody1():
	play_bg()
	sync_player.set_sync_stream_volume(1,0)
	
func play_melody2():
	play_bg()
	sync_player.set_sync_stream_volume(2,0)

func play_melody3():
	play_bg()
	sync_player.set_sync_stream_volume(3,0)
	
func play_help_jump():
	play_bg()
	sync_player.set_sync_stream_volume(4,0)
	
func play_help_move():
	play_bg()
	sync_player.set_sync_stream_volume(5,0)
	
func play_help_pick_up():
	play_bg()
	sync_player.set_sync_stream_volume(6,0)
	
func play_help_throw():
	play_bg()
	sync_player.set_sync_stream_volume(7,0)
