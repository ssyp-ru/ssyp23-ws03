extends "res://entities/animal/Animal.gd"

@export var goat = " "
var known_food = []
var lenths = []
var mini_s = 100000

func init():
	speed = 10
	velocity = Vector2(randf_range(-25, 25), randf_range(-25, 25))
	#set_random_direction_and_speed()
	max_years = randf_range(37, 50)
	max_want_eat = randf_range(25, 30)

#func _on_animal_body_entered(body):
	#if body.name == "Goat":
#		if want_eat > 10:
#			want_eat -= 10.0
#			body.queue_free()
#		else:
#			known_food.append(body)
	#if body.name == "Goat" or body.name == "Food":
		
func update(delta):
	if Global.pause == 0:
		if velocity.x > 0:
			$AnimatedSprite2D.play("Wolf right")
		if velocity.x < 0:
			$AnimatedSprite2D.play("Wolf left")
		if velocity.x == 0:
			$AnimatedSprite2D.stop()
		if years < 2:
			state = "baby"
		if want_eat > 7 and state != "go_to_food":
			state = "find_food"
		if state == "find_food":
			mini_s = 10000
			for i in get_tree().get_nodes_in_group("goats"):
				if (i.position - position).length() < mini_s:
					mini_s = (i.position - position).length()
					goat = i
			if mini_s != 10000:
				velocity = (goat.position - position).normalized() * speed
				state = "go_to_food"
		if state == "go_to_food":
			if not goat in get_tree().get_nodes_in_group("goats"):
				state = "find_food"
				return
			if (goat.position - position).length() < 50:
					want_eat -= 10.0
					goat.queue_free()
				
		if years > randf_range(3, 10) and want_eat < 10 and parent < 1:
			var new_wolf = load("res://entities/wolf/wolf.tscn").instantiate()
			new_wolf.name = "!!!!"
			new_wolf.position.x = 200 + randf_range(-100, 100)
			new_wolf.position.y = 400 + randf_range(-100, 100)
			#new_wolf.position.x = $"../../WolvesDen".position.x + randf_range(-100, 100)
			#new_wolf.position.y = $"../../WolvesDen".position.y + randf_range(-100, 100)
			get_parent().add_child(new_wolf)
			parent += 1
			Global.sleep(randf_range(0.5, 1))
		if randf_range(0, 2) > 1:
			sleep = 1
			Global.sleep(randf_range(1, 7))
			sleep = 0
		ageHungerMovement()
	else:
		$AnimatedSprite2D.stop()
