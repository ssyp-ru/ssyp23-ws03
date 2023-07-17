extends "res://entities/thing/Thing.gd"

#func _on_timer_timeout():
#	years =+ 1
#	pass # Replace with function body.

func init():
	$AnimatedSprite2D.play("Food")
	position = Vector2(randf_range(10, 1100), randf_range(10, 600))
	
func update(delta):
	if Global.pause == 0:
		years += 0.01
		$Label.value = years
		if years > randf_range(7, 20):
			queue_free()
	
