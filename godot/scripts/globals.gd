extends Node

var RNG = RandomNumberGenerator.new()
var WORLD_ROOT = null
var DEFAULT_MUSIC_VOLUME := 1.0

var TRANSITION_TO_GAMEPLAY_SCENE_PATH := "res://scenes/start_play_transition/start_play_transition.tscn"
var ROUND_OVER_SCENE_PATH := "res://scenes/round_over_transition/round_over_transition.tscn"
var LEVEL_1_PATH := "res://scenes/level1/level2.tscn"

var loader = null
var current_scene: String
var game_won: bool = false

signal transition_to_level_complete

func _ready():
	set_process(false)
	RNG.seed = hash("tosiso")
	WORLD_ROOT = get_tree().root.get_node("persistent_world")

func _process(delta: float) -> void:
	var res = ResourceLoader.load_threaded_get_status(current_scene)
	if res == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		var scene_resource = ResourceLoader.load_threaded_get(current_scene)
		var scene_instance = scene_resource.instantiate()
		
		set_process(false)
		
		globals.WORLD_ROOT.get_node("current_level_root").add_child(scene_instance)
		
		transition_to_level_complete.emit()

func return_to_main_menu() -> void:
	WORLD_ROOT.return_to_menu()

func transition_to_scene(new_scene_path: String) -> void:
	for level_scene in WORLD_ROOT.get_node("current_level_root").get_children():
		WORLD_ROOT.get_node("current_level_root").remove_child(level_scene)
		level_scene.queue_free()
	loader = ResourceLoader.load_threaded_request(new_scene_path)
	if loader != null:
		set_process(true)
		current_scene = new_scene_path

func play_sound(sound_name: String) -> bool:
	if not sound_name:
		printerr("sound_name was invalid or empty, cannot play sound.")
		return false

	var audio_player : AudioStreamPlayer= WORLD_ROOT.get_node("polyphonic_audio_player")
	if not audio_player:
		printerr("failed to get audio player node, scene tree likely borked!")
		return false
	
	
	var success: bool = audio_player.play_sound(sound_name)
	return success

func play_sound_looping(sound_name: String, key: String) -> bool:
	if not sound_name:
		printerr("sound_name was invalid or empty, cannot play sound.")
		return false

	var audio_player = WORLD_ROOT.get_node("polyphonic_audio_player")
	if not audio_player:
		printerr("failed to get audio player node, scene tree likely borked!")
		return false
	
	var success: bool = audio_player.play_sound_looping(sound_name, key)
	return success

func stop_sound_looping(key: String) -> bool:
	var audio_player = WORLD_ROOT.get_node("polyphonic_audio_player")
	if not audio_player:
		printerr("failed to get audio player node, scene tree likely borked!")
		return false
	
	var success: bool = audio_player.stop_sound_looping(key)
	return success
