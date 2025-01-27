extends VideoStreamPlayer

signal done

var _running = false

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if not _running :
		return
		
	if stream_position >= 8.5:
		paused = true
		
		#var t  = create_tween()
		#t.tween_callback(done.emit)
		hide()
		done.emit()
		_running = false
	
func start():
	show()
	play()
	var t = create_tween()
	modulate.a = 0
	t.tween_property(self,"modulate:a",1,0.5)
	_running = true 
	
