@tool
class_name HomePosition
extends Area2D



@export var loose_pice: LoosePice 
@export var _id : String : set = set_id
@export var _texture :Texture2D : set = set_texture

var _attract :bool = false

#@onready var color_rect: ColorRect = %ColorRect
@onready var home_name: Label = %HomeName
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	set_id(_id)
	set_texture(_texture)
	modulate  =Color.RED
	modulate.a = .3

func _physics_process(_delta: float) -> void:
	if is_instance_valid(loose_pice):
		if _attract and loose_pice.attatched_to == null :
			loose_pice.lock_transform(transform)
		else :
			loose_pice.unlock()
 

func _on_body_exited(_body: Node2D) -> void:
	if not get_overlapping_bodies().has(loose_pice):
		modulate  =Color.RED
		modulate.a = .3
		_attract = false


func _on_body_entered(_body: Node2D) -> void:
	if get_overlapping_bodies().has(loose_pice):
		modulate  =Color.TURQUOISE
		modulate.a = .3
		_attract = true

func set_id(value):
	_id = value
	if is_instance_valid(home_name):
		home_name.text = _id

func set_texture(value):
	_texture = value
	if is_instance_valid(sprite_2d):
		sprite_2d.texture = _texture
