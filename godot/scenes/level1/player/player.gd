extends CharacterBody2D


const SPEED :float = 300.0
const JUMP_VELOCITY :float = -400.0
const SLIDE_DOWN_SPEED :float= 50
const DASH_SPEED :float= 10000
const DASH_COOLDOWN_TIME :float = 1

var dash_on_cooldown :bool = false
var facing_left : bool = false


@onready var coyote_timer: Timer = %CoyoteTimer

func _physics_process(delta: float) -> void:
	_move(delta)
	
	if is_on_floor():
		coyote_timer.start() # starts timer that allows the player to jump a short period after running of platform
	if Input.is_action_just_pressed("jump"):
		_jump(delta)
	
	_fall_down(delta)
	
	
	if Input.is_action_just_pressed("dash"):
		_dash()
	move_and_slide()


func _jump(delta : float):
	
	if not coyote_timer.is_stopped():
		velocity.y = JUMP_VELOCITY
		coyote_timer.stop()
	
	if is_on_wall():
		velocity.y = JUMP_VELOCITY 
		velocity.x = -Input.get_axis("left", "right")
		
func _fall_down(delta : float):
	if not is_on_floor():
		velocity += get_gravity() * delta
		if is_on_wall() and (Input.is_action_pressed("left") or Input.is_action_pressed("right") ):
			if velocity.y > 0:
				velocity.y = SLIDE_DOWN_SPEED
		
	
		
func _move(delat: float) : 
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
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


func _on_dash_cooldown_timeout():
	dash_on_cooldown = false
