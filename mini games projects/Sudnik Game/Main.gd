extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ememy = preload("res://enemy.tscn")
var a = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _on_time_timeout():
	a = randi()
	a = a % 8 + 1
	var b = ememy.instantiate()
	var c = "Position2D" + str(a)
	add_child(b)
	b.position = get_node(c).position
	


func _on_Button_pressed():
	$time.wait_time = 0.2          
	$Button.text = ":)"
	$AudioStreamPlayer2D.play()
	$Label.text = "" 
	
