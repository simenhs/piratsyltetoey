extends Resource
class_name AudioLibrary

@export var sound_effects: Array[SoundEffect]

func get_audio_stream(name: String) -> AudioStream:
	var index := -1
	
	if name:
		for sound_effect in sound_effects:
			index += 1
			
			if name == sound_effect.name:
				return sound_effects[index].get_stream()
	else:
		printerr("sound name was empty or null, cannot fetch audio stream.")
		return null

	printerr("no sound found with name: " + name)
	return null
