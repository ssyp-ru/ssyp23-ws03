extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") or Input.is_action_pressed("ui_up"):
		position.z -= 1 #/ zoom.y
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_pressed("ui_down"):
		position.z += 1 #/ zoom.y
	elif Input.is_action_just_pressed("ui_left") or Input.is_action_pressed("ui_left"):
		position.x -= 1 #/ zoom.x
	elif Input.is_action_just_pressed("ui_right") or Input.is_action_pressed("ui_right"):
		position.x += 1 #/ zoom.x
	

#func  _input(e):
	#if e is InputEventMouseButton:
	#	if e.button_index ==  MOUSE_BUTTON_WHEEL_UP:
	#		zoom += Vector2(0.1,0.1)
	#		#$PauseButton.size -= $PauseButton.size/10
			#$ButtonSpeedUp.scale += Vector2(0.1,0.1)
	#		#$"версия шаблона".scale += Vector2(0.1,0.1)
			#$PredatorBar.scale += Vector2(0.1,0.1)
			#$GrassEaterBar.scale += Vector2(0.1,0.1)
			#$PlantBar.scale += Vector2(0.1,0.1)
			#$FoodBar.scale += Vector2(0.1,0.1)
	#	if e.button_index ==  MOUSE_BUTTON_WHEEL_DOWN:
	#		zoom -= Vector2(0.1,0.1)
			#$PauseButton.size += $PauseButton.size/10
			#$ButtonSpeedUp.scale -= Vector2(0.1,0.1)
			#$"версия шаблона".scale -= Vector2(0.1,0.1)
			#$PredatorBar.scale -= Vector2(0.1,0.1)
			#$GrassEaterBar.scale -= Vector2(0.1,0.1)
			#$PlantBar.scale -= Vector2(0.1,0.1)
			#$FoodBar.scale -= Vector2(0.1,0.1)

			
