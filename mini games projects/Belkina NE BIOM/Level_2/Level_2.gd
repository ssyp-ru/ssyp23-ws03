extends Node2D

func _process(delta):
	if not $AudioStreamPlayer2D.playing: 
		$AudioStreamPlayer2D.play()
	pass
