extends "res://entities/thing/Thing.gd"
#Еда

#добавить функции для еды. В entity есть типы еды
func init():
	hp = 100
	$Age.visible = false
	$HungerBar.visible = false
	nutrition_value = 40

@warning_ignore("unused_parameter")
func update(delta):
	$HealthBar.value = hp
	
	
@warning_ignore("shadowed_variable")
func eat_me(eater, nutrition_value):
	if hp > 0.0:
		#print(" ate -", nutrition_value)
		eater.hunger -= nutrition_value
		hp -= nutrition_value
	if hp <= 0.0:
		queue_free()
		var instancedObject = load("res://entities/fruit/Fruit.tscn")
		var fruit = instancedObject.instantiate()
		
