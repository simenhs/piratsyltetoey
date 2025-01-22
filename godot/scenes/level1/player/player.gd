class_name Player
extends CharacterBody2D


const SPEED :float = 300.0
const JUMP_VELOCITY :float = -400.0
const SLIDE_DOWN_SPEED :float= 50
const DASH_SPEED :float= 10000
const DASH_COOLDOWN_TIME :float = 1

var dash_on_cooldown :bool = false
var facing_left : bool = false
var bounce_count : int = 0
var was_on_floor :bool
var bounsing = false


@onready var coyote_timer: Timer = %CoyoteTimer
@onready var jump_buffer_timer: Timer = %JumpBufferTimer
@onready var hand_position: Marker2D = %HandPosition

func _physics_process(delta: float) -> void:
	_move(delta)
	
	if is_on_floor():
		coyote_timer.start() # starts timer that allows the player to jump a short period after running of platform

	if not jump_buffer_timer.is_stopped() :
		if is_on_wall():
			wall_jump(delta)

		if is_on_floor():
			_bounce_jump(delta)

			
	if Input.is_action_just_pressed("jump"):
		if is_on_wall():
			wall_jump(delta)

		else:
			if not coyote_timer.is_stopped():
				_jump(delta)

			else :
				jump_buffer_timer.start()
			
	
	_fall_down(delta)
	
	
	if Input.is_action_just_pressed("dash"):
		_dash()
	move_and_slide()


func _jump(_delta : float):
	globals.play_sound("jump")
	velocity.y = JUMP_VELOCITY
	coyote_timer.stop()
	
		
		
func _bounce_jump(_delta : float):
	globals.play_sound("jump") #Todo: replace with bounce sound 
	print(velocity.y)
	velocity.y = JUMP_VELOCITY + JUMP_VELOCITY*0.1 *bounce_count
	bounce_count += 1 
	coyote_timer.stop()
	bounsing = true
	
	
func wall_jump(_delta:float):
	globals.play_sound("jump")
	velocity.y = JUMP_VELOCITY 
	velocity.x = -Input.get_axis("left", "right")
	coyote_timer.stop()
		
func _fall_down(delta : float):
	if not is_on_floor():
		bounsing = false
		velocity += get_gravity() * delta
		if is_on_wall() and (Input.is_action_pressed("left") or Input.is_action_pressed("right") ):
			if velocity.y > 0:
				velocity.y = SLIDE_DOWN_SPEED
				#TODO: slide on wall sound loop
	
	if is_on_floor() and not was_on_floor and not bounsing:
		_hit_floor()
	was_on_floor = is_on_floor()
		
		
func _hit_floor():
	bounce_count = 0
	globals.play_sound("hit_metal") # Todo: replase with landing sound 
	
		
func _move(delat: float) : 
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if facing_left !=  Input.is_action_pressed("left"):
			scale.x = -1
		facing_left =  Input.is_action_pressed("left")
		
	else:
		velocity.x =  move_toward(velocity.x, 0, SPEED*delat*5)
		velocity.x = clamp(velocity.x,-SPEED,SPEED)

func _dash():
	if not dash_on_cooldown :
		if facing_left: 
			velocity.x = -DASH_SPEED
		else : 
			velocity.x = DASH_SPEED
		dash_on_cooldown = true
		get_tree().create_timer(DASH_COOLDOWN_TIME).timeout.connect(_on_dash_cooldown_timeout)
		globals.play_sound("jump") #todo: replace with dash sound 


func _on_dash_cooldown_timeout():
	dash_on_cooldown = false

func get_global_hand_transform():
	return hand_position.global_transform
