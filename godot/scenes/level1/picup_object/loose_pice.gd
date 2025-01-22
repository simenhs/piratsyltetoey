@tool
class_name LoosePice
extends RigidBody2D

@export var _id : String : set = set_id

var _lock_transform : Transform2D 
var _locked := false
var attatched_to : Player = null


@onready var picup_area_2d: Area2D = %PicupArea2D
#@onready var home_position: HomePosition = %HomePosition
@onready var loose_pice_label: Label = %LoosePiceLabel

func _ready() -> void:
	set_id(_id)

func _integrate_forces(state):
	if attatched_to != null:
		#if global_position.distance_to(attatched_to.global_position) > 10 :
			#apply_central_impulse(attatched_to.global_position.direction_to(global_position) * -700)   
		freeze_mode = FreezeMode.FREEZE_MODE_KINEMATIC
		freeze = true
		global_transform = attatched_to.get_global_hand_transform()
	else :
		freeze = false 

			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if attatched_to == null:
			print("overlap",picup_area_2d.get_overlapping_bodies())
			for player in picup_area_2d.get_overlapping_bodies():
				if player is Player:
					attatched_to = player
					globals.play_sound("pickup")
					sleeping = false
		else :
			attatched_to = null
			_throw()
func _throw():
	globals.play_sound("throw")
	if rotation > PI/2:
		apply_central_impulse(Vector2(-300,-300))
	else : 
		apply_central_impulse(Vector2(300,-300))	

#func eject(force : Vector2):
	#unlock()
	#home_position._attract = false
	##
	#apply_central_impulse(force)

func lock_transform(trans : Transform2D):
	transform = trans
	freeze = true

func unlock():
	freeze = false

func set_id(value):
	_id = value
	if is_instance_valid(loose_pice_label):
		loose_pice_label.text = _id
