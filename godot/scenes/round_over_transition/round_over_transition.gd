extends Node


@onready var temp_end_screen: AnimatedSprite2D = %TempEndScreen

func _ready() -> void:
	$Container/panel_win.hide()
	$Container/panel_loose.hide()
	%TempEndScreen.show()
	if globals.game_won:
		game_won()
	else:
		game_lost()

func _process(delta: float) -> void:
	pass

func do_transition() -> void:
	# Put movie code here
	pass

func game_won() -> void:
	temp_end_screen.show()
	temp_end_screen.play("Win")

func game_lost() -> void:
	temp_end_screen.show()
	temp_end_screen.play("Lose")

func animation_finished() -> void:
	%TempEndScreen.hide()
	if globals.game_won:
		$Container/panel_win.show()
	else:
		$Container/panel_loose.show()

func try_again() -> void:
	globals.transition_to_scene(globals.LEVEL_1_PATH)
	
func return_to_menu() -> void:
	globals.return_to_main_menu()
