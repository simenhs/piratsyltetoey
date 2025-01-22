class_name DoorButton
extends StaticBody2D


@export var door : Door

@onready var trigger: Area2D = %Trigger
@onready var color_rect: ColorRect = %ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.color = Color.BLUE



func _on_trigger_body_entered(body: Node2D) -> void:
	if scale.y > 0.5: 
		var tween = create_tween()
		tween.tween_property(self,"scale:y",0.5,1)
	color_rect.color = Color.GREEN
	door.open()


func _on_trigger_body_exited(body: Node2D) -> void:
	if trigger.get_overlapping_bodies().size() ==  0 :
		var tween = create_tween()
		tween.tween_property(self,"scale:y",1,1)
	color_rect.color = Color.BLUE
	door.close()
