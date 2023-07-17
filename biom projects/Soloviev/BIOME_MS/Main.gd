extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_speed_up_toggled(button_pressed):
	Global.speed_up = 2.0 if button_pressed else 1.0
	$ButtonSpeedUp.text = "СКОРОСТЬ 2X" if button_pressed else "СКОРОСТЬ 1X"
