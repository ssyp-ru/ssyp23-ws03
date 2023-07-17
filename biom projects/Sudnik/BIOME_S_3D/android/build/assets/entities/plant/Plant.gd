extends "res://entities/organism/Organism.gd"


# Растения
func _init():
	scale = Vector2(0.4,0.4)
	max_hp = 100 * scale.x
	hp = 100 * scale.x


