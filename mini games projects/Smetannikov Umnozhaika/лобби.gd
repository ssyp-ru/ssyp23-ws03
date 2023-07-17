extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.press_start = 2 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://игрок/Plaing.tscn")
	Global.press_start = 0


func _on_label_ready():
	var b = randi_range(1,10)
	$Label.text = str(b)



func _on_label_2_ready():
	var k = randi_range(1,10)
	var n = randi_range(1,10)
	$Label2.text = str(k, 'X', n)


func _on_label_3_ready():
	var c = randi_range(1,10)
	$Label3.text = str(c)


func _on_label_4_ready():
	var l = randi_range(1,10)
	$Label4.text = str(l)
