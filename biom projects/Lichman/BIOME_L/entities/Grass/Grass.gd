extends "res://entities/plant/Plant.gd"

func init():
	$AnimatedSprite2D.play("Grass")
	add_to_group("grass")
	position = Vector2(randf_range(10, 1100), randf_range(10, 600))
	max_years = randf_range(5, 10)
	max_want_eat = randf_range(10, 50)

func _on_area_2d_body_entered(body):
	if body.name == "Food":
		want_eat -= 5.0		
		body.queue_free()
	if body.name == "Goat":
		death()

func update(delta):
	if Global.pause == 0:
		if years > randf_range(5, 10) and years < randf_range(60, 70) and parent < 2 and want_eat < 10:
			get_parent().add_child(load("res://entities/Grass/Grass.tscn").instantiate())
			parent += 1
		update2(delta)
		if years > 2:
			scale.x = int(years / 2)
			scale.y = int(years / 2)
