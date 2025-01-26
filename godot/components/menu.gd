extends Container

var loader = null
var is_playing := false

signal play_start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var res = ResourceLoader.load_threaded_get_status(globals.START_SCENE_PATH)
	if res == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		var scene_resource = ResourceLoader.load_threaded_get(globals.START_SCENE_PATH)
		var scene_instance = scene_resource.instantiate()
		globals.WORLD_ROOT.get_node("current_level_root").add_child(scene_instance)
		set_process(false)
		play_start.emit()

func play_pressed() -> void:
	loader = ResourceLoader.load_threaded_request(globals.START_SCENE_PATH)
	if loader != null:
		set_process(true)
	
	hide()

func quit_pressed() -> void:
	get_tree().quit()
