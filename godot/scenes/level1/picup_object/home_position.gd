class_name HomePosition
extends Area2D



@onready var loose_pice: LoosePice = %LoosePice
@onready var color_rect: ColorRect = %ColorRect

var _attract :bool = true


func _physics_process(_delta: float) -> void:
	if _attract and loose_pice.attatched_to == null :
		loose_pice.lock_transform(transform)
	else :
		loose_pice.unlock()
 

func _on_body_exited(_body: Node2D) -> void:
	if not get_overlapping_bodies().has(loose_pice):
		print("exited: " , get_overlapping_bodies())
		color_rect.color  =Color.RED
		color_rect.color.a = .3
		_attract = false


func _on_body_entered(_body: Node2D) -> void:
	if get_overlapping_bodies().has(loose_pice):
		color_rect.color  =Color.TURQUOISE
		color_rect.color.a = .3
		_attract = true
