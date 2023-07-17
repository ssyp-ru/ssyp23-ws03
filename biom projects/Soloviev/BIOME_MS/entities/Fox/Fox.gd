extends "res://entities/Predator/Predator.gd"

func init():
	edible_group = "SC_food"
	min_childbearing_age = 10
	max_childbearing_age = 20
	childbearing_age = range(min_childbearing_age, max_childbearing_age + 1)
	#print(childbearing_age)
	bite_force = 40
	gave_birth = false
	nutrition_value = 60
	movetime = 0.0
	is_food_found = false
	starvation_limit = 60
	set_random_direction_and_speed()
	hp = 100
	state = STATE_IDLE

func update(delta):
	#$HungerBar.value = hunger
	if velocity.x > 0:
		$AnimatedSprite2D.play("run")
		print("velocity.x > 0:")
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
	elif velocity.x == 0:
		$AnimatedSprite2D.stop()
		
	if hunger != null or age != null:
		$HungerBar.value = hunger
		$HealthBar.value = hp
		
		$Age.text = str(round(age))
	elif hunger == null and age == null and hp != null:
		$HealthBar.value = hp
	naming()
	check_if_dead() 


	match state:

		STATE_IDLE:
			$position.text = "IDLE"					
			munchkin_behavior(delta)
			hungering(delta)
			aging(delta) #если животное сыто то включить поведение сытого животного

		STATE_LOOK_FOR_FOOD: #если животное голодно то искать еду
			$position.text = "STATE_LOOK_FOR_FOOD" 
			hungering(delta)
			aging(delta)
			
			#for i in edible_group:
			#(get_tree().get_nodes_in_group(edible_group))
			if get_tree().get_nodes_in_group(edible_group): #Если еда еще есть впринципе
				#print(get_tree().get_nodes_in_group(edible_group))
				where_to_go = find_nearest_food()
				#print(where_to_go)
				if where_to_go != null:  #если можно найти ближайшую еду
					state = STATE_WALK_TO_FOOD #если еда найдена то начать двигаться к ней


		STATE_WALK_TO_FOOD: 
			aging(delta)
			hungering(delta)
			
			$position.text = "STATE_WALK_TO_FOOD"
			move_to_food(where_to_go, delta)
			if appetite:
				state = STATE_EATING
		
		STATE_EATING:
			hungering(delta)
			$position.text = "STATE_EATING"
			bite()
			
	
func onDeath(organism):
	var instancedObject = load("res://entities/SC Meat/Second_consument_meat.tscn")
	var food = instancedObject.instantiate()
	var x = organism.position.x
	var y = organism.position.y
	food.position = Vector2(x,y)
	organism.get_parent().add_child(food)
	food.add_to_group("second_consument_meat")
	food.set_entity_name("second_consument_meat")
	organism.queue_free()	
	print("fox death")
	
func give_birth_animal(animal,children):
	#print("sdfsdfsdfsdfsdfsdf")
	print("fox born")
	for i in range(round(children) as int):
		#print("give_birth_animal")
		var instancedObject = load("res://entities/Fox/Fox.tscn")
		var baby = instancedObject.instantiate()
		var x = animal.position.x + 30*children
		var y = animal.position.y + 30*children
		baby.position = Vector2(x,y)
		animal.get_parent().add_child(baby)
		baby.set_entity_name("Baby Animal")
		baby.children = randi_range(1,3)
		baby.velocity.x = 0
		baby.velocity.y = 0
		baby.hunger = 60
		baby.disableBody(true)	

func eat_me(eater, nutrition_value):
	if hp > 0.0:
		#print(" ate -", nutrition_value)
		eater.hunger -= nutrition_value
		hp -= nutrition_value
	if hp <= 0.0:
		queue_free()
		var instancedObject = load("res://entities/SC Meat/Second_consument_meat.tscn")
		var fruit = instancedObject.instantiate()
