extends Node2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _process(delta):
	#n = Vector2()
	$"Пузыри".position.y -= speed * delta
	if $"Пузыри".position.y < -150:
		$"Пузыри".position.y = 600
	
	





func _on_button_pressed():
	get_tree().change_scene_to_file("res://игрок/Plaing.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://лобби.tscn")
