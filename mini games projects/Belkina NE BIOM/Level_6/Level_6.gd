extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if not $AudioStreamPlayer2D.playing: 
		$AudioStreamPlayer2D.play()
	pass
