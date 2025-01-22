@tool
class_name HomePosition
extends Area2D



@export var loose_pice: LoosePice 
@export var _id : String : set = set_id

@onready var color_rect: ColorRect = %ColorRect
@onready var home_name: Label = %HomeName

var _attract :bool = false


func _ready() -> void:
	set_id(_id)
	color_rect.color  =Color.RED
	color_rect.color.a = .3

func _physics_process(_delta: float) -> void:
	if is_instance_valid(loose_pice):
		if _attract and loose_pice.attatched_to == null :
			loose_pice.lock_transform(transform)
		else :
			loose_pice.unlock()
 

func _on_body_exited(_body: Node2D) -> void:
	if not get_overlapping_bodies().has(loose_pice):
		color_rect.color  =Color.RED
		color_rect.color.a = .3
		_attract = false


func _on_body_entered(_body: Node2D) -> void:
	if get_overlapping_bodies().has(loose_pice):
		color_rect.color  =Color.TURQUOISE
		color_rect.color.a = .3
		_attract = true

func set_id(value):
	_id = value
	if is_instance_valid(home_name):
		home_name.text = _id
