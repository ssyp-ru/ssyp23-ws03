extends CharacterBody2D

var hp = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2(100, 0)
var hold = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	velocity = $"../pl1".global_position - global_position
	move_and_slide()
	if Input.is_action_pressed("ui_accept"):
		if hold:
			queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "pl1":
		body.queue_free()
	if body.is_in_group("bullet"):
		body.queue_free()
		hp -= 1	
		if hp == 0:
			queue_free()


func _on_color_rect_mouse_entered():
	hold = 1


func _on_color_rect_mouse_exited():
	hold = 0
