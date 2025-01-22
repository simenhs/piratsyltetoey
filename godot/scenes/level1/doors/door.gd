@tool
class_name Door
extends StaticBody2D

@export var _texture : Texture2D : set = set_texture

var colisionshape :CollisionShape2D


#@onready var color_rect: ColorRect = %ColorRect
#@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var sprite_2d: Sprite2D = %Sprite2D

func _ready() -> void:
	set_texture(_texture)
	for c in get_children():
		if c is CollisionShape2D:
			colisionshape = c
	

func open():
	modulate = Color.GREEN
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",0,1)
	colisionshape.set_deferred("disabled", true)
	
func close():
	modulate = Color.WHITE
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",1,1)
	colisionshape.set_deferred("disabled", false)

func set_texture(value): 
	_texture = value
	if is_instance_valid(sprite_2d):
		sprite_2d.texture = _texture
