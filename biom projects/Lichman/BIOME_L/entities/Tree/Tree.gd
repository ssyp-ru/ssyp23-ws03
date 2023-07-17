extends "res://entities/plant/Plant.gd"

func update(delta):
	$AnimatedSprite2D.play("Tree")
	if Global.pause == 0:
		if years > randf_range(5, 20) and years < randf_range(45, 70) and parent < 1:
					get_parent().add_child(load("res://entities/Tree/Tree.tscn").instantiate())
					parent += 1
					Global.sleep(3)
		update2(delta)
		if years > 3:
			scale.x = int(years / 3)
			scale.y = int(years / 3)

func _on_area_2d_body_entered(body):
	if body.name == "Food":
		want_eat -= 5.0		
		body.queue_free()
