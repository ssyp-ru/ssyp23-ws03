extends "res://entities/Predator/Predator.gd"

var animation
var idle

func init():
	
	randomize()
	min_childbearing_age = 2
	max_childbearing_age = max_age
	childbearing_age = range(min_childbearing_age, max_childbearing_age + 1)
	#print(childbearing_age)
	gave_birth = false
	nutrition_value = 10
	movetime = 0.0
	is_food_found = false
	hunger_speed = 5
	max_hp = 70
	starvation_limit = 10
	set_random_direction_and_speed()
	hp = 70
	state = STATE_IDLE
	edible_group = "second_consuments"
	$HealthBar.max_value = round(max_hp)
	$HungerBar.max_value = round(max_hunger)

func update(delta):
	#$HungerBar.value = hunger
	#$AnimatedSprite2D.play(animation)
	if hunger != null or age != null:
		$HungerBar.value = hunger
		$HealthBar.value = hp
		
		$Age.text = str(round(age))
	elif hunger == null and age == null and hp != null:
		$HealthBar.value = hp
	naming()
	check_if_dead() 
	
	if velocity.x > 0:
		
		$AnimatedSprite2D.play("run")
		print("velocity.x > 0:")
		$AnimatedSprite2D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
	elif velocity.x == 0:
		$AnimatedSprite2D.play("idle")
		
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
		
func give_birth_animal(animal,children):
	#print("sdfsdfsdfsdfsdfsdf")
	print("fox born")
	for i in range(round(children) as int):
		#print("give_birth_animal")
		var instancedObject = load("res://entities/Wolf/Wolf.tscn")
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


