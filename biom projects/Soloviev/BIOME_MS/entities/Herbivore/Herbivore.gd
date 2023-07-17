extends "res://entities/animal/Animal.gd"

func init():
	min_childbearing_age = 2
	max_childbearing_age = max_age
	childbearing_age = range(min_childbearing_age, max_childbearing_age + 1)
	#print(childbearing_age)
	gave_birth = false
	nutrition_value = 60
	movetime = 0.0
	is_food_found = false
	starvation_limit = 10
	set_random_direction_and_speed()
	hp = 100
	state = STATE_IDLE
	edible_group = "fruits"
	
func onDeath(organism):
	var instancedObject = load("res://entities/FC Meat/First_consument_meat.tscn")
	var food = instancedObject.instantiate()
	var x = organism.position.x
	var y = organism.position.y
	food.position = Vector2(x,y)
	organism.get_parent().add_child(food)
	food.set_entity_name("First_consument_meat")
	organism.queue_free()
	
func eat_me(eater, nutrition_value):
	if hp > 0.0:
		speed /= 2
		hp -= eater.bite_force
	if hp <= 0.0:
		queue_free()
		onDeath(self)

func give_birth_animal(animal,children):
	#print("sdfsdfsdfsdfsdfsdf")
	#print(children)
	for i in range(round(children) as int):
		#print("give_birth_animal")
		var instancedObject = load("res://entities/Herbivore/Herbivore.tscn")
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
