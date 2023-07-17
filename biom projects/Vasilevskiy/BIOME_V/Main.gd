extends Node2D

@onready var predator_scene = preload("res://entities/animal/Animal.tscn")
@onready var grass_eater_scene = preload("res://entities/animalGrasseEater/AnimalGrassEater.tscn")
@onready var plant_scene = preload("res://entities/plant/Plant.tscn")
@onready var food_scene = preload("res://entities/food/Food.tscn")
@onready var rock_scene = preload("res://accessories/rock.tscn")
@onready var cactus_scene = preload("res://accessories/cactus.tscn")

@onready var predator_bar = $CanvasLayer/PredatorBar
@onready var grass_eater_bar = $CanvasLayer/GrassEaterBar
@onready var plant_bar = $CanvasLayer/PlantBar
@onready var food_bar = $CanvasLayer/FoodBar


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.main_scene = $"."
	Global.age_of_the_world = 0
	pass # Replace with function body.
var predators = 1
var grass_eaters = 1
var plants = 1
var food = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	var predator_number : float = len(get_tree().get_nodes_in_group("meat_eater"))
	var grass_eaters_number : float = len(get_tree().get_nodes_in_group("true_grass_eater"))
	var plant_number : float = len(get_tree().get_nodes_in_group("plant"))
	var food_number : float = len(get_tree().get_nodes_in_group("meat") + get_tree().get_nodes_in_group("food"))
	var percent100 : float = predator_number + grass_eaters_number + plant_number + food_number
	#predator_bar.value = (predator_number / (grass_eaters_number + plant_number + food_number)) * 100
	if predator_number == 0:
		predator_bar.value = 0
	else:
		predator_bar.value = 100.0 / (1.0 * percent100 / predator_number)
	if grass_eaters_number == 0:
		grass_eater_bar.value = 0
	else:
		grass_eater_bar.value = 100.0 / (1.0 *percent100 / grass_eaters_number)
	if plant_number == 0:
		plant_bar.value = 0
	else:
		plant_bar.value = 100.0 / (1.0 *percent100 / plant_number)
	if food_number == 0:
		food_bar.value = 0
	else:
		food_bar.value = 100.0 / (1.0 * percent100 / food_number)
	
	$CanvasLayer/Predators.text = str(predator_number) + " species"
	$CanvasLayer/GrassEaters.text = str(grass_eaters_number) + " species"
	$CanvasLayer/Plants.text = str(plant_number) + " species"
	$CanvasLayer/Food.text = str(food_number) + " food"
		
	
	Global.age_of_the_world += 0.1 * Global.speed_up * delta
	$CanvasLayer/AgeCount.text = "  " + str(round(Global.age_of_the_world)) + " years"
	#grass_eater_bar.value = (grass_eaters_number / (predator_number + plant_number + food_number)) * 100
	#plant_bar.value = (plant_number / (grass_eaters_number + predator_number + food_number)) * 100
	#food_bar.value = (food_number / (grass_eaters_number + plant_number + predator_number)) * 100
func _on_button_speed_up_toggled(button_pressed):
	Global.speed_up = 2.0 if Global.speed_up == 1.0 else 1.0 if Global.speed_up == 128.0 else 4.0 if Global.speed_up == 2.0 else 8.0 if Global.speed_up == 4.0 else 16.0 if Global.speed_up == 8.0 else 32.0 if Global.speed_up == 16.0 else 64.0 if Global.speed_up == 32.0 else 128.0
	match Global.speed_up:
		1.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 1X"
		2.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 2X"
		4.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 4X"
		8.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 8X"
		16.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 16X"
		32.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 32X"
		64.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 64X"
		128.0:
			$CanvasLayer/ButtonSpeedUp.text = "СКОРОСТЬ 128X"
	#$ButtonSpeedUp.text = "СКОРОСТЬ 1X" if button_pressed and Global.speed_up == 1.0 else "СКОРОСТЬ 2X" if Global.speed_up == 4.0 and button_pressed else "СКОРОСТЬ 4X"


func _on_pause_button_pressed():
	Global.is_paused = true if Global.is_paused == false else false
	$CanvasLayer/PauseButton.text = "Pause" if $CanvasLayer/PauseButton.text == "Play" else "Play"
	
func spawn_entity(scene,x,y):
	var baby = scene.instantiate()
	baby.position.x = x
	baby.position.y = y
	get_parent().add_child(baby)
	
	
	
func spawn_all(predators,grass_eaters,plants,food):
	for i in range(predators):
		spawn_entity(predator_scene,randf_range(-2000,2000),randf_range(-1500,1500))
	for i in range(grass_eaters):
		spawn_entity(grass_eater_scene,randf_range(-2000,2000),randf_range(-1500,1500))
	for i in range(plants):
		spawn_entity(plant_scene,randf_range(-2000,2000),randf_range(-1500,1500))
	for i in range(food):
		spawn_entity(food_scene,randf_range(-2000,2000),randf_range(-1500,1500))
	for i in range(30):
		spawn_entity(rock_scene,randf_range(-2000,2000),randf_range(-1500,1500))
	for i in range(30):
		spawn_entity(cactus_scene,randf_range(-2000,2000),randf_range(-1500,1500))
	





func _on_exit_button_pressed():
	#get_tree().reload_current_scene()
	#get_tree().get_nodes_in_group()
	get_tree().call_group("meat_eater","queue_free")
	get_tree().call_group("grass_eater","queue_free")
	get_tree().call_group("food","queue_free")
	get_tree().call_group("plant","queue_free")
	get_tree().call_group("accessories","queue_free")
	Global.speed_up = 1.0
	Global.is_hidden = 1
	get_tree().change_scene_to_file("res://menu.tscn")
	
	
