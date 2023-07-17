extends CharacterBody2D

@export var speed = 150
enum {STATE_IDLE, STATE_WALK, STATE_B_H, STATE_G_H}
var state
var box_in_hand
var is_carrying = false
var shi

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ishik = 0
	Global.truek = 0
	if Global.press_start == 0:
		$anim.play("stay") # Replace with function body.
		state = STATE_IDLE
		is_carrying = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
var plx = 0
var ply = 0

func _process(delta):			
	
	if Input.is_action_pressed("box up"):
		if Global.kus != 0:
			Global.upin = 0
	if Global.press_start == 0:
		match state:
			STATE_IDLE:
				$anim.play("stay")
				velocity.x = 0
				velocity.y = 0			
				if Input.is_action_pressed("r") or \
					Input.is_action_pressed("l") or \
					Input.is_action_pressed("u") or \
					Input.is_action_pressed("d"):
					state = STATE_WALK
				else:
					state = STATE_IDLE
			STATE_WALK:
				if Global.shiftun != 0:
					if is_carrying:
						box_in_hand.position = position
					if Input.is_action_pressed("r") or Global.r == 1:
						velocity.x = speed*shi
						$anim.play("right")
						velocity.y = 0		
					elif Input.is_action_pressed("l") or Global.l == 1:
						velocity.x = -speed*shi
						$anim.play("left")
						velocity.y = 0
					elif Input.is_action_pressed("u") or Global.r == 1:
						velocity.y = -speed*shi
						$anim.play("up")
						velocity.x = 0
					elif Input.is_action_pressed("d") or Global.d == 1:
						velocity.y = speed*shi
						$anim.play("down")
						velocity.x = 0
					else:
						state = STATE_IDLE
				else:
					state = STATE_IDLE
		if Input.is_action_pressed("Shift"):
			shi = 1.25
		else:
			shi = 0.5
	elif Global.press_start == 2:
		$anim.play("stay")
	else:
		$anim.play("jump")
		if Global.ishik == 1:
			position.x = -471
			position.y = 432
		elif Global.ishik == 2:
			position.x = 0
			position.y = 432
		elif Global.ishik == 3:
			position.x = 465
			position.y = 432
		$anim.play("jump")
		await get_tree().create_timer(1).timeout
		if Global.truek == 1:
			get_tree().change_scene_to_file("res://box/победка.tscn")
		else:
			get_tree().change_scene_to_file("res://смерть.tscn")
		Global.press_start = 0
	move_and_slide()
	
	

		
