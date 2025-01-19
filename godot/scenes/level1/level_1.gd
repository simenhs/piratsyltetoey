extends Node

@onready var timer_label: Label = %TimerLabel
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event.is_action("quit"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = str(timer.time_left).pad_decimals(1)


func _on_timer_timeout() -> void:
	get_tree().paused = true
