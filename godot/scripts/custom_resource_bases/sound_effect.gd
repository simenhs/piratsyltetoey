extends Resource
class_name SoundEffect

@export var name: String
@export var streams: Array[AudioStream]

func get_stream() -> AudioStream:
	if streams.size() == 0:
		printerr("attempt to fetch audio stream from sound effect with name " + name + ", but no streams are attached to it.")
		return null

	var index := globals.RNG.randi_range(0, streams.size() - 1)
	return streams[index]
