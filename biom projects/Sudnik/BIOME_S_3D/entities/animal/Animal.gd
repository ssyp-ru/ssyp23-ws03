extends "res://entities/organism/Organism.gd"
# Животные


@onready var collider = $CollisionShape2D

var nearest := CharacterBody3D.new()
	
func set_random_direction_and_speed():
	velocity = Vector3(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * speed * Global.speed_up
	
func init():
	scale = Vector3(0.5,0.5, 0.5)
	gave_birth = 0
	max_hp = 100 * scale.x
	hp = 100 * scale.x

func move(delta):
	pass
#добавить ограничение перемещения, чтобы не убегал за экран
	
func disableBody(disabled):
	$CollisionShape2D.disabled = disabled

func give_birth_animal(animal,children):
	for i in range(children):
		var instancedObject = load("res://entities/animal/Animal.tscn")
		var baby = instancedObject.instantiate()
		var x = animal.position.x + 30*children
		var y = animal.position.y + 30*children
		var z = animal.position.z + 30*children
		baby.position = Vector3(x,y, z)
		animal.get_parent().add_child(baby)
		baby.set_entity_name("Baby Animal")
		baby.children = randi_range(0,3)
		baby.velocity.x = 0
		baby.velocity.y = 0
		baby.disableBody(true)
		baby.scale = Vector3(0.5,0.5, 0.5)

func check_if_dead(delta):
	age += aging_speed * Global.speed_up * delta
	if age >= max_age:
		onDeath($".")
	if hp <= 0:
		onDeath($".")
		

func update(delta):
	position.y = clamp(position.y, 0, 0)
	position.x = clamp(position.x, -50, 50)
	position.z = clamp(position.z, -50, 50)
	if Global. is_paused == false:
		if randf() < 0.05 and going == 0:
			set_random_direction_and_speed()
		if age > 6 and age < 7 and gave_birth == 0:
			give_birth_animal($".",children)
			gave_birth = 1
		
		set_nam($".")
		if age > 0.5 and age < 0.6:
			disableBody(false)
		check_if_dead(delta)
		if hunger >= 50:
			if get_tree().get_nodes_in_group("grass_eater"):
				var ch = find_nearest_food($".")
				if ch != null:
					move_to_food($".",ch.position,ch)
		if hunger >= 90:
			hp -= 0.5
		elif hunger <= 25 and hp < 100:
			hp += 0.1
		if age <= 3:
			scale += growth_speed * Global.speed_up
			max_hp = 100 * scale.x
		
		

func find_nearest_food(animal):
	var food = get_tree().get_nodes_in_group("grass_eater")
	if food.size() < 1:
		return nearest
	#print(food)
	var s = 1000000
	for foo in food:
		if (animal.position - foo.position).length() < s:
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
	var food_location = nearest
	if food_location != Vector3(1000, 1000, 1000):
		var animal_location: Vector3 = animal.position
		animal.velocity = (food_location - animal_location).normalized() * speed * Global.speed_up
		going = 1
		if (food_location - animal_location).length() <= 50:
			animal.velocity = Vector3(0, 0, 0)
			eat_food(animal,food,randi_range(5,animal.hunger))
		
	
		
func set_nam(animal):
	if age <= 1:
		animal.name = "Baby Animal"
		$Name.text = animal.name
	else:
		animal.name = "Adult Animal"
		$Name.text = animal.name
		
