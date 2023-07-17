extends "res://entities/organism/Organism.gd"
var where_to_go
var food_location
var middle_pos
var edible_group = "first_consuments_meat"
@export var bite_force = 30
var animal = self
var gave_birth: bool = false
@export var children : int
@onready var collider = $CollisionShape2D
var going = 0
#var nearest_food_object := CharacterBody2D.new()
var is_food_found = false
var movetime = 0.0
var sub_state
var run


func set_random_direction_and_speed():
	velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * speed * Global.speed_up
	#sleep(randi_range(100, 500))



func init():
	edible_group = "first_consuments_meat"
	min_childbearing_age = 8
	max_childbearing_age = max_age - 2
	childbearing_age = range(min_childbearing_age, max_childbearing_age + 1)
	#print(childbearing_age)
	gave_birth = false
	nutrition_value = 60
	movetime = 0.0
	is_food_found = false
	starvation_limit = 70
	set_random_direction_and_speed()
	hp = 100
	state = STATE_IDLE

func update(delta):
	#$HungerBar.value = hunger
	
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
		



func munchkin_behavior(delta):
	#set_random_direction_and_speed()
	match sub_state:
		
		
		SSTATE_WALK: 
			movetime -= delta
			if movetime < 0.0:
				movetime = randf_range(0.5, 1.5)
				set_random_direction_and_speed()
			if randf() < 0.01:
				sub_state = SSTATE_STAY
				
				
		SSTATE_STAY, _:
			velocity = Vector2()
			if randf() < 0.01:
				sub_state = SSTATE_WALK
			fertility_check()
			#print(".")		
			
					
	
func fertility_check():
	
	if not gave_birth and (round(age) as int in childbearing_age) and hunger < starvation_limit:
		#print("sdfsdf")
		give_birth_animal(self, round((100 - hunger) / 30) as int)
		gave_birth = true
		#print(",")
		
	
	
	


func move(delta):
	pass
#добавить ограничение перемещения, чтобы не убегал за экран





func disableBody(disabled):
	$CollisionShape2D.disabled = disabled




func give_birth_animal(animal,children):
	#print("sdfsdfsdfsdfsdfsdf")
	#print(children)
	for i in range(round(children) as int):
		#print("give_birth_animal")
		var instancedObject = load("res://entities/animal/Animal.tscn")
		var baby = instancedObject.instantiate()
		var x = animal.position.x + 30*children
		var y = animal.position.y + 30*children
		baby.position = Vector2(x,y)
		animal.get_parent().add_child(baby)
		baby.set_entity_name("Baby Animal")
		baby.children = randi_range(1,2)
		baby.velocity.x = 0
		baby.velocity.y = 0
		baby.hunger = 60
		baby.disableBody(true)
		







func naming():
	#var animal = self
	if age <= 3:
		animal.name = "Baby"
		$Name.text = animal.name
	else:
		animal.name = "Adult"
		$Name.text = animal.name







func bite():
	if where_to_go != null and where_to_go.position != null:
		food_location = where_to_go.position
	else:
		state = STATE_IDLE
		return
	
	animal.velocity = ((food_location - animal.position).normalized() * speed) * Global.speed_up
	if (food_location - animal.position).length() <= 25:
		#animal.velocity = Vector2(0,0)
		eat_food(where_to_go)	#УКУСИТЬ	
		#отойти
		animal.velocity = -animal.velocity
		state = STATE_IDLE	
	
	$Name.text = str((food_location - animal.position).length())
	#print(str((food_location - animal.position).length()))

func find_nearest_food():
	#var animal = self
	#print("find_nearest_food")
	var foods
	var nearest_food_object : Object

	foods = get_tree().get_nodes_in_group(edible_group) 
		
	
	#print(foods)
	
	if foods.size() < 1:
		#print(3)
		return null
		
	#print(food)
	var s = 100000
	for food in foods:
		if food is CharacterBody2D and (food.position - animal.position).length() <= s:
			nearest_food_object = food
			
			s = (food.position - animal.position).length()
	if s != 100000:		
		is_food_found = true
		#print("is_food_found = true ", nearest_food_object.position.x, nearest_food_object.position.y, "\n")
		#print(nearest_food_object)
		return nearest_food_object
	return null
	
		
func eat_food(food):
	
	if !food:
		state = STATE_IDLE
		#print("STATE_IDLE")
		return
	food.eat_me(self, food.nutrition_value)
	if randf_range(0, 1) <= variation:
		max_age += 1	
		#print("1")
	if randf_range(0,1) <= health_gain:
		#print("2")
		hp += 10
#вызывается при смерти от старения. Либо когда это существо кто-то съел
func move_to_food(food_object, delta):
	if food_object != null and food_object.position != null: #костыльный момент
		food_location = food_object.position
		animal.velocity = ((food_location - animal.position).normalized() * speed) * Global.speed_up
		if (food_location - animal.position).length() <= 50:
			animal.velocity = Vector2(0,0)
			#print("(food_location - animal.position).length() <= 50:")
			
			appetite = true
	else:
		state = STATE_IDLE
		
		
func onDeath(organism):
	var instancedObject = load("res://entities/meat/Meat.tscn")
	var meat = instancedObject.instantiate()
	var x = organism.position.x
	var y = organism.position.y
	meat.position = Vector2(x,y)
	organism.get_parent().add_child(meat)
	meat.set_entity_name("meat")
	organism.queue_free()		
		
	
