@tool
class_name PickupObject
extends Node2D

@export var display_name :String = "A" : set = set_displayname


@onready var home_name: Label = %HomeName
@onready var loose_pice_label: Label = %LoosePiceLabel
@onready var loose_pice: RigidBody2D = %LoosePice
@onready var home_position: HomePosition = %HomePosition


func _ready() -> void:
	set_displayname(display_name)
	eject()
	
func set_displayname(value):
	display_name = value
	if is_instance_valid(home_name):
		home_name.text = display_name
	if is_instance_valid(loose_pice_label):
		loose_pice_label.text = display_name


func eject():
	home_position.eject()
	
