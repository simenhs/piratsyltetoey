extends Node

func _ready() -> void:
	do_transition()

func _process(delta: float) -> void:
	pass

func do_transition() -> void:
	# Put movie code here
	globals.transition_to_scene(globals.LEVEL_1_PATH)
