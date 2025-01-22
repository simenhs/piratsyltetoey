class_name DoorButton
extends StaticBody2D


@export var door : Door

@onready var trigger: Area2D = %Trigger
@onready var color_rect: ColorRect = %ColorRect
@onready var button_sprite: Sprite2D = %ButtonSprite
@onready var button_pressed_sprite: Sprite2D = %ButtonPressedSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.color = Color.BLUE



func _on_trigger_body_entered(_body: Node2D) -> void:
	#if scale.y > 0.5: 
		#var tween = create_tween()
		#tween.tween_property(self,"scale:y",0.5,1)
	modulate = Color.GREEN
	button_sprite.hide()
	button_pressed_sprite.show()
	door.open()


func _on_trigger_body_exited(_body: Node2D) -> void:
	if trigger.get_overlapping_bodies().size() ==  0 :
		#var tween = create_tween()
		#tween.tween_property(self,"scale:y",1,1)
		modulate = Color.WHITE
		button_sprite.show()
		button_pressed_sprite.hide()
		door.close()
