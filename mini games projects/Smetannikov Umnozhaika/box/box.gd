extends StaticBody2D

func _ready():
	pass
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Global.upin = 0




func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		Global.upin = 1

func  _process(delta):
	if $"t1r".text == str(Global.ke):
		Global.tru_ckash_box = 1
	else:
		Global.tp_crash = 1
	if Global.upin != 1:
		if Input.is_action_pressed("box up"):
			Global.press_start = 1
			if $"t1r".text == str(Global.ke):
				Global.truek = 1
			await get_tree().create_timer(0.5).timeout
			$".".position.y = 800
			Global.ishik = 1


