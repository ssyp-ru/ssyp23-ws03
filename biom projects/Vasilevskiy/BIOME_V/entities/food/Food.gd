extends "res://entities/thing/Thing.gd"
#Еда

#@onready var meat = Image.load_from_file("res://meat.png")
#var meat_texture = ImageTexture.create_from_image(meat)
#var apple = Image.load_from_file("res://apple.png")
#var apple_texture = ImageTexture.create_from_image(apple)
var texture_apple = load("res://apple3.0.svg")
var texture_meat = load("res://meat.svg")


#добавить функции для еды. В entity есть типы еды

func _ready():
	if is_in_group("meat"):
		$Sprite2D.texture = texture_meat
		$Name.text = "Meat"
	elif is_in_group("food"):
		$Sprite2D.texture = texture_apple
		$Name.text = "Fruit"
		
func _process(delta):
	if hp != null:
		$HealthBar.value = hp
	if hp <= 0:
		queue_free()
	if Global.is_paused == false:
		hp -= 0.01
	update_progress_bar()
	if Global.is_hidden == 0:
		$HealthBar.show()
	elif Global.is_hidden == 1:
		$HealthBar.hide()


		
