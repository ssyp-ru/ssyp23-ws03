extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.pause = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/ProgressBar.value = $Food.get_child_count()
	$CanvasLayer/ProgressBar2.value = $Grass.get_child_count()
	$CanvasLayer/ProgressBar3.value = $Wolf.get_child_count()
	$CanvasLayer/ProgressBar4.value = $Goat.get_child_count()
	$CanvasLayer/ProgressBar5.value = $Plant.get_child_count()

func _on_pause_pressed():
	if Global.pause == 1:
		Global.pause = 0
	else:
		Global.pause = 1


func _on_button_pressed():
	Global.zoom += 1
	
func _on_button_2_pressed():
	Global.zoom -= 1
