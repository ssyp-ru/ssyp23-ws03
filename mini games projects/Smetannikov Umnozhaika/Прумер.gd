extends Label
var variation = 0.1
var sub = 0
var ishik = []
var fake_box
var fake_box2
var box = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	Global.prim1 = randi_range(1 , 9)
	Global.prim2 = randi_range(1 , 9)

func _on_ready():
	$".".text = str(Global.prim1, 'X', Global.prim2, '?')
	pass
