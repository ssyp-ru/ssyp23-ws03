extends "res://entities/organism/Organism.gd"

var ran = randi_range(0,3)
var tree_type = "green"
@onready var anim = $AnimatedSprite2D
# Растения
func init():
	if  ran == 1:
		$AnimatedSprite2D.play("default")
		tree_type = "green"
	elif ran == 2:
		$AnimatedSprite2D.play("sakura")
		tree_type = "pink"
	elif ran == 0:
		$AnimatedSprite2D.play("orange")
		tree_type = "orange"
	
	scale = Vector2(0.4,0.4)
	max_hp = 100 * scale.x
	hp = 100 * scale.x
	#$Sprite2D.set_texture(new_texture)
	




