extends Node
#глобальные переменные, которые видно во всех скриптах проекта 
# пример if Global.speed_up > 0.1:

#ускорены ли процессы (скорость, время)
var speed_up := 1.0
var is_paused = false
@onready var main_scene
var age_of_the_world = 0
