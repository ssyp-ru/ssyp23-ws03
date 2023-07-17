extends "res://entities/animal/Animal.gd"

#func init():
#	add_to_group("Humans")

func update(delta):
	$Camera2D.zoom.x = Global.zoom
	$Camera2D.zoom.y = Global.zoom
	velocity = Vector2(0, 0)
	if Input.is_action_pressed("ui_down"):
		velocity.y = 10000 * delta
	if Input.is_action_pressed("ui_up"):
		velocity.y = -10000 * delta
	if Input.is_action_pressed("ui_right"):
		velocity.x = 10000 * delta
	if Input.is_action_pressed("ui_left"):
		velocity.x = -10000 * delta
	#if position.x > 1100:
	#	position.x -= 10
	if position.x < 50:
		position.x += 10
	#if position.y > 600:
		#position.y -= 10
	if position.y < 50:
		position.y += 10
	move()
