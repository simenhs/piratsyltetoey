class_name HomePosition
extends Area2D



@onready var loose_pice: RigidBody2D = %LoosePice
@onready var color_rect: ColorRect = %ColorRect

var _attract :bool
var _ejecting : bool = false

func _physics_process(delta: float) -> void:
	if _attract and loose_pice.attatched_to == null :
		loose_pice.global_transform = global_transform 

#func _process(delta: float) -> void:
	#if get_overlapping_bodies().has(loose_pice):
		#color_rect.color  =Color.TURQUOISE
		#color_rect.color.a = .3
		#_attract = true
	#else : 
		#color_rect.color  =Color.RED
		#color_rect.color.a = .3
		#_attract = false

func eject():
	_attract = false
	_ejecting = true
	loose_pice.apply_central_impulse(Vector2(randf(),randf()) * -5000)  

func _on_body_exited(body: Node2D) -> void:
	if not get_overlapping_bodies().has(loose_pice):
		print("exited: " , get_overlapping_bodies())
		color_rect.color  =Color.RED
		color_rect.color.a = .3
		_attract = false


func _on_body_entered(body: Node2D) -> void:
	print("entered: " , get_overlapping_bodies())
	if _ejecting:
		_ejecting = false
		return
	
	if get_overlapping_bodies().has(loose_pice):
		color_rect.color  =Color.TURQUOISE
		color_rect.color.a = .3
		_attract = true
