extends Node2D

const SPEED = 100  
const MAX_HEIGHT = 200  
const MIN_HEIGHT = 0  

var direction = Vector2(0, -1)  

func _process(delta):
	if not $AudioStreamPlayer2D.playing: 
		$AudioStreamPlayer2D.play()
	pass


func _physics_process(delta: float) -> void:
	var motion = direction * SPEED * delta
	
	if motion.y == 0:
		direction *= -1  
	
	
	position.y = clamp(position.y, MIN_HEIGHT, MAX_HEIGHT)
