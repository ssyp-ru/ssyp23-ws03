extends "res://entities/food/Food.gd"

var lifetime = 300 + randi_range(1, 200)
var fruite = self
var arr = [-1, 1]
func init():
	max_hp = 5
	$Name.text = "fruit"
	nutrition_value = 10
	hp = 5
	
func changetexture(Texture):
	$Sprite2D.texture = Texture
	

func update(delta):
	lifetime -= 1
	if randi_range(0, 1000) < 2: #мне очень не нравится это. Надо будет исправить
		var instancedObject = load("res://entities/plant/Plant.tscn")
		var fruit = instancedObject.instantiate()
		var x = fruite.position.x + randi_range(60, 360) * arr[randi_range(0, 1)]
		var y = fruite.position.y + randi_range(60, 360) * arr[randi_range(0, 1)]
		fruit.position = Vector2(x,y)
		fruite.get_parent().add_child(fruit)
		fruit.set_entity_name("plant")
		#fruit.number = randi_range(1, 2)
		fruit.velocity.x = 0
		fruit.velocity.y = 0
	if lifetime <= 0:
		queue_free()
		
		
