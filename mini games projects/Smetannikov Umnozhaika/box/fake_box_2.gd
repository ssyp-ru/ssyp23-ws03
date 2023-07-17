extends StaticBody2D

func _ready():
	pass
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Global.kus = 1




func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		Global.kus = 0

func  _process(delta):
	if Global.upin != 1:
		if Input.is_action_pressed("box up"):
			$".".position.y = 800
	else:
		pass
