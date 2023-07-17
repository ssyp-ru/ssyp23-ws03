extends "res://entities/organism/Organism.gd"

func init():
	add_to_group("plants")
	position = Vector2(randf_range(10, 1100), randf_range(10, 600))
	max_years = randf_range(25, 80)
	max_want_eat = randf_range(25, 50)

func death():
	if $"../../Food":
		for i in int(years) / 3:
			$"../../Food".add_child(preload("res://entities/food/Food.tscn").instantiate())
	queue_free()

func update2(delta):
		years += 0.01
		want_eat += 0.05
		$Label.value = years
		$Label2.value = want_eat
		if years > max_years or want_eat > max_want_eat:
			death()

func _on_area_2d_body_entered(body):
	if body.name == "Food":
		want_eat -= 5.0
		body.queue_free()
