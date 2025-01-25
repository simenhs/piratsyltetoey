extends AudioStreamPlayer

@export var audio_library: AudioLibrary

var looping_streams: Dictionary

func _ready() -> void:
	stream = AudioStreamPolyphonic.new()
	var level_scene = load("res://scenes/level1/level2.tscn").instantiate()
	$"../current_level_root".add_child(level_scene)

func _process(_delta: float) -> void:
	if not playing:
		self.play()

	var polyphonic_stream_playback := self.get_stream_playback()
	for key in looping_streams:
		if not polyphonic_stream_playback.is_stream_playing(looping_streams[key][0]):
			looping_streams[key][0] = polyphonic_stream_playback.play_stream(looping_streams[key][1])

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

func play_sound_looping(sound_name: String, key: String) -> bool:
	if sound_name:
		var audio_stream = audio_library.get_audio_stream(sound_name)
		if not audio_stream:
			printerr("failed to get audio stream from sound with name: " + sound_name)
			return false
		
		if not playing:
			self.play()
		
		var polyphonic_stream_playback := self.get_stream_playback()
		var play_id = polyphonic_stream_playback.play_stream(audio_stream)
		looping_streams[key] = [play_id, audio_stream]
		return true
	else:
		printerr("soundname is invalid, cannot play sound effect.")
		return false

func stop_sound_looping(key: String) -> bool:
	var looping_stream_meta = looping_streams.get(key)
	if not looping_stream_meta:
		printerr("no sound is currently looping for key: " + key)
		return false
		
	var polyphonic_stream_playback := self.get_stream_playback()
	polyphonic_stream_playback.stop_stream(looping_stream_meta[0])
	looping_streams.erase(key)
	return true
