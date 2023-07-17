extends "res://entities/animal/Animal.gd"

@export var plant = " "
var mini_s = 10000

func init():
	velocity = Vector2(randf_range(-25, 25), randf_range(-25, 25))
	add_to_group("goats")
	speed = 30
	#set_random_direction_and_speed()
	max_years = randf_range(37, 50)
	max_want_eat = randf_range(10, 25)

func update(delta ):
	if Global.pause == 0:
		if velocity.x > 0:
			$AnimatedSprite2D.play("Goat right")
		if velocity.x < 0:
			$AnimatedSprite2D.play("Goat left")
		if velocity.x == 0:
			$AnimatedSprite2D.stop()
		if years < 2:
			state = "baby"
		if want_eat > 7 and state != "go_to_food":
			state = "find_food"
		if years > randf_range(3, 10) and want_eat < 15 and parent < 1:
			var new_goat = load("res://entities/Goat/goat.tscn").instantiate()
			new_goat.name = "!!!!"
			get_parent().add_child(new_goat)
			new_goat.position.x = $"../../GoatsDen".position.x + randf_range(-100, 100)
			new_goat.position.y = $"../../GoatsDen".position.y + randf_range(-100, 100)
#			new_goat.position.x = 0
#			new_goat.position.y = 0
			parent += 1
			Global.sleep(randf_range(0.5, 1))
		#if years > 3:
		if state == "find_food":
			mini_s = 10000
			for i in get_tree().get_nodes_in_group("grass"):
				if (i.position - position).length() < mini_s:
					mini_s = (i.position - position).length()
					plant = i
			if mini_s != 10000:
				velocity = (plant.position - position).normalized() * speed
				state = "go_to_food"
		if state == "go_to_food":
			if not plant in get_tree().get_nodes_in_group("grass"):
				state = "find_food"
				return
			if (plant.position - position).length() < 50:
					want_eat -= 10.0
					plant.queue_free()
		else:
			move()
		if randf_range(0, 2) > 1:
			sleep = 1
			Global.sleep(randf_range(1, 7))
			sleep = 0
		ageHungerMovement()
	else:
		$AnimatedSprite2D.stop()
