extends Node2D
func _process(delta):
	if Global.tp_crash1 == 2:
		$".".position.x = 0
		$".".position.y = 432
