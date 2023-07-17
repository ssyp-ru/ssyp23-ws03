extends Node2D


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.tru_ckash_box == 1:
		$".".position.x = -470
		$".".position.y = 432
	if Global.tru_ckash_box == 2:
		$".".position.x = 0
		$".".position.y = 432
	if Global.tru_ckash_box == 3:
		$".".position.x = 465
		$".".position.y = 432
