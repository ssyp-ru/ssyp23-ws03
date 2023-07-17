extends "res://entities/animal/Animal.gd"

func init():
	edible_group = "SC_food"
	min_childbearing_age = 8
	max_childbearing_age = max_age - 2
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
