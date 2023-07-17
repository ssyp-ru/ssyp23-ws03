extends CharacterBody2D

@export var _name = "ЗАГЛУШКА"
@export var speed = 100
@export var years = 1.0
@export var time = 0
@export var want_eat = 0.0
@export var max_years = randf_range(37, 50)
@export var parent = 0

#установить имя организма, обновить Label с именем
func set_entity_name(nam):
	if nam == "ЗАГЛУШКА":
		_name = name
	else :
		_name = nam
	#$Name.text = _name
	
func init():
	#velocity = Vector2(randf_range(-speed, speed), randf_range(-speed, speed))
	time = 0

func move():
	pass
	
func update(delta):
	if Global.pause == 0:
		years += 0.01
		want_eat += 0.05
		$Label.text = str(years)
		$Label2.text = str(want_eat)
	#pass

func _ready():
	set_entity_name(_name)
	init()
	
func _process(delta):
	update(delta)

#func _on_timer_timeout():
	#years =+ 0.01
	#want_eat =+ 0.05
	#pass # Replace with function body.


