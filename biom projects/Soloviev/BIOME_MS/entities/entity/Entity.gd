extends CharacterBody2D
# Сущность - предок всех остальных.
# здесь добавляем все общие функции и переменные
@export var nutrition_value: int = 10
# текущее состояние наших существ. Будем добавлять сюда другие

# типы еды, будем добавлять другие сюда
enum {FOOD_TYPE_GRASS, FOOD_TYPE_MEAT}

@export var _name = "ЗАГЛУШКА" #заглушка для имени

var appetite = false
@export var speed = 100.0 #скороть движения

var variation = 0.5 #это столько может быть прибавленко к максимальному возрасту и тп при старте

@export var max_hp = 100.0 #макс возраст
@export var hp = 100.0 #текущее здоровье


@export var age = 0.0 #текущий возраст
@export var max_age = 18.0 #макс возраст
@export var aging_speed = 1.1 #скорость взрослени
@export var hunger = 0.0 #текущий голод
@export var max_hunger = 100.0 #макс голод
@export var hunger_speed = 5 #скорость ПРОголодания

@export var starvation_limit: float = 80.0
@export var attrition_rate = 20
@export var sleep_chance = 0.01 #шансы от нуля до 1
@export var health_gain = 0.7
@export var max_sleep_time = 10.0 #в секундах
@export var hunt2_chance = 0.05

var nearest_food = []

#изменим чуть-чуть макс возраст и др параметры

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
	$HealthBar.max_value = round(max_hp)
	$HungerBar.max_value = round(max_hunger)


#заменить в потомках
#в этой функции код движения существа
func move(delta):
	pass
	
#заменить в потомках на реальную работу существа
#в этой функции будет вызываться функция движения, переключения состояния и тп
func update(delta):
	if hp > max_hp:
		hp = max_hp
	if hunger > max_hunger:
		hunger = max_hunger
	
#проверить, если умирает от превышения макс возраста, умереть
func onDeath(object):
	queue_free()

#во всех дочерних скриптах не используйте _ready():, используйте init()
func _ready():
	set_entity_name(_name)
	init()
	
func update_progress_bar(delta):
	pass#во всех дочерних скриптах не используйте _process():, используйте update()	
func _process(delta):
	update(delta)
	move_and_slide()
	update_progress_bar(delta)
