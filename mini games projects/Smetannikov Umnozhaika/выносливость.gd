extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".value = 100
func _process(delta):
	if Input.is_action_pressed("r") or Input.is_action_pressed("l") or Input.is_action_pressed("u") or Input.is_action_pressed("d"):
		if Input.is_action_pressed("Shift"):
			$".".value = value - 20*delta
		else:
			$".".value = value - 10*delta
	else:
		$".".value = value + 50.0 * delta
	if $".". value >= 5:
		Global.shiftun = 1
	else:
		Global.shiftun = 0
