class_name LoosePice
extends RigidBody2D

var _lock_transform : Transform2D 
var _locked := false
var attatched_to : Player = null


@onready var picup_area_2d: Area2D = %PicupArea2D
@onready var home_position: HomePosition = %HomePosition

func _integrate_forces(state):
	if attatched_to != null:
		if global_position.distance_to(attatched_to.global_position) > 10 :
			apply_central_impulse(attatched_to.global_position.direction_to(global_position) * -700)    

			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if attatched_to == null:
			print("overlap",picup_area_2d.get_overlapping_bodies())
			for player in picup_area_2d.get_overlapping_bodies():
				if player is Player:
					attatched_to = player
		else :
			attatched_to = null
		

func eject(force : Vector2):
	unlock()
	home_position._attract = false
	#
	apply_central_impulse(force)

func lock_transform(trans : Transform2D):
	transform = trans
	freeze = true

func unlock():
	freeze = false
