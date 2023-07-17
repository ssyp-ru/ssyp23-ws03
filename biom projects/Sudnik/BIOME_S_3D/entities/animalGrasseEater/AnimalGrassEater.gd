extends "res://entities/organism/Organism.gd"

var nearest := CharacterBody3D.new()

func update(delta):
	if Global.is_paused == false:
		if randf() < 0.05 and going == 0:
			set_random_direction_and_speed()
		elif age > 3 and age < 4 and gave_birth == 0 and is_in_group("grass_eater"):
			give_birth_animal($".",children)
			gave_birth = 1
		set_nam($".")
		if age > 0.5 and age < 0.6:
			disableBody(false)
		check_if_dead(delta)
		if hunger >= 30:
			if get_tree().get_nodes_in_group("food") + get_tree().get_nodes_in_group("plant"):
				var ch = find_nearest_food($".")
				if ch != null:
					move_to_food($".",ch.position,ch)
		if hunger >= 90:
			hp -= 0.5
		elif hunger <= 25:
			hp += 0.1
		if age <= 3:
			scale += growth_speed * Global.speed_up
			max_hp = 100 * scale.x
			
func disableBody(disabled):
	$CollisionShape2D.disabled = disabled
	
	
func set_random_direction_and_speed():
	velocity = Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * speed * Global.speed_up
	
func give_birth_animal(animal,children):
	for i in range(children):
		var instancedObject = load("res://entities/animalGrasseEater/AnimalGrassEater.tscn")
		var baby = instancedObject.instantiate()
		var x = animal.position.x + 30*children
		var y = animal.position.y + 30*children
		var z = animal.position.z + 30*children
		baby.position = Vector3(x,y,z)
		animal.get_parent().add_child(baby)
		baby.set_entity_name("Baby Animal")
		baby.children = randi_range(1,3)
		baby.velocity.x = 0
		baby.velocity.y = 0
		baby.disableBody(true)
		baby.scale = Vector3(0.5, 0.5, 0.5)
		
		
func find_nearest_food(animal):
	var food = get_tree().get_nodes_in_group("food") + get_tree().get_nodes_in_group("plant")
	if food.size() <= 1:
		return nearest
	#print(food)
	var s = 1000000
	for foo in food:
		if (animal.position - foo.position).length() < s:
			if !foo.is_in_group("meat"):
				nearest = foo
				s = (animal.position - foo.position).length()
	return nearest
	
	
func eat_food(animal,food,amount):
	if food.hp > 0:
		animal.hunger -= amount
		food.hp -= amount
		going = 0
	else:
		food.queue_free()
		
#вызывается при смерти от старения. Либо когда это существо кто-то съел	
func move_to_food(animal,nearest,food):
	var food_location: Vector3 = nearest
	if food_location != Vector3(1000, 1000, 1000):
		var animal_location: Vector3 = animal.position
		animal.velocity = (food_location - animal_location).normalized() * speed * Global.speed_up
		going = 1
		if (food_location - animal_location).length() <= 50:
			animal.velocity = Vector3(0, 0, 0)
			eat_food(animal,food,randi_range(5,animal.hunger))
			
func init():
	set_random_direction_and_speed()
	scale = Vector3(0.5,0.5, 0.5)
	max_hp = 100 * scale.x
	hp = 100 * scale.x
			
func set_nam(animal):
	if age <= 1:
		animal.name = "Baby Animal"
		$Name.text = animal.name
	else:
		animal.name = "Adult Animal"
		$Name.text = animal.name

