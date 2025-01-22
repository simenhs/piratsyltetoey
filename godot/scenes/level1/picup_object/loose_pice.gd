@tool
class_name LoosePice
extends RigidBody2D

@export var _id : String : set = set_id
@export var _texture : Texture2D : set = set_texture

var _lock_transform : Transform2D 
var _locked := false
var attatched_to : Player = null : set = set_attached_to
var _spaw_position : Transform2D 


@onready var picup_area_2d: Area2D = %PicupArea2D
#@onready var home_position: HomePosition = %HomePosition
@onready var loose_pice_label: Label = %LoosePiceLabel
@onready var sprite_2d: Sprite2D = %Sprite2D 

func _ready() -> void:
	set_id(_id)
	set_texture(_texture)
	_spaw_position = transform

func _integrate_forces(state):
	if attatched_to != null:
		#if global_position.distance_to(attatched_to.global_position) > 10 :
			#apply_central_impulse(attatched_to.global_position.direction_to(global_position) * -700)   
		#freeze_mode = FreezeMode.FREEZE_MODE_KINEMATIC
		#freeze = true
		global_transform = attatched_to.get_global_hand_transform()
	#else :
		#freeze = false 

			
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


func _on_body_entered(body: Node) -> void:
	globals.play_sound("hit_metal") #todo detect hitd ting floor or walls 

func set_attached_to(value):
	if value == null:
		if is_instance_valid(attatched_to):
			attatched_to.drop_items.disconnect(respawn)
		attatched_to = value
	else : 
		attatched_to = value
		attatched_to.drop_items.connect(respawn)
		

func respawn():
	#freeze_mode = FreezeMode.FREEZE_MODE_KINEMATIC
	#freeze = true
	#position = _spaw_position
	attatched_to = null
	PhysicsServer2D.body_set_state(self, PhysicsServer2D.BODY_STATE_TRANSFORM, _spaw_position)
	
func set_texture(value): 
	_texture = value
	if is_instance_valid(sprite_2d):
		sprite_2d.texture = _texture
	
