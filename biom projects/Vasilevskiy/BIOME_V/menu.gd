extends "res://Main.gd"




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	predators = $CanvasLayer/Control/Predators.value
	grass_eaters = $CanvasLayer/Control/GrassEaters.value
	plants = $CanvasLayer/Control/Plants.value
	food = $CanvasLayer/Control/Food.value
	$CanvasLayer/Control/PredatorsLabel.text = str(predators)
	$CanvasLayer/Control/GrassEatersLabel.text = str(grass_eaters)
	$CanvasLayer/Control/PlantsLabel.text = str(plants)
	$CanvasLayer/Control/FoodLabel.text = str(food)

	
	



func _on_button_pressed():
	spawn_all(predators,grass_eaters,plants,food)
	get_tree().change_scene_to_file("res://Main.tscn")
	



	


func _on_check_box_toggled(button_pressed):
	if button_pressed:
		Global.is_hidden = 0
	else:
		Global.is_hidden = 1





func _on_randomizer_pressed():
	predators = randi_range(1,51)
	grass_eaters = randi_range(1,51)
	plants = randi_range(1,51)
	food = randi_range(1,51)
	$CanvasLayer/Control/Predators.value = predators
	$CanvasLayer/Control/GrassEaters.value = grass_eaters
	$CanvasLayer/Control/Plants.value = plants
	$CanvasLayer/Control/Food.value = food

	


