extends RigidBody2D

@onready var picup_area_2d: Area2D = %PicupArea2D

var attatched_to : Player = null

func _integrate_forces(state):
	if attatched_to != null:
		if global_position.distance_to(attatched_to.global_position) > 10 :
			apply_central_impulse(attatched_to.global_position.direction_to(global_position) * -700)    
				
				
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if attatched_to == null:
			for player in picup_area_2d.get_overlapping_bodies():
				if player is Player:
					attatched_to = player
		else :
			attatched_to = null
		
