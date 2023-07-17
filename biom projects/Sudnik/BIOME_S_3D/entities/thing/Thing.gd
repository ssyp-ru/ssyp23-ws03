extends "res://entities/entity/Entity.gd"
# Не живые предметы

#func move(delta):
#	print(""+ name + " " + _name + " не умеет move")
	
func _process(delta):
	if hp != null:
		$HealthBar.value = hp
		if hp <= 0:
			onDeath($".")
