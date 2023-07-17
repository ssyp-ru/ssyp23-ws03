extends Control

var fake1
var fake2

# Called when the node enters the scene tree for the first time.
func _ready():

	Global.ke = Global.prim1*Global.prim2
	var s = randi_range(1, 2)
	if s != 2:
		fake1 = Global.ke + 1
	else:
		fake1 = Global.ke - 1
	var h = randi_range(1, 2)
	if h != 2:
		fake2 = Global.ke + 2
	else:
		fake2 = Global.ke - 2
		
	var boxes = [$box/t1r, $"fake box 1/t2r", $"fake box 2/t3r"]
		
	var n = randi_range(0, 2)
	boxes[n].text = str(Global.ke)
	
	n += 1
	if n > 2:
		n = 0
	boxes[n].text = str(fake1)
	
	n += 1
	if n > 2:
		n = 0
	boxes[n].text = str(fake2)


# Called every frame. 'delta' is the elapsed time since the previous frame.




func _on_button_pressed():
	pass # Replace with function body.
