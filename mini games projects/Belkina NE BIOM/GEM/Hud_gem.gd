extends Area2D
var anim_coins
func _ready(): 
	anim_coins = $AnimatedSprite2D
	
	anim_coins.play("coins")
	

