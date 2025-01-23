@tool
class_name LoosePice
extends RigidBody2D

const MAX_THROW_CHARGE_TIME : float =1.5

@export var _id : String : set = set_id
@export var _texture : Texture2D : set = set_texture
@export var _throw_power : float = 300

#var _lock_transform : Transform2D 
#var _locked := false
var attatched_to : Player = null : set = set_attached_to
var _spaw_position : Transform2D 
var _throw_charge : float = 0
var _charging_throw := false

@onready var picup_area_2d: Area2D = %PicupArea2D
#@onready var home_position: HomePosition = %HomePosition
@onready var loose_pice_label: Label = %LoosePiceLabel
@onready var sprite_2d: Sprite2D = %Sprite2D 

func _ready() -> void:
	set_id(_id)
	set_texture(_texture)
	_spaw_position = transform

func _process(delta: float) -> void:
	
	if _charging_throw:
		_throw_charge += delta
		_throw_charge = clamp(_throw_charge,0,MAX_THROW_CHARGE_TIME)
	
		if Input.is_action_just_released("use") :
			_throw(_throw_charge)
			_charging_throw = false
			_throw_charge = 0
			globals.stop_sound_looping("charging_throw_key")
			
			
	if is_instance_valid(attatched_to):
		freeze = true
		global_transform = attatched_to.get_global_hand_transform()
	else :
		freeze = false
			
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		if attatched_to == null:
			for player in picup_area_2d.get_overlapping_bodies():
				if player is Player:
					attatched_to = player
					globals.play_sound("pickup")
					#sleeping = false
		else: 
			_charging_throw = true
			globals.play_sound_looping("wall_slide", "charging_throw_key")

			
func _throw(charge : float):
	freeze = false
	
	globals.play_sound("throw")
	var throw_vect = Vector2(1,-1) * charge*_throw_power #+ Vector2(0,-1000)
	if attatched_to.facing_left:
		throw_vect.x *= -1
	attatched_to = null	
	apply_central_impulse(throw_vect)
	

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


func _on_body_entered(_body: Node) -> void:
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
	
