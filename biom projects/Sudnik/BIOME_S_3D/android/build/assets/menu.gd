extends "res://Main.gd"



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	predators = int($Predators.text)
	grass_eaters = int($GrassEaters.text)
	plants = int($Plants.text)
	food = int($Food.text)

	
	



func _on_button_pressed():
	#var main = preload("res://Main.tscn").instantiate()
	#get_tree().get_root().add_child(main)
	#hide()
	spawn_all(predators,grass_eaters,plants,food)
	get_tree().change_scene_to_file("res://Main.tscn")
	
