extends StaticBody2D

func _ready():
	pass
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Global.upin2 = 0




func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		Global.upin2 = 1

func  _process(delta):
	if $"t3r".text == str(Global.ke):
		Global.tru_ckash_box = 3
	else:
		Global.tp_crash2 = 3
	if Global.upin2 != 1:
		if Input.is_action_pressed("box up"):
			Global.press_start = 1
			if $"t3r".text == str(Global.ke):
				Global.truek = 1
			await get_tree().create_timer(0.5).timeout
			$".".position.y = 800
			Global.ishik = 200
			Global.ishik = 3
	

