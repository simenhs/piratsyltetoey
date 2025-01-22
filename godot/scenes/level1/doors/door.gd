class_name Door
extends StaticBody2D

@onready var color_rect: ColorRect = %ColorRect
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D


func open():
	color_rect.color = Color.GREEN
	var tween = create_tween()
	tween.tween_property(color_rect,"color:a",0,1)
	collision_shape_2d.set_deferred("disabled", true)
	
func close():
	color_rect.color = Color.BLUE
	var tween = create_tween()
	tween.tween_property(color_rect,"color:a",1,1)
	collision_shape_2d.set_deferred("disabled", false)
