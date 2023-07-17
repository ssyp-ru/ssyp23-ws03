extends Camera2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up"):
		position.y -= 10
	if Input.is_action_pressed("down"):
		position.y += 10
	if Input.is_action_pressed("left"):
		position.x -= 10
	if Input.is_action_pressed("right"):
		position.x += 10
	

func _input(e):
	var camera = $Camera2D
	if e is InputEventMouseButton:
		if e.button_index ==  MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(0.1,0.1)
		if e.button_index ==  MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(0.1,0.1)
	
	# -*- coding: utf-8 -*-

# Создаем словарь экземпляров групп, куда будем записывать количество объектов каждой группы
#var groups = {}

