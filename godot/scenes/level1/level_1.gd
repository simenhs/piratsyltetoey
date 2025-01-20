class_name Level1
extends Node

signal game_lost
signal game_won

var _game_won = false

@onready var timer_label: Label = %TimerLabel
@onready var timer: Timer = $Timer
@onready var win_label: Label = %WinLabel
@onready var loos_label: Label = %LoosLabel


func _input(event: InputEvent) -> void:
	if event.is_action("quit"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer_label.text = str(timer.time_left).pad_decimals(1)
	
	var all_objects_fixed = true
	for c in get_children():
		if c is PickupObject:
			if not c.is_fixed():
				all_objects_fixed = false
	
	if all_objects_fixed:
		game_won.emit()
		win_label.show()
		_game_won = true


func _on_timer_timeout() -> void:
	if not game_won:
		game_lost.emit()
		loos_label.show()
