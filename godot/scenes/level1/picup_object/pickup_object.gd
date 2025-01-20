@tool
class_name PickupObject
extends Node2D

@export var display_name :String = "A" : set = set_displayname
@export var ejection_force : Vector2 = Vector2(300,300)
@export var ejection_delay : float = 0

var _is_ejected = false

@onready var home_name: Label = %HomeName
@onready var loose_pice_label: Label = %LoosePiceLabel
@onready var loose_pice: LoosePice = %LoosePice
@onready var home_position: HomePosition = %HomePosition



func _ready() -> void:
	set_displayname(display_name)
	get_tree().create_timer(ejection_delay).timeout.connect(eject)
	
func set_displayname(value):
	display_name = value
	if is_instance_valid(home_name):
		home_name.text = display_name
	if is_instance_valid(loose_pice_label):
		loose_pice_label.text = display_name

#func _input(event: InputEvent) -> void:
	#if event.is_action("jump"):
		#eject()

func eject():
	loose_pice.eject(ejection_force)
	await get_tree().create_timer(.5).timeout
	_is_ejected = true
	
func is_fixed ()-> bool:
	var coorect_pos = loose_pice.position == home_position.position
	 
	return coorect_pos and _is_ejected
