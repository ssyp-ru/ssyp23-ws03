extends CharacterBody2D


# Declare member variables here. Examples:
# var a = 2
 
var vel = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
#func _ready():
	#vel = get_global_mouse_position() - global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = vel 
	move_and_slide()


func _on_Timer_timeout():
	queue_free()
