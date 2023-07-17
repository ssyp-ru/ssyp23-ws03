extends Area2D
@export var score = 1
var anim_coins
func _ready(): 
	anim_coins = $AnimatedSprite2D
	
	anim_coins.play("coins")
	
func _on_body_entered(body):
	if body.name == "player":
		hide()
		$CollisionShape2D.queue_free() 
		$Coins.play() 
		config.score += score
		await $Coins.finished
		queue_free() 
