extends "res://entities/organism/Organism.gd"

var plant = self
var wait = 300
var num = 0
var specie
var specieview
func init():
	nutrition_value = 30
	hp = 20
	match randi_range(0, 4):
		0:
			specie = "apple"
			specieview = load("res://ASSETS/apple.png")
		1:
			specie = "cherry"
			specieview = load("res://ASSETS/cherry.png")
		2:
			specie = "pear"
			specieview = load("res://ASSETS/pear.png")
		3:
			specie = "strawberry"
			specieview = load("res://ASSETS/strawberry.png")
	$HungerBar.visible = false
	state = STATE_IDLE
	
	
func drop_fruit(number):
	for i in range(round(number) as int):
		
		var instancedObject = load("res://entities/fruit/Fruit.tscn")
		var fruit = instancedObject.instantiate()
		var x = plant.position.x + randi_range(1, 30)
		var y = plant.position.y + randi_range(1, 30)
		fruit.position = Vector2(x,y)
		plant.get_parent().add_child(fruit)
		fruit.set_entity_name("fruit")
		fruit.changetexture(specieview)
		#fruit.number = randi_range(1, 2)
		fruit.velocity.x = 0
		fruit.velocity.y = 0
		#fruit.disableBody(true)		
		
	
func update(delta):
	wait -= 1
	match state:
		
		STATE_IDLE:
			#(wait)
			if wait <= 0:
				state = STATE_DROP_FRUIT
			
		STATE_DROP_FRUIT:
			#("5")
			num = randi_range(1, 12)
			
			if num <= 2:
				drop_fruit( num+randi_range(1, 6) )
				wait = 1000
				state = STATE_IDLE
			if num < 5 and num > 2:
				state = STATE_OLD
				
			else:
				drop_fruit(1)
				queue_free()
			
				
		STATE_OLD:
			hp -= 0.1
			if !hp:
				queue_free()


func eat_me(eater, nutrition_value):
	if hp > 0.0:
		#print(" ate -", nutrition_value)
		eater.hunger -= nutrition_value
		hp -= nutrition_value
	if hp <= 0.0:
		queue_free()
		var instancedObject = load("res://entities/fruit/Fruit.tscn")
		var fruit = instancedObject.instantiate()				
