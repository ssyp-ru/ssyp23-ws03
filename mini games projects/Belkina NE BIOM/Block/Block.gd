extends Node2D

var block: Sprite2D

func _ready():
	
	# Начальные настройки блока
	block = $"CharacterBody2D/Big-crate"
	block.visible = true

	# Вызываем функцию после трёх секунд
	set_timer(3.0)

func set_timer(time: float):
	
	var timer = Timer.new()
	timer.wait_time = time
	timer.one_shot = true
	add_child(timer)
	timer.start()

	# Привязываем функцию-обработчик к таймеру
	timer.connect("timeout", _on_timer_timeout, 1)
	
func _on_timer_timeout():
	block.visible = !block.visible
	$CharacterBody2D/CollisionShape2D.disabled = !$CharacterBody2D/CollisionShape2D.disabled
	# Вызываем функцию снова после одной секунды
	set_timer(1.0)
