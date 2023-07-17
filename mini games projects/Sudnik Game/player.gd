extends CharacterBody2D

#var velocity = Vector2(0, 0)
var bullet = preload("res://bullet.tscn")

func _physics_process(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -500
	if Input.is_action_pressed("ui_down"):
		velocity.y = 500
	if Input.is_action_pressed("ui_left"):
		velocity.x = -500
	if Input.is_action_pressed("ui_right"):
		velocity.x = 500
	
	look_at(get_global_mouse_position())
	move_and_slide()
