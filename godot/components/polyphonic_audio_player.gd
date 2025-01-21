extends AudioStreamPlayer

@export var audio_library: AudioLibrary

func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	var level_scene = load("res://scenes/level1/level1.tscn").instantiate()
	$"../current_level_root".add_child(level_scene)

func play_sound(sound_name: String) -> bool:
	if sound_name:
		var audio_stream = audio_library.get_audio_stream(sound_name)
		if not audio_stream:
			printerr("failed to get audio stream from sound with name: " + sound_name)
			return false
		
		if not playing:
			self.play()
		
		var polyphonic_stream_playback := self.get_stream_playback()
		polyphonic_stream_playback.play_stream(audio_stream)
		return true
	else:
		printerr("soundname is invalid, cannot play sound effect.")
		return false
