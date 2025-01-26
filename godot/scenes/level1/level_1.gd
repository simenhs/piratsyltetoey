class_name Level1
extends Node

signal game_lost
signal game_won

var _game_won = false

@onready var timer_label: Label = %TimerLabel
@onready var timer: Timer = $Timer
#@onready var win_label: Label = %WinLabel
#@onready var loos_label: Label = %LoosLabel
@onready var temp_end_screen: AnimatedSprite2D = %TempEndScreen


func _input(event: InputEvent) -> void:
	if event.is_action("quit"):
		get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	timer_label.text = str(timer.time_left).pad_decimals(1)
	
	var all_objects_fixed = true
	for h in get_children():
		if h is HomePosition:
			if not h.objective_compleated():
				all_objects_fixed = false
	
	if all_objects_fixed:
		game_won.emit()
		#win_label.show()
		if not _game_won:
			temp_end_screen.show()
			temp_end_screen.play("Win")
			_game_won = true


func _on_timer_timeout() -> void:
	if not _game_won:
		game_lost.emit()
		#loos_label.show()
		temp_end_screen.show()
		temp_end_screen.play("Lose")
