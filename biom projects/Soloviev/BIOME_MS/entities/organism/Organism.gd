extends "res://entities/entity/Entity.gd"
# живые существа
enum {STATE_IDLE, STATE_SLEEP, STATE_LOOK_FOR_FOOD, STATE_WALK_TO_FOOD, STATE_LOOK_FOR_HOME, STATE_EATING, STATE_DROP_FRUIT, STATE_OLD, STATE_BITTEN}

enum {SSTATE_STAY, SSTATE_WALK, SSTATE_SLEEP}



@export var min_childbearing_age: int = 3
@export var max_childbearing_age: int = 20
var childbearing_age = range(min_childbearing_age, max_childbearing_age + 1)
var state:= STATE_IDLE
var extraordinary_case := false



var descendants: Dictionary = {} #	{ descendant_{x}: [name, lifetime], descendant_{x+1}: [name, lifetime]}


var is_hunger = hunger > starvation_limit

func sleep(time):
	await get_tree().create_timer(time).timeout
	
func update(delta):
	#живые существа двигаются. Но в реальных существах должно быть больше действий, кроме движения
	move(delta)
	check_if_dead()
	
func onDeath(organism):
	var instancedObject = load("res://entities/food/Food.tscn")
	var food = instancedObject.instantiate()
	var x = organism.position.x
	var y = organism.position.y
	food.position = Vector2(x,y)
	organism.get_parent().add_child(food)
	food.set_entity_name("")
	organism.queue_free()


func set_variations():
	speed = speed + speed * randf() * variation
	max_age = max_age + max_age * randf() * variation
	max_sleep_time = max_sleep_time + max_sleep_time * randf() * variation
	#hunger_speed = hunger_speed + hunger_speed * randf() * variation
	
func hungering(delta): #увеличение голода
	hunger += hunger_speed * delta * Global.speed_up
	
	if hunger > starvation_limit and state == STATE_IDLE and not extraordinary_case:
		state = STATE_LOOK_FOR_FOOD
	if hunger > 100:
		starvation(delta)
	if hunger < 0:
		hunger = 0
	
		
		
func starvation(delta): 
	if hunger >= 100:#умирание от голода
		hp -= attrition_rate * delta * Global.speed_up
			

func aging(delta):	#прибавление возраста
	age += aging_speed * Global.speed_up * delta
	
	if age >= max_age:
		onDeath($".")
	
func check_if_dead(): #проверить мертво ли животное
	if hp <= 0:
		onDeath($".")	


func update_progress_bar(delta):
	if hunger != null or age != null:
		$HungerBar.value = hunger
		$HealthBar.value = hp
		
		$Age.text = str(round(age))
	elif hunger == null and age == null and hp != null:
		$HealthBar.value = hp		
	
func give_birth(organism,children):
	for i in range(children):
		var instancedObject = load("res://entities/animal/Animal.tscn")
		var baby = instancedObject.instantiate()
		var x = organism.position.x + 30*children
		var y = organism.position.y + 30*children
		baby.position = Vector2(x,y)
		organism.get_parent().add_child(baby)
		baby.set_entity_name("Baby Animal")
		baby.children = randi_range(1,2)
		baby.velocity.x = 0
		baby.velocity.y = 0
#			
#
