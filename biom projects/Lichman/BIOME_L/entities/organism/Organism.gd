extends "res://entities/entity/Entity.gd"

@export var max_want_eat = 1

func update(delta):
	move()

#func _on_timer_timeout():
#	years =+ 0.01
#	want_eat =+ 0.05
#	pass # Replace with function body.
