extends Camera2D

var swipe = ''
const SWIPE_SPEED = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") or Input.is_action_pressed("ui_up"):
		position.y -= 20 / zoom.y
	elif Input.is_action_just_pressed("ui_down") or Input.is_action_pressed("ui_down"):
		position.y += 20 / zoom.y
	elif Input.is_action_just_pressed("ui_left") or Input.is_action_pressed("ui_left"):
		position.x -= 20 / zoom.x
	elif Input.is_action_just_pressed("ui_right") or Input.is_action_pressed("ui_right"):
		position.x += 20 / zoom.x
		
		
	if swipe && swipe != 'swiped': # Если обнаружен новый свайп и он ещё не обработан
		if swipe == 'up': # Если свайпнули вверх и объект на плоскости (поверхности)
			print("up")
			position.y += SWIPE_SPEED
		elif swipe == "down":
			print("down")
			position.y -= SWIPE_SPEED # Меняем скорость падения на константу, и вуаля - объект прыгает
		elif swipe == 'left':
			print("left")
			position.x += SWIPE_SPEED
		elif swipe == "right":
			print("right")
			position.x -= SWIPE_SPEED # Если свайпнули влево или вправо # Плавно изменяем значение положения текущего объекта # Берем его текущее положение, прибавляем к нему вектор с некоторым значением по X. Оно рассчитывается исходя из направления свайпа. -2 если влево, иначе 2
		swipe = 'swiped'
	
	

	

func  _input(e):
	if e is InputEventMouseButton:
		if e.button_index ==  MOUSE_BUTTON_WHEEL_UP:
			if zoom < Vector2(2,2):
				zoom += Vector2(0.1,0.1)
		if e.button_index ==  MOUSE_BUTTON_WHEEL_DOWN:
			if zoom >= Vector2(0.6,0.6):
				zoom -= Vector2(0.1,0.1)
				
				
	if e is InputEventScreenDrag: # Проверяем, что событие именно движение пальца по экрану
		if !swipe: # Если в данный момент свайп не производится
			if e.relative.y < -SWIPE_SPEED: # Проверяем скорость движения пальца по оси Y
				swipe = 'up'
			elif e.relative.y < SWIPE_SPEED:
				swipe = "down" # и если она меньше (потому что вверх идет на уменьшение) отрицательной скорости свайпа (что переводится, как если она больше или равна необходимой для учета свайпа), то устанавливаем свайп как "вверх (UP)"
			elif e.relative.x < -SWIPE_SPEED: # Если палец идет по другой траектории, то проверяем уже ось X. Если палец двигается влево - то влево
				swipe = 'left'
			elif e.relative.x > SWIPE_SPEED: # Если вправо,
				swipe = 'right' # то вправо
	elif e is InputEventScreenTouch: # Затем обработаем событие отпускания экрана
		if !e.pressed: # Когда игрок убирает палец с экрана
			swipe = ''

			
