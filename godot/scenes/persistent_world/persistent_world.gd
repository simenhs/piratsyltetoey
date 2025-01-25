extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var level_scene = load("res://scenes/level1/level1.tscn").instantiate()
	$current_level_root.add_child(level_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
