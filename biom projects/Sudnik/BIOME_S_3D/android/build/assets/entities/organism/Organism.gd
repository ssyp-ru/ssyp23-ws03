extends "res://entities/entity/Entity.gd"
# живые существа
@export var children = 1
var gave_birth = 0
@export var eating_radius = 60
var going = 0

var f := CharacterBody2D.new()
var r = randf_range(0.002,0.0007)
var growth_speed = Vector2(r,r)



func update(delta):
	#живые существа двигаются. Но в реальных существах должно быть больше действий, кроме движения
	if Global.is_paused == false:
		move(delta)
		check_if_dead(delta)
		if age >= 3.2 and gave_birth == 0:
			give_birth($".",children,"res://entities/plant/Plant.tscn")
			gave_birth = 1
		if hunger >= 30:
			if get_tree().get_nodes_in_group("food"):
				var ch: CharacterBody2D = find_food()
				if ch != null:
					eat(ch)
		if hunger >= 90:
			hp -= 0.1
		if age <= 3:
			scale += growth_speed * Global.speed_up
			max_hp = 100 * scale.x

		
		
			
		
		
func check_if_dead(delta):
	age += aging_speed * Global.speed_up * delta
	if age >= max_age:
		onDeath($".")
	if hp <= 0:
		onDeath($".")
		
func find_food():
	#print("searching food",self)
	var food = get_tree().get_nodes_in_group("food")
	if len(food) > 1:
		for foo in food:
			if foo.position - position <= Vector2(eating_radius,eating_radius):
				f = foo
				return f
	
	
	
func eat(food):
	
	var amount = randi_range(hunger/6,hunger/2)/2
	if food.hp > 0:
		if amount > food.hp:
			hunger -= food.hp * 2
			food.hp -= food.hp			
		else:
			hunger -= amount * 2
			food.hp -= amount
		#$Finger.position = (food.position - position).normalized() * 10
		#$Finger.rotation = (food.position - position).to
		#$Finger.rotation = position.angle_to_point(food.position)
			
	if food.hp <= 0:
		
		food.queue_free() 

