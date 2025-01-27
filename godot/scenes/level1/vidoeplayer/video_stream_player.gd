extends VideoStreamPlayer

signal done

var _has_finished := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _has_finished:
		return
	print(stream_position)
	if stream_position > 8.0: 
		paused = true
		var t = create_tween()
		t.tween_property(self,"modulate:a",0,0.5)
		t.tween_interval(0.5)
		t.tween_callback(animation_over)
		_has_finished = true
	
	
func animation_over():
	hide()
	done.emit()
