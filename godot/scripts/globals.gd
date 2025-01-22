extends Node

var RNG = RandomNumberGenerator.new()
var WORLD_ROOT = null

func _ready():
	RNG.seed = hash("tosiso")
	WORLD_ROOT = get_tree().root.get_node("persistent_world")
	print(WORLD_ROOT.name)

func play_sound(sound_name: String) -> bool:
	if not sound_name:
		printerr("sound_name was invalid or empty, cannot play sound.")
		return false

	var audio_player = WORLD_ROOT.get_node("polyphonic_audio_player")
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
