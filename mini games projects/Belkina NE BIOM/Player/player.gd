extends CharacterBody2D

var speed : float = 200.0
var state = "idle"
var anim_player
var is_flipped = false

@export var moveup: String = "ui_up"
@export var moveleft: String = "left"
@export var moveright: String = "right"
@export var number: String = "1"


	
	
func _ready(): 
	anim_player = $AnimatedSprite2D
	
	


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		#anim_player.play("jump_2")
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_pressed(moveup) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#anim_player.play("jump_1")
		anim_player.flip_h = false


	var direction = Input.get_axis(moveleft, moveright)
	if direction:
		velocity.x = direction * SPEED
		if direction == 1:
			anim_player.flip_h = true
		
		else:
			anim_player.flip_h = false                                                                        		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#в воздухе
	if not is_on_floor():
		if velocity.y < 0:
			anim_player.play("jump_up")
		else:
			anim_player.play("jump_down")
	else: #на земле
		if velocity.x == 0:
			anim_player.play("idle")
		else:
			anim_player.play("run")
	
		
		
	move_and_slide()
	
func desd():
	position = Vector2(53, 560)
