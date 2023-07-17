extends CharacterBody2D
# Сущность - предок всех остальных.
# здесь добавляем все общие функции и переменные

# текущее состояние наших существ. Будем добавлять сюда другие
enum {STATE_IDLE, STATE_SLEEP, STATE_LOOK_FOR_FOOD, STATE_LOOK_FOR_HOME, STATE_EATING}
# типы еды, будем добавлять другие сюда
enum {FOOD_TYPE_GRASS, FOOD_TYPE_MEAT}

@export var _name = "ЗАГЛУШКА" #заглушка для имени

var state:= STATE_IDLE
@export var speed = randf_range(90,110) #скороть движения

var variation = 0.5 #это столько может быть прибавленко к максимальному возрасту и тп при старте

@export var max_hp = randf_range(90,130) #макс возраст
@export var hp = randf_range(90,130) #текущее здоровье

@export var age = 0.0 #текущий возраст
@export var max_age = randi_range(16,20) #макс возраст
@export var aging_speed = 0.1

#скорость взрослени
@export var hunger = 0.0 #текущий голод
@export var max_hunger = 100.0 #макс голод
@export var hunger_speed = randf_range(0.08,0.011) #скорость ПРОголодания


@export var sleep_chance = 0.01 #шансы от нуля до 1
@export var hunt_chance = 0.05
@export var max_sleep_time = 10.0 #в секундах
@export var hunt2_chance = 0.05

var nearest_food = []


#изменим чуть-чуть макс возраст и др параметры
func set_variations():
	speed = speed + speed * randf() * variation
	max_age = max_age + max_age * randf() * variation
	max_sleep_time = max_sleep_time + max_sleep_time * randf() * variation
	hunger_speed = hunger_speed + hunger_speed * randf() * variation

#установить имя организма, обновить Label с именем
func set_entity_name(nam):
	if nam == null or nam == "ЗАГЛУШКА":
		_name = name
	else :
		_name = nam
	$Name.text = _name


		
#заменить в потомках
#в этой функции происходит начальная инициализация переменных существа
func init():
	pass

#заменить в потомках
#в этой функции код движения существа
func move(delta):
	pass
	
#заменить в потомках на реальную работу существа
#в этой функции будет вызываться функция движения, переключения состояния и тп
func update(delta):
	pass

func give_birth(parent_plant,children,children_scene):
	for i in range(children):
		var instancedObject = load(children_scene)
		var baby = instancedObject.instantiate()
		var pos = Vector2()	
		pos.x = parent_plant.position.x + randf_range(-60,60) * children * parent_plant.scale.x
		pos.y = parent_plant.position.y + randf_range(-60,60) * children * parent_plant.scale.x
		while (parent_plant.position - pos).length() < 60:
			pos.x = parent_plant.position.x + randf_range(-60,60) * children * parent_plant.scale.x
			pos.y = parent_plant.position.y + randf_range(-60,60) * children * parent_plant.scale.x			
		baby.position = pos
		parent_plant.get_parent().add_child(baby)
		baby.set_entity_name("Plant")
		baby.max_age = randi_range(4,7)
		baby.children = randi_range(0,2)
		baby.velocity.x = 0
		baby.velocity.y = 0
		baby.scale = Vector2(0.5,0.5)
		
		
		
		
	
#проверить, если умирает от превышения макс возраста, умереть
func onDeath(animal):
	var instancedObject = load("res://entities/food/Food.tscn")
	var food = instancedObject.instantiate()	
	food.position = animal.position
	food.scale = animal.scale
	food.hp = 100
	if animal.is_in_group("plant"):
		food.add_to_group("food")
		food.set_entity_name("Vegetables")
	if animal.is_in_group("grass_eater"):
		food.add_to_group("grass_eater")
		food.set_entity_name("Meat")
		food.remove_from_group("food")
		food.add_to_group("meat")
	if animal.is_in_group("meat_eater"):
		food.add_to_group("grass_eater")
		food.set_entity_name("Meat")	
		food.remove_from_group("food")
		food.add_to_group("meat")
	animal.get_parent().add_child(food)
	#food.max_hp = animal.max_hp
	#food.hp = animal.max_hp
	queue_free()

#во всех дочерних скриптах не используйте _ready():, используйте init()
func _ready():
	#print(_name)
	set_entity_name(_name)
	init()
	
func update_progress_bar():
	if hunger != null and age != null and hunger_speed != null:
		$HungerBar.value = hunger
		$HealthBar.value = hp
		if hunger <= 100:
			hunger += hunger_speed * Global.speed_up * scale.x
		$Age.text = "age: "+str(round(age))
	elif hunger == null and age == null and hp != null:
		$HealthBar.value = hp
	
#во всех дочерних скриптах не используйте _process():, используйте update()	
func _process(delta):
	if Global.is_paused == false:
		update(delta)
		move_and_slide()
		update_progress_bar()
	
