extends "res://entities/organism/Organism.gd"

@export var state = "baby"
@export var sleep = 0

#func set_random_direction_and_speed():
#	velocity = Vector2(randf_range(-speed, speed), randf_range(-speed, speed))

func init():
	position = get_parent().position
	#set_random_direction_and_speed()
	max_years = randf_range(18, 40)
	max_want_eat = randf_range(7, 20)
	
func move():
	move_and_slide()
	
func death():
	if $"../../Food":
		$"../../Food".add_child(preload("res://entities/food/Food.tscn").instantiate())
		queue_free()
	
func ageHungerMovement():
	if Global.pause == 0:
		#if not in get_tree().get_nodes_in_group("humans"):
		if sleep == 1:
			years += 0.001
			want_eat += 0.005
		#elif state == "baby" and sleep == 0:
		#	years += 0.005
		#	want_eat += 0.005
		else:
			years += 0.01
			want_eat += 0.05
		$Label.value = years
		$Label2.value = want_eat
		#if sleep == 0:
			#if position.x > 1100:
			#	position.x -= 10
			#if position.x < 50:
			#	position.x += 10
			#if position.y > 600:
			#	position.x -= 10
			#if position.x < 50:
			#	position.x += 10
			#if randf() < 0.07:
				#set_random_direction_and_speed()
		if years > max_years or want_eat > max_want_eat:
			death()
		move()
		if years > 3:
			scale.x = int(years / 3)
			scale.y = int(years / 3)
	
func update(delta):
	ageHungerMovement()
