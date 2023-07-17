extends Node2D
func _process(delta):
	if Global.tp_crash == 1:
		$".".position.x = -470
		$".".position.y = 432
